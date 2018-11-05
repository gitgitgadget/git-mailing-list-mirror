Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE63B1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbeKEQD5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:03:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:40426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729000AbeKEQD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:03:57 -0500
Received: (qmail 22047 invoked by uid 109); 5 Nov 2018 06:45:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:45:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17276 invoked by uid 111); 5 Nov 2018 06:45:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:45:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:45:42 -0500
Date:   Mon, 5 Nov 2018 01:45:42 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/13] assert NOARG/NONEG behavior of parse-options callbacks
Message-ID: <20181105064542.GM25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we define a parse-options callback, the flags we put in the option
struct must match what the callback expects. For example, a callback
which does not handle the "unset" parameter should only be used with
PARSE_OPT_NONEG. But since the callback and the option struct are not
defined next to each other, it's easy to get this wrong (as earlier
patches in this series show).

Fortunately, the compiler can help us here: compiling with
-Wunused-parameters can show us which callbacks ignore their "unset"
parameters (and likewise, ones that ignore "arg" expect to be triggered
with PARSE_OPT_NOARG).

But after we've inspected a callback and determined that all of its
callers use the right flags, what do we do next? We'd like to silence
the compiler warning, but do so in a way that will catch any wrong calls
in the future.

We can do that by actually checking those variables and asserting that
they match our expectations. Because this is such a common pattern,
we'll introduce some helper macros. The resulting messages aren't
as descriptive as we could make them, but the file/line information from
BUG() is enough to identify the problem (and anyway, the point is that
these should never be seen).

Each of the annotated callbacks in this patch triggers
-Wunused-parameters, and was manually inspected to make sure all callers
use the correct options (so none of these BUGs should be triggerable).

Signed-off-by: Jeff King <peff@peff.net>
---
 apply.c                       | 18 ++++++++++++++++++
 builtin/blame.c               |  4 ++++
 builtin/cat-file.c            |  2 ++
 builtin/checkout-index.c      |  2 ++
 builtin/clean.c               |  1 +
 builtin/commit.c              |  3 +++
 builtin/fetch.c               |  2 ++
 builtin/grep.c                | 14 +++++++++++++-
 builtin/init-db.c             |  1 +
 builtin/interpret-trailers.c  |  2 ++
 builtin/log.c                 | 10 ++++++++++
 builtin/ls-files.c            |  7 +++++++
 builtin/merge-file.c          |  2 ++
 builtin/merge.c               |  1 +
 builtin/notes.c               |  7 +++++++
 builtin/pack-objects.c        |  3 +++
 builtin/read-tree.c           |  3 +++
 builtin/rebase.c              |  6 ++++++
 builtin/show-branch.c         |  1 +
 builtin/show-ref.c            |  1 +
 builtin/tag.c                 |  2 ++
 builtin/update-index.c        | 21 +++++++++++++++++++--
 parse-options-cb.c            |  7 +++++++
 parse-options.h               | 14 ++++++++++++++
 ref-filter.c                  |  2 ++
 t/helper/test-parse-options.c |  1 +
 26 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index c4c9f849b1..3746310cef 100644
--- a/apply.c
+++ b/apply.c
@@ -4772,6 +4772,9 @@ static int apply_option_parse_exclude(const struct option *opt,
 				      const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
 	add_name_limit(state, arg, 1);
 	return 0;
 }
