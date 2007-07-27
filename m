From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v2] gitk: let you easily specify lines of context in diff view
Date: Fri, 27 Jul 2007 13:44:30 +0200
Message-ID: <11855366703782-git-send-email-prohaska@zib.de>
References: <18089.51584.704957.310331@cargo.ozlabs.ibm.com>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Fri Jul 27 13:44:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEOFJ-0000tg-E8
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 13:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259AbXG0Lof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 07:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbXG0Lof
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 07:44:35 -0400
Received: from mailer.zib.de ([130.73.108.11]:60634 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903AbXG0Loe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 07:44:34 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6RBiVOA018931;
	Fri, 27 Jul 2007 13:44:31 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6RBiV0I021170;
	Fri, 27 Jul 2007 13:44:31 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <18089.51584.704957.310331@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53919>

More lines of context sometimes help to better understand a diff.
This patch introduces a text field above the box displaying the
blobdiffs. You can type in the number of lines of context that
you wish to view. The number of lins ines of context is initially
always set to 3.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 gitk |   41 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 2 deletions(-)

I included the changes proposed by Paul. From my side, the patch
is ready to be applied.

    Steffen

diff --git a/gitk b/gitk
index 39e452a..9de9574 100755
--- a/gitk
+++ b/gitk
@@ -500,6 +500,7 @@ proc makewindow {} {
     global textfont mainfont uifont tabstop
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
+    global diffcontextstring diffcontext
     global maincursor textcursor curtextcursor
     global rowctxmenu fakerowmenu mergemax wrapcomment
     global highlight_files gdttype
@@ -714,7 +715,16 @@ proc makewindow {} {
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
@@ -4872,12 +4882,37 @@ proc gettreediffline {gdtf ids} {
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
-    if {[catch {set bdf [open [diffcmd $ids {-p -C}] r]} err]} {
+    if {[catch {set bdf [open [diffcmd $ids "-p -C -U$diffcontext"] r]} err]} {
 	puts "error getting diffs: $err"
 	return
     }
@@ -7537,6 +7572,8 @@ set markingmatches 0
 
 set optim_delay 16
 
+set diffcontext 3 
+
 set nextviewnum 1
 set curview 0
 set selectedview 0
-- 
1.5.3.rc3.21.g45610
