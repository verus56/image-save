import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _saveImage() async {
    if (_image != null) {
      try {
        // Get the app's local directory using path_provider
        final directory = await getApplicationDocumentsDirectory();

        // Copy the image file to the local directory
        final savedImage = await _image!.copy('${directory.path}/saved_image.png');

        print('Image saved at: ${savedImage.path}');
      } catch (e) {
        print('Error saving image: $e');
      }
    } else {
      print('No image to save.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Image Picker Example'),
    ),
    body: Center(        child: _image == null
        ? Text('No image selected.')
        : Image.file(_image!),
    ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _getImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _saveImage,
            tooltip: 'Save Image',
            child: Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}

