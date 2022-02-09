Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA586C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 06:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiBIGxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 01:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiBIGxF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 01:53:05 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E4C05CB81
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 22:53:08 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id q12-20020a17090a2e0c00b001b874772fecso1160695pjd.2
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 22:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VvadnfPpGcw1pyHAWiyfnRjTv76riCHUO3hQbkPEZXI=;
        b=YT/jSLf3L7GgD35oodDnQ7Y8oM3P23LBPOiBqh204dGrUotu3k4GQYZHLlsVGp0dqj
         mDXQztf6ksnUc+JFyO9TS59U+GLeBX6v0gwXSblbKVYO75ZAjS6hibvollBNnudaCx0v
         35RuP/UoiCE/6Ey60gzgxjlOGOKDP3mIitDESh1+rrQ6B6Ba8dC3cMVfEx2LgyYjl9sp
         gYSXBp0EAzBPIERhR51XMzyYjEgY/SisXkITpzyqV2zkrsSnEKYqZAIsdXs1HyiJgD/n
         8t5evYnjC/hvf00M1/zj9uC9wknbfqGGK1ZR3kqtst/NJpcPjtwFdl4k68jhbAr0Y+Uh
         L1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VvadnfPpGcw1pyHAWiyfnRjTv76riCHUO3hQbkPEZXI=;
        b=YzzgXtQmJFQD9AtEuPPUbQjmeNh6p2AS/w0lQ3cEEohdkq7cKauTXZ5BtPqUiudHJP
         E/yqpIrssrlW+IF9tJKL4734TC3p0zegSoIKDzimVZKE+XWOf8aVH3OJoDJm+mtoEhMs
         2WnfwhoDW6eKUFrUIzEAgy3FSdvwVCt5l2tBn1zKLkRD84ASL33C3QX3waz+p3SWBBqS
         YvSrcIAHBtooKG+6L4j7PE3PSDQBvWRs6mrJn3FbDTvY6x+RByGgUhu/3G/MLaEVPmyv
         Qlh2AvwMzyi0mAzZxmSWIY1IJar95N66CQwsHA2oU9Fi6cScLWcoy1Nj3NdqtPpj3NCt
         qs/g==
X-Gm-Message-State: AOAM531gRlBATn7+Ac+j0AMiltwQe4HJAI+gV+olL/m4yw0Ky0TrZRNz
        0hyVkAbIQgEbFyPw6G3osJiH5qXhOIK4+ig9aM4fCOvYUdbR7xL5qB8BNwa2pkQJs5nV+5SbOJl
        H6C/fI1baXTxe6lKIlIoZ9Lt05lRLsHE6MxsP2sDVA1zXTbEtXUsvUPm8zxVeMcg=
X-Google-Smtp-Source: ABdhPJxoMMnEro0RJspNNTllwlnmO2sUJGfDTnju1WqVU1wQ9q1elg4VDUxDjtxZPhayoIrBgcN6nrnWGY6WBA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ea0a:: with SMTP id
 s10mr751510plg.95.1644389587371; Tue, 08 Feb 2022 22:53:07 -0800 (PST)
Date:   Wed,  9 Feb 2022 14:52:36 +0800
In-Reply-To: <20220209065236.36494-1-chooglen@google.com>
Message-Id: <20220209065236.36494-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220209065236.36494-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 1/1] checkout --recurse-submodules: checkout branches if configured
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, rsbecker@nexbridge.com,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we introduced "git branch --recurse-submodules", but unless
the config value "submodule.propagateBranches" is true, commands ignore
the submodule ref store and do not respect the submodule branches.

Teach "git [checkout|switch]" to support
submodule.propagateBranches=true, which makes "git checkout
--recurse-submodules foo" checkout the branch "foo" in the superproject
and all submodules. To support superproject branches that were not
created with "git branch --recurse-submodules", "git checkout
--recurse-submodules foo" does not fail if a submodule is missing the
branch "foo". Instead, the gitlink of the superproject's "foo" is
checked out (just like how "--recurse-submodules" already behaves).

