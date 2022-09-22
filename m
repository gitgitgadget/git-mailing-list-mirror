Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3407ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 23:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiIVXaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 19:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIVXaR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 19:30:17 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6458675498
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:30:15 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b11-20020a170902d50b00b0017828988079so6983611plg.21
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=/v973hIij0Cz/vgZIDmfw3zytFfwgoiV/WjJhMcc2Pc=;
        b=oSa1GTQUdqvJS9eCvkGstCnfVJi8sOth+B1Hg8rb2b0o1xgrZvmovQ0IVktaG0EciS
         hr/bf1c5q/xT66rsBjrvpnbl5deuFPKd5dwULwCX1Rt5KqmDcM33EWWxR0cF0Hq/OSdD
         1XHNyiY6l4LYMHEvuN06rUX6o0MZJEvVCBn8x4LLi/Hlsmgk7Ed1bAGgpCnm4pPx+rk7
         cy8iOkK1jDPikBRNOr3Vd2BHnXYBZLA0+dxv+w4fQL+imytlI9mOCQYKjFaInbkeyH9v
         pOseTjmPsaTlXN7QN/dsCvvL6RsaM9gHuyipHdqLK833vewLGJ9KQ4Y9gTWTpcmsZhh5
         wRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=/v973hIij0Cz/vgZIDmfw3zytFfwgoiV/WjJhMcc2Pc=;
        b=NbUZnfqhUVIHsPIE7ACl3+meZ/c/cLZ8wa/bMNOhyPYtU5uwbnflcj/EhSJnC66owB
         hWDDC2DyXDVEub5yEu4eBhMz/3bOq6viEG8fnrtiqzEcFMKkcaBqRuIj7V01Oa+xT5DK
         qsXUUut7z+QpH5ybT+8Rpe478UZ6m78CSrNKIv8/7fDHSjz/DPrv5CLSyYjMX1my/m2U
         sSO8VQZMb36Wy2k7PgwyIzo/LTAMSsR+0Uee7una3fyErJVH3sCF8BkJMtWRtVou7bVp
         Zh2m4qk0uJzPDKWTZSWnie192q12SFvkaBYMfQttxgJG1HZms24GXKureWSxGFOxpOpL
         UPaA==
X-Gm-Message-State: ACrzQf3ss2HdrOxCVeSK+/Ig1Ey9bIdIBWIOnlcunQ1mL29bzYEH3T+x
        CxO/XaWJw/oEtx34aWpyqwFu157/K8aqggBU7TPDAlL3XeDCgZDOBhacUqZFLbRa22xL8LNeMQT
        ZMPocYxLtEv6vsUQF7XheERuab7WANQGeI+Cd36TR/4VrgJd4VrlQLa8c31X1D6qftg==
X-Google-Smtp-Source: AMsMyM5YcWQyi/BjZffB5XmoovyXYabqnm6KajzhWAnnDSgi4cO8wsAYThLtx0hsu9NBWcuZBH0j3Z5UrEOUds0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:ef82:b0:178:72bc:983b with SMTP
 id iz2-20020a170902ef8200b0017872bc983bmr5706632plb.0.1663889415052; Thu, 22
 Sep 2022 16:30:15 -0700 (PDT)
Date:   Thu, 22 Sep 2022 23:29:47 +0000
In-Reply-To: <20220922232947.631309-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922232947.631309-5-calvinwan@google.com>
Subject: [PATCH 4/4] diff-lib: parallelize run_diff_files for submodules
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the iteration of the index entries in run_diff_files, whenever
a submodule is found and needs its status checked, a subprocess is
spawned for it. Instead of spawning the subprocess immediately and
waiting for its completion to continue, hold onto all submodules and
relevant information in a list. Then use that list to create tasks for
run_processes_parallel. Finished subprocesses pipe their output to
status_finish which parses it and sets the relevant variables.

Add config option status.parallelSubmodules to set the maximum number
of parallel jobs. 

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/config/status.txt |   6 ++
 add-interactive.c               |   2 +-
 builtin/add.c                   |   4 +-
 builtin/commit.c                |   6 ++
 builtin/diff-files.c            |   2 +-
 builtin/diff.c                  |   2 +-
 builtin/merge.c                 |   2 +-
 builtin/stash.c                 |   2 +-
 builtin/submodule--helper.c     |   4 +-
 diff-lib.c                      |  55 +++++++++++--
 diff.h                          |   2 +-
 submodule.c                     | 142 ++++++++++++++++++++++++++++++++
 submodule.h                     |   9 ++
 wt-status.c                     |   6 +-
 wt-status.h                     |   1 +
 15 files changed, 226 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/status.txt b/Documentation/config/status.txt
