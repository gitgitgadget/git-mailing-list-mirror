Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61232C433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316D02065E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgG1UZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:25:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:40222 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgG1UY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:24:59 -0400
Received: (qmail 29744 invoked by uid 109); 28 Jul 2020 20:24:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:24:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28563 invoked by uid 111); 28 Jul 2020 20:24:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:24:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:24:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/11] strvec: convert more callers away from argv_array name
Message-ID: <20200728202453.GF1021513@coredump.intra.peff.net>
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

This patch converts remaining files from the first half of the alphabet,
to keep the diff to a manageable size.

The conversion was done purely mechanically with:

  git ls-files '*.c' '*.h' |
  xargs perl -i -pe '
    s/ARGV_ARRAY/STRVEC/g;
    s/argv_array/strvec/g;
  '

and then selectively staging files with "git add '[abcdefghjkl]*'".
We'll deal with any indentation/style fallouts separately.

Signed-off-by: Jeff King <peff@peff.net>
---
 add-interactive.c | 14 ++++++-------
 add-patch.c       | 28 ++++++++++++-------------
 bisect.c          | 12 +++++------
 bundle.c          | 12 +++++------
 bundle.h          |  2 +-
 column.c          | 12 +++++------
 commit.c          |  8 ++++----
 compat/mingw.c    |  4 ++--
 compat/terminal.c | 18 ++++++++--------
 connect.c         | 48 +++++++++++++++++++++----------------------
 connected.c       | 22 ++++++++++----------
 daemon.c          | 52 +++++++++++++++++++++++------------------------
 diff.c            | 28 ++++++++++++-------------
 environment.c     |  8 ++++----
 exec-cmd.c        | 10 ++++-----
 fast-import.c     |  4 ++--
 fetch-pack.c      | 34 +++++++++++++++----------------
 fsmonitor.c       |  6 +++---
 git.c             | 22 ++++++++++----------
 gpg-interface.c   |  8 ++++----
 graph.c           | 10 ++++-----
 http-backend.c    |  4 ++--
 http-push.c       | 12 +++++------
 http.c            |  6 +++---
 imap-send.c       |  2 +-
 line-log.c        |  6 +++---
 ls-refs.c         | 10 ++++-----
 27 files changed, 201 insertions(+), 201 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 29cd2fe020..b345777d0c 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -935,18 +935,18 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 	opts->prompt = N_("Patch update");
 	count = list_and_choose(s, files, opts);
 	if (count > 0) {
-		struct argv_array args = ARGV_ARRAY_INIT;
+		struct strvec args = STRVEC_INIT;
 		struct pathspec ps_selected = { 0 };
 
 		for (i = 0; i < files->items.nr; i++)
 			if (files->selected[i])
-				argv_array_push(&args,
+				strvec_push(&args,
 						files->items.items[i].string);
 		parse_pathspec(&ps_selected,
 			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 			       PATHSPEC_LITERAL_PATH, "", args.argv);
 		res = run_add_p(s->r, ADD_P_ADD, NULL, &ps_selected);
-		argv_array_clear(&args);
+		strvec_clear(&args);
 		clear_pathspec(&ps_selected);
 	}
 
@@ -976,18 +976,18 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 	count = list_and_choose(s, files, opts);
 	opts->flags = 0;
 	if (count > 0) {
-		struct argv_array args = ARGV_ARRAY_INIT;
+		struct strvec args = STRVEC_INIT;
 
-		argv_array_pushl(&args, "git", "diff", "-p", "--cached",
+		strvec_pushl(&args, "git", "diff", "-p", "--cached",
 				 oid_to_hex(!is_initial ? &oid :
 					    s->r->hash_algo->empty_tree),
 				 "--", NULL);
 		for (i = 0; i < files->items.nr; i++)
 			if (files->selected[i])
-				argv_array_push(&args,
+				strvec_push(&args,
 						files->items.items[i].string);
 		res = run_command_v_opt(args.argv, 0);
-		argv_array_clear(&args);
+		strvec_clear(&args);
 	}
 
 	putchar('\n');
diff --git a/add-patch.c b/add-patch.c
index 09d00c5574..3c91ae52ae 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -286,11 +286,11 @@ static void setup_child_process(struct add_p_state *s,
 
 	va_start(ap, cp);
 	while ((arg = va_arg(ap, const char *)))
-		argv_array_push(&cp->args, arg);
+		strvec_push(&cp->args, arg);
 	va_end(ap);
 
 	cp->git_cmd = 1;
-	argv_array_pushf(&cp->env_array,
+	strvec_pushf(&cp->env_array,
 			 INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
 }
 
@@ -370,7 +370,7 @@ static int is_octal(const char *p, size_t len)
 
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 	const char *diff_algorithm = s->s.interactive_diff_algorithm;
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -380,32 +380,32 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	struct hunk *hunk = NULL;
 	int res;
 
-	argv_array_pushv(&args, s->mode->diff_cmd);
+	strvec_pushv(&args, s->mode->diff_cmd);
 	if (diff_algorithm)
-		argv_array_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
+		strvec_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
 	if (s->revision) {
 		struct object_id oid;
-		argv_array_push(&args,
+		strvec_push(&args,
 				/* could be on an unborn branch */
 				!strcmp("HEAD", s->revision) &&
 				get_oid("HEAD", &oid) ?
 				empty_tree_oid_hex() : s->revision);
 	}
 	color_arg_index = args.argc;
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
-	argv_array_pushl(&args, "--no-color", "-p", "--", NULL);
+	strvec_pushl(&args, "--no-color", "-p", "--", NULL);
 	for (i = 0; i < ps->nr; i++)
-		argv_array_push(&args, ps->items[i].original);
+		strvec_push(&args, ps->items[i].original);
 
 	setup_child_process(s, &cp, NULL);
 	cp.argv = args.argv;
 	res = capture_command(&cp, plain, 0);
 	if (res) {
-		argv_array_clear(&args);
+		strvec_clear(&args);
 		return error(_("could not parse diff"));
 	}
 	if (!plain->len) {
-		argv_array_clear(&args);
+		strvec_clear(&args);
 		return 0;
 	}
 	strbuf_complete_line(plain);
@@ -419,7 +419,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		colored_cp.argv = args.argv;
 		colored = &s->colored;
 		res = capture_command(&colored_cp, colored, 0);
-		argv_array_clear(&args);
+		strvec_clear(&args);
 		if (res)
 			return error(_("could not parse colored diff"));
 
@@ -444,7 +444,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		colored_p = colored->buf;
 		colored_pend = colored_p + colored->len;
 	}
-	argv_array_clear(&args);
+	strvec_clear(&args);
 
 	/* parse files and hunks */
 	p = plain->buf;
@@ -1158,7 +1158,7 @@ static int run_apply_check(struct add_p_state *s,
 
 	setup_child_process(s, &cp,
 			    "apply", "--check", NULL);
-	argv_array_pushv(&cp.args, s->mode->apply_check_args);
+	strvec_pushv(&cp.args, s->mode->apply_check_args);
 	if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
 		return error(_("'git apply --cached' failed"));
 
@@ -1619,7 +1619,7 @@ static int patch_update_file(struct add_p_state *s,
 					   s->mode->is_reverse);
 		else {
 			setup_child_process(s, &cp, "apply", NULL);
-			argv_array_pushv(&cp.args, s->mode->apply_args);
+			strvec_pushv(&cp.args, s->mode->apply_args);
 			if (pipe_command(&cp, s->buf.buf, s->buf.len,
 					 NULL, 0, NULL, 0))
 				error(_("'git apply' failed"));
diff --git a/bisect.c b/bisect.c
index 77e35ddd43..3e50b51c11 100644
--- a/bisect.c
+++ b/bisect.c
@@ -456,7 +456,7 @@ static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
-static void read_bisect_paths(struct argv_array *array)
+static void read_bisect_paths(struct strvec *array)
 {
 	struct strbuf str = STRBUF_INIT;
 	const char *filename = git_path_bisect_names();
@@ -632,20 +632,20 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 			     const char *bad_format, const char *good_format,
 			     int read_paths)
 {
-	struct argv_array rev_argv = ARGV_ARRAY_INIT;
+	struct strvec rev_argv = STRVEC_INIT;
 	int i;
 
 	repo_init_revisions(r, revs, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
-	argv_array_push(&rev_argv, "bisect_rev_setup");
-	argv_array_pushf(&rev_argv, bad_format, oid_to_hex(current_bad_oid));
+	strvec_push(&rev_argv, "bisect_rev_setup");
+	strvec_pushf(&rev_argv, bad_format, oid_to_hex(current_bad_oid));
 	for (i = 0; i < good_revs.nr; i++)
-		argv_array_pushf(&rev_argv, good_format,
+		strvec_pushf(&rev_argv, good_format,
 				 oid_to_hex(good_revs.oid + i));
-	argv_array_push(&rev_argv, "--");
+	strvec_push(&rev_argv, "--");
 	if (read_paths)
 		read_bisect_paths(&rev_argv);
 
diff --git a/bundle.c b/bundle.c
index d46a387e66..709b2abc9c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -269,16 +269,16 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 
 
 /* Write the pack data to bundle_fd */
-static int write_pack_data(int bundle_fd, struct rev_info *revs, struct argv_array *pack_options)
+static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *pack_options)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	int i;
 
-	argv_array_pushl(&pack_objects.args,
+	strvec_pushl(&pack_objects.args,
 			 "pack-objects",
 			 "--stdout", "--thin", "--delta-base-offset",
 			 NULL);
-	argv_array_pushv(&pack_objects.args, pack_options->argv);
+	strvec_pushv(&pack_objects.args, pack_options->argv);
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
 	pack_objects.git_cmd = 1;
@@ -321,11 +321,11 @@ static int compute_and_write_prerequisites(int bundle_fd,
 	FILE *rls_fout;
 	int i;
 
-	argv_array_pushl(&rls.args,
+	strvec_pushl(&rls.args,
 			 "rev-list", "--boundary", "--pretty=oneline",
 			 NULL);
 	for (i = 1; i < argc; i++)
-		argv_array_push(&rls.args, argv[i]);
+		strvec_push(&rls.args, argv[i]);
 	rls.out = -1;
 	rls.git_cmd = 1;
 	if (start_command(&rls))
@@ -449,7 +449,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 }
 
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct argv_array *pack_options)
+		  int argc, const char **argv, struct strvec *pack_options)
 {
 	struct lock_file lock = LOCK_INIT;
 	int bundle_fd = -1;
diff --git a/bundle.h b/bundle.h
index 2cf1270092..3f5c9ad220 100644
--- a/bundle.h
+++ b/bundle.h
@@ -21,7 +21,7 @@ struct bundle_header {
 int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct argv_array *pack_options);
+		  int argc, const char **argv, struct strvec *pack_options);
 int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
 #define BUNDLE_VERBOSE 1
 int unbundle(struct repository *r, struct bundle_header *header,
diff --git a/column.c b/column.c
index 4a38eed322..a79c2621b0 100644
--- a/column.c
+++ b/column.c
@@ -358,22 +358,22 @@ static struct child_process column_process = CHILD_PROCESS_INIT;
 
 int run_column_filter(int colopts, const struct column_options *opts)
 {
-	struct argv_array *argv;
+	struct strvec *argv;
 
 	if (fd_out != -1)
 		return -1;
 
 	child_process_init(&column_process);
 	argv = &column_process.args;
 
-	argv_array_push(argv, "column");
-	argv_array_pushf(argv, "--raw-mode=%d", colopts);
+	strvec_push(argv, "column");
+	strvec_pushf(argv, "--raw-mode=%d", colopts);
 	if (opts && opts->width)
-		argv_array_pushf(argv, "--width=%d", opts->width);
+		strvec_pushf(argv, "--width=%d", opts->width);
 	if (opts && opts->indent)
-		argv_array_pushf(argv, "--indent=%s", opts->indent);
+		strvec_pushf(argv, "--indent=%s", opts->indent);
 	if (opts && opts->padding)
-		argv_array_pushf(argv, "--padding=%d", opts->padding);
+		strvec_pushf(argv, "--padding=%d", opts->padding);
 
 	fflush(stdout);
 	column_process.in = -1;
diff --git a/commit.c b/commit.c
index 7128895c3a..a5176a25bd 100644
--- a/commit.c
+++ b/commit.c
@@ -1630,22 +1630,22 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    const char *name, ...)
 {
-	struct argv_array hook_env = ARGV_ARRAY_INIT;
+	struct strvec hook_env = STRVEC_INIT;
 	va_list args;
 	int ret;
 
-	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		argv_array_push(&hook_env, "GIT_EDITOR=:");
+		strvec_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
 	ret = run_hook_ve(hook_env.argv,name, args);
 	va_end(args);
-	argv_array_clear(&hook_env);
+	strvec_clear(&hook_env);
 
 	return ret;
 }
diff --git a/compat/mingw.c b/compat/mingw.c
index 8ee0b6408e..4454b3e67b 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -18,8 +18,8 @@ void open_in_gdb(void)
 	static struct child_process cp = CHILD_PROCESS_INIT;
 	extern char *_pgmptr;
 
-	argv_array_pushl(&cp.args, "mintty", "gdb", NULL);
-	argv_array_pushf(&cp.args, "--pid=%d", getpid());
+	strvec_pushl(&cp.args, "mintty", "gdb", NULL);
+	strvec_pushf(&cp.args, "--pid=%d", getpid());
 	cp.clean_on_exit = 1;
 	if (start_command(&cp) < 0)
 		die_errno("Could not start gdb");
diff --git a/compat/terminal.c b/compat/terminal.c
index 35bca03d14..43b73ddc75 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -86,9 +86,9 @@ static void restore_term(void)
 		if (stty_restore.nr == 0)
 			return;
 
-		argv_array_push(&cp.args, "stty");
+		strvec_push(&cp.args, "stty");
 		for (i = 0; i < stty_restore.nr; i++)
-			argv_array_push(&cp.args, stty_restore.items[i].string);
+			strvec_push(&cp.args, stty_restore.items[i].string);
 		run_command(&cp);
 		string_list_clear(&stty_restore, 0);
 		return;
@@ -107,25 +107,25 @@ static int disable_bits(DWORD bits)
 	if (use_stty) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 
-		argv_array_push(&cp.args, "stty");
+		strvec_push(&cp.args, "stty");
 
 		if (bits & ENABLE_LINE_INPUT) {
 			string_list_append(&stty_restore, "icanon");
-			argv_array_push(&cp.args, "-icanon");
+			strvec_push(&cp.args, "-icanon");
 		}
 
 		if (bits & ENABLE_ECHO_INPUT) {
 			string_list_append(&stty_restore, "echo");
-			argv_array_push(&cp.args, "-echo");
+			strvec_push(&cp.args, "-echo");
 		}
 
 		if (bits & ENABLE_PROCESSED_INPUT) {
 			string_list_append(&stty_restore, "-ignbrk");
 			string_list_append(&stty_restore, "intr");
 			string_list_append(&stty_restore, "^c");
-			argv_array_push(&cp.args, "ignbrk");
-			argv_array_push(&cp.args, "intr");
-			argv_array_push(&cp.args, "");
+			strvec_push(&cp.args, "ignbrk");
+			strvec_push(&cp.args, "intr");
+			strvec_push(&cp.args, "");
 		}
 
 		if (run_command(&cp) == 0)
@@ -273,7 +273,7 @@ static int is_known_escape_sequence(const char *sequence)
 		hashmap_init(&sequences, (hashmap_cmp_fn)sequence_entry_cmp,
 			     NULL, 0);
 
-		argv_array_pushl(&cp.args, "infocmp", "-L", "-1", NULL);
+		strvec_pushl(&cp.args, "infocmp", "-L", "-1", NULL);
 		if (pipe_command(&cp, NULL, 0, &buf, 0, NULL, 0))
 			strbuf_setlen(&buf, 0);
 
diff --git a/connect.c b/connect.c
index e0d5b9fee0..9b453fe792 100644
--- a/connect.c
+++ b/connect.c
@@ -17,7 +17,7 @@
 #include "alias.h"
 
 static char *server_capabilities_v1;
-static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;
+static struct strvec server_capabilities_v2 = STRVEC_INIT;
 static const char *next_server_feature_value(const char *feature, int *len, int *offset);
 
 static int check_ref(const char *name, unsigned int flags)
@@ -123,7 +123,7 @@ int server_supports_feature(const char *c, const char *feature,
 static void process_capabilities_v2(struct packet_reader *reader)
 {
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL)
-		argv_array_push(&server_capabilities_v2, reader->line);
+		strvec_push(&server_capabilities_v2, reader->line);
 
 	if (reader->status != PACKET_READ_FLUSH)
 		die(_("expected flush after capabilities"));
@@ -453,7 +453,7 @@ void check_stateless_delimiter(int stateless_rpc,
 
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
-			     const struct argv_array *ref_prefixes,
+			     const struct strvec *ref_prefixes,
 			     const struct string_list *server_options,
 			     int stateless_rpc)
 {
@@ -944,9 +944,9 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 
 	proxy = xmalloc(sizeof(*proxy));
 	child_process_init(proxy);
-	argv_array_push(&proxy->args, git_proxy_command);
-	argv_array_push(&proxy->args, host);
-	argv_array_push(&proxy->args, port);
+	strvec_push(&proxy->args, git_proxy_command);
+	strvec_push(&proxy->args, host);
+	strvec_push(&proxy->args, port);
 	proxy->in = -1;
 	proxy->out = -1;
 	if (start_command(proxy))
@@ -1199,15 +1199,15 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
  * Append the appropriate environment variables to `env` and options to
  * `args` for running ssh in Git's SSH-tunneled transport.
  */
-static void push_ssh_options(struct argv_array *args, struct argv_array *env,
+static void push_ssh_options(struct strvec *args, struct strvec *env,
 			     enum ssh_variant variant, const char *port,
 			     enum protocol_version version, int flags)
 {
 	if (variant == VARIANT_SSH &&
 	    version > 0) {
-		argv_array_push(args, "-o");
-		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
-		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
+		strvec_push(args, "-o");
+		strvec_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
+		strvec_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
 				 version);
 	}
 
@@ -1221,7 +1221,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 		case VARIANT_PLINK:
 		case VARIANT_PUTTY:
 		case VARIANT_TORTOISEPLINK:
-			argv_array_push(args, "-4");
+			strvec_push(args, "-4");
 		}
 	} else if (flags & CONNECT_IPV6) {
 		switch (variant) {
@@ -1233,12 +1233,12 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 		case VARIANT_PLINK:
 		case VARIANT_PUTTY:
 		case VARIANT_TORTOISEPLINK:
-			argv_array_push(args, "-6");
+			strvec_push(args, "-6");
 		}
 	}
 
 	if (variant == VARIANT_TORTOISEPLINK)
-		argv_array_push(args, "-batch");
+		strvec_push(args, "-batch");
 
 	if (port) {
 		switch (variant) {
@@ -1247,15 +1247,15 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 		case VARIANT_SIMPLE:
 			die(_("ssh variant 'simple' does not support setting port"));
 		case VARIANT_SSH:
-			argv_array_push(args, "-p");
+			strvec_push(args, "-p");
 			break;
 		case VARIANT_PLINK:
 		case VARIANT_PUTTY:
 		case VARIANT_TORTOISEPLINK:
-			argv_array_push(args, "-P");
+			strvec_push(args, "-P");
 		}
 
-		argv_array_push(args, port);
+		strvec_push(args, port);
 	}
 }
 
@@ -1293,18 +1293,18 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 		detect.use_shell = conn->use_shell;
 		detect.no_stdin = detect.no_stdout = detect.no_stderr = 1;
 
-		argv_array_push(&detect.args, ssh);
-		argv_array_push(&detect.args, "-G");
+		strvec_push(&detect.args, ssh);
+		strvec_push(&detect.args, "-G");
 		push_ssh_options(&detect.args, &detect.env_array,
 				 VARIANT_SSH, port, version, flags);
-		argv_array_push(&detect.args, ssh_host);
+		strvec_push(&detect.args, ssh_host);
 
 		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
 	}
 
-	argv_array_push(&conn->args, ssh);
+	strvec_push(&conn->args, ssh);
 	push_ssh_options(&conn->args, &conn->env_array, variant, port, version, flags);
-	argv_array_push(&conn->args, ssh_host);
+	strvec_push(&conn->args, ssh_host);
 }
 
 /*
@@ -1365,7 +1365,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		/* remove repo-local variables from the environment */
 		for (var = local_repo_env; *var; var++)
-			argv_array_push(&conn->env_array, *var);
+			strvec_push(&conn->env_array, *var);
 
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
@@ -1397,11 +1397,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 			transport_check_allowed("file");
 			conn->trace2_child_class = "transport/file";
 			if (version > 0) {
-				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
+				strvec_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
 						 version);
 			}
 		}
-		argv_array_push(&conn->args, cmd.buf);
+		strvec_push(&conn->args, cmd.buf);
 
 		if (start_command(conn))
 			die(_("unable to fork"));
diff --git a/connected.c b/connected.c
index 937b4bae38..96b47879d3 100644
--- a/connected.c
+++ b/connected.c
@@ -90,22 +90,22 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 
 no_promisor_pack_found:
 	if (opt->shallow_file) {
-		argv_array_push(&rev_list.args, "--shallow-file");
-		argv_array_push(&rev_list.args, opt->shallow_file);
+		strvec_push(&rev_list.args, "--shallow-file");
+		strvec_push(&rev_list.args, opt->shallow_file);
 	}
-	argv_array_push(&rev_list.args,"rev-list");
-	argv_array_push(&rev_list.args, "--objects");
-	argv_array_push(&rev_list.args, "--stdin");
+	strvec_push(&rev_list.args,"rev-list");
+	strvec_push(&rev_list.args, "--objects");
+	strvec_push(&rev_list.args, "--stdin");
 	if (has_promisor_remote())
-		argv_array_push(&rev_list.args, "--exclude-promisor-objects");
+		strvec_push(&rev_list.args, "--exclude-promisor-objects");
 	if (!opt->is_deepening_fetch) {
-		argv_array_push(&rev_list.args, "--not");
-		argv_array_push(&rev_list.args, "--all");
+		strvec_push(&rev_list.args, "--not");
+		strvec_push(&rev_list.args, "--all");
 	}
-	argv_array_push(&rev_list.args, "--quiet");
-	argv_array_push(&rev_list.args, "--alternate-refs");
+	strvec_push(&rev_list.args, "--quiet");
+	strvec_push(&rev_list.args, "--alternate-refs");
 	if (opt->progress)
-		argv_array_pushf(&rev_list.args, "--progress=%s",
+		strvec_pushf(&rev_list.args, "--progress=%s",
 				 _("Checking connectivity"));
 
 	rev_list.git_cmd = 1;
diff --git a/daemon.c b/daemon.c
index fd669ed3b4..cea5f5354f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -296,7 +296,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-typedef int (*daemon_service_fn)(const struct argv_array *env);
+typedef int (*daemon_service_fn)(const struct strvec *env);
 struct daemon_service {
 	const char *name;
 	const char *config_name;
@@ -377,7 +377,7 @@ static int run_access_hook(struct daemon_service *service, const char *dir,
 }
 
 static int run_service(const char *dir, struct daemon_service *service,
-		       struct hostinfo *hi, const struct argv_array *env)
+		       struct hostinfo *hi, const struct strvec *env)
 {
 	const char *path;
 	int enabled = service->enabled;
@@ -462,7 +462,7 @@ static void copy_to_log(int fd)
 
 static int run_service_command(struct child_process *cld)
 {
-	argv_array_push(&cld->args, ".");
+	strvec_push(&cld->args, ".");
 	cld->git_cmd = 1;
 	cld->err = -1;
 	if (start_command(cld))
@@ -476,33 +476,33 @@ static int run_service_command(struct child_process *cld)
 	return finish_command(cld);
 }
 
-static int upload_pack(const struct argv_array *env)
+static int upload_pack(const struct strvec *env)
 {
 	struct child_process cld = CHILD_PROCESS_INIT;
-	argv_array_pushl(&cld.args, "upload-pack", "--strict", NULL);
-	argv_array_pushf(&cld.args, "--timeout=%u", timeout);
+	strvec_pushl(&cld.args, "upload-pack", "--strict", NULL);
+	strvec_pushf(&cld.args, "--timeout=%u", timeout);
 
-	argv_array_pushv(&cld.env_array, env->argv);
+	strvec_pushv(&cld.env_array, env->argv);
 
 	return run_service_command(&cld);
 }
 
-static int upload_archive(const struct argv_array *env)
+static int upload_archive(const struct strvec *env)
 {
 	struct child_process cld = CHILD_PROCESS_INIT;
-	argv_array_push(&cld.args, "upload-archive");
+	strvec_push(&cld.args, "upload-archive");
 
-	argv_array_pushv(&cld.env_array, env->argv);
+	strvec_pushv(&cld.env_array, env->argv);
 
 	return run_service_command(&cld);
 }
 
-static int receive_pack(const struct argv_array *env)
+static int receive_pack(const struct strvec *env)
 {
 	struct child_process cld = CHILD_PROCESS_INIT;
-	argv_array_push(&cld.args, "receive-pack");
+	strvec_push(&cld.args, "receive-pack");
 
-	argv_array_pushv(&cld.env_array, env->argv);
+	strvec_pushv(&cld.env_array, env->argv);
 
 	return run_service_command(&cld);
 }
@@ -633,7 +633,7 @@ static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 	return extra_args;
 }
 
-static void parse_extra_args(struct hostinfo *hi, struct argv_array *env,
+static void parse_extra_args(struct hostinfo *hi, struct strvec *env,
 			     char *extra_args, int buflen)
 {
 	const char *end = extra_args + buflen;
@@ -664,7 +664,7 @@ static void parse_extra_args(struct hostinfo *hi, struct argv_array *env,
 
 	if (git_protocol.len > 0) {
 		loginfo("Extended attribute \"protocol\": %s", git_protocol.buf);
-		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
+		strvec_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
 				 git_protocol.buf);
 	}
 	strbuf_release(&git_protocol);
@@ -761,7 +761,7 @@ static int execute(void)
 	int pktlen, len, i;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 	struct hostinfo hi;
-	struct argv_array env = ARGV_ARRAY_INIT;
+	struct strvec env = STRVEC_INIT;
 
 	hostinfo_init(&hi);
 
@@ -794,13 +794,13 @@ static int execute(void)
 			 */
 			int rc = run_service(arg, s, &hi, &env);
 			hostinfo_clear(&hi);
-			argv_array_clear(&env);
+			strvec_clear(&env);
 			return rc;
 		}
 	}
 
 	hostinfo_clear(&hi);
-	argv_array_clear(&env);
+	strvec_clear(&env);
 	logerror("Protocol error: '%s'", line);
 	return -1;
 }
@@ -893,7 +893,7 @@ static void check_dead_children(void)
 			cradle = &blanket->next;
 }
 
-static struct argv_array cld_argv = ARGV_ARRAY_INIT;
+static struct strvec cld_argv = STRVEC_INIT;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child_process cld = CHILD_PROCESS_INIT;
@@ -913,16 +913,16 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		char buf[128] = "";
 		struct sockaddr_in *sin_addr = (void *) addr;
 		inet_ntop(addr->sa_family, &sin_addr->sin_addr, buf, sizeof(buf));
-		argv_array_pushf(&cld.env_array, "REMOTE_ADDR=%s", buf);
-		argv_array_pushf(&cld.env_array, "REMOTE_PORT=%d",
+		strvec_pushf(&cld.env_array, "REMOTE_ADDR=%s", buf);
+		strvec_pushf(&cld.env_array, "REMOTE_PORT=%d",
 				 ntohs(sin_addr->sin_port));
 #ifndef NO_IPV6
 	} else if (addr->sa_family == AF_INET6) {
 		char buf[128] = "";
 		struct sockaddr_in6 *sin6_addr = (void *) addr;
 		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(buf));
-		argv_array_pushf(&cld.env_array, "REMOTE_ADDR=[%s]", buf);
-		argv_array_pushf(&cld.env_array, "REMOTE_PORT=%d",
+		strvec_pushf(&cld.env_array, "REMOTE_ADDR=[%s]", buf);
+		strvec_pushf(&cld.env_array, "REMOTE_PORT=%d",
 				 ntohs(sin6_addr->sin6_port));
 #endif
 	}
@@ -1476,10 +1476,10 @@ int cmd_main(int argc, const char **argv)
 		write_file(pid_file, "%"PRIuMAX, (uintmax_t) getpid());
 
 	/* prepare argv for serving-processes */
-	argv_array_push(&cld_argv, argv[0]); /* git-daemon */
-	argv_array_push(&cld_argv, "--serve");
+	strvec_push(&cld_argv, argv[0]); /* git-daemon */
+	strvec_push(&cld_argv, "--serve");
 	for (i = 1; i < argc; ++i)
-		argv_array_push(&cld_argv, argv[i]);
+		strvec_push(&cld_argv, argv[i]);
 
 	return serve(&listen_addr, listen_port, cred);
 }
diff --git a/diff.c b/diff.c
index ee008155e4..f1a3758922 100644
--- a/diff.c
+++ b/diff.c
@@ -4192,14 +4192,14 @@ static struct diff_tempfile *prepare_temp_file(struct repository *r,
 }
 
 static void add_external_diff_name(struct repository *r,
-				   struct argv_array *argv,
+				   struct strvec *argv,
 				   const char *name,
 				   struct diff_filespec *df)
 {
 	struct diff_tempfile *temp = prepare_temp_file(r, name, df);
-	argv_array_push(argv, temp->name);
-	argv_array_push(argv, temp->hex);
-	argv_array_push(argv, temp->mode);
+	strvec_push(argv, temp->name);
+	strvec_push(argv, temp->hex);
+	strvec_push(argv, temp->mode);
 }
 
 /* An external diff command takes:
@@ -4216,35 +4216,35 @@ static void run_external_diff(const char *pgm,
 			      const char *xfrm_msg,
 			      struct diff_options *o)
 {
-	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct argv_array env = ARGV_ARRAY_INIT;
+	struct strvec argv = STRVEC_INIT;
+	struct strvec env = STRVEC_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
-	argv_array_push(&argv, pgm);
-	argv_array_push(&argv, name);
+	strvec_push(&argv, pgm);
+	strvec_push(&argv, name);
 
 	if (one && two) {
 		add_external_diff_name(o->repo, &argv, name, one);
 		if (!other)
 			add_external_diff_name(o->repo, &argv, name, two);
 		else {
 			add_external_diff_name(o->repo, &argv, other, two);
-			argv_array_push(&argv, other);
-			argv_array_push(&argv, xfrm_msg);
+			strvec_push(&argv, other);
+			strvec_push(&argv, xfrm_msg);
 		}
 	}
 
-	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
-	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
+	strvec_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
+	strvec_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
 
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 	if (run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv))
 		die(_("external diff died, stopping at %s"), name);
 
 	remove_tempfile();
-	argv_array_clear(&argv);
-	argv_array_clear(&env);
+	strvec_clear(&argv);
+	strvec_clear(&env);
 }
 
 static int similarity_index(struct diff_filepair *p)
diff --git a/environment.c b/environment.c
index 75fe5f4c56..00fe20e496 100644
--- a/environment.c
+++ b/environment.c
@@ -156,14 +156,14 @@ static char *expand_namespace(const char *raw_namespace)
  * Wrapper of getenv() that returns a strdup value. This value is kept
  * in argv to be freed later.
  */
-static const char *getenv_safe(struct argv_array *argv, const char *name)
+static const char *getenv_safe(struct strvec *argv, const char *name)
 {
 	const char *value = getenv(name);
 
 	if (!value)
 		return NULL;
 
-	argv_array_push(argv, value);
+	strvec_push(argv, value);
 	return argv->argv[argv->argc - 1];
 }
 
@@ -172,15 +172,15 @@ void setup_git_env(const char *git_dir)
 	const char *shallow_file;
 	const char *replace_ref_base;
 	struct set_gitdir_args args = { NULL };
-	struct argv_array to_free = ARGV_ARRAY_INIT;
+	struct strvec to_free = STRVEC_INIT;
 
 	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
 	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
 	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
 	repo_set_gitdir(the_repository, git_dir, &args);
-	argv_array_clear(&to_free);
+	strvec_clear(&to_free);
 
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		read_replace_refs = 0;
diff --git a/exec-cmd.c b/exec-cmd.c
index bb24c2f3bc..0f8e888424 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -320,16 +320,16 @@ void setup_path(void)
 	strbuf_release(&new_path);
 }
 
-const char **prepare_git_cmd(struct argv_array *out, const char **argv)
+const char **prepare_git_cmd(struct strvec *out, const char **argv)
 {
-	argv_array_push(out, "git");
-	argv_array_pushv(out, argv);
+	strvec_push(out, "git");
+	strvec_pushv(out, argv);
 	return out->argv;
 }
 
 int execv_git_cmd(const char **argv)
 {
-	struct argv_array nargv = ARGV_ARRAY_INIT;
+	struct strvec nargv = STRVEC_INIT;
 
 	prepare_git_cmd(&nargv, argv);
 	trace_argv_printf(nargv.argv, "trace: exec:");
@@ -339,7 +339,7 @@ int execv_git_cmd(const char **argv)
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
-	argv_array_clear(&nargv);
+	strvec_clear(&nargv);
 	return -1;
 }
 
diff --git a/fast-import.c b/fast-import.c
index 0dfa14dc8c..ce47794db6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -843,9 +843,9 @@ static int loosen_small_pack(const struct packed_git *p)
 	unpack.in = p->pack_fd;
 	unpack.git_cmd = 1;
 	unpack.stdout_to_stderr = 1;
-	argv_array_push(&unpack.args, "unpack-objects");
+	strvec_push(&unpack.args, "unpack-objects");
 	if (!show_stats)
-		argv_array_push(&unpack.args, "-q");
+		strvec_push(&unpack.args, "-q");
 
 	return run_command(&unpack);
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index 80fb3bd899..7aa5dfbdad 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -835,30 +835,30 @@ static int get_pack(struct fetch_pack_args *args,
 	}
 
 	if (alternate_shallow_file) {
-		argv_array_push(&cmd.args, "--shallow-file");
-		argv_array_push(&cmd.args, alternate_shallow_file);
+		strvec_push(&cmd.args, "--shallow-file");
+		strvec_push(&cmd.args, alternate_shallow_file);
 	}
 
 	if (do_keep || args->from_promisor) {
 		if (pack_lockfiles)
 			cmd.out = -1;
 		cmd_name = "index-pack";
-		argv_array_push(&cmd.args, cmd_name);
-		argv_array_push(&cmd.args, "--stdin");
+		strvec_push(&cmd.args, cmd_name);
+		strvec_push(&cmd.args, "--stdin");
 		if (!args->quiet && !args->no_progress)
-			argv_array_push(&cmd.args, "-v");
+			strvec_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
-			argv_array_push(&cmd.args, "--fix-thin");
+			strvec_push(&cmd.args, "--fix-thin");
 		if (do_keep && (args->lock_pack || unpack_limit)) {
 			char hostname[HOST_NAME_MAX + 1];
 			if (xgethostname(hostname, sizeof(hostname)))
 				xsnprintf(hostname, sizeof(hostname), "localhost");
-			argv_array_pushf(&cmd.args,
+			strvec_pushf(&cmd.args,
 					"--keep=fetch-pack %"PRIuMAX " on %s",
 					(uintmax_t)getpid(), hostname);
 		}
 		if (only_packfile && args->check_self_contained_and_connected)
-			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
+			strvec_push(&cmd.args, "--check-self-contained-and-connected");
 		else
 			/*
 			 * We cannot perform any connectivity checks because
@@ -873,18 +873,18 @@ static int get_pack(struct fetch_pack_args *args,
 		 * us.
 		 */
 		if (!(do_keep && pack_lockfiles) && args->from_promisor)
-			argv_array_push(&cmd.args, "--promisor");
+			strvec_push(&cmd.args, "--promisor");
 	}
 	else {
 		cmd_name = "unpack-objects";
-		argv_array_push(&cmd.args, cmd_name);
+		strvec_push(&cmd.args, cmd_name);
 		if (args->quiet || args->no_progress)
-			argv_array_push(&cmd.args, "-q");
+			strvec_push(&cmd.args, "-q");
 		args->check_self_contained_and_connected = 0;
 	}
 
 	if (pass_header)
-		argv_array_pushf(&cmd.args, "--pack_header=%"PRIu32",%"PRIu32,
+		strvec_pushf(&cmd.args, "--pack_header=%"PRIu32",%"PRIu32,
 				 ntohl(header.hdr_version),
 				 ntohl(header.hdr_entries));
 	if (fetch_fsck_objects >= 0
@@ -898,9 +898,9 @@ static int get_pack(struct fetch_pack_args *args,
 			 * checks both broken objects and links, but we only
 			 * want to check for broken objects.
 			 */
-			argv_array_push(&cmd.args, "--fsck-objects");
+			strvec_push(&cmd.args, "--fsck-objects");
 		else
-			argv_array_pushf(&cmd.args, "--strict%s",
+			strvec_pushf(&cmd.args, "--strict%s",
 					 fsck_msg_types.buf);
 	}
 
@@ -1652,11 +1652,11 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		const char *uri = packfile_uris.items[i].string +
 			the_hash_algo->hexsz + 1;
 
-		argv_array_push(&cmd.args, "http-fetch");
-		argv_array_pushf(&cmd.args, "--packfile=%.*s",
+		strvec_push(&cmd.args, "http-fetch");
+		strvec_pushf(&cmd.args, "--packfile=%.*s",
 				 (int) the_hash_algo->hexsz,
 				 packfile_uris.items[i].string);
-		argv_array_push(&cmd.args, uri);
+		strvec_push(&cmd.args, uri);
 		cmd.git_cmd = 1;
 		cmd.no_stdin = 1;
 		cmd.out = -1;
diff --git a/fsmonitor.c b/fsmonitor.c
index 932bd9012d..e3c982e814 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -146,9 +146,9 @@ static int query_fsmonitor(int version, const char *last_update, struct strbuf *
 	if (!core_fsmonitor)
 		return -1;
 
-	argv_array_push(&cp.args, core_fsmonitor);
-	argv_array_pushf(&cp.args, "%d", version);
-	argv_array_pushf(&cp.args, "%s", last_update);
+	strvec_push(&cp.args, core_fsmonitor);
+	strvec_pushf(&cp.args, "%d", version);
+	strvec_pushf(&cp.args, "%s", last_update);
 	cp.use_shell = 1;
 	cp.dir = get_git_work_tree();
 
diff --git a/git.c b/git.c
index 6cd887bb0c..258035cfb1 100644
--- a/git.c
+++ b/git.c
@@ -349,8 +349,8 @@ static int handle_alias(int *argcp, const char ***argv)
 			child.clean_on_exit = 1;
 			child.wait_after_clean = 1;
 			child.trace2_child_class = "shell_alias";
-			argv_array_push(&child.args, alias_string + 1);
-			argv_array_pushv(&child.args, (*argv) + 1);
+			strvec_push(&child.args, alias_string + 1);
+			strvec_pushv(&child.args, (*argv) + 1);
 
 			trace2_cmd_alias(alias_command, child.args.argv);
 			trace2_cmd_list_config();
@@ -646,7 +646,7 @@ static void strip_extension(const char **argv)
 
 static void handle_builtin(int argc, const char **argv)
 {
-	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strvec args = STRVEC_INIT;
 	const char *cmd;
 	struct cmd_struct *builtin;
 
@@ -661,9 +661,9 @@ static void handle_builtin(int argc, const char **argv)
 		argv[0] = cmd = "help";
 
 		for (i = 0; i < argc; i++) {
-			argv_array_push(&args, argv[i]);
+			strvec_push(&args, argv[i]);
 			if (!i)
-				argv_array_push(&args, "--exclude-guides");
+				strvec_push(&args, "--exclude-guides");
 		}
 
 		argc++;
@@ -673,7 +673,7 @@ static void handle_builtin(int argc, const char **argv)
 	builtin = get_builtin(cmd);
 	if (builtin)
 		exit(run_builtin(builtin, argc, argv));
-	argv_array_clear(&args);
+	strvec_clear(&args);
 }
 
 static void execv_dashed_external(const char **argv)
@@ -688,8 +688,8 @@ static void execv_dashed_external(const char **argv)
 		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
 
-	argv_array_pushf(&cmd.args, "git-%s", argv[0]);
-	argv_array_pushv(&cmd.args, argv + 1);
+	strvec_pushf(&cmd.args, "git-%s", argv[0]);
+	strvec_pushv(&cmd.args, argv + 1);
 	cmd.clean_on_exit = 1;
 	cmd.wait_after_clean = 1;
 	cmd.silent_exec_failure = 1;
@@ -741,7 +741,7 @@ static int run_argv(int *argcp, const char ***argv)
 		if (!done_alias)
 			handle_builtin(*argcp, *argv);
 		else if (get_builtin(**argv)) {
-			struct argv_array args = ARGV_ARRAY_INIT;
+			struct strvec args = STRVEC_INIT;
 			int i;
 
 			/*
@@ -758,9 +758,9 @@ static int run_argv(int *argcp, const char ***argv)
 
 			commit_pager_choice();
 
-			argv_array_push(&args, "git");
+			strvec_push(&args, "git");
 			for (i = 0; i < *argcp; i++)
-				argv_array_push(&args, (*argv)[i]);
+				strvec_push(&args, (*argv)[i]);
 
 			trace_argv_printf(args.argv, "trace: exec:");
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 2d538bcd6e..cf56fe838f 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -282,9 +282,9 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
 	if (!fmt)
 		BUG("bad signature '%s'", signature);
 
-	argv_array_push(&gpg.args, fmt->program);
-	argv_array_pushv(&gpg.args, fmt->verify_args);
-	argv_array_pushl(&gpg.args,
+	strvec_push(&gpg.args, fmt->program);
+	strvec_pushv(&gpg.args, fmt->verify_args);
+	strvec_pushl(&gpg.args,
 			 "--status-fd=1",
 			 "--verify", temp->filename.buf, "-",
 			 NULL);
@@ -434,7 +434,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	size_t i, j, bottom;
 	struct strbuf gpg_status = STRBUF_INIT;
 
-	argv_array_pushl(&gpg.args,
+	strvec_pushl(&gpg.args,
 			 use_format->program,
 			 "--status-fd=2",
 			 "-bsau", signing_key,
diff --git a/graph.c b/graph.c
index 96af8f605a..09c9cc968c 100644
--- a/graph.c
+++ b/graph.c
@@ -82,7 +82,7 @@ static void graph_show_line_prefix(const struct diff_options *diffopt)
 static const char **column_colors;
 static unsigned short column_colors_max;
 
-static void parse_graph_colors_config(struct argv_array *colors, const char *string)
+static void parse_graph_colors_config(struct strvec *colors, const char *string)
 {
 	const char *end, *start;
 
@@ -93,13 +93,13 @@ static void parse_graph_colors_config(struct argv_array *colors, const char *str
 		char color[COLOR_MAXLEN];
 
 		if (!color_parse_mem(start, comma - start, color))
-			argv_array_push(colors, color);
+			strvec_push(colors, color);
 		else
 			warning(_("ignore invalid color '%.*s' in log.graphColors"),
 				(int)(comma - start), start);
 		start = comma + 1;
 	}
-	argv_array_push(colors, GIT_COLOR_RESET);
+	strvec_push(colors, GIT_COLOR_RESET);
 }
 
 void graph_set_column_colors(const char **colors, unsigned short colors_max)
@@ -350,8 +350,8 @@ struct git_graph *graph_init(struct rev_info *opt)
 			graph_set_column_colors(column_colors_ansi,
 						column_colors_ansi_max);
 		} else {
-			static struct argv_array custom_colors = ARGV_ARRAY_INIT;
-			argv_array_clear(&custom_colors);
+			static struct strvec custom_colors = STRVEC_INIT;
+			strvec_clear(&custom_colors);
 			parse_graph_colors_config(&custom_colors, string);
 			free(string);
 			/* graph_set_column_colors takes a max-index, not a count */
diff --git a/http-backend.c b/http-backend.c
index 6a42badf33..92fd62f73f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -477,9 +477,9 @@ static void run_service(const char **argv, int buffer_input)
 		host = "(none)";
 
 	if (!getenv("GIT_COMMITTER_NAME"))
-		argv_array_pushf(&cld.env_array, "GIT_COMMITTER_NAME=%s", user);
+		strvec_pushf(&cld.env_array, "GIT_COMMITTER_NAME=%s", user);
 	if (!getenv("GIT_COMMITTER_EMAIL"))
-		argv_array_pushf(&cld.env_array,
+		strvec_pushf(&cld.env_array,
 				 "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
 
 	cld.argv = argv;
diff --git a/http-push.c b/http-push.c
index 3a47921cc3..e1deea6fe4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1846,7 +1846,7 @@ int cmd_main(int argc, const char **argv)
 
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
-		struct argv_array commit_argv = ARGV_ARRAY_INIT;
+		struct strvec commit_argv = STRVEC_INIT;
 
 		if (!ref->peer_ref)
 			continue;
@@ -1924,11 +1924,11 @@ int cmd_main(int argc, const char **argv)
 		}
 
 		/* Set up revision info for this refspec */
-		argv_array_push(&commit_argv, ""); /* ignored */
-		argv_array_push(&commit_argv, "--objects");
-		argv_array_push(&commit_argv, oid_to_hex(&ref->new_oid));
+		strvec_push(&commit_argv, ""); /* ignored */
+		strvec_push(&commit_argv, "--objects");
+		strvec_push(&commit_argv, oid_to_hex(&ref->new_oid));
 		if (!push_all && !is_null_oid(&ref->old_oid))
-			argv_array_pushf(&commit_argv, "^%s",
+			strvec_pushf(&commit_argv, "^%s",
 					 oid_to_hex(&ref->old_oid));
 		repo_init_revisions(the_repository, &revs, setup_git_directory());
 		setup_revisions(commit_argv.argc, commit_argv.argv, &revs, NULL);
@@ -1961,7 +1961,7 @@ int cmd_main(int argc, const char **argv)
 			printf("%s %s\n", !rc ? "ok" : "error", ref->name);
 		unlock_remote(ref_lock);
 		check_locks();
-		argv_array_clear(&commit_argv);
+		strvec_clear(&commit_argv);
 	}
 
 	/* Update remote server info if appropriate */
diff --git a/http.c b/http.c
index 3b12843a5b..268a1e9744 100644
--- a/http.c
+++ b/http.c
@@ -2270,12 +2270,12 @@ int finish_http_pack_request(struct http_pack_request *preq)
 
 	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
 
-	argv_array_push(&ip.args, "index-pack");
-	argv_array_push(&ip.args, "--stdin");
+	strvec_push(&ip.args, "index-pack");
+	strvec_push(&ip.args, "--stdin");
 	ip.git_cmd = 1;
 	ip.in = tmpfile_fd;
 	if (preq->generate_keep) {
-		argv_array_pushf(&ip.args, "--keep=git %"PRIuMAX,
+		strvec_pushf(&ip.args, "--keep=git %"PRIuMAX,
 				 (uintmax_t)getpid());
 		ip.out = 0;
 	} else {
diff --git a/imap-send.c b/imap-send.c
index 52737546f3..5764dd812c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -976,7 +976,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
 
 		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
-		argv_array_push(&tunnel.args, srvc->tunnel);
+		strvec_push(&tunnel.args, srvc->tunnel);
 		tunnel.use_shell = 1;
 		tunnel.in = -1;
 		tunnel.out = -1;
diff --git a/line-log.c b/line-log.c
index 05d077b8e7..bf73ea95ac 100644
--- a/line-log.c
+++ b/line-log.c
@@ -758,12 +758,12 @@ static void parse_pathspec_from_ranges(struct pathspec *pathspec,
 				       struct line_log_data *range)
 {
 	struct line_log_data *r;
-	struct argv_array array = ARGV_ARRAY_INIT;
+	struct strvec array = STRVEC_INIT;
 	const char **paths;
 
 	for (r = range; r; r = r->next)
-		argv_array_push(&array, r->path);
-	paths = argv_array_detach(&array);
+		strvec_push(&array, r->path);
+	paths = strvec_detach(&array);
 
 	parse_pathspec(pathspec, 0, PATHSPEC_PREFER_FULL, "", paths);
 	/* strings are now owned by pathspec */
diff --git a/ls-refs.c b/ls-refs.c
index 98fb19092a..8192c949f4 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -11,7 +11,7 @@
  * Check if one of the prefixes is a prefix of the ref.
  * If no prefixes were provided, all refs match.
  */
-static int ref_match(const struct argv_array *prefixes, const char *refname)
+static int ref_match(const struct strvec *prefixes, const char *refname)
 {
 	int i;
 
@@ -31,7 +31,7 @@ static int ref_match(const struct argv_array *prefixes, const char *refname)
 struct ls_refs_data {
 	unsigned peel;
 	unsigned symrefs;
-	struct argv_array prefixes;
+	struct strvec prefixes;
 };
 
 static int send_ref(const char *refname, const struct object_id *oid,
@@ -84,7 +84,7 @@ static int ls_refs_config(const char *var, const char *value, void *data)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-int ls_refs(struct repository *r, struct argv_array *keys,
+int ls_refs(struct repository *r, struct strvec *keys,
 	    struct packet_reader *request)
 {
 	struct ls_refs_data data;
@@ -102,7 +102,7 @@ int ls_refs(struct repository *r, struct argv_array *keys,
 		else if (!strcmp("symrefs", arg))
 			data.symrefs = 1;
 		else if (skip_prefix(arg, "ref-prefix ", &out))
-			argv_array_push(&data.prefixes, out);
+			strvec_push(&data.prefixes, out);
 	}
 
 	if (request->status != PACKET_READ_FLUSH)
@@ -111,6 +111,6 @@ int ls_refs(struct repository *r, struct argv_array *keys,
 	head_ref_namespaced(send_ref, &data);
 	for_each_namespaced_ref(send_ref, &data);
 	packet_flush(1);
-	argv_array_clear(&data.prefixes);
+	strvec_clear(&data.prefixes);
 	return 0;
 }
-- 
2.28.0.rc2.475.g53c7e1c7f4

