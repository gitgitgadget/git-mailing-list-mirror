Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3FCC433E1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82962065E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgG1UYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:24:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:40218 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729063AbgG1UYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:24:34 -0400
Received: (qmail 29737 invoked by uid 109); 28 Jul 2020 20:24:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:24:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28560 invoked by uid 111); 28 Jul 2020 20:24:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:24:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:24:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/11] strvec: convert builtin/ callers away from argv_array
 name
Message-ID: <20200728202427.GE1021513@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We eventually want to drop the argv_array name and just use strvec
consistently. There's no particular reason we have to do it all at once,
or care about interactions between converted and unconverted bits.
Because of our preprocessor compat layer, the names are interchangeable
to the compiler (so even a definition and declaration using different
names is OK).

This patch converts all of the files in builtin/ to keep the diff to a
manageable size.

The conversion was done purely mechanically with:

  git ls-files '*.c' '*.h' |
  xargs perl -i -pe '
    s/ARGV_ARRAY/STRVEC/g;
    s/argv_array/strvec/g;
  '

and then selectively staging files with "git add builtin/". We'll deal
with any indentation/style fallouts separately.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/add.c               |  14 ++--
 builtin/am.c                |  66 ++++++++--------
 builtin/annotate.c          |   6 +-
 builtin/bisect--helper.c    |  12 +--
 builtin/bundle.c            |  12 +--
 builtin/clone.c             |  34 ++++-----
 builtin/commit.c            |   6 +-
 builtin/describe.c          |  28 +++----
 builtin/difftool.c          |  14 ++--
 builtin/fetch.c             |  54 ++++++-------
 builtin/gc.c                |  50 ++++++------
 builtin/grep.c              |   2 +-
 builtin/log.c               |  12 +--
 builtin/ls-remote.c         |   6 +-
 builtin/pack-objects.c      |  22 +++---
 builtin/pull.c              | 148 ++++++++++++++++++------------------
 builtin/range-diff.c        |   4 +-
 builtin/rebase.c            |  60 +++++++--------
 builtin/receive-pack.c      |  68 ++++++++---------
 builtin/remote-ext.c        |   4 +-
 builtin/remote.c            |  20 ++---
 builtin/repack.c            |  62 +++++++--------
 builtin/replace.c           |  16 ++--
 builtin/show-branch.c       |   6 +-
 builtin/stash.c             | 114 +++++++++++++--------------
 builtin/submodule--helper.c | 118 ++++++++++++++--------------
 builtin/upload-archive.c    |   6 +-
 builtin/worktree.c          |  42 +++++-----
 28 files changed, 503 insertions(+), 503 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 6cd9a4cd77..6185dd12a8 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -188,7 +188,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 			const struct pathspec *pathspec)
 {
 	int status, i;
-	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct strvec argv = STRVEC_INIT;
 	int use_builtin_add_i =
 		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
 
@@ -218,18 +218,18 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 		return !!run_add_p(the_repository, mode, revision, pathspec);
 	}
 
-	argv_array_push(&argv, "add--interactive");
+	strvec_push(&argv, "add--interactive");
 	if (patch_mode)
-		argv_array_push(&argv, patch_mode);
+		strvec_push(&argv, patch_mode);
 	if (revision)
-		argv_array_push(&argv, revision);
-	argv_array_push(&argv, "--");
+		strvec_push(&argv, revision);
+	strvec_push(&argv, "--");
 	for (i = 0; i < pathspec->nr; i++)
 		/* pass original pathspec, to be re-parsed */
-		argv_array_push(&argv, pathspec->items[i].original);
+		strvec_push(&argv, pathspec->items[i].original);
 
 	status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
-	argv_array_clear(&argv);
+	strvec_clear(&argv);
 	return status;
 }
 
diff --git a/builtin/am.c b/builtin/am.c
index 0641316e35..992ab3ca27 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -116,7 +116,7 @@ struct am_state {
 	int keep; /* enum keep_type */
 	int message_id;
 	int scissors; /* enum scissors_type */
-	struct argv_array git_apply_opts;
+	struct strvec git_apply_opts;
 	const char *resolvemsg;
 	int committer_date_is_author_date;
 	int ignore_date;
@@ -146,7 +146,7 @@ static void am_state_init(struct am_state *state)
 
 	state->scissors = SCISSORS_UNSET;
 
-	argv_array_init(&state->git_apply_opts);
+	strvec_init(&state->git_apply_opts);
 
 	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
 		state->sign_commit = gpgsign ? "" : NULL;
@@ -162,7 +162,7 @@ static void am_state_release(struct am_state *state)
 	free(state->author_email);
 	free(state->author_date);
 	free(state->msg);
-	argv_array_clear(&state->git_apply_opts);
+	strvec_clear(&state->git_apply_opts);
 }
 
 /**
@@ -398,7 +398,7 @@ static void am_load(struct am_state *state)
 		state->scissors = SCISSORS_UNSET;
 
 	read_state_file(&sb, state, "apply-opt", 1);
-	argv_array_clear(&state->git_apply_opts);
+	strvec_clear(&state->git_apply_opts);
 	if (sq_dequote_to_strvec(sb.buf, &state->git_apply_opts) < 0)
 		die(_("could not parse %s"), am_path(state, "apply-opt"));
 
@@ -452,8 +452,8 @@ static int run_post_rewrite_hook(const struct am_state *state)
 	if (!hook)
 		return 0;
 
-	argv_array_push(&cp.args, hook);
-	argv_array_push(&cp.args, "rebase");
+	strvec_push(&cp.args, hook);
+	strvec_push(&cp.args, "rebase");
 
 	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
 	cp.stdout_to_stderr = 1;
@@ -651,16 +651,16 @@ static int split_mail_mbox(struct am_state *state, const char **paths,
 	int ret;
 
 	cp.git_cmd = 1;
-	argv_array_push(&cp.args, "mailsplit");
-	argv_array_pushf(&cp.args, "-d%d", state->prec);
-	argv_array_pushf(&cp.args, "-o%s", state->dir);
-	argv_array_push(&cp.args, "-b");
+	strvec_push(&cp.args, "mailsplit");
+	strvec_pushf(&cp.args, "-d%d", state->prec);
+	strvec_pushf(&cp.args, "-o%s", state->dir);
+	strvec_push(&cp.args, "-b");
 	if (keep_cr)
-		argv_array_push(&cp.args, "--keep-cr");
+		strvec_push(&cp.args, "--keep-cr");
 	if (mboxrd)
-		argv_array_push(&cp.args, "--mboxrd");
-	argv_array_push(&cp.args, "--");
-	argv_array_pushv(&cp.args, paths);
+		strvec_push(&cp.args, "--mboxrd");
+	strvec_push(&cp.args, "--");
+	strvec_pushv(&cp.args, paths);
 
 	ret = capture_command(&cp, &last, 8);
 	if (ret)
@@ -787,7 +787,7 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 	const char *series_dir;
 	char *series_dir_buf;
 	FILE *fp;
-	struct argv_array patches = ARGV_ARRAY_INIT;
+	struct strvec patches = STRVEC_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
@@ -805,7 +805,7 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 		if (*sb.buf == '#')
 			continue; /* skip comment lines */
 
-		argv_array_push(&patches, mkpath("%s/%s", series_dir, sb.buf));
+		strvec_push(&patches, mkpath("%s/%s", series_dir, sb.buf));
 	}
 
 	fclose(fp);
@@ -814,7 +814,7 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 
 	ret = split_mail_conv(stgit_patch_to_mail, state, patches.argv, keep_cr);
 
-	argv_array_clear(&patches);
+	strvec_clear(&patches);
 	return ret;
 }
 
@@ -1390,8 +1390,8 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
  */
 static int run_apply(const struct am_state *state, const char *index_file)
 {
-	struct argv_array apply_paths = ARGV_ARRAY_INIT;
-	struct argv_array apply_opts = ARGV_ARRAY_INIT;
+	struct strvec apply_paths = STRVEC_INIT;
+	struct strvec apply_opts = STRVEC_INIT;
 	struct apply_state apply_state;
 	int res, opts_left;
 	int force_apply = 0;
@@ -1400,8 +1400,8 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	if (init_apply_state(&apply_state, the_repository, NULL))
 		BUG("init_apply_state() failed");
 
-	argv_array_push(&apply_opts, "apply");
-	argv_array_pushv(&apply_opts, state->git_apply_opts.argv);
+	strvec_push(&apply_opts, "apply");
+	strvec_pushv(&apply_opts, state->git_apply_opts.argv);
 
 	opts_left = apply_parse_options(apply_opts.argc, apply_opts.argv,
 					&apply_state, &force_apply, &options,
@@ -1426,12 +1426,12 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	if (check_apply_state(&apply_state, force_apply))
 		BUG("check_apply_state() failed");
 
-	argv_array_push(&apply_paths, am_path(state, "patch"));
+	strvec_push(&apply_paths, am_path(state, "patch"));
 
 	res = apply_all_patches(&apply_state, apply_paths.argc, apply_paths.argv, options);
 
-	argv_array_clear(&apply_paths);
-	argv_array_clear(&apply_opts);
+	strvec_clear(&apply_paths);
+	strvec_clear(&apply_opts);
 	clear_apply_state(&apply_state);
 
 	if (res)
@@ -1454,10 +1454,10 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 	struct child_process cp = CHILD_PROCESS_INIT;
 
 	cp.git_cmd = 1;
-	argv_array_push(&cp.args, "apply");
-	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
-	argv_array_pushf(&cp.args, "--build-fake-ancestor=%s", index_file);
-	argv_array_push(&cp.args, am_path(state, "patch"));
+	strvec_push(&cp.args, "apply");
+	strvec_pushv(&cp.args, state->git_apply_opts.argv);
+	strvec_pushf(&cp.args, "--build-fake-ancestor=%s", index_file);
+	strvec_push(&cp.args, am_path(state, "patch"));
 
 	if (run_command(&cp))
 		return -1;
@@ -1676,7 +1676,7 @@ static int do_interactive(struct am_state *state)
 			if (!pager)
 				pager = "cat";
 			prepare_pager_args(&cp, pager);
-			argv_array_push(&cp.args, am_path(state, "patch"));
+			strvec_push(&cp.args, am_path(state, "patch"));
 			run_command(&cp);
 		}
 	}
