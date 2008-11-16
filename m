From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) v2 2/5] git-gui: Fix the after callback execution in rescan.
Date: Sun, 16 Nov 2008 21:46:48 +0300
Message-ID: <1226861211-16995-3-git-send-email-angavrilov@gmail.com>
References: <1226861211-16995-1-git-send-email-angavrilov@gmail.com>
 <1226861211-16995-2-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 19:50:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1mhj-0001pL-LR
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 19:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbYKPStE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 13:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbYKPStD
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 13:49:03 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:22145 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbYKPStA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 13:49:00 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1819464fgg.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 10:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HGOdSMmvQUAbV/BIKz6rbtOcNbcdisHVpPH4mw8RjfI=;
        b=POxoyLkkvj207tM/yT8v/kFqtKy49MZxGIzoA0ICnqQXeHv2iETCUy4DQsmQ2XD4Ld
         lsfiBN5Eq0kd26b2K1ym223/45MsxPkPDHw7x7pFKa4LYBqbqTs9hMM3y3a9md0uWPnK
         RWGhLsWrpZ65v/+tqdK5tpl7Fq2DWgBBYk1uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v1ZKsjbAFHtySdN7iYBcUQWiWsJVzYB5+wJJWlRcCJFWIrDrQ0WmYhG4A5CDD7z0Jq
         Yx81mPt1xO1MX3qhRWny+66RO+JvviQY+yu6YsD5jWNhImjx5lZZ9IC/lgMPBWCFsCt8
         SQWA1VuVoubwWvkFmsckbh8JVF0tQaP4hjZg4=
Received: by 10.181.216.12 with SMTP id t12mr798146bkq.122.1226861337818;
        Sun, 16 Nov 2008 10:48:57 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id z15sm3020368fkz.16.2008.11.16.10.48.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 10:48:56 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1226861211-16995-2-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101152>

The rescan function receives a callback command
as its parameter, which is supposed to be executed
after the scan finishes. It is generally used to
update status. However, rescan may initiate a
loading of a diff, which always calls ui_ready after
completion. If the after handler is called before
that, ui_ready will override the new status.

This commit ensures that the after callback is
properly threaded through the diff machinery.

Since it uncovered the fact that force_first_diff
actually didn't work due to an undeclared global
variable, and the desired effects appeared only
because of the race condition between the diff
system and the rescan callback, I also reimplement
this function to make it behave as originally
intended.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh   |   41 ++++++++++++++++++++++++++++-------------
 lib/diff.tcl |    6 +++---
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 34214b6..2709f6e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1469,10 +1469,8 @@ proc rescan_done {fd buf after} {
 	prune_selection
 	unlock_index
 	display_all_files
-	if {$current_diff_path ne {}} reshow_diff
-	if {$current_diff_path eq {}} select_first_diff
-
-	uplevel #0 $after
+	if {$current_diff_path ne {}} { reshow_diff $after }
+	if {$current_diff_path eq {}} { select_first_diff $after }
 }
 
 proc prune_selection {} {
@@ -1984,16 +1982,16 @@ proc do_rescan {} {
 }
 
 proc ui_do_rescan {} {
-	rescan {force_first_diff; ui_ready}
+	rescan {force_first_diff ui_ready}
 }
 
 proc do_commit {} {
 	commit_tree
 }
 
-proc next_diff {} {
+proc next_diff {{after {}}} {
 	global next_diff_p next_diff_w next_diff_i
-	show_diff $next_diff_p $next_diff_w {}
+	show_diff $next_diff_p $next_diff_w {} {} $after
 }
 
 proc find_anchor_pos {lst name} {
@@ -2078,25 +2076,42 @@ proc next_diff_after_action {w path {lno {}} {mmask {}}} {
 	}
 }
 
-proc select_first_diff {} {
+proc select_first_diff {after} {
 	global ui_workdir
 
 	if {[find_next_diff $ui_workdir {} 1 {^_?U}] ||
 	    [find_next_diff $ui_workdir {} 1 {[^O]$}]} {
-		next_diff
+		next_diff $after
+	} else {
+		uplevel #0 $after
 	}
 }
 
-proc force_first_diff {} {
-	global current_diff_path
+proc force_first_diff {after} {
+	global ui_workdir current_diff_path file_states
 
 	if {[info exists file_states($current_diff_path)]} {
 		set state [lindex $file_states($current_diff_path) 0]
+	} else {
+		set state {OO}
+	}
 
-		if {[string index $state 1] ne {O}} return
+	set reselect 0
+	if {[string first {U} $state] >= 0} {
+		# Already a conflict, do nothing
+	} elseif {[find_next_diff $ui_workdir $current_diff_path {} {^_?U}]} {
+		set reselect 1
+	} elseif {[string index $state 1] ne {O}} {
+		# Already a diff & no conflicts, do nothing
+	} elseif {[find_next_diff $ui_workdir $current_diff_path {} {[^O]$}]} {
+		set reselect 1
 	}
 
-	select_first_diff
+	if {$reselect} {
+		next_diff $after
+	} else {
+		uplevel #0 $after
+	}
 }
 
 proc toggle_or_diff {w x y} {
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 94ee38c..bbbf15c 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -16,7 +16,7 @@ proc clear_diff {} {
 	$ui_workdir tag remove in_diff 0.0 end
 }
 
-proc reshow_diff {} {
+proc reshow_diff {{after {}}} {
 	global file_states file_lists
 	global current_diff_path current_diff_side
 	global ui_diff
@@ -30,13 +30,13 @@ proc reshow_diff {} {
 		|| [lsearch -sorted -exact $file_lists($current_diff_side) $p] == -1} {
 
 		if {[find_next_diff $current_diff_side $p {} {[^O]}]} {
-			next_diff
+			next_diff $after
 		} else {
 			clear_diff
 		}
 	} else {
 		set save_pos [lindex [$ui_diff yview] 0]
-		show_diff $p $current_diff_side {} $save_pos
+		show_diff $p $current_diff_side {} $save_pos $after
 	}
 }
 
-- 
1.6.0.3.15.gb8d36
