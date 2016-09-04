Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE071F859
	for <e@80x24.org>; Sun,  4 Sep 2016 23:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbcIDXmr (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 19:42:47 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34350 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbcIDXmq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 19:42:46 -0400
Received: by mail-pa0-f67.google.com with SMTP id hm5so3885521pac.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GgbM66hJcvme352REHES1O/VZHNCf14doQESp6aG0PQ=;
        b=tNJ2tETyJG73Rhds6DOSSYpT0wiVuvf1LTdINsrw8pR5CmvuTTwS3N7HZO5tHhJsFz
         WT59C9eTdS+G//9dqu3spKQ80GijBMD1CWLrdw007Cm61Uvm3EIQbHNXXkq1yHoEFqeW
         MiffqXmHr/E8LIn/qAl/9cLKLKrwjgWpooWnYv8Na0jIa9vo/M8qjQvYWSY0Xxs14H78
         d/tn/Z7cWEdNePdRcCDSVxeE4uQCgqKZSmdMXI2Crwv7jH3z6ECP4jhgmfac+qHiWvRd
         wIaTHOA7EKLK4TxUy+RpqQm8qQcc/t4wFl30iAg6jCb0OMWXPMF9PIJ4kTK8PN046+gz
         JTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GgbM66hJcvme352REHES1O/VZHNCf14doQESp6aG0PQ=;
        b=FDVXAW1XlfKpWdSPjhbhowJvItaDtuJMLbteW1ceH+eX6Yt7wqH7uaYv7WXRwaoSVU
         7hzZjUVbUKyE8I3ClK2Ki7RU9GKDeDqqMG0bseplAN83y/RhWD3yTiMI7S28IBxI2UbZ
         u45Gmkz0I2xfeTdd65Hq53xicW1xuSy786QRnJLk7ldDgJYTqfLgwpZ2yt+xQaO+ADdr
         Tok+D5UY+GqFGY4pVzYpkVDJ50ZBT2W91yAglCzb9EHU8oC7Y8MDw+PwSy2SX0RiMZBr
         gpJNPe0phnV6hCjl1E3O1RknRRxP/h93K7ihqNCCs3LyhIB/jTEw/KpdWLBALCbCJQkA
         kL/A==
X-Gm-Message-State: AE9vXwNmttXHDF5UAKmNLCH0fUWVChm0fxZO8m/3u8xTHtQCNq9WBhxgiFZm/vzq/dwg+A==
X-Received: by 10.66.132.81 with SMTP id os17mr5674513pab.106.1473032564928;
        Sun, 04 Sep 2016 16:42:44 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id n80sm14905166pfi.25.2016.09.04.16.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Sep 2016 16:42:43 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, gitster@pobox.com, jacob.keller@gmail.com,
        Stefan Beller <stefanbeller@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] diff.c: emit moved lines with a different color
