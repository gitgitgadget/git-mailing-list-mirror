Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050781F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbeGMRMG (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:06 -0400
Received: from siwi.pair.com ([209.68.5.199]:31839 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731651AbeGMRMF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:05 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6EB0D3F47F5;
        Fri, 13 Jul 2018 12:56:38 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 070E73F47F1;
        Fri, 13 Jul 2018 12:56:37 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 13/25] structured-logging: add timer around wt-status functions
Date:   Fri, 13 Jul 2018 16:56:09 +0000
Message-Id: <20180713165621.52017-14-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use a SLOG timer to record the time spend in wt_status_collect_worktree(),
wt_status_collect_changes_initial(), wt_status_collect_changes_index(),
and wt_status_collect_untracked().  These are reported in the "cmd_exit"
event.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 wt-status.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index d1c0514..f663a37 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -580,8 +580,11 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 
 static void wt_status_collect_changes_worktree(struct wt_status *s)
 {
+	int slog_tid;
 	struct rev_info rev;
 
+	slog_tid = slog_start_timer("status", "worktree");
+
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
@@ -600,13 +603,18 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
+
+	slog_stop_timer(slog_tid);
 }
 
 static void wt_status_collect_changes_index(struct wt_status *s)
 {
+	int slog_tid;
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
+	slog_tid = slog_start_timer("status", "changes_index");
+
 	init_revisions(&rev, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
@@ -636,12 +644,17 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
+
+	slog_stop_timer(slog_tid);
 }
 
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
+	int slog_tid;
 	int i;
 
+	slog_tid = slog_start_timer("status", "changes_initial");
+
 	for (i = 0; i < active_nr; i++) {
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
@@ -672,10 +685,13 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 			oidcpy(&d->oid_index, &ce->oid);
 		}
 	}
+
+	slog_stop_timer(slog_tid);
 }
 
 static void wt_status_collect_untracked(struct wt_status *s)
 {
+	int slog_tid;
 	int i;
 	struct dir_struct dir;
 	uint64_t t_begin = getnanotime();
@@ -683,6 +699,8 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	if (!s->show_untracked_files)
 		return;
 
+	slog_tid = slog_start_timer("status", "untracked");
+
 	memset(&dir, 0, sizeof(dir));
 	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=
@@ -722,6 +740,8 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	if (advice_status_u_option)
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
+
+	slog_stop_timer(slog_tid);
 }
 
 void wt_status_collect(struct wt_status *s)
-- 
2.9.3

