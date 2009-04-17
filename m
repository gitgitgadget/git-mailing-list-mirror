From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: use themed tk widgets
Date: 17 Apr 2009 01:24:35 +0100
Message-ID: <873ac8m8jg.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 02:26:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LubuY-0003HC-OU
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 02:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619AbZDQAYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2009 20:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667AbZDQAYw
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 20:24:52 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:43804 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753073AbZDQAYu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 20:24:50 -0400
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Lubst-00035f-Au; Fri, 17 Apr 2009 01:24:47 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Lubsl-000227-Jp; Fri, 17 Apr 2009 01:24:45 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id CAA0751836; Fri, 17 Apr 2009 01:24:38 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116721>


  With Tk 8.5+ use the themed widgets to improve the appearence
  on Windows and MacOSX. On X11 less difference is apparent but
  users can select alternate themes by setting *TkTheme in the
  resource database (eg: *TkTheme: clam)

  With Tk 8.6 there is a built-in font selection dialog and this
  patch will make use of that when available as on Windows and
  MacOSX it calls the native font selection dialog.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |  590 ++++++++++++++++++++++++++++++++++++++++------------------=
--------
 1 files changed, 356 insertions(+), 234 deletions(-)

diff --git a/gitk b/gitk
index a346bd5..053b1a0 100755
--- a/gitk
+++ b/gitk
@@ -7,6 +7,8 @@ exec wish "$0" -- "$@"
 # and distributed under the terms of the GNU General Public Licence,
 # either version 2, or (at your option) any later version.
