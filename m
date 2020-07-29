Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2ECC433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE09920A8B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgG2AkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:40:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:40800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730507AbgG2AkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 20:40:14 -0400
Received: (qmail 32060 invoked by uid 109); 29 Jul 2020 00:40:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 00:40:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31829 invoked by uid 111); 29 Jul 2020 00:40:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 20:40:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 20:40:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/11] strvec: drop argv_array compatibility layer
Message-ID: <20200729004009.GB1653374@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <20200728202709.GJ1021513@coredump.intra.peff.net>
 <xmqq5za7cm8e.fsf@gitster.c.googlers.com>
 <20200729000430.GA1623001@coredump.intra.peff.net>
 <20200729003720.GA1653374@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729003720.GA1653374@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 08:37:21PM -0400, Jeff King wrote:

> > If I swap out the final patch with "s/items/v/" that may cause a
> > _little_ more trouble, but perhaps not quite as much (only some of the
> > sites access the fields directly).
> 
> Here's the "v" version, which can replace the top patch. I'll follow-up
> with some notes on merging to "seen".

And here's a diff between your current "seen" tip and what I get by
merging in this updated version and then doing any necessary resolution
or fixups on top. I'll leave it as an exercise for how you might want to
pull the content across. :)

I do note that most of the new call-sites are ones that would be better
off using child_process.args, and reviewers (myself and others) have
suggested that. So those direct uses of the "argv" member may go away
anyway.

---
diff --git a/add-interactive.c b/add-interactive.c
index 659289905c..555c4abf32 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -944,7 +944,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 					    files->items.items[i].string);
 		parse_pathspec(&ps_selected,
 			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
-			       PATHSPEC_LITERAL_PATH, "", args.items);
+			       PATHSPEC_LITERAL_PATH, "", args.v);
 		res = run_add_p(s->r, ADD_P_ADD, NULL, &ps_selected);
 		strvec_clear(&args);
 		clear_pathspec(&ps_selected);
@@ -986,7 +986,7 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 			if (files->selected[i])
 				strvec_push(&args,
 					    files->items.items[i].string);
-		res = run_command_v_opt(args.items, 0);
+		res = run_command_v_opt(args.v, 0);
 		strvec_clear(&args);
 	}
 
diff --git a/add-patch.c b/add-patch.c
index df170d29ef..0f68eb665e 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -398,7 +398,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		strvec_push(&args, ps->items[i].original);
 
 	setup_child_process(s, &cp, NULL);
-	cp.argv = args.items;
+	cp.argv = args.v;
 	res = capture_command(&cp, plain, 0);
 	if (res) {
 		strvec_clear(&args);
@@ -415,8 +415,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		const char *diff_filter = s->s.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
-		xsnprintf((char *)args.items[color_arg_index], 8, "--color");
-		colored_cp.argv = args.items;
+		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
+		colored_cp.argv = args.v;
 		colored = &s->colored;
 		res = capture_command(&colored_cp, colored, 0);
 		strvec_clear(&args);
diff --git a/bisect.c b/bisect.c
index 9ca3c5c52e..5c7710034a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -649,7 +649,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	if (read_paths)
 		read_bisect_paths(&rev_argv);
 
-	setup_revisions(rev_argv.nr, rev_argv.items, revs, NULL);
+	setup_revisions(rev_argv.nr, rev_argv.v, revs, NULL);
 	/* XXX leak rev_argv, as "revs" may still be pointing to it */
 }
 
diff --git a/builtin/add.c b/builtin/add.c
index eb6457da05..ab39a60a0d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -228,7 +228,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 		/* pass original pathspec, to be re-parsed */
 		strvec_push(&argv, pathspec->items[i].original);
 
-	status = run_command_v_opt(argv.items, RUN_GIT_CMD);
+	status = run_command_v_opt(argv.v, RUN_GIT_CMD);
 	strvec_clear(&argv);
 	return status;
 }
diff --git a/builtin/am.c b/builtin/am.c
index 2ca363f72e..68e9d17379 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -812,7 +812,7 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 	strbuf_release(&sb);
 	free(series_dir_buf);
 
-	ret = split_mail_conv(stgit_patch_to_mail, state, patches.items, keep_cr);
+	ret = split_mail_conv(stgit_patch_to_mail, state, patches.v, keep_cr);
 
 	strvec_clear(&patches);
 	return ret;
@@ -1002,7 +1002,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	}
 	write_state_text(state, "scissors", str);
 
-	sq_quote_argv(&sb, state->git_apply_opts.items);
+	sq_quote_argv(&sb, state->git_apply_opts.v);
 	write_state_text(state, "apply-opt", sb.buf);
 
 	if (state->rebasing)
@@ -1401,9 +1401,9 @@ static int run_apply(const struct am_state *state, const char *index_file)
 		BUG("init_apply_state() failed");
 
 	strvec_push(&apply_opts, "apply");
-	strvec_pushv(&apply_opts, state->git_apply_opts.items);
+	strvec_pushv(&apply_opts, state->git_apply_opts.v);
 
-	opts_left = apply_parse_options(apply_opts.nr, apply_opts.items,
+	opts_left = apply_parse_options(apply_opts.nr, apply_opts.v,
 					&apply_state, &force_apply, &options,
 					NULL);
 
@@ -1428,7 +1428,7 @@ static int run_apply(const struct am_state *state, const char *index_file)
 
 	strvec_push(&apply_paths, am_path(state, "patch"));
 
-	res = apply_all_patches(&apply_state, apply_paths.nr, apply_paths.items, options);
+	res = apply_all_patches(&apply_state, apply_paths.nr, apply_paths.v, options);
 
 	strvec_clear(&apply_paths);
 	strvec_clear(&apply_opts);
@@ -1455,7 +1455,7 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 
 	cp.git_cmd = 1;
 	strvec_push(&cp.args, "apply");
-	strvec_pushv(&cp.args, state->git_apply_opts.items);
+	strvec_pushv(&cp.args, state->git_apply_opts.v);
 	strvec_pushf(&cp.args, "--build-fake-ancestor=%s", index_file);
 	strvec_push(&cp.args, am_path(state, "patch"));
 
@@ -2379,7 +2379,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		if (state.interactive && !paths.nr)
 			die(_("interactive mode requires patches on the command line"));
 
-		am_setup(&state, patch_format, paths.items, keep_cr);
+		am_setup(&state, patch_format, paths.v, keep_cr);
 
 		strvec_clear(&paths);
 	}
