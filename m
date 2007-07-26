From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] gitk: let you easily specify lines of context in diff view
Date: Thu, 26 Jul 2007 09:59:29 +0200
Message-ID: <11854367692095-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Jul 26 10:00:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDyGN-0000wI-LH
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 10:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbXGZH7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756829AbXGZH7x
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:59:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:55815 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932641AbXGZH7w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 03:59:52 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6Q7xTn9015543;
	Thu, 26 Jul 2007 09:59:29 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6Q7xTBB011086;
	Thu, 26 Jul 2007 09:59:29 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53804>

More lines of context sometimes help to better understand a diff.
This patch introduces a text field above the box displaying the
blobdiffs. You can type in the number of lines of context that
you wish to view.

Minor improvements are needed:
   * The value you type in is only used on the next update.
   * lines of context is initially always 3.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 gitk |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

The patch may need some polishing. I know some tcl but this is the 
first time I tried tk:
   * I initialized diffcontext globally, ok?
   * I don't know how to update the view after entering a new value. 
  
    Steffen

diff --git a/gitk b/gitk
index 39e452a..4e9acff 100755
--- a/gitk
+++ b/gitk
@@ -500,6 +500,7 @@ proc makewindow {} {
     global textfont mainfont uifont tabstop
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
+    global diffcontextstring
     global maincursor textcursor curtextcursor
     global rowctxmenu fakerowmenu mergemax wrapcomment
     global highlight_files gdttype
@@ -714,7 +715,12 @@ proc makewindow {} {
 	-command changediffdisp -variable diffelide -value {0 1}
     radiobutton .bleft.mid.new -text "New version" \
 	-command changediffdisp -variable diffelide -value {1 0}
-    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
+    label .bleft.mid.labeldiffcontext -text "      Lines of context: " \
+    -font $uifont
+    entry .bleft.mid.diffcontext -width 5 -font $textfont -textvariable diffcontextstring
+    trace add variable diffcontextstring write diffcontextchange
+    lappend entries .bleft.mid.diffcontext
+    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new .bleft.mid.labeldiffcontext .bleft.mid.diffcontext -side left
     set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-tabs "[expr {$tabstop * $charspc}]" \
@@ -4872,12 +4878,25 @@ proc gettreediffline {gdtf ids} {
     return 0
 }
 
+proc diffcontextchange {n1 n2 op} {
+    global diffcontextstring diffcontext
+
+    if {[string is integer $diffcontextstring]} {
+        if {$diffcontextstring > 0} {
+            set diffcontext $diffcontextstring
+# TODO: need to trigger update of diff display
+# tried dodiffindex but that corrupted the history view
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
@@ -7537,6 +7556,8 @@ set markingmatches 0
 
 set optim_delay 16
 
+set diffcontext 3 
+
 set nextviewnum 1
 set curview 0
 set selectedview 0
-- 
1.5.3.rc3.20.g06b4