=20
+package require Tk
+
 proc gitdir {} {
     global env
     if {[info exists env(GIT_DIR)]} {
@@ -1767,6 +1769,15 @@ proc removehead {id name} {
     unset headids($name)
 }
=20
+proc ttk_toplevel {w args} {
+    global use_ttk
+    eval [linsert $args 0 ::toplevel $w]
+    if {$use_ttk} {
+        place [ttk::frame $w._toplevel_background] -x 0 -y 0 -relwidth=
 1 -relheight 1
+    }
+    return $w
+}
+
 proc make_transient {window origin} {
     global have_tk85
=20
@@ -1786,9 +1797,11 @@ proc make_transient {window origin} {
 }
=20
 proc show_error {w top msg} {
+    global NS
+    if {[wm state $top] eq "withdrawn"} { wm deiconify $top }
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
-    button $w.ok -text [mc OK] -command "destroy $top"
+    ${NS}::button $w.ok -default active -text [mc OK] -command "destro=
y $top"
     pack $w.ok -side bottom -fill x
     bind $top <Visibility> "grab $top; focus $top"
     bind $top <Key-Return> "destroy $top"
@@ -1798,45 +1811,56 @@ proc show_error {w top msg} {
 }
=20
 proc error_popup {msg {owner .}} {
-    set w .error
-    toplevel $w
-    make_transient $w $owner
-    show_error $w $w $msg
+    if {[tk windowingsystem] eq "win32"} {
+        tk_messageBox -icon error -type ok -title [wm title .] \
+            -parent $owner -message $msg
+    } else {
+        set w .error
+        ttk_toplevel $w
+        make_transient $w $owner
+        show_error $w $w $msg
+    }
 }
=20
 proc confirm_popup {msg {owner .}} {
-    global confirm_ok
+    global confirm_ok NS
     set confirm_ok 0
     set w .confirm
-    toplevel $w
+    ttk_toplevel $w
     make_transient $w $owner
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
-    button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
+    ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; dest=
roy $w"
     pack $w.ok -side left -fill x
-    button $w.cancel -text [mc Cancel] -command "destroy $w"
+    ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
     pack $w.cancel -side right -fill x
     bind $w <Visibility> "grab $w; focus $w"
     bind $w <Key-Return> "set confirm_ok 1; destroy $w"
     bind $w <Key-space>  "set confirm_ok 1; destroy $w"
     bind $w <Key-Escape> "destroy $w"
+    tk::PlaceWindow $w widget $owner
     tkwait window $w
     return $confirm_ok
 }
=20
 proc setoptions {} {
-    option add *Panedwindow.showHandle 1 startupFile
-    option add *Panedwindow.sashRelief raised startupFile
+    if {[tk windowingsystem] ne "win32"} {
+        option add *Panedwindow.showHandle 1 startupFile
+        option add *Panedwindow.sashRelief raised startupFile
+        if {[tk windowingsystem] ne "aqua"} {
+            option add *Menu.font uifont startupFile
+        }
+    } else {
+        option add *Menu.TearOff 0 startupFile
+    }
     option add *Button.font uifont startupFile
     option add *Checkbutton.font uifont startupFile
     option add *Radiobutton.font uifont startupFile
-    if {[tk windowingsystem] ne "aqua"} {
-	option add *Menu.font uifont startupFile
-    }
     option add *Menubutton.font uifont startupFile
     option add *Label.font uifont startupFile
     option add *Message.font uifont startupFile
     option add *Entry.font uifont startupFile
+    option add *Labelframe.font uifont startupFile
 }
=20
 # Make a menu and submenus.
@@ -1893,6 +1917,17 @@ proc mca {str} {
     return [string map {&& & & {}} [mc $str]]
 }
=20
+proc makedroplist {w varname args} {
+    global use_ttk
+    if {$use_ttk} {
+	set gm [ttk::combobox $w -width 10 -state readonly\
+		    -textvariable $varname -values $args]
+    } else {
+	set gm [eval [linsert $args 0 tk_optionMenu $w $varname]]
+    }
+    return $gm
+}
+
 proc makewindow {} {
     global canv canv2 canv3 linespc charspc ctext cflist cscroll
     global tabstop
@@ -1908,7 +1943,7 @@ proc makewindow {} {
     global headctxmenu progresscanv progressitem progresscoords status=
w
     global fprogitem fprogcoord lastprogupdate progupdatepending
     global rprogitem rprogcoord rownumsel numcommits
-    global have_tk85
+    global have_tk85 use_ttk NS
=20
     # The "mc" arguments here are purely so that xgettext
     # sees the following string as needing to be translated
@@ -1960,8 +1995,13 @@ proc makewindow {} {
     makemenu .bar $bar
     . configure -menu .bar
=20
+    if {$use_ttk} {
+        # cover the non-themed toplevel with a themed frame.
+        place [ttk::frame ._main_background] -x 0 -y 0 -relwidth 1 -re=
lheight 1
+    }
+
     # the gui has upper and lower half, parts of a paned window.
-    panedwindow .ctop -orient vertical
+    ${NS}::panedwindow .ctop -orient vertical
=20
     # possibly use assumed geometry
     if {![info exists geometry(pwsash0)]} {
@@ -1969,14 +2009,17 @@ proc makewindow {} {
         set geometry(topwidth) [expr {80 * $charspc}]
         set geometry(botheight) [expr {15 * $linespc}]
         set geometry(botwidth) [expr {50 * $charspc}]
-        set geometry(pwsash0) "[expr {40 * $charspc}] 2"
-        set geometry(pwsash1) "[expr {60 * $charspc}] 2"
+        set geometry(pwsash0) [list [expr {40 * $charspc}] 2]
+        set geometry(pwsash1) [list [expr {60 * $charspc}] 2]
     }
=20
     # the upper half will have a paned window, a scroll bar to the rig=
ht, and some stuff below
-    frame .tf -height $geometry(topheight) -width $geometry(topwidth)
-    frame .tf.histframe
-    panedwindow .tf.histframe.pwclist -orient horizontal -sashpad 0 -h=
andlesize 4
+    ${NS}::frame .tf -height $geometry(topheight) -width $geometry(top=
width)
+    ${NS}::frame .tf.histframe
+    ${NS}::panedwindow .tf.histframe.pwclist -orient horizontal
+    if {!$use_ttk} {
+	.tf.histframe.pwclist configure -sashpad 0 -handlesize 4
+    }
=20
     # create three canvases
     set cscroll .tf.histframe.csb
@@ -1996,19 +2039,28 @@ proc makewindow {} {
 	-selectbackground $selectbgcolor \
 	-background $bgcolor -bd 0 -yscrollincr $linespc
     .tf.histframe.pwclist add $canv3
-    eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
-    eval .tf.histframe.pwclist sash place 1 $geometry(pwsash1)
+    if {$use_ttk} {
+	bind .tf.histframe.pwclist <Map> {
+	    bind %W <Map> {}
+	    .tf.histframe.pwclist sashpos 1 [lindex $::geometry(pwsash1) 0]
+	    .tf.histframe.pwclist sashpos 0 [lindex $::geometry(pwsash0) 0]
+	}
+    } else {
+	eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
+	eval .tf.histframe.pwclist sash place 1 $geometry(pwsash1)
+    }
=20
     # a scroll bar to rule them
-    scrollbar $cscroll -command {allcanvs yview} -highlightthickness 0
+    ${NS}::scrollbar $cscroll -command {allcanvs yview}
+    if {!$use_ttk} {$cscroll configure -highlightthickness 0}
     pack $cscroll -side right -fill y
     bind .tf.histframe.pwclist <Configure> {resizeclistpanes %W %w}
     lappend bglist $canv $canv2 $canv3
     pack .tf.histframe.pwclist -fill both -expand 1 -side left
=20
     # we have two button bars at bottom of top frame. Bar 1
-    frame .tf.bar
-    frame .tf.lbar -height 15
+    ${NS}::frame .tf.bar
+    ${NS}::frame .tf.lbar -height 15
=20
     set sha1entry .tf.bar.sha1
     set entries $sha1entry
@@ -2017,7 +2069,7 @@ proc makewindow {} {
 	-command gotocommit -width 8
     $sha1but conf -disabledforeground [$sha1but cget -foreground]
     pack .tf.bar.sha1label -side left
-    entry $sha1entry -width 40 -font textfont -textvariable sha1string
+    ${NS}::entry $sha1entry -width 40 -font textfont -textvariable sha=
1string
     trace add variable sha1string write sha1change
     pack $sha1entry -side left -pady 2
=20
@@ -2037,36 +2089,43 @@ proc makewindow {} {
 	0x00, 0x38, 0xff, 0x7f, 0xff, 0x7f, 0xff, 0x7f, 0x00, 0x38, 0x00, 0x1=
c,
 	0x00, 0x0e, 0x00, 0x07, 0x80, 0x03, 0xc0, 0x01};
     }
-    button .tf.bar.leftbut -image bm-left -command goback \
+    ${NS}::button .tf.bar.leftbut -image bm-left -command goback \
 	-state disabled -width 26
     pack .tf.bar.leftbut -side left -fill y
-    button .tf.bar.rightbut -image bm-right -command goforw \
+    ${NS}::button .tf.bar.rightbut -image bm-right -command goforw \
 	-state disabled -width 26
     pack .tf.bar.rightbut -side left -fill y
=20
-    label .tf.bar.rowlabel -text [mc "Row"]
+    ${NS}::label .tf.bar.rowlabel -text [mc "Row"]
     set rownumsel {}
-    label .tf.bar.rownum -width 7 -font textfont -textvariable rownums=
el \
+    ${NS}::label .tf.bar.rownum -width 7 -textvariable rownumsel \
 	-relief sunken -anchor e
-    label .tf.bar.rowlabel2 -text "/"
-    label .tf.bar.numcommits -width 7 -font textfont -textvariable num=
commits \
+    ${NS}::label .tf.bar.rowlabel2 -text "/"
+    ${NS}::label .tf.bar.numcommits -width 7 -textvariable numcommits =
\
 	-relief sunken -anchor e
     pack .tf.bar.rowlabel .tf.bar.rownum .tf.bar.rowlabel2 .tf.bar.num=
commits \
 	-side left
+    if {!$use_ttk} {
+        foreach w {rownum numcommits} {.tf.bar.$w configure -font text=
font}
+    }
     global selectedline
     trace add variable selectedline write selectedline_change
=20
     # Status label and progress bar
     set statusw .tf.bar.status
-    label $statusw -width 15 -relief sunken
+    ${NS}::label $statusw -width 15 -relief sunken
     pack $statusw -side left -padx 5
-    set h [expr {[font metrics uifont -linespace] + 2}]
-    set progresscanv .tf.bar.progress
-    canvas $progresscanv -relief sunken -height $h -borderwidth 2
-    set progressitem [$progresscanv create rect -1 0 0 $h -fill green]
-    set fprogitem [$progresscanv create rect -1 0 0 $h -fill yellow]
-    set rprogitem [$progresscanv create rect -1 0 0 $h -fill red]
-    pack $progresscanv -side right -expand 1 -fill x
+    if {$use_ttk} {
+	set progresscanv [ttk::progressbar .tf.bar.progress]
+    } else {
+	set h [expr {[font metrics uifont -linespace] + 2}]
+	set progresscanv .tf.bar.progress
+	canvas $progresscanv -relief sunken -height $h -borderwidth 2
+	set progressitem [$progresscanv create rect -1 0 0 $h -fill green]
+	set fprogitem [$progresscanv create rect -1 0 0 $h -fill yellow]
+	set rprogitem [$progresscanv create rect -1 0 0 $h -fill red]
+    }
+    pack $progresscanv -side right -expand 1 -fill x -padx {0 2}
     set progresscoords {0 0}
     set fprogcoord 0
     set rprogcoord 0
@@ -2075,14 +2134,14 @@ proc makewindow {} {
     set progupdatepending 0
=20
     # build up the bottom bar of upper window
-    label .tf.lbar.flabel -text "[mc "Find"] "
-    button .tf.lbar.fnext -text [mc "next"] -command {dofind 1 1}
-    button .tf.lbar.fprev -text [mc "prev"] -command {dofind -1 1}
-    label .tf.lbar.flab2 -text " [mc "commit"] "
+    ${NS}::label .tf.lbar.flabel -text "[mc "Find"] "
+    ${NS}::button .tf.lbar.fnext -text [mc "next"] -command {dofind 1 =
1}
+    ${NS}::button .tf.lbar.fprev -text [mc "prev"] -command {dofind -1=
 1}
+    ${NS}::label .tf.lbar.flab2 -text " [mc "commit"] "
     pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 =
\
 	-side left -fill y
     set gdttype [mc "containing:"]
-    set gm [tk_optionMenu .tf.lbar.gdttype gdttype \
+    set gm [makedroplist .tf.lbar.gdttype gdtype \
 		[mc "containing:"] \
 		[mc "touching paths:"] \
 		[mc "adding/removing string:"]]
@@ -2092,14 +2151,14 @@ proc makewindow {} {
     set findstring {}
     set fstring .tf.lbar.findstring
     lappend entries $fstring
-    entry $fstring -width 30 -font textfont -textvariable findstring
+    ${NS}::entry $fstring -width 30 -font textfont -textvariable finds=
tring
     trace add variable findstring write find_change
     set findtype [mc "Exact"]
-    set findtypemenu [tk_optionMenu .tf.lbar.findtype \
-		      findtype [mc "Exact"] [mc "IgnCase"] [mc "Regexp"]]
+    set findtypemenu [makedroplist .tf.lbar.findtype \
+			  findtype [mc "Exact"] [mc "IgnCase"] [mc "Regexp"]]
     trace add variable findtype write findcom_change
     set findloc [mc "All fields"]
-    tk_optionMenu .tf.lbar.findloc findloc [mc "All fields"] [mc "Head=
line"] \
+    makedroplist .tf.lbar.findloc findloc [mc "All fields"] [mc "Headl=
ine"] \
 	[mc "Comments"] [mc "Author"] [mc "Committer"]
     trace add variable findloc write find_change
     pack .tf.lbar.findloc -side right
@@ -2111,38 +2170,41 @@ proc makewindow {} {
     pack .tf.bar -in .tf -side bottom -fill x
     pack .tf.histframe -fill both -side top -expand 1
     .ctop add .tf
-    .ctop paneconfigure .tf -height $geometry(topheight)
-    .ctop paneconfigure .tf -width $geometry(topwidth)
+    if {!$use_ttk} {
+	.ctop paneconfigure .tf -height $geometry(topheight)
+	.ctop paneconfigure .tf -width $geometry(topwidth)
+    }
=20
     # now build up the bottom
-    panedwindow .pwbottom -orient horizontal
+    ${NS}::panedwindow .pwbottom -orient horizontal
=20
     # lower left, a text box over search bar, scroll bar to the right
     # if we know window height, then that will set the lower text heig=
ht, otherwise
     # we set lower text height which will drive window height
     if {[info exists geometry(main)]} {
-        frame .bleft -width $geometry(botwidth)
+	${NS}::frame .bleft -width $geometry(botwidth)
     } else {
-        frame .bleft -width $geometry(botwidth) -height $geometry(both=
eight)
+	${NS}::frame .bleft -width $geometry(botwidth) -height $geometry(both=
eight)
     }
-    frame .bleft.top
-    frame .bleft.mid
-    frame .bleft.bottom
+    ${NS}::frame .bleft.top
+    ${NS}::frame .bleft.mid
+    ${NS}::frame .bleft.bottom
=20
-    button .bleft.top.search -text [mc "Search"] -command dosearch
+    ${NS}::button .bleft.top.search -text [mc "Search"] -command dosea=
rch
     pack .bleft.top.search -side left -padx 5
     set sstring .bleft.top.sstring
-    entry $sstring -width 20 -font textfont -textvariable searchstring
+    set searchstring ""
+    ${NS}::entry $sstring -width 20 -font textfont -textvariable searc=
hstring
     lappend entries $sstring
     trace add variable searchstring write incrsearch
     pack $sstring -side left -expand 1 -fill x
-    radiobutton .bleft.mid.diff -text [mc "Diff"] \
+    ${NS}::radiobutton .bleft.mid.diff -text [mc "Diff"] \
 	-command changediffdisp -variable diffelide -value {0 0}
-    radiobutton .bleft.mid.old -text [mc "Old version"] \
+    ${NS}::radiobutton .bleft.mid.old -text [mc "Old version"] \
 	-command changediffdisp -variable diffelide -value {0 1}
-    radiobutton .bleft.mid.new -text [mc "New version"] \
+    ${NS}::radiobutton .bleft.mid.new -text [mc "New version"] \
 	-command changediffdisp -variable diffelide -value {1 0}
-    label .bleft.mid.labeldiffcontext -text "      [mc "Lines of conte=
xt"]: "
+    ${NS}::label .bleft.mid.labeldiffcontext -text "      [mc "Lines o=
f context"]: "
     pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
     spinbox .bleft.mid.diffcontext -width 5 -font textfont \
 	-from 1 -increment 1 -to 10000000 \
@@ -2152,7 +2214,7 @@ proc makewindow {} {
     trace add variable diffcontextstring write diffcontextchange
     lappend entries .bleft.mid.diffcontext
     pack .bleft.mid.labeldiffcontext .bleft.mid.diffcontext -side left
-    checkbutton .bleft.mid.ignspace -text [mc "Ignore space change"] \
+    ${NS}::checkbutton .bleft.mid.ignspace -text [mc "Ignore space cha=
nge"] \
 	-command changeignorespace -variable ignorespace
     pack .bleft.mid.ignspace -side left -padx 5
     set ctext .bleft.bottom.ctext
@@ -2163,9 +2225,8 @@ proc makewindow {} {
     if {$have_tk85} {
 	$ctext conf -tabstyle wordprocessor
     }
-    scrollbar .bleft.bottom.sb -command "$ctext yview"
-    scrollbar .bleft.bottom.sbhorizontal -command "$ctext xview" -orie=
nt h \
-	-width 10
+    ${NS}::scrollbar .bleft.bottom.sb -command "$ctext yview"
+    ${NS}::scrollbar .bleft.bottom.sbhorizontal -command "$ctext xview=
" -orient h
     pack .bleft.top -side top -fill x
     pack .bleft.mid -side top -fill x
     grid $ctext .bleft.bottom.sb -sticky nsew
@@ -2205,14 +2266,16 @@ proc makewindow {} {
     $ctext tag conf found -back yellow
=20
     .pwbottom add .bleft
-    .pwbottom paneconfigure .bleft -width $geometry(botwidth)
+    if {!$use_ttk} {
+	.pwbottom paneconfigure .bleft -width $geometry(botwidth)
+    }
=20
     # lower right
-    frame .bright
-    frame .bright.mode
-    radiobutton .bright.mode.patch -text [mc "Patch"] \
+    ${NS}::frame .bright
+    ${NS}::frame .bright.mode
+    ${NS}::radiobutton .bright.mode.patch -text [mc "Patch"] \
 	-command reselectline -variable cmitmode -value "patch"
-    radiobutton .bright.mode.tree -text [mc "Tree"] \
+    ${NS}::radiobutton .bright.mode.tree -text [mc "Tree"] \
 	-command reselectline -variable cmitmode -value "tree"
     grid .bright.mode.patch .bright.mode.tree -sticky ew
     pack .bright.mode -side top -fill x
@@ -2228,7 +2291,7 @@ proc makewindow {} {
 	-spacing1 1 -spacing3 1
     lappend bglist $cflist
     lappend fglist $cflist
-    scrollbar .bright.sb -command "$cflist yview"
+    ${NS}::scrollbar .bright.sb -command "$cflist yview"
     pack .bright.sb -side right -fill y
     pack $cflist -side left -fill both -expand 1
     $cflist tag configure highlight \
@@ -2477,7 +2540,12 @@ proc click {w} {
 proc adjustprogress {} {
     global progresscanv progressitem progresscoords
     global fprogitem fprogcoord lastprogupdate progupdatepending
-    global rprogitem rprogcoord
+    global rprogitem rprogcoord use_ttk
+   =20
+    if {$use_ttk} {
+	$progresscanv configure -value [expr {int($fprogcoord * 100)}]
+	return
+    }
=20
     set w [expr {[winfo width $progresscanv] - 4}]
     set x0 [expr {$w * [lindex $progresscoords 0]}]
@@ -2513,7 +2581,7 @@ proc savestuff {w} {
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnu=
m
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
-    global autoselect extdifftool perfile_attrs markbgcolor
+    global autoselect extdifftool perfile_attrs markbgcolor use_ttk
=20
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -2547,8 +2615,13 @@ proc savestuff {w} {
 	puts $f "set geometry(state) [wm state .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
-        puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sash c=
oord 0]\""
-        puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sash c=
oord 1]\""
+	if {$use_ttk} {
+	    puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sashpos 0=
] 1\""
+	    puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1=
] 1\""
+	} else {
+	    puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sash coor=
d 0]\""
+	    puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sash coor=
d 1]\""
+	}
 	puts $f "set geometry(botwidth) [winfo width .bleft]"
 	puts $f "set geometry(botheight) [winfo height .bleft]"
=20
@@ -2566,10 +2639,15 @@ proc savestuff {w} {
 }
=20
 proc resizeclistpanes {win w} {
-    global oldwidth
+    global oldwidth use_ttk
     if {[info exists oldwidth($win)]} {
-	set s0 [$win sash coord 0]
-	set s1 [$win sash coord 1]
+	if {$use_ttk} {
+	    set s0 [$win sashpos 0]
+	    set s1 [$win sashpos 1]
+	} else {
+	    set s0 [$win sash coord 0]
+	    set s1 [$win sash coord 1]
+	}
 	if {$w < 60} {
 	    set sash0 [expr {int($w/2 - 2)}]
 	    set sash1 [expr {int($w*5/6 - 2)}]
@@ -2590,16 +2668,25 @@ proc resizeclistpanes {win w} {
 		}
 	    }
 	}
-	$win sash place 0 $sash0 [lindex $s0 1]
-	$win sash place 1 $sash1 [lindex $s1 1]
+	if {$use_ttk} {
+	    $win sashpos 0 $sash0
+	    $win sashpos 1 $sash1
+	} else {
+	    $win sash place 0 $sash0 [lindex $s0 1]
+	    $win sash place 1 $sash1 [lindex $s1 1]
+	}
     }
     set oldwidth($win) $w
 }
=20
 proc resizecdetpanes {win w} {
-    global oldwidth
+    global oldwidth use_ttk
     if {[info exists oldwidth($win)]} {
-	set s0 [$win sash coord 0]
+	if {$use_ttk} {
+	    set s0 [$win sashpos 0]
+	} else {
+	    set s0 [$win sash coord 0]
+	}
 	if {$w < 60} {
 	    set sash0 [expr {int($w*3/4 - 2)}]
 	} else {
@@ -2612,7 +2699,11 @@ proc resizecdetpanes {win w} {
 		set sash0 [expr {$w - 15}]
 	    }
 	}
-	$win sash place 0 $sash0 [lindex $s0 1]
+	if {$use_ttk} {
+	    $win sashpos 0 $sash0
+	} else {
+	    $win sash place 0 $sash0 [lindex $s0 1]
+	}
     }
     set oldwidth($win) $w
 }
@@ -2632,31 +2723,33 @@ proc bindall {event action} {
 }
=20
 proc about {} {
-    global uifont
+    global uifont NS
     set w .about
     if {[winfo exists $w]} {
 	raise $w
 	return
     }
-    toplevel $w
+    ttk_toplevel $w
     wm title $w [mc "About gitk"]
     make_transient $w .
     message $w.m -text [mc "
 Gitk - a commit viewer for git
=20
-Copyright =C2=A9 2005-2008 Paul Mackerras
+Copyright \u00a9 2005-2009 Paul Mackerras
=20
 Use and redistribute under the terms of the GNU General Public License=
"] \
 	    -justify center -aspect 400 -border 2 -bg white -relief groove
     pack $w.m -side top -fill x -padx 2 -pady 2
-    button $w.ok -text [mc "Close"] -command "destroy $w" -default act=
ive
+    ${NS}::button $w.ok -text [mc "Close"] -command "destroy $w" -defa=
ult active
     pack $w.ok -side bottom
     bind $w <Visibility> "focus $w.ok"
     bind $w <Key-Escape> "destroy $w"
     bind $w <Key-Return> "destroy $w"
+    tk::PlaceWindow $w widget .
 }
=20
 proc keys {} {
+    global NS
     set w .keys
     if {[winfo exists $w]} {
 	raise $w
@@ -2667,7 +2760,7 @@ proc keys {} {
     } else {
 	set M1T Ctrl
     }
-    toplevel $w
+    ttk_toplevel $w
     wm title $w [mc "Gitk key bindings"]
     make_transient $w .
     message $w.m -text "
@@ -2711,7 +2804,7 @@ proc keys {} {
 " \
 	    -justify left -bg white -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
-    button $w.ok -text [mc "Close"] -command "destroy $w" -default act=
ive
+    ${NS}::button $w.ok -text [mc "Close"] -command "destroy $w" -defa=
ult active
     bind $w <Key-Escape> [list destroy $w]
     pack $w.ok -side bottom
     bind $w <Visibility> "focus $w.ok"
@@ -3774,16 +3867,16 @@ proc editview {} {
=20
 proc vieweditor {top n title} {
     global newviewname newviewopts viewfiles bgcolor
-    global known_view_options
+    global known_view_options NS
=20
-    toplevel $top
+    ttk_toplevel $top
     wm title $top $title
     make_transient $top .
=20
     # View name
-    frame $top.nfr
-    label $top.nl -text [mc "Name"]
-    entry $top.name -width 20 -textvariable newviewname($n)
+    ${NS}::frame $top.nfr
+    ${NS}::label $top.nl -text [mc "Name"]
+    ${NS}::entry $top.name -width 20 -textvariable newviewname($n)
     pack $top.nfr -in $top -fill x -pady 5 -padx 3
     pack $top.nl -in $top.nfr -side left -padx {0 30}
     pack $top.name -in $top.nfr -side left
@@ -3802,7 +3895,7 @@ proc vieweditor {top n title} {
 	if {$flags eq "+" || $flags eq "*"} {
 	    set cframe $top.fr$cnt
 	    incr cnt
-	    frame $cframe
+	    ${NS}::frame $cframe
 	    pack $cframe -in $top -fill x -pady 3 -padx 3
 	    set cexpand [expr {$flags eq "*"}]
 	} else {
@@ -3810,18 +3903,18 @@ proc vieweditor {top n title} {
 	}
=20
 	if {$type eq "b"} {
-	    checkbutton $cframe.c_$id -text $title -variable newviewopts($n,$=
id)
+	    ${NS}::checkbutton $cframe.c_$id -text $title -variable newviewop=
ts($n,$id)
 	    pack $cframe.c_$id -in $cframe -side left \
 		-padx [list $lxpad 0] -expand $cexpand -anchor w
 	} elseif {[regexp {^t(\d+)$} $type type sz]} {
-	    message $cframe.l_$id -aspect 1500 -text $title
-	    entry $cframe.e_$id -width $sz -background $bgcolor \
+	    ${NS}::label $cframe.l_$id -text $title
+	    ${NS}::entry $cframe.e_$id -width $sz -background $bgcolor \
 		-textvariable newviewopts($n,$id)
 	    pack $cframe.l_$id -in $cframe -side left -padx [list $lxpad 0]
 	    pack $cframe.e_$id -in $cframe -side left -expand 1 -fill x
 	} elseif {[regexp {^t(\d+)=3D$} $type type sz]} {
-	    message $cframe.l_$id -aspect 1500 -text $title
-	    entry $cframe.e_$id -width $sz -background $bgcolor \
+	    ${NS}::label $cframe.l_$id -text $title
+	    ${NS}::entry $cframe.e_$id -width $sz -background $bgcolor \
 		-textvariable newviewopts($n,$id)
 	    pack $cframe.l_$id -in $cframe -side top -pady [list 3 0] -anchor=
 w
 	    pack $cframe.e_$id -in $cframe -side top -fill x
@@ -3829,7 +3922,7 @@ proc vieweditor {top n title} {
     }
=20
     # Path list
-    message $top.l -aspect 1500 \
+    ${NS}::label $top.l \
 	-text [mc "Enter files and directories to include, one per line:"]
     pack $top.l -in $top -side top -pady [list 7 0] -anchor w -padx 3
     text $top.t -width 40 -height 5 -background $bgcolor -font uifont
@@ -3842,10 +3935,10 @@ proc vieweditor {top n title} {
 	$top.t mark set insert 0.0
     }
     pack $top.t -in $top -side top -pady [list 0 5] -fill both -expand=
 1 -padx 3
-    frame $top.buts
-    button $top.buts.ok -text [mc "OK"] -command [list newviewok $top =
$n]
-    button $top.buts.apply -text [mc "Apply (F5)"] -command [list newv=
iewok $top $n 1]
-    button $top.buts.can -text [mc "Cancel"] -command [list destroy $t=
op]
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.ok -text [mc "OK"] -command [list newviewo=
k $top $n]
+    ${NS}::button $top.buts.apply -text [mc "Apply (F5)"] -command [li=
st newviewok $top $n 1]
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command [list des=
troy $top]
     bind $top <Control-Return> [list newviewok $top $n]
     bind $top <F5> [list newviewok $top $n 1]
     bind $top <Escape> [list destroy $top]
@@ -6688,8 +6781,7 @@ proc selectline {l isnew {desired_loc {}}} {
     $sha1entry delete 0 end
     $sha1entry insert 0 $id
     if {$autoselect} {
-	$sha1entry selection from 0
-	$sha1entry selection to end
+	$sha1entry selection range 0 end
     }
     rhighlight_sel $id
=20
@@ -8067,7 +8159,7 @@ proc doseldiff {oldid newid} {
 }
=20
 proc mkpatch {} {
-    global rowmenuid currentid commitinfo patchtop patchnum
+    global rowmenuid currentid commitinfo patchtop patchnum NS
=20
     if {![info exists currentid]} return
     set oldid $currentid
@@ -8077,38 +8169,38 @@ proc mkpatch {} {
     set top .patch
     set patchtop $top
     catch {destroy $top}
-    toplevel $top
+    ttk_toplevel $top
     make_transient $top .
-    label $top.title -text [mc "Generate patch"]
+    ${NS}::label $top.title -text [mc "Generate patch"]
     grid $top.title - -pady 10
-    label $top.from -text [mc "From:"]
-    entry $top.fromsha1 -width 40 -relief flat
+    ${NS}::label $top.from -text [mc "From:"]
+    ${NS}::entry $top.fromsha1 -width 40
     $top.fromsha1 insert 0 $oldid
     $top.fromsha1 conf -state readonly
     grid $top.from $top.fromsha1 -sticky w
-    entry $top.fromhead -width 60 -relief flat
+    ${NS}::entry $top.fromhead -width 60
     $top.fromhead insert 0 $oldhead
     $top.fromhead conf -state readonly
     grid x $top.fromhead -sticky w
-    label $top.to -text [mc "To:"]
-    entry $top.tosha1 -width 40 -relief flat
+    ${NS}::label $top.to -text [mc "To:"]
+    ${NS}::entry $top.tosha1 -width 40
     $top.tosha1 insert 0 $newid
     $top.tosha1 conf -state readonly
     grid $top.to $top.tosha1 -sticky w
-    entry $top.tohead -width 60 -relief flat
+    ${NS}::entry $top.tohead -width 60
     $top.tohead insert 0 $newhead
     $top.tohead conf -state readonly
     grid x $top.tohead -sticky w
-    button $top.rev -text [mc "Reverse"] -command mkpatchrev -padx 5
-    grid $top.rev x -pady 10
-    label $top.flab -text [mc "Output file:"]
-    entry $top.fname -width 60
+    ${NS}::button $top.rev -text [mc "Reverse"] -command mkpatchrev
+    grid $top.rev x -pady 10 -padx 5
+    ${NS}::label $top.flab -text [mc "Output file:"]
+    ${NS}::entry $top.fname -width 60
     $top.fname insert 0 [file normalize "patch$patchnum.patch"]
     incr patchnum
     grid $top.flab $top.fname -sticky w
-    frame $top.buts
-    button $top.buts.gen -text [mc "Generate"] -command mkpatchgo
-    button $top.buts.can -text [mc "Cancel"] -command mkpatchcan
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.gen -text [mc "Generate"] -command mkpatch=
go
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command mkpatchca=
n
     bind $top <Key-Return> mkpatchgo
     bind $top <Key-Escape> mkpatchcan
     grid $top.buts.gen $top.buts.can
@@ -8159,30 +8251,30 @@ proc mkpatchcan {} {
 }
=20
 proc mktag {} {
-    global rowmenuid mktagtop commitinfo
+    global rowmenuid mktagtop commitinfo NS
=20
     set top .maketag
     set mktagtop $top
     catch {destroy $top}
-    toplevel $top
+    ttk_toplevel $top
     make_transient $top .
-    label $top.title -text [mc "Create tag"]
+    ${NS}::label $top.title -text [mc "Create tag"]
     grid $top.title - -pady 10
-    label $top.id -text [mc "ID:"]
-    entry $top.sha1 -width 40 -relief flat
+    ${NS}::label $top.id -text [mc "ID:"]
+    ${NS}::entry $top.sha1 -width 40
     $top.sha1 insert 0 $rowmenuid
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
-    entry $top.head -width 60 -relief flat
+    ${NS}::entry $top.head -width 60
     $top.head insert 0 [lindex $commitinfo($rowmenuid) 0]
     $top.head conf -state readonly
     grid x $top.head -sticky w
-    label $top.tlab -text [mc "Tag name:"]
-    entry $top.tag -width 60
+    ${NS}::label $top.tlab -text [mc "Tag name:"]
+    ${NS}::entry $top.tag -width 60
     grid $top.tlab $top.tag -sticky w
-    frame $top.buts
-    button $top.buts.gen -text [mc "Create"] -command mktaggo
-    button $top.buts.can -text [mc "Cancel"] -command mktagcan
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.gen -text [mc "Create"] -command mktaggo
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command mktagcan
     bind $top <Key-Return> mktaggo
     bind $top <Key-Escape> mktagcan
     grid $top.buts.gen $top.buts.can
@@ -8262,34 +8354,34 @@ proc mktaggo {} {
 }
=20
 proc writecommit {} {
-    global rowmenuid wrcomtop commitinfo wrcomcmd
+    global rowmenuid wrcomtop commitinfo wrcomcmd NS
=20
     set top .writecommit
     set wrcomtop $top
     catch {destroy $top}
-    toplevel $top
+    ttk_toplevel $top
     make_transient $top .
-    label $top.title -text [mc "Write commit to file"]
+    ${NS}::label $top.title -text [mc "Write commit to file"]
     grid $top.title - -pady 10
-    label $top.id -text [mc "ID:"]
-    entry $top.sha1 -width 40 -relief flat
+    ${NS}::label $top.id -text [mc "ID:"]
+    ${NS}::entry $top.sha1 -width 40
     $top.sha1 insert 0 $rowmenuid
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
-    entry $top.head -width 60 -relief flat
+    ${NS}::entry $top.head -width 60
     $top.head insert 0 [lindex $commitinfo($rowmenuid) 0]
     $top.head conf -state readonly
     grid x $top.head -sticky w
-    label $top.clab -text [mc "Command:"]
-    entry $top.cmd -width 60 -textvariable wrcomcmd
+    ${NS}::label $top.clab -text [mc "Command:"]
+    ${NS}::entry $top.cmd -width 60 -textvariable wrcomcmd
     grid $top.clab $top.cmd -sticky w -pady 10
-    label $top.flab -text [mc "Output file:"]
-    entry $top.fname -width 60
+    ${NS}::label $top.flab -text [mc "Output file:"]
+    ${NS}::entry $top.fname -width 60
     $top.fname insert 0 [file normalize "commit-[string range $rowmenu=
id 0 6]"]
     grid $top.flab $top.fname -sticky w
-    frame $top.buts
-    button $top.buts.gen -text [mc "Write"] -command wrcomgo
-    button $top.buts.can -text [mc "Cancel"] -command wrcomcan
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.gen -text [mc "Write"] -command wrcomgo
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command wrcomcan
     bind $top <Key-Return> wrcomgo
     bind $top <Key-Escape> wrcomcan
     grid $top.buts.gen $top.buts.can
@@ -8320,25 +8412,25 @@ proc wrcomcan {} {
 }
=20
 proc mkbranch {} {
-    global rowmenuid mkbrtop
+    global rowmenuid mkbrtop NS
=20
     set top .makebranch
     catch {destroy $top}
-    toplevel $top
+    ttk_toplevel $top
     make_transient $top .
-    label $top.title -text [mc "Create new branch"]
+    ${NS}::label $top.title -text [mc "Create new branch"]
     grid $top.title - -pady 10
-    label $top.id -text [mc "ID:"]
-    entry $top.sha1 -width 40 -relief flat
+    ${NS}::label $top.id -text [mc "ID:"]
+    ${NS}::entry $top.sha1 -width 40
     $top.sha1 insert 0 $rowmenuid
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
-    label $top.nlab -text [mc "Name:"]
-    entry $top.name -width 40
+    ${NS}::label $top.nlab -text [mc "Name:"]
+    ${NS}::entry $top.name -width 40
     grid $top.nlab $top.name -sticky w
-    frame $top.buts
-    button $top.buts.go -text [mc "Create"] -command [list mkbrgo $top=
]
-    button $top.buts.can -text [mc "Cancel"] -command "catch {destroy =
$top}"
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.go -text [mc "Create"] -command [list mkbr=
go $top]
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command "catch {d=
estroy $top}"
     bind $top <Key-Return> [list mkbrgo $top]
     bind $top <Key-Escape> "catch {destroy $top}"
     grid $top.buts.go $top.buts.can
@@ -8483,34 +8575,31 @@ proc cherrypick {} {
 }
=20
 proc resethead {} {
-    global mainhead rowmenuid confirm_ok resettype
+    global mainhead rowmenuid confirm_ok resettype NS
=20
     set confirm_ok 0
     set w ".confirmreset"
-    toplevel $w
+    ttk_toplevel $w
     make_transient $w .
     wm title $w [mc "Confirm reset"]
-    message $w.m -text \
-	[mc "Reset branch %s to %s?" $mainhead [string range $rowmenuid 0 7]]=
 \
-	-justify center -aspect 1000
+    ${NS}::label $w.m -text \
+	[mc "Reset branch %s to %s?" $mainhead [string range $rowmenuid 0 7]]
     pack $w.m -side top -fill x -padx 20 -pady 20
-    frame $w.f -relief sunken -border 2
-    message $w.f.rt -text [mc "Reset type:"] -aspect 1000
-    grid $w.f.rt -sticky w
+    ${NS}::labelframe $w.f -text [mc "Reset type:"]
     set resettype mixed
-    radiobutton $w.f.soft -value soft -variable resettype -justify lef=
t \
+    ${NS}::radiobutton $w.f.soft -value soft -variable resettype \
 	-text [mc "Soft: Leave working tree and index untouched"]
     grid $w.f.soft -sticky w
-    radiobutton $w.f.mixed -value mixed -variable resettype -justify l=
eft \
+    ${NS}::radiobutton $w.f.mixed -value mixed -variable resettype \
 	-text [mc "Mixed: Leave working tree untouched, reset index"]
     grid $w.f.mixed -sticky w
-    radiobutton $w.f.hard -value hard -variable resettype -justify lef=
t \
+    ${NS}::radiobutton $w.f.hard -value hard -variable resettype \
 	-text [mc "Hard: Reset working tree and index\n(discard ALL local cha=
nges)"]
     grid $w.f.hard -sticky w
-    pack $w.f -side top -fill x
-    button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
+    pack $w.f -side top -fill x -padx 4
+    ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; dest=
roy $w"
     pack $w.ok -side left -fill x -padx 20 -pady 20
-    button $w.cancel -text [mc Cancel] -command "destroy $w"
+    ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
     bind $w <Key-Escape> [list destroy $w]
     pack $w.cancel -side right -fill x -padx 20 -pady 20
     bind $w <Visibility> "grab $w; focus $w"
@@ -8658,7 +8747,7 @@ proc rmbranch {} {
=20
 # Display a list of tags and heads
 proc showrefs {} {
-    global showrefstop bgcolor fgcolor selectbgcolor
+    global showrefstop bgcolor fgcolor selectbgcolor NS
     global bglist fglist reflistfilter reflist maincursor
=20
     set top .showrefs
@@ -8668,7 +8757,7 @@ proc showrefs {} {
 	refill_reflist
 	return
     }
-    toplevel $top
+    ttk_toplevel $top
     wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
     make_transient $top .
     text $top.list -background $bgcolor -foreground $fgcolor \
@@ -8679,19 +8768,19 @@ proc showrefs {} {
     $top.list tag configure highlight -background $selectbgcolor
     lappend bglist $top.list
     lappend fglist $top.list
-    scrollbar $top.ysb -command "$top.list yview" -orient vertical
-    scrollbar $top.xsb -command "$top.list xview" -orient horizontal
+    ${NS}::scrollbar $top.ysb -command "$top.list yview" -orient verti=
cal
+    ${NS}::scrollbar $top.xsb -command "$top.list xview" -orient horiz=
ontal
     grid $top.list $top.ysb -sticky nsew
     grid $top.xsb x -sticky ew
-    frame $top.f
-    label $top.f.l -text "[mc "Filter"]: "
-    entry $top.f.e -width 20 -textvariable reflistfilter
+    ${NS}::frame $top.f
+    ${NS}::label $top.f.l -text "[mc "Filter"]: "
+    ${NS}::entry $top.f.e -width 20 -textvariable reflistfilter
     set reflistfilter "*"
     trace add variable reflistfilter write reflistfilter_change
     pack $top.f.e -side right -fill x -expand 1
     pack $top.f.l -side left
     grid $top.f - -sticky ew -pady 2
-    button $top.close -command [list destroy $top] -text [mc "Close"]
+    ${NS}::button $top.close -command [list destroy $top] -text [mc "C=
lose"]
     bind $top <Key-Escape> [list destroy $top]
     grid $top.close -
     grid columnconfigure $top 0 -weight 1
@@ -9986,19 +10075,20 @@ proc doquit {} {
 }
=20
 proc mkfontdisp {font top which} {
-    global fontattr fontpref $font
+    global fontattr fontpref $font NS use_ttk
=20
     set fontpref($font) [set $font]
-    button $top.${font}but -text $which -font optionfont \
+    ${NS}::button $top.${font}but -text $which \
 	-command [list choosefont $font $which]
-    label $top.$font -relief flat -font $font \
+    if {!$use_ttk} {$top.${font}but configure  -font optionfont}
+    ${NS}::label $top.$font -relief flat -font $font \
 	-text $fontattr($font,family) -justify left
     grid x $top.${font}but $top.$font -sticky w
 }
=20
 proc choosefont {font which} {
     global fontparam fontlist fonttop fontattr
-    global prefstop
+    global prefstop NS
=20
     set fontparam(which) $which
     set fontparam(font) $font
@@ -10011,21 +10101,21 @@ proc choosefont {font which} {
     if {![winfo exists $top]} {
 	font create sample
 	eval font config sample [font actual $font]
-	toplevel $top
+	ttk_toplevel $top
 	make_transient $top $prefstop
 	wm title $top [mc "Gitk font chooser"]
-	label $top.l -textvariable fontparam(which)
+	${NS}::label $top.l -textvariable fontparam(which)
 	pack $top.l -side top
 	set fontlist [lsort [font families]]
-	frame $top.f
+	${NS}::frame $top.f
 	listbox $top.f.fam -listvariable fontlist \
 	    -yscrollcommand [list $top.f.sb set]
 	bind $top.f.fam <<ListboxSelect>> selfontfam
-	scrollbar $top.f.sb -command [list $top.f.fam yview]
+	${NS}::scrollbar $top.f.sb -command [list $top.f.fam yview]
 	pack $top.f.sb -side right -fill y
 	pack $top.f.fam -side left -fill both -expand 1
 	pack $top.f -side top -fill both -expand 1
-	frame $top.g
+	${NS}::frame $top.g
 	spinbox $top.g.size -from 4 -to 40 -width 4 \
 	    -textvariable fontparam(size) \
 	    -validatecommand {string is integer -strict %s}
@@ -10043,9 +10133,9 @@ proc choosefont {font which} {
 	    -fill black -tags text
 	bind $top.c <Configure> [list centertext $top.c]
 	pack $top.c -side top -fill x
-	frame $top.buts
-	button $top.buts.ok -text [mc "OK"] -command fontok -default active
-	button $top.buts.can -text [mc "Cancel"] -command fontcan -default no=
rmal
+	${NS}::frame $top.buts
+	${NS}::button $top.buts.ok -text [mc "OK"] -command fontok -default a=
ctive
+	${NS}::button $top.buts.can -text [mc "Cancel"] -command fontcan -def=
ault normal
 	bind $top <Key-Return> fontok
 	bind $top <Key-Escape> fontcan
 	grid $top.buts.ok $top.buts.can
@@ -10096,6 +10186,28 @@ proc fontcan {} {
     }
 }
=20
+if {[package vsatisfies [package provide Tk] 8.6]} {
+    # In Tk 8.6 we have a native font chooser dialog. Overwrite the ab=
ove
+    # function to make use of it.
+    proc choosefont {font which} {
+	tk fontchooser configure -title $which -font $font \
+	    -command [list on_choosefont $font $which]
+	tk fontchooser show
+    }
+    proc on_choosefont {font which newfont} {
+	global fontparam
+	puts stderr "$font $newfont"
+	array set f [font actual $newfont]
+	set fontparam(which) $which
+	set fontparam(font) $font
+	set fontparam(family) $f(-family)
+	set fontparam(size) $f(-size)
+	set fontparam(weight) $f(-weight)
+	set fontparam(slant) $f(-slant)
+	fontok
+    }
+}
+       =20
 proc selfontfam {} {
     global fonttop fontparam
=20
@@ -10112,7 +10224,7 @@ proc chg_fontparam {v sub op} {
 }
=20
 proc doprefs {} {
-    global maxwidth maxgraphpct
+    global maxwidth maxgraphpct use_ttk NS
     global oldprefs prefstop showneartags showlocalchanges
     global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect extdifftool perfile_attrs
@@ -10127,103 +10239,109 @@ proc doprefs {} {
 		   limitdiffs tabstop perfile_attrs} {
 	set oldprefs($v) [set $v]
     }
-    toplevel $top
+    ttk_toplevel $top
     wm title $top [mc "Gitk preferences"]
     make_transient $top .
-    label $top.ldisp -text [mc "Commit list display options"]
+    ${NS}::label $top.ldisp -text [mc "Commit list display options"]
     grid $top.ldisp - -sticky w -pady 10
-    label $top.spacer -text " "
-    label $top.maxwidthl -text [mc "Maximum graph width (lines)"] \
-	-font optionfont
+    ${NS}::label $top.spacer -text " "
+    ${NS}::label $top.maxwidthl -text [mc "Maximum graph width (lines)=
"]
     spinbox $top.maxwidth -from 0 -to 100 -width 4 -textvariable maxwi=
dth
     grid $top.spacer $top.maxwidthl $top.maxwidth -sticky w
-    label $top.maxpctl -text [mc "Maximum graph width (% of pane)"] \
-	-font optionfont
+    ${NS}::label $top.maxpctl -text [mc "Maximum graph width (% of pan=
e)"]
     spinbox $top.maxpct -from 1 -to 100 -width 4 -textvariable maxgrap=
hpct
     grid x $top.maxpctl $top.maxpct -sticky w
-    checkbutton $top.showlocal -text [mc "Show local changes"] \
-	-font optionfont -variable showlocalchanges
+    ${NS}::checkbutton $top.showlocal -text [mc "Show local changes"] =
\
+	-variable showlocalchanges
     grid x $top.showlocal -sticky w
-    checkbutton $top.autoselect -text [mc "Auto-select SHA1"] \
-	-font optionfont -variable autoselect
+    ${NS}::checkbutton $top.autoselect -text [mc "Auto-select SHA1"] \
+	-variable autoselect
     grid x $top.autoselect -sticky w
-
-    label $top.ddisp -text [mc "Diff display options"]
+   =20
+    ${NS}::label $top.ddisp -text [mc "Diff display options"]
     grid $top.ddisp - -sticky w -pady 10
-    label $top.tabstopl -text [mc "Tab spacing"] -font optionfont
+    ${NS}::label $top.tabstopl -text [mc "Tab spacing"]
     spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
     grid x $top.tabstopl $top.tabstop -sticky w
-    checkbutton $top.ntag -text [mc "Display nearby tags"] \
-	-font optionfont -variable showneartags
+    ${NS}::checkbutton $top.ntag -text [mc "Display nearby tags"] \
+	-variable showneartags
     grid x $top.ntag -sticky w
-    checkbutton $top.ldiff -text [mc "Limit diffs to listed paths"] \
-	-font optionfont -variable limitdiffs
+    ${NS}::checkbutton $top.ldiff -text [mc "Limit diffs to listed pat=
hs"] \
+	-variable limitdiffs
     grid x $top.ldiff -sticky w
-    checkbutton $top.lattr -text [mc "Support per-file encodings"] \
-	-font optionfont -variable perfile_attrs
+    ${NS}::checkbutton $top.lattr -text [mc "Support per-file encoding=
s"] \
+	-variable perfile_attrs
     grid x $top.lattr -sticky w
=20
-    entry $top.extdifft -textvariable extdifftool
-    frame $top.extdifff
-    label $top.extdifff.l -text [mc "External diff tool" ] -font optio=
nfont \
-	-padx 10
-    button $top.extdifff.b -text [mc "Choose..."] -font optionfont \
-	-command choose_extdiff
+    ${NS}::entry $top.extdifft -textvariable extdifftool
+    ${NS}::frame $top.extdifff
+    ${NS}::label $top.extdifff.l -text [mc "External diff tool" ]
+    ${NS}::button $top.extdifff.b -text [mc "Choose..."] -command choo=
se_extdiff
     pack $top.extdifff.l $top.extdifff.b -side left
-    grid x $top.extdifff $top.extdifft -sticky w
+    pack configure $top.extdifff.l -padx 10
+    grid x $top.extdifff $top.extdifft -sticky ew
=20
-    label $top.cdisp -text [mc "Colors: press to choose"]
+    ${NS}::label $top.cdisp -text [mc "Colors: press to choose"]
     grid $top.cdisp - -sticky w -pady 10
     label $top.bg -padx 40 -relief sunk -background $bgcolor
-    button $top.bgbut -text [mc "Background"] -font optionfont \
+    ${NS}::button $top.bgbut -text [mc "Background"] \
 	-command [list choosecolor bgcolor {} $top.bg [mc "background"] setbg=
]
     grid x $top.bgbut $top.bg -sticky w
     label $top.fg -padx 40 -relief sunk -background $fgcolor
-    button $top.fgbut -text [mc "Foreground"] -font optionfont \
+    ${NS}::button $top.fgbut -text [mc "Foreground"] \
 	-command [list choosecolor fgcolor {} $top.fg [mc "foreground"] setfg=
]
     grid x $top.fgbut $top.fg -sticky w
     label $top.diffold -padx 40 -relief sunk -background [lindex $diff=
colors 0]
-    button $top.diffoldbut -text [mc "Diff: old lines"] -font optionfo=
nt \
+    ${NS}::button $top.diffoldbut -text [mc "Diff: old lines"] \
 	-command [list choosecolor diffcolors 0 $top.diffold [mc "diff old li=
nes"] \
 		      [list $ctext tag conf d0 -foreground]]
     grid x $top.diffoldbut $top.diffold -sticky w
     label $top.diffnew -padx 40 -relief sunk -background [lindex $diff=
colors 1]
-    button $top.diffnewbut -text [mc "Diff: new lines"] -font optionfo=
nt \
+    ${NS}::button $top.diffnewbut -text [mc "Diff: new lines"] \
 	-command [list choosecolor diffcolors 1 $top.diffnew [mc "diff new li=
nes"] \
 		      [list $ctext tag conf dresult -foreground]]
     grid x $top.diffnewbut $top.diffnew -sticky w
     label $top.hunksep -padx 40 -relief sunk -background [lindex $diff=
colors 2]
-    button $top.hunksepbut -text [mc "Diff: hunk header"] -font option=
font \
+    ${NS}::button $top.hunksepbut -text [mc "Diff: hunk header"] \
 	-command [list choosecolor diffcolors 2 $top.hunksep \
 		      [mc "diff hunk header"] \
 		      [list $ctext tag conf hunksep -foreground]]
     grid x $top.hunksepbut $top.hunksep -sticky w
     label $top.markbgsep -padx 40 -relief sunk -background $markbgcolo=
r
-    button $top.markbgbut -text [mc "Marked line bg"] -font optionfont=
 \
+    ${NS}::button $top.markbgbut -text [mc "Marked line bg"] \
 	-command [list choosecolor markbgcolor {} $top.markbgsep \
 		      [mc "marked line background"] \
 		      [list $ctext tag conf omark -background]]
     grid x $top.markbgbut $top.markbgsep -sticky w
     label $top.selbgsep -padx 40 -relief sunk -background $selectbgcol=
or
-    button $top.selbgbut -text [mc "Select bg"] -font optionfont \
+    ${NS}::button $top.selbgbut -text [mc "Select bg"] \
 	-command [list choosecolor selectbgcolor {} $top.selbgsep [mc "backgr=
ound"] setselbg]
     grid x $top.selbgbut $top.selbgsep -sticky w
=20
-    label $top.cfont -text [mc "Fonts: press to choose"]
+    ${NS}::label $top.cfont -text [mc "Fonts: press to choose"]
     grid $top.cfont - -sticky w -pady 10
     mkfontdisp mainfont $top [mc "Main font"]
     mkfontdisp textfont $top [mc "Diff display font"]
     mkfontdisp uifont $top [mc "User interface font"]
=20
-    frame $top.buts
-    button $top.buts.ok -text [mc "OK"] -command prefsok -default acti=
ve
-    button $top.buts.can -text [mc "Cancel"] -command prefscan -defaul=
t normal
+    if {!$use_ttk} {
+	foreach w {maxpctl maxwidthl showlocal autoselect tabstopl ntag
+	    ldiff lattr extdifff.l extdifff.b bgbut fgbut=20
+	    diffoldbut diffnewbut hunksepbut markbgbut selbgbut} {
+	    $top.$w configure -font optionfont
+	}
+    }
+
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.ok -text [mc "OK"] -command prefsok -defau=
lt active
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command prefscan =
-default normal
     bind $top <Key-Return> prefsok
     bind $top <Key-Escape> prefscan
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - - -pady 10 -sticky ew
+    grid columnconfigure $top 2 -weight 1
     bind $top <Visibility> "focus $top.buts.ok"
 }
=20
@@ -10886,6 +11004,10 @@ set nullid2 "000000000000000000000000000000000=
0000001"
 set nullfile "/dev/null"
=20
 set have_tk85 [expr {[package vcompare $tk_version "8.5"] >=3D 0}]
+if {![info exists use_ttk]} {
+    set use_ttk [llength [info commands ::ttk::style]]
+}
+set NS [expr {$use_ttk ? "ttk" : ""}]
=20
 set runq {}
 set history {}
--=20
1.6.2.2.1669.g7eaf8