diff --git a/builtin/annotate.c b/builtin/annotate.c
index b9ab710740..58ff977a23 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -18,5 +18,5 @@ int cmd_annotate(int argc, const char **argv, const char *prefix)
 		strvec_push(&args, argv[i]);
 	}
 
-	return cmd_blame(args.nr, args.items, prefix);
+	return cmd_blame(args.nr, args.v, prefix);
 }
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 272c303ee4..0ba43f71ff 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -204,7 +204,7 @@ static int bisect_reset(const char *commit)
 		struct strvec argv = STRVEC_INIT;
 
 		strvec_pushl(&argv, "checkout", branch.buf, "--", NULL);
-		if (run_command_v_opt(argv.items, RUN_GIT_CMD)) {
+		if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
 			error(_("could not check out original"
 				" HEAD '%s'. Try 'git bisect"
 				" reset <commit>'."), branch.buf);
@@ -707,7 +707,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int no_checkou
 
 			strvec_pushl(&argv, "checkout", start_head.buf,
 				     "--", NULL);
-			if (run_command_v_opt(argv.items, RUN_GIT_CMD)) {
+			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
 				res = error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
 						 "<valid-branch>'."),
diff --git a/builtin/clone.c b/builtin/clone.c
index 0bd57a9124..b087ee40c2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -752,7 +752,7 @@ static int git_sparse_checkout_init(const char *repo)
 	 */
 	core_apply_sparse_checkout = 1;
 
-	if (run_command_v_opt(argv.items, RUN_GIT_CMD)) {
+	if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
 		error(_("failed to initialize sparse-checkout"));
 		result = 1;
 	}
@@ -844,7 +844,7 @@ static int checkout(int submodule_progress)
 					       "--single-branch" :
 					       "--no-single-branch");
 
-		err = run_command_v_opt(args.items, RUN_GIT_CMD);
+		err = run_command_v_opt(args.v, RUN_GIT_CMD);
 		strvec_clear(&args);
 	}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 9705bfb0cf..f9b0a0c05d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1008,7 +1008,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct strvec env = STRVEC_INIT;
 
 		strvec_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
-		if (launch_editor(git_path_commit_editmsg(), NULL, env.items)) {
+		if (launch_editor(git_path_commit_editmsg(), NULL, env.v)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
diff --git a/builtin/describe.c b/builtin/describe.c
index 85c1504065..7668591d57 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -509,7 +509,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 		     NULL);
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	if (setup_revisions(args.nr, args.items, &revs, NULL) > 1)
+	if (setup_revisions(args.nr, args.v, &revs, NULL) > 1)
 		BUG("setup_revisions could not handle all args?");
 
 	if (prepare_revision_walk(&revs))
@@ -613,7 +613,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			strvec_pushv(&args, argv);
 		else
 			strvec_push(&args, "HEAD");
-		return cmd_name_rev(args.nr, args.items, prefix);
+		return cmd_name_rev(args.nr, args.v, prefix);
 	}
 
 	hashmap_init(&names, commit_name_neq, NULL, 0);
@@ -659,7 +659,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 			repo_init_revisions(the_repository, &revs, prefix);
 			strvec_pushv(&args, diff_index_args);
-			if (setup_revisions(args.nr, args.items, &revs, NULL) != 1)
+			if (setup_revisions(args.nr, args.v, &revs, NULL) != 1)
 				BUG("malformed internal diff-index command line");
 			result = run_diff_index(&revs, 0);
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 78ea697325..7ac432b881 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -683,7 +683,7 @@ static int run_file_diff(int prompt, const char *prefix,
 	strvec_push(&args, "diff");
 	for (i = 0; i < argc; i++)
 		strvec_push(&args, argv[i]);
-	ret = run_command_v_opt_cd_env(args.items, RUN_GIT_CMD, prefix, env);
+	ret = run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
 	exit(ret);
 }
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4c6d7c4428..ee52ae734e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1616,7 +1616,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 	add_options_to_argv(&argv);
 
 	if (max_children != 1 && list->nr != 1) {
-		struct parallel_fetch_state state = { argv.items, list, 0, 0 };
+		struct parallel_fetch_state state = { argv.v, list, 0, 0 };
 
 		strvec_push(&argv, "--end-of-options");
 		result = run_processes_parallel_tr2(max_children,
@@ -1634,7 +1634,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 			strvec_push(&argv, name);
 			if (verbosity >= 0)
 				printf(_("Fetching %s\n"), name);
-			if (run_command_v_opt(argv.items, RUN_GIT_CMD)) {
+			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
 				error(_("Could not fetch %s"), name);
 				result = 1;
 			}
diff --git a/builtin/gc.c b/builtin/gc.c
index c87505ba21..5cacf78bba 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -518,11 +518,11 @@ static void gc_before_repack(void)
 	if (done++)
 		return;
 
-	if (pack_refs && run_command_v_opt(pack_refs_cmd.items, RUN_GIT_CMD))
-		die(FAILED_RUN, pack_refs_cmd.items[0]);
+	if (pack_refs && run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD))
+		die(FAILED_RUN, pack_refs_cmd.v[0]);
 
-	if (prune_reflogs && run_command_v_opt(reflog.items, RUN_GIT_CMD))
-		die(FAILED_RUN, reflog.items[0]);
+	if (prune_reflogs && run_command_v_opt(reflog.v, RUN_GIT_CMD))
+		die(FAILED_RUN, reflog.v[0]);
 }
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
@@ -657,8 +657,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (!repository_format_precious_objects) {
 		close_object_store(the_repository->objects);
-		if (run_command_v_opt(repack.items, RUN_GIT_CMD))
-			die(FAILED_RUN, repack.items[0]);
+		if (run_command_v_opt(repack.v, RUN_GIT_CMD))
+			die(FAILED_RUN, repack.v[0]);
 
 		if (prune_expire) {
 			strvec_push(&prune, prune_expire);
@@ -667,19 +667,19 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			if (has_promisor_remote())
 				strvec_push(&prune,
 					    "--exclude-promisor-objects");
-			if (run_command_v_opt(prune.items, RUN_GIT_CMD))
-				die(FAILED_RUN, prune.items[0]);
+			if (run_command_v_opt(prune.v, RUN_GIT_CMD))
+				die(FAILED_RUN, prune.v[0]);
 		}
 	}
 
 	if (prune_worktrees_expire) {
 		strvec_push(&prune_worktrees, prune_worktrees_expire);
-		if (run_command_v_opt(prune_worktrees.items, RUN_GIT_CMD))
-			die(FAILED_RUN, prune_worktrees.items[0]);
+		if (run_command_v_opt(prune_worktrees.v, RUN_GIT_CMD))
+			die(FAILED_RUN, prune_worktrees.v[0]);
 	}
 