@@ -2346,7 +2346,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		if (state.signoff == SIGNOFF_EXPLICIT)
 			am_append_signoff(&state);
 	} else {
-		struct argv_array paths = ARGV_ARRAY_INIT;
+		struct strvec paths = STRVEC_INIT;
 		int i;
 
 		/*
@@ -2371,17 +2371,17 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 		for (i = 0; i < argc; i++) {
 			if (is_absolute_path(argv[i]) || !prefix)
-				argv_array_push(&paths, argv[i]);
+				strvec_push(&paths, argv[i]);
 			else
-				argv_array_push(&paths, mkpath("%s/%s", prefix, argv[i]));
+				strvec_push(&paths, mkpath("%s/%s", prefix, argv[i]));
 		}
 
 		if (state.interactive && !paths.argc)
 			die(_("interactive mode requires patches on the command line"));
 
 		am_setup(&state, patch_format, paths.argv, keep_cr);
 
-		argv_array_clear(&paths);
+		strvec_clear(&paths);
 	}
 
 	switch (resume.mode) {
diff --git a/builtin/annotate.c b/builtin/annotate.c
index 4353448712..7b7ecd366d 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -9,13 +9,13 @@
 
 int cmd_annotate(int argc, const char **argv, const char *prefix)
 {
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 	int i;
 
-	argv_array_pushl(&args, "annotate", "-c", NULL);
+	strvec_pushl(&args, "annotate", "-c", NULL);
 
 	for (i = 1; i < argc; i++) {
-		argv_array_push(&args, argv[i]);
+		strvec_push(&args, argv[i]);
 	}
 
 	return cmd_blame(args.argc, args.argv, prefix);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e929315b38..9815e78871 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -165,18 +165,18 @@ static int bisect_reset(const char *commit)
 	}
 
 	if (!file_exists(git_path_bisect_head())) {
-		struct argv_array argv = ARGV_ARRAY_INIT;
+		struct strvec argv = STRVEC_INIT;
 
-		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
+		strvec_pushl(&argv, "checkout", branch.buf, "--", NULL);
 		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
 			error(_("could not check out original"
 				" HEAD '%s'. Try 'git bisect"
 				" reset <commit>'."), branch.buf);
 			strbuf_release(&branch);
-			argv_array_clear(&argv);
+			strvec_clear(&argv);
 			return -1;
 		}
-		argv_array_clear(&argv);
+		strvec_clear(&argv);
 	}
 
 	strbuf_release(&branch);
@@ -526,9 +526,9 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
 		strbuf_trim(&start_head);
 		if (!no_checkout) {
-			struct argv_array argv = ARGV_ARRAY_INIT;
+			struct strvec argv = STRVEC_INIT;
 
-			argv_array_pushl(&argv, "checkout", start_head.buf,
+			strvec_pushl(&argv, "checkout", start_head.buf,
 					 "--", NULL);
 			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
 				res = error(_("checking out '%s' failed."
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 51fc6d9739..750630bdd9 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -59,7 +59,7 @@ static int parse_options_cmd_bundle(int argc,
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	int all_progress_implied = 0;
 	int progress = isatty(STDERR_FILENO);
-	struct argv_array pack_opts;
+	struct strvec pack_opts;
 
 	struct option options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -79,15 +79,15 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 			builtin_bundle_create_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	argv_array_init(&pack_opts);
+	strvec_init(&pack_opts);
 	if (progress == 0)
-		argv_array_push(&pack_opts, "--quiet");
+		strvec_push(&pack_opts, "--quiet");
 	else if (progress == 1)
-		argv_array_push(&pack_opts, "--progress");
+		strvec_push(&pack_opts, "--progress");
 	else if (progress == 2)
-		argv_array_push(&pack_opts, "--all-progress");
+		strvec_push(&pack_opts, "--all-progress");
 	if (progress && all_progress_implied)
-		argv_array_push(&pack_opts, "--all-progress-implied");
+		strvec_push(&pack_opts, "--all-progress-implied");
 
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
diff --git a/builtin/clone.c b/builtin/clone.c
index bef70745c0..e26bd82dc4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -742,9 +742,9 @@ static void update_head(const struct ref *our, const struct ref *remote,
 
 static int git_sparse_checkout_init(const char *repo)
 {
-	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct strvec argv = STRVEC_INIT;
 	int result = 0;
-	argv_array_pushl(&argv, "-C", repo, "sparse-checkout", "init", NULL);
+	strvec_pushl(&argv, "-C", repo, "sparse-checkout", "init", NULL);
 
 	/*
 	 * We must apply the setting in the current process
@@ -757,7 +757,7 @@ static int git_sparse_checkout_init(const char *repo)
 		result = 1;
 	}
 
-	argv_array_clear(&argv);
+	strvec_clear(&argv);
 	return result;
 }
 
@@ -819,33 +819,33 @@ static int checkout(int submodule_progress)
 			   oid_to_hex(&oid), "1", NULL);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
-		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--require-init", "--recursive", NULL);
+		struct strvec args = STRVEC_INIT;
+		strvec_pushl(&args, "submodule", "update", "--require-init", "--recursive", NULL);
 
 		if (option_shallow_submodules == 1)
-			argv_array_push(&args, "--depth=1");
+			strvec_push(&args, "--depth=1");
 
 		if (max_jobs != -1)
-			argv_array_pushf(&args, "--jobs=%d", max_jobs);
+			strvec_pushf(&args, "--jobs=%d", max_jobs);
 
 		if (submodule_progress)
-			argv_array_push(&args, "--progress");
+			strvec_push(&args, "--progress");
 
 		if (option_verbosity < 0)
-			argv_array_push(&args, "--quiet");
+			strvec_push(&args, "--quiet");
 
 		if (option_remote_submodules) {
-			argv_array_push(&args, "--remote");
-			argv_array_push(&args, "--no-fetch");
+			strvec_push(&args, "--remote");
+			strvec_push(&args, "--no-fetch");
 		}
 
 		if (option_single_branch >= 0)
-			argv_array_push(&args, option_single_branch ?
+			strvec_push(&args, option_single_branch ?
 					       "--single-branch" :
 					       "--no-single-branch");
 
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
-		argv_array_clear(&args);
+		strvec_clear(&args);
 	}
 
 	return err;
@@ -961,7 +961,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 
-	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
+	struct strvec ref_prefixes = STRVEC_INIT;
 
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
@@ -1211,12 +1211,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
 
-	argv_array_push(&ref_prefixes, "HEAD");
+	strvec_push(&ref_prefixes, "HEAD");
 	refspec_ref_prefixes(&remote->fetch, &ref_prefixes);
 	if (option_branch)
 		expand_ref_prefix(&ref_prefixes, option_branch);
 	if (!option_no_tags)
-		argv_array_push(&ref_prefixes, "refs/tags/");
+		strvec_push(&ref_prefixes, "refs/tags/");
 
 	refs = transport_get_remote_refs(transport, &ref_prefixes);
 
@@ -1327,6 +1327,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&default_refspec);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	argv_array_clear(&ref_prefixes);
+	strvec_clear(&ref_prefixes);
 	return err;
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index d1b7396052..c3f4067537 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1005,15 +1005,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 
 	if (use_editor) {
-		struct argv_array env = ARGV_ARRAY_INIT;
+		struct strvec env = STRVEC_INIT;
 
-		argv_array_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
+		strvec_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
 		if (launch_editor(git_path_commit_editmsg(), NULL, env.argv)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
 		}
-		argv_array_clear(&env);
+		strvec_clear(&env);
 	}
 
 	if (!no_verify &&
diff --git a/builtin/describe.c b/builtin/describe.c
index 32ad6822f7..ff3c169fa9 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -501,10 +501,10 @@ static void process_object(struct object *obj, const char *path, void *data)
 static void describe_blob(struct object_id oid, struct strbuf *dst)
 {
 	struct rev_info revs;
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 	struct process_commit_data pcd = { null_oid, oid, dst, &revs};
 
-	argv_array_pushl(&args, "internal: The first arg is not parsed",
+	strvec_pushl(&args, "internal: The first arg is not parsed",
 		"--objects", "--in-commit-order", "--reverse", "HEAD",
 		NULL);
 
@@ -594,25 +594,25 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	if (contains) {
 		struct string_list_item *item;
-		struct argv_array args;
+		struct strvec args;
 
-		argv_array_init(&args);
-		argv_array_pushl(&args, "name-rev",
+		strvec_init(&args);
+		strvec_pushl(&args, "name-rev",
 				 "--peel-tag", "--name-only", "--no-undefined",
 				 NULL);
 		if (always)
-			argv_array_push(&args, "--always");
+			strvec_push(&args, "--always");
 		if (!all) {
-			argv_array_push(&args, "--tags");
+			strvec_push(&args, "--tags");
 			for_each_string_list_item(item, &patterns)
-				argv_array_pushf(&args, "--refs=refs/tags/%s", item->string);
+				strvec_pushf(&args, "--refs=refs/tags/%s", item->string);
 			for_each_string_list_item(item, &exclude_patterns)
-				argv_array_pushf(&args, "--exclude=refs/tags/%s", item->string);
+				strvec_pushf(&args, "--exclude=refs/tags/%s", item->string);
 		}
 		if (argc)
-			argv_array_pushv(&args, argv);
+			strvec_pushv(&args, argv);
 		else
-			argv_array_push(&args, "HEAD");
+			strvec_push(&args, "HEAD");
 		return cmd_name_rev(args.argc, args.argv, prefix);
 	}
 
@@ -624,7 +624,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (argc == 0) {
 		if (broken) {
 			struct child_process cp = CHILD_PROCESS_INIT;
-			argv_array_pushv(&cp.args, diff_index_args);
+			strvec_pushv(&cp.args, diff_index_args);
 			cp.git_cmd = 1;
 			cp.no_stdin = 1;
 			cp.no_stdout = 1;
@@ -646,7 +646,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		} else if (dirty) {
 			struct lock_file index_lock = LOCK_INIT;
 			struct rev_info revs;
-			struct argv_array args = ARGV_ARRAY_INIT;
+			struct strvec args = STRVEC_INIT;
 			int fd, result;
 
 			setup_work_tree();
@@ -658,7 +658,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 				repo_update_index_if_able(the_repository, &index_lock);
 
 			repo_init_revisions(the_repository, &revs, prefix);
-			argv_array_pushv(&args, diff_index_args);
+			strvec_pushv(&args, diff_index_args);
 			if (setup_revisions(args.argc, args.argv, &revs, NULL) != 1)
 				BUG("malformed internal diff-index command line");
 			result = run_diff_index(&revs, 0);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index c0608a78d9..40c4d7b6b6 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -210,7 +210,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	strbuf_addf(&index_env, "GIT_INDEX_FILE=%s", index_path);
 	env[0] = index_env.buf;
 
-	argv_array_pushl(&update_index.args,
+	strvec_pushl(&update_index.args,
 			 "--git-dir", git_dir, "--work-tree", workdir,
 			 "update-index", "--really-refresh", "-q",
 			 "--unmerged", NULL);
@@ -225,7 +225,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	/* Ignore any errors of update-index */
 	run_command(&update_index);
 
-	argv_array_pushl(&diff_files.args,
+	strvec_pushl(&diff_files.args,
 			 "--git-dir", git_dir, "--work-tree", workdir,
 			 "diff-files", "--name-only", "-z", NULL);
 	diff_files.no_stdin = 1;
@@ -393,10 +393,10 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	child.clean_on_exit = 1;
 	child.dir = prefix;
 	child.out = -1;
-	argv_array_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
+	strvec_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
 			 NULL);
 	for (i = 0; i < argc; i++)
-		argv_array_push(&child.args, argv[i]);
+		strvec_push(&child.args, argv[i]);
 	if (start_command(&child))
 		die("could not obtain raw diff");
 	fp = xfdopen(child.out, "r");
@@ -667,7 +667,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 static int run_file_diff(int prompt, const char *prefix,
 			 int argc, const char **argv)
 {
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 	const char *env[] = {
 		"GIT_PAGER=", "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL,
 		NULL
@@ -680,9 +680,9 @@ static int run_file_diff(int prompt, const char *prefix,
 		env[2] = "GIT_DIFFTOOL_NO_PROMPT=true";
 
 
-	argv_array_push(&args, "diff");
+	strvec_push(&args, "diff");
 	for (i = 0; i < argc; i++)
-		argv_array_push(&args, argv[i]);
+		strvec_push(&args, argv[i]);
 	ret = run_command_v_opt_cd_env(args.argv, RUN_GIT_CMD, prefix, env);
 	exit(ret);
 }
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b183b55ee9..cc636188ad 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1316,7 +1316,7 @@ static int do_fetch(struct transport *transport,
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 	const struct ref *remote_refs;
-	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
+	struct strvec ref_prefixes = STRVEC_INIT;
 	int must_list_refs = 1;
 
 	if (tags == TAGS_DEFAULT) {
@@ -1355,7 +1355,7 @@ static int do_fetch(struct transport *transport,
 	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
 		must_list_refs = 1;
 		if (ref_prefixes.argc)
-			argv_array_push(&ref_prefixes, "refs/tags/");
+			strvec_push(&ref_prefixes, "refs/tags/");
 	}
 
 	if (must_list_refs) {
@@ -1365,7 +1365,7 @@ static int do_fetch(struct transport *transport,
 	} else
 		remote_refs = NULL;
 
-	argv_array_clear(&ref_prefixes);
+	strvec_clear(&ref_prefixes);
 
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
 			      tags, &autotags);
@@ -1503,34 +1503,34 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 	return 1;
 }
 
-static void add_options_to_argv(struct argv_array *argv)
+static void add_options_to_argv(struct strvec *argv)
 {
 	if (dry_run)
-		argv_array_push(argv, "--dry-run");
+		strvec_push(argv, "--dry-run");
 	if (prune != -1)
-		argv_array_push(argv, prune ? "--prune" : "--no-prune");
+		strvec_push(argv, prune ? "--prune" : "--no-prune");
 	if (prune_tags != -1)
-		argv_array_push(argv, prune_tags ? "--prune-tags" : "--no-prune-tags");
+		strvec_push(argv, prune_tags ? "--prune-tags" : "--no-prune-tags");
 	if (update_head_ok)
-		argv_array_push(argv, "--update-head-ok");
+		strvec_push(argv, "--update-head-ok");
 	if (force)
-		argv_array_push(argv, "--force");
+		strvec_push(argv, "--force");
 	if (keep)
-		argv_array_push(argv, "--keep");
+		strvec_push(argv, "--keep");
 	if (recurse_submodules == RECURSE_SUBMODULES_ON)
-		argv_array_push(argv, "--recurse-submodules");
+		strvec_push(argv, "--recurse-submodules");
 	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
-		argv_array_push(argv, "--recurse-submodules=on-demand");
+		strvec_push(argv, "--recurse-submodules=on-demand");
 	if (tags == TAGS_SET)
-		argv_array_push(argv, "--tags");
+		strvec_push(argv, "--tags");
 	else if (tags == TAGS_UNSET)
-		argv_array_push(argv, "--no-tags");
+		strvec_push(argv, "--no-tags");
 	if (verbosity >= 2)
-		argv_array_push(argv, "-v");
+		strvec_push(argv, "-v");
 	if (verbosity >= 1)
-		argv_array_push(argv, "-v");
+		strvec_push(argv, "-v");
 	else if (verbosity < 0)
-		argv_array_push(argv, "-q");
+		strvec_push(argv, "-q");
 
 }
 
@@ -1554,8 +1554,8 @@ static int fetch_next_remote(struct child_process *cp, struct strbuf *out,
 	remote = state->remotes->items[state->next++].string;
 	*task_cb = remote;
 
-	argv_array_pushv(&cp->args, state->argv);
-	argv_array_push(&cp->args, remote);
+	strvec_pushv(&cp->args, state->argv);
+	strvec_push(&cp->args, remote);
 	cp->git_cmd = 1;
 
 	if (verbosity >= 0)
@@ -1592,22 +1592,22 @@ static int fetch_finished(int result, struct strbuf *out,
 static int fetch_multiple(struct string_list *list, int max_children)
 {
 	int i, result = 0;
-	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct strvec argv = STRVEC_INIT;
 
 	if (!append && !dry_run) {
 		int errcode = truncate_fetch_head();
 		if (errcode)
 			return errcode;
 	}
 
-	argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc",
+	strvec_pushl(&argv, "fetch", "--append", "--no-auto-gc",
 			"--no-write-commit-graph", NULL);
 	add_options_to_argv(&argv);
 
 	if (max_children != 1 && list->nr != 1) {
 		struct parallel_fetch_state state = { argv.argv, list, 0, 0 };
 
-		argv_array_push(&argv, "--end-of-options");
+		strvec_push(&argv, "--end-of-options");
 		result = run_processes_parallel_tr2(max_children,
 						    &fetch_next_remote,
 						    &fetch_failed_to_start,
@@ -1620,17 +1620,17 @@ static int fetch_multiple(struct string_list *list, int max_children)
 	} else
 		for (i = 0; i < list->nr; i++) {
 			const char *name = list->items[i].string;
-			argv_array_push(&argv, name);
+			strvec_push(&argv, name);
 			if (verbosity >= 0)
 				printf(_("Fetching %s\n"), name);
 			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
 				error(_("Could not fetch %s"), name);
 				result = 1;
 			}
-			argv_array_pop(&argv);
+			strvec_pop(&argv);
 		}
 
-	argv_array_clear(&argv);
+	strvec_clear(&argv);
 	return !!result;
 }
 
@@ -1844,7 +1844,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
-		struct argv_array options = ARGV_ARRAY_INIT;
+		struct strvec options = STRVEC_INIT;
 		int max_children = max_jobs;
 
 		if (max_children < 0)
@@ -1860,7 +1860,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 						    recurse_submodules_default,
 						    verbosity < 0,
 						    max_children);
-		argv_array_clear(&options);
+		strvec_clear(&options);
 	}
 
 	string_list_clear(&list, 0);
diff --git a/builtin/gc.c b/builtin/gc.c
index 27951ee061..89742e159e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -50,12 +50,12 @@ static const char *prune_worktrees_expire = "3.months.ago";
 static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
-static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
-static struct argv_array reflog = ARGV_ARRAY_INIT;
-static struct argv_array repack = ARGV_ARRAY_INIT;
-static struct argv_array prune = ARGV_ARRAY_INIT;
-static struct argv_array prune_worktrees = ARGV_ARRAY_INIT;
-static struct argv_array rerere = ARGV_ARRAY_INIT;
+static struct strvec pack_refs_cmd = STRVEC_INIT;
+static struct strvec reflog = STRVEC_INIT;
+static struct strvec repack = STRVEC_INIT;
+static struct strvec prune = STRVEC_INIT;
+static struct strvec prune_worktrees = STRVEC_INIT;
+static struct strvec rerere = STRVEC_INIT;
 
 static struct tempfile *pidfile;
 static struct lock_file log_lock;
@@ -311,18 +311,18 @@ static uint64_t estimate_repack_memory(struct packed_git *pack)
 
 static int keep_one_pack(struct string_list_item *item, void *data)
 {
-	argv_array_pushf(&repack, "--keep-pack=%s", basename(item->string));
+	strvec_pushf(&repack, "--keep-pack=%s", basename(item->string));
 	return 0;
 }
 
 static void add_repack_all_option(struct string_list *keep_pack)
 {
 	if (prune_expire && !strcmp(prune_expire, "now"))
-		argv_array_push(&repack, "-a");
+		strvec_push(&repack, "-a");
 	else {
-		argv_array_push(&repack, "-A");
+		strvec_push(&repack, "-A");
 		if (prune_expire)
-			argv_array_pushf(&repack, "--unpack-unreachable=%s", prune_expire);
+			strvec_pushf(&repack, "--unpack-unreachable=%s", prune_expire);
 	}
 
 	if (keep_pack)
@@ -331,7 +331,7 @@ static void add_repack_all_option(struct string_list *keep_pack)
 
 static void add_repack_incremental_option(void)
 {
-	argv_array_push(&repack, "--no-write-bitmap-index");
+	strvec_push(&repack, "--no-write-bitmap-index");
 }
 
 static int need_to_gc(void)
@@ -552,12 +552,12 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
-	argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
-	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
-	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
-	argv_array_pushl(&prune, "prune", "--expire", NULL);
-	argv_array_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
-	argv_array_pushl(&rerere, "rerere", "gc", NULL);
+	strvec_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
+	strvec_pushl(&reflog, "reflog", "expire", "--all", NULL);
+	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
+	strvec_pushl(&prune, "prune", "--expire", NULL);
+	strvec_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
+	strvec_pushl(&rerere, "rerere", "gc", NULL);
 
 	/* default expiry time, overwritten in gc_config */
 	gc_config();
@@ -576,14 +576,14 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		die(_("failed to parse prune expiry value %s"), prune_expire);
 
 	if (aggressive) {
-		argv_array_push(&repack, "-f");
+		strvec_push(&repack, "-f");
 		if (aggressive_depth > 0)
-			argv_array_pushf(&repack, "--depth=%d", aggressive_depth);
+			strvec_pushf(&repack, "--depth=%d", aggressive_depth);
 		if (aggressive_window > 0)
-			argv_array_pushf(&repack, "--window=%d", aggressive_window);
+			strvec_pushf(&repack, "--window=%d", aggressive_window);
 	}
 	if (quiet)
-		argv_array_push(&repack, "-q");
+		strvec_push(&repack, "-q");
 
 	if (auto_gc) {
 		/*
@@ -657,19 +657,19 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			die(FAILED_RUN, repack.argv[0]);
 
 		if (prune_expire) {
-			argv_array_push(&prune, prune_expire);
+			strvec_push(&prune, prune_expire);
 			if (quiet)
-				argv_array_push(&prune, "--no-progress");
+				strvec_push(&prune, "--no-progress");
 			if (has_promisor_remote())
-				argv_array_push(&prune,
+				strvec_push(&prune,
 						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
 				die(FAILED_RUN, prune.argv[0]);
 		}
 	}
 
 	if (prune_worktrees_expire) {
-		argv_array_push(&prune_worktrees, prune_worktrees_expire);
+		strvec_push(&prune_worktrees, prune_worktrees_expire);
 		if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
 			die(FAILED_RUN, prune_worktrees.argv[0]);
 	}
diff --git a/builtin/grep.c b/builtin/grep.c
index a5056f395a..2ae77eb8b3 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -397,7 +397,7 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 	int i, status;
 
 	for (i = 0; i < path_list->nr; i++)
-		argv_array_push(&child.args, path_list->items[i].string);
+		strvec_push(&child.args, path_list->items[i].string);
 	child.dir = prefix;
 	child.use_shell = 1;
 
diff --git a/builtin/log.c b/builtin/log.c
index d104d5c688..33528fefa9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1128,18 +1128,18 @@ static void prepare_cover_text(struct pretty_print_context *pp,
 
 static int get_notes_refs(struct string_list_item *item, void *arg)
 {
-	argv_array_pushf(arg, "--notes=%s", item->string);
+	strvec_pushf(arg, "--notes=%s", item->string);
 	return 0;
 }
 
-static void get_notes_args(struct argv_array *arg, struct rev_info *rev)
+static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 {
 	if (!rev->show_notes) {
-		argv_array_push(arg, "--no-notes");
+		strvec_push(arg, "--no-notes");
 	} else if (rev->notes_opt.use_default_notes > 0 ||
 		   (rev->notes_opt.use_default_notes == -1 &&
 		    !rev->notes_opt.extra_notes_refs.nr)) {
-		argv_array_push(arg, "--notes");
+		strvec_push(arg, "--notes");
 	} else {
 		for_each_string_list(&rev->notes_opt.extra_notes_refs, get_notes_refs, arg);
 	}
@@ -1217,7 +1217,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		 * can be added later if deemed desirable.
 		 */
 		struct diff_options opts;
-		struct argv_array other_arg = ARGV_ARRAY_INIT;
+		struct strvec other_arg = STRVEC_INIT;
 		diff_setup(&opts);
 		opts.file = rev->diffopt.file;
 		opts.use_color = rev->diffopt.use_color;
@@ -1226,7 +1226,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		get_notes_args(&other_arg, rev);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
 				rev->creation_factor, 1, &opts, &other_arg);
-		argv_array_clear(&other_arg);
+		strvec_clear(&other_arg);
 	}
 }
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 3a4dd12903..ea91679f33 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -45,7 +45,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int show_symref_target = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
-	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
+	struct strvec ref_prefixes = STRVEC_INIT;
 	int i;
 	struct string_list server_options = STRING_LIST_INIT_DUP;
 
@@ -92,9 +92,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	if (flags & REF_TAGS)
-		argv_array_push(&ref_prefixes, "refs/tags/");
+		strvec_push(&ref_prefixes, "refs/tags/");
 	if (flags & REF_HEADS)
-		argv_array_push(&ref_prefixes, "refs/heads/");
+		strvec_push(&ref_prefixes, "refs/heads/");
 
 	remote = remote_get(dest);
 	if (!remote) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5f18f0ee9d..323f8bce80 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3439,7 +3439,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int use_internal_rev_list = 0;
 	int shallow = 0;
 	int all_progress_implied = 0;
-	struct argv_array rp = ARGV_ARRAY_INIT;
+	struct strvec rp = STRVEC_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
@@ -3575,36 +3575,36 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		cache_max_small_delta_size = (1U << OE_Z_DELTA_BITS) - 1;
 	}
 
-	argv_array_push(&rp, "pack-objects");
+	strvec_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
-		argv_array_push(&rp, shallow
+		strvec_push(&rp, shallow
 				? "--objects-edge-aggressive"
 				: "--objects-edge");
 	} else
-		argv_array_push(&rp, "--objects");
+		strvec_push(&rp, "--objects");
 
 	if (rev_list_all) {
 		use_internal_rev_list = 1;
-		argv_array_push(&rp, "--all");
+		strvec_push(&rp, "--all");
 	}
 	if (rev_list_reflog) {
 		use_internal_rev_list = 1;
-		argv_array_push(&rp, "--reflog");
+		strvec_push(&rp, "--reflog");
 	}
 	if (rev_list_index) {
 		use_internal_rev_list = 1;
-		argv_array_push(&rp, "--indexed-objects");
+		strvec_push(&rp, "--indexed-objects");
 	}
 	if (rev_list_unpacked) {
 		use_internal_rev_list = 1;
-		argv_array_push(&rp, "--unpacked");
+		strvec_push(&rp, "--unpacked");
 	}
 
 	if (exclude_promisor_objects) {
 		use_internal_rev_list = 1;
 		fetch_if_missing = 0;
-		argv_array_push(&rp, "--exclude-promisor-objects");
+		strvec_push(&rp, "--exclude-promisor-objects");
 	}
 	if (unpack_unreachable || keep_unreachable || pack_loose_unreachable)
 		use_internal_rev_list = 1;
@@ -3666,7 +3666,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		write_bitmap_index = 0;
 
 	if (use_delta_islands)
-		argv_array_push(&rp, "--topo-order");
+		strvec_push(&rp, "--topo-order");
 
 	if (progress && all_progress_implied)
 		progress = 2;
@@ -3705,7 +3705,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		read_object_list_from_stdin();
 	else {
 		get_object_list(rp.argc, rp.argv);
-		argv_array_clear(&rp);
+		strvec_clear(&rp);
 	}
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
diff --git a/builtin/pull.c b/builtin/pull.c
index 8159c5d7c9..8a8d30e1dc 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -87,8 +87,8 @@ static char *opt_verify_signatures;
 static int opt_autostash = -1;
 static int config_autostash;
 static int check_trust_level = 1;
-static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
-static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
+static struct strvec opt_strategies = STRVEC_INIT;
+static struct strvec opt_strategy_opts = STRVEC_INIT;
 static char *opt_gpg_sign;
 static int opt_allow_unrelated_histories;
 
@@ -110,7 +110,7 @@ static char *opt_ipv4;
 static char *opt_ipv6;
 static int opt_show_forced_updates = -1;
 static char *set_upstream;
-static struct argv_array opt_fetch = ARGV_ARRAY_INIT;
+static struct strvec opt_fetch = STRVEC_INIT;
 
 static struct option pull_options[] = {
 	/* Shared options */
@@ -251,25 +251,25 @@ static struct option pull_options[] = {
 /**
  * Pushes "-q" or "-v" switches into arr to match the opt_verbosity level.
  */
-static void argv_push_verbosity(struct argv_array *arr)
+static void argv_push_verbosity(struct strvec *arr)
 {
 	int verbosity;
 
 	for (verbosity = opt_verbosity; verbosity > 0; verbosity--)
-		argv_array_push(arr, "-v");
+		strvec_push(arr, "-v");
 
 	for (verbosity = opt_verbosity; verbosity < 0; verbosity++)
-		argv_array_push(arr, "-q");
+		strvec_push(arr, "-q");
 }
 
 /**
  * Pushes "-f" switches into arr to match the opt_force level.
  */
-static void argv_push_force(struct argv_array *arr)
+static void argv_push_force(struct strvec *arr)
 {
 	int force = opt_force;
 	while (force-- > 0)
-		argv_array_push(arr, "-f");
+		strvec_push(arr, "-f");
 }
 
 /**
@@ -524,75 +524,75 @@ static void parse_repo_refspecs(int argc, const char **argv, const char **repo,
  */
 static int run_fetch(const char *repo, const char **refspecs)
 {
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 	int ret;
 
-	argv_array_pushl(&args, "fetch", "--update-head-ok", NULL);
+	strvec_pushl(&args, "fetch", "--update-head-ok", NULL);
 
 	/* Shared options */
 	argv_push_verbosity(&args);
 	if (opt_progress)
-		argv_array_push(&args, opt_progress);
+		strvec_push(&args, opt_progress);
 
 	/* Options passed to git-fetch */
 	if (opt_all)
-		argv_array_push(&args, opt_all);
+		strvec_push(&args, opt_all);
 	if (opt_append)
-		argv_array_push(&args, opt_append);
+		strvec_push(&args, opt_append);
 	if (opt_upload_pack)
-		argv_array_push(&args, opt_upload_pack);
+		strvec_push(&args, opt_upload_pack);
 	argv_push_force(&args);
 	if (opt_tags)
-		argv_array_push(&args, opt_tags);
+		strvec_push(&args, opt_tags);
 	if (opt_prune)
-		argv_array_push(&args, opt_prune);
+		strvec_push(&args, opt_prune);
 	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
 		switch (recurse_submodules) {
 		case RECURSE_SUBMODULES_ON:
-			argv_array_push(&args, "--recurse-submodules=on");
+			strvec_push(&args, "--recurse-submodules=on");
 			break;
 		case RECURSE_SUBMODULES_OFF:
-			argv_array_push(&args, "--recurse-submodules=no");
+			strvec_push(&args, "--recurse-submodules=no");
 			break;
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			argv_array_push(&args, "--recurse-submodules=on-demand");
+			strvec_push(&args, "--recurse-submodules=on-demand");
 			break;
 		default:
 			BUG("submodule recursion option not understood");
 		}
 	if (max_children)
-		argv_array_push(&args, max_children);
+		strvec_push(&args, max_children);
 	if (opt_dry_run)
-		argv_array_push(&args, "--dry-run");
+		strvec_push(&args, "--dry-run");
 	if (opt_keep)
-		argv_array_push(&args, opt_keep);
+		strvec_push(&args, opt_keep);
 	if (opt_depth)
-		argv_array_push(&args, opt_depth);
+		strvec_push(&args, opt_depth);
 	if (opt_unshallow)
-		argv_array_push(&args, opt_unshallow);
+		strvec_push(&args, opt_unshallow);
 	if (opt_update_shallow)
-		argv_array_push(&args, opt_update_shallow);
+		strvec_push(&args, opt_update_shallow);
 	if (opt_refmap)
-		argv_array_push(&args, opt_refmap);
+		strvec_push(&args, opt_refmap);
 	if (opt_ipv4)
-		argv_array_push(&args, opt_ipv4);
+		strvec_push(&args, opt_ipv4);
 	if (opt_ipv6)
-		argv_array_push(&args, opt_ipv6);
+		strvec_push(&args, opt_ipv6);
 	if (opt_show_forced_updates > 0)
-		argv_array_push(&args, "--show-forced-updates");
+		strvec_push(&args, "--show-forced-updates");
 	else if (opt_show_forced_updates == 0)
-		argv_array_push(&args, "--no-show-forced-updates");
+		strvec_push(&args, "--no-show-forced-updates");
 	if (set_upstream)
-		argv_array_push(&args, set_upstream);
-	argv_array_pushv(&args, opt_fetch.argv);
+		strvec_push(&args, set_upstream);
+	strvec_pushv(&args, opt_fetch.argv);
 
 	if (repo) {
-		argv_array_push(&args, repo);
-		argv_array_pushv(&args, refspecs);
+		strvec_push(&args, repo);
+		strvec_pushv(&args, refspecs);
 	} else if (*refspecs)
 		BUG("refspecs without repo?");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
-	argv_array_clear(&args);
+	strvec_clear(&args);
 	return ret;
 }
 
@@ -637,7 +637,7 @@ static int rebase_submodules(void)
 
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-	argv_array_pushl(&cp.args, "submodule", "update",
+	strvec_pushl(&cp.args, "submodule", "update",
 				   "--recursive", "--rebase", NULL);
 	argv_push_verbosity(&cp.args);
 
@@ -650,7 +650,7 @@ static int update_submodules(void)
 
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-	argv_array_pushl(&cp.args, "submodule", "update",
+	strvec_pushl(&cp.args, "submodule", "update",
 				   "--recursive", "--checkout", NULL);
 	argv_push_verbosity(&cp.args);
 
@@ -663,48 +663,48 @@ static int update_submodules(void)
 static int run_merge(void)
 {
 	int ret;
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 
-	argv_array_pushl(&args, "merge", NULL);
+	strvec_pushl(&args, "merge", NULL);
 
 	/* Shared options */
 	argv_push_verbosity(&args);
 	if (opt_progress)
-		argv_array_push(&args, opt_progress);
+		strvec_push(&args, opt_progress);
 
 	/* Options passed to git-merge */
 	if (opt_diffstat)
-		argv_array_push(&args, opt_diffstat);
+		strvec_push(&args, opt_diffstat);
 	if (opt_log)
-		argv_array_push(&args, opt_log);
+		strvec_push(&args, opt_log);
 	if (opt_signoff)
-		argv_array_push(&args, opt_signoff);
+		strvec_push(&args, opt_signoff);
 	if (opt_squash)
-		argv_array_push(&args, opt_squash);
+		strvec_push(&args, opt_squash);
 	if (opt_commit)
-		argv_array_push(&args, opt_commit);
+		strvec_push(&args, opt_commit);
 	if (opt_edit)
-		argv_array_push(&args, opt_edit);
+		strvec_push(&args, opt_edit);
 	if (cleanup_arg)
-		argv_array_pushf(&args, "--cleanup=%s", cleanup_arg);
+		strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
 	if (opt_ff)
-		argv_array_push(&args, opt_ff);
+		strvec_push(&args, opt_ff);
 	if (opt_verify_signatures)
-		argv_array_push(&args, opt_verify_signatures);
-	argv_array_pushv(&args, opt_strategies.argv);
-	argv_array_pushv(&args, opt_strategy_opts.argv);
+		strvec_push(&args, opt_verify_signatures);
+	strvec_pushv(&args, opt_strategies.argv);
+	strvec_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
-		argv_array_push(&args, opt_gpg_sign);
+		strvec_push(&args, opt_gpg_sign);
 	if (opt_autostash == 0)
-		argv_array_push(&args, "--no-autostash");
+		strvec_push(&args, "--no-autostash");
 	else if (opt_autostash == 1)
-		argv_array_push(&args, "--autostash");
+		strvec_push(&args, "--autostash");
 	if (opt_allow_unrelated_histories > 0)
-		argv_array_push(&args, "--allow-unrelated-histories");
+		strvec_push(&args, "--allow-unrelated-histories");
 
-	argv_array_push(&args, "FETCH_HEAD");
+	strvec_push(&args, "FETCH_HEAD");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
-	argv_array_clear(&args);
+	strvec_clear(&args);
 	return ret;
 }
 
@@ -801,7 +801,7 @@ static int get_rebase_fork_point(struct object_id *fork_point, const char *repo,
 	if (!remote_branch)
 		return -1;
 
-	argv_array_pushl(&cp.args, "merge-base", "--fork-point",
+	strvec_pushl(&cp.args, "merge-base", "--fork-point",
 			remote_branch, curr_branch->name, NULL);
 	cp.no_stdin = 1;
 	cp.no_stderr = 1;
@@ -862,48 +862,48 @@ static int run_rebase(const struct object_id *curr_head,
 {
 	int ret;
 	struct object_id oct_merge_base;
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 
 	if (!get_octopus_merge_base(&oct_merge_base, curr_head, merge_head, fork_point))
 		if (!is_null_oid(fork_point) && oideq(&oct_merge_base, fork_point))
 			fork_point = NULL;
 
-	argv_array_push(&args, "rebase");
+	strvec_push(&args, "rebase");
 
 	/* Shared options */
 	argv_push_verbosity(&args);
 
 	/* Options passed to git-rebase */
 	if (opt_rebase == REBASE_MERGES)
-		argv_array_push(&args, "--rebase-merges");
+		strvec_push(&args, "--rebase-merges");
 	else if (opt_rebase == REBASE_PRESERVE)
-		argv_array_push(&args, "--preserve-merges");
+		strvec_push(&args, "--preserve-merges");
 	else if (opt_rebase == REBASE_INTERACTIVE)
-		argv_array_push(&args, "--interactive");
+		strvec_push(&args, "--interactive");
 	if (opt_diffstat)
-		argv_array_push(&args, opt_diffstat);
-	argv_array_pushv(&args, opt_strategies.argv);
-	argv_array_pushv(&args, opt_strategy_opts.argv);
+		strvec_push(&args, opt_diffstat);
+	strvec_pushv(&args, opt_strategies.argv);
+	strvec_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
-		argv_array_push(&args, opt_gpg_sign);
+		strvec_push(&args, opt_gpg_sign);
 	if (opt_autostash == 0)
-		argv_array_push(&args, "--no-autostash");
+		strvec_push(&args, "--no-autostash");
 	else if (opt_autostash == 1)
-		argv_array_push(&args, "--autostash");
+		strvec_push(&args, "--autostash");
 	if (opt_verify_signatures &&
 	    !strcmp(opt_verify_signatures, "--verify-signatures"))
 		warning(_("ignoring --verify-signatures for rebase"));
 
-	argv_array_push(&args, "--onto");
-	argv_array_push(&args, oid_to_hex(merge_head));
+	strvec_push(&args, "--onto");
+	strvec_push(&args, oid_to_hex(merge_head));
 
 	if (fork_point && !is_null_oid(fork_point))
-		argv_array_push(&args, oid_to_hex(fork_point));
+		strvec_push(&args, oid_to_hex(fork_point));
 	else
-		argv_array_push(&args, oid_to_hex(merge_head));
+		strvec_push(&args, oid_to_hex(merge_head));
 
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
-	argv_array_clear(&args);
+	strvec_clear(&args);
 	return ret;
 }
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index d8a4670629..24c4162f74 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -15,7 +15,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	struct diff_options diffopt = { NULL };
-	struct argv_array other_arg = ARGV_ARRAY_INIT;
+	struct strvec other_arg = STRVEC_INIT;
 	int simple_color = -1;
 	struct option range_diff_options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
@@ -84,7 +84,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	res = show_range_diff(range1.buf, range2.buf, creation_factor,
 			      simple_color < 1, &diffopt, &other_arg);
 
-	argv_array_clear(&other_arg);
+	strvec_clear(&other_arg);
 	strbuf_release(&range1);
 	strbuf_release(&range2);
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 38145a66ed..fb56b9e263 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -84,7 +84,7 @@ struct rebase_options {
 		REBASE_FORCE = 1<<3,
 		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
 	} flags;
-	struct argv_array git_am_opts;
+	struct strvec git_am_opts;
 	const char *action;
 	int signoff;
 	int allow_rerere_autoupdate;
@@ -108,7 +108,7 @@ struct rebase_options {
 		.keep_empty = 1,			\
 		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
-		.git_am_opts = ARGV_ARRAY_INIT,		\
+		.git_am_opts = STRVEC_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
 	}
 
@@ -323,7 +323,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	int ret;
 	const char *head_hash = NULL;
 	char *revisions = NULL, *shortrevisions = NULL;
-	struct argv_array make_script_args = ARGV_ARRAY_INIT;
+	struct strvec make_script_args = STRVEC_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct replay_opts replay = get_replay_opts(opts);
 	struct string_list commands = STRING_LIST_INIT_DUP;
@@ -345,9 +345,9 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 		write_file(path_squash_onto(), "%s\n",
 			   oid_to_hex(opts->squash_onto));
 
-	argv_array_pushl(&make_script_args, "", revisions, NULL);
+	strvec_pushl(&make_script_args, "", revisions, NULL);
 	if (opts->restrict_revision)
-		argv_array_pushf(&make_script_args, "^%s",
+		strvec_pushf(&make_script_args, "^%s",
 				 oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
@@ -372,7 +372,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	free(revisions);
 	free(shortrevisions);
 	todo_list_release(&todo_list);
-	argv_array_clear(&make_script_args);
+	strvec_clear(&make_script_args);
 
 	return ret;
 }
@@ -420,7 +420,7 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
-		argv_array_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
+		strvec_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
 		ret = run_command(&cmd);
 
 		break;
@@ -811,30 +811,30 @@ static int run_am(struct rebase_options *opts)
 	char *rebased_patches;
 
 	am.git_cmd = 1;
-	argv_array_push(&am.args, "am");
+	strvec_push(&am.args, "am");
 
 	if (opts->action && !strcmp("continue", opts->action)) {
-		argv_array_push(&am.args, "--resolved");
-		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+		strvec_push(&am.args, "--resolved");
+		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
 		if (opts->gpg_sign_opt)
-			argv_array_push(&am.args, opts->gpg_sign_opt);
+			strvec_push(&am.args, opts->gpg_sign_opt);
 		status = run_command(&am);
 		if (status)
 			return status;
 
 		return move_to_original_branch(opts);
 	}
 	if (opts->action && !strcmp("skip", opts->action)) {
-		argv_array_push(&am.args, "--skip");
-		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+		strvec_push(&am.args, "--skip");
+		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
 		status = run_command(&am);
 		if (status)
 			return status;
 
 		return move_to_original_branch(opts);
 	}
 	if (opts->action && !strcmp("show-current-patch", opts->action)) {
-		argv_array_push(&am.args, "--show-current-patch");
+		strvec_push(&am.args, "--show-current-patch");
 		return run_command(&am);
 	}
 
@@ -852,29 +852,29 @@ static int run_am(struct rebase_options *opts)
 		status = error_errno(_("could not open '%s' for writing"),
 				     rebased_patches);
 		free(rebased_patches);
-		argv_array_clear(&am.args);
+		strvec_clear(&am.args);
 		return status;
 	}
 
 	format_patch.git_cmd = 1;
-	argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
+	strvec_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
 			 "--full-index", "--cherry-pick", "--right-only",
 			 "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
 			 "--no-cover-letter", "--pretty=mboxrd", "--topo-order",
 			 "--no-base", NULL);
 	if (opts->git_format_patch_opt.len)
-		argv_array_split(&format_patch.args,
+		strvec_split(&format_patch.args,
 				 opts->git_format_patch_opt.buf);
-	argv_array_push(&format_patch.args, revisions.buf);
+	strvec_push(&format_patch.args, revisions.buf);
 	if (opts->restrict_revision)
-		argv_array_pushf(&format_patch.args, "^%s",
+		strvec_pushf(&format_patch.args, "^%s",
 				 oid_to_hex(&opts->restrict_revision->object.oid));
 
 	status = run_command(&format_patch);
 	if (status) {
 		unlink(rebased_patches);
 		free(rebased_patches);
-		argv_array_clear(&am.args);
+		strvec_clear(&am.args);
 
 		reset_head(the_repository, &opts->orig_head, "checkout",
 			   opts->head_name, 0,
@@ -896,20 +896,20 @@ static int run_am(struct rebase_options *opts)
 		status = error_errno(_("could not open '%s' for reading"),
 				     rebased_patches);
 		free(rebased_patches);
-		argv_array_clear(&am.args);
+		strvec_clear(&am.args);
 		return status;
 	}
 
-	argv_array_pushv(&am.args, opts->git_am_opts.argv);
-	argv_array_push(&am.args, "--rebasing");
-	argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
-	argv_array_push(&am.args, "--patch-format=mboxrd");
+	strvec_pushv(&am.args, opts->git_am_opts.argv);
+	strvec_push(&am.args, "--rebasing");
+	strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+	strvec_push(&am.args, "--patch-format=mboxrd");
 	if (opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE)
-		argv_array_push(&am.args, "--rerere-autoupdate");
+		strvec_push(&am.args, "--rerere-autoupdate");
 	else if (opts->allow_rerere_autoupdate == RERERE_NOAUTOUPDATE)
-		argv_array_push(&am.args, "--no-rerere-autoupdate");
+		strvec_push(&am.args, "--no-rerere-autoupdate");
 	if (opts->gpg_sign_opt)
-		argv_array_push(&am.args, opts->gpg_sign_opt);
+		strvec_push(&am.args, opts->gpg_sign_opt);
 	status = run_command(&am);
 	unlink(rebased_patches);
 	free(rebased_patches);
@@ -1649,7 +1649,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			exit(1);
 
 	if (!(options.flags & REBASE_NO_QUIET))
-		argv_array_push(&options.git_am_opts, "-q");
+		strvec_push(&options.git_am_opts, "-q");
 
 	if (options.empty != EMPTY_UNSPECIFIED)
 		imply_merge(&options, "--empty");
@@ -1776,7 +1776,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (options.type == REBASE_PRESERVE_MERGES)
 			die("cannot combine '--signoff' with "
 			    "'--preserve-merges'");
-		argv_array_push(&options.git_am_opts, "--signoff");
+		strvec_push(&options.git_am_opts, "--signoff");
 		options.flags |= REBASE_FORCE;
 	}
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1285631481..71274231aa 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -667,23 +667,23 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		nonce_status = check_nonce(push_cert.buf, bogs);
 	}
 	if (!is_null_oid(&push_cert_oid)) {
-		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT=%s",
+		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT=%s",
 				 oid_to_hex(&push_cert_oid));
-		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_SIGNER=%s",
+		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_SIGNER=%s",
 				 sigcheck.signer ? sigcheck.signer : "");
-		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_KEY=%s",
+		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_KEY=%s",
 				 sigcheck.key ? sigcheck.key : "");
-		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_STATUS=%c",
+		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_STATUS=%c",
 				 sigcheck.result);
 		if (push_cert_nonce) {
-			argv_array_pushf(&proc->env_array,
+			strvec_pushf(&proc->env_array,
 					 "GIT_PUSH_CERT_NONCE=%s",
 					 push_cert_nonce);
-			argv_array_pushf(&proc->env_array,
+			strvec_pushf(&proc->env_array,
 					 "GIT_PUSH_CERT_NONCE_STATUS=%s",
 					 nonce_status);
 			if (nonce_status == NONCE_SLOP)
-				argv_array_pushf(&proc->env_array,
+				strvec_pushf(&proc->env_array,
 						 "GIT_PUSH_CERT_NONCE_SLOP=%ld",
 						 nonce_stamp_slop);
 		}
@@ -720,16 +720,16 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	if (feed_state->push_options) {
 		int i;
 		for (i = 0; i < feed_state->push_options->nr; i++)
-			argv_array_pushf(&proc.env_array,
+			strvec_pushf(&proc.env_array,
 				"GIT_PUSH_OPTION_%d=%s", i,
 				feed_state->push_options->items[i].string);
-		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
+		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
 				 feed_state->push_options->nr);
 	} else
-		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
+		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
 
 	if (tmp_objdir)
-		argv_array_pushv(&proc.env_array, tmp_objdir_env(tmp_objdir));
+		strvec_pushv(&proc.env_array, tmp_objdir_env(tmp_objdir));
 
 	if (use_sideband) {
 		memset(&muxer, 0, sizeof(muxer));
@@ -931,7 +931,7 @@ static int head_has_history(void)
 }
 
 static const char *push_to_deploy(unsigned char *sha1,
-				  struct argv_array *env,
+				  struct strvec *env,
 				  const char *work_tree)
 {
 	const char *update_refresh[] = {
@@ -1000,10 +1000,10 @@ static const char *push_to_deploy(unsigned char *sha1,
 static const char *push_to_checkout_hook = "push-to-checkout";
 
 static const char *push_to_checkout(unsigned char *hash,
-				    struct argv_array *env,
+				    struct strvec *env,
 				    const char *work_tree)
 {
-	argv_array_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
+	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
 	if (run_hook_le(env->argv, push_to_checkout_hook,
 			hash_to_hex(hash), NULL))
 		return "push-to-checkout hook declined";
@@ -1014,7 +1014,7 @@ static const char *push_to_checkout(unsigned char *hash,
 static const char *update_worktree(unsigned char *sha1, const struct worktree *worktree)
 {
 	const char *retval, *work_tree, *git_dir = NULL;
-	struct argv_array env = ARGV_ARRAY_INIT;
+	struct strvec env = STRVEC_INIT;
 
 	if (worktree && worktree->path)
 		work_tree = worktree->path;
@@ -1030,14 +1030,14 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 	if (!git_dir)
 		git_dir = get_git_dir();
 
-	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
+	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
 	if (!find_hook(push_to_checkout_hook))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
 
-	argv_array_clear(&env);
+	strvec_clear(&env);
 	return retval;
 }
 
@@ -1206,8 +1206,8 @@ static void run_update_post_hook(struct command *commands)
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
 		if (!proc.args.argc)
-			argv_array_push(&proc.args, hook);
-		argv_array_push(&proc.args, cmd->ref_name);
+			strvec_push(&proc.args, hook);
+		strvec_push(&proc.args, cmd->ref_name);
 	}
 	if (!proc.args.argc)
 		return;
@@ -1715,9 +1715,9 @@ static const char *parse_pack_header(struct pack_header *hdr)
 
 static const char *pack_lockfile;
 
-static void push_header_arg(struct argv_array *args, struct pack_header *hdr)
+static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 {
-	argv_array_pushf(args, "--pack_header=%"PRIu32",%"PRIu32,
+	strvec_pushf(args, "--pack_header=%"PRIu32",%"PRIu32,
 			ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
@@ -1742,8 +1742,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 
 	if (si->nr_ours || si->nr_theirs) {
 		alt_shallow_file = setup_temporary_shallow(si->shallow);
-		argv_array_push(&child.args, "--shallow-file");
-		argv_array_push(&child.args, alt_shallow_file);
+		strvec_push(&child.args, "--shallow-file");
+		strvec_push(&child.args, alt_shallow_file);
 	}
 
 	tmp_objdir = tmp_objdir_create();
@@ -1762,15 +1762,15 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 	tmp_objdir_add_as_alternate(tmp_objdir);
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
-		argv_array_push(&child.args, "unpack-objects");
+		strvec_push(&child.args, "unpack-objects");
 		push_header_arg(&child.args, &hdr);
 		if (quiet)
-			argv_array_push(&child.args, "-q");
+			strvec_push(&child.args, "-q");
 		if (fsck_objects)
-			argv_array_pushf(&child.args, "--strict%s",
+			strvec_pushf(&child.args, "--strict%s",
 				fsck_msg_types.buf);
 		if (max_input_size)
-			argv_array_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				(uintmax_t)max_input_size);
 		child.no_stdout = 1;
 		child.err = err_fd;
@@ -1781,27 +1781,27 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 	} else {
 		char hostname[HOST_NAME_MAX + 1];
 
-		argv_array_pushl(&child.args, "index-pack", "--stdin", NULL);
+		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
 		push_header_arg(&child.args, &hdr);
 
 		if (xgethostname(hostname, sizeof(hostname)))
 			xsnprintf(hostname, sizeof(hostname), "localhost");
-		argv_array_pushf(&child.args,
+		strvec_pushf(&child.args,
 				 "--keep=receive-pack %"PRIuMAX" on %s",
 				 (uintmax_t)getpid(),
 				 hostname);
 
 		if (!quiet && err_fd)
-			argv_array_push(&child.args, "--show-resolving-progress");
+			strvec_push(&child.args, "--show-resolving-progress");
 		if (use_sideband)
-			argv_array_push(&child.args, "--report-end-of-input");
+			strvec_push(&child.args, "--report-end-of-input");
 		if (fsck_objects)
-			argv_array_pushf(&child.args, "--strict%s",
+			strvec_pushf(&child.args, "--strict%s",
 				fsck_msg_types.buf);
 		if (!reject_thin)
-			argv_array_push(&child.args, "--fix-thin");
+			strvec_push(&child.args, "--fix-thin");
 		if (max_input_size)
-			argv_array_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				(uintmax_t)max_input_size);
 		child.out = -1;
 		child.err = err_fd;
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 6a9127a33c..fd3538d4f0 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -117,12 +117,12 @@ static char *strip_escapes(const char *str, const char *service,
 	}
 }
 
-static void parse_argv(struct argv_array *out, const char *arg, const char *service)
+static void parse_argv(struct strvec *out, const char *arg, const char *service)
 {
 	while (*arg) {
 		char *expanded = strip_escapes(arg, service, &arg);
 		if (expanded)
-			argv_array_push(out, expanded);
+			strvec_push(out, expanded);
 		free(expanded);
 	}
 }
diff --git a/builtin/remote.c b/builtin/remote.c
index a9f35ba855..a3b33c2c88 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1451,35 +1451,35 @@ static int update(int argc, const char **argv)
 			 N_("prune remotes after fetching")),
 		OPT_END()
 	};
-	struct argv_array fetch_argv = ARGV_ARRAY_INIT;
+	struct strvec fetch_argv = STRVEC_INIT;
 	int default_defined = 0;
 	int retval;
 
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_update_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 
-	argv_array_push(&fetch_argv, "fetch");
+	strvec_push(&fetch_argv, "fetch");
 
 	if (prune != -1)
-		argv_array_push(&fetch_argv, prune ? "--prune" : "--no-prune");
+		strvec_push(&fetch_argv, prune ? "--prune" : "--no-prune");
 	if (verbose)
-		argv_array_push(&fetch_argv, "-v");
-	argv_array_push(&fetch_argv, "--multiple");
+		strvec_push(&fetch_argv, "-v");
+	strvec_push(&fetch_argv, "--multiple");
 	if (argc < 2)
-		argv_array_push(&fetch_argv, "default");
+		strvec_push(&fetch_argv, "default");
 	for (i = 1; i < argc; i++)
-		argv_array_push(&fetch_argv, argv[i]);
+		strvec_push(&fetch_argv, argv[i]);
 
 	if (strcmp(fetch_argv.argv[fetch_argv.argc-1], "default") == 0) {
 		git_config(get_remote_default, &default_defined);
 		if (!default_defined) {
-			argv_array_pop(&fetch_argv);
-			argv_array_push(&fetch_argv, "--all");
+			strvec_pop(&fetch_argv);
+			strvec_push(&fetch_argv, "--all");
 		}
 	}
 
 	retval = run_command_v_opt(fetch_argv.argv, RUN_GIT_CMD);
-	argv_array_clear(&fetch_argv);
+	strvec_clear(&fetch_argv);
 	return retval;
 }
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 8bccb38a28..7435ee9af1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -153,28 +153,28 @@ struct pack_objects_args {
 static void prepare_pack_objects(struct child_process *cmd,
 				 const struct pack_objects_args *args)
 {
-	argv_array_push(&cmd->args, "pack-objects");
+	strvec_push(&cmd->args, "pack-objects");
 	if (args->window)
-		argv_array_pushf(&cmd->args, "--window=%s", args->window);
+		strvec_pushf(&cmd->args, "--window=%s", args->window);
 	if (args->window_memory)
-		argv_array_pushf(&cmd->args, "--window-memory=%s", args->window_memory);
+		strvec_pushf(&cmd->args, "--window-memory=%s", args->window_memory);
 	if (args->depth)
-		argv_array_pushf(&cmd->args, "--depth=%s", args->depth);
+		strvec_pushf(&cmd->args, "--depth=%s", args->depth);
 	if (args->threads)
-		argv_array_pushf(&cmd->args, "--threads=%s", args->threads);
+		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
 	if (args->max_pack_size)
-		argv_array_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
 	if (args->no_reuse_delta)
-		argv_array_pushf(&cmd->args, "--no-reuse-delta");
+		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
-		argv_array_pushf(&cmd->args, "--no-reuse-object");
+		strvec_pushf(&cmd->args, "--no-reuse-object");
 	if (args->local)
-		argv_array_push(&cmd->args,  "--local");
+		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
-		argv_array_push(&cmd->args,  "--quiet");
+		strvec_push(&cmd->args,  "--quiet");
 	if (delta_base_offset)
-		argv_array_push(&cmd->args,  "--delta-base-offset");
-	argv_array_push(&cmd->args, packtmp);
+		strvec_push(&cmd->args,  "--delta-base-offset");
+	strvec_push(&cmd->args, packtmp);
 	cmd->git_cmd = 1;
 	cmd->out = -1;
 }
@@ -361,24 +361,24 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	prepare_pack_objects(&cmd, &po_args);
 
-	argv_array_push(&cmd.args, "--keep-true-parents");
+	strvec_push(&cmd.args, "--keep-true-parents");
 	if (!pack_kept_objects)
-		argv_array_push(&cmd.args, "--honor-pack-keep");
+		strvec_push(&cmd.args, "--honor-pack-keep");
 	for (i = 0; i < keep_pack_list.nr; i++)
-		argv_array_pushf(&cmd.args, "--keep-pack=%s",
+		strvec_pushf(&cmd.args, "--keep-pack=%s",
 				 keep_pack_list.items[i].string);
-	argv_array_push(&cmd.args, "--non-empty");
-	argv_array_push(&cmd.args, "--all");
-	argv_array_push(&cmd.args, "--reflog");
-	argv_array_push(&cmd.args, "--indexed-objects");
+	strvec_push(&cmd.args, "--non-empty");
+	strvec_push(&cmd.args, "--all");
+	strvec_push(&cmd.args, "--reflog");
+	strvec_push(&cmd.args, "--indexed-objects");
 	if (has_promisor_remote())
-		argv_array_push(&cmd.args, "--exclude-promisor-objects");
+		strvec_push(&cmd.args, "--exclude-promisor-objects");
 	if (write_bitmaps > 0)
-		argv_array_push(&cmd.args, "--write-bitmap-index");
+		strvec_push(&cmd.args, "--write-bitmap-index");
 	else if (write_bitmaps < 0)
-		argv_array_push(&cmd.args, "--write-bitmap-index-quiet");
+		strvec_push(&cmd.args, "--write-bitmap-index-quiet");
 	if (use_delta_islands)
-		argv_array_push(&cmd.args, "--delta-islands");
+		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
@@ -387,23 +387,23 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 		if (existing_packs.nr && delete_redundant) {
 			if (unpack_unreachable) {
-				argv_array_pushf(&cmd.args,
+				strvec_pushf(&cmd.args,
 						"--unpack-unreachable=%s",
 						unpack_unreachable);
-				argv_array_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
+				strvec_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
 			} else if (pack_everything & LOOSEN_UNREACHABLE) {
-				argv_array_push(&cmd.args,
+				strvec_push(&cmd.args,
 						"--unpack-unreachable");
 			} else if (keep_unreachable) {
-				argv_array_push(&cmd.args, "--keep-unreachable");
-				argv_array_push(&cmd.args, "--pack-loose-unreachable");
+				strvec_push(&cmd.args, "--keep-unreachable");
+				strvec_push(&cmd.args, "--pack-loose-unreachable");
 			} else {
-				argv_array_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
+				strvec_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
 			}
 		}
 	} else {
-		argv_array_push(&cmd.args, "--unpacked");
-		argv_array_push(&cmd.args, "--incremental");
+		strvec_push(&cmd.args, "--unpacked");
+		strvec_push(&cmd.args, "--incremental");
 	}
 
 	cmd.no_stdin = 1;
diff --git a/builtin/replace.c b/builtin/replace.c
index b36d17a657..7bc5d66ed9 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -228,13 +228,13 @@ static int export_object(const struct object_id *oid, enum object_type type,
 	if (fd < 0)
 		return error_errno(_("unable to open %s for writing"), filename);
 
-	argv_array_push(&cmd.args, "--no-replace-objects");
-	argv_array_push(&cmd.args, "cat-file");
+	strvec_push(&cmd.args, "--no-replace-objects");
+	strvec_push(&cmd.args, "cat-file");
 	if (raw)
-		argv_array_push(&cmd.args, type_name(type));
+		strvec_push(&cmd.args, type_name(type));
 	else
-		argv_array_push(&cmd.args, "-p");
-	argv_array_push(&cmd.args, oid_to_hex(oid));
+		strvec_push(&cmd.args, "-p");
+	strvec_push(&cmd.args, oid_to_hex(oid));
 	cmd.git_cmd = 1;
 	cmd.out = fd;
 
@@ -502,7 +502,7 @@ static int convert_graft_file(int force)
 	const char *graft_file = get_graft_file(the_repository);
 	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT, err = STRBUF_INIT;
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 
 	if (!fp)
 		return -1;
@@ -512,10 +512,10 @@ static int convert_graft_file(int force)
 		if (*buf.buf == '#')
 			continue;
 
-		argv_array_split(&args, buf.buf);
+		strvec_split(&args, buf.buf);
 		if (args.argc && create_graft(args.argc, args.argv, force, 1))
 			strbuf_addf(&err, "\n\t%s", buf.buf);
-		argv_array_clear(&args);
+		strvec_clear(&args);
 	}
 	fclose(fp);
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f0a70538c3..4c918ce90d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -20,7 +20,7 @@ static const char* show_branch_usage[] = {
 
 static int showbranch_use_color = -1;
 
-static struct argv_array default_args = ARGV_ARRAY_INIT;
+static struct strvec default_args = STRVEC_INIT;
 
 /*
  * TODO: convert this use of commit->object.flags to commit-slab
@@ -562,8 +562,8 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 		 * mimic the real argv a bit better.
 		 */
 		if (!default_args.argc)
-			argv_array_push(&default_args, "show-branch");
-		argv_array_push(&default_args, value);
+			strvec_push(&default_args, "show-branch");
+		strvec_push(&default_args, value);
 		return 0;
 	}
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 1acf216254..05c086e54c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -277,8 +277,8 @@ static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
 	 * however it should be done together with apply_cached.
 	 */
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
-	argv_array_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
+	strvec_pushl(&cp.args, "diff-tree", "--binary", NULL);
+	strvec_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
 
 	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
 }
@@ -293,7 +293,7 @@ static int apply_cached(struct strbuf *out)
 	 * buffer.
 	 */
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "apply", "--cached", NULL);
+	strvec_pushl(&cp.args, "apply", "--cached", NULL);
 	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
 }
 
@@ -306,7 +306,7 @@ static int reset_head(void)
 	 * API for resetting.
 	 */
 	cp.git_cmd = 1;
-	argv_array_push(&cp.args, "reset");
+	strvec_push(&cp.args, "reset");
 
 	return run_command(&cp);
 }
@@ -335,9 +335,9 @@ static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
 	 * converted together with update_index.
 	 */
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only",
+	strvec_pushl(&cp.args, "diff-index", "--cached", "--name-only",
 			 "--diff-filter=A", NULL);
-	argv_array_push(&cp.args, c_tree_hex);
+	strvec_push(&cp.args, c_tree_hex);
 	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
 }
 
@@ -350,7 +350,7 @@ static int update_index(struct strbuf *out)
 	 * function exposed in order to remove this forking.
 	 */
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
+	strvec_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
 	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
 }
 
@@ -365,9 +365,9 @@ static int restore_untracked(struct object_id *u_tree)
 	 * run_command to fork processes that will not interfere.
 	 */
 	cp.git_cmd = 1;
-	argv_array_push(&cp.args, "read-tree");
-	argv_array_push(&cp.args, oid_to_hex(u_tree));
-	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
+	strvec_push(&cp.args, "read-tree");
+	strvec_push(&cp.args, oid_to_hex(u_tree));
+	strvec_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
 	if (run_command(&cp)) {
 		remove_path(stash_index_path.buf);
@@ -376,8 +376,8 @@ static int restore_untracked(struct object_id *u_tree)
 
 	child_process_init(&cp);
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "checkout-index", "--all", NULL);
-	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
+	strvec_pushl(&cp.args, "checkout-index", "--all", NULL);
+	strvec_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
 
 	res = run_command(&cp);
@@ -499,11 +499,11 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		 */
 		cp.git_cmd = 1;
 		cp.dir = prefix;
-		argv_array_pushf(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT"=%s",
+		strvec_pushf(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT"=%s",
 				 absolute_path(get_git_work_tree()));
-		argv_array_pushf(&cp.env_array, GIT_DIR_ENVIRONMENT"=%s",
+		strvec_pushf(&cp.env_array, GIT_DIR_ENVIRONMENT"=%s",
 				 absolute_path(get_git_dir()));
-		argv_array_push(&cp.args, "status");
+		strvec_push(&cp.args, "status");
 		run_command(&cp);
 	}
 
@@ -546,9 +546,9 @@ static int do_drop_stash(struct stash_info *info, int quiet)
 	 */
 
 	cp_reflog.git_cmd = 1;
-	argv_array_pushl(&cp_reflog.args, "reflog", "delete", "--updateref",
+	strvec_pushl(&cp_reflog.args, "reflog", "delete", "--updateref",
 			 "--rewrite", NULL);
-	argv_array_push(&cp_reflog.args, info->revision.buf);
+	strvec_push(&cp_reflog.args, info->revision.buf);
 	ret = run_command(&cp_reflog);
 	if (!ret) {
 		if (!quiet)
@@ -566,8 +566,8 @@ static int do_drop_stash(struct stash_info *info, int quiet)
 	cp.git_cmd = 1;
 	/* Even though --quiet is specified, rev-parse still outputs the hash */
 	cp.no_stdout = 1;
-	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
-	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
+	strvec_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
+	strvec_pushf(&cp.args, "%s@{0}", ref_stash);
 	ret = run_command(&cp);
 
 	/* do_clear_stash if we just dropped the last stash entry */
@@ -663,9 +663,9 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 		return -1;
 
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "checkout", "-b", NULL);
-	argv_array_push(&cp.args, branch);
-	argv_array_push(&cp.args, oid_to_hex(&info.b_commit));
+	strvec_pushl(&cp.args, "checkout", "-b", NULL);
+	strvec_push(&cp.args, branch);
+	strvec_push(&cp.args, oid_to_hex(&info.b_commit));
 	ret = run_command(&cp);
 	if (!ret)
 		ret = do_apply_stash(prefix, &info, 1, 0);
@@ -692,11 +692,11 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 		return 0;
 
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "log", "--format=%gd: %gs", "-g",
+	strvec_pushl(&cp.args, "log", "--format=%gd: %gs", "-g",
 			 "--first-parent", "-m", NULL);
-	argv_array_pushv(&cp.args, argv);
-	argv_array_push(&cp.args, ref_stash);
-	argv_array_push(&cp.args, "--");
+	strvec_pushv(&cp.args, argv);
+	strvec_push(&cp.args, ref_stash);
+	strvec_push(&cp.args, "--");
 	return run_command(&cp);
 }
 
@@ -727,8 +727,8 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	int ret = 0;
 	struct stash_info info;
 	struct rev_info rev;
-	struct argv_array stash_args = ARGV_ARRAY_INIT;
-	struct argv_array revision_args = ARGV_ARRAY_INIT;
+	struct strvec stash_args = STRVEC_INIT;
+	struct strvec revision_args = STRVEC_INIT;
 	struct option options[] = {
 		OPT_END()
 	};
@@ -737,16 +737,16 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config, NULL);
 	init_revisions(&rev, prefix);
 
-	argv_array_push(&revision_args, argv[0]);
+	strvec_push(&revision_args, argv[0]);
 	for (i = 1; i < argc; i++) {
 		if (argv[i][0] != '-')
-			argv_array_push(&stash_args, argv[i]);
+			strvec_push(&stash_args, argv[i]);
 		else
-			argv_array_push(&revision_args, argv[i]);
+			strvec_push(&revision_args, argv[i]);
 	}
 
 	ret = get_stash_info(&info, stash_args.argc, stash_args.argv);
-	argv_array_clear(&stash_args);
+	strvec_clear(&stash_args);
 	if (ret)
 		return -1;
 
@@ -842,12 +842,12 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 	return do_store_stash(&obj, stash_msg, quiet);
 }
 
-static void add_pathspecs(struct argv_array *args,
+static void add_pathspecs(struct strvec *args,
 			  const struct pathspec *ps) {
 	int i;
 
 	for (i = 0; i < ps->nr; i++)
-		argv_array_push(args, ps->items[i].original);
+		strvec_push(args, ps->items[i].original);
 }
 
 /*
@@ -960,9 +960,9 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	struct index_state istate = { NULL };
 
 	cp_upd_index.git_cmd = 1;
-	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
+	strvec_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
 			 "--remove", "--stdin", NULL);
-	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
+	strvec_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
 
 	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
@@ -1003,8 +1003,8 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	remove_path(stash_index_path.buf);
 
 	cp_read_tree.git_cmd = 1;
-	argv_array_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
-	argv_array_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
+	strvec_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
+	strvec_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
 	if (run_command(&cp_read_tree)) {
 		ret = -1;
@@ -1034,7 +1034,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	}
 
 	cp_diff_tree.git_cmd = 1;
-	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
+	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
 			 oid_to_hex(&info->w_tree), "--", NULL);
 	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
 		ret = -1;
@@ -1088,10 +1088,10 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	}
 
 	cp_upd_index.git_cmd = 1;
-	argv_array_pushl(&cp_upd_index.args, "update-index",
+	strvec_pushl(&cp_upd_index.args, "update-index",
 			 "--ignore-skip-worktree-entries",
 			 "-z", "--add", "--remove", "--stdin", NULL);
-	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
+	strvec_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
 
 	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
@@ -1342,10 +1342,10 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
-			argv_array_pushl(&cp.args, "clean", "--force",
+			strvec_pushl(&cp.args, "clean", "--force",
 					 "--quiet", "-d", NULL);
 			if (include_untracked == INCLUDE_ALL_FILES)
-				argv_array_push(&cp.args, "-x");
+				strvec_push(&cp.args, "-x");
 			if (run_command(&cp)) {
 				ret = -1;
 				goto done;
@@ -1359,20 +1359,20 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct strbuf out = STRBUF_INIT;
 
 			cp_add.git_cmd = 1;
-			argv_array_push(&cp_add.args, "add");
+			strvec_push(&cp_add.args, "add");
 			if (!include_untracked)
-				argv_array_push(&cp_add.args, "-u");
+				strvec_push(&cp_add.args, "-u");
 			if (include_untracked == INCLUDE_ALL_FILES)
-				argv_array_push(&cp_add.args, "--force");
-			argv_array_push(&cp_add.args, "--");
+				strvec_push(&cp_add.args, "--force");
+			strvec_push(&cp_add.args, "--");
 			add_pathspecs(&cp_add.args, ps);
 			if (run_command(&cp_add)) {
 				ret = -1;
 				goto done;
 			}
 
 			cp_diff.git_cmd = 1;
-			argv_array_pushl(&cp_diff.args, "diff-index", "-p",
+			strvec_pushl(&cp_diff.args, "diff-index", "-p",
 					 "--cached", "--binary", "HEAD", "--",
 					 NULL);
 			add_pathspecs(&cp_diff.args, ps);
@@ -1382,7 +1382,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			}
 
 			cp_apply.git_cmd = 1;
-			argv_array_pushl(&cp_apply.args, "apply", "--index",
+			strvec_pushl(&cp_apply.args, "apply", "--index",
 					 "-R", NULL);
 			if (pipe_command(&cp_apply, out.buf, out.len, NULL, 0,
 					 NULL, 0)) {
@@ -1392,7 +1392,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		} else {
 			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.git_cmd = 1;
-			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
+			strvec_pushl(&cp.args, "reset", "--hard", "-q",
 					 "--no-recurse-submodules", NULL);
 			if (run_command(&cp)) {
 				ret = -1;
@@ -1404,10 +1404,10 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
-			argv_array_pushl(&cp.args, "checkout", "--no-overlay",
+			strvec_pushl(&cp.args, "checkout", "--no-overlay",
 					 oid_to_hex(&info.i_tree), "--", NULL);
 			if (!ps->nr)
-				argv_array_push(&cp.args, ":/");
+				strvec_push(&cp.args, ":/");
 			else
 				add_pathspecs(&cp.args, ps);
 			if (run_command(&cp)) {
@@ -1420,7 +1420,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		struct child_process cp = CHILD_PROCESS_INIT;
 
 		cp.git_cmd = 1;
-		argv_array_pushl(&cp.args, "apply", "-R", NULL);
+		strvec_pushl(&cp.args, "apply", "-R", NULL);
 
 		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
 			if (!quiet)
@@ -1434,7 +1434,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
-			argv_array_pushl(&cp.args, "reset", "-q", "--", NULL);
+			strvec_pushl(&cp.args, "reset", "-q", "--", NULL);
 			add_pathspecs(&cp.args, ps);
 			if (run_command(&cp)) {
 				ret = -1;
@@ -1560,7 +1560,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
 	const char *index_file;
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 
 	struct option options[] = {
 		OPT_END()
@@ -1609,7 +1609,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 			      git_stash_usage, options);
 
 	/* Assume 'stash push' */
-	argv_array_push(&args, "push");
-	argv_array_pushv(&args, argv);
+	strvec_push(&args, "push");
+	strvec_pushv(&args, argv);
 	return !!push_stash(args.argc, args.argv, prefix, 1);
 }
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a1c75607c7..7705e8eabf 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -294,9 +294,9 @@ static char *compute_rev_name(const char *sub_path, const char* object_id)
 		cp.git_cmd = 1;
 		cp.no_stderr = 1;
 
-		argv_array_push(&cp.args, "describe");
-		argv_array_pushv(&cp.args, *d);
-		argv_array_push(&cp.args, object_id);
+		strvec_push(&cp.args, "describe");
+		strvec_pushv(&cp.args, *d);
+		strvec_push(&cp.args, object_id);
 
 		if (!capture_command(&cp, &sb, 0)) {
 			strbuf_strip_suffix(&sb, "\n");
@@ -495,12 +495,12 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		char *toplevel = xgetcwd();
 		struct strbuf sb = STRBUF_INIT;
 
-		argv_array_pushf(&cp.env_array, "name=%s", sub->name);
-		argv_array_pushf(&cp.env_array, "sm_path=%s", path);
-		argv_array_pushf(&cp.env_array, "displaypath=%s", displaypath);
-		argv_array_pushf(&cp.env_array, "sha1=%s",
+		strvec_pushf(&cp.env_array, "name=%s", sub->name);
+		strvec_pushf(&cp.env_array, "sm_path=%s", path);
+		strvec_pushf(&cp.env_array, "displaypath=%s", displaypath);
+		strvec_pushf(&cp.env_array, "sha1=%s",
 				oid_to_hex(ce_oid));
-		argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
+		strvec_pushf(&cp.env_array, "toplevel=%s", toplevel);
 
 		/*
 		 * Since the path variable was accessible from the script
@@ -509,15 +509,15 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		 * on windows. And since environment variables are
 		 * case-insensitive in windows, it interferes with the
 		 * existing PATH variable. Hence, to avoid that, we expose
-		 * path via the args argv_array and not via env_array.
+		 * path via the args strvec and not via env_array.
 		 */
 		sq_quote_buf(&sb, path);
-		argv_array_pushf(&cp.args, "path=%s; %s",
+		strvec_pushf(&cp.args, "path=%s; %s",
 				 sb.buf, info->argv[0]);
 		strbuf_release(&sb);
 		free(toplevel);
 	} else {
-		argv_array_pushv(&cp.args, info->argv);
+		strvec_pushv(&cp.args, info->argv);
 	}
 
 	if (!info->quiet)
@@ -534,16 +534,16 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env_array);
 
-		argv_array_pushl(&cpr.args, "--super-prefix", NULL);
-		argv_array_pushf(&cpr.args, "%s/", displaypath);
-		argv_array_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
+		strvec_pushl(&cpr.args, "--super-prefix", NULL);
+		strvec_pushf(&cpr.args, "%s/", displaypath);
+		strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
 				NULL);
 
 		if (info->quiet)
-			argv_array_push(&cpr.args, "--quiet");
+			strvec_push(&cpr.args, "--quiet");
 
-		argv_array_push(&cpr.args, "--");
-		argv_array_pushv(&cpr.args, info->argv);
+		strvec_push(&cpr.args, "--");
+		strvec_pushv(&cpr.args, info->argv);
 
 		if (run_command(&cpr))
 			die(_("run_command returned non-zero status while "
@@ -779,7 +779,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			     unsigned int flags)
 {
 	char *displaypath;
-	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
+	struct strvec diff_files_args = STRVEC_INIT;
 	struct rev_info rev;
 	int diff_files_result;
 	struct strbuf buf = STRBUF_INIT;
@@ -809,7 +809,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	}
 	strbuf_release(&buf);
 
-	argv_array_pushl(&diff_files_args, "diff-files",
+	strvec_pushl(&diff_files_args, "diff-files",
 			 "--ignore-submodules=dirty", "--quiet", "--",
 			 path, NULL);
 
@@ -849,23 +849,23 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env_array);
 
-		argv_array_push(&cpr.args, "--super-prefix");
-		argv_array_pushf(&cpr.args, "%s/", displaypath);
-		argv_array_pushl(&cpr.args, "submodule--helper", "status",
+		strvec_push(&cpr.args, "--super-prefix");
+		strvec_pushf(&cpr.args, "%s/", displaypath);
+		strvec_pushl(&cpr.args, "submodule--helper", "status",
 				 "--recursive", NULL);
 
 		if (flags & OPT_CACHED)
-			argv_array_push(&cpr.args, "--cached");
+			strvec_push(&cpr.args, "--cached");
 
 		if (flags & OPT_QUIET)
-			argv_array_push(&cpr.args, "--quiet");
+			strvec_push(&cpr.args, "--quiet");
 
 		if (run_command(&cpr))
 			die(_("failed to recurse into submodule '%s'"), path);
 	}
 
 cleanup:
-	argv_array_clear(&diff_files_args);
+	strvec_clear(&diff_files_args);
 	free(displaypath);
 }
 
@@ -995,7 +995,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.dir = path;
-	argv_array_pushl(&cp.args, "submodule--helper",
+	strvec_pushl(&cp.args, "submodule--helper",
 			 "print-default-remote", NULL);
 
 	strbuf_reset(&sb);
@@ -1021,13 +1021,13 @@ static void sync_submodule(const char *path, const char *prefix,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env_array);
 
-		argv_array_push(&cpr.args, "--super-prefix");
-		argv_array_pushf(&cpr.args, "%s/", displaypath);
-		argv_array_pushl(&cpr.args, "submodule--helper", "sync",
+		strvec_push(&cpr.args, "--super-prefix");
+		strvec_pushf(&cpr.args, "%s/", displaypath);
+		strvec_pushl(&cpr.args, "submodule--helper", "sync",
 				 "--recursive", NULL);
 
 		if (flags & OPT_QUIET)
-			argv_array_push(&cpr.args, "--quiet");
+			strvec_push(&cpr.args, "--quiet");
 
 		if (run_command(&cpr))
 			die(_("failed to recurse into submodule '%s'"),
@@ -1127,7 +1127,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 		if (!(flags & OPT_FORCE)) {
 			struct child_process cp_rm = CHILD_PROCESS_INIT;
 			cp_rm.git_cmd = 1;
-			argv_array_pushl(&cp_rm.args, "rm", "-qn",
+			strvec_pushl(&cp_rm.args, "rm", "-qn",
 					 path, NULL);
 
 			if (run_command(&cp_rm))
@@ -1156,8 +1156,8 @@ static void deinit_submodule(const char *path, const char *prefix,
 		      displaypath);
 
 	cp_config.git_cmd = 1;
-	argv_array_pushl(&cp_config.args, "config", "--get-regexp", NULL);
-	argv_array_pushf(&cp_config.args, "submodule.%s\\.", sub->name);
+	strvec_pushl(&cp_config.args, "config", "--get-regexp", NULL);
+	strvec_pushf(&cp_config.args, "submodule.%s\\.", sub->name);
 
 	/* remove the .git/config entries (unless the user already did it) */
 	if (!capture_command(&cp_config, &sb_config, 0) && sb_config.len) {
@@ -1239,32 +1239,32 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
-	argv_array_push(&cp.args, "clone");
-	argv_array_push(&cp.args, "--no-checkout");
+	strvec_push(&cp.args, "clone");
+	strvec_push(&cp.args, "--no-checkout");
 	if (quiet)
-		argv_array_push(&cp.args, "--quiet");
+		strvec_push(&cp.args, "--quiet");
 	if (progress)
-		argv_array_push(&cp.args, "--progress");
+		strvec_push(&cp.args, "--progress");
 	if (depth && *depth)
-		argv_array_pushl(&cp.args, "--depth", depth, NULL);
+		strvec_pushl(&cp.args, "--depth", depth, NULL);
 	if (reference->nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, reference)
-			argv_array_pushl(&cp.args, "--reference",
+			strvec_pushl(&cp.args, "--reference",
 					 item->string, NULL);
 	}
 	if (dissociate)
-		argv_array_push(&cp.args, "--dissociate");
+		strvec_push(&cp.args, "--dissociate");
 	if (gitdir && *gitdir)
-		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
+		strvec_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
 	if (single_branch >= 0)
-		argv_array_push(&cp.args, single_branch ?
+		strvec_push(&cp.args, single_branch ?
 					  "--single-branch" :
 					  "--no-single-branch");
 
-	argv_array_push(&cp.args, "--");
-	argv_array_push(&cp.args, url);
-	argv_array_push(&cp.args, path);
+	strvec_push(&cp.args, "--");
+	strvec_push(&cp.args, url);
+	strvec_push(&cp.args, path);
 
 	cp.git_cmd = 1;
 	prepare_submodule_repo_env(&cp.env_array);
@@ -1717,32 +1717,32 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	child->no_stdin = 1;
 	child->stdout_to_stderr = 1;
 	child->err = -1;
-	argv_array_push(&child->args, "submodule--helper");
-	argv_array_push(&child->args, "clone");
+	strvec_push(&child->args, "submodule--helper");
+	strvec_push(&child->args, "clone");
 	if (suc->progress)
-		argv_array_push(&child->args, "--progress");
+		strvec_push(&child->args, "--progress");
 	if (suc->quiet)
-		argv_array_push(&child->args, "--quiet");
+		strvec_push(&child->args, "--quiet");
 	if (suc->prefix)
-		argv_array_pushl(&child->args, "--prefix", suc->prefix, NULL);
+		strvec_pushl(&child->args, "--prefix", suc->prefix, NULL);
 	if (suc->recommend_shallow && sub->recommend_shallow == 1)
-		argv_array_push(&child->args, "--depth=1");
+		strvec_push(&child->args, "--depth=1");
 	if (suc->require_init)
-		argv_array_push(&child->args, "--require-init");
-	argv_array_pushl(&child->args, "--path", sub->path, NULL);
-	argv_array_pushl(&child->args, "--name", sub->name, NULL);
-	argv_array_pushl(&child->args, "--url", url, NULL);
+		strvec_push(&child->args, "--require-init");
+	strvec_pushl(&child->args, "--path", sub->path, NULL);
+	strvec_pushl(&child->args, "--name", sub->name, NULL);
+	strvec_pushl(&child->args, "--url", url, NULL);
 	if (suc->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &suc->references)
-			argv_array_pushl(&child->args, "--reference", item->string, NULL);
+			strvec_pushl(&child->args, "--reference", item->string, NULL);
 	}
 	if (suc->dissociate)
-		argv_array_push(&child->args, "--dissociate");
+		strvec_push(&child->args, "--dissociate");
 	if (suc->depth)
-		argv_array_push(&child->args, suc->depth);
+		strvec_push(&child->args, suc->depth);
 	if (suc->single_branch >= 0)
-		argv_array_push(&child->args, suc->single_branch ?
+		strvec_push(&child->args, suc->single_branch ?
 					      "--single-branch" :
 					      "--no-single-branch");
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 7fc8e0e82d..f02bb0ea15 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -19,7 +19,7 @@ static const char deadchild[] =
 
 int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 {
-	struct argv_array sent_argv = ARGV_ARRAY_INIT;
+	struct strvec sent_argv = STRVEC_INIT;
 	const char *arg_cmd = "argument ";
 
 	if (argc != 2 || !strcmp(argv[1], "-h"))
@@ -31,7 +31,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	init_archivers();
 
 	/* put received options in sent_argv[] */
-	argv_array_push(&sent_argv, "git-upload-archive");
+	strvec_push(&sent_argv, "git-upload-archive");
 	for (;;) {
 		char *buf = packet_read_line(0, NULL);
 		if (!buf)
@@ -41,7 +41,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 
 		if (!starts_with(buf, arg_cmd))
 			die("'argument' token or flush expected");
-		argv_array_push(&sent_argv, buf + strlen(arg_cmd));
+		strvec_push(&sent_argv, buf + strlen(arg_cmd));
 	}
 
 	/* parse all options sent by the client */
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 35945096f6..3c483c23d4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -316,7 +316,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf sb = STRBUF_INIT, realpath = STRBUF_INIT;
 	const char *name;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	struct argv_array child_env = ARGV_ARRAY_INIT;
+	struct strvec child_env = STRVEC_INIT;
 	unsigned int counter = 0;
 	int len, ret;
 	struct strbuf symref = STRBUF_INIT;
@@ -408,18 +408,18 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
-	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
-	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
+	strvec_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
+	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd = 1;
 
 	if (!is_branch)
-		argv_array_pushl(&cp.args, "update-ref", "HEAD",
+		strvec_pushl(&cp.args, "update-ref", "HEAD",
 				 oid_to_hex(&commit->object.oid), NULL);
 	else {
-		argv_array_pushl(&cp.args, "symbolic-ref", "HEAD",
+		strvec_pushl(&cp.args, "symbolic-ref", "HEAD",
 				 symref.buf, NULL);
 		if (opts->quiet)
-			argv_array_push(&cp.args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 	}
 
 	cp.env = child_env.argv;
@@ -429,10 +429,10 @@ static int add_worktree(const char *path, const char *refname,
 
 	if (opts->checkout) {
 		cp.argv = NULL;
-		argv_array_clear(&cp.args);
-		argv_array_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
+		strvec_clear(&cp.args);
+		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
-			argv_array_push(&cp.args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		cp.env = child_env.argv;
 		ret = run_command(&cp);
 		if (ret)
@@ -465,15 +465,15 @@ static int add_worktree(const char *path, const char *refname,
 			cp.env = env;
 			cp.argv = NULL;
 			cp.trace2_hook_name = "post-checkout";
-			argv_array_pushl(&cp.args, absolute_path(hook),
+			strvec_pushl(&cp.args, absolute_path(hook),
 					 oid_to_hex(&null_oid),
 					 oid_to_hex(&commit->object.oid),
 					 "1", NULL);
 			ret = run_command(&cp);
 		}
 	}
 
-	argv_array_clear(&child_env);
+	strvec_clear(&child_env);
 	strbuf_release(&sb);
 	strbuf_release(&symref);
 	strbuf_release(&sb_repo);
@@ -619,15 +619,15 @@ static int add(int ac, const char **av, const char *prefix)
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
-		argv_array_push(&cp.args, "branch");
+		strvec_push(&cp.args, "branch");
 		if (new_branch_force)
-			argv_array_push(&cp.args, "--force");
+			strvec_push(&cp.args, "--force");
 		if (opts.quiet)
-			argv_array_push(&cp.args, "--quiet");
-		argv_array_push(&cp.args, new_branch);
-		argv_array_push(&cp.args, branch);
+			strvec_push(&cp.args, "--quiet");
+		strvec_push(&cp.args, new_branch);
+		strvec_push(&cp.args, branch);
 		if (opt_track)
-			argv_array_push(&cp.args, opt_track);
+			strvec_push(&cp.args, opt_track);
 		if (run_command(&cp))
 			return -1;
 		branch = new_branch;
@@ -924,7 +924,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 static void check_clean_worktree(struct worktree *wt,
 				 const char *original_path)
 {
-	struct argv_array child_env = ARGV_ARRAY_INIT;
+	struct strvec child_env = STRVEC_INIT;
 	struct child_process cp;
 	char buf[1];
 	int ret;
@@ -935,12 +935,12 @@ static void check_clean_worktree(struct worktree *wt,
 	 */
 	validate_no_submodules(wt);
 
-	argv_array_pushf(&child_env, "%s=%s/.git",
+	strvec_pushf(&child_env, "%s=%s/.git",
 			 GIT_DIR_ENVIRONMENT, wt->path);
-	argv_array_pushf(&child_env, "%s=%s",
+	strvec_pushf(&child_env, "%s=%s",
 			 GIT_WORK_TREE_ENVIRONMENT, wt->path);
 	memset(&cp, 0, sizeof(cp));
-	argv_array_pushl(&cp.args, "status",
+	strvec_pushl(&cp.args, "status",
 			 "--porcelain", "--ignore-submodules=none",
 			 NULL);
 	cp.env = child_env.argv;
-- 
2.28.0.rc2.475.g53c7e1c7f4