index 0fc704ab80..92c5511fec 100644
--- a/Documentation/config/status.txt
+++ b/Documentation/config/status.txt
@@ -75,3 +75,9 @@ status.submoduleSummary::
 	the --ignore-submodules=dirty command-line option or the 'git
 	submodule summary' command, which shows a similar output but does
 	not honor these settings.
+
+status.parallelSubmodules::
+	When linkgit:git-status[1] is run in a superproject with
+	submodules, a status subprocess is spawned for every submodule.
+	This option specifies the number of submodule status subprocesses
+	to run in parallel. If unset, it defaults to 1.
diff --git a/add-interactive.c b/add-interactive.c
index 22fcd3412c..3e38aa833d 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -565,7 +565,7 @@ static int get_modified_files(struct repository *r,
 			run_diff_index(&rev, 1);
 		else {
 			rev.diffopt.flags.ignore_dirty_submodules = 1;
-			run_diff_files(&rev, 0);
+			run_diff_files(&rev, 0, -1);
 		}
 
 		release_revisions(&rev);
diff --git a/builtin/add.c b/builtin/add.c
index f84372964c..094d59c1b4 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -148,7 +148,7 @@ int add_files_to_cache(const char *prefix,
 	 * may not have their own transaction active.
 	 */
 	begin_odb_transaction();
-	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED, -1);
 	end_odb_transaction();
 
 	release_revisions(&rev);
@@ -325,7 +325,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	out = xopen(file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	rev.diffopt.file = xfdopen(out, "w");
 	rev.diffopt.close_file = 1;
-	if (run_diff_files(&rev, 0))
+	if (run_diff_files(&rev, 0, -1))
 		die(_("Could not write patch"));
 
 	if (launch_editor(file, NULL, NULL))
diff --git a/builtin/commit.c b/builtin/commit.c
index fcf9c85947..c5147a7952 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1468,6 +1468,12 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		s->detect_rename = git_config_rename(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "status.parallelsubmodules")) {
+		s->parallel_jobs_submodules = git_config_int(k, v);
+		if (s->parallel_jobs_submodules < 0)
+			die(_("status.parallelsubmodules cannot be negative"));
+		return 0;
+	}
 	return git_diff_ui_config(k, v, NULL);
 }
 
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 92cf6e1e92..eb1b576440 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -80,7 +80,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		result = -1;
 		goto cleanup;
 	}
-	result = run_diff_files(&rev, options);
+	result = run_diff_files(&rev, options, -1);
 	result = diff_result_code(&rev.diffopt, result);
 cleanup:
 	release_revisions(&rev);
diff --git a/builtin/diff.c b/builtin/diff.c
index 54bb3de964..c3c532517b 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -275,7 +275,7 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 		perror("read_cache_preload");
 		return -1;
 	}
