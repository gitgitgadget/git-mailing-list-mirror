From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v4, ping] gitk: let you easily specify lines of context in diff view
Date: Sat, 11 Aug 2007 17:30:50 +0200
Message-ID: <11868462503722-git-send-email-prohaska@zib.de>
References: <11856503182381-git-send-email-prohaska@zib.de>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sat Aug 11 17:35:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJt02-0006zg-1F
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 17:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbXHKPfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbXHKPfF
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 11:35:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:61562 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbXHKPfE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 11:35:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7BFV47b010702;
	Sat, 11 Aug 2007 17:34:44 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7BFUo8a011264;
	Sat, 11 Aug 2007 17:30:50 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11856503182381-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55613>

More lines of context sometimes help to better understand a diff.
This patch introduces a text field above the box displaying the
blobdiffs. You can type in the number of lines of context that
you wish to view. The number of lines of context is initially
always set to 3.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 gitk |   41 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 2 deletions(-)

rebased to the current master, fixed one trailing whitespace.

Any chance to get this patch applied? It works for me.

    Steffen

diff --git a/gitk b/gitk
index f74ce51..2f86c7c 100755
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
1.5.3.rc4.31.g6adda