-	if (run_command_v_opt(rerere.items, RUN_GIT_CMD))
-		die(FAILED_RUN, rerere.items[0]);
+	if (run_command_v_opt(rerere.v, RUN_GIT_CMD))
+		die(FAILED_RUN, rerere.v[0]);
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);
@@ -802,7 +802,7 @@ static int run_write_commit_graph(void)
 	if (opts.quiet)
 		strvec_push(&cmd, "--no-progress");
 
-	result = run_command_v_opt(cmd.items, RUN_GIT_CMD);
+	result = run_command_v_opt(cmd.v, RUN_GIT_CMD);
 	strvec_clear(&cmd);
 
 	return result;
@@ -819,7 +819,7 @@ static int run_verify_commit_graph(void)
 	if (opts.quiet)
 		strvec_push(&cmd, "--no-progress");
 
-	result = run_command_v_opt(cmd.items, RUN_GIT_CMD);
+	result = run_command_v_opt(cmd.v, RUN_GIT_CMD);
 	strvec_clear(&cmd);
 
 	return result;
@@ -874,7 +874,7 @@ static int fetch_remote(const char *remote)
 	if (opts.quiet)
 		strvec_push(&cmd, "--quiet");
 
-	result = run_command_v_opt(cmd.items, RUN_GIT_CMD);
+	result = run_command_v_opt(cmd.v, RUN_GIT_CMD);
 
 	strbuf_release(&refmap);
 	return result;
@@ -929,7 +929,7 @@ static int maintenance_task_gc(void)
 		strvec_pushl(&cmd, "--quiet", NULL);
 
 	close_object_store(the_repository->objects);
-	result = run_command_v_opt(cmd.items, RUN_GIT_CMD);
+	result = run_command_v_opt(cmd.v, RUN_GIT_CMD);
 	strvec_clear(&cmd);
 
 	return result;
@@ -943,7 +943,7 @@ static int prune_packed(void)
 	if (opts.quiet)
 		strvec_push(&cmd, "--quiet");
 
-	return run_command_v_opt(cmd.items, RUN_GIT_CMD);
+	return run_command_v_opt(cmd.v, RUN_GIT_CMD);
 }
 
 struct write_loose_object_data {
@@ -1102,7 +1102,7 @@ static int multi_pack_index_write(void)
 	if (opts.quiet)
 		strvec_push(&cmd, "--no-progress");
 
-	result = run_command_v_opt(cmd.items, RUN_GIT_CMD);
+	result = run_command_v_opt(cmd.v, RUN_GIT_CMD);
 	strvec_clear(&cmd);
 
 	return result;
@@ -1133,7 +1133,7 @@ static int multi_pack_index_verify(void)
 	if (opts.quiet)
 		strvec_push(&cmd, "--no-progress");
 
-	result = run_command_v_opt(cmd.items, RUN_GIT_CMD);
+	result = run_command_v_opt(cmd.v, RUN_GIT_CMD);
 	strvec_clear(&cmd);
 
 	return result;
@@ -1149,7 +1149,7 @@ static int multi_pack_index_expire(void)
 		strvec_push(&cmd, "--no-progress");
 
 	close_object_store(the_repository->objects);
-	result = run_command_v_opt(cmd.items, RUN_GIT_CMD);
+	result = run_command_v_opt(cmd.v, RUN_GIT_CMD);
 	strvec_clear(&cmd);
 
 	return result;
@@ -1212,7 +1212,7 @@ static int multi_pack_index_repack(void)
 	strvec_push(&cmd, batch_arg.buf);
 
 	close_object_store(the_repository->objects);
-	result = run_command_v_opt(cmd.items, RUN_GIT_CMD);
+	result = run_command_v_opt(cmd.v, RUN_GIT_CMD);
 	strbuf_release(&batch_arg);
 
 	if (result && multi_pack_index_verify()) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0de05ee567..fac58865da 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3737,7 +3737,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
-		get_object_list(rp.nr, rp.items);
+		get_object_list(rp.nr, rp.v);
 		strvec_clear(&rp);
 	}
 	cleanup_preferred_base();
diff --git a/builtin/pull.c b/builtin/pull.c
index 4c66db1468..5ef3434e1f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -585,14 +585,14 @@ static int run_fetch(const char *repo, const char **refspecs)
 		strvec_push(&args, "--no-show-forced-updates");
 	if (set_upstream)
 		strvec_push(&args, set_upstream);
-	strvec_pushv(&args, opt_fetch.items);
+	strvec_pushv(&args, opt_fetch.v);
 
 	if (repo) {
 		strvec_push(&args, repo);
 		strvec_pushv(&args, refspecs);
 	} else if (*refspecs)
 		BUG("refspecs without repo?");
-	ret = run_command_v_opt(args.items, RUN_GIT_CMD);
+	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
 	strvec_clear(&args);
 	return ret;
 }
@@ -692,8 +692,8 @@ static int run_merge(void)
 		strvec_push(&args, opt_ff);
 	if (opt_verify_signatures)
 		strvec_push(&args, opt_verify_signatures);
-	strvec_pushv(&args, opt_strategies.items);
-	strvec_pushv(&args, opt_strategy_opts.items);
+	strvec_pushv(&args, opt_strategies.v);
+	strvec_pushv(&args, opt_strategy_opts.v);
 	if (opt_gpg_sign)
 		strvec_push(&args, opt_gpg_sign);
 	if (opt_autostash == 0)
@@ -704,7 +704,7 @@ static int run_merge(void)
 		strvec_push(&args, "--allow-unrelated-histories");
 
 	strvec_push(&args, "FETCH_HEAD");
-	ret = run_command_v_opt(args.items, RUN_GIT_CMD);
+	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
 	strvec_clear(&args);
 	return ret;
 }
@@ -883,8 +883,8 @@ static int run_rebase(const struct object_id *curr_head,
 		strvec_push(&args, "--interactive");
 	if (opt_diffstat)
 		strvec_push(&args, opt_diffstat);
-	strvec_pushv(&args, opt_strategies.items);
-	strvec_pushv(&args, opt_strategy_opts.items);
+	strvec_pushv(&args, opt_strategies.v);
+	strvec_pushv(&args, opt_strategy_opts.v);
 	if (opt_gpg_sign)
 		strvec_push(&args, opt_gpg_sign);
 	if (opt_autostash == 0)
@@ -903,7 +903,7 @@ static int run_rebase(const struct object_id *curr_head,
 	else
 		strvec_push(&args, oid_to_hex(merge_head));
 
-	ret = run_command_v_opt(args.items, RUN_GIT_CMD);
+	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
 	strvec_clear(&args);
 	return ret;
 }
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3a9d6672f2..eeca53382f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -357,7 +357,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 			     oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
-				    make_script_args.nr, make_script_args.items,
+				    make_script_args.nr, make_script_args.v,
 				    flags);
 
 	if (ret)