Presently, "git checkout" updates the superproject tree, submodule
trees and submodule HEAD using unpack-trees, while the superproject HEAD
is updated in the cmd_checkout() porcelain. However, this does not work
well for submodule.propagateBranches=true because unpack-trees does not
consider submodule refs. Instead of introducing procelain concerns into
unpack-trees, submodule updating is done in the cmd_checkout()
porcelain like so:

- disable submodule updating in unpack-trees, so that neither the
  submodule HEAD nor submodule tree are updated
- update the submodules' HEAD and tree using a "git checkout" subprocess
  (specifically, update_refs_for_switch())

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/checkout.c            | 142 +++++++++++++++++++++++++++++++++-
 submodule.c                   |   6 ++
 submodule.h                   |   9 +++
 t/t2013-checkout-submodule.sh |  90 +++++++++++++++++++++
 4 files changed, 243 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8600860629..0d1557da88 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -74,6 +74,8 @@ struct checkout_opts {
 	int ignore_unmerged;
 	int pathspec_file_nul;
 	const char *pathspec_from_file;
+	int recurse_submodules;
+	int submodule_propagate_branches;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -858,6 +860,123 @@ static void report_tracking(struct branch_info *new_branch_info)
 	strbuf_release(&sb);
 }
 
+static int update_submodule(struct repository *subrepo, const struct submodule *submodule, const struct checkout_opts *opts, const char *new_head)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	/*
+	 * NEEDSWORK: this output formatting is just copied from
+	 * submodule_create_branch() - this should become a helper function
+	 * instead.
+	 */
+	int ret = 0;
+	struct strbuf child_err = STRBUF_INIT;
+	struct strbuf out_buf = STRBUF_INIT;
+	char *out_prefix = xstrfmt("submodule '%s': ", submodule->name);
+	child.err = -1;
+	child.stdout_to_stderr = 1;
+
+	child.git_cmd = 1;
+	prepare_other_repo_env(&child.env_array, subrepo->gitdir);
+	/* NEEDSWORK: TODO do i need the -c? */
+	strvec_pushl(&child.args, "-c", "submodule.propagateBranches", "checkout", "--recurse-submodules", NULL);
+
+	if (opts->new_branch)
+		strvec_push(&child.args, "-c");
+	if (opts->new_branch_force)
+		strvec_push(&child.args, "-C");
+	if (opts->discard_changes)
+		strvec_push(&child.args, "--discard-changes");
+	if (opts->show_progress)
+		strvec_push(&child.args, "--progress");
+	if (opts->track == BRANCH_TRACK_EXPLICIT)
+		strvec_push(&child.args, "--track");
+	if (opts->track == BRANCH_TRACK_INHERIT)
+		strvec_pushl(&child.args, "--track", "inherit", NULL);
+
+	if (opts->force)
+		strvec_push(&child.args, "--force");
+	if (opts->new_orphan_branch)
+		strvec_push(&child.args, "--orphan");
+	if (opts->ignore_other_worktrees)
+		strvec_push(&child.args, "--ignore-other-worktrees");
+
+	strvec_push(&child.args, new_head);
+
+	/*
+	 * NEEDSWORK: handle the output correctly e.g. the child process
+	 * shouldn't dump warnings about detached HEAD.
+	 */
+	if ((ret = start_command(&child)))
+		return ret;
+	ret = finish_command(&child);
+	strbuf_read(&child_err, child.err, 0);
+	strbuf_add_lines(&out_buf, out_prefix, child_err.buf, child_err.len);
+
+	if (ret)
+		fprintf(stderr, "%s", out_buf.buf);
+	else
+		printf("%s", out_buf.buf);
+
+	strbuf_release(&child_err);
+	strbuf_release(&out_buf);
+	return ret;
+}
+
+static int update_submodules_recursively(const struct checkout_opts *opts,
+				   struct branch_info *old_branch_info,
+				   struct branch_info *new_branch_info)
+{
+	int i;
+	struct repository subrepo;
+	const struct submodule *submodule;
+	const char *new_head;
+
+	/*
+	 * NEEDSWORK: use parallel processes instead.
+	 */
+	for (i = 0; i < the_repository->index->cache_nr; i++) {
+		const struct cache_entry *ce = the_repository->index->cache[i];
+
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+		if (repo_submodule_init(&subrepo, the_repository, ce->name, null_oid())) {
+			warning(_("unable to checkout submodule '%s'"), ce->name);
+			continue;
+		}
+
+		/*
+		 * If the repo is in detached HEAD, submodules should
+		 * checkout the gitlink.
+		 */
+		if (!new_branch_info->path)
+			new_head = oid_to_hex(&ce->oid);
+		/*
+		 * Otherwise, the submodule should checkout the branch
+		 * if possible.
+		 */
+		else if (!refs_ref_exists(get_main_ref_store(&subrepo), new_branch_info->path)){
+				warning(_("branch '%s' does not exist in submodule '%s'"), new_branch_info->name, ce->name);
+				new_head = oid_to_hex(&ce->oid);
+		} else
+			new_head = new_branch_info->name;
+
+
+		/*
+		 * NEEDSWORK: Ironically, this doesn't use
+		 * submodule_from_ce() because we've disabled submodule
+		 * updating
+		 */
+		submodule = submodule_from_path(the_repository, null_oid(), ce->name);
+		if (!submodule)
+			continue;
+
+		update_submodule(&subrepo, submodule, opts, new_head);
+	}
+
+	return 0;
+}
+
 static void update_refs_for_switch(const struct checkout_opts *opts,
 				   struct branch_info *old_branch_info,
 				   struct branch_info *new_branch_info)
