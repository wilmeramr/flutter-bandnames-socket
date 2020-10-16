import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketServie with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  SocketServie() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    _socket = IO.io('http://192.168.0.142:3001', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
/* 
    socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje: ');
      print('nombre:' + payload['nombre']);
      print('mensaje:' + payload['mensaje']);
    }); */
  }
}
