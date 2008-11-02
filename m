From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 2/6] gitk: Make gitk dialog windows transient.
Date: Sun,  2 Nov 2008 21:59:45 +0300
Message-ID: <1225652389-22082-3-git-send-email-angavrilov@gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-2-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 20:03:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwiED-0005yD-QS
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 20:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYKBTBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 14:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbYKBTBw
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 14:01:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:10442 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbYKBTBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 14:01:50 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1851909fgg.17
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 11:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VIpiGyl3u8MnpZjTZFVw4IGq0GXua6Xbz//7AZqU/VM=;
        b=tsev2tAW3AidfibH5hmR0M9foUBwKJpgpw8URF+E9dK+jkhFhMIPHVzOn3VnPBaJ4z
         2edrnscdNedpqtPxLVZReVLhwLBwpC8zsjUbDU9G2eJHcoqLOOEvPHOkSLCPEKhC0V80
         fgJds5F1NOpsVJo94Yeg7YQtnyNB5hHXRtR9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UfdWQ2dkflEqM+A6fO/U+VeZbRIBOFJ35BUL0QnHOnWV6UDBfLdaTQ1NbdiaIotQA+
         lF8pOtWk5uEkbofrdll1CbBGvbQfdRA/TJIJidBGnnA6QT/CzmdwAuoFNZa51XibiOsp
         cGvALf66nMN8LXi1EJHhoVPjkXgrndFCuBfpM=
Received: by 10.181.239.8 with SMTP id q8mr3929524bkr.109.1225652508542;
        Sun, 02 Nov 2008 11:01:48 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm8536420fks.6.2008.11.02.11.01.45
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 11:01:47 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1225652389-22082-2-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99863>

Transient windows are always kept above their parent,
and don't occupy any space in the taskbar, which is useful
for dialogs. Also, when transient is used, it is important
to bind windows to the correct parent.

