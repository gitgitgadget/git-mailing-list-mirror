Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA42C8D1
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242702; cv=none; b=TjU4Tswg20Y889pSQkegxmTcWr+QE6KuMiI+Tv0CedIjMOs2BYTkKUf1tWyxAiMh3bHCqMxePhG+LYGrerUkEqBEwD6LgAN2xnsg0KMUNtEl3DPTiqPCR58ek4Wa24rWkmq8T4L+W7wHJJzNJnjgzPBbgD2fxEDCO8N1yEhd3vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242702; c=relaxed/simple;
	bh=josdxg+Aedxeq6lD4hAZcD9IliyYZxCru2Hyc+UzW/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L6LXC4t+bIF88NGcIWn0tjbH6nwHsdcTnL0+Pjqnx+FwwNXgEf8l/zqImhhPk95Gz2LgiaeQ+wd8T/22vpveF+gmBbuLv0qeQtkA2hBbWBydTEn1fut9XVeIWSV3XOm+3PGx9MxihP2fMfyxIQ6auvFLgsXtXTXMolCCROJuENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D+27KUzF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D+27KUzF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D2BAC20DF1;
	Fri,  9 Aug 2024 18:31:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=josdxg+Aedxeq6lD4hAZcD9IliyYZxCru2Hyc+
	UzW/U=; b=D+27KUzFKpcO2FQWyrcvPempdbIokf5Jj2xLtJAI3YX1dcS2tsU1C0
	IwheS2dCIKvrMllQZlsFSrY6MMa8LmMAMWaAgYXroMSwKZEonbr/PjwXcnaz4Rz0
	uRe1aMBG5oSa4qCB+ZyNuAG0WGX1xPdVuqbP72J1QXxlKixvgyS8w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CABEC20DF0;
	Fri,  9 Aug 2024 18:31:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CDFFF20DEF;
	Fri,  9 Aug 2024 18:31:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,  blanet <bupt_xingxin@163.com>,  Xing
 Xin <xingxin.xx@bytedance.com>
Subject: [PATCH 2/2] remerge-diff: clean up temporary objdir at a central place
In-Reply-To: <xmqqv8099vms.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	09 Aug 2024 15:30:51 -0700")
References: <xmqqv8099vms.fsf@gitster.g>
Date: Fri, 09 Aug 2024 15:31:35 -0700
Message-ID: <xmqqr0ax9vlk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2395E642-569F-11EF-B5CC-E92ED1CD468F-77302942!pb-smtp21.pobox.com

After running a diff between two things, or a series of diffs while
walking the history, the diff computation is concluded by a call to
diff_result_code() to extract the exit status of the diff machinery.

The function can work on "struct diffopt", but all the callers
historically and currently pass "struct diffopt" that is embedded in
the "struct rev_info" that is used to hold the remerge_diff bit and
the remerge_objdir variable that points at the temporary object
directory in use.

Redefine diff_result_code() to take the whole "struct rev_info" to
give it an access to these members related to remerge-diff, so that
it can get rid of the temporary object directory for any and all
callers that used the feature.  We can lose the equivalent code to
do so from the code paths for individual commands, diff-tree, diff,
and log.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c          |  2 +-
 builtin/diff-files.c        |  2 +-
 builtin/diff-index.c        |  2 +-
 builtin/diff-tree.c         |  7 +------
 builtin/diff.c              |  2 +-
 builtin/log.c               | 11 ++++-------
 builtin/stash.c             |  6 +++---
 builtin/submodule--helper.c |  2 +-
 diff-no-index.c             |  2 +-
 diff.c                      | 10 +++++++++-
 diff.h                      |  2 +-
 wt-status.c                 |  4 ++--
 12 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index d6c77a714f..a1457d59e8 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -687,7 +687,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 				BUG("malformed internal diff-index command line");
 			run_diff_index(&revs, 0);
 
-			if (!diff_result_code(&revs.diffopt))
+			if (!diff_result_code(&revs))
 				suffix = NULL;
 			else
 				suffix = dirty;
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 018011f29e..dd0b76e7d5 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -82,7 +82,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0)
 		die_errno("repo_read_index_preload");
 	run_diff_files(&rev, options);
-	result = diff_result_code(&rev.diffopt);
+	result = diff_result_code(&rev);
 	release_revisions(&rev);
 	return result;
 }
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 3e05260ac0..560c099524 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -71,7 +71,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		return -1;
 	}
 	run_diff_index(&rev, option);
-	result = diff_result_code(&rev.diffopt);
+	result = diff_result_code(&rev);
 	release_revisions(&rev);
 	return result;
 }
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index af51cd29c6..995225ef5f 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -232,10 +232,5 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		diff_free(&opt->diffopt);
 	}
 
-	if (opt->remerge_diff) {
-		tmp_objdir_destroy(opt->remerge_objdir);
-		opt->remerge_objdir = NULL;
-	}
-
-	return diff_result_code(&opt->diffopt);
+	return diff_result_code(opt);
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index 6e196e0c7d..a5834704aa 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -605,7 +605,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		builtin_diff_combined(&rev, argc, argv,
 				      ent.objects, ent.nr,
 				      first_non_parent);
-	result = diff_result_code(&rev.diffopt);
+	result = diff_result_code(&rev);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
 	release_revisions(&rev);
