Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B5BEE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjHUUS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHUUS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:18:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF70E4
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:18:56 -0700 (PDT)
Received: (qmail 17375 invoked by uid 109); 21 Aug 2023 20:18:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:18:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18681 invoked by uid 111); 21 Aug 2023 20:18:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:18:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:18:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 5/7] diff: drop useless return from run_diff_{files,index}
 functions
Message-ID: <20230821201855.GE1798590@coredump.intra.peff.net>
References: <20230821201358.GA2663749@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821201358.GA2663749@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neither of these functions ever returns a value other than zero.
Instead, they expect unrecoverable errors to exit immediately, and
things like "--exit-code" are stored inside the diff_options struct to
be handled later via diff_result_code().

Some callers do check the return values, but many don't bother. Let's
drop the useless return values, which are misleading callers about how
the functions work. This could be seen as a step in the wrong direction,
as we might want to eventually "lib-ify" these to more cleanly return
errors up the stack, in which case we'd have to add the return values
back in. But there are some benefits to doing this now:

  1. In the current code, somebody could accidentally add a "return -1"
     to one of the functions, which would be erroneously ignored by many
     callers. By removing the return code, the compiler can notice the
     mismatch and force the developer to decide what to do.

     Obviously the other option here is that we could start consistently
     checking the error code in every caller. But it would be dead code,
     and we wouldn't get any compile-time help in catching new cases.

  2. It communicates the situation to callers, who may want to choose a
     different function. These functions are really thin wrappers for
     doing git-diff-files and git-diff-index within the process. But
     callers who care about recovering from an error here are probably
     better off using the underlying library functions, many of
     which do return errors.

If somebody eventually wants to teach these functions to propagate
errors, they'll have to switch back to returning a value, effectively
reverting this patch. But at least then they will be starting with a
level playing field: they know that they will need to inspect each
caller to see how it should handle the error.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/add.c               |  3 +--
 builtin/describe.c          |  6 +++---
 builtin/diff-files.c        |  4 ++--
 builtin/diff-index.c        |  4 ++--
 builtin/diff.c              |  6 ++++--
 builtin/stash.c             | 14 +++++---------
 builtin/submodule--helper.c |  5 ++---
 diff-lib.c                  |  6 ++----
 diff.h                      |  4 ++--
 wt-status.c                 |  8 ++++----
 10 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 4b0dd798df..12c5aa6d1f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -194,8 +194,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	out = xopen(file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	rev.diffopt.file = xfdopen(out, "w");
 	rev.diffopt.close_file = 1;
-	if (run_diff_files(&rev, 0))
-		die(_("Could not write patch"));
+	run_diff_files(&rev, 0);
 
 	if (launch_editor(file, NULL, NULL))
 		die(_("editing patch failed"));
diff --git a/builtin/describe.c b/builtin/describe.c
index b28a4a1f82..8cdc25b748 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -668,7 +668,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			struct lock_file index_lock = LOCK_INIT;
 			struct rev_info revs;
 			struct strvec args = STRVEC_INIT;
-			int fd, result;
+			int fd;
 
 			setup_work_tree();
 			prepare_repo_settings(the_repository);
@@ -685,9 +685,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			strvec_pushv(&args, diff_index_args);
 			if (setup_revisions(args.nr, args.v, &revs, NULL) != 1)
 				BUG("malformed internal diff-index command line");
-			result = run_diff_index(&revs, 0);
+			run_diff_index(&revs, 0);
 
-			if (!diff_result_code(&revs.diffopt, result))
+			if (!diff_result_code(&revs.diffopt, 0))
 				suffix = NULL;
 			else
 				suffix = dirty;
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 2e3e948583..04070607b1 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -82,8 +82,8 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 
 	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0)
 		die_errno("repo_read_index_preload");
-	result = run_diff_files(&rev, options);
-	result = diff_result_code(&rev.diffopt, result);
+	run_diff_files(&rev, options);
+	result = diff_result_code(&rev.diffopt, 0);
 	release_revisions(&rev);
 	return result;
 }
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 9db7139b83..2c6a179832 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -72,8 +72,8 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		perror("repo_read_index");
 		return -1;
 	}
-	result = run_diff_index(&rev, option);
-	result = diff_result_code(&rev.diffopt, result);
+	run_diff_index(&rev, option);
+	result = diff_result_code(&rev.diffopt, 0);
 	release_revisions(&rev);
 	return result;
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index 005f415d36..e1f7647c84 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -168,7 +168,8 @@ static int builtin_diff_index(struct rev_info *revs,
 	} else if (repo_read_index(the_repository) < 0) {
 		die_errno("repo_read_cache");
 	}
-	return run_diff_index(revs, option);
+	run_diff_index(revs, option);
+	return 0;
 }
 
 static int builtin_diff_tree(struct rev_info *revs,
@@ -289,7 +290,8 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 				    0) < 0) {
 		die_errno("repo_read_index_preload");
 	}
