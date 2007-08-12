From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v5] gitk: let you easily specify lines of context in diff view
Date: Sun, 12 Aug 2007 12:05:46 +0200
Message-ID: <11869131461127-git-send-email-prohaska@zib.de>
References: <AC6A824F-E268-41AE-823B-2C01D78FAF30@zib.de>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sun Aug 12 12:06:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKAKd-0000ca-G4
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 12:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761863AbXHLKF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 06:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756742AbXHLKFz
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 06:05:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:39313 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159AbXHLKFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 06:05:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7CA5kEu021978;
	Sun, 12 Aug 2007 12:05:46 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7CA5k3k020040;
	Sun, 12 Aug 2007 12:05:46 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <AC6A824F-E268-41AE-823B-2C01D78FAF30@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55671>

More lines of context sometimes help to better understand a diff.
This patch introduces a text field above the box displaying the
blobdiffs. You can type in the number of lines of context that
you wish to view. The number of lines of context is saved to
~/.gitk.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 gitk |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 1103baf..4366c7f 100755
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
@@ -731,7 +732,17 @@ proc makewindow {} {
 	-command changediffdisp -variable diffelide -value {0 1}
     radiobutton .bleft.mid.new -text "New version" \
 	-command changediffdisp -variable diffelide -value {1 0}
+    label .bleft.mid.labeldiffcontext -text "      Lines of context: " \
+	-font $uifont
     pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
+    spinbox .bleft.mid.diffcontext -width 5 -font $textfont \
+	-from 1 -increment 1 -to 10000000 \
+	-validate all -validatecommand "diffcontextvalidate %P" \
+	-textvariable diffcontextstring
+    .bleft.mid.diffcontext set $diffcontext
+    trace add variable diffcontextstring write diffcontextchange
+    lappend entries .bleft.mid.diffcontext
+    pack .bleft.mid.labeldiffcontext .bleft.mid.diffcontext -side left
     set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-tabs "[expr {$tabstop * $charspc}]" \
@@ -968,7 +979,7 @@ proc savestuff {w} {
     global maxwidth showneartags showlocalchanges
     global viewname viewfiles viewargs viewperm nextviewnum
     global cmitmode wrapcomment
-    global colors bgcolor fgcolor diffcolors selectbgcolor
+    global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -989,6 +1000,7 @@ proc savestuff {w} {
 	puts $f [list set fgcolor $fgcolor]
 	puts $f [list set colors $colors]
 	puts $f [list set diffcolors $diffcolors]
+	puts $f [list set diffcontext $diffcontext]
 	puts $f [list set selectbgcolor $selectbgcolor]
 
 	puts $f "set geometry(main) [wm geometry .]"
@@ -4986,12 +4998,29 @@ proc gettreediffline {gdtf ids} {
     return 0
 }
 
+# empty string or positive integer
+proc diffcontextvalidate {v} {
+    return [regexp {^(|[1-9][0-9]*)$} $v]
+}
+
+proc diffcontextchange {n1 n2 op} {
+    global diffcontextstring diffcontext
+
+    if {[string is integer -strict $diffcontextstring]} {
+	if {$diffcontextstring > 0} {
+	    set diffcontext $diffcontextstring
+	    reselectline
+	}
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
@@ -7569,6 +7598,7 @@ set colors {green red blue magenta darkgrey brown orange}
 set bgcolor white
 set fgcolor black
 set diffcolors {red "#00a000" blue}
+set diffcontext 3
 set selectbgcolor gray85
 
 catch {source ~/.gitk}
-- 
1.5.3.rc4.762.g17d7
