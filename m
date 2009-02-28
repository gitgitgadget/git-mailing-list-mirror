From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: make use of themed widgets where available
Date: 28 Feb 2009 00:18:00 +0000
Message-ID: <87ljrre7nr.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 01:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdDKG-0007iy-TN
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 01:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbZB1Anl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 19:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754489AbZB1Ank
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 19:43:40 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:48857 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753770AbZB1Anh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 19:43:37 -0500
X-Greylist: delayed 1574 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Feb 2009 19:43:36 EST
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1LdCu9-0000NG-5I; Sat, 28 Feb 2009 00:18:09 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1LdCu2-00084o-Ev; Sat, 28 Feb 2009 00:18:07 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 4356E51836; Sat, 28 Feb 2009 00:18:02 +0000 (GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111728>


    This patch improves the appearence of gitk on Windows XP and Vista
    by making use of the themed widgets that are provided in Tk 8.5
    and above. For good Vista support 8.6 will be needed.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |  432 ++++++++++++++++++++++++++++++++++++++++------------------=
--------
 1 files changed, 262 insertions(+), 170 deletions(-)

diff --git a/gitk b/gitk
index f8c3c73..2b5265a 100755
--- a/gitk
+++ b/gitk
@@ -1765,6 +1765,15 @@ proc removehead {id name} {
     unset headids($name)
 }
=20
+proc ttk_toplevel {w args} {
+    variable use_ttk
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
@@ -1784,14 +1793,16 @@ proc make_transient {window origin} {
 }
=20
 proc show_error {w top msg} {
+    variable use_ttk
+    set ttk [expr {$use_ttk ? "ttk" : ""}]
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
-    button $w.ok -text [mc OK] -command "destroy $top"
+    ${ttk}::button $w.ok -default active -text [mc OK] -command "destr=
oy $top"
     pack $w.ok -side bottom -fill x
     bind $top <Visibility> "grab $top; focus $top"
-    bind $top <Key-Return> "destroy $top"
-    bind $top <Key-space>  "destroy $top"
-    bind $top <Key-Escape> "destroy $top"
+    bind $top <Key-Return> [list $w.ok invoke]
+    bind $top <Key-space>  [list $w.ok invoke]
+    bind $top <Key-Escape> [list $w.ok invoke]
     tkwait window $top
 }
=20
@@ -1801,18 +1812,29 @@ proc error_popup {msg {owner .}} {
             -parent $owner -message $msg
     } else {
         set w .error
-        toplevel $w
+        ttk_toplevel $w
         make_transient $w $owner
         show_error $w $w $msg
     }
 }
=20
+variable fullscreen 0
+proc togglefullscreen {} {
+    variable fullscreen
+    if {[catch {
+        set ofs [wm attribute . -fullscreen]
+        if {$ofs} {set fs 0} else {set fs 1}
+        wm attribute . -fullscreen $fs
+        set fullscreen $fs
+    } err]} { error_popup "fullscreen error: $err" }
+}
+
 proc confirm_popup {msg {owner .}} {
     global confirm_ok use_ttk
     set ttk [expr {$use_ttk ? "ttk" : ""}]
     set confirm_ok 0
     set w .confirm
-    toplevel $w
+    ttk_toplevel $w
     make_transient $w $owner
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
@@ -1853,11 +1875,18 @@ proc setoptions {} {
 # description depends on type; it's the sublist for cascade, the
 # command to invoke for command, or {variable value} for radiobutton
 proc makemenu {m items} {
-    menu $m
-    if {[tk windowingsystem] eq {aqua}} {
-	set Meta1 Cmd
-    } else {
-	set Meta1 Ctrl
+    set Meta1 Ctrl
+    switch -exact -- [tk windowingsystem] {
+        win32 {
+            menu $m -tearoff 0
+        }
+        aqua {
+            menu $m
+            set Meta1 Cmd
+        }
+        default {
+            menu $m
+        }
     }
     foreach i $items {
 	set name [mc [lindex $i 1]]
@@ -1913,7 +1942,8 @@ proc makewindow {} {
     global headctxmenu progresscanv progressitem progresscoords status=
w
     global fprogitem fprogcoord lastprogupdate progupdatepending
     global rprogitem rprogcoord rownumsel numcommits
-    global have_tk85
+    global have_tk85 use_ttk
+    set ttk [expr {$use_ttk ? "ttk" : ""}]
=20
     # The "mc" arguments here are purely so that xgettext
     # sees the following string as needing to be translated
@@ -1945,8 +1975,10 @@ proc makewindow {} {
     }
     . configure -menu .bar
=20
+    place [${ttk}::frame ._main_background] -x 0 -y 0 -relwidth 1 -rel=
height 1
+
     # the gui has upper and lower half, parts of a paned window.
-    panedwindow .ctop -orient vertical
+    ${ttk}::panedwindow .ctop -orient vertical
=20
     # possibly use assumed geometry
     if {![info exists geometry(pwsash0)]} {
@@ -1954,46 +1986,56 @@ proc makewindow {} {
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
+    ${ttk}::frame .tf -height $geometry(topheight) -width $geometry(to=
pwidth)
+    ${ttk}::frame .tf.histframe
+    ${ttk}::panedwindow .tf.histframe.pwclist -orient horizontal=20
+    if {!$use_ttk} {
+        .tf.histframe.pwclist configure -sashpad 0 -handlesize 4
+    }
=20
     # create three canvases
     set cscroll .tf.histframe.csb
     set canv .tf.histframe.pwclist.canv
     canvas $canv \
 	-selectbackground $selectbgcolor \
-	-background $bgcolor -bd 0 \
-	-yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
+	-background $bgcolor -borderwidth 0 \
+	-yscrollincrement $linespc -yscrollcommand "scrollcanv $cscroll"
     .tf.histframe.pwclist add $canv
     set canv2 .tf.histframe.pwclist.canv2
     canvas $canv2 \
 	-selectbackground $selectbgcolor \
-	-background $bgcolor -bd 0 -yscrollincr $linespc
+	-background $bgcolor -borderwidth 0 -yscrollincrement $linespc
     .tf.histframe.pwclist add $canv2
     set canv3 .tf.histframe.pwclist.canv3
     canvas $canv3 \
 	-selectbackground $selectbgcolor \
-	-background $bgcolor -bd 0 -yscrollincr $linespc
+	-background $bgcolor -borderwidth 0 -yscrollincrement $linespc
     .tf.histframe.pwclist add $canv3
-    eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
-    eval .tf.histframe.pwclist sash place 1 $geometry(pwsash1)
+    if {$use_ttk} {
+        #set p1 [expr {[winfo screenwidth .] - (40 * $charspc)}]
+        #set p0 [expr {[winfo screenwidth .] - (100 * $charspc)}]
+        #.tf.histframe.pwclist sashpos 0 585
+        #.tf.histframe.pwclist sashpos 1 868
+     } else {
+        eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
+        eval .tf.histframe.pwclist sash place 1 $geometry(pwsash1)
+    }
=20
     # a scroll bar to rule them
-    scrollbar $cscroll -command {allcanvs yview} -highlightthickness 0
+    ${ttk}::scrollbar $cscroll -command {allcanvs yview} ;#-highlightt=
hickness 0
     pack $cscroll -side right -fill y
     bind .tf.histframe.pwclist <Configure> {resizeclistpanes %W %w}
     lappend bglist $canv $canv2 $canv3
     pack .tf.histframe.pwclist -fill both -expand 1 -side left
=20
     # we have two button bars at bottom of top frame. Bar 1
-    frame .tf.bar
-    frame .tf.lbar -height 15
+    ${ttk}::frame .tf.bar
+    ${ttk}::frame .tf.lbar -height 15
=20
     set sha1entry .tf.bar.sha1
     set entries $sha1entry
@@ -2002,7 +2044,7 @@ proc makewindow {} {
 	-command gotocommit -width 8
     $sha1but conf -disabledforeground [$sha1but cget -foreground]
     pack .tf.bar.sha1label -side left
-    entry $sha1entry -width 40 -font textfont -textvariable sha1string
+    ${ttk}::entry $sha1entry -width 40 -font textfont -textvariable sh=
a1string
     trace add variable sha1string write sha1change
     pack $sha1entry -side left -pady 2
=20
@@ -2029,12 +2071,12 @@ proc makewindow {} {
 	-state disabled -width 26
     pack .tf.bar.rightbut -side left -fill y
=20
-    label .tf.bar.rowlabel -text [mc "Row"]
+    ${ttk}::label .tf.bar.rowlabel -text [mc "Row"]
     set rownumsel {}
-    label .tf.bar.rownum -width 7 -font textfont -textvariable rownums=
el \
+    ${ttk}::label .tf.bar.rownum -width 7 -font textfont -textvariable=
 rownumsel \
 	-relief sunken -anchor e
-    label .tf.bar.rowlabel2 -text "/"
-    label .tf.bar.numcommits -width 7 -font textfont -textvariable num=
commits \
+    ${ttk}::label .tf.bar.rowlabel2 -text "/"
+    ${ttk}::label .tf.bar.numcommits -width 7 -font textfont -textvari=
able numcommits \
 	-relief sunken -anchor e
     pack .tf.bar.rowlabel .tf.bar.rownum .tf.bar.rowlabel2 .tf.bar.num=
commits \
 	-side left
@@ -2043,7 +2085,7 @@ proc makewindow {} {
=20
     # Status label and progress bar
     set statusw .tf.bar.status
-    label $statusw -width 15 -relief sunken
+    ${ttk}::label $statusw -width 15 -relief sunken
     pack $statusw -side left -padx 5
     set h [expr {[font metrics uifont -linespace] + 2}]
     set progresscanv .tf.bar.progress
@@ -2060,32 +2102,52 @@ proc makewindow {} {
     set progupdatepending 0
=20
     # build up the bottom bar of upper window
-    label .tf.lbar.flabel -text "[mc "Find"] "
-    button .tf.lbar.fnext -text [mc "next"] -command {dofind 1 1}
-    button .tf.lbar.fprev -text [mc "prev"] -command {dofind -1 1}
-    label .tf.lbar.flab2 -text " [mc "commit"] "
+    ${ttk}::label .tf.lbar.flabel -text "[mc "Find"] "
+    ${ttk}::button .tf.lbar.fnext -text [mc "next"] -command {dofind 1=
 1}
+    ${ttk}::button .tf.lbar.fprev -text [mc "prev"] -command {dofind -=
1 1}
+    ${ttk}::label .tf.lbar.flab2 -text " [mc "commit"] "
     pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 =
\
 	-side left -fill y
     set gdttype [mc "containing:"]
-    set gm [tk_optionMenu .tf.lbar.gdttype gdttype \
-		[mc "containing:"] \
-		[mc "touching paths:"] \
-		[mc "adding/removing string:"]]
+    if {$use_ttk} {
+        set values [list [mc "containing:"] [mc "touching paths:"] \
+                        [mc "adding/removing string:"]]
+        set gm [ttk::combobox .tf.lbar.gdttype -width 10\
+                    -values $values -textvariable gdtype]
+    } else {
+        set gm [tk_optionMenu .tf.lbar.gdttype gdttype \
+                    [mc "containing:"] \
+                    [mc "touching paths:"] \
+                    [mc "adding/removing string:"]]
+    }
     trace add variable gdttype write gdttype_change
     pack .tf.lbar.gdttype -side left -fill y
=20
     set findstring {}
     set fstring .tf.lbar.findstring
     lappend entries $fstring
-    entry $fstring -width 30 -font textfont -textvariable findstring
+    ${ttk}::entry $fstring -width 30 -font textfont -textvariable find=
string
     trace add variable findstring write find_change
     set findtype [mc "Exact"]
-    set findtypemenu [tk_optionMenu .tf.lbar.findtype \
-		      findtype [mc "Exact"] [mc "IgnCase"] [mc "Regexp"]]
+    if {$use_ttk} {
+        set values [list [mc "Exact"] [mc "IgnCase"] [mc "Regexp"]]
+        ttk::combobox .tf.lbar.findtype -width 10 \
+            -values $values -textvariable findtype
+     } else {
+        set findtypemenu [tk_optionMenu .tf.lbar.findtype \
+                              findtype [mc "Exact"] [mc "IgnCase"] [mc=
 "Regexp"]]
+    }
     trace add variable findtype write findcom_change
     set findloc [mc "All fields"]
-    tk_optionMenu .tf.lbar.findloc findloc [mc "All fields"] [mc "Head=
line"] \
-	[mc "Comments"] [mc "Author"] [mc "Committer"]
+    if {$use_ttk} {
+        set values [list [mc "All fields"] [mc "Headline"] \
+                        [mc "Comments"] [mc "Author"] [mc "Committer"]=
]
+        ttk::combobox .tf.lbar.findloc -width 10 \
+            -values $values -textvariable findloc
+    } else {
+        tk_optionMenu .tf.lbar.findloc findloc [mc "All fields"] [mc "=
Headline"] \
+            [mc "Comments"] [mc "Author"] [mc "Committer"]
+    }
     trace add variable findloc write find_change
     pack .tf.lbar.findloc -side right
     pack .tf.lbar.findtype -side right
@@ -2096,38 +2158,41 @@ proc makewindow {} {
     pack .tf.bar -in .tf -side bottom -fill x
     pack .tf.histframe -fill both -side top -expand 1
     .ctop add .tf
-    .ctop paneconfigure .tf -height $geometry(topheight)
-    .ctop paneconfigure .tf -width $geometry(topwidth)
+    if {!$use_ttk} {
+        .ctop paneconfigure .tf -height $geometry(topheight)
+        .ctop paneconfigure .tf -width $geometry(topwidth)
+    }
=20
     # now build up the bottom
-    panedwindow .pwbottom -orient horizontal
+    ${ttk}::panedwindow .pwbottom -orient horizontal
=20
     # lower left, a text box over search bar, scroll bar to the right
     # if we know window height, then that will set the lower text heig=
ht, otherwise
     # we set lower text height which will drive window height
     if {[info exists geometry(main)]} {
-        frame .bleft -width $geometry(botwidth)
+        ${ttk}::frame .bleft -width $geometry(botwidth)
     } else {
-        frame .bleft -width $geometry(botwidth) -height $geometry(both=
eight)
+        ${ttk}::frame .bleft -width $geometry(botwidth) -height $geome=
try(botheight)
     }
-    frame .bleft.top
-    frame .bleft.mid
-    frame .bleft.bottom
+    ${ttk}::frame .bleft.top
+    ${ttk}::frame .bleft.mid
+    ${ttk}::frame .bleft.bottom
=20
-    button .bleft.top.search -text [mc "Search"] -command dosearch
+    ${ttk}::button .bleft.top.search -text [mc "Search"] -command dose=
arch
     pack .bleft.top.search -side left -padx 5
     set sstring .bleft.top.sstring
-    entry $sstring -width 20 -font textfont -textvariable searchstring
+    variable searchstring ""
+    ${ttk}::entry $sstring -width 20 -font textfont -textvariable sear=
chstring
     lappend entries $sstring
     trace add variable searchstring write incrsearch
     pack $sstring -side left -expand 1 -fill x
-    radiobutton .bleft.mid.diff -text [mc "Diff"] \
+    ${ttk}::radiobutton .bleft.mid.diff -text [mc "Diff"] \
 	-command changediffdisp -variable diffelide -value {0 0}
-    radiobutton .bleft.mid.old -text [mc "Old version"] \
+    ${ttk}::radiobutton .bleft.mid.old -text [mc "Old version"] \
 	-command changediffdisp -variable diffelide -value {0 1}
-    radiobutton .bleft.mid.new -text [mc "New version"] \
+    ${ttk}::radiobutton .bleft.mid.new -text [mc "New version"] \
 	-command changediffdisp -variable diffelide -value {1 0}
-    label .bleft.mid.labeldiffcontext -text "      [mc "Lines of conte=
xt"]: "
+    ${ttk}::label .bleft.mid.labeldiffcontext -text "      [mc "Lines =
of context"]: "
     pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
     spinbox .bleft.mid.diffcontext -width 5 -font textfont \
 	-from 1 -increment 1 -to 10000000 \
@@ -2137,7 +2202,7 @@ proc makewindow {} {
     trace add variable diffcontextstring write diffcontextchange
     lappend entries .bleft.mid.diffcontext
     pack .bleft.mid.labeldiffcontext .bleft.mid.diffcontext -side left
-    checkbutton .bleft.mid.ignspace -text [mc "Ignore space change"] \
+    ${ttk}::checkbutton .bleft.mid.ignspace -text [mc "Ignore space ch=
ange"] \
 	-command changeignorespace -variable ignorespace
     pack .bleft.mid.ignspace -side left -padx 5
     set ctext .bleft.bottom.ctext
@@ -2148,9 +2213,8 @@ proc makewindow {} {
     if {$have_tk85} {
 	$ctext conf -tabstyle wordprocessor
     }
-    scrollbar .bleft.bottom.sb -command "$ctext yview"
-    scrollbar .bleft.bottom.sbhorizontal -command "$ctext xview" -orie=
nt h \
-	-width 10
+    ${ttk}::scrollbar .bleft.bottom.sb -command "$ctext yview"
+    ${ttk}::scrollbar .bleft.bottom.sbhorizontal -command "$ctext xvie=
w" -orient h
     pack .bleft.top -side top -fill x
     pack .bleft.mid -side top -fill x
     grid $ctext .bleft.bottom.sb -sticky nsew
@@ -2190,14 +2254,16 @@ proc makewindow {} {
     $ctext tag conf found -back yellow
=20
     .pwbottom add .bleft
-    .pwbottom paneconfigure .bleft -width $geometry(botwidth)
+    if {!$use_ttk} {
+        .pwbottom paneconfigure .bleft -width $geometry(botwidth)
+    }
=20
     # lower right
-    frame .bright
-    frame .bright.mode
-    radiobutton .bright.mode.patch -text [mc "Patch"] \
+    ${ttk}::frame .bright
+    ${ttk}::frame .bright.mode
+    ${ttk}::radiobutton .bright.mode.patch -text [mc "Patch"] \
 	-command reselectline -variable cmitmode -value "patch"
-    radiobutton .bright.mode.tree -text [mc "Tree"] \
+    ${ttk}::radiobutton .bright.mode.tree -text [mc "Tree"] \
 	-command reselectline -variable cmitmode -value "tree"
     grid .bright.mode.patch .bright.mode.tree -sticky ew
     pack .bright.mode -side top -fill x
@@ -2213,7 +2279,7 @@ proc makewindow {} {
 	-spacing1 1 -spacing3 1
     lappend bglist $cflist
     lappend fglist $cflist
-    scrollbar .bright.sb -command "$cflist yview"
+    ${ttk}::scrollbar .bright.sb -command "$cflist yview"
     pack .bright.sb -side right -fill y
     pack $cflist -side left -fill both -expand 1
     $cflist tag configure highlight \
@@ -2293,6 +2359,7 @@ proc makewindow {} {
     bindkey u "$ctext yview scroll -18 units"
     bindkey / {focus $fstring}
     bindkey <Key-Return> {dofind 1 1}
+    bindkey <Alt-Return> [namespace code [list togglefullscreen]]
     bindkey ? {dofind -1 1}
     bindkey f nextfile
     bind . <F5> updatecommits
@@ -2540,10 +2607,15 @@ proc savestuff {w} {
 }
=20
 proc resizeclistpanes {win w} {
-    global oldwidth
+    global oldwidth use_ttk
     if {[info exists oldwidth($win)]} {
-	set s0 [$win sash coord 0]
-	set s1 [$win sash coord 1]
+        if {$use_ttk} {
+            set s0 [$win sashpos 0]
+            set s1 [$win sashpos 1]
+        } else {
+            set s0 [$win sash coord 0]
+            set s1 [$win sash coord 1]
+        }
 	if {$w < 60} {
 	    set sash0 [expr {int($w/2 - 2)}]
 	    set sash1 [expr {int($w*5/6 - 2)}]
@@ -2564,16 +2636,25 @@ proc resizeclistpanes {win w} {
 		}
 	    }
 	}
-	$win sash place 0 $sash0 [lindex $s0 1]
-	$win sash place 1 $sash1 [lindex $s1 1]
+        if {$use_ttk} {
+            $win sashpos 0 $sash0
+            $win sashpos 1 $sash1
+        } else {
+            $win sash place 0 $sash0 [lindex $s0 1]
+            $win sash place 1 $sash1 [lindex $s1 1]
+        }
     }
     set oldwidth($win) $w
 }
=20
 proc resizecdetpanes {win w} {
-    global oldwidth
+    global oldwidth use_ttk
     if {[info exists oldwidth($win)]} {
-	set s0 [$win sash coord 0]
+        if {$use_ttk} {
+            set s0 [$win sashpos 0]
+        } else {
+            set s0 [$win sash coord 0]
+        }
 	if {$w < 60} {
 	    set sash0 [expr {int($w*3/4 - 2)}]
 	} else {
@@ -2586,7 +2667,11 @@ proc resizecdetpanes {win w} {
 		set sash0 [expr {$w - 15}]
 	    }
 	}
-	$win sash place 0 $sash0 [lindex $s0 1]
+        if {$use_ttk} {
+            $win sashpos 0 $sash0
+        } else {
+            $win sash place 0 $sash0 [lindex $s0 1]
+        }
     }
     set oldwidth($win) $w
 }
@@ -2606,13 +2691,15 @@ proc bindall {event action} {
 }
=20
 proc about {} {
-    global uifont
+    global uifont use_ttk
+    set ttk [expr {$use_ttk ? "ttk" : ""}]
     set w .about
     if {[winfo exists $w]} {
 	raise $w
 	return
     }
-    toplevel $w
+    ttk_toplevel $w
+    wm withdraw $w
     wm title $w [mc "About gitk"]
     make_transient $w .
     message $w.m -text [mc "
@@ -2623,14 +2710,18 @@ Copyright =C2=A9 2005-2008 Paul Mackerras
 Use and redistribute under the terms of the GNU General Public License=
"] \
 	    -justify center -aspect 400 -border 2 -bg white -relief groove
     pack $w.m -side top -fill x -padx 2 -pady 2
-    button $w.ok -text [mc "Close"] -command "destroy $w" -default act=
ive
+    ${ttk}::button $w.ok -text [mc "Close"] -command "destroy $w" -def=
ault active
     pack $w.ok -side bottom
     bind $w <Visibility> "focus $w.ok"
     bind $w <Key-Escape> "destroy $w"
     bind $w <Key-Return> "destroy $w"
+    tk::PlaceWindow $w widget .
+    wm deiconify $w
 }
=20
 proc keys {} {
+    variable use_ttk
+    set ttk [expr {$use_ttk ? "ttk" : ""}]
     set w .keys
     if {[winfo exists $w]} {
 	raise $w
@@ -2641,7 +2732,7 @@ proc keys {} {
     } else {
 	set M1T Ctrl
     }
-    toplevel $w
+    ttk_toplevel $w
     wm title $w [mc "Gitk key bindings"]
     make_transient $w .
     message $w.m -text "
@@ -2685,7 +2776,7 @@ proc keys {} {
 " \
 	    -justify left -bg white -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
-    button $w.ok -text [mc "Close"] -command "destroy $w" -default act=
ive
+    ${ttk}::button $w.ok -text [mc "Close"] -command "destroy $w" -def=
ault active
     bind $w <Key-Escape> [list destroy $w]
     pack $w.ok -side bottom
     bind $w <Visibility> "focus $w.ok"
@@ -3750,16 +3841,17 @@ proc editview {} {
=20
 proc vieweditor {top n title} {
     global newviewname newviewopts viewfiles bgcolor
-    global known_view_options
+    global known_view_options use_ttk
+    set ttk [expr {$use_ttk ? "ttk" : ""}]
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
+    ${ttk}::frame $top.nfr
+    ${ttk}::label $top.nl -text [mc "Name"]
+    ${ttk}::entry $top.name -width 20 -textvariable newviewname($n)
     pack $top.nfr -in $top -fill x -pady 5 -padx 3
     pack $top.nl -in $top.nfr -side left -padx {0 30}
     pack $top.name -in $top.nfr -side left
@@ -3778,7 +3870,7 @@ proc vieweditor {top n title} {
 	if {$flags eq "+" || $flags eq "*"} {
 	    set cframe $top.fr$cnt
 	    incr cnt
-	    frame $cframe
+	    ${ttk}::frame $cframe
 	    pack $cframe -in $top -fill x -pady 3 -padx 3
 	    set cexpand [expr {$flags eq "*"}]
 	} else {
@@ -3786,18 +3878,18 @@ proc vieweditor {top n title} {
 	}
=20
 	if {$type eq "b"} {
-	    checkbutton $cframe.c_$id -text $title -variable newviewopts($n,$=
id)
+	    ${ttk}::checkbutton $cframe.c_$id -text $title -variable newviewo=
pts($n,$id)
 	    pack $cframe.c_$id -in $cframe -side left \
 		-padx [list $lxpad 0] -expand $cexpand -anchor w
 	} elseif {[regexp {^t(\d+)$} $type type sz]} {
-	    message $cframe.l_$id -aspect 1500 -text $title
-	    entry $cframe.e_$id -width $sz -background $bgcolor \
+            ${ttk}::label $cframe.l_$id -text $title
+	    ${ttk}::entry $cframe.e_$id -width $sz -background $bgcolor \
 		-textvariable newviewopts($n,$id)
 	    pack $cframe.l_$id -in $cframe -side left -padx [list $lxpad 0]
 	    pack $cframe.e_$id -in $cframe -side left -expand 1 -fill x
 	} elseif {[regexp {^t(\d+)=3D$} $type type sz]} {
-	    message $cframe.l_$id -aspect 1500 -text $title
-	    entry $cframe.e_$id -width $sz -background $bgcolor \
+            ${ttk}::label $cframe.l_$id -text $title
+	    ${ttk}::entry $cframe.e_$id -width $sz -background $bgcolor \
 		-textvariable newviewopts($n,$id)
 	    pack $cframe.l_$id -in $cframe -side top -pady [list 3 0] -anchor=
 w
 	    pack $cframe.e_$id -in $cframe -side top -fill x
@@ -3805,7 +3897,7 @@ proc vieweditor {top n title} {
     }
=20
     # Path list
-    message $top.l -aspect 1500 \
+    ${ttk}::label $top.l \
 	-text [mc "Enter files and directories to include, one per line:"]
     pack $top.l -in $top -side top -pady [list 7 0] -anchor w -padx 3
     text $top.t -width 40 -height 5 -background $bgcolor -font uifont
@@ -3818,10 +3910,11 @@ proc vieweditor {top n title} {
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
+    ${ttk}::frame $top.buts
+    ${ttk}::button $top.buts.ok -text [mc "OK"] -command [list newview=
ok $top $n] \
+        -default active
+    ${ttk}::button $top.buts.apply -text [mc "Apply (F5)"] -command [l=
ist newviewok $top $n 1]
+    ${ttk}::button $top.buts.can -text [mc "Cancel"] -command [list de=
stroy $top]
     bind $top <Control-Return> [list newviewok $top $n]
     bind $top <F5> [list newviewok $top $n 1]
     bind $top <Escape> [list destroy $top]
@@ -6665,8 +6758,7 @@ proc selectline {l isnew {desired_loc {}}} {
     $sha1entry delete 0 end
     $sha1entry insert 0 $id
     if {$autoselect} {
-	$sha1entry selection from 0
-	$sha1entry selection to end
+	$sha1entry selection range 0 end
     }
     rhighlight_sel $id
=20
@@ -8043,7 +8135,8 @@ proc doseldiff {oldid newid} {
 }
=20
 proc mkpatch {} {
-    global rowmenuid currentid commitinfo patchtop patchnum
+    global rowmenuid currentid commitinfo patchtop patchnum use_ttk
+    set ttk [expr {$use_ttk ? "ttk" : ""}]
=20
     if {![info exists currentid]} return
     set oldid $currentid
@@ -8053,38 +8146,38 @@ proc mkpatch {} {
     set top .patch
     set patchtop $top
     catch {destroy $top}
-    toplevel $top
+    ttk_toplevel $top
     make_transient $top .
-    label $top.title -text [mc "Generate patch"]
+    ${ttk}::label $top.title -text [mc "Generate patch"]
     grid $top.title - -pady 10
-    label $top.from -text [mc "From:"]
-    entry $top.fromsha1 -width 40 -relief flat
+    ${ttk}::label $top.from -text [mc "From:"]
+    ${ttk}::entry $top.fromsha1 -width 40 ;#-relief flat
     $top.fromsha1 insert 0 $oldid
     $top.fromsha1 conf -state readonly
     grid $top.from $top.fromsha1 -sticky w
-    entry $top.fromhead -width 60 -relief flat
+    ${ttk}::entry $top.fromhead -width 60 ;#-relief flat
     $top.fromhead insert 0 $oldhead
     $top.fromhead conf -state readonly
     grid x $top.fromhead -sticky w
-    label $top.to -text [mc "To:"]
-    entry $top.tosha1 -width 40 -relief flat
+    ${ttk}::label $top.to -text [mc "To:"]
+    ${ttk}::entry $top.tosha1 -width 40 ;#-relief flat
     $top.tosha1 insert 0 $newid
     $top.tosha1 conf -state readonly
     grid $top.to $top.tosha1 -sticky w
-    entry $top.tohead -width 60 -relief flat
+    ${ttk}::entry $top.tohead -width 60 ;#-relief flat
     $top.tohead insert 0 $newhead
-    $top.tohead conf -state readonly
+    $top.tohead configure -state readonly
     grid x $top.tohead -sticky w
-    button $top.rev -text [mc "Reverse"] -command mkpatchrev -padx 5
-    grid $top.rev x -pady 10
-    label $top.flab -text [mc "Output file:"]
-    entry $top.fname -width 60
+    ${ttk}::button $top.rev -text [mc "Reverse"] -command mkpatchrev
+    grid $top.rev x -pady 10 -padx 5
+    ${ttk}::label $top.flab -text [mc "Output file:"]
+    ${ttk}::entry $top.fname -width 60
     $top.fname insert 0 [file normalize "patch$patchnum.patch"]
     incr patchnum
     grid $top.flab $top.fname -sticky w
-    frame $top.buts
-    button $top.buts.gen -text [mc "Generate"] -command mkpatchgo
-    button $top.buts.can -text [mc "Cancel"] -command mkpatchcan
+    ${ttk}::frame $top.buts
+    ${ttk}::button $top.buts.gen -text [mc "Generate"] -command mkpatc=
hgo
+    ${ttk}::button $top.buts.can -text [mc "Cancel"] -command mkpatchc=
an
     bind $top <Key-Return> mkpatchgo
     bind $top <Key-Escape> mkpatchcan
     grid $top.buts.gen $top.buts.can
@@ -8140,7 +8233,7 @@ proc mktag {} {
     set top .maketag
     set mktagtop $top
     catch {destroy $top}
-    toplevel $top
+    ttk_toplevel $top
     make_transient $top .
     label $top.title -text [mc "Create tag"]
     grid $top.title - -pady 10
@@ -8243,7 +8336,7 @@ proc writecommit {} {
     set top .writecommit
     set wrcomtop $top
     catch {destroy $top}
-    toplevel $top
+    ttk_toplevel $top
     make_transient $top .
     label $top.title -text [mc "Write commit to file"]
     grid $top.title - -pady 10
@@ -8300,7 +8393,7 @@ proc mkbranch {} {
=20
     set top .makebranch
     catch {destroy $top}
-    toplevel $top
+    ttk_toplevel $top
     make_transient $top .
     label $top.title -text [mc "Create new branch"]
     grid $top.title - -pady 10
@@ -8463,7 +8556,7 @@ proc resethead {} {
=20
     set confirm_ok 0
     set w ".confirmreset"
-    toplevel $w
+    ttk_toplevel $w
     make_transient $w .
     wm title $w [mc "Confirm reset"]
     message $w.m -text \
@@ -8644,7 +8737,7 @@ proc showrefs {} {
 	refill_reflist
 	return
     }
-    toplevel $top
+    ttk_toplevel $top
     wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
     make_transient $top .
     text $top.list -background $bgcolor -foreground $fgcolor \
@@ -9987,7 +10080,7 @@ proc choosefont {font which} {
     if {![winfo exists $top]} {
 	font create sample
 	eval font config sample [font actual $font]
-	toplevel $top
+	ttk_toplevel $top
 	make_transient $top $prefstop
 	wm title $top [mc "Gitk font chooser"]
 	label $top.l -textvariable fontparam(which)
@@ -10088,10 +10181,11 @@ proc chg_fontparam {v sub op} {
 }
=20
 proc doprefs {} {
-    global maxwidth maxgraphpct
+    global maxwidth maxgraphpct use_ttk
     global oldprefs prefstop showneartags showlocalchanges
     global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect extdifftool perfile_attrs
+    set ttk [expr {$use_ttk ? "ttk" : ""}]
=20
     set top .gitkprefs
     set prefstop $top
@@ -10103,97 +10197,95 @@ proc doprefs {} {
 		   limitdiffs tabstop perfile_attrs} {
 	set oldprefs($v) [set $v]
     }
-    toplevel $top
+    ttk_toplevel $top
     wm title $top [mc "Gitk preferences"]
     make_transient $top .
-    label $top.ldisp -text [mc "Commit list display options"]
+    ${ttk}::label $top.ldisp -text [mc "Commit list display options"]
     grid $top.ldisp - -sticky w -pady 10
-    label $top.spacer -text " "
-    label $top.maxwidthl -text [mc "Maximum graph width (lines)"] \
+    ${ttk}::label $top.spacer -text " "
+    ${ttk}::label $top.maxwidthl -text [mc "Maximum graph width (lines=
)"] \
 	-font optionfont
     spinbox $top.maxwidth -from 0 -to 100 -width 4 -textvariable maxwi=
dth
     grid $top.spacer $top.maxwidthl $top.maxwidth -sticky w
-    label $top.maxpctl -text [mc "Maximum graph width (% of pane)"] \
+    ${ttk}::label $top.maxpctl -text [mc "Maximum graph width (% of pa=
ne)"] \
 	-font optionfont
     spinbox $top.maxpct -from 1 -to 100 -width 4 -textvariable maxgrap=
hpct
     grid x $top.maxpctl $top.maxpct -sticky w
-    checkbutton $top.showlocal -text [mc "Show local changes"] \
-	-font optionfont -variable showlocalchanges
+    ${ttk}::checkbutton $top.showlocal -text [mc "Show local changes"]=
 \
+	-variable showlocalchanges
     grid x $top.showlocal -sticky w
-    checkbutton $top.autoselect -text [mc "Auto-select SHA1"] \
-	-font optionfont -variable autoselect
+    ${ttk}::checkbutton $top.autoselect -text [mc "Auto-select SHA1"] =
\
+	-variable autoselect
     grid x $top.autoselect -sticky w
=20
-    label $top.ddisp -text [mc "Diff display options"]
+    ${ttk}::label $top.ddisp -text [mc "Diff display options"]
     grid $top.ddisp - -sticky w -pady 10
-    label $top.tabstopl -text [mc "Tab spacing"] -font optionfont
+    ${ttk}::label $top.tabstopl -text [mc "Tab spacing"] -font optionf=
ont
     spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
     grid x $top.tabstopl $top.tabstop -sticky w
-    checkbutton $top.ntag -text [mc "Display nearby tags"] \
-	-font optionfont -variable showneartags
+    ${ttk}::checkbutton $top.ntag -text [mc "Display nearby tags"] \
+	-variable showneartags
     grid x $top.ntag -sticky w
-    checkbutton $top.ldiff -text [mc "Limit diffs to listed paths"] \
-	-font optionfont -variable limitdiffs
+    ${ttk}::checkbutton $top.ldiff -text [mc "Limit diffs to listed pa=
ths"] \
+	-variable limitdiffs
     grid x $top.ldiff -sticky w
-    checkbutton $top.lattr -text [mc "Support per-file encodings"] \
-	-font optionfont -variable perfile_attrs
+    ${ttk}::checkbutton $top.lattr -text [mc "Support per-file encodin=
gs"] \
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
-    pack $top.extdifff.l $top.extdifff.b -side left
+    ${ttk}::entry $top.extdifft -textvariable extdifftool
+    ${ttk}::frame $top.extdifff
+    ${ttk}::label $top.extdifff.l -text [mc "External diff tool" ] -fo=
nt optionfont
+    ${ttk}::button $top.extdifff.b -text [mc "Choose..."] -command cho=
ose_extdiff
+    pack $top.extdifff.l -padx 10 ; pack $top.extdifff.b -side left
     grid x $top.extdifff $top.extdifft -sticky w
=20
-    label $top.cdisp -text [mc "Colors: press to choose"]
+    ${ttk}::label $top.cdisp -text [mc "Colors: press to choose"]
     grid $top.cdisp - -sticky w -pady 10
-    label $top.bg -padx 40 -relief sunk -background $bgcolor
-    button $top.bgbut -text [mc "Background"] -font optionfont \
+    ${ttk}::label $top.bg -relief sunk -background $bgcolor
+    ${ttk}::button $top.bgbut -text [mc "Background"] -font optionfont=
 \
 	-command [list choosecolor bgcolor {} $top.bg [mc "background"] setbg=
]
     grid x $top.bgbut $top.bg -sticky w
-    label $top.fg -padx 40 -relief sunk -background $fgcolor
-    button $top.fgbut -text [mc "Foreground"] -font optionfont \
+    ${ttk}::label $top.fg -padx 40 -relief sunk -background $fgcolor
+    ${ttk}::button $top.fgbut -text [mc "Foreground"] -font optionfont=
 \
 	-command [list choosecolor fgcolor {} $top.fg [mc "foreground"] setfg=
]
     grid x $top.fgbut $top.fg -sticky w
-    label $top.diffold -padx 40 -relief sunk -background [lindex $diff=
colors 0]
-    button $top.diffoldbut -text [mc "Diff: old lines"] -font optionfo=
nt \
+    ${ttk}::label $top.diffold -padx 40 -relief sunk -background [lind=
ex $diffcolors 0]
+    ${ttk}::button $top.diffoldbut -text [mc "Diff: old lines"] -font =
optionfont \
 	-command [list choosecolor diffcolors 0 $top.diffold [mc "diff old li=
nes"] \
 		      [list $ctext tag conf d0 -foreground]]
     grid x $top.diffoldbut $top.diffold -sticky w
-    label $top.diffnew -padx 40 -relief sunk -background [lindex $diff=
colors 1]
-    button $top.diffnewbut -text [mc "Diff: new lines"] -font optionfo=
nt \
+    ${ttk}::label $top.diffnew -padx 40 -relief sunk -background [lind=
ex $diffcolors 1]
+    ${ttk}::button $top.diffnewbut -text [mc "Diff: new lines"] -font =
optionfont \
 	-command [list choosecolor diffcolors 1 $top.diffnew [mc "diff new li=
nes"] \
 		      [list $ctext tag conf dresult -foreground]]
     grid x $top.diffnewbut $top.diffnew -sticky w
-    label $top.hunksep -padx 40 -relief sunk -background [lindex $diff=
colors 2]
-    button $top.hunksepbut -text [mc "Diff: hunk header"] -font option=
font \
+    ${ttk}::label $top.hunksep -padx 40 -relief sunk -background [lind=
ex $diffcolors 2]
+    ${ttk}::button $top.hunksepbut -text [mc "Diff: hunk header"] -fon=
t optionfont \
 	-command [list choosecolor diffcolors 2 $top.hunksep \
 		      [mc "diff hunk header"] \
 		      [list $ctext tag conf hunksep -foreground]]
     grid x $top.hunksepbut $top.hunksep -sticky w
-    label $top.markbgsep -padx 40 -relief sunk -background $markbgcolo=
r
-    button $top.markbgbut -text [mc "Marked line bg"] -font optionfont=
 \
+    ${ttk}::label $top.markbgsep -padx 40 -relief sunk -background $ma=
rkbgcolor
+    ${ttk}::button $top.markbgbut -text [mc "Marked line bg"] -font op=
tionfont \
 	-command [list choosecolor markbgcolor {} $top.markbgsep \
 		      [mc "marked line background"] \
 		      [list $ctext tag conf omark -background]]
     grid x $top.markbgbut $top.markbgsep -sticky w
-    label $top.selbgsep -padx 40 -relief sunk -background $selectbgcol=
or
-    button $top.selbgbut -text [mc "Select bg"] -font optionfont \
+    ${ttk}::label $top.selbgsep -padx 40 -relief sunk -background $sel=
ectbgcolor
+    ${ttk}::button $top.selbgbut -text [mc "Select bg"] -font optionfo=
nt \
 	-command [list choosecolor selectbgcolor {} $top.selbgsep [mc "backgr=
ound"] setselbg]
     grid x $top.selbgbut $top.selbgsep -sticky w
=20
-    label $top.cfont -text [mc "Fonts: press to choose"]
+    ${ttk}::label $top.cfont -text [mc "Fonts: press to choose"]
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
+    ${ttk}::frame $top.buts
+    ${ttk}::button $top.buts.ok -text [mc "OK"] -command prefsok -defa=
ult active
+    ${ttk}::button $top.buts.can -text [mc "Cancel"] -command prefscan=
 -default normal
     bind $top <Key-Return> prefsok
     bind $top <Key-Escape> prefscan
     grid $top.buts.ok $top.buts.can
@@ -10791,11 +10883,11 @@ proc init {args} {
=20
     # check that we can find a .git directory somewhere...
     if {[catch {set gitdir [gitdir]}]} {
-        show_error {} . [mc "Cannot find a git repository here."]
+        error_popup [mc "Cannot find a git repository here."]
         exit 1
     }
     if {![file isdirectory $gitdir]} {
-        show_error {} . [mc "Cannot find the git directory \"%s\"." $g=
itdir]
+        error_popup [mc "Cannot find the git directory \"%s\"." $gitdi=
r]
         exit 1
     }
=20
--=20
1.6.0.2.1172.ga5ed0