@@ -906,7 +906,7 @@ static int run_am(struct rebase_options *opts)
 		return status;
 	}
 
-	strvec_pushv(&am.args, opts->git_am_opts.items);
+	strvec_pushv(&am.args, opts->git_am_opts.v);
 	strvec_push(&am.args, "--rebasing");
 	strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
 	strvec_push(&am.args, "--patch-format=mboxrd");
@@ -975,7 +975,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	add_var(&script_snippet, "revisions", opts->revisions);
 	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
 		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
-	sq_quote_argv_pretty(&buf, opts->git_am_opts.items);
+	sq_quote_argv_pretty(&buf, opts->git_am_opts.v);
 	add_var(&script_snippet, "git_am_opt", buf.buf);
 	strbuf_release(&buf);
 	add_var(&script_snippet, "verbose",
@@ -1636,7 +1636,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.flags |= REBASE_FORCE;
 
 	for (i = 0; i < options.git_am_opts.nr; i++) {
-		const char *option = options.git_am_opts.items[i], *p;
+		const char *option = options.git_am_opts.v[i], *p;
 		if (!strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			allow_preemptive_ff = 0;
@@ -1749,7 +1749,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.git_am_opts.nr || options.type == REBASE_APPLY) {
 		/* all am options except -q are compatible only with --apply */
 		for (i = options.git_am_opts.nr - 1; i >= 0; i--)
-			if (strcmp(options.git_am_opts.items[i], "-q"))
+			if (strcmp(options.git_am_opts.v[i], "-q"))
 				break;
 
 		if (i >= 0) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1158d184f5..b9615e8441 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1252,7 +1252,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.argv = update_refresh;
-	child.env = env->items;
+	child.env = env->v;
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
@@ -1263,7 +1263,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	/* run_command() does not clean up completely; reinitialize */
 	child_process_init(&child);
 	child.argv = diff_files;
-	child.env = env->items;
+	child.env = env->v;
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
@@ -1276,7 +1276,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 
 	child_process_init(&child);
 	child.argv = diff_index;
-	child.env = env->items;
+	child.env = env->v;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
 	child.stdout_to_stderr = 0;
@@ -1287,7 +1287,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	read_tree[3] = hash_to_hex(sha1);
 	child_process_init(&child);
 	child.argv = read_tree;
-	child.env = env->items;
+	child.env = env->v;
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
@@ -1306,7 +1306,7 @@ static const char *push_to_checkout(unsigned char *hash,
 				    const char *work_tree)
 {
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->items, push_to_checkout_hook,
+	if (run_hook_le(env->v, push_to_checkout_hook,
 			hash_to_hex(hash), NULL))
 		return "push-to-checkout hook declined";
 	else
diff --git a/builtin/remote.c b/builtin/remote.c
index 9a98e77a5e..c8240e9fcd 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1470,15 +1470,15 @@ static int update(int argc, const char **argv)
 	for (i = 1; i < argc; i++)
 		strvec_push(&fetch_argv, argv[i]);
 
-	if (strcmp(fetch_argv.items[fetch_argv.nr-1], "default") == 0) {
+	if (strcmp(fetch_argv.v[fetch_argv.nr-1], "default") == 0) {
 		git_config(get_remote_default, &default_defined);
 		if (!default_defined) {
 			strvec_pop(&fetch_argv);
 			strvec_push(&fetch_argv, "--all");
 		}
 	}
 
-	retval = run_command_v_opt(fetch_argv.items, RUN_GIT_CMD);
+	retval = run_command_v_opt(fetch_argv.v, RUN_GIT_CMD);
 	strvec_clear(&fetch_argv);
 	return retval;
 }
diff --git a/builtin/replace.c b/builtin/replace.c
index 038b7f874b..cd48765911 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -513,7 +513,7 @@ static int convert_graft_file(int force)
 			continue;
 
 		strvec_split(&args, buf.buf);
-		if (args.nr && create_graft(args.nr, args.items, force, 1))
+		if (args.nr && create_graft(args.nr, args.v, force, 1))
 			strbuf_addf(&err, "\n\t%s", buf.buf);
 		strvec_clear(&args);
 	}
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index de27703297..7eae5f3801 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -686,7 +686,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	/* If nothing is specified, try the default first */
 	if (ac == 1 && default_args.nr) {
 		ac = default_args.nr;
-		av = default_args.items;
+		av = default_args.v;
 	}
 
 	ac = parse_options(ac, av, prefix, builtin_show_branch_options,
diff --git a/builtin/stash.c b/builtin/stash.c
index 0134c6b0d6..10d87630cd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -745,7 +745,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 			strvec_push(&revision_args, argv[i]);
 	}
 
-	ret = get_stash_info(&info, stash_args.nr, stash_args.items);
+	ret = get_stash_info(&info, stash_args.nr, stash_args.v);
 	strvec_clear(&stash_args);
 	if (ret)
 		return -1;
@@ -767,7 +767,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	argc = setup_revisions(revision_args.nr, revision_args.items, &rev, NULL);
+	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
 	if (argc > 1) {
 		free_stash_info(&info);
 		usage_with_options(git_stash_show_usage, options);
@@ -1611,5 +1611,5 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
 	strvec_pushv(&args, argv);
-	return !!push_stash(args.nr, args.items, prefix, 1);
+	return !!push_stash(args.nr, args.v, prefix, 1);
 }
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bbed9f92a..df135abbf1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -818,7 +818,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.abbrev = 0;
 	diff_files_args.nr = setup_revisions(diff_files_args.nr,
-					     diff_files_args.items,
+					     diff_files_args.v,
 					     &rev, NULL);
 	diff_files_result = run_diff_files(&rev, 0);
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 8ded611092..24654b4c9b 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -45,7 +45,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse all options sent by the client */
-	return write_archive(sent_argv.nr, sent_argv.items, prefix,
+	return write_archive(sent_argv.nr, sent_argv.v, prefix,
 			     the_repository, NULL, 1);
 }
 
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 9a5b787912..ef24e11243 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -40,7 +40,7 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
 		strbuf_addstr(&arg, ".pack");
 	strvec_push(&argv, arg.buf);
 
-	index_pack.argv = argv.items;
+	index_pack.argv = argv.v;
 	index_pack.git_cmd = 1;
 
 	err = run_command(&index_pack);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1d6b9455da..378f332b5d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -422,7 +422,7 @@ static int add_worktree(const char *path, const char *refname,
 			strvec_push(&cp.args, "--quiet");
 	}
 
-	cp.env = child_env.items;
+	cp.env = child_env.v;
 	ret = run_command(&cp);
 	if (ret)
 		goto done;
@@ -433,7 +433,7 @@ static int add_worktree(const char *path, const char *refname,
 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
 			strvec_push(&cp.args, "--quiet");
-		cp.env = child_env.items;
+		cp.env = child_env.v;
 		ret = run_command(&cp);
 		if (ret)
 			goto done;
@@ -943,7 +943,7 @@ static void check_clean_worktree(struct worktree *wt,
 	strvec_pushl(&cp.args, "status",
 		     "--porcelain", "--ignore-submodules=none",
 		     NULL);
-	cp.env = child_env.items;
+	cp.env = child_env.v;
 	cp.git_cmd = 1;
 	cp.dir = wt->path;
 	cp.out = -1;
diff --git a/bundle.c b/bundle.c
index 762177e1fd..47e478c9a5 100644
--- a/bundle.c
+++ b/bundle.c
@@ -304,7 +304,7 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 		     "pack-objects",
 		     "--stdout", "--thin", "--delta-base-offset",
 		     NULL);
-	strvec_pushv(&pack_objects.args, pack_options->items);
+	strvec_pushv(&pack_objects.args, pack_options->v);
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
 	pack_objects.git_cmd = 1;
diff --git a/commit.c b/commit.c
index c8fd6931a6..4ce8cb38d5 100644
--- a/commit.c
+++ b/commit.c
@@ -1643,7 +1643,7 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		strvec_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.items, name, args);
+	ret = run_hook_ve(hook_env.v, name, args);
 	va_end(args);
 	strvec_clear(&hook_env);
 
diff --git a/connect.c b/connect.c
index e3a08179d4..0b6aba177e 100644
--- a/connect.c
+++ b/connect.c
@@ -72,7 +72,7 @@ int server_supports_v2(const char *c, int die_on_error)
 
 	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
-		if (skip_prefix(server_capabilities_v2.items[i], c, &out) &&
+		if (skip_prefix(server_capabilities_v2.v[i], c, &out) &&
 		    (!*out || *out == '='))
 			return 1;
 	}
@@ -89,7 +89,7 @@ int server_feature_v2(const char *c, const char **v)
 
 	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
-		if (skip_prefix(server_capabilities_v2.items[i], c, &out) &&
+		if (skip_prefix(server_capabilities_v2.v[i], c, &out) &&
 		    (*out == '=')) {
 			*v = out + 1;
 			return 1;
@@ -105,7 +105,7 @@ int server_supports_feature(const char *c, const char *feature,
 
 	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
-		if (skip_prefix(server_capabilities_v2.items[i], c, &out) &&
+		if (skip_prefix(server_capabilities_v2.v[i], c, &out) &&
 		    (!*out || *(out++) == '=')) {
 			if (parse_feature_request(out, feature))
 				return 1;
@@ -490,7 +490,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	packet_write_fmt(fd_out, "symrefs\n");
 	for (i = 0; ref_prefixes && i < ref_prefixes->nr; i++) {
 		packet_write_fmt(fd_out, "ref-prefix %s\n",
-				 ref_prefixes->items[i]);
+				 ref_prefixes->v[i]);
 	}
 	packet_flush(fd_out);
 
diff --git a/daemon.c b/daemon.c
index ee66002a6f..2ab7ea82eb 100644
--- a/daemon.c
+++ b/daemon.c
@@ -482,7 +482,7 @@ static int upload_pack(const struct strvec *env)
 	strvec_pushl(&cld.args, "upload-pack", "--strict", NULL);
 	strvec_pushf(&cld.args, "--timeout=%u", timeout);
 
-	strvec_pushv(&cld.env_array, env->items);
+	strvec_pushv(&cld.env_array, env->v);
 
 	return run_service_command(&cld);
 }
@@ -492,7 +492,7 @@ static int upload_archive(const struct strvec *env)
 	struct child_process cld = CHILD_PROCESS_INIT;
 	strvec_push(&cld.args, "upload-archive");
 
-	strvec_pushv(&cld.env_array, env->items);
+	strvec_pushv(&cld.env_array, env->v);
 
 	return run_service_command(&cld);
 }
@@ -502,7 +502,7 @@ static int receive_pack(const struct strvec *env)
 	struct child_process cld = CHILD_PROCESS_INIT;
 	strvec_push(&cld.args, "receive-pack");
 
-	strvec_pushv(&cld.env_array, env->items);
+	strvec_pushv(&cld.env_array, env->v);
 
 	return run_service_command(&cld);
 }
@@ -927,7 +927,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 #endif
 	}
 
-	cld.argv = cld_argv.items;
+	cld.argv = cld_argv.v;
 	cld.in = incoming;
 	cld.out = dup(incoming);
 
diff --git a/diff.c b/diff.c
index fb5462c532..f9709de7b4 100644
--- a/diff.c
+++ b/diff.c
@@ -4239,7 +4239,7 @@ static void run_external_diff(const char *pgm,
 
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
-	if (run_command_v_opt_cd_env(argv.items, RUN_USING_SHELL, NULL, env.items))
+	if (run_command_v_opt_cd_env(argv.v, RUN_USING_SHELL, NULL, env.v))
 		die(_("external diff died, stopping at %s"), name);
 
 	remove_tempfile();
diff --git a/environment.c b/environment.c
index 449a46995d..52e0c979ba 100644
--- a/environment.c
+++ b/environment.c
@@ -164,7 +164,7 @@ static const char *getenv_safe(struct strvec *argv, const char *name)
 		return NULL;
 
 	strvec_push(argv, value);
-	return argv->items[argv->nr - 1];
+	return argv->v[argv->nr - 1];
 }
 
 void setup_git_env(const char *git_dir)
diff --git a/exec-cmd.c b/exec-cmd.c
index d657c025c2..eeb2ee52b8 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -324,18 +324,18 @@ const char **prepare_git_cmd(struct strvec *out, const char **argv)
 {
 	strvec_push(out, "git");
 	strvec_pushv(out, argv);
-	return out->items;
+	return out->v;
 }
 
 int execv_git_cmd(const char **argv)
 {
 	struct strvec nargv = STRVEC_INIT;
 
 	prepare_git_cmd(&nargv, argv);
-	trace_argv_printf(nargv.items, "trace: exec:");
+	trace_argv_printf(nargv.v, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
-	sane_execvp("git", (char **)nargv.items);
+	sane_execvp("git", (char **)nargv.v);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
diff --git a/git.c b/git.c
index 0b2c5531ae..866ee11a2a 100644
--- a/git.c
+++ b/git.c
@@ -357,7 +357,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			strvec_push(&child.args, alias_string + 1);
 			strvec_pushv(&child.args, (*argv) + 1);
 
-			trace2_cmd_alias(alias_command, child.args.items);
+			trace2_cmd_alias(alias_command, child.args.v);
 			trace2_cmd_list_config();
 			trace2_cmd_list_env_vars();
 			trace2_cmd_name("_run_shell_alias_");
@@ -674,7 +674,7 @@ static void handle_builtin(int argc, const char **argv)
 		}
 
 		argc++;
-		argv = args.items;
+		argv = args.v;
 	}
 
 	builtin = get_builtin(cmd);
@@ -708,7 +708,7 @@ static void execv_dashed_external(const char **argv)
 	 * The code in run_command() logs trace2 child_start/child_exit
 	 * events, so we do not need to report exec/exec_result events here.
 	 */
-	trace_argv_printf(cmd.args.items, "trace: exec:");
+	trace_argv_printf(cmd.args.v, "trace: exec:");
 
 	/*
 	 * If we fail because the command is not found, it is
@@ -769,13 +769,13 @@ static int run_argv(int *argcp, const char ***argv)
 			for (i = 0; i < *argcp; i++)
 				strvec_push(&args, (*argv)[i]);
 
-			trace_argv_printf(args.items, "trace: exec:");
+			trace_argv_printf(args.v, "trace: exec:");
 
 			/*
 			 * if we fail because the command is not found, it is
 			 * OK to return. Otherwise, we just pass along the status code.
 			 */
-			i = run_command_v_opt_tr2(args.items, RUN_SILENT_EXEC_FAILURE |
+			i = run_command_v_opt_tr2(args.v, RUN_SILENT_EXEC_FAILURE |
 						  RUN_CLEAN_ON_EXIT | RUN_WAIT_AFTER_CLEAN, "git_alias");
 			if (i >= 0 || errno != ENOENT)
 				exit(i);
diff --git a/graph.c b/graph.c
index 1d68fffa24..c128ad0cce 100644
--- a/graph.c
+++ b/graph.c
@@ -355,7 +355,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 			parse_graph_colors_config(&custom_colors, string);
 			free(string);
 			/* graph_set_column_colors takes a max-index, not a count */
-			graph_set_column_colors(custom_colors.items,
+			graph_set_column_colors(custom_colors.v,
 						custom_colors.nr - 1);
 		}
 	}
diff --git a/http-push.c b/http-push.c
index c4e3825609..6a4a43e07f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1931,7 +1931,7 @@ int cmd_main(int argc, const char **argv)
 			strvec_pushf(&commit_argv, "^%s",
 				     oid_to_hex(&ref->old_oid));
 		repo_init_revisions(the_repository, &revs, setup_git_directory());
-		setup_revisions(commit_argv.nr, commit_argv.items, &revs, NULL);
+		setup_revisions(commit_argv.nr, commit_argv.v, &revs, NULL);
 		revs.edge_hint = 0; /* just in case */
 
 		/* Generate a list of objects that need to be pushed */
diff --git a/ls-refs.c b/ls-refs.c
index e6b8c9cf8e..a1e0b473e4 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -19,7 +19,7 @@ static int ref_match(const struct strvec *prefixes, const char *refname)
 		return 1; /* no restriction */
 
 	for (i = 0; i < prefixes->nr; i++) {
-		const char *prefix = prefixes->items[i];
+		const char *prefix = prefixes->v[i];
 
 		if (starts_with(refname, prefix))
 			return 1;
diff --git a/merge.c b/merge.c
index bcfb9dcf8a..753e461659 100644
--- a/merge.c
+++ b/merge.c
@@ -33,7 +33,7 @@ int try_merge_command(struct repository *r,
 	for (j = remotes; j; j = j->next)
 		strvec_push(&args, merge_argument(j->item));
 
-	ret = run_command_v_opt(args.items, RUN_GIT_CMD);
+	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
 	strvec_clear(&args);
 
 	discard_index(r->index);
diff --git a/pathspec.c b/pathspec.c
index 75378f49d1..7a229d8d22 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -652,7 +652,7 @@ void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
 	if (in != stdin)
 		fclose(in);
 
-	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.items);
+	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.v);
 	strvec_clear(&parsed_file);
 }
 
diff --git a/range-diff.c b/range-diff.c
index 3fa3ac6cb5..24dc435e48 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -67,7 +67,7 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--notes",
 		     NULL);
 	if (other_arg)
-		strvec_pushv(&cp.args, other_arg->items);
+		strvec_pushv(&cp.args, other_arg->v);
 	strvec_push(&cp.args, range);
 	cp.out = -1;
 	cp.no_stdin = 1;
diff --git a/ref-filter.c b/ref-filter.c
index 5b2a7684a1..d0e6ab525c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1923,9 +1923,9 @@ static void find_longest_prefixes(struct string_list *out,
 	struct strbuf prefix = STRBUF_INIT;
 
 	strvec_pushv(&sorted, patterns);
-	QSORT(sorted.items, sorted.nr, qsort_strcmp);
+	QSORT(sorted.v, sorted.nr, qsort_strcmp);
 
-	find_longest_prefixes_1(out, &prefix, sorted.items, sorted.nr);
+	find_longest_prefixes_1(out, &prefix, sorted.v, sorted.nr);
 
 	strvec_clear(&sorted);
 	strbuf_release(&prefix);
diff --git a/remote-curl.c b/remote-curl.c
index 8a2f461824..62b3a45cde 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1194,7 +1194,7 @@ static int fetch_git(struct discovery *heads,
 	rpc.service_name = "git-upload-pack",
 	rpc.gzip_request = 1;
 
-	err = rpc_service(&rpc, heads, args.items, &preamble, &rpc_result);
+	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);
 	if (rpc_result.len)
 		write_or_die(1, rpc_result.buf, rpc_result.len);
 	strbuf_release(&rpc_result);
@@ -1329,7 +1329,7 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-receive-pack",
 
-	err = rpc_service(&rpc, heads, args.items, &preamble, &rpc_result);
+	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);
 	if (rpc_result.len)
 		write_or_die(1, rpc_result.buf, rpc_result.len);
 	strbuf_release(&rpc_result);
@@ -1370,7 +1370,7 @@ static void parse_push(struct strbuf *buf)
 			break;
 	} while (1);
 
