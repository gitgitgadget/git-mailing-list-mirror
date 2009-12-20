From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: handle really long error messages in updateindex.
Date: Sun, 20 Dec 2009 02:02:03 +0000
Message-ID: <87bphqui9t.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 23 10:55:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNNwF-0003XW-PX
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 10:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbZLWJzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 04:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754527AbZLWJzV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 04:55:21 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:58145 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754116AbZLWJzU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2009 04:55:20 -0500
Received: from [172.23.170.137] (helo=anti-virus01-08)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NNNw5-0007QW-W9; Wed, 23 Dec 2009 09:55:18 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1NNNw0-0004Hc-7U; Wed, 23 Dec 2009 09:55:12 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id A3F1213D389; Wed, 23 Dec 2009 09:55:11 +0000 (GMT)
Cc: <msysgit@googlegroups.com>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (usg-unix-v)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135618>

 As reported to msysGit (bug #340) it is possible to get some very long
 error messages when updating the index. The use of a label to display
 this prevents scrolling the output. This patch replaces the label with
 a scrollable text widget configured to look like a label.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 lib/index.tcl |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index d33896a..0b58bd8 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -14,29 +14,31 @@ proc _close_updateindex {fd after} {
 		toplevel $w
 		wm title $w [strcat "[appname] ([reponame]): " [mc "Index Error"]]
 		wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
-		pack [label $w.msg \
-			-justify left \
-			-anchor w \
-			-text [strcat \
-				[mc "Updating the Git index failed.  A rescan will be automatically started to resynchronize git-gui."] \
-				"\n\n$err"] \
-			] -anchor w
-
-		frame $w.buttons
-		button $w.buttons.continue \
+		set s [mc "Updating the Git index failed.  A rescan will be automatically started to resynchronize git-gui."]
+		text $w.msg -yscrollcommand [list $w.vs set] \
+			-width [string length $s] -relief flat \
+			-borderwidth 0 -highlightthickness 0 \
+			-background [$w cget -background]
+		$w.msg tag configure bold -font font_uibold -justify center
+		scrollbar $w.vs -command [list $w.msg yview]
+		$w.msg insert end $s bold \n\n$err {}
+		$w.msg configure -state disabled
+
+		button $w.continue \
 			-text [mc "Continue"] \
 			-command [list destroy $w]
-		pack $w.buttons.continue -side right -padx 5
-		button $w.buttons.unlock \
+		button $w.unlock \
 			-text [mc "Unlock Index"] \
 			-command "destroy $w; _delete_indexlock"
-		pack $w.buttons.unlock -side right
-		pack $w.buttons -side bottom -fill x -pady 10 -padx 10
+		grid $w.msg - $w.vs -sticky news
+		grid $w.unlock $w.continue - -sticky se -padx 2 -pady 2
+		grid columnconfigure $w 0 -weight 1
+		grid rowconfigure $w 0 -weight 1
 
 		wm protocol $w WM_DELETE_WINDOW update
-		bind $w.buttons.continue <Visibility> "
+		bind $w.continue <Visibility> "
 			grab $w
-			focus $w.buttons.continue
+			focus %W
 		"
 		tkwait window $w
 
-- 
1.6.2
