Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5C11F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 23:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbcHOXHQ (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 19:07:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:42712 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322AbcHOXHL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 19:07:11 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP; 15 Aug 2016 16:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,527,1464678000"; 
   d="scan'208";a="1036073630"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2016 16:07:09 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v6 3/3] diff: add SUBMODULE_DIFF format to display submodule diff
Date:	Mon, 15 Aug 2016 16:07:02 -0700
Message-Id: <20160815230702.30817-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.9.2.873.g47c31b4
In-Reply-To: <20160815230702.30817-1-jacob.e.keller@intel.com>
References: <20160815230702.30817-1-jacob.e.keller@intel.com>
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

Add some tests for the new format and option.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/diff-config.txt                |   3 +-
 Documentation/diff-options.txt               |   7 +-
 diff.c                                       |  41 +-
 diff.h                                       |   9 +-
 submodule.c                                  | 130 +++++
 submodule.h                                  |   6 +
 t/t4059-diff-submodule-option-diff-format.sh | 738 +++++++++++++++++++++++++++
 7 files changed, 915 insertions(+), 19 deletions(-)
 create mode 100755 t/t4059-diff-submodule-option-diff-format.sh

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
index cc4342e2034d..d3ca4ad2c2c5 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -215,8 +215,11 @@ any of those replacements occurred.
 	the commits in the range like linkgit:git-submodule[1] `summary` does.
 	Omitting the `--submodule` option or specifying `--submodule=short`,
 	uses the 'short' format. This format just shows the names of the commits
-	at the beginning and end of the range.  Can be tweaked via the
-	`diff.submodule` configuration variable.
+	at the beginning and end of the range. When `--submodule=diff` is
+	given, the 'diff' format is used. This format shows the diff between
+	the old and new submodule commmit from the perspective of the
+	submodule.  Defaults to `diff.submodule` or 'short' if the config
+	option is unset.
 
 --color[=<when>]::
 	Show colored diff.