-	ret = push(specs.nr, specs.items);
+	ret = push(specs.nr, specs.v);
 	printf("\n");
 	fflush(stdout);
 
diff --git a/remote.c b/remote.c
index cc4b77ead6..d9af0018af 100644
--- a/remote.c
+++ b/remote.c
@@ -1969,7 +1969,7 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	strvec_push(&argv, "--");
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	setup_revisions(argv.nr, argv.items, &revs, NULL);
+	setup_revisions(argv.nr, argv.v, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
diff --git a/revision.c b/revision.c
index 358cc77c5c..3f909604e2 100644
--- a/revision.c
+++ b/revision.c
@@ -2807,7 +2807,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		 * }
 		 */
 		parse_pathspec(&revs->prune_data, 0, 0,
-			       revs->prefix, prune_data.items);
+			       revs->prefix, prune_data.v);
 	}
 	strvec_clear(&prune_data);
 
diff --git a/run-command.c b/run-command.c
index 26f24e4459..30f1dfe3c5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -287,7 +287,7 @@ static const char **prepare_shell_cmd(struct strvec *out, const char **argv)
 	}
 
 	strvec_pushv(out, argv);
-	return out->items;
+	return out->v;
 }
 
 #ifndef GIT_WINDOWS_NATIVE
@@ -426,11 +426,11 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
 	 * there are dir separator characters, we have exec attempt to invoke
 	 * the command directly.
 	 */
