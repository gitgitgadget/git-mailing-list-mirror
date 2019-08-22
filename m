Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78721F461
	for <e@80x24.org>; Thu, 22 Aug 2019 22:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404851AbfHVWBY (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 18:01:24 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:55623 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404840AbfHVWBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 18:01:23 -0400
Received: from localhost.localdomain (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3DC60240004;
        Thu, 22 Aug 2019 22:01:19 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v2 4/4] git-gui: Add the ability to revert selected hunk
Date:   Fri, 23 Aug 2019 03:31:07 +0530
Message-Id: <20190822220107.4153-5-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822220107.4153-1-me@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190822220107.4153-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like the user can select a hunk to stage or unstage, add the
ability to revert hunks.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui.sh   | 14 +++++++++++++-
 lib/diff.tcl | 34 +++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 9d84ba9..13fef74 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3583,9 +3583,14 @@ set ctxm .vpane.lower.diff.body.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
 	-label [mc "Apply/Reverse Hunk"] \
-	-command {apply_hunk $cursorX $cursorY}
+	-command {apply_or_revert_hunk $cursorX $cursorY 0}
 set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
+$ctxm add command \
+	-label [mc "Revert Hunk"] \
+	-command {apply_or_revert_hunk $cursorX $cursorY 1}
+set ui_diff_reverthunk [$ctxm index last]
+lappend diff_actions [list $ctxm entryconf $ui_diff_reverthunk -state]
 $ctxm add command \
 	-label [mc "Apply/Reverse Line"] \
 	-command {apply_or_revert_range_or_line $cursorX $cursorY 0; do_rescan}
@@ -3692,6 +3697,8 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 		set has_range [expr {[$::ui_diff tag nextrange sel 0.0] != {}}]
 		if {$::ui_index eq $::current_diff_side} {
 			set l [mc "Unstage Hunk From Commit"]
+			set h [mc "Revert Hunk"]
+
 			if {$has_range} {
 				set t [mc "Unstage Lines From Commit"]
 				set r [mc "Revert Lines"]
@@ -3701,6 +3708,8 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 			}
 		} else {
 			set l [mc "Stage Hunk For Commit"]
+			set h [mc "Revert Hunk"]
+
 			if {$has_range} {
 				set t [mc "Stage Lines For Commit"]
 				set r [mc "Revert Lines"]
@@ -3735,6 +3744,9 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 		$ctxm entryconf $::ui_diff_applyline -state $s -label $t
 		$ctxm entryconf $::ui_diff_revertline -state $revert_state \
 			-label $r
+		$ctxm entryconf $::ui_diff_reverthunk -state $revert_state \
+			-label $h
+
 		tk_popup $ctxm $X $Y
 	}
 }
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 00b15f5..6a9c760 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -567,30 +567,50 @@ proc read_diff {fd conflict_size cont_info} {
 	}
 }
 
-proc apply_hunk {x y} {
+proc apply_or_revert_hunk {x y revert} {
 	global current_diff_path current_diff_header current_diff_side
 	global ui_diff ui_index file_states
 
 	if {$current_diff_path eq {} || $current_diff_header eq {}} return
 	if {![lock_index apply_hunk]} return
 
-	set apply_cmd {apply --cached --whitespace=nowarn}
+	set apply_cmd {apply --whitespace=nowarn}
 	set mi [lindex $file_states($current_diff_path) 0]
 	if {$current_diff_side eq $ui_index} {
 		set failed_msg [mc "Failed to unstage selected hunk."]
-		lappend apply_cmd --reverse
+		lappend apply_cmd --reverse --cached
 		if {[string index $mi 0] ne {M}} {
 			unlock_index
 			return
 		}
 	} else {
-		set failed_msg [mc "Failed to stage selected hunk."]
+		if {$revert} {
+			set failed_msg [mc "Failed to revert selected hunk."]
+			lappend apply_cmd --reverse
+		} else {
+			set failed_msg [mc "Failed to stage selected hunk."]
+			lappend apply_cmd --cached
+		}
+
 		if {[string index $mi 1] ne {M}} {
 			unlock_index
 			return
 		}
 	}
 
+	if {$revert} {
+		set query "[mc "Revert changes in file %s?" \
+			[short_path $current_diff_path]]
+
+[mc "The selected hunk will be permanently lost by the revert."]"
+
+		set reply [revert_dialog $query]
+		if {$reply ne 1} {
+			unlock_index
+			return
+		}
+	}
+
 	set s_lno [lindex [split [$ui_diff index @$x,$y] .] 0]
 	set s_lno [$ui_diff search -backwards -regexp ^@@ $s_lno.0 0.0]
 	if {$s_lno eq {}} {
@@ -619,13 +639,17 @@ proc apply_hunk {x y} {
 	$ui_diff delete $s_lno $e_lno
 	$ui_diff conf -state disabled
 
+	# Check if the hunk was the last one in the file.
 	if {[$ui_diff get 1.0 end] eq "\n"} {
 		set o _
 	} else {
 		set o ?
 	}
 
-	if {$current_diff_side eq $ui_index} {
+	# Update the status flags.
+	if {$revert} {
+		set mi [string index $mi 0]$o
+	} elseif {$current_diff_side eq $ui_index} {
 		set mi ${o}M
 	} elseif {[string index $mi 0] eq {_}} {
 		set mi M$o
-- 
2.21.0