Date:   Sun,  4 Sep 2016 16:42:37 -0700
Message-Id: <20160904234237.10548-1-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.10.0.1.ga424fb3
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

 * fixed memleaks
 * only run the new code when needed.
 * renamed variables to fit in better.


 Documentation/config.txt               |   5 +-
 contrib/completion/git-completion.bash |   2 +
 diff.c                                 | 200 +++++++++++++++++++++++++++++++--
 diff.h                                 |   5 +-
 4 files changed, 202 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb679..f4f51c2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -980,8 +980,9 @@ color.diff.<slot>::
 	of `context` (context text - `plain` is a historical synonym),
 	`meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
-	`new` (added lines), `commit` (commit headers), or `whitespace`
-	(highlighting whitespace errors).
+	`new` (added lines), `commit` (commit headers), `whitespace`
+	(highlighting whitespace errors), `moved-old` (removed lines that
+	reappear), `moved-new` (added lines that were removed elsewhere).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9c8f738..b558d12 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2115,6 +2115,8 @@ _git_config ()
 		color.diff.old
 		color.diff.plain
 		color.diff.whitespace
+		color.diff.moved-old
+		color.diff.moved-new
 		color.grep
 		color.grep.context
 		color.grep.filename
diff --git a/diff.c b/diff.c
index 534c12e..7fde014 100644
--- a/diff.c
+++ b/diff.c
@@ -18,6 +18,7 @@
 #include "ll-merge.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "git-compat-util.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -42,6 +43,16 @@ static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
 static long diff_algorithm;
 
+static struct hashmap *moved_add;
+static struct hashmap *moved_del;
+static int hash_prev_added;
+static int hash_prev_removed;
+struct moved_entry {
+	struct hashmap_entry ent;
+	char *line;
+	int hash_prev_line;
+};
+
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_NORMAL,	/* CONTEXT */
@@ -52,6 +63,8 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
+	GIT_COLOR_BLUE,		/* NEW MOVED */
+	GIT_COLOR_MAGENTA,	/* OLD MOVED */
 };
 
 static int parse_diff_color_slot(const char *var)
@@ -72,6 +85,10 @@ static int parse_diff_color_slot(const char *var)
 		return DIFF_WHITESPACE;
 	if (!strcasecmp(var, "func"))
 		return DIFF_FUNCINFO;
+	if (!strcasecmp(var, "moved-old"))
+		return DIFF_FILE_MOVED_OLD;
+	if (!strcasecmp(var, "moved-new"))
+		return DIFF_FILE_MOVED_NEW;
 	return -1;
 }
 
@@ -287,6 +304,25 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static int moved_entry_cmp(const struct moved_entry *a,
+			   const struct moved_entry *b,
+			   const void *unused)
+{
+	return strcmp(a->line, b->line) &&
+	       a->hash_prev_line == b->hash_prev_line;
+}
+
+static struct moved_entry *prepare_entry(const char *line,
+					 unsigned long len,
+					 int hash_prev_line)
+{
+	struct moved_entry *ret = xmalloc(sizeof(*ret));
+	ret->ent.hash = memhash(line, len) ^ hash_prev_line;
+	ret->line = xmemdupz(line, len);
+	ret->hash_prev_line = hash_prev_line;
+	return ret;
+}
+
 static char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
@@ -537,16 +573,38 @@ static void emit_add_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
+	enum color_diff color = DIFF_FILE_NEW;
+	unsigned ws_error_highlight = WSEH_NEW;
+
+	if (ecbdata->opt->color_moved) {
+		int hash = memhash(line, len);
+		struct moved_entry *keydata = prepare_entry(line, len,
+							    hash_prev_added);
+		if (hashmap_get(moved_del, keydata, keydata))
+			color = DIFF_FILE_MOVED_NEW;
+		hash_prev_added = hash;
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
+		int hash = memhash(line, len);
+		struct moved_entry *keydata = prepare_entry(line, len,
+							    hash_prev_removed);
+		if (hashmap_get(moved_add, keydata, keydata))
+			color = DIFF_FILE_MOVED_OLD;
+		hash_prev_removed = hash;
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
+		hash_prev_removed = h;
+		hash_prev_added = h;
+	}
 }
 
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -1323,6 +1386,41 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 }
 
+static void fn_prepare_consume(void *priv, char *line, unsigned long len)
+{
+	struct moved_entry *d;
+	int hash = memhash(line + 1, len - 1);
+
+	switch (line[0]) {
+	case ' ':
+		hashmap_add(moved_del, prepare_entry(line + 1, len - 1, 0));
+		hashmap_add(moved_add, prepare_entry(line + 1, len - 1, 0));
+		hash_prev_added = hash;
+		hash_prev_removed = hash;
+		break;
+	case '+':
+		if (hash_prev_added) {
+			d = prepare_entry(line + 1, len - 1, hash_prev_added);
+			hashmap_add(moved_add, d);
+		}
+		hash_prev_added = hash;
+		hash_prev_removed = 0;
+		break;
+	case '-':
+		if (hash_prev_removed) {
+			d = prepare_entry(line + 1, len - 1, hash_prev_removed);
+			hashmap_add(moved_del, d);
+		}
+		hash_prev_added = 0;
+		hash_prev_removed = hash;
+		break;
+	default:
+		hash_prev_added = 0;
+		hash_prev_removed = 0;
+		break;
+	}
+}
+
 static char *pprint_rename(const char *a, const char *b)
 {
 	const char *old = a;
@@ -2279,6 +2377,56 @@ struct userdiff_driver *get_textconv(struct diff_filespec *one)
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
+	if ((!one->mode || S_ISGITLINK(one->mode)) ||
+	    (!two->mode || S_ISGITLINK(two->mode)))
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
@@ -3295,6 +3443,7 @@ void diff_setup(struct diff_options *options)
 	options->xdl_opts |= diff_algorithm;
 	if (diff_compaction_heuristic)
 		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
+	options->color_moved = options->use_color;
 
 	options->orderfile = diff_order_file_cfg;
 
@@ -3413,6 +3562,9 @@ void diff_setup_done(struct diff_options *options)
 
 	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
 		die(_("--follow requires exactly one pathspec"));
+
+	if (!options->use_color || external_diff())
+		options->color_moved = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -4622,6 +4774,43 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(rename_limit_advice, varname, needed);
 }
 
+static void diff_flush_format_patch(struct diff_options *o)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	if (o->color_moved) {
+		moved_add = xmalloc(sizeof(*moved_add));
+		moved_del = xmalloc(sizeof(*moved_del));
+		hashmap_init(moved_add, (hashmap_cmp_fn)moved_entry_cmp, 0);
+		hashmap_init(moved_del, (hashmap_cmp_fn)moved_entry_cmp, 0);
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
+		struct moved_entry *e;
+		hashmap_iter_init(moved_add, &iter);
+		while ((e = hashmap_iter_next(&iter)))
+			free(e->line);
+		hashmap_iter_init(moved_del, &iter);
+		while ((e = hashmap_iter_next(&iter)))
+			free(e->line);
+		hashmap_free(moved_add, 1);
+		hashmap_free(moved_del, 1);
+	}
+}
+
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -4696,6 +4885,7 @@ void diff_flush(struct diff_options *options)
 		if (!options->file)
 			die_errno("Could not open /dev/null");
 		options->close_file = 1;
+		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
@@ -4716,11 +4906,7 @@ void diff_flush(struct diff_options *options)
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
index 7883729..b0331b9 100644
--- a/diff.h
+++ b/diff.h
@@ -122,6 +122,7 @@ struct diff_options {
 	unsigned int filter;
 
 	int use_color;
+	int color_moved;
 	int context;
 	int interhunkcontext;
 	int break_opt;
@@ -189,7 +190,9 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
-	DIFF_FUNCINFO = 8
+	DIFF_FUNCINFO = 8,
+	DIFF_FILE_MOVED_NEW = 9,
+	DIFF_FILE_MOVED_OLD = 10
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
-- 
2.10.0.1.ga424fb3

