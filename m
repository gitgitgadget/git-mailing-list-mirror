Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D3EEE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjHUUOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjHUUOV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:14:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1219C13E
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:14:15 -0700 (PDT)
Received: (qmail 17333 invoked by uid 109); 21 Aug 2023 20:14:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:14:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18539 invoked by uid 111); 21 Aug 2023 20:14:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:14:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:14:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 1/7] diff: spell DIFF_INDEX_CACHED out when calling
 run_diff_index()
Message-ID: <20230821201414.GA1798590@coredump.intra.peff.net>
References: <20230821201358.GA2663749@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821201358.GA2663749@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Many callers of run_diff_index() passed literal "1" for the option
flag word, which should better be spelled out as DIFF_INDEX_CACHED
for readablity.  Everybody else passes "0" that can stay as-is.

The other bit in the option flag word is DIFF_INDEX_MERGE_BASE, but
curiously there is only one caller that can pass it, which is "git
diff-index --merge-base" itself---no internal callers uses the
feature.

A bit tricky call to the function is in builtin/submodule--helper.c
where the .cached member in a private struct is set/reset as a plain
Boolean flag, which happens to be "1" and happens to match the value
of DIFF_INDEX_CACHED.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 add-interactive.c           | 2 +-
 builtin/am.c                | 4 ++--
 builtin/stash.c             | 2 +-
 builtin/submodule--helper.c | 2 +-
 diff-lib.c                  | 2 +-
 wt-status.c                 | 6 +++---
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index add9a1ad43..7fd00c5e25 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -569,7 +569,7 @@ static int get_modified_files(struct repository *r,
 			copy_pathspec(&rev.prune_data, ps);
 
 		if (s.mode == FROM_INDEX)
-			run_diff_index(&rev, 1);
+			run_diff_index(&rev, DIFF_INDEX_CACHED);
 		else {
 			rev.diffopt.flags.ignore_dirty_submodules = 1;
 			run_diff_files(&rev, 0);
diff --git a/builtin/am.c b/builtin/am.c
index 8bde034fae..202040b62e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1430,7 +1430,7 @@ static void write_index_patch(const struct am_state *state)
 	rev_info.diffopt.close_file = 1;
 	add_pending_object(&rev_info, &tree->object, "");
 	diff_setup_done(&rev_info.diffopt);
-	run_diff_index(&rev_info, 1);
+	run_diff_index(&rev_info, DIFF_INDEX_CACHED);
 	release_revisions(&rev_info);
 }
 
@@ -1593,7 +1593,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		rev_info.diffopt.filter |= diff_filter_bit('M');
 		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
 		diff_setup_done(&rev_info.diffopt);
-		run_diff_index(&rev_info, 1);
+		run_diff_index(&rev_info, DIFF_INDEX_CACHED);
 		release_revisions(&rev_info);
 	}
 
diff --git a/builtin/stash.c b/builtin/stash.c
index fe64cde9ce..fe5052f12f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1111,7 +1111,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	add_head_to_pending(&rev);
 	diff_setup_done(&rev.diffopt);
 
-	result = run_diff_index(&rev, 1);
+	result = run_diff_index(&rev, DIFF_INDEX_CACHED);
 	if (diff_result_code(&rev.diffopt, result)) {
 		ret = 1;
 		goto done;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f6871efd95..125ea80d21 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1141,7 +1141,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	}
 
 	if (diff_cmd == DIFF_INDEX)
-		run_diff_index(&rev, info->cached);
+		run_diff_index(&rev, info->cached ? DIFF_INDEX_CACHED : 0);
 	else
 		run_diff_files(&rev, 0);
 	prepare_submodule_summary(info, &list);
diff --git a/diff-lib.c b/diff-lib.c
index 6b0c6a7180..cfa3489111 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -682,7 +682,7 @@ int index_differs_from(struct repository *r,
 			rev.diffopt.flags.ignore_submodules = flags->ignore_submodules;
 	}
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
-	run_diff_index(&rev, 1);
+	run_diff_index(&rev, DIFF_INDEX_CACHED);
 	has_changes = rev.diffopt.flags.has_changes;
 	release_revisions(&rev);
 	return (has_changes != 0);
diff --git a/wt-status.c b/wt-status.c
index 5b1378965c..bf8687b357 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -675,7 +675,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.flags.recursive = 1;
 
 	copy_pathspec(&rev.prune_data, &s->pathspec);
-	run_diff_index(&rev, 1);
+	run_diff_index(&rev, DIFF_INDEX_CACHED);
 	release_revisions(&rev);
 }
 
@@ -1156,7 +1156,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		rev.diffopt.a_prefix = "c/";
 		rev.diffopt.b_prefix = "i/";
 	} /* else use prefix as per user config */
-	run_diff_index(&rev, 1);
+	run_diff_index(&rev, DIFF_INDEX_CACHED);
 	if (s->verbose > 1 &&
 	    wt_status_check_worktree_changes(s, &dirty_submodules)) {
 		status_printf_ln(s, c,
@@ -2614,7 +2614,7 @@ int has_uncommitted_changes(struct repository *r,
 	}
 
 	diff_setup_done(&rev_info.diffopt);
-	result = run_diff_index(&rev_info, 1);
+	result = run_diff_index(&rev_info, DIFF_INDEX_CACHED);
 	result = diff_result_code(&rev_info.diffopt, result);
 	release_revisions(&rev_info);
 	return result;
-- 
2.42.0.rc2.423.g967ecb4f2b