@@ -4780,6 +4783,9 @@ static int apply_option_parse_include(const struct option *opt,
 				      const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
 	add_name_limit(state, arg, 0);
 	state->has_include = 1;
 	return 0;
@@ -4790,6 +4796,9 @@ static int apply_option_parse_p(const struct option *opt,
 				int unset)
 {
 	struct apply_state *state = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
 	state->p_value = atoi(arg);
 	state->p_value_known = 1;
 	return 0;
@@ -4799,6 +4808,9 @@ static int apply_option_parse_space_change(const struct option *opt,
 					   const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+
 	if (unset)
 		state->ws_ignore_action = ignore_ws_none;
 	else
@@ -4810,6 +4822,9 @@ static int apply_option_parse_whitespace(const struct option *opt,
 					 const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
 	state->whitespace_option = arg;
 	if (parse_whitespace_option(state, arg))
 		return -1;
@@ -4820,6 +4835,9 @@ static int apply_option_parse_directory(const struct option *opt,
 					const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
 	strbuf_reset(&state->root);
 	strbuf_addstr(&state->root, arg);
 	strbuf_complete(&state->root, '/');
diff --git a/builtin/blame.c b/builtin/blame.c
index a443af9ee9..06a7163ffe 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -732,6 +732,8 @@ static int blame_copy_callback(const struct option *option, const char *arg, int
 {
 	int *opt = option->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	/*
 	 * -C enables copy from removed files;
 	 * -C -C enables copy from existing files, but only
@@ -754,6 +756,8 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 {
 	int *opt = option->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	*opt |= PICKAXE_BLAME_MOVE;
 
 	if (arg)
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0f6b692df6..1cdd357d52 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -595,6 +595,8 @@ static int batch_option_callback(const struct option *opt,
 {
 	struct batch_options *bo = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (bo->enabled) {
 		return error(_("only one batch option may be specified"));
 	}
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 88b86c8d9f..eb74774cbc 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -132,6 +132,8 @@ static const char * const builtin_checkout_index_usage[] = {
 static int option_parse_stage(const struct option *opt,
 			      const char *arg, int unset)
 {
+	BUG_ON_OPT_NEG(unset);
+
 	if (!strcmp(arg, "all")) {
 		to_tempfile = 1;
 		checkout_stage = CHECKOUT_ALL;
diff --git a/builtin/clean.c b/builtin/clean.c
index 8d9a7dc206..bbcdeb2d9e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -140,6 +140,7 @@ static void clean_print_color(enum color_clean ix)
 static int exclude_cb(const struct option *opt, const char *arg, int unset)
 {
 	struct string_list *exclude_list = opt->value;
+	BUG_ON_OPT_NEG(unset);
 	string_list_append(exclude_list, arg);
 	return 0;
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index 4d7754ca43..500f793fa6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -161,6 +161,9 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 static int opt_parse_rename_score(const struct option *opt, const char *arg, int unset)
 {
 	const char **value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
 	if (arg != NULL && *arg == '=')
 		arg = arg + 1;
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8f7249f2b1..354ed8bdef 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -98,6 +98,8 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
 {
+	BUG_ON_OPT_NEG(unset);
+
 	/*
 	 * "git fetch --refmap='' origin foo"
 	 * can be used to tell the command not to store anywhere
diff --git a/builtin/grep.c b/builtin/grep.c
index d8508ddf79..33c8b61595 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -712,11 +712,14 @@ static int context_callback(const struct option *opt, const char *arg,
 static int file_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
-	int from_stdin = !strcmp(arg, "-");
+	int from_stdin;
 	FILE *patterns;
 	int lno = 0;
 	struct strbuf sb = STRBUF_INIT;
 
+	BUG_ON_OPT_NEG(unset);
+
+	from_stdin = !strcmp(arg, "-");
 	patterns = from_stdin ? stdin : fopen(arg, "r");
 	if (!patterns)
 		die_errno(_("cannot open '%s'"), arg);
@@ -737,6 +740,8 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 static int not_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	append_grep_pattern(grep_opt, "--not", "command line", 0, GREP_NOT);
 	return 0;
 }
@@ -744,6 +749,8 @@ static int not_callback(const struct option *opt, const char *arg, int unset)
 static int and_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	append_grep_pattern(grep_opt, "--and", "command line", 0, GREP_AND);
 	return 0;
 }
@@ -751,6 +758,8 @@ static int and_callback(const struct option *opt, const char *arg, int unset)
 static int open_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	append_grep_pattern(grep_opt, "(", "command line", 0, GREP_OPEN_PAREN);
 	return 0;
 }
@@ -758,6 +767,8 @@ static int open_callback(const struct option *opt, const char *arg, int unset)
 static int close_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	append_grep_pattern(grep_opt, ")", "command line", 0, GREP_CLOSE_PAREN);
 	return 0;
 }
@@ -766,6 +777,7 @@ static int pattern_callback(const struct option *opt, const char *arg,
 			    int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
+	BUG_ON_OPT_NEG(unset);
 	append_grep_pattern(grep_opt, arg, "-e option", 0, GREP_PATTERN);
 	return 0;
 }
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 12ddda7e7b..41faffd28d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -451,6 +451,7 @@ static int guess_repository_type(const char *git_dir)
 
 static int shared_callback(const struct option *opt, const char *arg, int unset)
 {
+	BUG_ON_OPT_NEG(unset);
 	*((int *) opt->value) = (arg) ? git_config_perm("arg", arg) : PERM_GROUP;
 	return 0;
 }
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 4b87e0dd2e..8ae40dec47 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -80,6 +80,8 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 	v->only_trailers = 1;
 	v->only_input = 1;
 	v->unfold = 1;
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	return 0;
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 41188e723c..9f2d987294 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -107,6 +107,8 @@ static int log_line_range_callback(const struct option *option, const char *arg,
 {
 	struct line_opt_callback_data *data = option->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (!arg)
 		return -1;
 
@@ -1151,6 +1153,8 @@ static int keep_subject = 0;
 
 static int keep_callback(const struct option *opt, const char *arg, int unset)
 {
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	((struct rev_info *)opt->value)->total = -1;
 	keep_subject = 1;
 	return 0;
@@ -1161,6 +1165,7 @@ static int subject_prefix = 0;
 static int subject_prefix_callback(const struct option *opt, const char *arg,
 			    int unset)
 {
+	BUG_ON_OPT_NEG(unset);
 	subject_prefix = 1;
 	((struct rev_info *)opt->value)->subject_prefix = arg;
 	return 0;
@@ -1168,6 +1173,8 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
 
 static int rfc_callback(const struct option *opt, const char *arg, int unset)
 {
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	return subject_prefix_callback(opt, "RFC PATCH", unset);
 }
 
@@ -1176,6 +1183,7 @@ static int numbered_cmdline_opt = 0;
 static int numbered_callback(const struct option *opt, const char *arg,
 			     int unset)
 {
+	BUG_ON_OPT_ARG(arg);
 	*(int *)opt->value = numbered_cmdline_opt = unset ? 0 : 1;
 	if (unset)
 		auto_number =  0;
@@ -1185,6 +1193,7 @@ static int numbered_callback(const struct option *opt, const char *arg,
 static int no_numbered_callback(const struct option *opt, const char *arg,
 				int unset)
 {
+	BUG_ON_OPT_NEG(unset);
 	return numbered_callback(opt, arg, 1);
 }
 
@@ -1192,6 +1201,7 @@ static int output_directory_callback(const struct option *opt, const char *arg,
 			      int unset)
 {
 	const char **dir = (const char **)opt->value;
+	BUG_ON_OPT_NEG(unset);
 	if (*dir)
 		die(_("Two output directories?"));
 	*dir = arg;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2787453eb1..c70a9c7158 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -475,6 +475,8 @@ static int option_parse_exclude(const struct option *opt,
 {
 	struct string_list *exclude_list = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	exc_given = 1;
 	string_list_append(exclude_list, arg);
 
@@ -486,6 +488,8 @@ static int option_parse_exclude_from(const struct option *opt,
 {
 	struct dir_struct *dir = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	exc_given = 1;
 	add_excludes_from_file(dir, arg);
 
@@ -497,6 +501,9 @@ static int option_parse_exclude_standard(const struct option *opt,
 {
 	struct dir_struct *dir = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
 	exc_given = 1;
 	setup_standard_excludes(dir);
 
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index b08803e611..06a2f90c48 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -15,6 +15,8 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 	static int label_count = 0;
 	const char **names = (const char **)opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (label_count >= 3)
 		return error("too many labels on the command line");
 	names[label_count++] = arg;
diff --git a/builtin/merge.c b/builtin/merge.c
index 4aa6071598..adb0402e84 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -224,6 +224,7 @@ static int option_parse_x(const struct option *opt,
 static int option_parse_n(const struct option *opt,
 			  const char *arg, int unset)
 {
+	BUG_ON_OPT_ARG(arg);
 	show_diffstat = unset;
 	return 0;
 }
diff --git a/builtin/notes.c b/builtin/notes.c
index c05cd004ab..91faa514aa 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -215,6 +215,8 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	strbuf_grow(&d->buf, strlen(arg) + 2);
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
@@ -229,6 +231,8 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 	if (!strcmp(arg, "-")) {
@@ -250,6 +254,8 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	enum object_type type;
 	unsigned long len;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 
@@ -273,6 +279,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 static int parse_reedit_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
+	BUG_ON_OPT_NEG(unset);
 	d->use_editor = 1;
 	return parse_reuse_arg(opt, arg, unset);
 }
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4eac2f997b..6718e62c15 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3206,6 +3206,9 @@ static int option_parse_index_version(const struct option *opt,
 {
 	char *c;
 	const char *val = arg;
+
+	BUG_ON_OPT_NEG(unset);
+
 	pack_idx_opts.version = strtoul(val, &c, 10);
 	if (pack_idx_opts.version > 2)
 		die(_("unsupported index version %s"), val);
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index fbbc98e516..183ee8c1e5 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -44,6 +44,7 @@ static const char * const read_tree_usage[] = {
 static int index_output_cb(const struct option *opt, const char *arg,
 				 int unset)
 {
+	BUG_ON_OPT_NEG(unset);
 	set_alternate_index_output(arg);
 	return 0;
 }
@@ -54,6 +55,8 @@ static int exclude_per_directory_cb(const struct option *opt, const char *arg,
 	struct dir_struct *dir;
 	struct unpack_trees_options *opts;
 
+	BUG_ON_OPT_NEG(unset);
+
 	opts = (struct unpack_trees_options *)opt->value;
 
 	if (opts->dir)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ee06aa363..b84568fc4e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -703,6 +703,9 @@ static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
 {
 	struct rebase_options *opts = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
 	if (!is_interactive(opts))
 		opts->type = REBASE_MERGE;
 
@@ -715,6 +718,9 @@ static int parse_opt_interactive(const struct option *opt, const char *arg,
 {
 	struct rebase_options *opts = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
 	opts->type = REBASE_INTERACTIVE;
 	opts->flags |= REBASE_INTERACTIVE_EXPLICIT;
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index b1b540f7f6..934e514944 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -604,6 +604,7 @@ static int parse_reflog_param(const struct option *opt, const char *arg,
 {
 	char *ep;
 	const char **base = (const char **)opt->value;
+	BUG_ON_OPT_NEG(unset);
 	if (!arg)
 		arg = "";
 	reflog = strtoul(arg, &ep, 10);
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 2f13f1316f..ed888ffa48 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -151,6 +151,7 @@ static int hash_callback(const struct option *opt, const char *arg, int unset)
 static int exclude_existing_callback(const struct option *opt, const char *arg,
 				     int unset)
 {
+	BUG_ON_OPT_NEG(unset);
 	exclude_arg = 1;
 	*(const char **)opt->value = arg;
 	return 0;
diff --git a/builtin/tag.c b/builtin/tag.c
index 6a396a5090..02f6bd1279 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -338,6 +338,8 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct msg_arg *msg = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (!arg)
 		return -1;
 	if (msg->buf.len)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 07c10bcb7d..faa16c61f1 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -790,12 +790,16 @@ static int refresh(struct refresh_params *o, unsigned int flag)
 static int refresh_callback(const struct option *opt,
 				const char *arg, int unset)
 {
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	return refresh(opt->value, 0);
 }
 
 static int really_refresh_callback(const struct option *opt,
 				const char *arg, int unset)
 {
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	return refresh(opt->value, REFRESH_REALLY);
 }
 
@@ -803,6 +807,7 @@ static int chmod_callback(const struct option *opt,
 				const char *arg, int unset)
 {
 	char *flip = opt->value;
+	BUG_ON_OPT_NEG(unset);
 	if ((arg[0] != '-' && arg[0] != '+') || arg[1] != 'x' || arg[2])
 		return error("option 'chmod' expects \"+x\" or \"-x\"");
 	*flip = arg[0];
@@ -812,6 +817,8 @@ static int chmod_callback(const struct option *opt,
 static int resolve_undo_clear_callback(const struct option *opt,
 				const char *arg, int unset)
 {
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 	resolve_undo_clear();
 	return 0;
 }
@@ -847,6 +854,8 @@ static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 	unsigned int mode;
 	const char *path;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, &oid, &path)) {
 		if (add_cacheinfo(mode, &oid, path, 0))
 			die("git update-index: --cacheinfo cannot add %s", path);
@@ -869,6 +878,8 @@ static int stdin_cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 {
 	int *nul_term_line = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
 	allow_add = allow_replace = allow_remove = 1;
@@ -881,6 +892,8 @@ static int stdin_callback(struct parse_opt_ctx_t *ctx,
 {
 	int *read_from_stdin = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
 	*read_from_stdin = 1;
@@ -888,11 +901,13 @@ static int stdin_callback(struct parse_opt_ctx_t *ctx,
 }
 
 static int unresolve_callback(struct parse_opt_ctx_t *ctx,
-				const struct option *opt, int flags)
+				const struct option *opt, int unset)
 {
 	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
 
+	BUG_ON_OPT_NEG(unset);
+
 	/* consume remaining arguments. */
 	*has_errors = do_unresolve(ctx->argc, ctx->argv,
 				prefix, prefix ? strlen(prefix) : 0);
@@ -905,11 +920,13 @@ static int unresolve_callback(struct parse_opt_ctx_t *ctx,
 }
 
 static int reupdate_callback(struct parse_opt_ctx_t *ctx,
-				const struct option *opt, int flags)
+				const struct option *opt, int unset)
 {
 	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
 
+	BUG_ON_OPT_NEG(unset);
+
 	/* consume remaining arguments. */
 	setup_work_tree();
 	*has_errors = do_reupdate(ctx->argc, ctx->argv,
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 6a61166b26..8c9edce52f 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -58,6 +58,8 @@ int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
 {
 	int *target = opt->value;
 
+	BUG_ON_OPT_ARG(arg);
+
 	if (unset)
 		/* --no-quiet, --no-verbose */
 		*target = 0;
@@ -80,6 +82,8 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 	struct object_id oid;
 	struct commit *commit;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (!arg)
 		return -1;
 	if (get_oid(arg, &oid))
@@ -110,6 +114,9 @@ int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
 {
 	int *target = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+
 	*target = unset ? 2 : 1;
 	return 0;
 }
diff --git a/parse-options.h b/parse-options.h
index c3f2d2eceb..6c4fe2016d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -191,6 +191,20 @@ extern int opterror(const struct option *opt, const char *reason, int flags);
 #define opterror(o,r,f) (opterror((o),(r),(f)), const_error())
 #endif
 
+/*
+ * Use these assertions for callbacks that expect to be called with NONEG and
+ * NOARG respectively, and do not otherwise handle the "unset" and "arg"
+ * parameters.
+ */
+#define BUG_ON_OPT_NEG(unset) do { \
+	if ((unset)) \
+		BUG("option callback does not expect negation"); \
+} while (0)
+#define BUG_ON_OPT_ARG(arg) do { \
+	if ((arg)) \
+		BUG("option callback does not expect an argument"); \
+} while (0)
+
 /*----- incremental advanced APIs -----*/
 
 enum {
diff --git a/ref-filter.c b/ref-filter.c
index 0c45ed9d94..7eca436223 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2316,6 +2316,8 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 	struct object_id oid;
 	int no_merged = starts_with(opt->long_name, "no");
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (rf->merge) {
 		if (no_merged) {
 			return opterror(opt, "is incompatible with --merged", 0);
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index f0623bb42b..47fee660b8 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -36,6 +36,7 @@ static int length_callback(const struct option *opt, const char *arg, int unset)
 
 static int number_callback(const struct option *opt, const char *arg, int unset)
 {
+	BUG_ON_OPT_NEG(unset);
 	*(int *)opt->value = strtol(arg, NULL, 10);
 	return 0;
 }
-- 
2.19.1.1505.g9cd28186cf
