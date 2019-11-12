import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tkjidi/Config/viewConfig.dart';
import 'package:tkjidi/Utility/MoreWidgets.dart';
class SearchAppBar extends StatefulWidget implements PreferredSizeWidget{
  final Widget child;
  final double height;
  final double evevation;
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final VoidCallback onEditingComplete;

  const SearchAppBar({Key key, this.height: 46, this.evevation: 0.5, this.hintText: '请输入关键词', this.focusNode, this.controller, this.prefixIcon: Icons.search, this.inputFormatters, this.onEditingComplete, this.child}) : super(key: key);
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize{
    return Size.fromHeight(height);
  }
  
  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool _hasdeleteIcon = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: PreferredSize(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: buildAppBar(context, '',leading: widget.child),
            ),
            Positioned(
              left: 20,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 10,top: 5),
                width: ssSetWidth(550),
                height: ssSetHeigth(70),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.white,
                    child: TextField(
                      focusNode: widget.focusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: widget.controller,
                      maxLines: 1,
                      inputFormatters: widget.inputFormatters,
                      
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsetsDirectional.only(start: 14),
                          child: Icon(
                            widget.prefixIcon,
                            color: Colors.black,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsetsDirectional.only(start: 2.0,end: _hasdeleteIcon? 20:0),
                          child: _hasdeleteIcon? InkWell(
                            onTap: ((){
                              setState(() {
                              widget.controller.text = '';
                              _hasdeleteIcon = false; 
                              });
                            }),
                            child: Icon(
                              Icons.clear,
                              size: 18,
                              color:Colors.black
                            ),
                          ): Text('')
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: InputBorder.none
                      ),
                      onChanged: (str){
                        setState(() {
                        if (str.isEmpty){
                          _hasdeleteIcon = false;
                        } else{
                          _hasdeleteIcon = true;
                        }
                        });
                      },
                      onEditingComplete: widget.onEditingComplete,
                    ),
                  )
                )
              ),
            )
          ],
        ),
        preferredSize: Size.fromHeight(widget.height),
      ),
    );
  }
}