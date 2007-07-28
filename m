From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v3] gitk: let you easily specify lines of context in diff view
Date: Sat, 28 Jul 2007 21:18:38 +0200
Message-ID: <11856503182381-git-send-email-prohaska@zib.de>
References: <11855366703782-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sat Jul 28 21:18:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEroN-0005sL-0b
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 21:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbXG1TSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 15:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbXG1TSn
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 15:18:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:44955 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbXG1TSn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 15:18:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6SJIdwl002129;
	Sat, 28 Jul 2007 21:18:39 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6SJIcTX029514;
	Sat, 28 Jul 2007 21:18:38 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <11855366703782-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54049>

More lines of context sometimes help to better understand a diff.
This patch introduces a text field above the box displaying the
blobdiffs. You can type in the number of lines of context that
you wish to view. The number of lines of context is initially
always set to 3.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 gitk |   41 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 2 deletions(-)

rebased to the current master.

    Steffen

diff --git a/gitk b/gitk
index f74ce51..670a162 100755
--- a/gitk
+++ b/gitk
@@ -517,6 +517,7 @@ proc makewindow {} {
     global textfont mainfont uifont tabstop
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
+    global diffcontextstring diffcontext
     global maincursor textcursor curtextcursor
     global rowctxmenu fakerowmenu mergemax wrapcomment
     global highlight_files gdttype
@@ -731,7 +732,16 @@ proc makewindow {} {
 	-command changediffdisp -variable diffelide -value {0 1}
     radiobutton .bleft.mid.new -text "New version" \
 	-command changediffdisp -variable diffelide -value {1 0}
-    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
+    label .bleft.mid.labeldiffcontext -text "      Lines of context: " \
+    -font $uifont
+    spinbox .bleft.mid.diffcontext -width 5 -font $textfont \
+    -from 1 -increment 1 -to 10000000 \
+    -validate all -validatecommand "diffcontextvalidate %P" \
+    -textvariable diffcontextstring
+    .bleft.mid.diffcontext set $diffcontext
+    trace add variable diffcontextstring write diffcontextchange
+    lappend entries .bleft.mid.diffcontext
+    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new .bleft.mid.labeldiffcontext .bleft.mid.diffcontext -side left
     set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-tabs "[expr {$tabstop * $charspc}]" \
@@ -4985,12 +4995,37 @@ proc gettreediffline {gdtf ids} {
     return 0
 }
 
+# empty strings or integers accepted
+proc diffcontextvalidate {v} {
+    if {[string length $v] == 0} {
+	return 1
+    }
+    if {[string is integer $v]} {
+	if {$v > 0} {
+	    return 1
+	}
+    }
+    return 0
+}
+
+proc diffcontextchange {n1 n2 op} {
+    global diffcontextstring diffcontext
+
+    if {[string is integer $diffcontextstring]} {
+        if {$diffcontextstring > 0} {
+            set diffcontext $diffcontextstring
+		    reselectline
+        }
+    }
+}
+
 proc getblobdiffs {ids} {
     global diffopts blobdifffd diffids env
     global diffinhdr treediffs
+    global diffcontext
 
     set env(GIT_DIFF_OPTS) $diffopts
-    if {[catch {set bdf [open [diffcmd $ids {-p -C --no-commit-id}] r]} err]} {
+    if {[catch {set bdf [open [diffcmd $ids "-p -C --no-commit-id -U$diffcontext"] r]} err]} {
 	puts "error getting diffs: $err"
 	return
     }
@@ -7646,6 +7681,8 @@ set markingmatches 0
 
 set optim_delay 16
 
+set diffcontext 3 
+
 set nextviewnum 1
 set curview 0
 set selectedview 0
-- 
1.5.3.rc3.45.g4c741
