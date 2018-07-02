Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D479F1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 18:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeGBSfX (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 14:35:23 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:47036 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbeGBSfW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 14:35:22 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2018 14:35:22 EDT
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id EC55341BAC; Mon,  2 Jul 2018 20:25:21 +0200 (CEST)
From:   =?UTF-8?q?Martin=20Sch=C3=B6n?= 
        <Martin.Schoen@loewensteinmedical.de>
Date:   Mon, 2 Jul 2018 15:28:09 +0200
Subject: [PATCH] git-gui: use commit message template
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20180702182521.EC55341BAC@mail.steuer-voss.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the file described by commit.template (if set) to show the commit message
template, just like other GUIs.

Signed-off-by: Martin Sch??n <Martin.Schoen@loewensteinmedical.de>
---
 git-gui.sh     | 9 +++++++++
 lib/commit.tcl | 1 +
 2 files changed, 10 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..6fc598d 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1611,6 +1611,12 @@ proc run_prepare_commit_msg_hook {} {
 		fconfigure $fd_sm -encoding utf-8
 		puts -nonewline $fd_pcm [read $fd_sm]
 		close $fd_sm
+	} elseif {[file isfile [get_config commit.template]]} {
+		set pcm_source "template"
+		set fd_sm [open [get_config commit.template] r]
+		fconfigure $fd_sm -encoding utf-8
+		puts -nonewline $fd_pcm [read $fd_sm]
+		close $fd_sm
 	} else {
 		set pcm_source ""
 	}
@@ -1620,6 +1626,9 @@ proc run_prepare_commit_msg_hook {} {
 	set fd_ph [githook_read prepare-commit-msg \
 			[gitdir PREPARE_COMMIT_MSG] $pcm_source]
 	if {$fd_ph eq {}} {
+		if {$pcm_source eq "template"} {
+			load_message PREPARE_COMMIT_MSG
+		}
 		catch {file delete [gitdir PREPARE_COMMIT_MSG]}
 		return 0;
 	}
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 83620b7..168f696 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -506,6 +506,7 @@ A rescan will be automatically started now.
 	unlock_index
 	reshow_diff
 	ui_status [mc "Created commit %s: %s" [string range $cmt_id 0 7] $subject]
+	rescan ui_ready
 }
 
 proc commit_postcommit_wait {fd_ph cmt_id} {
-- 
2.17.1

