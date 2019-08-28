Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01AB31F461
	for <e@80x24.org>; Wed, 28 Aug 2019 21:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfH1V5j (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 17:57:39 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:47211 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1V5i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 17:57:38 -0400
Received: from localhost.localdomain (unknown [1.186.12.40])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 2CD47200002;
        Wed, 28 Aug 2019 21:57:34 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v3 1/4] git-gui: allow reverting selected lines
Date:   Thu, 29 Aug 2019 03:27:22 +0530
Message-Id: <20190828215725.13376-2-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828215725.13376-1-me@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190828215725.13376-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like the user can select lines to stage or unstage, add the
ability to revert selected lines.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui.sh   | 25 ++++++++++++++++++++++++-
 lib/diff.tcl | 20 ++++++++++++++------
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..6d4d002 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3587,10 +3587,16 @@ set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
 $ctxm add command \
 	-label [mc "Apply/Reverse Line"] \
-	-command {apply_range_or_line $cursorX $cursorY; do_rescan}
+	-command {apply_or_revert_range_or_line $cursorX $cursorY 0; do_rescan}
 set ui_diff_applyline [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
 $ctxm add separator
+$ctxm add command \
+	-label [mc "Revert Line"] \
+	-command {apply_or_revert_range_or_line $cursorX $cursorY 1; do_rescan}
+set ui_diff_revertline [$ctxm index last]
+lappend diff_actions [list $ctxm entryconf $ui_diff_revertline -state]
+$ctxm add separator
 $ctxm add command \
 	-label [mc "Show Less Context"] \
 	-command show_less_context
@@ -3687,15 +3693,19 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 			set l [mc "Unstage Hunk From Commit"]
 			if {$has_range} {
 				set t [mc "Unstage Lines From Commit"]
+				set r [mc "Revert Lines"]
 			} else {
 				set t [mc "Unstage Line From Commit"]
+				set r [mc "Revert Line"]
 			}
 		} else {
 			set l [mc "Stage Hunk For Commit"]
 			if {$has_range} {
 				set t [mc "Stage Lines For Commit"]
+				set r [mc "Revert Lines"]
 			} else {
 				set t [mc "Stage Line For Commit"]
+				set r [mc "Revert Line"]
 			}
 		}
 		if {$::is_3way_diff
@@ -3706,11 +3716,24 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 			|| [string match {T?} $state]
 			|| [has_textconv $current_diff_path]} {
 			set s disabled
+			set revert_state disabled
 		} else {
 			set s normal
+
+			# Only allow reverting changes in the working tree. If
+			# the user wants to revert changes in the index, they
+			# need to unstage those first.
+			if {$::ui_workdir eq $::current_diff_side} {
+				set revert_state normal
+			} else {
+				set revert_state disabled
+			}
 		}
+
 		$ctxm entryconf $::ui_diff_applyhunk -state $s -label $l
 		$ctxm entryconf $::ui_diff_applyline -state $s -label $t
+		$ctxm entryconf $::ui_diff_revertline -state $revert_state \
+			-label $r
 		tk_popup $ctxm $X $Y
 	}
 }
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 4cae10a..d6bee29 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -55,7 +55,7 @@ proc reshow_diff {{after {}}} {
 
 proc force_diff_encoding {enc} {
 	global current_diff_path
-	
+
 	if {$current_diff_path ne {}} {
 		force_path_encoding $current_diff_path $enc
 		reshow_diff
@@ -640,7 +640,7 @@ proc apply_hunk {x y} {
 	}
 }
 
-proc apply_range_or_line {x y} {
+proc apply_or_revert_range_or_line {x y revert} {
 	global current_diff_path current_diff_header current_diff_side
 	global ui_diff ui_index file_states
 
@@ -660,19 +660,27 @@ proc apply_range_or_line {x y} {
 	if {$current_diff_path eq {} || $current_diff_header eq {}} return
 	if {![lock_index apply_hunk]} return
 
-	set apply_cmd {apply --cached --whitespace=nowarn}
+	set apply_cmd {apply --whitespace=nowarn}
 	set mi [lindex $file_states($current_diff_path) 0]
 	if {$current_diff_side eq $ui_index} {
 		set failed_msg [mc "Failed to unstage selected line."]
 		set to_context {+}
-		lappend apply_cmd --reverse
+		lappend apply_cmd --reverse --cached
 		if {[string index $mi 0] ne {M}} {
 			unlock_index
 			return
 		}
 	} else {
-		set failed_msg [mc "Failed to stage selected line."]
-		set to_context {-}
+		if {$revert} {
+			set failed_msg [mc "Failed to revert selected line."]
+			set to_context {+}
+			lappend apply_cmd --reverse
+		} else {
+			set failed_msg [mc "Failed to stage selected line."]
+			set to_context {-}
+			lappend apply_cmd --cached
+		}
+
 		if {[string index $mi 1] ne {M}} {
 			unlock_index
 			return
-- 
2.21.0

