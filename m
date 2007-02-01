From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Wed, 31 Jan 2007 20:41:55 -0500
Message-ID: <45C14563.8060707@verizon.net>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl> <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070502020008060203070903"
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 03:55:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCS6U-0003Oy-Eq
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 03:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377AbXBACzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 21:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933382AbXBACzK
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 21:55:10 -0500
Received: from main.gmane.org ([80.91.229.2]:45182 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933377AbXBACzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 21:55:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HCS6I-0001yh-Lg
	for git@vger.kernel.org; Thu, 01 Feb 2007 03:55:02 +0100
Received: from pool-71-246-235-75.washdc.fios.verizon.net ([71.246.235.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 03:55:02 +0100
Received: from mdl123 by pool-71-246-235-75.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 03:55:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-246-235-75.washdc.fios.verizon.net
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38319>

This is a multi-part message in MIME format.
--------------070502020008060203070903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The gitk gui layout was completely broken on Cygwin. If gitk was started
without previous geometry in ~/.gitk, the user could drag the window 
sashes to get a useable layout. However, if ~/.gitk existed, this was 
not possible at all.

The fix was to rewrite makewindow, changing the toplevel containers and
the particular geometry information saved between sessions. Numerous 
bugs in both the Cygwin and the Linux Tk versions make this a delicate
balancing act: the version here works in both but many subtle variants
are competely broken in one or the other environment.

Three user visible changes result:
1 - The viewer is fully functional under Cygwin.
2 - The search bar moves from the bottom to the top of the lower left
    pane. This was necessary to get around a layout problem on Cygwin.
3 - The window size and position is saved and restored between sessions.
    Again, this is necessary to get around a layout problem on Cygwin.

Also, responding to other comments on this thread:

1) Regarding the size of the patch. I tried many different approaches to 
getting the layout to work on Cgywin as well as Linux, ultimately the 
only approach that worked required changing the very top level structure 
containing the Tk widgets. As the  style used names all widgets using 
their parents, every widget's name is changed. This makes the patch seem 
more complex than it is, many changes  are just changing names. There 
might be a simpler solution, I didn't find it and I can find absolutely 
no indication from googling that anyone else has found a better solution.

2) I have changed the default window size (used only the first time gitk 
is run) to be smaller. This may address the problem of layout noted in 
mingw. Note that the search bar is not at the bottom left, but is now 
middle left. On cygwin, the widgets mostly resize with the window, but 
may not always do so if the resizing is significant, and in particular 
the lower left pane can extend below the window and be clipped. 
Restarting gitk after setting the desired geometry will cause all 
widgets to size correctly, so this layout problem is a minor annoyance 
suffered only the first time, and only on Cygwin (it does not happen on 
Linux).

3) I have tried this extensively on Linux and Cygwin (the latter using 
the native Tcl /Tk as well as one built for the X-server under cygwin). 
This version of gitk works well in all, and as far as I can tell has no 
regressions from the current version while significantly improving the 
situation in native Cygwin.

Mark Levedahl

--------------070502020008060203070903
Content-Type: text/plain;
 name="0001-Make-gitk-work-reasonably-well-on-Cygwin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Make-gitk-work-reasonably-well-on-Cygwin.patch"

>From ba01b56d615dcc553e278ead7030a0f0b4918766 Mon Sep 17 00:00:00 2001
From: Mark Levedahl <mdl123@verizon.net>
Date: Wed, 31 Jan 2007 18:51:21 -0500
Subject: [PATCH] Make gitk work reasonably well on Cygwin.

The gitk gui layout was completely broken on Cygwin. If gitk was started
without previous geometry in ~/.gitk, the user could drag the window sashes
to get a useable layout. However, if ~/.gitk existed, this was not possible
at all.

The fix was to rewrite makewindow, changing the toplevel containers and
the particular geometry information saved between sessions. Numerous bugs
in both the Cygwin and the Linux Tk versions make this a delicate
balancing act: the version here works in both but many subtle variants
are competely broken in one or the other environment.

Three user visible changes result:
1 - The viewer is fully functional under Cygwin.
2 - The search bar moves from the bottom to the top of the lower left
    pane. This was necessary to get around a layout problem on Cygwin.
3 - The window size and position is saved and restored between sessions.
    Again, this is necessary to get around a layout problem on Cygwin.
