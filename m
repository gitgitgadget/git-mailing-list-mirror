From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] git-gui: Move on to the next filename after staging/unstaging a change
Date: Fri, 13 Jun 2008 03:42:10 +0530
Message-ID: <1213308730-12707-1-git-send-email-ams@toroid.org>
Cc: gitster@pobox.com, Abhijit Menon-Sen <ams@toroid.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 00:46:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6vYo-0003wS-2z
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 00:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbYFLWpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 18:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbYFLWpa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 18:45:30 -0400
Received: from fugue.toroid.org ([85.10.196.113]:47742 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907AbYFLWp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 18:45:29 -0400
X-Greylist: delayed 1995 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jun 2008 18:45:29 EDT
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 42298558244;
	Fri, 13 Jun 2008 00:12:12 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id C8EF3ADC0CB; Fri, 13 Jun 2008 03:42:10 +0530 (IST)
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84808>

Suppose the "Unstaged Changes" pane contains a list of files, and one of
them is selected (i.e., that diff is currently being displayed). If one
clicks on the icon to stage the change, git-gui clears the diff and one
has to click on another filename to see the next diff in the list.

This patch changes that behaviour. If one clicks on the icon to stage
(or unstage) the file whose diff is being displayed, git-gui will move
on to the next filename in the list and display that diff instead of a
blank diff pane. If the selected file was at the end of the list, the
diff pane will display the previous diff instead; if the selected file
was the only one listed, the diff pane will become blank.

If no diff is currently being displayed, this patch changes nothing.

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---
 git-gui/git-gui.sh |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index e6e8890..23d7dfe 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1774,6 +1774,11 @@ proc do_commit {} {
 	commit_tree
 }
 
+proc next_diff {} {
+	global next_diff_p next_diff_w next_diff_i
+	show_diff $next_diff_p $next_diff_w $next_diff_i
+}
+
 proc toggle_or_diff {w x y} {
 	global file_states file_lists current_diff_path ui_index ui_workdir
 	global last_clicked selected_paths
@@ -1793,11 +1798,31 @@ proc toggle_or_diff {w x y} {
 	$ui_workdir tag remove in_sel 0.0 end
 
 	if {$col == 0} {
-		if {$current_diff_path eq $path} {
+		set i [expr {$lno-1}]
+		set ll [expr {[llength $file_lists($w)]-1}]
+
+		if {$i == $ll && $i == 0} {
 			set after {reshow_diff;}
 		} else {
-			set after {}
+			global next_diff_p next_diff_w next_diff_i
+
+			if {$i < $ll} {
+				set i [expr {$i + 1}]
+			} else {
+				set i [expr {$i - 1}]
+			}
+
+			set next_diff_i $i
+			set next_diff_w $w
+			set next_diff_p [lindex $file_lists($w) $i]
+
+			if {$next_diff_p ne {} && $current_diff_path ne {}} {
+				set after {next_diff;}
+			} else {
+				set after {}
+			}
 		}
+
 		if {$w eq $ui_index} {
 			update_indexinfo \
 				"Unstaging [short_path $path] from commit" \
-- 
1.5.5.1
