From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: avoid a crash in Tk if the application is closed early
Date: 28 Feb 2009 00:19:02 +0000
Message-ID: <87hc2fe7m1.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 02:29:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdE1P-0001vo-Ow
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 02:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbZB1B2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 20:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbZB1B2O
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 20:28:14 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:44632 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753522AbZB1B2O (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 20:28:14 -0500
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1LdCv1-0003Rf-C6; Sat, 28 Feb 2009 00:19:03 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1LdCv0-0003vQ-VI; Sat, 28 Feb 2009 00:19:03 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id B9F3F51836; Sat, 28 Feb 2009 00:19:02 +0000 (GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111736>


    This evades Tk bug [2645457] that can lead to a crash in gitk if
    the application is closed while the commits are still being read
    from the git subprocess. By calling update to flush all the
    outstanding geometry events we avoid the chance of trying to map a
    deleted window.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 2b5265a..cd7ea2f 100755
--- a/gitk
+++ b/gitk
@@ -1795,6 +1795,7 @@ proc make_transient {window origin} {
 proc show_error {w top msg} {
     variable use_ttk
     set ttk [expr {$use_ttk ? "ttk" : ""}]
+    if {[wm state $top] eq "withdrawn"} { wm deiconify $top }
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
     ${ttk}::button $w.ok -default active -text [mc OK] -command "destroy $top"
@@ -10998,12 +10999,9 @@ proc init {args} {
     variable lserial 0
     variable isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
     setcoords
-    makewindow
-    # wait for the window to become visible
-    wm deiconify .
-    tkwait visibility .
+    wm withdraw .
     wm title . "[file tail $argv0]: [file tail [pwd]]"
-    readrefs
+    makewindow
 
     if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
         # create a view for the files/dirs specified on the command line
@@ -11034,11 +11032,20 @@ proc init {args} {
         }
     }
 
+    # wait for the window to become visible
+    wm deiconify .
+    tkwait visibility .
+
     if {[tk windowingsystem] eq "win32"} {
         focus -force .
         bind . <Control-F2> {console show}
     }
 
+    # flush all geometry events to prevent possible crash if someone exits
+    # during the following reads.
+    update
+
+    readrefs
     getcommits {}
 }
 
-- 
1.6.0.2.1172.ga5ed0
