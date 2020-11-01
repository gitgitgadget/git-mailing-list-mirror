Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7619AC5517A
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4904622242
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKARFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:05:25 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:57932 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgKARFW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:05:22 -0500
Received: from client3368.fritz.box (i5C74609C.versanet.de [92.116.96.156])
        by dd36226.kasserver.com (Postfix) with ESMTPA id 9E0913C462E;
        Sun,  1 Nov 2020 18:05:18 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com
Subject: [PATCH 1/2] git-gui: Delay rescan until idle time
Date:   Sun,  1 Nov 2020 18:05:04 +0100
Message-Id: <20201101170505.71246-2-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201101170505.71246-1-stefan@haller-berlin.de>
References: <20201101170505.71246-1-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is to ensure that a rescan is only performed once, even if it is
requested multiple times during one event. We don't need this yet, because
we only ever call do_rescan once per event so far; this is going to change
with the next commit, when we also call it from FocusIn.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 git-gui.sh | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 867b8ce..8864c14 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2376,8 +2376,21 @@ proc do_quit {{rc {1}}} {
 	destroy .
 }
 
+# Not to be called directly; use schedule_rescan instead
 proc do_rescan {} {
+	global rescan_id
+
 	rescan ui_ready
+	unset rescan_id
+}
+
+proc schedule_rescan {} {
+	global rescan_id
+
+	if {[info exists rescan_id]} {
+		after cancel $rescan_id
+	}
+	set rescan_id [after idle do_rescan]
 }
 
 proc ui_do_rescan {} {
@@ -3683,7 +3696,7 @@ set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
 $ctxm add command \
 	-label [mc "Apply/Reverse Line"] \
-	-command {apply_or_revert_range_or_line $cursorX $cursorY 0; do_rescan}
+	-command {apply_or_revert_range_or_line $cursorX $cursorY 0; schedule_rescan}
 set ui_diff_applyline [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
 $ctxm add separator
@@ -3694,12 +3707,12 @@ set ui_diff_reverthunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_reverthunk -state]
 $ctxm add command \
 	-label [mc "Revert Line"] \
-	-command {apply_or_revert_range_or_line $cursorX $cursorY 1; do_rescan}
+	-command {apply_or_revert_range_or_line $cursorX $cursorY 1; schedule_rescan}
 set ui_diff_revertline [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_revertline -state]
 $ctxm add command \
 	-label [mc "Undo Last Revert"] \
-	-command {undo_last_revert; do_rescan}
+	-command {undo_last_revert; schedule_rescan}
 set ui_diff_undorevert [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_undorevert -state]
 $ctxm add separator
@@ -4171,7 +4184,7 @@ after 1 {
 	if {[is_enabled initialamend]} {
 		force_amend
 	} else {
-		do_rescan
+		schedule_rescan
 	}
 
 	if {[is_enabled nocommitmsg]} {
-- 
2.29.2

