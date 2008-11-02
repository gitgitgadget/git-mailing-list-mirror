From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 6/6] gitk: Explicitly position popup windows.
Date: Sun,  2 Nov 2008 21:59:49 +0300
Message-ID: <1225652389-22082-7-git-send-email-angavrilov@gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-2-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-3-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-4-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-5-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-6-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 20:03:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwiEg-00069X-6w
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 20:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbYKBTCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 14:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754286AbYKBTCF
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 14:02:05 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:13051 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbYKBTCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 14:02:01 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2460100fkq.5
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 11:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fKGvDF7icXJ5DYGM9Ff0u3ZzuY4uMo6GrQCiba1HW6I=;
        b=hWnXmNUEcjX2tVnYGril8puQ/eeqV+Sl9WRxCui76VMtTrm6s4KK9X+wWmtbM7QUAf
         G45CTzPUyPuV/iIZRotMaFvAVUtbitQetLVznKnoK1/x9vTNJTjUsrnkghTJrJ+GKZU9
         cEtw4+EZtM0609UuuKuw9b3jDjuWZqDb7jk/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HryYvlxIdPMMJDputLcibAgjiTJwCXNKkYnCdPamzLVXQTl1yV/iDpfZs2+dBIYUjh
         NneYPI077FptLd+zSQZaoc6bv8z504MBUBunp+BgeDGvpOLOQyYiXvebcpsN4QlIhF1k
         +euRTnOxc6yN+TpAa+dg0foKxGH7ef0W1ylfY=
Received: by 10.181.33.18 with SMTP id l18mr3913220bkj.192.1225652518345;
        Sun, 02 Nov 2008 11:01:58 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm8536420fks.6.2008.11.02.11.01.56
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 11:01:57 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1225652389-22082-6-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99868>

For some reason, on Windows all transient windows are placed
in the upper left corner of the screen. Thus, it is necessary
to explicitly position the windows relative to their parent.
For simplicity this patch uses the function that is used
internally by Tk dialogs.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I wrapped the call to tk::PlaceWindow in a
	helper function to minimize the number of
	places to change if something happens to it.
	
	-- Alexander

 gitk |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 5b4eaa2..7d153a3 100755
--- a/gitk
+++ b/gitk
@@ -1739,7 +1739,13 @@ proc removehead {id name} {
     unset headids($name)
 }
 
-proc show_error {w top msg} {
+proc center_window {window origin} {
+    # Use a handy function from Tk. Note that it
+    # calls 'update' to figure out dimensions.
+    tk::PlaceWindow $window widget $origin
+}
+
+proc show_error {w top msg {owner {}}} {
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
     button $w.ok -text [mc OK] -command "destroy $top"
@@ -1748,6 +1754,9 @@ proc show_error {w top msg} {
     bind $top <Key-Return> "destroy $top"
     bind $top <Key-space>  "destroy $top"
     bind $top <Key-Escape> "destroy $top"
+    if {$owner ne {}} {
+	center_window $top $owner
+    }
     tkwait window $top
 }
 
@@ -1755,7 +1764,7 @@ proc error_popup {msg {owner .}} {
     set w .error
     toplevel $w
     wm transient $w $owner
-    show_error $w $w $msg
+    show_error $w $w $msg $owner
 }
 
 proc confirm_popup {msg {owner .}} {
@@ -1774,6 +1783,7 @@ proc confirm_popup {msg {owner .}} {
     bind $w <Key-Return> "set confirm_ok 1; destroy $w"
     bind $w <Key-space>  "set confirm_ok 1; destroy $w"
     bind $w <Key-Escape> "destroy $w"
+    center_window $w $owner
     tkwait window $w
     return $confirm_ok
 }
@@ -2572,6 +2582,7 @@ Use and redistribute under the terms of the GNU General Public License"] \
     bind $w <Visibility> "focus $w.ok"
     bind $w <Key-Escape> "destroy $w"
     bind $w <Key-Return> "destroy $w"
+    center_window $w .
 }
 
 proc keys {} {
@@ -2635,6 +2646,7 @@ proc keys {} {
     bind $w <Visibility> "focus $w.ok"
     bind $w <Key-Escape> "destroy $w"
     bind $w <Key-Return> "destroy $w"
+    center_window $w .
 }
 
 # Procedures for manipulating the file list window at the
@@ -3687,6 +3699,7 @@ proc vieweditor {top n title} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid columnconfigure $top.buts 2 -weight 1 -uniform a
     pack $top.buts -in $top -side top -fill x
+    center_window $top .
     focus $top.t
 }
 
@@ -7950,6 +7963,7 @@ proc mkpatch {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.fname
+    center_window $top .
 }
 
 proc mkpatchrev {} {
@@ -8024,6 +8038,7 @@ proc mktag {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.tag
+    center_window $top .
 }
 
 proc domktag {} {
@@ -8131,6 +8146,7 @@ proc writecommit {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.fname
+    center_window $top .
 }
 
 proc wrcomgo {} {
@@ -8181,6 +8197,7 @@ proc mkbranch {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.name
+    center_window $top .
 }
 
 proc mkbrgo {top} {
@@ -8341,6 +8358,7 @@ proc resethead {} {
     bind $w <Key-Escape> [list destroy $w]
     pack $w.cancel -side right -fill x -padx 20 -pady 20
     bind $w <Visibility> "grab $w; focus $w"
+    center_window $w .
     tkwait window $w
     if {!$confirm_ok} return
     if {[catch {set fd [open \
@@ -8526,6 +8544,7 @@ proc showrefs {} {
     bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
     set reflist {}
     refill_reflist
+    center_window $top .
 }
 
 proc sel_reflist {w x y} {
@@ -9878,6 +9897,7 @@ proc choosefont {font which} {
 	grid columnconfigure $top.buts 1 -weight 1 -uniform a
 	pack $top.buts -side bottom -fill x
 	trace add variable fontparam write chg_fontparam
+	center_window $top $prefstop
     } else {
 	raise $top
 	$top.c itemconf text -text $which
@@ -10060,6 +10080,7 @@ proc doprefs {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - - -pady 10 -sticky ew
     bind $top <Visibility> "focus $top.buts.ok"
+    center_window $top .
 }
 
 proc choose_extdiff {} {
-- 
1.6.0.3.15.gb8d36