This commit adds transient annotations to all dialogs,
ensures usage of the correct parent for error and
confirmation popups, and, as a side job, makes gitk
preserve the create tag dialog window in case of errors.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   46 ++++++++++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/gitk b/gitk
index edef9e2..41d3d2d 100755
--- a/gitk
+++ b/gitk
@@ -1751,19 +1751,19 @@ proc show_error {w top msg} {
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
@@ -2546,6 +2546,7 @@ proc about {} {
     }
     toplevel $w
     wm title $w [mc "About gitk"]
+    wm transient $w .
     message $w.m -text [mc "
 Gitk - a commit viewer for git
 
@@ -2574,6 +2575,7 @@ proc keys {} {
     }
     toplevel $w
     wm title $w [mc "Gitk key bindings"]
+    wm transient $w .
     message $w.m -text "
 [mc "Gitk key bindings:"]
 
@@ -3503,6 +3505,7 @@ proc vieweditor {top n title} {
 
     toplevel $top
     wm title $top $title
+    wm transient $top .
     label $top.nl -text [mc "Name"]
     entry $top.name -width 20 -textvariable newviewname($n)
     grid $top.nl $top.name -sticky w -pady 5
@@ -3572,9 +3575,7 @@ proc newviewok {top n} {
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
@@ -7770,6 +7771,7 @@ proc mkpatch {} {
     set patchtop $top
     catch {destroy $top}
     toplevel $top
+    wm transient $top .
     label $top.title -text [mc "Generate patch"]
     grid $top.title - -pady 10
     label $top.from -text [mc "From:"]
@@ -7836,7 +7838,7 @@ proc mkpatchgo {} {
     set cmd [lrange $cmd 1 end]
     lappend cmd >$fname &
     if {[catch {eval exec $cmd} err]} {
-	error_popup "[mc "Error creating patch:"] $err"
+	error_popup "[mc "Error creating patch:"] $err" $patchtop
     }
     catch {destroy $patchtop}
     unset patchtop
@@ -7856,6 +7858,7 @@ proc mktag {} {
     set mktagtop $top
     catch {destroy $top}
     toplevel $top
+    wm transient $top .
     label $top.title -text [mc "Create tag"]
     grid $top.title - -pady 10
     label $top.id -text [mc "ID:"]
@@ -7888,18 +7891,18 @@ proc domktag {} {
     set id [$mktagtop.sha1 get]
     set tag [$mktagtop.tag get]
     if {$tag == {}} {
-	error_popup [mc "No tag name specified"]
-	return
+	error_popup [mc "No tag name specified"] $mktagtop
+	return 0
     }
     if {[info exists tagids($tag)]} {
-	error_popup [mc "Tag \"%s\" already exists" $tag]
-	return
+	error_popup [mc "Tag \"%s\" already exists" $tag] $mktagtop
+	return 0
     }
     if {[catch {
 	exec git tag $tag $id
     } err]} {
-	error_popup "[mc "Error creating tag:"] $err"
-	return
+	error_popup "[mc "Error creating tag:"] $err" $mktagtop
+	return 0
     }
 
     set tagids($tag) $id
@@ -7908,6 +7911,7 @@ proc domktag {} {
     addedtag $id
     dispneartags 0
     run refill_reflist
+    return 1
 }
 
 proc redrawtags {id} {
@@ -7946,7 +7950,7 @@ proc mktagcan {} {
 }
 
 proc mktaggo {} {
-    domktag
+    if {![domktag]} return
     mktagcan
 }
 
@@ -7957,6 +7961,7 @@ proc writecommit {} {
     set wrcomtop $top
     catch {destroy $top}
     toplevel $top
+    wm transient $top .
     label $top.title -text [mc "Write commit to file"]
     grid $top.title - -pady 10
     label $top.id -text [mc "ID:"]
@@ -7994,7 +7999,7 @@ proc wrcomgo {} {
     set cmd "echo $id | [$wrcomtop.cmd get]"
     set fname [$wrcomtop.fname get]
     if {[catch {exec sh -c $cmd >$fname &} err]} {
-	error_popup "[mc "Error writing commit:"] $err"
+	error_popup "[mc "Error writing commit:"] $err" $wrcomtop
     }
     catch {destroy $wrcomtop}
     unset wrcomtop
@@ -8013,6 +8018,7 @@ proc mkbranch {} {
     set top .makebranch
     catch {destroy $top}
     toplevel $top
+    wm transient $top .
     label $top.title -text [mc "Create new branch"]
     grid $top.title - -pady 10
     label $top.id -text [mc "ID:"]
@@ -8044,12 +8050,12 @@ proc mkbrgo {top} {
     set cmdargs {}
     set old_id {}
     if {$name eq {}} {
-	error_popup [mc "Please specify a name for the new branch"]
+	error_popup [mc "Please specify a name for the new branch"] $top
 	return
     }
     if {[info exists headids($name)]} {
 	if {![confirm_popup [mc \
-		"Branch '%s' already exists. Overwrite?" $name]]} {
+		"Branch '%s' already exists. Overwrite?" $name] $top]} {
 	    return
 	}
 	set old_id $headids($name)
@@ -8310,6 +8316,7 @@ proc showrefs {} {
     }
     toplevel $top
     wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
+    wm transient $top .
     text $top.list -background $bgcolor -foreground $fgcolor \
 	-selectbackground $selectbgcolor -font mainfont \
 	-xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
@@ -9637,6 +9644,7 @@ proc mkfontdisp {font top which} {
 
 proc choosefont {font which} {
     global fontparam fontlist fonttop fontattr
+    global prefstop
 
     set fontparam(which) $which
     set fontparam(font) $font
@@ -9650,6 +9658,7 @@ proc choosefont {font which} {
 	font create sample
 	eval font config sample [font actual $font]
 	toplevel $top
+	wm transient $top $prefstop
 	wm title $top [mc "Gitk font chooser"]
 	label $top.l -textvariable fontparam(which)
 	pack $top.l -side top
@@ -9766,6 +9775,7 @@ proc doprefs {} {
     }
     toplevel $top
     wm title $top [mc "Gitk preferences"]
+    wm transient $top .
     label $top.ldisp -text [mc "Commit list display options"]
     grid $top.ldisp - -sticky w -pady 10
     label $top.spacer -text " "
-- 
1.6.0.3.15.gb8d36