---
 gitk |  284 ++++++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 155 insertions(+), 129 deletions(-)

diff --git a/gitk b/gitk
index 31d0aad..a0d27f5 100755
--- a/gitk
+++ b/gitk
@@ -427,7 +427,7 @@ proc makewindow {} {
     .bar.view add separator
     .bar.view add radiobutton -label "All files" -command {showview 0} \
 	-variable selectedview -value 0
-    
+
     menu .bar.help
     .bar add cascade -label "Help" -menu .bar.help
     .bar.help add command -label "About gitk" -command about
@@ -435,56 +435,59 @@ proc makewindow {} {
     .bar.help configure -font $uifont
     . configure -menu .bar
 
-    if {![info exists geometry(canv1)]} {
-	set geometry(canv1) [expr {45 * $charspc}]
-	set geometry(canv2) [expr {30 * $charspc}]
-	set geometry(canv3) [expr {15 * $charspc}]
-	set geometry(canvh) [expr {25 * $linespc + 4}]
-	set geometry(ctextw) 80
-	set geometry(ctexth) 30
-	set geometry(cflistw) 30
-    }
+    # the gui has upper and lower half, parts of a paned window.
     panedwindow .ctop -orient vertical
-    if {[info exists geometry(width)]} {
-	.ctop conf -width $geometry(width) -height $geometry(height)
-	set texth [expr {$geometry(height) - $geometry(canvh) - 56}]
-	set geometry(ctexth) [expr {($texth - 8) /
-				    [font metrics $textfont -linespace]}]
-    }
-    frame .ctop.top
-    frame .ctop.top.bar
-    frame .ctop.top.lbar
-    pack .ctop.top.lbar -side bottom -fill x
-    pack .ctop.top.bar -side bottom -fill x
-    set cscroll .ctop.top.csb
-    scrollbar $cscroll -command {allcanvs yview} -highlightthickness 0
-    pack $cscroll -side right -fill y
-    panedwindow .ctop.top.clist -orient horizontal -sashpad 0 -handlesize 4
-    pack .ctop.top.clist -side top -fill both -expand 1
-    .ctop add .ctop.top
-    set canv .ctop.top.clist.canv
-    canvas $canv -height $geometry(canvh) -width $geometry(canv1) \
+
+    # possibly use assumed geometry
+    if {![info exists geometry(topheight)]} {
+        set geometry(topheight) [expr {15 * $linespc}]
+        set geometry(topwidth) [expr {80 * $charspc}]
+        set geometry(botheight) [expr {15 * $linespc}]
+        set geometry(botwidth) [expr {50 * $charspc}]
+        set geometry(canv) [expr {40 * $charspc}]
+        set geometry(canv2) [expr {20 * $charspc}]
+        set geometry(canv3) [expr {20 * $charspc}]
+    }
+
+    # the upper half will have a paned window, a scroll bar to the right, and some stuff below
+    frame .tf -height $geometry(topheight) -width $geometry(topwidth)
+    frame .tf.histframe
+    panedwindow .tf.histframe.pwclist -orient horizontal -sashpad 0 -handlesize 4
+
+    # create three canvases
+    set cscroll .tf.histframe.csb
+    set canv .tf.histframe.pwclist.canv
+    canvas $canv -width $geometry(canv) \
 	-background $bgcolor -bd 0 \
 	-yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
-    .ctop.top.clist add $canv
-    set canv2 .ctop.top.clist.canv2
-    canvas $canv2 -height $geometry(canvh) -width $geometry(canv2) \
+    .tf.histframe.pwclist add $canv
+    set canv2 .tf.histframe.pwclist.canv2
+    canvas $canv2 -width $geometry(canv2) \
 	-background $bgcolor -bd 0 -yscrollincr $linespc
-    .ctop.top.clist add $canv2
-    set canv3 .ctop.top.clist.canv3
-    canvas $canv3 -height $geometry(canvh) -width $geometry(canv3) \
+    .tf.histframe.pwclist add $canv2
+    set canv3 .tf.histframe.pwclist.canv3
+    canvas $canv3 -width $geometry(canv3) \
 	-background $bgcolor -bd 0 -yscrollincr $linespc
-    .ctop.top.clist add $canv3
-    bind .ctop.top.clist <Configure> {resizeclistpanes %W %w}
+    .tf.histframe.pwclist add $canv3
+
+    # a scroll bar to rule them
+    scrollbar $cscroll -command {allcanvs yview} -highlightthickness 0
+    pack $cscroll -side right -fill y
+    bind .tf.histframe.pwclist <Configure> {resizeclistpanes %W %w}
     lappend bglist $canv $canv2 $canv3
+    pack .tf.histframe.pwclist -fill both -expand 1 -side left
+
+    # we have two button bars at bottom of top frame. Bar 1
+    frame .tf.bar
+    frame .tf.lbar -height 15
 
-    set sha1entry .ctop.top.bar.sha1
+    set sha1entry .tf.bar.sha1
     set entries $sha1entry
-    set sha1but .ctop.top.bar.sha1label
+    set sha1but .tf.bar.sha1label
     button $sha1but -text "SHA1 ID: " -state disabled -relief flat \
 	-command gotocommit -width 8 -font $uifont
     $sha1but conf -disabledforeground [$sha1but cget -foreground]
-    pack .ctop.top.bar.sha1label -side left
+    pack .tf.bar.sha1label -side left
     entry $sha1entry -width 40 -font $textfont -textvariable sha1string
     trace add variable sha1string write sha1change
     pack $sha1entry -side left -pady 2
@@ -505,91 +508,107 @@ proc makewindow {} {
 	0x00, 0x38, 0xff, 0x7f, 0xff, 0x7f, 0xff, 0x7f, 0x00, 0x38, 0x00, 0x1c,
 	0x00, 0x0e, 0x00, 0x07, 0x80, 0x03, 0xc0, 0x01};
     }
-    button .ctop.top.bar.leftbut -image bm-left -command goback \
+    button .tf.bar.leftbut -image bm-left -command goback \
 	-state disabled -width 26
-    pack .ctop.top.bar.leftbut -side left -fill y
-    button .ctop.top.bar.rightbut -image bm-right -command goforw \
+    pack .tf.bar.leftbut -side left -fill y
+    button .tf.bar.rightbut -image bm-right -command goforw \
 	-state disabled -width 26
-    pack .ctop.top.bar.rightbut -side left -fill y
+    pack .tf.bar.rightbut -side left -fill y
 
-    button .ctop.top.bar.findbut -text "Find" -command dofind -font $uifont
-    pack .ctop.top.bar.findbut -side left
+    button .tf.bar.findbut -text "Find" -command dofind -font $uifont
+    pack .tf.bar.findbut -side left
     set findstring {}
-    set fstring .ctop.top.bar.findstring
+    set fstring .tf.bar.findstring
     lappend entries $fstring
     entry $fstring -width 30 -font $textfont -textvariable findstring
     trace add variable findstring write find_change
-    pack $fstring -side left -expand 1 -fill x
+    pack $fstring -side left -expand 1 -fill x -in .tf.bar
     set findtype Exact
-    set findtypemenu [tk_optionMenu .ctop.top.bar.findtype \
-			  findtype Exact IgnCase Regexp]
+    set findtypemenu [tk_optionMenu .tf.bar.findtype \
+		      findtype Exact IgnCase Regexp]
     trace add variable findtype write find_change
-    .ctop.top.bar.findtype configure -font $uifont
-    .ctop.top.bar.findtype.menu configure -font $uifont
+    .tf.bar.findtype configure -font $uifont
+    .tf.bar.findtype.menu configure -font $uifont
     set findloc "All fields"
-    tk_optionMenu .ctop.top.bar.findloc findloc "All fields" Headline \
+    tk_optionMenu .tf.bar.findloc findloc "All fields" Headline \
 	Comments Author Committer
     trace add variable findloc write find_change
-    .ctop.top.bar.findloc configure -font $uifont
-    .ctop.top.bar.findloc.menu configure -font $uifont
-    pack .ctop.top.bar.findloc -side right
-    pack .ctop.top.bar.findtype -side right
+    .tf.bar.findloc configure -font $uifont
+    .tf.bar.findloc.menu configure -font $uifont
+    pack .tf.bar.findloc -side right
+    pack .tf.bar.findtype -side right
 
-    label .ctop.top.lbar.flabel -text "Highlight:  Commits " \
-	-font $uifont
-    pack .ctop.top.lbar.flabel -side left -fill y
+    #-----------------
+
+    # build up the bottom bar of upper window
+    label .tf.lbar.flabel -text "Highlight:  Commits " \
+    -font $uifont
+    pack .tf.lbar.flabel -side left -fill y
     set gdttype "touching paths:"
-    set gm [tk_optionMenu .ctop.top.lbar.gdttype gdttype "touching paths:" \
-		"adding/removing string:"]
+    set gm [tk_optionMenu .tf.lbar.gdttype gdttype "touching paths:" \
+	"adding/removing string:"]
     trace add variable gdttype write hfiles_change
     $gm conf -font $uifont
-    .ctop.top.lbar.gdttype conf -font $uifont
-    pack .ctop.top.lbar.gdttype -side left -fill y
-    entry .ctop.top.lbar.fent -width 25 -font $textfont \
+    .tf.lbar.gdttype conf -font $uifont
+    pack .tf.lbar.gdttype -side left -fill y
+    entry .tf.lbar.fent -width 25 -font $textfont \
 	-textvariable highlight_files
     trace add variable highlight_files write hfiles_change
-    lappend entries .ctop.top.lbar.fent
-    pack .ctop.top.lbar.fent -side left -fill x -expand 1
-    label .ctop.top.lbar.vlabel -text " OR in view" -font $uifont
-    pack .ctop.top.lbar.vlabel -side left -fill y
+    lappend entries .tf.lbar.fent
+    pack .tf.lbar.fent -side left -fill x -expand 1
+    label .tf.lbar.vlabel -text " OR in view" -font $uifont
+    pack .tf.lbar.vlabel -side left -fill y
     global viewhlmenu selectedhlview
-    set viewhlmenu [tk_optionMenu .ctop.top.lbar.vhl selectedhlview None]
+    set viewhlmenu [tk_optionMenu .tf.lbar.vhl selectedhlview None]
     $viewhlmenu entryconf None -command delvhighlight
     $viewhlmenu conf -font $uifont
-    .ctop.top.lbar.vhl conf -font $uifont
-    pack .ctop.top.lbar.vhl -side left -fill y
-    label .ctop.top.lbar.rlabel -text " OR " -font $uifont
-    pack .ctop.top.lbar.rlabel -side left -fill y
+    .tf.lbar.vhl conf -font $uifont
+    pack .tf.lbar.vhl -side left -fill y
+    label .tf.lbar.rlabel -text " OR " -font $uifont
+    pack .tf.lbar.rlabel -side left -fill y
     global highlight_related
-    set m [tk_optionMenu .ctop.top.lbar.relm highlight_related None \
-	       "Descendent" "Not descendent" "Ancestor" "Not ancestor"]
+    set m [tk_optionMenu .tf.lbar.relm highlight_related None \
+	"Descendent" "Not descendent" "Ancestor" "Not ancestor"]
     $m conf -font $uifont
-    .ctop.top.lbar.relm conf -font $uifont
+    .tf.lbar.relm conf -font $uifont
     trace add variable highlight_related write vrel_change
-    pack .ctop.top.lbar.relm -side left -fill y
-
-    panedwindow .ctop.cdet -orient horizontal
-    .ctop add .ctop.cdet
-    frame .ctop.cdet.left
-    frame .ctop.cdet.left.bot
-    pack .ctop.cdet.left.bot -side bottom -fill x
-    button .ctop.cdet.left.bot.search -text "Search" -command dosearch \
+    pack .tf.lbar.relm -side left -fill y
+
+    # Finish putting the upper half of the viewer together
+    pack .tf.lbar -in .tf -side bottom -fill x
+    pack .tf.bar -in .tf -side bottom -fill x
+    pack .tf.histframe -fill both -side top -expand 1
+    .ctop add .tf
+
+    # now build up the bottom
+    panedwindow .pwbottom -orient horizontal
+
+    # lower left, a text box over search bar, scroll bar to the right
+    # if we know window height, then that will set the lower text height, otherwise
+    # we set lower text height which will drive window height
+    if {[info exists geometry(main)]} {
+        frame .bleft -width $geometry(botwidth)
+    } else {
+        frame .bleft -width $geometry(botwidth) -height $geometry(botheight)
+    }
+    frame .bleft.top
+
+    button .bleft.top.search -text "Search" -command dosearch \
 	-font $uifont
-    pack .ctop.cdet.left.bot.search -side left -padx 5
-    set sstring .ctop.cdet.left.bot.sstring
+    pack .bleft.top.search -side left -padx 5
+    set sstring .bleft.top.sstring
     entry $sstring -width 20 -font $textfont -textvariable searchstring
     lappend entries $sstring
     trace add variable searchstring write incrsearch
     pack $sstring -side left -expand 1 -fill x
-    set ctext .ctop.cdet.left.ctext
+    set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font $textfont \
-	-width $geometry(ctextw) -height $geometry(ctexth) \
 	-yscrollcommand scrolltext -wrap none
-    scrollbar .ctop.cdet.left.sb -command "$ctext yview"
-    pack .ctop.cdet.left.sb -side right -fill y
+    scrollbar .bleft.sb -command "$ctext yview"
+    pack .bleft.top -side top -fill x
+    pack .bleft.sb -side right -fill y
     pack $ctext -side left -fill both -expand 1
-    .ctop.cdet add .ctop.cdet.left
     lappend bglist $ctext
     lappend fglist $ctext
 
@@ -620,36 +639,45 @@ proc makewindow {} {
     $ctext tag conf msep -font [concat $textfont bold]
     $ctext tag conf found -back yellow
 
-    frame .ctop.cdet.right
-    frame .ctop.cdet.right.mode
-    radiobutton .ctop.cdet.right.mode.patch -text "Patch" \
+    .pwbottom add .bleft
+
+    # lower right
+    frame .bright
+    frame .bright.mode
+    radiobutton .bright.mode.patch -text "Patch" \
 	-command reselectline -variable cmitmode -value "patch"
-    radiobutton .ctop.cdet.right.mode.tree -text "Tree" \
+    radiobutton .bright.mode.tree -text "Tree" \
 	-command reselectline -variable cmitmode -value "tree"
-    grid .ctop.cdet.right.mode.patch .ctop.cdet.right.mode.tree -sticky ew
-    pack .ctop.cdet.right.mode -side top -fill x
-    set cflist .ctop.cdet.right.cfiles
+    grid .bright.mode.patch .bright.mode.tree -sticky ew
+    pack .bright.mode -side top -fill x
+    set cflist .bright.cfiles
     set indent [font measure $mainfont "nn"]
-    text $cflist -width $geometry(cflistw) \
+    text $cflist \
 	-background $bgcolor -foreground $fgcolor \
 	-font $mainfont \
 	-tabs [list $indent [expr {2 * $indent}]] \
-	-yscrollcommand ".ctop.cdet.right.sb set" \
+	-yscrollcommand ".bright.sb set" \
 	-cursor [. cget -cursor] \
 	-spacing1 1 -spacing3 1
     lappend bglist $cflist
     lappend fglist $cflist
-    scrollbar .ctop.cdet.right.sb -command "$cflist yview"
-    pack .ctop.cdet.right.sb -side right -fill y
+    scrollbar .bright.sb -command "$cflist yview"
+    pack .bright.sb -side right -fill y
     pack $cflist -side left -fill both -expand 1
     $cflist tag configure highlight \
 	-background [$cflist cget -selectbackground]
     $cflist tag configure bold -font [concat $mainfont bold]
-    .ctop.cdet add .ctop.cdet.right
-    bind .ctop.cdet <Configure> {resizecdetpanes %W %w}
 
-    pack .ctop -side top -fill both -expand 1
+    .pwbottom add .bright
+    .ctop add .pwbottom
+
+    # restore window position if known
+    if {[info exists geometry(main)]} {
+        wm geometry . "$geometry(main)"
+    }
 
+    bind .pwbottom <Configure> {resizecdetpanes %W %w}
+    pack .ctop -fill both -expand 1
     bindall <1> {selcanvline %W %x %y}
     #bindall <B1-Motion> {selcanvline %W %x %y}
     bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
@@ -802,18 +830,16 @@ proc savestuff {w} {
 	puts $f [list set fgcolor $fgcolor]
 	puts $f [list set colors $colors]
 	puts $f [list set diffcolors $diffcolors]
-	puts $f "set geometry(width) [winfo width .ctop]"
-	puts $f "set geometry(height) [winfo height .ctop]"
-	puts $f "set geometry(canv1) [expr {[winfo width $canv]-2}]"
-	puts $f "set geometry(canv2) [expr {[winfo width $canv2]-2}]"
-	puts $f "set geometry(canv3) [expr {[winfo width $canv3]-2}]"
-	puts $f "set geometry(canvh) [expr {[winfo height $canv]-2}]"
-	set wid [expr {([winfo width $ctext] - 8) \
-			   / [font measure $textfont "0"]}]
-	puts $f "set geometry(ctextw) $wid"
-	set wid [expr {([winfo width $cflist] - 11) \
-			   / [font measure [$cflist cget -font] "0"]}]
-	puts $f "set geometry(cflistw) $wid"
+
+        puts $f "set geometry(main) [winfo geometry .]"
+	puts $f "set geometry(topwidth) [winfo width .tf]"
+	puts $f "set geometry(topheight) [winfo height .tf]"
+	puts $f "set geometry(canv) [expr {[winfo width $canv]-0}]"
+	puts $f "set geometry(canv2) [expr {[winfo width $canv2]-0}]"
+	puts $f "set geometry(canv3) [expr {[winfo width $canv3]-0}]"
+	puts $f "set geometry(botwidth) [winfo width .bleft]"
+	puts $f "set geometry(botheight) [winfo height .bleft]"
+
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $nextviewnum} {incr v} {
 	    if {$viewperm($v)} {
@@ -1402,7 +1428,7 @@ proc newview {ishighlight} {
     set newviewname($nextviewnum) "View $nextviewnum"
     set newviewperm($nextviewnum) 0
     set newviewargs($nextviewnum) [shellarglist $revtreeargs]
-    vieweditor $top $nextviewnum "Gitk view definition" 
+    vieweditor $top $nextviewnum "Gitk view definition"
 }
 
 proc editview {} {
@@ -3897,7 +3923,7 @@ proc selectline {l isnew} {
 	}
 	$ctext insert end "\n"
     }
- 
+
     set headers {}
     set olds [lindex $parentlist $l]
     if {[llength $olds] > 1} {
@@ -4006,7 +4032,7 @@ proc selnextpage {dir} {
         set l [expr $numcommits - 1]
     }
     unmarkmatches
-    selectline $l 1    
+    selectline $l 1
 }
 
 proc unselectline {} {
@@ -4043,11 +4069,11 @@ proc addtohistory {cmd} {
     }
     incr historyindex
     if {$historyindex > 1} {
-	.ctop.top.bar.leftbut conf -state normal
+	.tf.bar.leftbut conf -state normal
     } else {
-	.ctop.top.bar.leftbut conf -state disabled
+	.tf.bar.leftbut conf -state disabled
     }
-    .ctop.top.bar.rightbut conf -state disabled
+    .tf.bar.rightbut conf -state disabled
 }
 
 proc godo {elt} {
@@ -4067,10 +4093,10 @@ proc goback {} {
     if {$historyindex > 1} {
 	incr historyindex -1
 	godo [lindex $history [expr {$historyindex - 1}]]
-	.ctop.top.bar.rightbut conf -state normal
+	.tf.bar.rightbut conf -state normal
     }
     if {$historyindex <= 1} {
-	.ctop.top.bar.leftbut conf -state disabled
+	.tf.bar.leftbut conf -state disabled
     }
 }
 
@@ -4081,10 +4107,10 @@ proc goforw {} {
 	set cmd [lindex $history $historyindex]
 	incr historyindex
 	godo $cmd
-	.ctop.top.bar.leftbut conf -state normal
+	.tf.bar.leftbut conf -state normal
     }
     if {$historyindex >= [llength $history]} {
-	.ctop.top.bar.rightbut conf -state disabled
+	.tf.bar.rightbut conf -state disabled
     }
 }
 
@@ -4591,7 +4617,7 @@ proc searchmarkvisible {doall} {
 proc scrolltext {f0 f1} {
     global searchstring
 
-    .ctop.cdet.left.sb set $f0 $f1
+    .bleft.sb set $f0 $f1
     if {$searchstring ne {}} {
 	searchmarkvisible 0
     }
-- 
1.5.0.rc2.62.g874ea


--------------070502020008060203070903--
