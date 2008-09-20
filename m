From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI)] git-gui: Reenable staging unmerged files by clicking the icon.
Date: Sat, 20 Sep 2008 12:19:18 +0400
Organization: HOME
Message-ID: <200809201219.18630.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 10:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgxj4-00008x-NH
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 10:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbYITIUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 04:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbYITIUp
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 04:20:45 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:18687 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbYITIUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 04:20:42 -0400
Received: by fk-out-0910.google.com with SMTP id 18so734308fkq.5
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RV7WtajzM54BrxAj58DdOl4LPQMs+1rm9uR2D8UKz5w=;
        b=x0KoLWiH/Xupidm/IW6j4aUX8c7TlQnzeIKWS9G4LQdjccNFy5IGbt+nYIfHlioYzn
         XCyEzfL3gpFK8YS8q2W12F4495aAjMh7O+fW1ruK/QkRa20w7SoKv6LGTxCt5M3kTBLm
         c6YBxpdlWi7OOOGJQRHFJ9g9ZNhY4a/ALZPII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=WNEwgKJF/zQQPtXrx1/Kaoyyf72aGa0Ud1qFsM5ZnE83BT3CPb2Bnsy8k/GGBAndoe
         si5caRQFME2JfscLbF0jwcxv5uGsNvdpJFvflw2y+VHE8veGXiZHQQvDq12sPMO1wSJ6
         0VIjDhr9O9ZJmXHozHkBP4NWnYmFafzP0neWs=
Received: by 10.181.2.2 with SMTP id e2mr880415bki.3.1221898840159;
        Sat, 20 Sep 2008 01:20:40 -0700 (PDT)
Received: from keydesk.localnet ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm2269271fka.3.2008.09.20.01.20.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 01:20:39 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.3-29.fc9.i686; KDE/4.1.0; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96337>

This restores functionality of the file icon for unmerged files.
Safety is enforced by loading the diff and checking for lines
that look like conflict markers. If such lines are found, or
the conflict involves deletion and/or symlinks, a confirmation
dialog is presented. Otherwise, the icon immediately stages the
working copy version of the file.

Includes a revert of 2fe5b2ee42897a3acc78e5ddaace3775eb2713ca
(Restore ability to Stage Working Copy for conflicts)

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh        |   18 ++++++++----------
 lib/diff.tcl      |   52 +++++++++++++++++++++++++++++++++++-----------------
 lib/mergetool.tcl |   33 +++++++++++++++++++++++++++------
 3 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 3bbb4f1..9e5b122 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1059,6 +1059,7 @@ set current_branch {}
 set is_detached 0
 set current_diff_path {}
 set is_3way_diff 0
+set is_conflict_diff 0
 set selected_commit_type new
 
 set nullid "0000000000000000000000000000000000000000"