-	return run_diff_files(revs, options);
+	run_diff_files(revs, options);
+	return 0;
 }
 
 struct symdiff {
diff --git a/builtin/stash.c b/builtin/stash.c
index fe5052f12f..e799b660f0 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1089,7 +1089,6 @@ static int get_untracked_files(const struct pathspec *ps, int include_untracked,
  */
 static int check_changes_tracked_files(const struct pathspec *ps)
 {
-	int result;
 	struct rev_info rev;
 	struct object_id dummy;
 	int ret = 0;
@@ -1111,14 +1110,14 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	add_head_to_pending(&rev);
 	diff_setup_done(&rev.diffopt);
 
-	result = run_diff_index(&rev, DIFF_INDEX_CACHED);
-	if (diff_result_code(&rev.diffopt, result)) {
+	run_diff_index(&rev, DIFF_INDEX_CACHED);
+	if (diff_result_code(&rev.diffopt, 0)) {
 		ret = 1;
 		goto done;
 	}
 
-	result = run_diff_files(&rev, 0);
-	if (diff_result_code(&rev.diffopt, result)) {
+	run_diff_files(&rev, 0);
+	if (diff_result_code(&rev.diffopt, 0)) {
 		ret = 1;
 		goto done;
 	}
@@ -1309,10 +1308,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 
 	add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
 			   "");
-	if (run_diff_index(&rev, 0)) {
-		ret = -1;
-		goto done;
-	}
+	run_diff_index(&rev, 0);
 
 	cp_upd_index.git_cmd = 1;
 	strvec_pushl(&cp_upd_index.args, "update-index",
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 125ea80d21..3764ed1f9c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -629,7 +629,6 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	char *displaypath;
 	struct strvec diff_files_args = STRVEC_INIT;
 	struct rev_info rev = REV_INFO_INIT;
-	int diff_files_result;
 	struct strbuf buf = STRBUF_INIT;
 	const char *git_dir;
 	struct setup_revision_opt opt = {
@@ -669,9 +668,9 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.abbrev = 0;
 	setup_revisions(diff_files_args.nr, diff_files_args.v, &rev, &opt);
-	diff_files_result = run_diff_files(&rev, 0);
+	run_diff_files(&rev, 0);
 
-	if (!diff_result_code(&rev.diffopt, diff_files_result)) {
+	if (!diff_result_code(&rev.diffopt, 0)) {
 		print_status(flags, ' ', path, ce_oid,
 			     displaypath);
 	} else if (!(flags & OPT_CACHED)) {
diff --git a/diff-lib.c b/diff-lib.c
index cfa3489111..d8aa777a73 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -96,7 +96,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	return changed;
 }
 
-int run_diff_files(struct rev_info *revs, unsigned int option)
+void run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
 	int diff_unmerged_stage = revs->max_count;
@@ -272,7 +272,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	trace_performance_since(start, "diff-files");
-	return 0;
 }
 
 /*
@@ -606,7 +605,7 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 	free_commit_list(merge_bases);
 }
 
-int run_diff_index(struct rev_info *revs, unsigned int option)
+void run_diff_index(struct rev_info *revs, unsigned int option)
 {
 	struct object_array_entry *ent;
 	int cached = !!(option & DIFF_INDEX_CACHED);
@@ -640,7 +639,6 @@ int run_diff_index(struct rev_info *revs, unsigned int option)
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	trace_performance_leave("diff-index");
-	return 0;
 }
 
 int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
diff --git a/diff.h b/diff.h
index 260c454155..528f00d5e1 100644
--- a/diff.h
+++ b/diff.h
@@ -637,11 +637,11 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb);
 #define DIFF_SILENT_ON_REMOVED 01
 /* report racily-clean paths as modified */
 #define DIFF_RACY_IS_MODIFIED 02
-int run_diff_files(struct rev_info *revs, unsigned int option);
+void run_diff_files(struct rev_info *revs, unsigned int option);
 
 #define DIFF_INDEX_CACHED 01
 #define DIFF_INDEX_MERGE_BASE 02
-int run_diff_index(struct rev_info *revs, unsigned int option);
+void run_diff_index(struct rev_info *revs, unsigned int option);
 
 int do_diff_cache(const struct object_id *, struct diff_options *);
 int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
diff --git a/wt-status.c b/wt-status.c
index bf8687b357..545cea948f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2580,8 +2580,8 @@ int has_unstaged_changes(struct repository *r, int ignore_submodules)
 	}
 	rev_info.diffopt.flags.quick = 1;
 	diff_setup_done(&rev_info.diffopt);
-	result = run_diff_files(&rev_info, 0);
-	result = diff_result_code(&rev_info.diffopt, result);
+	run_diff_files(&rev_info, 0);
+	result = diff_result_code(&rev_info.diffopt, 0);
 	release_revisions(&rev_info);
 	return result;
 }
@@ -2614,8 +2614,8 @@ int has_uncommitted_changes(struct repository *r,
 	}
 
 	diff_setup_done(&rev_info.diffopt);
-	result = run_diff_index(&rev_info, DIFF_INDEX_CACHED);
-	result = diff_result_code(&rev_info.diffopt, result);
+	run_diff_index(&rev_info, DIFF_INDEX_CACHED);
+	result = diff_result_code(&rev_info.diffopt, 0);
 	release_revisions(&rev_info);
 	return result;
 }
-- 
2.42.0.rc2.423.g967ecb4f2b