diff --git a/diff.c b/diff.c
index e286897b51e6..232fbe17680f 100644
--- a/diff.c
+++ b/diff.c
@@ -132,9 +132,11 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
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
@@ -2300,9 +2302,18 @@ static void builtin_diff(const char *name_a,
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
@@ -2311,6 +2322,15 @@ static void builtin_diff(const char *name_a,
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
@@ -2318,15 +2338,6 @@ static void builtin_diff(const char *name_a,
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
@@ -3916,7 +3927,7 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, arg);
 	} else if (!strcmp(arg, "--submodule"))
-		DIFF_OPT_SET(options, SUBMODULE_LOG);
+		options->submodule_format = DIFF_SUBMODULE_LOG;
 	else if (skip_prefix(arg, "--submodule=", &arg))
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
diff --git a/diff.h b/diff.h
index 83d0b1ae8580..abaa9a49c036 100644
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
index 1b5cdfb7e784..b1da68dd49c9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -333,6 +333,136 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
+void show_submodule_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule, const char *meta,
+		const char *a_prefix, const char *b_prefix,
+		const char *reset)
+{
+	struct strbuf submodule_git_dir = STRBUF_INIT, sb = STRBUF_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *git_dir;
+
+	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) {
+		fprintf(f, "%sSubmodule %s contains untracked content\n",
+			line_prefix, path);
+	}
+	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
+		fprintf(f, "%sSubmodule %s contains modified content\n",
+			line_prefix, path);
+	}
+
+	strbuf_addf(&sb, "%s%sSubmodule %s %s..",
+		    line_prefix, meta, path,
+		    find_unique_abbrev(one, DEFAULT_ABBREV));
+	strbuf_addf(&sb, "%s:%s",
+		    find_unique_abbrev(two, DEFAULT_ABBREV),
+		    reset);
+	fwrite(sb.buf, sb.len, 1, f);
+
+	if (is_null_sha1(one))
+		fprintf(f, " (new submodule)");
+	if (is_null_sha1(two))
+		fprintf(f, " (submodule deleted)");
+
+	/*
+	 * We need to determine the most accurate location to call the sub
+	 * command, and handle the various corner cases involved. We'll first
+	 * attempt to use the path directly if the submodule is checked out.
+	 * Then, if that fails, we'll check the standard module location in
+	 * the git directory. If even this fails, it means we can't do the
+	 * lookup because the module has not been initialized.
+	 */
+	strbuf_addf(&submodule_git_dir, "%s/.git", path);
+	git_dir = resolve_gitdir(submodule_git_dir.buf);
+	if (git_dir) {
+		/*
+		 * If we can resolve a git dir, this means that the submodule
+		 * has been checked out. In this case, just use the original
+		 * path since we want access to the work tree
+		 */
+		git_dir = path;
+	} else {
+		/*
+		 * If we can't resolve a git dir, this means that the
+		 * submodule has not been checked out. In this case, try the
+		 * standard location for modules
+		 */
+		strbuf_reset(&submodule_git_dir);
+		strbuf_addf(&submodule_git_dir, "%s/modules/%s", get_git_dir(), path);
+		git_dir = resolve_gitdir(submodule_git_dir.buf);
+		if (!git_dir) {
+			/*
+			 * If we failed to find a git directory here, then the
+			 * submodule must not have been initialized. Without
+			 * the initialized contents of the submodule, we won't
+			 * be able to perform the difference.
+			 */
+			fprintf(f, " (submodule not initialized)\n");
+			goto out;
+		}
+	}
+
+	/*
+	 * print a newline and flush the file so that the diff output appears
+	 * starting on its own line
+	 */
+	fprintf(f, "\n");
+	fflush(f);
+
+	cp.git_cmd = 1;
+	cp.dir = git_dir;
+	cp.out = dup(fileno(f));
+	cp.no_stdin = 1;
+
+	argv_array_push(&cp.args, "diff");
+	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
+	argv_array_pushf(&cp.args, "--src-prefix=%s%s/", a_prefix, path);
+	argv_array_pushf(&cp.args, "--dst-prefix=%s%s/", b_prefix, path);
+
+	if (is_null_sha1(one)) {
+		/*
+		 * If the origin commit is null, we want to use the empty tree
+		 * so that we see a diff of all the new contents added.
+		 */
+		argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
+	} else {
+		/* Use the old commit as the diff base */
+		argv_array_push(&cp.args, sha1_to_hex(one));
+	}
+
+	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
+		/*
+		 * If the submodule has modified contents we want to diff
+		 * against the work tree, so don't add a second parameter.
+		 * This is essentially equivalent of using diff-index instead.
+		 * Note that we can't (easily) show the diff of any untracked
+		 * files.
+		 */
+	} else if (is_null_sha1(two)) {
+		/*
+		 * If new commit is null, we should diff against the empty
+		 * tree, so that we see a diff of all submodule contents
+		 * removed.
+		 */
+		argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
+	} else {
+		/*
+		 * Finally, in other cases use the new commit as the end
+		 * result.
+		 */
+		argv_array_push(&cp.args, sha1_to_hex(two));
+	}
+
+	if (run_command(&cp))
+		fprintf(f, "(diff failed)\n");
+
+out:
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
diff --git a/t/t4059-diff-submodule-option-diff-format.sh b/t/t4059-diff-submodule-option-diff-format.sh
new file mode 100755
index 000000000000..d1306b65986c
--- /dev/null
+++ b/t/t4059-diff-submodule-option-diff-format.sh
@@ -0,0 +1,738 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Jens Lehmann, based on t7401 by Ping Yin
+# Copyright (c) 2011 Alexey Shumkin (+ non-UTF-8 commit encoding tests)
+# Copyright (c) 2016 Jacob Keller (copy + convert to --submodule=diff)
+#
+
+test_description='Support for diff format verbose submodule difference in git diff
+
+This test tries to verify the sanity of --submodule=diff option of git diff.
+'
+
+. ./test-lib.sh
+
+# Tested non-UTF-8 encoding
+test_encoding="ISO8859-1"
+
+# String "added" in German (translated with Google Translate), encoded in UTF-8,
+# used in sample commit log messages in add_file() function below.
+added=$(printf "hinzugef\303\274gt")
+add_file () {
+	(
+		cd "$1" &&
+		shift &&
+		for name
+		do
+			echo "$name" >"$name" &&
+			git add "$name" &&
+			test_tick &&
+			# "git commit -m" would break MinGW, as Windows refuse to pass
+			# $test_encoding encoded parameter to git.
+			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
+			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+		done >/dev/null &&
+		git rev-parse --short --verify HEAD
+	)
+}
+commit_file () {
+	test_tick &&
+	git commit "$@" -m "Commit $*" >/dev/null
+}
+
+test_create_repo sm1 &&
+add_file . foo >/dev/null
+
+head1=$(add_file sm1 foo1 foo2)
+fullhead1=$(cd sm1; git rev-parse --verify HEAD)
+
+test_expect_success 'added submodule' '
+	git add sm1 &&
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 0000000..1beffeb: (new submodule)
+	diff --git a/sm1/foo1 b/sm1/foo1
+	new file mode 100644
+	index 0000000..1715acd
+	--- /dev/null
+	+++ b/sm1/foo1
+	@@ -0,0 +1 @@
+	+foo1
+	diff --git a/sm1/foo2 b/sm1/foo2
+	new file mode 100644
+	index 0000000..54b060e
+	--- /dev/null
+	+++ b/sm1/foo2
+	@@ -0,0 +1 @@
+	+foo2
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'added submodule, set diff.submodule' '
+	git config diff.submodule log &&
+	git add sm1 &&
+	git diff --cached >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 0000000...$head1 (new submodule)
+	EOF
+	git config --unset diff.submodule &&
+	test_cmp expected actual
+'
+
+test_expect_success '--submodule=short overrides diff.submodule' '
+	test_config diff.submodule log &&
+	git add sm1 &&
+	git diff --submodule=short --cached >actual &&
+	cat >expected <<-EOF &&
+	diff --git a/sm1 b/sm1
+	new file mode 160000
+	index 0000000..$head1
+	--- /dev/null
+	+++ b/sm1
+	@@ -0,0 +1 @@
+	+Subproject commit $fullhead1
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'diff.submodule does not affect plumbing' '
+	test_config diff.submodule log &&
+	git diff-index -p HEAD >actual &&
+	cat >expected <<-EOF &&
+	diff --git a/sm1 b/sm1
+	new file mode 160000
+	index 0000000..$head1
+	--- /dev/null
+	+++ b/sm1
+	@@ -0,0 +1 @@
+	+Subproject commit $fullhead1
+	EOF
+	test_cmp expected actual
+'
+
+commit_file sm1 &&
+head2=$(add_file sm1 foo3)
+
+test_expect_success 'modified submodule(forward)' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 1beffeb..30b9670:
+	diff --git a/sm1/foo3 b/sm1/foo3
+	new file mode 100644
+	index 0000000..c1ec6c6
+	--- /dev/null
+	+++ b/sm1/foo3
+	@@ -0,0 +1 @@
+	+foo3
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'modified submodule(forward)' '
+	git diff --submodule=diff >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 1beffeb..30b9670:
+	diff --git a/sm1/foo3 b/sm1/foo3
+	new file mode 100644
+	index 0000000..c1ec6c6
+	--- /dev/null
+	+++ b/sm1/foo3
+	@@ -0,0 +1 @@
+	+foo3
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'modified submodule(forward) --submodule' '
+	git diff --submodule >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 $head1..$head2:
+	  > Add foo3 ($added foo3)
+	EOF
+	test_cmp expected actual
+'
+
+fullhead2=$(cd sm1; git rev-parse --verify HEAD)
+test_expect_success 'modified submodule(forward) --submodule=short' '
+	git diff --submodule=short >actual &&
+	cat >expected <<-EOF &&
+	diff --git a/sm1 b/sm1
+	index $head1..$head2 160000
+	--- a/sm1
+	+++ b/sm1
+	@@ -1 +1 @@
+	-Subproject commit $fullhead1
+	+Subproject commit $fullhead2
+	EOF
+	test_cmp expected actual
+'
+
+commit_file sm1 &&
+head3=$(
+	cd sm1 &&
+	git reset --hard HEAD~2 >/dev/null &&
+	git rev-parse --short --verify HEAD
+)
+
+test_expect_success 'modified submodule(backward)' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 30b9670..dafb207:
+	diff --git a/sm1/foo2 b/sm1/foo2
+	deleted file mode 100644
+	index 54b060e..0000000
+	--- a/sm1/foo2
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo2
+	diff --git a/sm1/foo3 b/sm1/foo3
+	deleted file mode 100644
+	index c1ec6c6..0000000
+	--- a/sm1/foo3
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo3
+	EOF
+	test_cmp expected actual
+'
+
+head4=$(add_file sm1 foo4 foo5)
+test_expect_success 'modified submodule(backward and forward)' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 30b9670..d176589:
+	diff --git a/sm1/foo2 b/sm1/foo2
+	deleted file mode 100644
+	index 54b060e..0000000
+	--- a/sm1/foo2
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo2
+	diff --git a/sm1/foo3 b/sm1/foo3
+	deleted file mode 100644
+	index c1ec6c6..0000000
+	--- a/sm1/foo3
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo3
+	diff --git a/sm1/foo4 b/sm1/foo4
+	new file mode 100644
+	index 0000000..a0016db
+	--- /dev/null
+	+++ b/sm1/foo4
+	@@ -0,0 +1 @@
+	+foo4
+	diff --git a/sm1/foo5 b/sm1/foo5
+	new file mode 100644
+	index 0000000..d6f2413
+	--- /dev/null
+	+++ b/sm1/foo5
+	@@ -0,0 +1 @@
+	+foo5
+	EOF
+	test_cmp expected actual
+'
+
+commit_file sm1 &&
+mv sm1 sm1-bak &&
+echo sm1 >sm1 &&
+head5=$(git hash-object sm1 | cut -c1-7) &&
+git add sm1 &&
+rm -f sm1 &&
+mv sm1-bak sm1
+
+test_expect_success 'typechanged submodule(submodule->blob), --cached' '
+	git diff --submodule=diff --cached >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 d176589..0000000: (submodule deleted)
+	diff --git a/sm1/foo1 b/sm1/foo1
+	deleted file mode 100644
+	index 1715acd..0000000
+	--- a/sm1/foo1
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo1
+	diff --git a/sm1/foo4 b/sm1/foo4
+	deleted file mode 100644
+	index a0016db..0000000
+	--- a/sm1/foo4
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo4
+	diff --git a/sm1/foo5 b/sm1/foo5
+	deleted file mode 100644
+	index d6f2413..0000000
+	--- a/sm1/foo5
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-foo5
+	diff --git a/sm1 b/sm1
+	new file mode 100644
+	index 0000000..9da5fb8
+	--- /dev/null
+	+++ b/sm1
+	@@ -0,0 +1 @@
+	+sm1
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'typechanged submodule(submodule->blob)' '
+	git diff --submodule=diff >actual &&
+	cat >expected <<-EOF &&
+	diff --git a/sm1 b/sm1
+	deleted file mode 100644
+	index 9da5fb8..0000000
+	--- a/sm1
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-sm1
+	Submodule sm1 0000000..d176589: (new submodule)
+	diff --git a/sm1/foo1 b/sm1/foo1
+	new file mode 100644
+	index 0000000..1715acd
+	--- /dev/null
+	+++ b/sm1/foo1
+	@@ -0,0 +1 @@
+	+foo1
+	diff --git a/sm1/foo4 b/sm1/foo4
+	new file mode 100644
+	index 0000000..a0016db
+	--- /dev/null
+	+++ b/sm1/foo4
+	@@ -0,0 +1 @@
+	+foo4
+	diff --git a/sm1/foo5 b/sm1/foo5
+	new file mode 100644
+	index 0000000..d6f2413
+	--- /dev/null
+	+++ b/sm1/foo5
+	@@ -0,0 +1 @@
+	+foo5
+	EOF
+	test_cmp expected actual
+'
+
+rm -rf sm1 &&
+git checkout-index sm1
+test_expect_success 'typechanged submodule(submodule->blob)' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 $head4..0000000: (submodule deleted) (submodule not initialized)
+	diff --git a/sm1 b/sm1
+	new file mode 100644
+	index 0000000..$head5
+	--- /dev/null
+	+++ b/sm1
+	@@ -0,0 +1 @@
+	+sm1
+	EOF
+	test_cmp expected actual
+'
+
+rm -f sm1 &&
+test_create_repo sm1 &&
+head6=$(add_file sm1 foo6 foo7)
+fullhead6=$(cd sm1; git rev-parse --verify HEAD)
+test_expect_success 'nonexistent commit' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 d176589..17243c9:
+	(diff failed)
+	EOF
+	test_cmp expected actual
+'
+
+commit_file
+test_expect_success 'typechanged submodule(blob->submodule)' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	diff --git a/sm1 b/sm1
+	deleted file mode 100644
+	index 9da5fb8..0000000
+	--- a/sm1
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-sm1
+	Submodule sm1 0000000..17243c9: (new submodule)
+	diff --git a/sm1/foo6 b/sm1/foo6
+	new file mode 100644
+	index 0000000..462398b
+	--- /dev/null
+	+++ b/sm1/foo6
+	@@ -0,0 +1 @@
+	+foo6
+	diff --git a/sm1/foo7 b/sm1/foo7
+	new file mode 100644
+	index 0000000..6e9262c
+	--- /dev/null
+	+++ b/sm1/foo7
+	@@ -0,0 +1 @@
+	+foo7
+	EOF
+	test_cmp expected actual
+'
+
+commit_file sm1 &&
+test_expect_success 'submodule is up to date' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule contains untracked content' '
+	echo new > sm1/new-file &&
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 contains untracked content
+	Submodule sm1 17243c9..17243c9:
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule contains untracked content (untracked ignored)' '
+	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	! test -s actual
+'
+
+test_expect_success 'submodule contains untracked content (dirty ignored)' '
+	git diff-index -p --ignore-submodules=dirty --submodule=diff HEAD >actual &&
+	! test -s actual
+'
+
+test_expect_success 'submodule contains untracked content (all ignored)' '
+	git diff-index -p --ignore-submodules=all --submodule=diff HEAD >actual &&
+	! test -s actual
+'
+
+test_expect_success 'submodule contains untracked and modified content' '
+	echo new > sm1/foo6 &&
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 contains untracked content
+	Submodule sm1 contains modified content
+	Submodule sm1 17243c9..17243c9:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..3e75765 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1 @@
+	-foo6
+	+new
+	EOF
+	test_cmp expected actual
+'
+
+# NOT OK
+test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
+	echo new > sm1/foo6 &&
+	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 contains modified content
+	Submodule sm1 17243c9..17243c9:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..3e75765 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1 @@
+	-foo6
+	+new
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule contains untracked and modified content (dirty ignored)' '
+	echo new > sm1/foo6 &&
+	git diff-index -p --ignore-submodules=dirty --submodule=diff HEAD >actual &&
+	! test -s actual
+'
+
+test_expect_success 'submodule contains untracked and modified content (all ignored)' '
+	echo new > sm1/foo6 &&
+	git diff-index -p --ignore-submodules --submodule=diff HEAD >actual &&
+	! test -s actual
+'
+
+test_expect_success 'submodule contains modified content' '
+	rm -f sm1/new-file &&
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 contains modified content
+	Submodule sm1 17243c9..17243c9:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..3e75765 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1 @@
+	-foo6
+	+new
+	EOF
+	test_cmp expected actual
+'
+
+(cd sm1; git commit -mchange foo6 >/dev/null) &&
+head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
+test_expect_success 'submodule is modified' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 17243c9..cfce562:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..3e75765 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1 @@
+	-foo6
+	+new
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'modified submodule contains untracked content' '
+	echo new > sm1/new-file &&
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 contains untracked content
+	Submodule sm1 17243c9..cfce562:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..3e75765 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1 @@
+	-foo6
+	+new
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
+	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 17243c9..cfce562:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..3e75765 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1 @@
+	-foo6
+	+new
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'modified submodule contains untracked content (dirty ignored)' '
+	git diff-index -p --ignore-submodules=dirty --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 17243c9..cfce562:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..3e75765 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1 @@
+	-foo6
+	+new
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'modified submodule contains untracked content (all ignored)' '
+	git diff-index -p --ignore-submodules=all --submodule=diff HEAD >actual &&
+	! test -s actual
+'
+
+test_expect_success 'modified submodule contains untracked and modified content' '
+	echo modification >> sm1/foo6 &&
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 contains untracked content
+	Submodule sm1 contains modified content
+	Submodule sm1 17243c9..cfce562:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..dfda541 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1,2 @@
+	-foo6
+	+new
+	+modification
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
+	echo modification >> sm1/foo6 &&
+	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 contains modified content
+	Submodule sm1 17243c9..cfce562:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..e20e2d9 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1,3 @@
+	-foo6
+	+new
+	+modification
+	+modification
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'modified submodule contains untracked and modified content (dirty ignored)' '
+	echo modification >> sm1/foo6 &&
+	git diff-index -p --ignore-submodules=dirty --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 17243c9..cfce562:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..3e75765 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1 @@
+	-foo6
+	+new
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'modified submodule contains untracked and modified content (all ignored)' '
+	echo modification >> sm1/foo6 &&
+	git diff-index -p --ignore-submodules --submodule=diff HEAD >actual &&
+	! test -s actual
+'
+
+# NOT OK
+test_expect_success 'modified submodule contains modified content' '
+	rm -f sm1/new-file &&
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 contains modified content
+	Submodule sm1 17243c9..cfce562:
+	diff --git a/sm1/foo6 b/sm1/foo6
+	index 462398b..ac466ca 100644
+	--- a/sm1/foo6
+	+++ b/sm1/foo6
+	@@ -1 +1,5 @@
+	-foo6
+	+new
+	+modification
+	+modification
+	+modification
+	+modification
+	EOF
+	test_cmp expected actual
+'
+
+rm -rf sm1
+test_expect_success 'deleted submodule' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 17243c9..0000000: (submodule deleted) (submodule not initialized)
+	EOF
+	test_cmp expected actual
+'
+
+test_create_repo sm2 &&
+head7=$(add_file sm2 foo8 foo9) &&
+git add sm2
+
+test_expect_success 'multiple submodules' '
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 17243c9..0000000: (submodule deleted) (submodule not initialized)
+	Submodule sm2 0000000..a5a65c9: (new submodule)
+	diff --git a/sm2/foo8 b/sm2/foo8
+	new file mode 100644
+	index 0000000..db9916b
+	--- /dev/null
+	+++ b/sm2/foo8
+	@@ -0,0 +1 @@
+	+foo8
+	diff --git a/sm2/foo9 b/sm2/foo9
+	new file mode 100644
+	index 0000000..9c3b4f6
+	--- /dev/null
+	+++ b/sm2/foo9
+	@@ -0,0 +1 @@
+	+foo9
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'path filter' '
+	git diff-index -p --submodule=diff HEAD sm2 >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 0000000..a5a65c9: (new submodule)
+	diff --git a/sm2/foo8 b/sm2/foo8
+	new file mode 100644
+	index 0000000..db9916b
+	--- /dev/null
+	+++ b/sm2/foo8
+	@@ -0,0 +1 @@
+	+foo8
+	diff --git a/sm2/foo9 b/sm2/foo9
+	new file mode 100644
+	index 0000000..9c3b4f6
+	--- /dev/null
+	+++ b/sm2/foo9
+	@@ -0,0 +1 @@
+	+foo9
+	EOF
+	test_cmp expected actual
+'
+
+commit_file sm2
+test_expect_success 'given commit' '
+	git diff-index -p --submodule=diff HEAD^ >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 17243c9..0000000: (submodule deleted) (submodule not initialized)
+	Submodule sm2 0000000..a5a65c9: (new submodule)
+	diff --git a/sm2/foo8 b/sm2/foo8
+	new file mode 100644
+	index 0000000..db9916b
+	--- /dev/null
+	+++ b/sm2/foo8
+	@@ -0,0 +1 @@
+	+foo8
+	diff --git a/sm2/foo9 b/sm2/foo9
+	new file mode 100644
+	index 0000000..9c3b4f6
+	--- /dev/null
+	+++ b/sm2/foo9
+	@@ -0,0 +1 @@
+	+foo9
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'setup .git file for sm2' '
+	(cd sm2 &&
+	 REAL="$(pwd)/../.real" &&
+	 mv .git "$REAL"
+	 echo "gitdir: $REAL" >.git)
+'
+
+test_expect_success 'diff --submodule=diff with .git file' '
+	git diff --submodule=diff HEAD^ >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 17243c9..0000000: (submodule deleted) (submodule not initialized)
+	Submodule sm2 0000000..a5a65c9: (new submodule)
+	diff --git a/sm2/foo8 b/sm2/foo8
+	new file mode 100644
+	index 0000000..db9916b
+	--- /dev/null
+	+++ b/sm2/foo8
+	@@ -0,0 +1 @@
+	+foo8
+	diff --git a/sm2/foo9 b/sm2/foo9
+	new file mode 100644
+	index 0000000..9c3b4f6
+	--- /dev/null
+	+++ b/sm2/foo9
+	@@ -0,0 +1 @@
+	+foo9
+	EOF
+	test_cmp expected actual
+'
+
+test_done
-- 
2.9.2.873.g47c31b4

