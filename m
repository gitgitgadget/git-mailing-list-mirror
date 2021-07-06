Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB7EC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF3761CA6
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhGFVGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:06:32 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:39706 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhGFVGb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:06:31 -0400
Received: by mail-ed1-f50.google.com with SMTP id v1so471005edt.6
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 14:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ec2H++sDdeA2sResqUIQyvLZKDUu/rr9Do5lNKlmxAk=;
        b=R1WySwH+8ph+nGP224VAjdvmpNrRlujmqvJj61GgTUKjP+7FRUu+QBr+WMcfN0esjK
         XHuPx7YnxxWYVTlfpvqH/BVJhR4ofS9Bsw7Yw6LMcnFY53vd6pTfOh+z1iT+auNBCjbi
         MtsuvRDYAslkdMjyiURK5/GpD5ah9tQ74FXuyQQRJMztHEau3nWBGoNNtzefMBro0D7a
         ZALdtrG9Ht7lCr0pmaFHZLLEQHuSWn9m/XoSaiPUol0RvFaUcyUXeY6ARc2eTHa8wa0J
         s9YLgoCiAGAenDWj9GAAaFFe1MRXarQFfwm4ywpittImzyKAZ8WtEzD0hzmJQCEHgovV
         vXrw==
X-Gm-Message-State: AOAM530F7v+fdzcfTyk3do4UTJvwSqKIjRerfF2gHHg8f1ZKY4xPHiji
        4Px7MU6rrxTWTageKluR8FtywAxTcIGO7Q==
X-Google-Smtp-Source: ABdhPJyMSH8mmv9wknMRQYwZXk6Sz3O/67nr9+O3snU2ATbtGVox/TFGAG86qC1cQWM8CXAAmQX3GA==
X-Received: by 2002:aa7:d751:: with SMTP id a17mr25695308eds.377.1625605431352;
        Tue, 06 Jul 2021 14:03:51 -0700 (PDT)
Received: from localhost.localdomain (IGLD-83-130-17-216.inter.net.il. [83.130.17.216])
        by smtp.gmail.com with ESMTPSA id t6sm7690284edd.3.2021.07.06.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 14:03:50 -0700 (PDT)
From:   Avishay Matayev <me@avishay.dev>
To:     git@vger.kernel.org
Cc:     code@tpope.net, Avishay Matayev <me@avishay.dev>
Subject: [PATCH 2/3] Allow isatty to be overriden with GIT_FORCE_TTY
Date:   Wed,  7 Jul 2021 00:03:17 +0300
Message-Id: <20210706210317.706313-3-me@avishay.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706210317.706313-1-me@avishay.dev>
References: <20210706210317.706313-1-me@avishay.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several behaviors where git will not attempt to do an action if a
tty is not present, for example - `git_pager` (pager.c) will instruct git
to not use the GIT_PAGER environment variable if stdout is not a pty.

