Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A525EEE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjHUUUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjHUUUt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:20:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D48E3
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:20:47 -0700 (PDT)
Received: (qmail 17397 invoked by uid 109); 21 Aug 2023 20:20:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:20:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18735 invoked by uid 111); 21 Aug 2023 20:20:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:20:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:20:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 7/7] diff: drop useless "status" parameter from
 diff_result_code()
Message-ID: <20230821202046.GG1798590@coredump.intra.peff.net>
References: <20230821201358.GA2663749@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821201358.GA2663749@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many programs use diff_result_code() to get a user-visible program exit
code from a diff result (e.g., checking opts.found_changes if
--exit-code was requested).

This function also takes a "status" parameter, which seems at first
glance that it could be used to propagate an error encountered when
computing the diff. But it doesn't work that way:

  - negative values are passed through as-is, but are not appropriate as
    program exit codes

  - when --exit-code or --check is in effect, we _ignore_ the passed-in
    status completely. So a failed diff which did not have a chance to
    set opts.found_changes would erroneously report "success, no
    changes" instead of propagating the error.

After recent cleanups, neither of these bugs is possible to trigger, as
every caller just passes in "0". So rather than fixing them, we can
simply drop the useless parameter instead.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c          | 2 +-
 builtin/diff-files.c        | 2 +-
 builtin/diff-index.c        | 2 +-
 builtin/diff-tree.c         | 2 +-
 builtin/diff.c              | 2 +-
 builtin/log.c               | 2 +-
 builtin/stash.c             | 6 +++---
 builtin/submodule--helper.c | 2 +-
 diff-no-index.c             | 2 +-
 diff.c                      | 6 ++----
 diff.h                      | 2 +-
 wt-status.c                 | 4 ++--
 12 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 8cdc25b748..a9e375882b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -687,7 +687,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 				BUG("malformed internal diff-index command line");
 			run_diff_index(&revs, 0);
 
-			if (!diff_result_code(&revs.diffopt, 0))
+			if (!diff_result_code(&revs.diffopt))
 				suffix = NULL;
 			else
 				suffix = dirty;
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 04070607b1..f38912cd40 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -83,7 +83,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0)
 		die_errno("repo_read_index_preload");
 	run_diff_files(&rev, options);
-	result = diff_result_code(&rev.diffopt, 0);
+	result = diff_result_code(&rev.diffopt);
 	release_revisions(&rev);
 	return result;
 }
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 2c6a179832..220f341ffa 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -73,7 +73,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		return -1;
 	}
 	run_diff_index(&rev, option);
-	result = diff_result_code(&rev.diffopt, 0);
+	result = diff_result_code(&rev.diffopt);
 	release_revisions(&rev);
 	return result;
 }
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index c9ba35f143..86be634286 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -232,5 +232,5 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		diff_free(&opt->diffopt);
 	}
 
-	return diff_result_code(&opt->diffopt, 0);
+	return diff_result_code(&opt->diffopt);
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index 3eba691b82..0b313549c7 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -608,7 +608,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		builtin_diff_combined(&rev, argc, argv,
 				      ent.objects, ent.nr,
 				      first_non_parent);
-	result = diff_result_code(&rev.diffopt, 0);
+	result = diff_result_code(&rev.diffopt);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
 	release_revisions(&rev);
diff --git a/builtin/log.c b/builtin/log.c
index db3a88bfe9..5d808c92f4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -549,7 +549,7 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
 	    rev->diffopt.flags.check_failed) {
 		return 02;
 	}
-	return diff_result_code(&rev->diffopt, 0);
+	return diff_result_code(&rev->diffopt);
 }
 
 static int cmd_log_walk(struct rev_info *rev)
diff --git a/builtin/stash.c b/builtin/stash.c
index e799b660f0..53e8868ba1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -973,7 +973,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	}
 	log_tree_diff_flush(&rev);
 
-	ret = diff_result_code(&rev.diffopt, 0);
+	ret = diff_result_code(&rev.diffopt);
 cleanup:
 	strvec_clear(&stash_args);
 	free_stash_info(&info);