-	return run_diff_files(revs, options);
+	return run_diff_files(revs, options, -1);
 }
 
 struct symdiff {
diff --git a/builtin/merge.c b/builtin/merge.c
index f7c92c0e64..ff373fa880 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1001,7 +1001,7 @@ static int evaluate_result(void)
 		DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = count_diff_files;
 	rev.diffopt.format_callback_data = &cnt;
-	run_diff_files(&rev, 0);
+	run_diff_files(&rev, 0, -1);
 
 	/*
 	 * Check how many unmerged entries are
diff --git a/builtin/stash.c b/builtin/stash.c
index 30fa101460..097ea55214 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1075,7 +1075,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 		goto done;
 	}
 
-	result = run_diff_files(&rev, 0);
+	result = run_diff_files(&rev, 0, -1);
 	if (diff_result_code(&rev.diffopt, result)) {
 		ret = 1;
 		goto done;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fac52ade5e..b50dbf5e36 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -679,7 +679,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	diff_files_args.nr = setup_revisions(diff_files_args.nr,
 					     diff_files_args.v,
 					     &rev, NULL);
-	diff_files_result = run_diff_files(&rev, 0);
+	diff_files_result = run_diff_files(&rev, 0, -1);
 
 	if (!diff_result_code(&rev.diffopt, diff_files_result)) {
 		print_status(flags, ' ', path, ce_oid,
@@ -1143,7 +1143,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	if (diff_cmd == DIFF_INDEX)
 		run_diff_index(&rev, info->cached);
 	else
-		run_diff_files(&rev, 0);
+		run_diff_files(&rev, 0, -1);
 	prepare_submodule_summary(info, &list);
 cleanup:
 	strvec_clear(&diff_args);
diff --git a/diff-lib.c b/diff-lib.c
index 2e148b79e6..ec745755fc 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -65,14 +65,19 @@ static int check_removed(const struct index_state *istate, const struct cache_en
  * Return 1 when changes are detected, 0 otherwise. If the DIRTY_SUBMODULES
  * option is set, the caller does not only want to know if a submodule is
  * modified at all but wants to know all the conditions that are met (new
- * commits, untracked content and/or modified content).
+ * commits, untracked content and/or modified content). If
+ * defer_submodule_status bit is set, dirty_submodule will be left to the
+ * caller to set. defer_submodule_status can also be set to 0 in this
+ * function if there is no need to check if the submodule is modified.
  */
 static int match_stat_with_submodule(struct diff_options *diffopt,
 				     const struct cache_entry *ce,
 				     struct stat *st, unsigned ce_option,
-				     unsigned *dirty_submodule)
+				     unsigned *dirty_submodule, int *defer_submodule_status,
+					 int *ignore_untracked_in_submodules)
 {
 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
+	int defer = 0;
 	struct diff_flags orig_flags = diffopt->flags;
 	if (!S_ISGITLINK(ce->ce_mode))
 		goto cleanup;
@@ -83,11 +88,20 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 		goto cleanup;
 	}
 	if (!diffopt->flags.ignore_dirty_submodules &&
-		(!changed || diffopt->flags.dirty_submodules))
+		(!changed || diffopt->flags.dirty_submodules)) {
+		if (defer_submodule_status && *defer_submodule_status) {
+			defer = 1;
+			*ignore_untracked_in_submodules =
+							diffopt->flags.ignore_untracked_in_submodules;
+		} else {
 			*dirty_submodule = is_submodule_modified(ce->name,
 							diffopt->flags.ignore_untracked_in_submodules);
+		}
+	}
 cleanup:
 	diffopt->flags = orig_flags;
+	if (defer_submodule_status)
+		*defer_submodule_status = defer;
 	return changed;
 }
 
@@ -117,7 +131,7 @@ static void finish_run_diff_files(struct rev_info *revs,
 			    ce->name, 0, dirty_submodule);
 }
 
-int run_diff_files(struct rev_info *revs, unsigned int option)
+int run_diff_files(struct rev_info *revs, unsigned int option, int parallel_jobs)
 {
 	int entries, i;
 	int diff_unmerged_stage = revs->max_count;
@@ -125,6 +139,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 	uint64_t start = getnanotime();
 	struct index_state *istate = revs->diffopt.repo->index;
+	struct string_list submodules = STRING_LIST_INIT_NODUP;
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
@@ -138,6 +153,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		struct cache_entry *ce = istate->cache[i];
 		int changed;
 		unsigned dirty_submodule = 0;
+		int defer_submodule_status = revs && revs->repo &&
+							!strcmp(revs->repo->gitdir, ".git");
+		int ignore_untracked_in_submodules;
 
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
@@ -269,11 +287,36 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			}
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
-							    ce_option, &dirty_submodule);
+							ce_option, &dirty_submodule,
+							&defer_submodule_status,
+							&ignore_untracked_in_submodules);
 			newmode = ce_mode_from_stat(ce, st.st_mode);
+			if (defer_submodule_status) {
+				struct string_list_item *item =
+								string_list_append(&submodules, ce->name);
+				struct submodule_status_util *util = xmalloc(sizeof(*util));
+				util->changed = changed;
+				util->dirty_submodule = 0;
+				util->ignore_untracked = ignore_untracked_in_submodules;
+				util->newmode = newmode;
+				util->ce = ce;
+				item->util = util;
+				continue;
+			}
 		}
 		finish_run_diff_files(revs, ce, istate, changed, dirty_submodule, newmode);
 	}
