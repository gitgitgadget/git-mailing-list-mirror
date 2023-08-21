Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9747BEE49AA
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 16:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjHUQVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 12:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjHUQVz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 12:21:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412A7E3
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 09:21:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 978F31B9C18;
        Mon, 21 Aug 2023 12:21:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=oyb4WvRV1iF+0aIY8yfan4lS9JJhZW1XXwoM9vg56xo=; b=x4Uv
        k7Oo4oznVyCKwbMy6Z30BXP+NW+teN5inC+08f9iMNRc/20A4gwWQGZdfM0jdkKY
        ykjs0wfUi4xe2O8DkHx8m6WFbuGZ9jeb4n5A7JH9UT63lfdhCuh/Yg96R52Yiaxt
        1uRDw3bTKIjLTgRAZI+pJU1sStQ9jNYGnGtKdEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F6721B9C17;
        Mon, 21 Aug 2023 12:21:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F01DD1B9C16;
        Mon, 21 Aug 2023 12:21:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH] diff: spell DIFF_INDEX_CACHED out when calling
 run_diff_index()
References: <CAHxTZ4AUxow1p7mNG0fuRtfhkaOu=Wpc7cYvM8wRaB80hPNf9Q@mail.gmail.com>
        <20230821003532.GA1113755@coredump.intra.peff.net>
        <xmqqlee4s82d.fsf@gitster.g>
Date:   Mon, 21 Aug 2023 09:21:50 -0700
Message-ID: <xmqqfs4cqsbl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6259F82-403E-11EE-8450-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 add-interactive.c           | 2 +-
 builtin/am.c                | 4 ++--
 builtin/stash.c             | 2 +-
 builtin/submodule--helper.c | 2 +-
 diff-lib.c                  | 2 +-
 wt-status.c                 | 6 +++---
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git c/add-interactive.c w/add-interactive.c
index add9a1ad43..7fd00c5e25 100644
--- c/add-interactive.c
+++ w/add-interactive.c
@@ -569,7 +569,7 @@ static int get_modified_files(struct repository *r,
 			copy_pathspec(&rev.prune_data, ps);
 
 		if (s.mode == FROM_INDEX)
-			run_diff_index(&rev, 1);
+			run_diff_index(&rev, DIFF_INDEX_CACHED);
 		else {
 			rev.diffopt.flags.ignore_dirty_submodules = 1;
 			run_diff_files(&rev, 0);
diff --git c/builtin/am.c w/builtin/am.c
index 8bde034fae..202040b62e 100644
--- c/builtin/am.c
+++ w/builtin/am.c
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
 
diff --git c/builtin/stash.c w/builtin/stash.c
index fe64cde9ce..fe5052f12f 100644
--- c/builtin/stash.c
+++ w/builtin/stash.c
@@ -1111,7 +1111,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	add_head_to_pending(&rev);
 	diff_setup_done(&rev.diffopt);
 
-	result = run_diff_index(&rev, 1);
+	result = run_diff_index(&rev, DIFF_INDEX_CACHED);
 	if (diff_result_code(&rev.diffopt, result)) {
 		ret = 1;
 		goto done;
diff --git c/builtin/submodule--helper.c w/builtin/submodule--helper.c
index f6871efd95..125ea80d21 100644
--- c/builtin/submodule--helper.c
+++ w/builtin/submodule--helper.c
@@ -1141,7 +1141,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	}
 
 	if (diff_cmd == DIFF_INDEX)
-		run_diff_index(&rev, info->cached);
+		run_diff_index(&rev, info->cached ? DIFF_INDEX_CACHED : 0);
 	else
 		run_diff_files(&rev, 0);
 	prepare_submodule_summary(info, &list);
diff --git c/diff-lib.c w/diff-lib.c
index 6b0c6a7180..cfa3489111 100644
--- c/diff-lib.c
+++ w/diff-lib.c
@@ -682,7 +682,7 @@ int index_differs_from(struct repository *r,
 			rev.diffopt.flags.ignore_submodules = flags->ignore_submodules;
 	}
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
-	run_diff_index(&rev, 1);
+	run_diff_index(&rev, DIFF_INDEX_CACHED);
 	has_changes = rev.diffopt.flags.has_changes;
 	release_revisions(&rev);
 	return (has_changes != 0);
diff --git c/wt-status.c w/wt-status.c
index 5b1378965c..bf8687b357 100644
--- c/wt-status.c
+++ w/wt-status.c
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