@@ -1111,13 +1111,13 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	diff_setup_done(&rev.diffopt);
 
 	run_diff_index(&rev, DIFF_INDEX_CACHED);
-	if (diff_result_code(&rev.diffopt, 0)) {
+	if (diff_result_code(&rev.diffopt)) {
 		ret = 1;
 		goto done;
 	}
 
 	run_diff_files(&rev, 0);
-	if (diff_result_code(&rev.diffopt, 0)) {
+	if (diff_result_code(&rev.diffopt)) {
 		ret = 1;
 		goto done;
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3764ed1f9c..6f3bf33e61 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -670,7 +670,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	setup_revisions(diff_files_args.nr, diff_files_args.v, &rev, &opt);
 	run_diff_files(&rev, 0);
 
-	if (!diff_result_code(&rev.diffopt, 0)) {
+	if (!diff_result_code(&rev.diffopt)) {
 		print_status(flags, ' ', path, ce_oid,
 			     displaypath);
 	} else if (!(flags & OPT_CACHED)) {
diff --git a/diff-no-index.c b/diff-no-index.c
index 4771cf02aa..8aead3e332 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -364,7 +364,7 @@ int diff_no_index(struct rev_info *revs,
 	 * The return code for --no-index imitates diff(1):
 	 * 0 = no changes, 1 = changes, else error
 	 */
-	ret = diff_result_code(&revs->diffopt, 0);
+	ret = diff_result_code(&revs->diffopt);
 
 out:
 	for (i = 0; i < ARRAY_SIZE(to_free); i++)
diff --git a/diff.c b/diff.c
index ee3eb629e3..2de5d3d098 100644
--- a/diff.c
+++ b/diff.c
@@ -6973,16 +6973,14 @@ void diffcore_std(struct diff_options *options)
 	options->found_follow = 0;
 }
 
-int diff_result_code(struct diff_options *opt, int status)
+int diff_result_code(struct diff_options *opt)
 {
 	int result = 0;
 
 	diff_warn_rename_limit("diff.renameLimit",
 			       opt->needed_rename_limit,
 			       opt->degraded_cc_to_c);
-	if (!opt->flags.exit_with_status &&
-	    !(opt->output_format & DIFF_FORMAT_CHECKDIFF))
-		return status;
+
 	if (opt->flags.exit_with_status &&
 	    opt->flags.has_changes)
 		result |= 01;
diff --git a/diff.h b/diff.h
index 528f00d5e1..caf1528bf0 100644
--- a/diff.h
+++ b/diff.h
@@ -647,7 +647,7 @@ int do_diff_cache(const struct object_id *, struct diff_options *);
 int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
 void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx);
 
-int diff_result_code(struct diff_options *, int);
+int diff_result_code(struct diff_options *);
 
 int diff_no_index(struct rev_info *,
 		  int implicit_no_index, int, const char **);
diff --git a/wt-status.c b/wt-status.c
index 545cea948f..981adb09f3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2581,7 +2581,7 @@ int has_unstaged_changes(struct repository *r, int ignore_submodules)
 	rev_info.diffopt.flags.quick = 1;
 	diff_setup_done(&rev_info.diffopt);
 	run_diff_files(&rev_info, 0);
-	result = diff_result_code(&rev_info.diffopt, 0);
+	result = diff_result_code(&rev_info.diffopt);
 	release_revisions(&rev_info);
 	return result;
 }
@@ -2615,7 +2615,7 @@ int has_uncommitted_changes(struct repository *r,
 
 	diff_setup_done(&rev_info.diffopt);
 	run_diff_index(&rev_info, DIFF_INDEX_CACHED);
-	result = diff_result_code(&rev_info.diffopt, 0);
+	result = diff_result_code(&rev_info.diffopt);
 	release_revisions(&rev_info);
 	return result;
 }
-- 
2.42.0.rc2.423.g967ecb4f2b