+	if (submodules.nr > 0) {
+		if (get_submodules_status(revs->repo, &submodules,
+						parallel_jobs > 0 ? parallel_jobs : 1))
+			BUG("Submodule status failed");
+		for (int i = 0; i < submodules.nr; i++) {
+			struct submodule_status_util *util = submodules.items[i].util;
+
+			finish_run_diff_files(revs, util->ce, NULL, util->changed,
+							util->dirty_submodule, util->newmode);
+		}
+	}
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	trace_performance_since(start, "diff-files");
@@ -321,7 +364,7 @@ static int get_stat_data(const struct index_state *istate,
 			return -1;
 		}
 		changed = match_stat_with_submodule(diffopt, ce, &st,
-						    0, dirty_submodule);
+						    0, dirty_submodule, NULL, NULL);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			oid = null_oid();
diff --git a/diff.h b/diff.h
index 8ae18e5ab1..5a6a615381 100644
--- a/diff.h
+++ b/diff.h
@@ -627,7 +627,7 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb);
 #define DIFF_SILENT_ON_REMOVED 01
 /* report racily-clean paths as modified */
 #define DIFF_RACY_IS_MODIFIED 02
-int run_diff_files(struct rev_info *revs, unsigned int option);
+int run_diff_files(struct rev_info *revs, unsigned int option, int parallel_jobs);
 
 #define DIFF_INDEX_CACHED 01
 #define DIFF_INDEX_MERGE_BASE 02
diff --git a/submodule.c b/submodule.c
index 91213ba83c..15729bb327 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1362,6 +1362,20 @@ int submodule_touches_in_range(struct repository *r,
 	return ret;
 }
 
+struct submodule_parallel_status {
+	int index_count;
+	int result;
+
+	struct string_list *submodule_names;
+	struct repository *r;
+
+	/* Pending statuses by OIDs */
+	struct status_task **oid_status_tasks;
+	int oid_status_tasks_nr, oid_status_tasks_alloc;
+};
+
+#define SPS_INIT { 0 }
+
 struct submodule_parallel_fetch {
 	/*
 	 * The index of the last index entry processed by
@@ -1444,6 +1458,12 @@ struct fetch_task {
 	struct oid_array *commits; /* Ensure these commits are fetched */
 };
 
+struct status_task {
+	struct repository *repo;
+	const char *path;
+	int ignore_untracked;
+};
+
 /**
  * When a submodule is not defined in .gitmodules, we cannot access it
  * via the regular submodule-config. Create a fake submodule, which we can
@@ -1547,6 +1567,41 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 	return NULL;
 }
 
+static struct status_task *
+get_status_task_from_index(struct submodule_parallel_status *sps,
+			  struct strbuf *err)
+{
+	for (; sps->index_count < sps->submodule_names->nr; sps->index_count++) {
+		struct submodule_status_util *util = sps->submodule_names->items[sps->index_count].util;
+		const struct cache_entry *ce = util->ce;
+		struct status_task *task;
+		struct strbuf buf = STRBUF_INIT;
+		const char *git_dir;
+
+		strbuf_addf(&buf, "%s/.git", ce->name);
+		git_dir = read_gitfile(buf.buf);
+		if (!git_dir)
+			git_dir = buf.buf;
+		if (!is_git_directory(git_dir)) {
+			if (is_directory(git_dir))
+				die(_("'%s' not recognized as a git repository"), git_dir);
+			strbuf_release(&buf);
+			/* The submodule is not checked out, so it is not modified */
+			util->dirty_submodule = 0;
+			continue;
+		}
+		strbuf_release(&buf);
+
+		task = xmalloc(sizeof(*task));
+		memset(task, 0, sizeof(*task));
+		task->path = ce->name;
+		task->ignore_untracked = util->ignore_untracked;
+		sps->index_count++;
+		return task;
+	}
+	return NULL;
+}
+
 static struct fetch_task *
 get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
 			  struct strbuf *err)
@@ -1744,6 +1799,16 @@ static int fetch_start_failure(struct strbuf *err,
 	return 0;
 }
 