@@ -947,6 +1066,11 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				delete_reflog(old_branch_info->path);
 		}
 	}
+
+	if (opts->submodule_propagate_branches && opts->recurse_submodules) {
+		update_submodules_recursively(opts, old_branch_info, new_branch_info);
+	}
+
 	remove_branch_state(the_repository, !opts->quiet);
 	strbuf_release(&msg);
 	if (!opts->quiet &&
@@ -1130,7 +1254,10 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
 	}
-
+	if (!strcasecmp(var, "submodule.propagateBranches")) {
+		opts->submodule_propagate_branches = git_config_bool(var, value);
+		return 0;
+	}
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
 
@@ -1512,9 +1639,8 @@ static struct option *add_common_options(struct checkout_opts *opts,
 {
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
-		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+		OPT_BOOL(0, "recurse-submodules", &opts->recurse_submodules,
+			    N_("control recursive updating of submodules")),
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
 		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
@@ -1588,6 +1714,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	opts->show_progress = -1;
 
 	git_config(git_checkout_config, opts);
+	if (opts->recurse_submodules && !opts->submodule_propagate_branches)
+		set_update_submodules(RECURSE_SUBMODULES_ON);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
@@ -1768,6 +1896,12 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 				validate_new_branchname(opts->new_branch, &buf, 0);
 		strbuf_release(&buf);
 	}
+	/*
+	 * NEEDSWORK: Check for option comaptibility with
+	 * --recurse-submodules + submodule.propagateBranches
+	 *
+	 * e.g. --merge, --detach
+	 */
 
 	UNLEAK(opts);
 	if (opts->patch_mode || opts->pathspec.nr)
diff --git a/submodule.c b/submodule.c
index 5ace18a7d9..18a609de09 100644
--- a/submodule.c
+++ b/submodule.c
@@ -766,6 +766,12 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	}
 }
 
