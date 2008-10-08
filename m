From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH 1/7] gitk: Enhance UI popup and accelerator handling.
Date: Wed,  8 Oct 2008 11:05:34 +0400
Message-ID: <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 09:08:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnT9w-00067l-0M
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbYJHHH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbYJHHH1
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:07:27 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:14103 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbYJHHHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:07:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3173789fkq.5
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1PIjYayXenf5MebkaBJp6fdHTlKk9TFvXYNzSYyW5dM=;
        b=wjWCBlWMJXw3Ex9HP4Vyy9i1ipgHH3UrIwqg4bFzZbqZmMlahR5seeWP4XBUBpcu3a
         nJFz188mr4o7z3UeGUnc471W6KKI7nkZZgsVXohQhxhSqbWSGxr9rzJp9FV+0nZidtAM
         mx+c1D72W5aCmFuX+nnLms8Fa2Hr2cmYq1MqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mvj4hINWviI4wNs01KhOndYBIAH852ckQ6dQRuPgwzzduOnIF6W2oeHTIPiRodVMwu
         WRXyzNYWJIDGboYB13sC2zdT25OplF21N8ei0v0DzrAF1a9A9aXiN/n8L3KXU7BxJFC3
         5ZlsuksGUI9IxeUjxntsXc54ZlksIb3Dz9DW0=
Received: by 10.181.24.14 with SMTP id b14mr5850858bkj.22.1223449641214;
        Wed, 08 Oct 2008 00:07:21 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id e17sm15096059fke.10.2008.10.08.00.07.19
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 00:07:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97775>

- Popups are supposed to be marked transient, otherwise
  the WM creates them in strange places. Besides, at
  least under kwin, transients are automatically kept
  above their parent.
- Accelerators for menu items should be listed directly
  on the items, to make them more discoverable.
- Some more accelerators are added, e.g. F4 for Edit View.
- Finally, dialogs can now be accepted or dismissed using
  the Return and Escape keys.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/gitk b/gitk
index e6c2a17..a4ef736 100755
--- a/gitk
+++ b/gitk
@@ -1710,22 +1710,24 @@ proc show_error {w top msg} {
     pack $w.ok -side bottom -fill x
     bind $top <Visibility> "grab $top; focus $top"
     bind $top <Key-Return> "destroy $top"
+    bind $top <Key-space>  "destroy $top"
+    bind $top <Key-Escape> "destroy $top"
     tkwait window $top
 }
 
