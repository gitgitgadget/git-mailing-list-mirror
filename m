Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6106B1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 19:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbcIDTOu (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 15:14:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33638 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbcIDTOt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 15:14:49 -0400
Received: by mail-it0-f68.google.com with SMTP id g185so7083702ith.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XSrDjfv9NHvOxd8f7aXrVNP3YCiZiRkXa86kNcq6aMk=;
        b=ToW0YMT8KceVH4eAQC2YpcDVCOC7RrOKtPbGa5wHiBz70zw3rPD+Vf/sMYQOWXwcdI
         KunxKq3bAuuhC2wEG4iIXXK5j4J39EjASttH2bQNeVRilIReaLiExdbQRQh1xgRnWk1y
         /MVINfZAEn1mKeUTatrpWTxKlpL+xUBvc3H0v/xeWa4URFWIa7h8Hsg6pvLAmpbRYyt8
         WGU5G17ufmdriRgJPOL9G/1G9EiVsSIh+d4VE26Fbs1iX3+Gj2NULd8T5IAZXzAm0bkg
         RHJgoHPv0bvbwPykqsAOkKxyxWE0/OmuGcJoqSo53JAHp340jZ0aY1UvTYQafsoUow8j
         hHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XSrDjfv9NHvOxd8f7aXrVNP3YCiZiRkXa86kNcq6aMk=;
        b=Zq/FYfJBSVwM91KDxt0enwW0KGyr94OwzhwLeNsohnTHAf7FJRnmhiTxel7vm8JKPf
         nzlA0dRRPrm+oePlaqkvtHx8rTEIqRZ1H73WRUTeFDYG4qRCMemSSPWk5fwTKglFjjyf
         GV7duzMU4a3v5v2oT+9oWUVnpZNWuHz/3XJvZEejuZXyzqZiarNbnZaICR16yoYheCnL
         VY7cazejyY2Y70XYf7Jy+LAQy9/ZJ8eHITWm37OV6Y5PD/s5l4JuEhN5MXKwBUCFIeTC
         NTy5RZuU/5bLZmEb9dJ8cXb4GpDT7quPmmyBN0xY3R4WvN0jsZrDiDPlwndPfKMmeIC0
         8ZNQ==
X-Gm-Message-State: AE9vXwOf+E/vxQ6YJYqi/mLWXQCFH6Dgzp4CNtpBG0N+1SUfZN+Kn/9VS8uzyShOShD10g==
X-Received: by 10.36.104.73 with SMTP id v70mr19144408itb.12.1473016488297;
        Sun, 04 Sep 2016 12:14:48 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id 194sm8010316itu.4.2016.09.04.12.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Sep 2016 12:14:47 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, gitster@pobox.com, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [WIP PATCH v2] diff.c: emit moved lines with a different color
Date:   Sun,  4 Sep 2016 12:14:35 -0700
Message-Id: <20160904191435.14144-1-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.10.0.2.ga528ff4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

When we color the diff, we'll mark moved lines with a different color.

This is achieved by doing a two passes over the diff. The first pass
will inspect each line of the diff and store the removed lines and the
added lines in its own hash map.
The second pass will check for each added line if that is found in the
set of removed lines. If so it will color the added line differently as
with the new `moved-new` color mode.
For each removed line we check the set of added lines and if found emit
that with the new color `moved-old`.

When detecting the moved lines, we cannot just rely on a line being equal,
but we need to take the context into account to detect when the moves were
reordered as we do not want to color moved but per-mutated lines.

This patch was motivated by e.g. reviewing 3b0c4200 ("apply: move
libified code from builtin/apply.c to apply.{c,h}", 2016-08-08)

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  This adds code only in the diff_flush part, just as you suggested Junio.
  
  I think the design is sound now, as it produces good highlights across files;
  though now the code still sucks.
   * leaking memory; 
   * we run the code to detect moves more often than we need, e.g.
     when we configured an external diff, we don't need to run it.
     Or when we do not use colors at all.
   * I need to think about if we need everything doubled for both add and
       removal; maybe we can use one variable for both cases.


  Jacob wrote:
  
  > In the example, the first and last lines of duplicate copies don't get
  > colored differently, and that threw  me off. I feel like that was
  > maybe not intentional? If it was, can you explain why?

  We need the context to detect permutations, improved version:
  
  http://i.imgur.com/MnaSZ1D.png


  Jakub wrote:
  
  > P.S. BTW. does this work with word-diff?
  
  No (not yet.... )
  
  Thanks,
  Stefan

 Documentation/config.txt               |   5 +-
 contrib/completion/git-completion.bash |   2 +
 diff.c                                 | 200 ++++++++++++++++++++++++++++++++-
 diff.h                                 |   5 +-
 4 files changed, 205 insertions(+), 7 deletions(-)

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
index 534c12e..d37cb4f 100644
--- a/diff.c
+++ b/diff.c
@@ -18,6 +18,7 @@
 #include "ll-merge.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "git-compat-util.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -42,6 +43,11 @@ static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
 static long diff_algorithm;
 
+static struct hashmap *duplicates_added;
+static struct hashmap *duplicates_removed;
+static int hash_previous_line_added;
+static int hash_previous_line_removed;
+
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_NORMAL,	/* CONTEXT */
@@ -52,6 +58,8 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
+	GIT_COLOR_BLUE,		/* NEW MOVED */
+	GIT_COLOR_MAGENTA,	/* OLD MOVED */
 };
 
 static int parse_diff_color_slot(const char *var)
@@ -72,6 +80,10 @@ static int parse_diff_color_slot(const char *var)
 		return DIFF_WHITESPACE;
 	if (!strcasecmp(var, "func"))
 		return DIFF_FUNCINFO;
+	if (!strcasecmp(var, "moved-old"))
+		return DIFF_FILE_MOVED_OLD;
+	if (!strcasecmp(var, "moved-new"))
+		return DIFF_FILE_MOVED_NEW;
 	return -1;
 }
 