diff --git a/builtin/log.c b/builtin/log.c
index 227823a16e..b1a8fa73b1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -493,6 +493,7 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
 	struct commit *commit;
 	int saved_nrl = 0;
 	int saved_dcctc = 0;
+	int result;
 
 	if (rev->early_output)
 		setup_early_output();
@@ -533,16 +534,12 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
 	rev->diffopt.degraded_cc_to_c = saved_dcctc;
 	rev->diffopt.needed_rename_limit = saved_nrl;
 
-	if (rev->remerge_diff) {
-		tmp_objdir_destroy(rev->remerge_objdir);
-		rev->remerge_objdir = NULL;
-	}
-
+	result = diff_result_code(rev);
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
 	    rev->diffopt.flags.check_failed) {
-		return 02;
+		result = 02;
 	}
-	return diff_result_code(&rev->diffopt);
+	return result;
 }
 
 static int cmd_log_walk(struct rev_info *rev)
diff --git a/builtin/stash.c b/builtin/stash.c
index 7fb355bff0..6dc70a6be2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -972,7 +972,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	}
 	log_tree_diff_flush(&rev);
 
-	ret = diff_result_code(&rev.diffopt);
+	ret = diff_result_code(&rev);
 cleanup:
 	strvec_clear(&stash_args);
 	free_stash_info(&info);
@@ -1116,13 +1116,13 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	diff_setup_done(&rev.diffopt);
 
 	run_diff_index(&rev, DIFF_INDEX_CACHED);
-	if (diff_result_code(&rev.diffopt)) {
+	if (diff_result_code(&rev)) {
 		ret = 1;
 		goto done;
 	}
 
 	run_diff_files(&rev, 0);
-	if (diff_result_code(&rev.diffopt)) {
+	if (diff_result_code(&rev)) {
 		ret = 1;
 		goto done;
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index cc0db6336c..96d2889907 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -675,7 +675,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	setup_revisions(diff_files_args.nr, diff_files_args.v, &rev, &opt);
 	run_diff_files(&rev, 0);
 
-	if (!diff_result_code(&rev.diffopt)) {
+	if (!diff_result_code(&rev)) {
 		print_status(flags, ' ', path, ce_oid,
 			     displaypath);
 	} else if (!(flags & OPT_CACHED)) {
diff --git a/diff-no-index.c b/diff-no-index.c
index 3a8965672c..c5fb06e6d1 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -362,7 +362,7 @@ int diff_no_index(struct rev_info *revs,
 	 * The return code for --no-index imitates diff(1):
 	 * 0 = no changes, 1 = changes, else error
 	 */
-	ret = diff_result_code(&revs->diffopt);
+	ret = diff_result_code(revs);
 
 out:
 	for (i = 0; i < ARRAY_SIZE(to_free); i++)
diff --git a/diff.c b/diff.c
index ccfa1fca0d..970ea47710 100644
--- a/diff.c
+++ b/diff.c
@@ -9,6 +9,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "tempfile.h"
+#include "revision.h"
 #include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -26,6 +27,7 @@
 #include "merge-ll.h"
 #include "string-list.h"
 #include "strvec.h"
+#include "tmp-objdir.h"
 #include "graph.h"
 #include "oid-array.h"
 #include "packfile.h"
@@ -7012,10 +7014,16 @@ void diffcore_std(struct diff_options *options)
 	options->found_follow = 0;
 }
 
-int diff_result_code(struct diff_options *opt)
+int diff_result_code(struct rev_info *revs)
 {
+	struct diff_options *opt = &revs->diffopt;
 	int result = 0;
 
+	if (revs->remerge_diff) {
+		tmp_objdir_destroy(revs->remerge_objdir);
+		revs->remerge_objdir = NULL;
+	}
+
 	diff_warn_rename_limit("diff.renameLimit",
 			       opt->needed_rename_limit,
 			       opt->degraded_cc_to_c);
diff --git a/diff.h b/diff.h
index 66bd8aeb29..1966ba6bb7 100644
--- a/diff.h
+++ b/diff.h
@@ -648,7 +648,7 @@ int do_diff_cache(const struct object_id *, struct diff_options *);
 int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
 void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx);
 
-int diff_result_code(struct diff_options *);
+int diff_result_code(struct rev_info *);
 
 int diff_no_index(struct rev_info *,
 		  int implicit_no_index, int, const char **);
diff --git a/wt-status.c b/wt-status.c
index 9e8c08003b..d1c3f3dc4d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2582,7 +2582,7 @@ int has_unstaged_changes(struct repository *r, int ignore_submodules)
 	rev_info.diffopt.flags.quick = 1;
 	diff_setup_done(&rev_info.diffopt);
 	run_diff_files(&rev_info, 0);
-	result = diff_result_code(&rev_info.diffopt);
+	result = diff_result_code(&rev_info);
 	release_revisions(&rev_info);
 	return result;
 }
@@ -2616,7 +2616,7 @@ int has_uncommitted_changes(struct repository *r,
 
 	diff_setup_done(&rev_info.diffopt);
 	run_diff_index(&rev_info, DIFF_INDEX_CACHED);
-	result = diff_result_code(&rev_info.diffopt);
+	result = diff_result_code(&rev_info);
 	release_revisions(&rev_info);
 	return result;
 }
-- 
2.46.0-326-g1e046905fc