+static int status_start_failure(struct strbuf *err,
+			       void *cb, void *task_cb)
+{
+	struct submodule_parallel_status *sps = cb;
+
+	sps->result = 1;
+	return 0;
+}
+
+
 static int commit_missing_in_sub(const struct object_id *oid, void *data)
 {
 	struct repository *subrepo = data;
@@ -1790,6 +1855,30 @@ static int parse_status_porcelain(char *buf, unsigned *dirty_submodule, int igno
 	return 0;
 }
 
+static int status_finish(int retvalue, struct strbuf *err,
+			void *cb, void *task_cb)
+{
+	struct submodule_parallel_status *sps = cb;
+	struct status_task *task = task_cb;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list_item *it = string_list_lookup(sps->submodule_names,
+											task->path);
+	struct submodule_status_util *util = it->util;
+
+	int i;
+
+	string_list_split(&list, err->buf, '\n', -1);
+
+	for (i = 0; i < list.nr; i++) {
+		if (parse_status_porcelain(list.items[i].string,
+							&util->dirty_submodule, util->ignore_untracked))
+			break;
+	}
+	strbuf_reset(err);
+
+	return 0;
+}
+
 static int fetch_finish(int retvalue, struct strbuf *err,
 			void *cb, void *task_cb)
 {
@@ -1943,6 +2032,59 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	return dirty_submodule;
 }
 
+static int get_next_submodule_status(struct child_process *cp,
+						struct strbuf *err, void *data, void **task_cb)
+{
+	struct submodule_parallel_status *sps = data;
+	struct status_task *task = get_status_task_from_index(sps, err);
+
+	int ignore_untracked;
+
+	if (!task) {
+		return 0;
+	}
+
+	ignore_untracked = task->ignore_untracked;
+
+	child_process_init(cp);
+	prepare_submodule_repo_env_in_gitdir(&cp->env);
+
+	strvec_init(&cp->args);
+	strvec_pushl(&cp->args, "status", "--porcelain=2", NULL);
+	if (ignore_untracked)
+		strvec_push(&cp->args, "-uno");
+
+	prepare_submodule_repo_env(&cp->env);
+	cp->git_cmd = 1;
+	cp->no_stdin = 1;
+	cp->dir = task->path;
+	*task_cb = task;
+	return 1;
+}
+
+int get_submodules_status(struct repository *r,
+			struct string_list *submodules,
+		    int max_parallel_jobs)
+{
+	struct submodule_parallel_status sps = SPS_INIT;
+
+	sps.r = r;
+
+	if (repo_read_index(r) < 0)
+		die(_("index file corrupt"));
+
+	sps.submodule_names = submodules;
+	string_list_sort(sps.submodule_names);
+	run_processes_parallel_pipe_output = 1;
+	run_processes_parallel_tr2(max_parallel_jobs,
+				get_next_submodule_status,
+				status_start_failure,
+				status_finish,
+				&sps,
+				"submodule", "parallel/status");
+	return sps.result;
+}
+
 int submodule_uses_gitfile(const char *path)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
diff --git a/submodule.h b/submodule.h
index bfaa9da186..18a42c64ce 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,6 +41,12 @@ struct submodule_update_strategy {
 	.type = SM_UPDATE_UNSPECIFIED, \
 }
 
+struct submodule_status_util {
+	int changed, ignore_untracked;
+	unsigned dirty_submodule, newmode;
+	struct cache_entry *ce;
+};
+
 int is_gitmodules_unmerged(struct index_state *istate);
 int is_writing_gitmodules_ok(void);
 int is_staging_gitmodules_ok(struct index_state *istate);
@@ -94,6 +100,9 @@ int fetch_submodules(struct repository *r,
 		     int command_line_option,
 		     int default_option,
 		     int quiet, int max_parallel_jobs);
+int get_submodules_status(struct repository *r,
+			 struct string_list *submodules,
+		     int max_parallel_jobs);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 
diff --git a/wt-status.c b/wt-status.c
index 867e3e417e..9864484f81 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -615,7 +615,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
-	run_diff_files(&rev, 0);
+	run_diff_files(&rev, 0, s->parallel_jobs_submodules);
 	release_revisions(&rev);
 }
 
@@ -1149,7 +1149,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		setup_work_tree();
 		rev.diffopt.a_prefix = "i/";
 		rev.diffopt.b_prefix = "w/";
-		run_diff_files(&rev, 0);
+		run_diff_files(&rev, 0, -1);
 	}
 	release_revisions(&rev);
 }
@@ -2544,7 +2544,7 @@ int has_unstaged_changes(struct repository *r, int ignore_submodules)
 	}
 	rev_info.diffopt.flags.quick = 1;
 	diff_setup_done(&rev_info.diffopt);
-	result = run_diff_files(&rev_info, 0);
+	result = run_diff_files(&rev_info, 0, -1);
 	result = diff_result_code(&rev_info.diffopt, result);
 	release_revisions(&rev_info);
 	return result;
diff --git a/wt-status.h b/wt-status.h
index ab9cc9d8f0..2ea2317715 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -131,6 +131,7 @@ struct wt_status {
 	enum wt_status_format status_format;
 	struct wt_status_state state;
 	struct object_id oid_commit; /* when not Initial */
+	int parallel_jobs_submodules;
 
 	/* These are computed during processing of the individual sections */
 	int committable;
-- 
2.37.3.998.g577e59143f-goog