-	if (!has_dir_sep(out->items[1])) {
-		char *program = locate_in_PATH(out->items[1]);
+	if (!has_dir_sep(out->v[1])) {
+		char *program = locate_in_PATH(out->v[1]);
 		if (program) {
-			free((char *)out->items[1]);
-			out->items[1] = program;
+			free((char *)out->v[1]);
+			out->v[1] = program;
 		} else {
 			strvec_clear(out);
 			errno = ENOENT;
@@ -672,9 +672,9 @@ int start_command(struct child_process *cmd)
 	char *str;
 
 	if (!cmd->argv)
-		cmd->argv = cmd->args.items;
+		cmd->argv = cmd->args.v;
 	if (!cmd->env)
-		cmd->env = cmd->env_array.items;
+		cmd->env = cmd->env_array.v;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
@@ -846,10 +846,10 @@ int start_command(struct child_process *cmd)
 		 * be used in the event exec failed with ENOEXEC at which point
 		 * we will try to interpret the command using 'sh'.
 		 */
-		execve(argv.items[1], (char *const *) argv.items + 1,
+		execve(argv.v[1], (char *const *) argv.v + 1,
 		       (char *const *) childenv);
 		if (errno == ENOEXEC)
-			execve(argv.items[0], (char *const *) argv.items,
+			execve(argv.v[0], (char *const *) argv.v,
 			       (char *const *) childenv);
 
 		if (errno == ENOENT) {
@@ -1877,7 +1877,7 @@ int run_auto_maintenance(int quiet)
 	else
 		strvec_push(&argv_gc_auto, "--no-quiet");
 
-	status = run_command_v_opt(argv_gc_auto.items, RUN_GIT_CMD);
+	status = run_command_v_opt(argv_gc_auto.v, RUN_GIT_CMD);
 	strvec_clear(&argv_gc_auto);
 	return status;
 }
diff --git a/sequencer.c b/sequencer.c
index 10c83d0914..6b1795a844 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -871,8 +871,7 @@ static const char *author_date_from_env_array(const struct strvec *env)
 	const char *date;
 
 	for (i = 0; i < env->nr; i++)
-		if (skip_prefix(env->items[i],
-				"GIT_AUTHOR_DATE=", &date))
+		if (skip_prefix(env->v[i], "GIT_AUTHOR_DATE=", &date))
 			return date;
 	/*
 	 * If GIT_AUTHOR_DATE is missing we should have already errored out when
@@ -2855,7 +2854,7 @@ static int reset_merge(const struct object_id *oid)
 	if (!is_null_oid(oid))
 		strvec_push(&argv, oid_to_hex(oid));
 
-	ret = run_command_v_opt(argv.items, RUN_GIT_CMD);
+	ret = run_command_v_opt(argv.v, RUN_GIT_CMD);
 	strvec_clear(&argv);
 
 	return ret;
@@ -3229,7 +3228,7 @@ static int do_exec(struct repository *r, const char *command_line)
 	strvec_pushf(&child_env, "GIT_WORK_TREE=%s",
 		     absolute_path(get_git_work_tree()));
 	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
-					  child_env.items);
+					  child_env.v);
 
 	/* force re-reading of the cache */
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
diff --git a/serve.c b/serve.c
index 0db929beff..f6341206c4 100644
--- a/serve.c
+++ b/serve.c
@@ -148,7 +148,7 @@ int has_capability(const struct strvec *keys, const char *capability,
 	int i;
 	for (i = 0; i < keys->nr; i++) {
 		const char *out;
-		if (skip_prefix(keys->items[i], capability, &out) &&
+		if (skip_prefix(keys->v[i], capability, &out) &&
 		    (!*out || *out == '=')) {
 			if (value) {
 				if (*out == '=')
diff --git a/strvec.c b/strvec.c
index 0e17597f80..21dce0a7a4 100644
--- a/strvec.c
+++ b/strvec.c
@@ -6,25 +6,25 @@ const char *empty_strvec[] = { NULL };
 
 void strvec_init(struct strvec *array)
 {
-	array->items = empty_strvec;
+	array->v = empty_strvec;
 	array->nr = 0;
 	array->alloc = 0;
 }
 
 static void strvec_push_nodup(struct strvec *array, const char *value)
 {
-	if (array->items == empty_strvec)
-		array->items = NULL;
+	if (array->v == empty_strvec)
+		array->v = NULL;
 
-	ALLOC_GROW(array->items, array->nr + 2, array->alloc);
-	array->items[array->nr++] = value;
-	array->items[array->nr] = NULL;
+	ALLOC_GROW(array->v, array->nr + 2, array->alloc);
+	array->v[array->nr++] = value;
+	array->v[array->nr] = NULL;
 }
 
 const char *strvec_push(struct strvec *array, const char *value)
 {
 	strvec_push_nodup(array, xstrdup(value));
-	return array->items[array->nr - 1];
+	return array->v[array->nr - 1];
 }
 
 const char *strvec_pushf(struct strvec *array, const char *fmt, ...)
@@ -37,7 +37,7 @@ const char *strvec_pushf(struct strvec *array, const char *fmt, ...)
 	va_end(ap);
 
 	strvec_push_nodup(array, strbuf_detach(&v, NULL));
-	return array->items[array->nr - 1];
+	return array->v[array->nr - 1];
 }
 
 void strvec_pushl(struct strvec *array, ...)
@@ -61,8 +61,8 @@ void strvec_pop(struct strvec *array)
 {
 	if (!array->nr)
 		return;
-	free((char *)array->items[array->nr - 1]);
-	array->items[array->nr - 1] = NULL;
+	free((char *)array->v[array->nr - 1]);
+	array->v[array->nr - 1] = NULL;
 	array->nr--;
 }
 
@@ -88,21 +88,21 @@ void strvec_split(struct strvec *array, const char *to_split)
 
 void strvec_clear(struct strvec *array)
 {
-	if (array->items != empty_strvec) {
+	if (array->v != empty_strvec) {
 		int i;
 		for (i = 0; i < array->nr; i++)
-			free((char *)array->items[i]);
-		free(array->items);
+			free((char *)array->v[i]);
+		free(array->v);
 	}
 	strvec_init(array);
 }
 
 const char **strvec_detach(struct strvec *array)
 {
-	if (array->items == empty_strvec)
+	if (array->v == empty_strvec)
 		return xcalloc(1, sizeof(const char *));
 	else {
-		const char **ret = array->items;
+		const char **ret = array->v;
 		strvec_init(array);
 		return ret;
 	}
diff --git a/strvec.h b/strvec.h
index fda1c81c86..fdcad75b45 100644
--- a/strvec.h
+++ b/strvec.h
@@ -28,7 +28,7 @@ extern const char *empty_strvec[];
  * NULL.
  */
 struct strvec {
-	const char **items;
+	const char **v;
 	int nr;
 	int alloc;
 };
diff --git a/submodule.c b/submodule.c
index 51fdb9c365..48d6dea78d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -269,7 +269,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 			strvec_push(&args, item->string);
 		}
 
-		parse_pathspec(&ps, 0, 0, NULL, args.items);
+		parse_pathspec(&ps, 0, 0, NULL, args.v);
 		ret = match_pathspec(repo->index, &ps, path, strlen(path), 0, NULL, 1);
 
 		strvec_clear(&args);
@@ -842,7 +842,7 @@ static void collect_changed_submodules(struct repository *r,
 	const struct commit *commit;
 
 	repo_init_revisions(r, &rev, NULL);
-	setup_revisions(argv->nr, argv->items, &rev, NULL);
+	setup_revisions(argv->nr, argv->v, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
 
@@ -1014,7 +1014,7 @@ int find_unpushed_submodules(struct repository *r,
 	struct string_list_item *name;
 	struct strvec argv = STRVEC_INIT;
 
-	/* argv.items[0] will be ignored by setup_revisions */
+	/* argv.v[0] will be ignored by setup_revisions */
 	strvec_push(&argv, "find_unpushed_submodules");
 	oid_array_for_each_unique(commits, append_oid_to_argv, &argv);
 	strvec_push(&argv, "--not");
@@ -1453,7 +1453,7 @@ static int get_next_submodule(struct child_process *cp,
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
 			strvec_init(&cp->args);
-			strvec_pushv(&cp->args, spf->args.items);
+			strvec_pushv(&cp->args, spf->args.v);
 			strvec_push(&cp->args, default_argv);
 			strvec_push(&cp->args, "--submodule-prefix");
 
@@ -1501,7 +1501,7 @@ static int get_next_submodule(struct child_process *cp,
 		cp->dir = task->repo->gitdir;
 
 		strvec_init(&cp->args);
-		strvec_pushv(&cp->args, spf->args.items);
+		strvec_pushv(&cp->args, spf->args.v);
 		strvec_push(&cp->args, "on-demand");
 		strvec_push(&cp->args, "--submodule-prefix");
 		strvec_push(&cp->args, submodule_prefix.buf);
@@ -1620,7 +1620,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	strvec_push(&spf.args, "fetch");
 	for (i = 0; i < options->nr; i++)
-		strvec_push(&spf.args, options->items[i]);
+		strvec_push(&spf.args, options->v[i]);
 	strvec_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 605135be42..7ae03dc712 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -275,13 +275,13 @@ static int quote_stress_test(int argc, const char **argv)
 		if (i < skip)
 			continue;
 
-		cp.argv = args.items;
+		cp.argv = args.v;
 		strbuf_reset(&out);
 		if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0) < 0)
 			return error("Failed to spawn child process");
 
 		for (j = 0, k = 0; j < arg_count; j++) {
-			const char *arg = args.items[j + arg_offset];
+			const char *arg = args.v[j + arg_offset];
 
 			if (strcmp(arg, out.buf + k))
 				ret = error("incorrectly quoted arg: '%s', "
@@ -298,7 +298,7 @@ static int quote_stress_test(int argc, const char **argv)
 			fprintf(stderr, "Trial #%d failed. Arguments:\n", i);
 			for (j = 0; j < arg_count; j++)
 				fprintf(stderr, "arg #%d: '%s'\n",
-					(int)j, args.items[j + arg_offset]);
+					(int)j, args.v[j + arg_offset]);
 
 			strbuf_release(&out);
 			strvec_clear(&args);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index e21bef6cca..42ed4db5d3 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -283,7 +283,7 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
 {
 	if (!t)
 		return NULL;
-	return t->env.items;
+	return t->env.v;
 }
 
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
diff --git a/transport-helper.c b/transport-helper.c
index 51b72a224d..0029ba18bd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -138,7 +138,7 @@ static struct child_process *get_helper(struct transport *transport)
 		strvec_pushf(&helper->env_array, "%s=%s",
 			     GIT_DIR_ENVIRONMENT, get_git_dir());
 
-	helper->trace2_child_class = helper->args.items[0]; /* "remote-<name>" */
+	helper->trace2_child_class = helper->args.v[0]; /* "remote-<name>" */
 
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
diff --git a/upload-pack.c b/upload-pack.c
index bf677df48c..dd37000b23 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -906,7 +906,7 @@ static int send_shallow_list(struct upload_pack_data *data)
 			struct object *o = data->want_obj.objects[i].item;
 			strvec_push(&av, oid_to_hex(&o->oid));
 		}
-		deepen_by_rev_list(data, av.nr, av.items);
+		deepen_by_rev_list(data, av.nr, av.v);
 		strvec_clear(&av);
 		ret = 1;
 	} else {