This makes sense for the normal command-line use case, however, we might
want to force git to use GIT_PAGER as a pager even if no pty is present.
This can be useful for an external program to know whether git has used
the pager (as some commands in git do use the pager and some don't).

Another example is git push not prompting the editor to edit the commit
message if no pty is present, which is a behavior Fugitive could use
(even though it does not guarantee a pty).

Link: https://github.com/tpope/vim-fugitive/issues/1772
Link: https://lore.kernel.org/git/CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com/
Signed-off-by: Avishay Matayev <me@avishay.dev>
---
 builtin/am.c               |  2 +-
 builtin/bisect--helper.c   |  4 ++--
 builtin/blame.c            |  2 +-
 builtin/bundle.c           |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/commit-graph.c     |  4 ++--
 builtin/commit.c           |  2 +-
 builtin/fsck.c             |  2 +-
 builtin/gc.c               |  2 +-
 builtin/log.c              |  2 +-
 builtin/merge.c            |  4 ++--
 builtin/multi-pack-index.c |  2 +-
 builtin/pack-objects.c     |  2 +-
 builtin/pack-redundant.c   |  2 +-
 builtin/prune-packed.c     |  2 +-
 builtin/prune.c            |  2 +-
 builtin/rebase.c           |  2 +-
 builtin/repack.c           |  2 +-
 builtin/send-pack.c        |  2 +-
 builtin/shortlog.c         |  4 ++--
 builtin/sparse-checkout.c  |  2 +-
 builtin/unpack-objects.c   |  2 +-
 cache.h                    |  3 +++
 color.c                    |  2 +-
 column.c                   |  2 +-
 compat/mingw.c             |  6 +++---
 compat/mingw.h             |  2 +-
 compat/winansi.c           | 16 ++++++++--------
 config.c                   |  5 +++++
 date.c                     |  2 +-
 editor.c                   |  2 +-
 pager.c                    |  4 ++--
 preload-index.c            |  2 +-
 read-cache.c               |  2 +-
 remote-curl.c              |  2 +-
 sequencer.c                |  4 ++--
 sideband.c                 |  2 +-
 transport.c                |  6 +++---
 transport.h                |  2 +-
 wt-status.c                |  2 +-
 40 files changed, 63 insertions(+), 55 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 2230c3e94d..bc4d2b23ac 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2394,7 +2394,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		 *    intend to feed us a patch but wanted to continue
 		 *    unattended.
 		 */
-		if (argc || (resume.mode == RESUME_FALSE && !isatty(STDIN_FILENO)))
+		if (argc || (resume.mode == RESUME_FALSE && !git_isatty(STDIN_FILENO)))
 			die(_("previous rebase directory %s still exists but mbox given."),
 				state.dir);
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5d42c75a46..e8de9f4433 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -346,7 +346,7 @@ static int decide_next(const struct bisect_terms *terms,
 		 * although this is less optimum.
 		 */
 		warning(_("bisecting only with a %s commit"), terms->term_bad);
-		if (!isatty(STDIN_FILENO))
+		if (!git_isatty(STDIN_FILENO))
 			return 0;
 		/*
 		 * TRANSLATORS: Make sure to include [Y] and [n] in your
@@ -813,7 +813,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 	fprintf_ln(stderr, _("You need to start by \"git bisect "
 			  "start\"\n"));
 
-	if (!isatty(STDIN_FILENO))
+	if (!git_isatty(STDIN_FILENO))
 		return -1;
 
 	/*
diff --git a/builtin/blame.c b/builtin/blame.c
index 1b674b2f52..6df43333c9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -945,7 +945,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			die(_("--progress can't be used with --incremental or porcelain formats"));
 		show_progress = 0;
 	} else if (show_progress < 0)
-		show_progress = isatty(STDERR_FILENO);
+		show_progress = git_isatty(STDERR_FILENO);
 
 	if (0 < abbrev && abbrev < hexsz)
 		/* one more abbrev length is needed for the boundary commit */
diff --git a/builtin/bundle.c b/builtin/bundle.c
index ea6948110b..48bebe2cc9 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -58,7 +58,7 @@ static int parse_options_cmd_bundle(int argc,
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	int all_progress_implied = 0;
-	int progress = isatty(STDERR_FILENO);
+	int progress = git_isatty(STDERR_FILENO);
 	struct strvec pack_opts;
 	int version = -1;
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e3bd31449b..617373d557 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1607,7 +1607,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		if (opts->quiet)
 			opts->show_progress = 0;
 		else
-			opts->show_progress = isatty(STDERR_FILENO);
+			opts->show_progress = git_isatty(STDERR_FILENO);
 	}
 
 	if (opts->conflict_style) {
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 461f1a2a65..65fc8483d9 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -87,7 +87,7 @@ static int graph_verify(int argc, const char **argv)
 
 	trace2_cmd_mode("verify");
 
-	opts.progress = isatty(STDERR_FILENO);
+	opts.progress = git_isatty(STDERR_FILENO);
 	argc = parse_options(argc, argv, NULL,
 			     builtin_commit_graph_verify_options,
 			     builtin_commit_graph_verify_usage, 0);
@@ -236,7 +236,7 @@ static int graph_write(int argc, const char **argv)
 		OPT_END(),
 	};
 
-	opts.progress = isatty(STDERR_FILENO);
+	opts.progress = git_isatty(STDERR_FILENO);
 	opts.enable_changed_paths = -1;
 	write_opts.size_multiple = 2;
 	write_opts.max_commits = 0;
diff --git a/builtin/commit.c b/builtin/commit.c
index d364ce6a39..bfe397e6cc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -754,7 +754,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (logfile && !strcmp(logfile, "-")) {
-		if (isatty(STDIN_FILENO))
+		if (git_isatty(STDIN_FILENO))
 			fprintf(stderr, _("(reading log message from standard input)\n"));
 		if (strbuf_read(&sb, 0, 0) < 0)
 			die_errno(_("could not read log from standard input"));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4e65c823e4..a18452fa6c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -790,7 +790,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_obj_options.strict = 1;
 
 	if (show_progress == -1)
-		show_progress = isatty(STDERR_FILENO);
+		show_progress = git_isatty(STDERR_FILENO);
 	if (verbose)
 		show_progress = 0;
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 4566754427..80860ae2dc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1425,7 +1425,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	};
 	memset(&opts, 0, sizeof(opts));
 
-	opts.quiet = !isatty(STDERR_FILENO);
+	opts.quiet = !git_isatty(STDERR_FILENO);
 
 	for (i = 0; i < TASK__COUNT; i++)
 		tasks[i].selected_order = -1;
diff --git a/builtin/log.c b/builtin/log.c
index 5bb9f4194a..b0a98b3acf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -69,7 +69,7 @@ struct line_opt_callback_data {
 
 static int session_is_interactive(void)
 {
-	return isatty(STDOUT_FILENO) || pager_in_use();
+	return git_isatty(STDOUT_FILENO) || pager_in_use();
 }
 
 static int auto_decoration_style(void)
diff --git a/builtin/merge.c b/builtin/merge.c
index 88f53c03b5..e576e52bf4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -734,7 +734,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			o.subtree_shift = "";
 
 		o.show_rename_progress =
-			show_progress == -1 ? isatty(STDERR_FILENO) : show_progress;
+			show_progress == -1 ? git_isatty(STDERR_FILENO) : show_progress;
 
 		for (x = 0; x < xopts_nr; x++)
 			if (parse_merge_opt(&o, xopts[x]))
@@ -1073,7 +1073,7 @@ static int default_edit_option(void)
 	/* Use editor if stdin and stdout are the same and is a tty */
 	return (!fstat(0, &st_stdin) &&
 		!fstat(1, &st_stdout) &&
-		isatty(STDIN_FILENO) && isatty(STDOUT_FILENO) &&
+		git_isatty(STDIN_FILENO) && git_isatty(STDOUT_FILENO) &&
 		st_stdin.st_dev == st_stdout.st_dev &&
 		st_stdin.st_ino == st_stdout.st_ino &&
 		st_stdin.st_mode == st_stdout.st_mode);
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 8e329b8b22..f23d199a19 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -154,7 +154,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	git_config(git_default_config, NULL);
 
-	if (isatty(STDERR_FILENO))
+	if (git_isatty(STDERR_FILENO))
 		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 74536fa5a4..2d54cd5283 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4016,7 +4016,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
 		pack_idx_opts.flags |= WRITE_REV;
 
-	progress = isatty(STDERR_FILENO);
+	progress = git_isatty(STDERR_FILENO);
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
 			     pack_usage, 0);
 
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index acf1edba3a..0516b3c8a7 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -621,7 +621,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 
 	/* ignore objects given on stdin */
 	llist_init(&ignore);
-	if (!isatty(STDIN_FILENO)) {
+	if (!git_isatty(STDIN_FILENO)) {
 		while (fgets(buf, sizeof(buf), stdin)) {
 			oid = xmalloc(sizeof(*oid));
 			if (get_oid_hex(buf, oid))
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 5d476316a5..4961eed29e 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -9,7 +9,7 @@ static const char * const prune_packed_usage[] = {
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
-	int opts = isatty(STDERR_FILENO) ? PRUNE_PACKED_VERBOSE : 0;
+	int opts = git_isatty(STDERR_FILENO) ? PRUNE_PACKED_VERBOSE : 0;
 	const struct option prune_packed_options[] = {
 		OPT_BIT('n', "dry-run", &opts, N_("dry run"),
 			PRUNE_PACKED_DRY_RUN),
diff --git a/builtin/prune.c b/builtin/prune.c
index 36b9fed1bf..b2d810dd51 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -165,7 +165,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_progress == -1)
-		show_progress = isatty(STDERR_FILENO);
+		show_progress = git_isatty(STDERR_FILENO);
 	if (exclude_promisor_objects) {
 		fetch_if_missing = 0;
 		revs.exclude_promisor_objects = 1;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 97e8c8cbf8..3ffc15f08d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1745,7 +1745,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
 
-	if (isatty(STDERR_FILENO) && options.flags & REBASE_NO_QUIET)
+	if (git_isatty(STDERR_FILENO) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
 	if (options.git_am_opts.nr || options.type == REBASE_APPLY) {
diff --git a/builtin/repack.c b/builtin/repack.c
index 4eb21e8e98..31beee642d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -710,7 +710,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			}
 			strbuf_release(&buf);
 		}
-		if (!po_args.quiet && isatty(STDERR_FILENO))
+		if (!po_args.quiet && git_isatty(STDERR_FILENO))
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index c168c03a26..5919466913 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -261,7 +261,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	if (progress == -1)
-		progress = !args.quiet && isatty(STDERR_FILENO);
+		progress = !args.quiet && git_isatty(STDERR_FILENO);
 	args.progress = progress;
 
 	if (args.stateless_rpc) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index a3612e3f72..dd4550cea6 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -406,10 +406,10 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	string_list_sort(&log.trailers);
 
 	/* assume HEAD if from a tty */
-	if (!nongit && !rev.pending.nr && isatty(STDIN_FILENO))
+	if (!nongit && !rev.pending.nr && git_isatty(STDIN_FILENO))
 		add_head_to_pending(&rev);
 	if (rev.pending.nr == 0) {
-		if (isatty(STDIN_FILENO))
+		if (git_isatty(STDIN_FILENO))
 			fprintf(stderr, _("(reading log message from standard input)\n"));
 		read_from_stdin(&log);
 	}
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 63e79c7520..71eece7c12 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -114,7 +114,7 @@ static int update_working_directory(struct pattern_list *pl)
 	r->index->sparse_checkout_patterns = pl;
 
 	memset(&o, 0, sizeof(o));
-	o.verbose_update = isatty(STDERR_FILENO);
+	o.verbose_update = git_isatty(STDERR_FILENO);
 	o.update = 1;
 	o.head_idx = -1;
 	o.src_index = r->index;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 1a86e2e606..c64ed6b037 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -522,7 +522,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	quiet = !isatty(STDERR_FILENO);
+	quiet = !git_isatty(STDERR_FILENO);
 
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/cache.h b/cache.h
index ba04ff8bd3..76497f2770 100644
--- a/cache.h
+++ b/cache.h
@@ -1893,4 +1893,7 @@ int print_sha1_ellipsis(void);
 /* Return 1 if the file is empty or does not exists, 0 otherwise. */
 int is_empty_or_missing_file(const char *filename);
 
+/* Return 1 if the fd is a tty or if GIT_FORCE_TTY is set, 0 otherwise. */
+int git_isatty(int fd);
+
 #endif /* CACHE_H */
diff --git a/color.c b/color.c
index 64f52a4f93..d13fa1a557 100644
--- a/color.c
+++ b/color.c
@@ -357,7 +357,7 @@ static int check_auto_color(int fd)
 	static int color_stderr_is_tty = -1;
 	int *is_tty_p = fd == 1 ? &color_stdout_is_tty : &color_stderr_is_tty;
 	if (*is_tty_p < 0)
-		*is_tty_p = isatty(fd);
+		*is_tty_p = git_isatty(fd);
 	if (*is_tty_p || (fd == 1 && pager_in_use() && pager_use_color)) {
 		if (!is_terminal_dumb())
 			return 1;
diff --git a/column.c b/column.c
index 375869e848..7b3c4b6be7 100644
--- a/column.c
+++ b/column.c
@@ -211,7 +211,7 @@ int finalize_colopts(unsigned int *colopts, int stdout_is_tty)
 {
 	if ((*colopts & COL_ENABLE_MASK) == COL_AUTO) {
 		if (stdout_is_tty < 0)
-			stdout_is_tty = isatty(STDOUT_FILENO);
+			stdout_is_tty = git_isatty(STDOUT_FILENO);
 		*colopts &= ~COL_ENABLE_MASK;
 		if (stdout_is_tty || pager_in_use())
 			*colopts |= COL_ENABLED;
diff --git a/compat/mingw.c b/compat/mingw.c
index aa647b367b..b85b66a75d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -204,7 +204,7 @@ static int ask_yes_no_if_possible(const char *format, ...)
 		return !run_command_v_opt(retry_hook, 0);
 	}
 
-	if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
+	if (!git_isatty(_fileno(stdin)) || !git_isatty(_fileno(stderr)))
 		return 0;
 
 	while (1) {
@@ -570,7 +570,7 @@ static BOOL WINAPI ctrl_ignore(DWORD type)
 int mingw_fgetc(FILE *stream)
 {
 	int ch;
-	if (!isatty(_fileno(stream)))
+	if (!git_isatty(_fileno(stream)))
 		return fgetc(stream);
 
 	SetConsoleCtrlHandler(ctrl_ignore, TRUE);
@@ -2353,7 +2353,7 @@ int mingw_raise(int sig)
 	switch (sig) {
 	case SIGALRM:
 		if (timer_fn == SIG_DFL) {
-			if (isatty(STDERR_FILENO))
+			if (git_isatty(STDERR_FILENO))
 				fputs("Alarm clock\n", stderr);
 			exit(128 + SIGALRM);
 		} else if (timer_fn != SIG_IGN)
diff --git a/compat/mingw.h b/compat/mingw.h
index c9a52ad64a..ea1fa43092 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -425,7 +425,7 @@ int mingw_raise(int sig);
  */
 
 int winansi_isatty(int fd);
-#define isatty winansi_isatty
+#define git_isatty winansi_isatty
 
 int winansi_dup2(int oldfd, int newfd);
 #define dup2 winansi_dup2
diff --git a/compat/winansi.c b/compat/winansi.c
index c27b20a79d..29378e52e2 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -590,19 +590,19 @@ static void detect_msys_tty(int fd)
 #endif
 
 /*
- * Wrapper for isatty().  Most calls in the main git code
- * call isatty(1 or 2) to see if the instance is interactive
- * and should: be colored, show progress, paginate output.
- * We lie and give results for what the descriptor WAS at
- * startup (and ignore any pipe redirection we internally
- * do).
+ * Wrapper for git_isatty().  Most calls in the main git
+ * code call git_isatty(1 or 2) to see if the instance is
+ * interactive and should: be colored, show progress,
+ * paginate output.  We lie and give results for what the
+ * descriptor WAS at startup (and ignore any pipe
+ * redirection we internally do).
  */
-#undef isatty
+#undef git_isatty
 int winansi_isatty(int fd)
 {
 	if (fd >= 0 && fd <= 2)
 		return fd_is_interactive[fd] != 0;
-	return isatty(fd);
+	return git_isatty(fd);
 }
 
 void winansi_init(void)
diff --git a/config.c b/config.c
index f9c400ad30..6afa42a22c 100644
--- a/config.c
+++ b/config.c
@@ -3563,3 +3563,8 @@ int lookup_config(const char **mapping, int nr_mapping, const char *var)
 	}
 	return -1;
 }
+
+int git_isatty(int fd)
+{
+	return git_env_bool("GIT_FORCE_TTY", isatty(fd));
+}
diff --git a/date.c b/date.c
index 6dd6c37c22..bd53752854 100644
--- a/date.c
+++ b/date.c
@@ -969,7 +969,7 @@ void parse_date_format(const char *format, struct date_mode *mode)
 
 	/* "auto:foo" is "if tty/pager, then foo, otherwise normal" */
 	if (skip_prefix(format, "auto:", &p)) {
-		if (isatty(STDOUT_FILENO) || pager_in_use())
+		if (git_isatty(STDOUT_FILENO) || pager_in_use())
 			format = p;
 		else
 			format = "default";
diff --git a/editor.c b/editor.c
index 13521f05cf..bc03f22477 100644
--- a/editor.c
+++ b/editor.c
@@ -58,7 +58,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		const char *args[] = { editor, NULL, NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
-		int print_waiting_for_editor = advice_waiting_for_editor && isatty(STDERR_FILENO);
+		int print_waiting_for_editor = advice_waiting_for_editor && git_isatty(STDERR_FILENO);
 
 		if (print_waiting_for_editor) {
 			/*
diff --git a/pager.c b/pager.c
index 3c4664ebed..c255d1ad36 100644
--- a/pager.c
+++ b/pager.c
@@ -101,7 +101,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
-	const char *pager = git_pager(isatty(STDOUT_FILENO));
+	const char *pager = git_pager(git_isatty(STDOUT_FILENO));
 
 	if (!pager)
 		return;
@@ -128,7 +128,7 @@ void setup_pager(void)
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
-	if (isatty(STDERR_FILENO))
+	if (git_isatty(STDERR_FILENO))
 		dup2(pager_process.in, 2);
 	close(pager_process.in);
 
diff --git a/preload-index.c b/preload-index.c
index 28707d9bee..2812c96b43 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -121,7 +121,7 @@ void preload_index(struct index_state *index,
 	memset(&data, 0, sizeof(data));
 
 	memset(&pd, 0, sizeof(pd));
-	if (refresh_flags & REFRESH_PROGRESS && isatty(STDERR_FILENO)) {
+	if (refresh_flags & REFRESH_PROGRESS && git_isatty(STDERR_FILENO)) {
 		pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr);
 		pthread_mutex_init(&pd.mutex, NULL);
 	}
diff --git a/read-cache.c b/read-cache.c
index a8063fefe6..acd6850b59 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1568,7 +1568,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int t2_sum_lstat = 0;
 	int t2_sum_scan = 0;
 
-	if (flags & REFRESH_PROGRESS && isatty(STDERR_FILENO))
+	if (flags & REFRESH_PROGRESS && git_isatty(STDERR_FILENO))
 		progress = start_delayed_progress(_("Refresh index"),
 						  istate->cache_nr);
 
diff --git a/remote-curl.c b/remote-curl.c
index 843a287680..e644ada8cc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1483,7 +1483,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	options.verbosity = 1;
-	options.progress = !!isatty(STDERR_FILENO);
+	options.progress = !!git_isatty(STDERR_FILENO);
 	options.thin = 1;
 	string_list_init(&options.deepen_not, 1);
 	string_list_init(&options.push_options, 1);
diff --git a/sequencer.c b/sequencer.c
index d1311eecc1..9d4acb267b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2040,7 +2040,7 @@ static int should_edit(struct replay_opts *opts) {
 		 * commits; continue_single_pick() handles the conflicted
 		 * commits itself instead of calling this function.
 		 */
-		return (opts->action == REPLAY_REVERT && isatty(STDIN_FILENO)) ? 1 : 0;
+		return (opts->action == REPLAY_REVERT && git_isatty(STDIN_FILENO)) ? 1 : 0;
 	return opts->edit;
 }
 
@@ -4589,7 +4589,7 @@ static int continue_single_pick(struct repository *r, struct replay_opts *opts)
 	 * we want to edit if the user asked for it, or if they didn't specify
 	 * and stdin is a tty.
 	 */
-	if (!opts->edit || (opts->edit < 0 && !isatty(STDIN_FILENO)))
+	if (!opts->edit || (opts->edit < 0 && !git_isatty(STDIN_FILENO)))
 		/*
 		 * Include --cleanup=strip as well because we don't want the
 		 * "# Conflicts:" messages.
diff --git a/sideband.c b/sideband.c
index a5dcb971f5..24afcb06e6 100644
--- a/sideband.c
+++ b/sideband.c
@@ -126,7 +126,7 @@ int demultiplex_sideband(const char *me, int status,
 	int band;
 
 	if (!suffix) {
-		if (isatty(STDERR_FILENO) && !is_terminal_dumb())
+		if (git_isatty(STDERR_FILENO) && !is_terminal_dumb())
 			suffix = ANSI_SUFFIX;
 		else
 			suffix = DUMB_SUFFIX;
diff --git a/transport.c b/transport.c
index ab8f297afa..bdbf89137d 100644
--- a/transport.c
+++ b/transport.c
@@ -1051,7 +1051,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	const char *helper;
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
-	ret->progress = isatty(STDERR_FILENO);
+	ret->progress = git_isatty(STDERR_FILENO);
 	string_list_init(&ret->pack_lockfiles, 1);
 
 	if (!remote)
@@ -1168,12 +1168,12 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 	 *   . Report progress, if force_progress is 1 (ie. --progress).
 	 *   . Don't report progress, if force_progress is 0 (ie. --no-progress).
 	 *   . Don't report progress, if verbosity < 0 (ie. -q/--quiet ).
-	 *   . Report progress if isatty(STDERR_FILENO) is 1.
+	 *   . Report progress if git_isatty(STDERR_FILENO) is 1.
 	 **/
 	if (force_progress >= 0)
 		transport->progress = !!force_progress;
 	else
-		transport->progress = verbosity >= 0 && isatty(STDERR_FILENO);
+		transport->progress = verbosity >= 0 && git_isatty(STDERR_FILENO);
 }
 
 static void die_with_unpushed_submodules(struct string_list *needs_pushing)
diff --git a/transport.h b/transport.h
index 4630d42755..8ec9ee2cab 100644
--- a/transport.h
+++ b/transport.h
@@ -110,7 +110,7 @@ struct transport {
 	signed verbose : 3;
 	/**
 	 * Transports should not set this directly, and should use this
-	 * value without having to check isatty(STDERR_FILENO), -q/--quiet
+	 * value without having to check git_isatty(STDERR_FILENO), -q/--quiet
 	 * (transport->verbose < 0), etc. - checking has already been done
 	 * in transport_set_verbosity().
 	 **/
diff --git a/wt-status.c b/wt-status.c
index 42b6735716..61f0afbc6b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1060,7 +1060,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	 * If we're not going to stdout, then we definitely don't
 	 * want color, since we are going to the commit message
 	 * file (and even the "auto" setting won't work, since it
-	 * will have checked isatty on stdout). But we then do want
+	 * will have checked git_isatty on stdout). But we then do want
 	 * to insert the scissor line here to reliably remove the
 	 * diff before committing.
 	 */
-- 
2.25.1

