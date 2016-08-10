Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B13E1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 23:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbcHJXTj (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 19:19:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:10309 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbcHJXTi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 19:19:38 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 10 Aug 2016 16:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,502,1464678000"; 
   d="scan'208";a="1023347058"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2016 16:19:11 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 2/2] diff: add SUBMODULE_DIFF format to display submodule diff
Date:	Wed, 10 Aug 2016 16:19:08 -0700
Message-Id: <20160810231908.26330-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.9.2.872.g2dc3c84
In-Reply-To: <20160810231908.26330-1-jacob.e.keller@intel.com>
References: <20160810231908.26330-1-jacob.e.keller@intel.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Teach git-diff and friends a new format for displaying the difference of
a submodule using git-diff inside the submodule project. This allows
users to easily see exactly what source changed in a given commit that
updates the submodule pointer. To do this, remove DIFF_SUBMODULE_LOG bit
from the diff options, and instead add a new enum type for these
formats.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/diff-config.txt  |  3 +-
 Documentation/diff-options.txt |  6 ++--
 diff.c                         | 41 ++++++++++++++++----------
 diff.h                         |  9 +++++-
 submodule.c                    | 67 ++++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |  6 ++++
 6 files changed, 113 insertions(+), 19 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index d5a5b17d5088..f5d693afad6c 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -123,7 +123,8 @@ diff.suppressBlankEmpty::
 diff.submodule::
 	Specify the format in which differences in submodules are
 	shown.  The "log" format lists the commits in the range like
-	linkgit:git-submodule[1] `summary` does.  The "short" format
+	linkgit:git-submodule[1] `summary` does.  The "diff" format shows the
+	diff between the beginning and end of the range. The "short" format
 	format just shows the names of the commits at the beginning
 	and end of the range.  Defaults to short.
 
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e7b729f3644f..988068225463 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -215,8 +215,10 @@ any of those replacements occurred.
 	the commits in the range like linkgit:git-submodule[1] `summary` does.
 	Omitting the `--submodule` option or specifying `--submodule=short`,
 	uses the 'short' format. This format just shows the names of the commits
-	at the beginning and end of the range.  Can be tweaked via the
-	`diff.submodule` configuration variable.
+	at the beginning and end of the range. When `--submodule=diff` is
+	given, the 'diff' format is used. This format shows the diff between
+	the old and new submodule commmit from the perspective of the
+	submodule.  Can be tweaked via the `diff.submodule` configuration variable.
 
 --color[=<when>]::
 	Show colored diff.
diff --git a/diff.c b/diff.c
index 6fa9668b19e5..8a591d23eb0f 100644
--- a/diff.c
+++ b/diff.c
@@ -131,9 +131,11 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 static int parse_submodule_params(struct diff_options *options, const char *value)
 {
 	if (!strcmp(value, "log"))
-		DIFF_OPT_SET(options, SUBMODULE_LOG);
+		options->submodule_format = DIFF_SUBMODULE_LOG;
+	else if (!strcmp(value, "diff"))
+		options->submodule_format = DIFF_SUBMODULE_DIFF;
 	else if (!strcmp(value, "short"))
-		DIFF_OPT_CLR(options, SUBMODULE_LOG);
+		options->submodule_format = DIFF_SUBMODULE_SHORT;
 	else
 		return -1;
 	return 0;
@@ -2306,9 +2308,18 @@ static void builtin_diff(const char *name_a,
 	struct strbuf header = STRBUF_INIT;
 	const char *line_prefix = diff_line_prefix(o);
 
-	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
-			(!one->mode || S_ISGITLINK(one->mode)) &&
-			(!two->mode || S_ISGITLINK(two->mode))) {
+	diff_set_mnemonic_prefix(o, "a/", "b/");
+	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
+		a_prefix = o->b_prefix;
+		b_prefix = o->a_prefix;
+	} else {
+		a_prefix = o->a_prefix;
+		b_prefix = o->b_prefix;
+	}
+
+	if (o->submodule_format == DIFF_SUBMODULE_LOG &&
+	    (!one->mode || S_ISGITLINK(one->mode)) &&
+	    (!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one->path ? one->path : two->path,
@@ -2317,6 +2328,15 @@ static void builtin_diff(const char *name_a,
 				two->dirty_submodule,
 				meta, del, add, reset);
 		return;
+	} else if (o->submodule_format == DIFF_SUBMODULE_DIFF &&
+		   (!one->mode || S_ISGITLINK(one->mode)) &&
+		   (!two->mode || S_ISGITLINK(two->mode))) {
+		show_submodule_diff(o->file, one->path ? one->path : two->path,
+				line_prefix,
+				one->oid.hash, two->oid.hash,
+				two->dirty_submodule,
+				meta, a_prefix, b_prefix, reset);
+		return;
 	}
 
 	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
@@ -2324,15 +2344,6 @@ static void builtin_diff(const char *name_a,
 		textconv_two = get_textconv(two);
 	}
 
-	diff_set_mnemonic_prefix(o, "a/", "b/");
-	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
-		a_prefix = o->b_prefix;
-		b_prefix = o->a_prefix;
-	} else {
-		a_prefix = o->a_prefix;
-		b_prefix = o->b_prefix;
-	}
-
 	/* Never use a non-valid filename anywhere if at all possible */
 	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
 	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;
@@ -3922,7 +3933,7 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, arg);
 	} else if (!strcmp(arg, "--submodule"))