+void set_update_submodules(int update_submodules)
+{
+	config_update_recurse_submodules = update_submodules
+		? RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+}
+
 int should_update_submodules(void)
 {
 	return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
diff --git a/submodule.h b/submodule.h
index 784ceffc0e..239cdaf451 100644
--- a/submodule.h
+++ b/submodule.h
@@ -80,6 +80,15 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 void show_submodule_inline_diff(struct diff_options *o, const char *path,
 				struct object_id *one, struct object_id *two,
 				unsigned dirty_submodule);
+
+/*
+ * Explicitly set whether or not we want to update submodules.
+ * This should only be used for very fine-grained control:
+ * - if option parsing is enough, use
+ *   option_parse_recurse_submodules_worktree_updater()
+ * - if config parsing is enough, use git_default_submodule_config()
+ */
+void set_update_submodules(int update_submodules);
 /* Check if we want to update any submodule.*/
 int should_update_submodules(void);
 /*
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index b2bdd1fcb4..db88bd3448 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -72,4 +72,94 @@ test_submodule_switch "checkout"
 
 test_submodule_forced_switch "checkout -f"
 
+test_expect_success 'setup tests with submodule.propagateBranches' '
+	mkdir submodule2 &&
+	(
+		cd submodule2 &&
+		git init &&
+		test_commit new_commit
+	) &&
+	mkdir super &&
+	(
+		cd super &&
+		git init &&
+		git submodule add ../submodule sub1 &&
+		(
+			cd sub1 &&
+			git submodule add ../submodule2 sub2 &&
+			git commit -m "add submodule"
+		) &&
+		git add sub1 &&
+		git submodule add ../submodule2 sub2 &&
+		git commit -m "add submodules"
+	) &&
+	git -C super config submodule.propagateBranches true
+'
+
+# Tests that HEAD is a literal value regardless of whether it points to
+# a branch or commit id.
+test_cmp_head () {
+	EXPECT=$1
+	DIR=$2
+	rm -f actual-head expect-head &&
+	(git -C $DIR symbolic-ref HEAD || git -C $DIR rev-parse HEAD) \
+			2>/dev/null >actual-head &&
+	echo "$EXPECT" >expect-head &&
+	test_cmp expect-head actual-head
+}
+
+test_expect_success '"checkout" with submodule.propagateBranches checks out branch in all submodules if it exists' '
+        test_when_finished "git -C super checkout --recurse-submodules master" &&
+	git -C super branch --recurse-submodules branch-a master &&
+	(
+		cd super/sub1 &&
+		git checkout branch-a &&
+		test_commit --no-tag branch-a &&
+		git checkout master
+	) &&
+	git -C super checkout --recurse-submodules branch-a &&
+	test_cmp_head refs/heads/branch-a super &&
+	test_cmp_head refs/heads/branch-a super/sub1 &&
+	test_cmp_head refs/heads/branch-a super/sub2 &&
+	test_cmp_head refs/heads/branch-a super/sub1/sub2
+'
+
+test_expect_success 'submodule.propagateBranches checks out gitlink if branch does not exist' '
+        test_when_finished "git -C super checkout --recurse-submodules master \
+		&& rm expect* && rm actual*" &&
+	git -C super branch --recurse-submodules branch-b master &&
+	git -C super/sub1 rev-parse refs/heads/branch-b >expect-sub1-head &&
+	git -C super/sub1/sub2 rev-parse refs/heads/branch-b >expect-sub1-sub2-head &&
+	(
+		cd super/sub1 &&
+		git checkout --detach branch-b &&
+		test_commit --no-tag branch-b &&
+		git branch -D branch-b
+	) &&
+	git -C super checkout --recurse-submodules branch-b 2>actual-err &&
+	test_cmp_head "$(cat expect-sub1-head)" super/sub1 &&
+	grep "warning: branch .branch-b. does not exist in submodule .sub1." actual-err &&
+	test_cmp_head refs/heads/branch-b super &&
+	test_cmp_head refs/heads/branch-b super/sub2 &&
+	# even though super/sub1/sub2 has branch-b, do not check it out
+	# because its containing repo did not checkout branch-b
+	test_cmp_head "$(cat expect-sub1-sub2-head)" super/sub1/sub2
+'
+
+test_expect_success 'submodule.propagateBranches ignores non-branches' '
+        test_when_finished "git -C super checkout --recurse-submodules master \
+		&& rm expect* && rm actual*" &&
+	git -C super branch --recurse-submodules branch-c master &&
+	git -C super/sub1 rev-parse refs/heads/branch-c >expect-sub1-head &&
+	(
+		cd super/sub1 &&
+		git branch -D branch-c &&
+		# create a new commit with the tag "branch-c"
+		test_commit branch-c
+	) &&
+	git -C super checkout --recurse-submodules branch-c  2>actual-err &&
+	test_cmp_head "$(cat expect-sub1-head)" super/sub1 &&
+	grep "warning: branch .branch-c. does not exist in submodule .sub1." actual-err
+'
+
 test_done
-- 
2.33.GIT

