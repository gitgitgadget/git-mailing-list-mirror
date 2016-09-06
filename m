Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1DE1F859
	for <e@80x24.org>; Tue,  6 Sep 2016 07:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbcIFHB6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 03:01:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34312 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbcIFHB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 03:01:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id g202so10941690pfb.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5DnkWxgb4xH8yyxbtBpImxXSL/jHOw2uHSptt4cmJAA=;
        b=MJlTLy3nPCyatTfw6JxNvnhb6xJ76AHtQom4JFW0SbzrlCIwUlTac4syxC6B6m5yml
         nEYbYdvpaHOJJZXzvvaJvNP/eib94qInkmygZhgRB7jEHxiPDABkX4p0dGUbuBKA7oF4
         jkv4tDytzTbcLYtI8zog+rFjqNfn6kBcbYQTpWtddSQmp8MalfmEVjzDh9mrAVrMri8/
         a2BMKJNUGX1I+8io0myVs9u24+GsAa4TJSRwm1wQx1ktxjNVDipVgfLSmAyfk86h1pcY
         th+G2PDyETZZd1tySqtPUUIx7tvSxm+8RmGKTTob3FiSWI3QV0r5qcyRbea2JQB53sGV
         MSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5DnkWxgb4xH8yyxbtBpImxXSL/jHOw2uHSptt4cmJAA=;
        b=K7/Ik2xZS1lJygMSWe8xCVDtr45LrstzxYkcalWtx2i/6eEe3H736i4T4MFczUYoq9
         hndYgVzU+jLbumRuN2Vfj8QD20BV4AuRze2P71lC1frX0CKPcpXZK8c4jGaQInlv5B9s
         BKE6c5Z3z6E+UJcG0DFPF2C/juklfJBB650S0hqQd1AjrbhoB/I9Doe02L7Zuf3/0O1M
         NNGmz2b38XXDf7/PL9e5JzVK3pUbQaZQSWKQDbC4V52Y8xkgKgZ35z6gKv4D4tBy70eM
         2QmyFFbAwyQ19l7Aw7muwSLseJ7cquwMlfT1JyDuC6d/2mf9IDFoj/VsCILkAD9HaJB3
         WSKA==
X-Gm-Message-State: AE9vXwN29SXKZBWQKLr4ulAhQn28evZm1DgaR+UOp5Y9YicoSPiqGeUc+o7hM9+aXygzug==
X-Received: by 10.98.67.193 with SMTP id l62mr70314935pfi.16.1473145316072;
        Tue, 06 Sep 2016 00:01:56 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id h66sm14885927pfc.47.2016.09.06.00.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2016 00:01:55 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, gitster@pobox.com, jacob.keller@gmail.com,
        Stefan Beller <stefanbeller@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4] diff.c: emit moved lines with a different color
Date:   Tue,  6 Sep 2016 00:01:51 -0700
Message-Id: <20160906070151.15163-1-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g233b7f3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we color the diff, we'll mark moved lines with a different color.

This is achieved by doing a two passes over the diff. The first pass
will inspect each line of the diff and store the removed lines and the
added lines in its own hash map.
The second pass will check for each added line if that is found in the
set of removed lines. If so it will color the added line differently as
with the new `moved-new` color mode. For each removed line we check the
set of added lines and if found emit that with the new color `moved-old`.

When detecting the moved lines, we cannot just rely on a line being equal,
but we need to take the context into account to detect when the moves were
reordered as we do not want to color moved but per-mutated lines.
To do that we use the hash of the preceding line.