-		DIFF_OPT_SET(options, SUBMODULE_LOG);
+		options->submodule_format = DIFF_SUBMODULE_LOG;
 	else if (skip_prefix(arg, "--submodule=", &arg))
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
diff --git a/diff.h b/diff.h
index 6a91a1139686..3110a2afb3d6 100644
--- a/diff.h
+++ b/diff.h
@@ -83,7 +83,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
 #define DIFF_OPT_DIFF_FROM_CONTENTS  (1 << 22)
-#define DIFF_OPT_SUBMODULE_LOG       (1 << 23)
+/* (1 << 23) unused */
 #define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
@@ -110,6 +110,12 @@ enum diff_words_type {
 	DIFF_WORDS_COLOR
 };
 
+enum diff_submodule_format {
+	DIFF_SUBMODULE_SHORT = 0,
+	DIFF_SUBMODULE_LOG,
+	DIFF_SUBMODULE_DIFF
+};
+
 struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
@@ -156,6 +162,7 @@ struct diff_options {
 	int stat_count;
 	const char *word_regex;
 	enum diff_words_type word_diff;
+	enum diff_submodule_format submodule_format;
 
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
diff --git a/submodule.c b/submodule.c
index 1b5cdfb7e784..36f8fd00c3ce 100644
--- a/submodule.c
+++ b/submodule.c
@@ -333,6 +333,73 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
+void show_submodule_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule, const char *meta,
+		const char *a_prefix, const char *b_prefix,
+		const char *reset)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf submodule_git_dir = STRBUF_INIT;
+	const char *git_dir, *message = NULL;
+	int create_dirty_diff = 0;
+	FILE *diff;
+	char c;
+
+	if ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
+	    (dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
+		create_dirty_diff = 1;
+
+	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
+			find_unique_abbrev(one, DEFAULT_ABBREV));
+	strbuf_addf(&sb, "%s:%s\n", !create_dirty_diff ?
+		    find_unique_abbrev(two, DEFAULT_ABBREV) : "", reset);
+	fwrite(sb.buf, sb.len, 1, f);
+
+	strbuf_addf(&submodule_git_dir, "%s/.git", path);
+	git_dir = read_gitfile(submodule_git_dir.buf);
+	if (!git_dir)
+		git_dir = submodule_git_dir.buf;
+	if (!is_directory(git_dir)) {
+		strbuf_reset(&submodule_git_dir);
+		strbuf_addf(&submodule_git_dir, ".git/modules/%s", path);
+		git_dir = submodule_git_dir.buf;
+	}
+
+	fflush(f);
+
+	cp.git_cmd = 1;
+	if (!create_dirty_diff)
+		cp.dir = git_dir;
+	else
+		cp.dir = path;
+	cp.out = dup(fileno(f));
+	cp.no_stdin = 1;
+	argv_array_push(&cp.args, "diff");
+	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
+	argv_array_pushf(&cp.args, "--src-prefix=%s%s/", a_prefix, path);
+	argv_array_pushf(&cp.args, "--dst-prefix=%s%s/", b_prefix, path);
+	argv_array_push(&cp.args, sha1_to_hex(one));
+
+	/*
+	 * If the submodule has untracked or modified contents don't add the
+	 * current stored commit. Thus, we will diff between the previous
+	 * value and the current tip of working tree. The result is a complete
+	 * diff which shows all changes to the submodule, not just changes
+	 * that have been committed to the super project.
+	 */
+	if (!create_dirty_diff)
+		argv_array_push(&cp.args, sha1_to_hex(two));
+
+	if (run_command(&cp))
+		fprintf(f, "(diff failed)\n");
+
+	strbuf_release(&submodule_git_dir);
+	strbuf_release(&sb);
+}
+
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
diff --git a/submodule.h b/submodule.h
index 2af939099819..f32a25c667ab 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,6 +41,12 @@ int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
+void show_submodule_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule, const char *meta,
+		const char *a_prefix, const char *b_prefix,
+		const char *reset);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
-- 
2.9.2.872.g2dc3c84