@@ -2013,19 +2014,21 @@ proc toggle_or_diff {w x y} {
 	$ui_index tag remove in_sel 0.0 end
 	$ui_workdir tag remove in_sel 0.0 end
 
-	# Do not stage files with conflicts
+	# Determine the state of the file
 	if {[info exists file_states($path)]} {
 		set state [lindex $file_states($path) 0]
 	} else {
 		set state {__}
 	}
 
-	if {[string first {U} $state] >= 0} {
-		set col 1
-	}
-
 	# Restage the file, or simply show the diff
 	if {$col == 0 && $y > 1} {
+		# Conflicts need special handling
+		if {[string first {U} $state] >= 0} {
+			merge_stage_workdir $path $w $lno
+			return
+		}
+
 		if {[string index $state 1] eq {O}} {
 			set mmask {}
 		} else {
@@ -2984,11 +2987,6 @@ $ctxmmg add command \
 	-command {merge_resolve_one 1}
 lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
 $ctxmmg add separator
-$ctxmmg add command \
-	-label [mc "Stage Working Copy"] \
-	-command {merge_resolve_one 0}
-lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
-$ctxmmg add separator
 create_common_diff_popup $ctxmmg
 
 proc popup_diff_menu {ctxm ctxmmg x y X Y} {
diff --git a/lib/diff.tcl b/lib/diff.tcl
index b616296..abe502d 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -69,9 +69,9 @@ A rescan will be automatically started to find other files which may have the sa
 	rescan ui_ready 0
 }
 
-proc show_diff {path w {lno {}} {scroll_pos {}}} {
+proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
 	global file_states file_lists
-	global is_3way_diff diff_active repo_config
+	global is_3way_diff is_conflict_diff diff_active repo_config
 	global ui_diff ui_index ui_workdir
 	global current_diff_path current_diff_side current_diff_header
 	global current_diff_queue
@@ -92,36 +92,42 @@ proc show_diff {path w {lno {}} {scroll_pos {}}} {
 
 	set s $file_states($path)
 	set m [lindex $s 0]
+	set is_conflict_diff 0
 	set current_diff_path $path
 	set current_diff_side $w
 	set current_diff_queue {}
 	ui_status [mc "Loading diff of %s..." [escape_path $path]]
 
+	set cont_info [list $scroll_pos $callback]
+
 	if {[string first {U} $m] >= 0} {
-		merge_load_stages $path [list show_unmerged_diff $scroll_pos]
+		merge_load_stages $path [list show_unmerged_diff $cont_info]
 	} elseif {$m eq {_O}} {
-		show_other_diff $path $w $m $scroll_pos
+		show_other_diff $path $w $m $cont_info
 	} else {
-		start_show_diff $scroll_pos
+		start_show_diff $cont_info
 	}
 }
 
-proc show_unmerged_diff {scroll_pos} {
+proc show_unmerged_diff {cont_info} {
 	global current_diff_path current_diff_side
-	global merge_stages ui_diff
+	global merge_stages ui_diff is_conflict_diff
 	global current_diff_queue
 
 	if {$merge_stages(2) eq {}} {
+		set is_conflict_diff 1
 		lappend current_diff_queue \
 			[list "LOCAL: deleted\nREMOTE:\n" d======= \
 			    [list ":1:$current_diff_path" ":3:$current_diff_path"]]
 	} elseif {$merge_stages(3) eq {}} {
+		set is_conflict_diff 1
 		lappend current_diff_queue \
 			[list "REMOTE: deleted\nLOCAL:\n" d======= \
 			    [list ":1:$current_diff_path" ":2:$current_diff_path"]]
 	} elseif {[lindex $merge_stages(1) 0] eq {120000}
 		|| [lindex $merge_stages(2) 0] eq {120000}
 		|| [lindex $merge_stages(3) 0] eq {120000}} {
+		set is_conflict_diff 1
 		lappend current_diff_queue \
 			[list "LOCAL:\n" d======= \
 			    [list ":1:$current_diff_path" ":2:$current_diff_path"]]
@@ -129,14 +135,14 @@ proc show_unmerged_diff {scroll_pos} {
 			[list "REMOTE:\n" d======= \
 			    [list ":1:$current_diff_path" ":3:$current_diff_path"]]
 	} else {
-		start_show_diff $scroll_pos
+		start_show_diff $cont_info
 		return
 	}
 
-	advance_diff_queue $scroll_pos
+	advance_diff_queue $cont_info
 }
 
-proc advance_diff_queue {scroll_pos} {
+proc advance_diff_queue {cont_info} {
 	global current_diff_queue ui_diff
 
 	set item [lindex $current_diff_queue 0]
@@ -146,10 +152,10 @@ proc advance_diff_queue {scroll_pos} {
 	$ui_diff insert end [lindex $item 0] [lindex $item 1]
 	$ui_diff conf -state disabled
 
-	start_show_diff $scroll_pos [lindex $item 2]
+	start_show_diff $cont_info [lindex $item 2]
 }
 
-proc show_other_diff {path w m scroll_pos} {
+proc show_other_diff {path w m cont_info} {
 	global file_states file_lists
 	global is_3way_diff diff_active repo_config
 	global ui_diff ui_index ui_workdir
@@ -228,16 +234,21 @@ proc show_other_diff {path w m scroll_pos} {
 		$ui_diff conf -state disabled
 		set diff_active 0
 		unlock_index
+		set scroll_pos [lindex $cont_info 0]
 		if {$scroll_pos ne {}} {
 			update
 			$ui_diff yview moveto $scroll_pos
 		}
 		ui_ready
+		set callback [lindex $cont_info 1]
+		if {$callback ne {}} {
+			eval $callback
+		}
 		return
 	}
 }
 
-proc start_show_diff {scroll_pos {add_opts {}}} {
+proc start_show_diff {cont_info {add_opts {}}} {
 	global file_states file_lists
 	global is_3way_diff diff_active repo_config
 	global ui_diff ui_index ui_workdir
@@ -292,12 +303,12 @@ proc start_show_diff {scroll_pos {add_opts {}}} {
 		-blocking 0 \
 		-encoding [get_path_encoding $path] \
 		-translation lf
-	fileevent $fd readable [list read_diff $fd $scroll_pos]
+	fileevent $fd readable [list read_diff $fd $cont_info]
 }
 
-proc read_diff {fd scroll_pos} {
+proc read_diff {fd cont_info} {
 	global ui_diff diff_active
-	global is_3way_diff current_diff_header
+	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
 
 	$ui_diff conf -state normal
@@ -345,6 +356,7 @@ proc read_diff {fd scroll_pos} {
 			{--} {set tags d_--}
 			{++} {
 				if {[regexp {^\+\+([<>]{7} |={7})} $line _g op]} {
+					set is_conflict_diff 1
 					set line [string replace $line 0 1 {  }]
 					set tags d$op
 				} else {
@@ -364,6 +376,7 @@ proc read_diff {fd scroll_pos} {
 			{-} {set tags d_-}
 			{+} {
 				if {[regexp {^\+([<>]{7} |={7})} $line _g op]} {
+					set is_conflict_diff 1
 					set line [string replace $line 0 0 { }]
 					set tags d$op
 				} else {
@@ -388,12 +401,13 @@ proc read_diff {fd scroll_pos} {
 		close $fd
 
 		if {$current_diff_queue ne {}} {
-			advance_diff_queue $scroll_pos
+			advance_diff_queue $cont_info
 			return
 		}
 
 		set diff_active 0
 		unlock_index
+		set scroll_pos [lindex $cont_info 0]
 		if {$scroll_pos ne {}} {
 			update
 			$ui_diff yview moveto $scroll_pos
@@ -403,6 +417,10 @@ proc read_diff {fd scroll_pos} {
 		if {[$ui_diff index end] eq {2.0}} {
 			handle_empty_diff
 		}
+		set callback [lindex $cont_info 1]
+		if {$callback ne {}} {
+			eval $callback
+		}
 	}
 }
 
diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index dd2315b..9693e47 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -5,12 +5,6 @@ proc merge_resolve_one {stage} {
 	global current_diff_path
 
 	switch -- $stage {
-		0 {	# Stage without confirmation, to minimize
-			# disruption of the rerere workflow
-			merge_add_resolution $current_diff_path
-			return
-		}
-
 		1 { set target [mc "the base version"] }
 		2 { set target [mc "this branch"] }
 		3 { set target [mc "the other branch"] }
@@ -29,6 +23,33 @@ This operation can be undone only by restarting the merge." \
 	}
 }
 
+proc merge_stage_workdir {path w lno} {
+	global current_diff_path diff_active
+
+	if {$diff_active} return
+
+	if {$path ne $current_diff_path} {
+		show_diff $path $w $lno {} [list do_merge_stage_workdir $path]
+	} else {
+		do_merge_stage_workdir $path
+	}
+}
+
+proc do_merge_stage_workdir {path} {
+	global current_diff_path is_conflict_diff
+
+	if {$path ne $current_diff_path} return;
+
+	if {$is_conflict_diff} {
+		if {[ask_popup [mc "File %s seems to have unresolved conflicts, still stage?" \
+				[short_path $path]]] ne {yes}} {
+			return
+		}
+	}
+
+	merge_add_resolution $path
+}
+
 proc merge_add_resolution {path} {
 	global current_diff_path ui_workdir
 
-- 
1.6.0.20.g6148bc