This patch was motivated by e.g. reviewing 3b0c4200 ("apply: move
libified code from builtin/apply.c to apply.{c,h}", 2016-08-08)

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 * moved new data structures into struct diff_options
 * color.moved=bool as well as --[no-]color-moved to {dis,en}able the new feature
 * color.diff.movedfrom and color.diff.movedto to control the colors
 * added a test
 
 Documentation/config.txt               |  12 +-
 Documentation/diff-options.txt         |   7 ++
 contrib/completion/git-completion.bash |   2 +
 diff.c                                 | 211 +++++++++++++++++++++++++++++++--
 diff.h                                 |  16 ++-
 t/t4015-diff-whitespace.sh             |  44 +++++++
 6 files changed, 282 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb679..5daf77a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -974,14 +974,22 @@ This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
 
+color.moved::
+	A boolean value, whether a diff should color moved lines
+	differently. The moved lines are searched for in the diff only.
+	Duplicated lines from somewhere in the project that are not
+	part of the diff are not colored as moved.
+	Defaults to true.
+
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
 	of `context` (context text - `plain` is a historical synonym),
 	`meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
-	`new` (added lines), `commit` (commit headers), or `whitespace`
-	(highlighting whitespace errors).
+	`new` (added lines), `commit` (commit headers), `whitespace`
+	(highlighting whitespace errors), `movedfrom` (removed lines that
+	reappear), `movedto` (added lines that were removed elsewhere).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 705a873..13b6a2a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -234,6 +234,13 @@ ifdef::git-diff[]
 endif::git-diff[]
 	It is the same as `--color=never`.
 
+--[no-]color-moved::
+	Show moved blocks in a different color.
+ifdef::git-diff[]
+	It can be changed by the `diff.ui` and `color.diff`
+	configuration settings.
+endif::git-diff[]
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9c8f738..9827c2e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2115,6 +2115,8 @@ _git_config ()
 		color.diff.old
 		color.diff.plain
 		color.diff.whitespace
+		color.diff.movedfrom
+		color.diff.movedto
 		color.grep
 		color.grep.context
 		color.grep.filename
diff --git a/diff.c b/diff.c
index 534c12e..47685f3 100644
--- a/diff.c
+++ b/diff.c
@@ -18,6 +18,7 @@
 #include "ll-merge.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "git-compat-util.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -30,6 +31,7 @@ static int diff_compaction_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
+static int diff_color_moved_default = -1;
 static int diff_context_default = 3;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
@@ -52,6 +54,8 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
+	GIT_COLOR_BLUE,		/* MOVED FROM */
+	GIT_COLOR_MAGENTA,	/* MOVED TO */
 };
 
 static int parse_diff_color_slot(const char *var)
@@ -72,6 +76,10 @@ static int parse_diff_color_slot(const char *var)
 		return DIFF_WHITESPACE;
 	if (!strcasecmp(var, "func"))
 		return DIFF_FUNCINFO;
+	if (!strcasecmp(var, "movedfrom"))
+		return DIFF_FILE_MOVED_FROM;
+	if (!strcasecmp(var, "movedto"))
+		return DIFF_FILE_MOVED_TO;
 	return -1;
 }
 
@@ -180,6 +188,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "color.moved")) {
+		diff_color_moved_default = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.context")) {
 		diff_context_default = git_config_int(var, value);
 		if (diff_context_default < 0)
@@ -287,6 +299,26 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static int diff_line_moved_entry_cmp(const struct diff_line_moved_entry *a,
+				     const struct diff_line_moved_entry *b,
+				     const void *unused)
+{
+	return strcmp(a->line, b->line) &&
+	       a->hash_prev_line == b->hash_prev_line;
+}
+
+static struct diff_line_moved_entry *
+prepare_diff_line_moved_entry(const char *line,
+			      unsigned long len,
+			      int hash_prev_line)
+{
+	struct diff_line_moved_entry *ret = xmalloc(sizeof(*ret));
+	ret->ent.hash = memhash(line, len) ^ hash_prev_line;
+	ret->line = xmemdupz(line, len);
+	ret->hash_prev_line = hash_prev_line;
+	return ret;
+}
+
 static char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
@@ -537,16 +569,42 @@ static void emit_add_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
+	enum color_diff color = DIFF_FILE_NEW;
+	unsigned ws_error_highlight = WSEH_NEW;
+
+	if (ecbdata->opt->color_moved) {
+		struct diff_options *o = ecbdata->opt;
+		int hash = memhash(line, len);
+		struct diff_line_moved_entry *keydata =
+			prepare_diff_line_moved_entry(line, len,
+						      o->hash_prev_added);
+		if (hashmap_get(o->moved_del, keydata, keydata))
+			color = DIFF_FILE_MOVED_TO;
+		o->hash_prev_added = hash;
+	}
 	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_FILE_NEW, WSEH_NEW, '+');
+			  color, ws_error_highlight, '+');
 }
 
 static void emit_del_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
+	enum color_diff color = DIFF_FILE_OLD;
+	unsigned ws_error_highlight = WSEH_OLD;
+
+	if (ecbdata->opt->color_moved) {
+		struct diff_options *o = ecbdata->opt;
+		int hash = memhash(line, len);
+		struct diff_line_moved_entry *keydata =
+			prepare_diff_line_moved_entry(line, len,
+						      o->hash_prev_removed);
+		if (hashmap_get(ecbdata->opt->moved_add, keydata, keydata))
+			color = DIFF_FILE_MOVED_FROM;
+		o->hash_prev_removed = hash;
+	}
 	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_FILE_OLD, WSEH_OLD, '-');
+			  color, ws_error_highlight, '-');
 }
 
 static void emit_context_line(const char *reset,
@@ -555,6 +613,11 @@ static void emit_context_line(const char *reset,
 {
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_CONTEXT, WSEH_CONTEXT, ' ');
+	if (ecbdata->opt->color_moved) {
+		int h = memhash(line, len);
+		ecbdata->opt->hash_prev_removed = h;
+		ecbdata->opt->hash_prev_added = h;
+	}
 }
 
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -1323,6 +1386,47 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 }
 
+static void fn_prepare_consume(void *priv, char *line, unsigned long len)
+{
+	struct emit_callback *ecbdata = priv;
+	struct diff_options *o = ecbdata->opt;
+	struct diff_line_moved_entry *d;
+	int hash = memhash(line + 1, len - 1);
+
+	switch (line[0]) {
+	case ' ':
+		hashmap_add(o->moved_del,
+			prepare_diff_line_moved_entry(line + 1, len - 1, 0));
+		hashmap_add(o->moved_add,
+			prepare_diff_line_moved_entry(line + 1, len - 1, 0));
+		o->hash_prev_added = hash;
+		o->hash_prev_removed = hash;
+		break;
+	case '+':
+		if (o->hash_prev_added) {
+			d = prepare_diff_line_moved_entry(line + 1, len - 1,
+							  o->hash_prev_added);
+			hashmap_add(o->moved_add, d);
+		}
+		o->hash_prev_added = hash;
+		o->hash_prev_removed = 0;
+		break;
+	case '-':
+		if (o->hash_prev_removed) {
+			d = prepare_diff_line_moved_entry(line + 1, len - 1,
+							  o->hash_prev_removed);
+			hashmap_add(o->moved_del, d);
+		}
+		o->hash_prev_added = 0;
+		o->hash_prev_removed = hash;
+		break;
+	default:
+		o->hash_prev_added = 0;
+		o->hash_prev_removed = 0;
+		break;
+	}
+}
+
 static char *pprint_rename(const char *a, const char *b)
 {
 	const char *old = a;
@@ -2279,6 +2383,57 @@ struct userdiff_driver *get_textconv(struct diff_filespec *one)
 	return userdiff_get_textconv(one->driver);
 }
 
+static void prepare_moved_lines(struct diff_filepair *p, struct diff_options *o)
+{
+	mmfile_t mf1, mf2;
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	struct emit_callback ecbdata;
+	struct diff_filespec *one = p->one;
+	struct diff_filespec *two = p->two;
+	struct userdiff_driver *textconv_one = NULL;
+	struct userdiff_driver *textconv_two = NULL;
+
+	if (S_ISGITLINK(one->mode) ||
+	    S_ISGITLINK(two->mode))
+		return;
+
+	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+		textconv_one = get_textconv(one);
+		textconv_two = get_textconv(two);
+	}
+
+	if (!DIFF_OPT_TST(o, TEXT) &&
+	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
+	      (!textconv_two && diff_filespec_is_binary(two)) ))
+	      return;
+
+	mf1.size = fill_textconv(textconv_one, one, &mf1.ptr);
+	mf2.size = fill_textconv(textconv_two, two, &mf2.ptr);
+
+	memset(&xpp, 0, sizeof(xpp));
+	memset(&xecfg, 0, sizeof(xecfg));
+	memset(&ecbdata, 0, sizeof(ecbdata));
+	ecbdata.opt = o;
+
+	xpp.flags = o->xdl_opts;
+	xecfg.ctxlen = 1;
+
+	if (o->word_diff)
+		init_diff_words_data(&ecbdata, o, one, two);
+	if (xdi_diff_outf(&mf1, &mf2, fn_prepare_consume, &ecbdata,
+			  &xpp, &xecfg))
+		die("unable to generate generate moved color output for %s",
+		    one->path);
+	if (o->word_diff)
+		free_diff_words_data(&ecbdata);
+	if (textconv_one)
+		free(mf1.ptr);
+	if (textconv_two)
+		free(mf2.ptr);
+	xdiff_clear_find_func(&xecfg);
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -3291,6 +3446,7 @@ void diff_setup(struct diff_options *options)
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
 	options->use_color = diff_use_color_default;
+	options->color_moved = diff_color_moved_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
 	if (diff_compaction_heuristic)
@@ -3413,6 +3569,9 @@ void diff_setup_done(struct diff_options *options)
 
 	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
 		die(_("--follow requires exactly one pathspec"));
+
+	if (!options->use_color || external_diff())
+		options->color_moved = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -3863,6 +4022,10 @@ int diff_opt_parse(struct diff_options *options,
 	}
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
+	else if (!strcmp(arg, "--color-moved"))
+		options->color_moved = 1;
+	else if (!strcmp(arg, "--no-color-moved"))
+		options->color_moved = 0;
 	else if (!strcmp(arg, "--color-words")) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
@@ -4622,6 +4785,43 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(rename_limit_advice, varname, needed);
 }
 
+static void diff_flush_format_patch(struct diff_options *o)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	if (o->color_moved) {
+		o->moved_add = xmalloc(sizeof(*o->moved_add));
+		o->moved_del = xmalloc(sizeof(*o->moved_del));
+		hashmap_init(o->moved_add, (hashmap_cmp_fn)diff_line_moved_entry_cmp, 0);
+		hashmap_init(o->moved_del, (hashmap_cmp_fn)diff_line_moved_entry_cmp, 0);
+
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (check_pair_status(p) && !diff_unmodified_pair(p))
+				prepare_moved_lines(p, o);
+		}
+	}
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (check_pair_status(p))
+			diff_flush_patch(p, o);
+	}
+
+	if (o->color_moved) {
+		struct hashmap_iter iter;
+		struct diff_line_moved_entry *e;
+		hashmap_iter_init(o->moved_add, &iter);
+		while ((e = hashmap_iter_next(&iter)))
+			free(e->line);
+		hashmap_iter_init(o->moved_del, &iter);
+		while ((e = hashmap_iter_next(&iter)))
+			free(e->line);
+		hashmap_free(o->moved_add, 1);
+		hashmap_free(o->moved_del, 1);
+	}
+}
+
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -4696,6 +4896,7 @@ void diff_flush(struct diff_options *options)
 		if (!options->file)
 			die_errno("Could not open /dev/null");
 		options->close_file = 1;
+		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
@@ -4716,11 +4917,7 @@ void diff_flush(struct diff_options *options)
 			}
 		}
 
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				diff_flush_patch(p, options);
-		}
+		diff_flush_format_patch(options);
 	}
 
 	if (output_format & DIFF_FORMAT_CALLBACK)
diff --git a/diff.h b/diff.h
index 7883729..236baa8 100644
--- a/diff.h
+++ b/diff.h
@@ -110,6 +110,12 @@ enum diff_words_type {
 	DIFF_WORDS_COLOR
 };
 
+struct diff_line_moved_entry {
+	struct hashmap_entry ent;
+	char *line;
+	int hash_prev_line;
+};
+
 struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
@@ -178,6 +184,12 @@ struct diff_options {
 	void *output_prefix_data;
 
 	int diff_path_counter;
+
+	int color_moved;
+	struct hashmap *moved_add;
+	struct hashmap *moved_del;
+	int hash_prev_added;
+	int hash_prev_removed;
 };
 
 enum color_diff {
@@ -189,7 +201,9 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
-	DIFF_FUNCINFO = 8
+	DIFF_FUNCINFO = 8,
+	DIFF_FILE_MOVED_TO = 9,
+	DIFF_FILE_MOVED_FROM = 10
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 2434157..9fdc5bd 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -934,4 +934,48 @@ test_expect_success 'the same with --ws-error-highlight' '
 	test_cmp expected current
 '
 
+test_expect_success 'detect moved code' '
+	git reset --hard &&
+	cat >test.c <<-\EOF &&
+
+	#include<stdio.h>
+	main()
+	{
+	printf("Hello World");
+	}
+	EOF
+	git add test.c &&
+	git commit -m "add main function" &&
+	git mv test.c main.c &&
+	git diff HEAD --no-renames | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/main.c b/main.c<RESET>
+	<BOLD>new file mode 100644<RESET>
+	<BOLD>index 0000000..f068530<RESET>
+	<BOLD>--- /dev/null<RESET>
+	<BOLD>+++ b/main.c<RESET>
+	<CYAN>@@ -0,0 +1,6 @@<RESET>
+	<GREEN>+<RESET>
+	<BLUE>+<RESET><BLUE>#include<stdio.h><RESET>
+	<BLUE>+<RESET><BLUE>main()<RESET>
+	<BLUE>+<RESET><BLUE>{<RESET>
+	<BLUE>+<RESET><BLUE>printf("Hello World");<RESET>
+	<BLUE>+<RESET><BLUE>}<RESET>
+	<BOLD>diff --git a/test.c b/test.c<RESET>
+	<BOLD>deleted file mode 100644<RESET>
+	<BOLD>index f068530..0000000<RESET>
+	<BOLD>--- a/test.c<RESET>
+	<BOLD>+++ /dev/null<RESET>
+	<CYAN>@@ -1,6 +0,0 @@<RESET>
+	<RED>-<RESET>
+	<MAGENTA>-#include<stdio.h><RESET>
+	<MAGENTA>-main()<RESET>
+	<MAGENTA>-{<RESET>
+	<MAGENTA>-printf("Hello World");<RESET>
+	<MAGENTA>-}<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
-- 
2.10.0.1.g233b7f3.dirty

