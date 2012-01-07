From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: fix selection regression introduced in a8ca786991
Date: Sat,  7 Jan 2012 20:43:47 +0100
Message-ID: <14628854a651ab0202e3f82be9b245331cf9029a.1325965254.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jan 07 20:44:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjcBK-0006Cg-Vm
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 20:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338Ab2AGTnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 14:43:53 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35512 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab2AGTnw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 14:43:52 -0500
Received: by bkcjm19 with SMTP id jm19so703469bkc.19
        for <git@vger.kernel.org>; Sat, 07 Jan 2012 11:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=oCFDF2BT0yto8NRmLkOIzbLJ9tPwGVXJ1EkzthxgQfQ=;
        b=EN3gpQDKM8r+4lHU7tn8Gyt2EU6M4XnqtbOXOEYa9GrFM7jkv2uvIXthham2Bvv/xI
         2AlaONcWgpBmRDZtjvPnMtkucC7fiK9BguQCSGnJ6sddteiQWSUlrp8ypXfpmiuM3Hg/
         5TDF2FFZZqFkiRGj04uMdiMroV9TReXzPz4OE=
Received: by 10.204.152.136 with SMTP id g8mr4533892bkw.127.1325965431392;
        Sat, 07 Jan 2012 11:43:51 -0800 (PST)
Received: from localhost (p5B2ABA2C.dip.t-dialin.net. [91.42.186.44])
        by mx.google.com with ESMTPS id fg16sm130524318bkb.16.2012.01.07.11.43.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Jan 2012 11:43:50 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.873.gfea665
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188084>

While fixing the problem from a8ca786991, it introduces a regression
regarding what happen after the multi selected file operation (ie.
one of Ctrl-{T,U,J}) because the next selected file could not be handled
by such a subsequent file operation.

The right way is to move the fix from this commit down into the show_diff
function. So that all code path add the current diff path to the list of
selections.

This also simplifies helper functions for these operatione which needed
to handle the case whether there is only the current diff path or also
a selction.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

I propbose this to be inlcuded in the next git-1.7.9 release.

 git-gui.sh    |    1 -
 lib/diff.tcl  |    3 ++-
 lib/index.tcl |   48 +++++++++++++++---------------------------------
 3 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index ba4e5c1..13b22dd 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2520,7 +2520,6 @@ proc toggle_or_diff {w x y} {
 				[concat $after [list ui_ready]]
 		}
 	} else {
-		set selected_paths($path) 1
 		show_diff $path $w $lno
 	}
 }
diff --git a/lib/diff.tcl b/lib/diff.tcl
index ec44055..775649c 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -75,7 +75,7 @@ A rescan will be automatically started to find other files which may have the sa
 }
 
 proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
-	global file_states file_lists
+	global file_states file_lists selected_paths
 	global is_3way_diff is_conflict_diff diff_active repo_config
 	global ui_diff ui_index ui_workdir
 	global current_diff_path current_diff_side current_diff_header
@@ -91,6 +91,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
 		}
 	}
 	if {$lno >= 1} {
+		set selected_paths($path) 1
 		$w tag add in_diff $lno.0 [expr {$lno + 1}].0
 		$w see $lno.0
 	}
diff --git a/lib/index.tcl b/lib/index.tcl
index 8efbbdd..2223a21 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -287,17 +287,11 @@ proc unstage_helper {txt paths} {
 }
 
 proc do_unstage_selection {} {
-	global current_diff_path selected_paths
-
-	if {[array size selected_paths] > 0} {
-		unstage_helper \
-			{Unstaging selected files from commit} \
-			[array names selected_paths]
-	} elseif {$current_diff_path ne {}} {
-		unstage_helper \
-			[mc "Unstaging %s from commit" [short_path $current_diff_path]] \
-			[list $current_diff_path]
-	}
+	global selected_paths
+
+	unstage_helper \
+		{Unstaging selected files from commit} \
+		[array names selected_paths]
 }
 
 proc add_helper {txt paths} {
@@ -339,17 +333,11 @@ proc add_helper {txt paths} {
 }
 
 proc do_add_selection {} {
-	global current_diff_path selected_paths
-
-	if {[array size selected_paths] > 0} {
-		add_helper \
-			{Adding selected files} \
-			[array names selected_paths]
-	} elseif {$current_diff_path ne {}} {
-		add_helper \
-			[mc "Adding %s" [short_path $current_diff_path]] \
-			[list $current_diff_path]
-	}
+	global selected_paths
+
+	add_helper \
+		{Adding selected files} \
+		[array names selected_paths]
 }
 
 proc do_add_all {} {
@@ -452,17 +440,11 @@ proc revert_helper {txt paths} {
 }
 
 proc do_revert_selection {} {
-	global current_diff_path selected_paths
-
-	if {[array size selected_paths] > 0} {
-		revert_helper \
-			[mc "Reverting selected files"] \
-			[array names selected_paths]
-	} elseif {$current_diff_path ne {}} {
-		revert_helper \
-			[mc "Reverting %s" [short_path $current_diff_path]] \
-			[list $current_diff_path]
-	}
+	global selected_paths
+
+	revert_helper \
+		[mc "Reverting selected files"] \
+		[array names selected_paths]
 }
 
 proc do_select_commit_type {} {
-- 
1.7.8.1.873.gfea665