-proc error_popup msg {
+proc error_popup {msg {owner .}} {
     set w .error
     toplevel $w
-    wm transient $w .
+    wm transient $w $owner
     show_error $w $w $msg
 }
 
-proc confirm_popup msg {
+proc confirm_popup {msg {owner .}} {
     global confirm_ok
     set confirm_ok 0
     set w .confirm
     toplevel $w
-    wm transient $w .
+    wm transient $w $owner
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
     button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
@@ -1733,6 +1735,9 @@ proc confirm_popup msg {
     button $w.cancel -text [mc Cancel] -command "destroy $w"
     pack $w.cancel -side right -fill x
     bind $w <Visibility> "grab $w; focus $w"
+    bind $w <Key-Return> "set confirm_ok 1; destroy $w"
+    bind $w <Key-space>  "set confirm_ok 1; destroy $w"
+    bind $w <Key-Escape> "destroy $w"
     tkwait window $w
     return $confirm_ok
 }
@@ -1767,22 +1772,28 @@ proc makewindow {} {
     global rprogitem rprogcoord rownumsel numcommits
     global have_tk85
 
+    if {[tk windowingsystem] eq {aqua}} {
+	set M1T Cmd
+    } else {
+	set M1T Ctrl
+    }
+
     menu .bar
     .bar add cascade -label [mc "File"] -menu .bar.file
     menu .bar.file
-    .bar.file add command -label [mc "Update"] -command updatecommits
-    .bar.file add command -label [mc "Reload"] -command reloadcommits
+    .bar.file add command -label [mc "Update"] -accelerator F5 -command updatecommits
+    .bar.file add command -label [mc "Reload"] -accelerator $M1T-F5 -command reloadcommits
     .bar.file add command -label [mc "Reread references"] -command rereadrefs
-    .bar.file add command -label [mc "List references"] -command showrefs
-    .bar.file add command -label [mc "Quit"] -command doquit
+    .bar.file add command -label [mc "List references"] -accelerator F2 -command showrefs
+    .bar.file add command -label [mc "Quit"] -accelerator $M1T-Q -command doquit
     menu .bar.edit
     .bar add cascade -label [mc "Edit"] -menu .bar.edit
     .bar.edit add command -label [mc "Preferences"] -command doprefs
 
     menu .bar.view
     .bar add cascade -label [mc "View"] -menu .bar.view
-    .bar.view add command -label [mc "New view..."] -command {newview 0}
-    .bar.view add command -label [mc "Edit view..."] -command editview \
+    .bar.view add command -label [mc "New view..."] -accelerator Shift-F4 -command {newview 0}
+    .bar.view add command -label [mc "Edit view..."] -accelerator F4 -command editview \
 	-state disabled
     .bar.view add command -label [mc "Delete view"] -command delview -state disabled
     .bar.view add separator
@@ -2146,7 +2157,12 @@ proc makewindow {} {
     bindkey <Key-Return> {dofind 1 1}
     bindkey ? {dofind -1 1}
     bindkey f nextfile
-    bindkey <F5> updatecommits
+    bind . <F5> updatecommits
+    bind . <$M1B-F5> reloadcommits
+    bind . <F2> showrefs
+    bind . <Shift-F4> {newview 0}
+    catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }
+    bind . <F4> edit_or_newview
     bind . <$M1B-q> doquit
     bind . <$M1B-f> {dofind 1 1}
     bind . <$M1B-g> {dofind 1 0}
@@ -2456,6 +2472,7 @@ proc about {} {
     }
     toplevel $w
     wm title $w [mc "About gitk"]
+    wm transient $w .
     message $w.m -text [mc "
 Gitk - a commit viewer for git
 
@@ -2484,10 +2501,10 @@ proc keys {} {
     }
     toplevel $w
     wm title $w [mc "Gitk key bindings"]
+    wm transient $w .
     message $w.m -text "
 [mc "Gitk key bindings:"]
 
-[mc "<%s-Q>		Quit" $M1T]
 [mc "<Home>		Move to first commit"]
 [mc "<End>		Move to last commit"]
 [mc "<Up>, p, i	Move up one commit"]
@@ -2521,11 +2538,11 @@ proc keys {} {
 [mc "<%s-plus>	Increase font size" $M1T]
 [mc "<%s-KP->	Decrease font size" $M1T]
 [mc "<%s-minus>	Decrease font size" $M1T]
-[mc "<F5>		Update"]
 " \
 	    -justify left -bg white -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
     button $w.ok -text [mc "Close"] -command "destroy $w" -default active
+    bind $w <Key-Escape> [list destroy $w]
     pack $w.ok -side bottom
     bind $w <Visibility> "focus $w.ok"
     bind $w <Key-Escape> "destroy $w"
@@ -3171,6 +3188,16 @@ proc newview {ishighlight} {
     vieweditor $top $nextviewnum [mc "Gitk view definition"]
 }
 
+proc edit_or_newview {} {
+    global curview
+
+    if {$curview > 0} {
+	editview
+    } else {
+	newview 0
+    }
+}
+
 proc editview {} {
     global curview
     global viewname viewperm newviewname newviewperm
@@ -3193,6 +3220,7 @@ proc vieweditor {top n title} {
 
     toplevel $top
     wm title $top $title
+    wm transient $top .
     label $top.nl -text [mc "Name"]
     entry $top.name -width 20 -textvariable newviewname($n)
     grid $top.nl $top.name -sticky w -pady 5
@@ -3229,6 +3257,7 @@ proc vieweditor {top n title} {
     frame $top.buts
     button $top.buts.ok -text [mc "OK"] -command [list newviewok $top $n]
     button $top.buts.can -text [mc "Cancel"] -command [list destroy $top]
+    bind $top <Escape> [list destroy $top]
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -3261,9 +3290,7 @@ proc newviewok {top n} {
     if {[catch {
 	set newargs [shellsplit $newviewargs($n)]
     } err]} {
-	error_popup "[mc "Error in commit selection arguments:"] $err"
-	wm raise $top
-	focus $top
+	error_popup "[mc "Error in commit selection arguments:"] $err" $top
 	return
     }
     set files {}
@@ -7367,6 +7394,7 @@ proc mkpatch {} {
     set patchtop $top
     catch {destroy $top}
     toplevel $top
+    wm transient $top .
     label $top.title -text [mc "Generate patch"]
     grid $top.title - -pady 10
     label $top.from -text [mc "From:"]
@@ -7397,6 +7425,8 @@ proc mkpatch {} {
     frame $top.buts
     button $top.buts.gen -text [mc "Generate"] -command mkpatchgo
     button $top.buts.can -text [mc "Cancel"] -command mkpatchcan
+    bind $top <Key-Return> mkpatchgo
+    bind $top <Key-Escape> mkpatchcan
     grid $top.buts.gen $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -7431,7 +7461,7 @@ proc mkpatchgo {} {
     set cmd [lrange $cmd 1 end]
     lappend cmd >$fname &
     if {[catch {eval exec $cmd} err]} {
-	error_popup "[mc "Error creating patch:"] $err"
+	error_popup "[mc "Error creating patch:"] $err" $patchtop
     }
     catch {destroy $patchtop}
     unset patchtop
@@ -7451,6 +7481,7 @@ proc mktag {} {
     set mktagtop $top
     catch {destroy $top}
     toplevel $top
+    wm transient $top .
     label $top.title -text [mc "Create tag"]
     grid $top.title - -pady 10
     label $top.id -text [mc "ID:"]
@@ -7468,6 +7499,8 @@ proc mktag {} {
     frame $top.buts
     button $top.buts.gen -text [mc "Create"] -command mktaggo
     button $top.buts.can -text [mc "Cancel"] -command mktagcan
+    bind $top <Key-Return> mktaggo
+    bind $top <Key-Escape> mktagcan
     grid $top.buts.gen $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -7481,17 +7514,17 @@ proc domktag {} {
     set id [$mktagtop.sha1 get]
     set tag [$mktagtop.tag get]
     if {$tag == {}} {
-	error_popup [mc "No tag name specified"]
+	error_popup [mc "No tag name specified"] $mktagtop
 	return
     }
     if {[info exists tagids($tag)]} {
-	error_popup [mc "Tag \"%s\" already exists" $tag]
+	error_popup [mc "Tag \"%s\" already exists" $tag] $mktagtop
 	return
     }
     if {[catch {
 	exec git tag $tag $id
     } err]} {
-	error_popup "[mc "Error creating tag:"] $err"
+	error_popup "[mc "Error creating tag:"] $err" $mktagtop
 	return
     }
 
@@ -7501,6 +7534,7 @@ proc domktag {} {
     addedtag $id
     dispneartags 0
     run refill_reflist
+    return 1
 }
 
 proc redrawtags {id} {
@@ -7539,7 +7573,7 @@ proc mktagcan {} {
 }
 
 proc mktaggo {} {
-    domktag
+    if {![domktag]} return
     mktagcan
 }
 
@@ -7550,6 +7584,7 @@ proc writecommit {} {
     set wrcomtop $top
     catch {destroy $top}
     toplevel $top
+    wm transient $top .
     label $top.title -text [mc "Write commit to file"]
     grid $top.title - -pady 10
     label $top.id -text [mc "ID:"]
@@ -7571,6 +7606,8 @@ proc writecommit {} {
     frame $top.buts
     button $top.buts.gen -text [mc "Write"] -command wrcomgo
     button $top.buts.can -text [mc "Cancel"] -command wrcomcan
+    bind $top <Key-Return> wrcomgo
+    bind $top <Key-Escape> wrcomcan
     grid $top.buts.gen $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -7585,7 +7622,7 @@ proc wrcomgo {} {
     set cmd "echo $id | [$wrcomtop.cmd get]"
     set fname [$wrcomtop.fname get]
     if {[catch {exec sh -c $cmd >$fname &} err]} {
-	error_popup "[mc "Error writing commit:"] $err"
+	error_popup "[mc "Error writing commit:"] $err" $wrcomtop
     }
     catch {destroy $wrcomtop}
     unset wrcomtop
@@ -7604,6 +7641,7 @@ proc mkbranch {} {
     set top .makebranch
     catch {destroy $top}
     toplevel $top
+    wm transient $top .
     label $top.title -text [mc "Create new branch"]
     grid $top.title - -pady 10
     label $top.id -text [mc "ID:"]
@@ -7617,6 +7655,8 @@ proc mkbranch {} {
     frame $top.buts
     button $top.buts.go -text [mc "Create"] -command [list mkbrgo $top]
     button $top.buts.can -text [mc "Cancel"] -command "catch {destroy $top}"
+    bind $top <Key-Return> [list mkbrgo $top]
+    bind $top <Key-Escape> "catch {destroy $top}"
     grid $top.buts.go $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -7630,7 +7670,7 @@ proc mkbrgo {top} {
     set name [$top.name get]
     set id [$top.sha1 get]
     if {$name eq {}} {
-	error_popup [mc "Please specify a name for the new branch"]
+	error_popup [mc "Please specify a name for the new branch"] $top
 	return
     }
     catch {destroy $top}
@@ -7723,6 +7763,7 @@ proc resethead {} {
     button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
     pack $w.ok -side left -fill x -padx 20 -pady 20
     button $w.cancel -text [mc Cancel] -command "destroy $w"
+    bind $w <Key-Escape> [list destroy $w]
     pack $w.cancel -side right -fill x -padx 20 -pady 20
     bind $w <Visibility> "grab $w; focus $w"
     tkwait window $w
@@ -7879,6 +7920,7 @@ proc showrefs {} {
     }
     toplevel $top
     wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
+    wm transient $top .
     text $top.list -background $bgcolor -foreground $fgcolor \
 	-selectbackground $selectbgcolor -font mainfont \
 	-xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
@@ -7900,6 +7942,7 @@ proc showrefs {} {
     pack $top.f.l -side left
     grid $top.f - -sticky ew -pady 2
     button $top.close -command [list destroy $top] -text [mc "Close"]
+    bind $top <Key-Escape> [list destroy $top]
     grid $top.close -
     grid columnconfigure $top 0 -weight 1
     grid rowconfigure $top 0 -weight 1
@@ -9205,6 +9248,7 @@ proc mkfontdisp {font top which} {
 
 proc choosefont {font which} {
     global fontparam fontlist fonttop fontattr
+    global prefstop
 
     set fontparam(which) $which
     set fontparam(font) $font
@@ -9218,6 +9262,7 @@ proc choosefont {font which} {
 	font create sample
 	eval font config sample [font actual $font]
 	toplevel $top
+	wm transient $top $prefstop
 	wm title $top [mc "Gitk font chooser"]
 	label $top.l -textvariable fontparam(which)
 	pack $top.l -side top
@@ -9251,6 +9296,8 @@ proc choosefont {font which} {
 	frame $top.buts
 	button $top.buts.ok -text [mc "OK"] -command fontok -default active
 	button $top.buts.can -text [mc "Cancel"] -command fontcan -default normal
+	bind $top <Key-Return> fontok
+	bind $top <Key-Escape> fontcan
 	grid $top.buts.ok $top.buts.can
 	grid columnconfigure $top.buts 0 -weight 1 -uniform a
 	grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -9332,6 +9379,7 @@ proc doprefs {} {
     }
     toplevel $top
     wm title $top [mc "Gitk preferences"]
+    wm transient $top .
     label $top.ldisp -text [mc "Commit list display options"]
     grid $top.ldisp - -sticky w -pady 10
     label $top.spacer -text " "
@@ -9419,6 +9467,8 @@ proc doprefs {} {
     frame $top.buts
     button $top.buts.ok -text [mc "OK"] -command prefsok -default active
     button $top.buts.can -text [mc "Cancel"] -command prefscan -default normal
+    bind $top <Key-Return> prefsok
+    bind $top <Key-Escape> prefscan
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
-- 
1.6.0.20.g6148bc