@@ -287,6 +299,30 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+struct dup_entry {
+	struct hashmap_entry ent;
+	char *line;
+	int previous_hash;
+};
+
+static int dup_entry_cmp(const struct dup_entry *a,
+			 const struct dup_entry *b,
+			 const void *unused)
+{
+	return strcmp(a->line, b->line) && a->previous_hash == b->previous_hash;
+}
+
+static struct dup_entry *prepare_entry(const char *line,
+					unsigned long len,
+					int previous_hash)
+{
+	struct dup_entry *ret = xmalloc(sizeof(*ret));
+	ret->ent.hash = memhash(line, len) ^ previous_hash;
+	ret->line = xmemdupz(line, len);
+	ret->previous_hash = previous_hash;
+	return ret;
+}
+
 static char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
@@ -537,16 +573,46 @@ static void emit_add_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
-	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_FILE_NEW, WSEH_NEW, '+');
+	if (!duplicates_removed) {
+		emit_line_checked(reset, ecbdata, line, len,
+				  DIFF_FILE_NEW, WSEH_NEW, '+');
+	} else {
+		int hash = memhash(line, len);
+		struct dup_entry *keydata = prepare_entry(line, len, hash_previous_line_added);
+		enum color_diff color = DIFF_FILE_NEW;
+		unsigned ws_error_highlight = WSEH_NEW;
+
+		if (hashmap_get(duplicates_removed, keydata, keydata))
+			color = DIFF_FILE_MOVED_NEW;
+
+		emit_line_checked(reset, ecbdata, line, len,
+				  color, ws_error_highlight, '+');
+
+		hash_previous_line_added = hash;
+	}
 }
 
 static void emit_del_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
-	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_FILE_OLD, WSEH_OLD, '-');
+	if (!duplicates_added) {
+		emit_line_checked(reset, ecbdata, line, len,
+				  DIFF_FILE_OLD, WSEH_OLD, '-');
+	} else {
+		int hash = memhash(line, len);
+		struct dup_entry *keydata = prepare_entry(line, len, hash_previous_line_removed);
+		enum color_diff color = DIFF_FILE_OLD;
+		unsigned ws_error_highlight = WSEH_OLD;
+
+		if (hashmap_get(duplicates_added, keydata, keydata))
+			color = DIFF_FILE_MOVED_OLD;
+
+		emit_line_checked(reset, ecbdata, line, len,
+				  color, ws_error_highlight, '-');
+
+		hash_previous_line_removed = hash;
+	}
 }
 
 static void emit_context_line(const char *reset,
@@ -555,6 +621,11 @@ static void emit_context_line(const char *reset,
 {
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_CONTEXT, WSEH_CONTEXT, ' ');
+	if (duplicates_added) {
+		int hash = memhash(line, len);
+		hash_previous_line_removed = hash;
+		hash_previous_line_added = hash;
+	}
 }
 
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -1323,6 +1394,59 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 }
 
+static void fn_prepare_consume(void *priv, char *line, unsigned long len)
+{
+	int hash;
+	struct dup_entry *d;
+
+	if (!duplicates_added) {
+		duplicates_added = xmalloc(sizeof(*duplicates_added));
+		duplicates_removed = xmalloc(sizeof(*duplicates_removed));
+		hashmap_init(duplicates_added, (hashmap_cmp_fn)dup_entry_cmp, 0);
+		hashmap_init(duplicates_removed, (hashmap_cmp_fn)dup_entry_cmp, 0);
+	}
+
+	switch (line[0]) {
+	case ' ':
+		d = prepare_entry(line + 1, len - 1, 0);
+		hashmap_add(duplicates_removed, d);
+		hashmap_add(duplicates_added, d);
+		break;
+	case '+':
+		if (hash_previous_line_added)
+			hashmap_add(duplicates_added,
+				prepare_entry(line + 1, len - 1,
+					      hash_previous_line_added));
+		break;
+	case '-':
+		if (hash_previous_line_removed)
+			hashmap_add(duplicates_removed,
+				prepare_entry(line + 1, len - 1,
+					      hash_previous_line_removed));
+		break;
+	}
+
+	hash = memhash(line + 1, len - 1);
+	switch (line[0]) {
+	case ' ':
+		hash_previous_line_added = hash;
+		hash_previous_line_removed = hash;
+		break;
+	case '+':
+		hash_previous_line_added = hash;
+		hash_previous_line_removed = 0;
+		break;
+	case '-':
+		hash_previous_line_added = 0;
+		hash_previous_line_removed = hash;
+		break;
+	default:
+		hash_previous_line_added = 0;
+		hash_previous_line_removed = 0;
+		break;
+	}
+}
+
 static char *pprint_rename(const char *a, const char *b)
 {
 	const char *old = a;
@@ -2279,6 +2403,50 @@ struct userdiff_driver *get_textconv(struct diff_filespec *one)
 	return userdiff_get_textconv(one->driver);
 }
 
+
+static void prepare_moved_lines(struct diff_filepair *p, struct diff_options *o)
+{
+	struct diff_filespec *one = p->one;
+	struct diff_filespec *two = p->two;
+	struct userdiff_driver *textconv_one = NULL;
+	struct userdiff_driver *textconv_two = NULL;
+
+	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+		textconv_one = get_textconv(one);
+		textconv_two = get_textconv(two);
+	}
+
+	{
+		mmfile_t mf1, mf2;
+		xpparam_t xpp;
+		xdemitconf_t xecfg;
+		struct emit_callback ecbdata;
+
+		mf1.size = fill_textconv(textconv_one, one, &mf1.ptr);
+		mf2.size = fill_textconv(textconv_two, two, &mf2.ptr);
+
+		memset(&xpp, 0, sizeof(xpp));
+		memset(&xecfg, 0, sizeof(xecfg));
+		memset(&ecbdata, 0, sizeof(ecbdata));
+
+		xpp.flags = o->xdl_opts;
+		xecfg.ctxlen = 1;
+
+		if (o->word_diff)
+			init_diff_words_data(&ecbdata, o, one, two);
+		if (xdi_diff_outf(&mf1, &mf2, fn_prepare_consume, &ecbdata,
+				  &xpp, &xecfg))
+			die("unable to generate diff for %s", one->path);
+		if (o->word_diff)
+			free_diff_words_data(&ecbdata);
+		if (textconv_one)
+			free(mf1.ptr);
+		if (textconv_two)
+			free(mf2.ptr);
+		xdiff_clear_find_func(&xecfg);
+	}
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -3295,6 +3463,7 @@ void diff_setup(struct diff_options *options)
 	options->xdl_opts |= diff_algorithm;
 	if (diff_compaction_heuristic)
 		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
+	options->highlight_moved = options->use_color;
 
 	options->orderfile = diff_order_file_cfg;
 
@@ -3413,6 +3582,9 @@ void diff_setup_done(struct diff_options *options)
 
 	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
 		die(_("--follow requires exactly one pathspec"));
+
+	if (!options->use_color)
+		options->highlight_moved = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -4622,6 +4794,24 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(rename_limit_advice, varname, needed);
 }
 
+static void diff_flush_maybe_prepare_moved_lines(struct diff_options *o)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	if (0
+	    /* TODO
+	     * internal diff and colored options, i.e.
+	     * only when we actually run into the emit_line_...
+	     * eventually */)
+		return;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (check_pair_status(p))
+			prepare_moved_lines(p, o);
+	}
+}
+
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -4716,6 +4906,8 @@ void diff_flush(struct diff_options *options)
 			}
 		}
 
+
+		diff_flush_maybe_prepare_moved_lines(options);
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
diff --git a/diff.h b/diff.h
index 7883729..0e4367b 100644
--- a/diff.h
+++ b/diff.h
@@ -139,6 +139,7 @@ struct diff_options {
 	int dirstat_permille;
 	int setup;
 	int abbrev;
+	int highlight_moved;
 /* white-space error highlighting */
 #define WSEH_NEW 1
 #define WSEH_CONTEXT 2
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
2.10.0.2.ga528ff4

