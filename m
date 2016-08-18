Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704FF1FD99
	for <e@80x24.org>; Thu, 18 Aug 2016 00:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbcHRAvj (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 20:51:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:3579 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753935AbcHRAvi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 20:51:38 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP; 17 Aug 2016 17:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,536,1464678000"; 
   d="scan'208";a="157475900"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2016 17:51:34 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v7 7/7] diff: teach diff to display submodule difference with an inline diff
Date:	Wed, 17 Aug 2016 17:51:31 -0700
Message-Id: <20160818005131.31600-8-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.217.g609f9e8.dirty
In-Reply-To: <20160818005131.31600-1-jacob.e.keller@intel.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Teach git-diff and friends a new format for displaying the difference
of a submodule. The new format is an inline diff of the contents of the
submodule between the commit range of the update. This allows the user
to see the actual code change caused by a submodule update.

Add tests for the new format and option.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/diff-config.txt                |   9 +-
 Documentation/diff-options.txt               |  17 +-
 diff.c                                       |  31 +-
 diff.h                                       |   1 +
 submodule.c                                  |  61 +++
 submodule.h                                  |   6 +
 t/t4059-diff-submodule-option-diff-format.sh | 733 +++++++++++++++++++++++++++
 7 files changed, 838 insertions(+), 20 deletions(-)
 create mode 100755 t/t4059-diff-submodule-option-diff-format.sh

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index d5a5b17d5088..0eded24034b5 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -122,10 +122,11 @@ diff.suppressBlankEmpty::
 
 diff.submodule::
 	Specify the format in which differences in submodules are
-	shown.  The "log" format lists the commits in the range like
-	linkgit:git-submodule[1] `summary` does.  The "short" format
-	format just shows the names of the commits at the beginning
-	and end of the range.  Defaults to short.
+	shown.  The "short" format just shows the names of the commits
+	at the beginning and end of the range. The "log" format lists
+	the commits in the range like linkgit:git-submodule[1] `summary`
+	does. The "diff" format shows an inline diff of the changed
+	contents of the submodule. Defaults to "short".
 
 diff.wordRegex::
 	A POSIX Extended Regular Expression used to determine what is a "word"
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index cc4342e2034d..7805a0ccadf2 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -210,13 +210,16 @@ any of those replacements occurred.
 	of the `--diff-filter` option on what the status letters mean.
 
 --submodule[=<format>]::
-	Specify how differences in submodules are shown.  When `--submodule`
-	or `--submodule=log` is given, the 'log' format is used.  This format lists
-	the commits in the range like linkgit:git-submodule[1] `summary` does.
-	Omitting the `--submodule` option or specifying `--submodule=short`,
-	uses the 'short' format. This format just shows the names of the commits
-	at the beginning and end of the range.  Can be tweaked via the
-	`diff.submodule` configuration variable.
+	Specify how differences in submodules are shown.  When specifying
+	`--submodule=short` the 'short' format is used.  This format just
+	shows the names of the commits at the beginning and end of the range.
+	When `--submodule` or `--submodule=log` is specified, the 'log'
+	format is used.  This format lists the commits in the range like
+	linkgit:git-submodule[1] `summary` does.  When `--submodule=diff`
+	is specified, the 'diff' format is used.  This format shows an
+	inline diff of the changes in the submodule contents between the
+	commit range.  Defaults to `diff.submodule` or the 'short' format
+	if the config option is unset.
 
 --color[=<when>]::
 	Show colored diff.
diff --git a/diff.c b/diff.c
index d6b321da3d1d..e119758aba82 100644
--- a/diff.c
+++ b/diff.c
@@ -135,6 +135,8 @@ static int parse_submodule_params(struct diff_options *options, const char *valu
 		options->submodule_format = DIFF_SUBMODULE_LOG;
 	else if (!strcmp(value, "short"))
 		options->submodule_format = DIFF_SUBMODULE_SHORT;
+	else if (!strcmp(value, "diff"))
+		options->submodule_format = DIFF_SUBMODULE_INLINE_DIFF;
 	else
 		return -1;
 	return 0;
@@ -2300,6 +2302,15 @@ static void builtin_diff(const char *name_a,
 	struct strbuf header = STRBUF_INIT;
 	const char *line_prefix = diff_line_prefix(o);
 
+	diff_set_mnemonic_prefix(o, "a/", "b/");
+	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
+		a_prefix = o->b_prefix;
+		b_prefix = o->a_prefix;
+	} else {
+		a_prefix = o->a_prefix;
+		b_prefix = o->b_prefix;
+	}
+
 	if (o->submodule_format == DIFF_SUBMODULE_LOG &&
 	    (!one->mode || S_ISGITLINK(one->mode)) &&
 	    (!two->mode || S_ISGITLINK(two->mode))) {
@@ -2311,6 +2322,17 @@ static void builtin_diff(const char *name_a,
 				two->dirty_submodule,
 				meta, del, add, reset);
 		return;
+	} else if (o->submodule_format == DIFF_SUBMODULE_INLINE_DIFF &&
+		   (!one->mode || S_ISGITLINK(one->mode)) &&
+		   (!two->mode || S_ISGITLINK(two->mode))) {
+		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
+		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
+		show_submodule_inline_diff(o->file, one->path ? one->path : two->path,
+				line_prefix,
+				one->oid.hash, two->oid.hash,
+				two->dirty_submodule,
+				meta, del, add, reset, o);
+		return;
 	}
 
 	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
@@ -2318,15 +2340,6 @@ static void builtin_diff(const char *name_a,
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
diff --git a/diff.h b/diff.h
index ea5aba668eaa..192c0eedd0ff 100644
--- a/diff.h
+++ b/diff.h
@@ -112,6 +112,7 @@ enum diff_words_type {
 enum diff_submodule_format {
 	DIFF_SUBMODULE_SHORT = 0,
 	DIFF_SUBMODULE_LOG,
+	DIFF_SUBMODULE_INLINE_DIFF,
 };
 
 struct diff_options {
diff --git a/submodule.c b/submodule.c
index e341ca7ffefd..e5f1138f4362 100644
--- a/submodule.c
+++ b/submodule.c
@@ -436,6 +436,67 @@ void show_submodule_summary(FILE *f, const char *path,
 		clear_commit_marks(right, ~0);
 }
 
+void show_submodule_inline_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule, const char *meta,
+		const char *del, const char *add, const char *reset,
+		const struct diff_options *o)
+{
+	const char *old = EMPTY_TREE_SHA1_BIN, *new = EMPTY_TREE_SHA1_BIN;
+	struct commit *left = NULL, *right = NULL;
+	struct strbuf submodule_dir = STRBUF_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
+			      meta, reset, &left, &right);
+
+	/* We need a valid left and right commit to display a difference */
+	if (!(left || is_null_sha1(one)) ||
+	    !(right || is_null_sha1(two)))
+		goto done;
+
+	if (left)
+		old = one;
+	if (right)
+		new = two;
+
+	fflush(f);
+	cp.git_cmd = 1;
+	cp.dir = path;
+	cp.out = dup(fileno(f));
+	cp.no_stdin = 1;
+
+	/* TODO: other options may need to be passed here. */
+	argv_array_pushl(&cp.args, "diff");
+	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
+	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
+		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
+				 o->b_prefix, path);
+		argv_array_pushf(&cp.args, "--dst-prefix=%s%s/",
+				 o->a_prefix, path);
+	} else {
+		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
+				 o->a_prefix, path);
+		argv_array_pushf(&cp.args, "--dst-prefix=%s%s/",
+				 o->b_prefix, path);
+	}
+	argv_array_push(&cp.args, sha1_to_hex(old));
+	/* If the submodule has modified content, we will diff against the
+	 * work tree, under the assumption that the user has asked for the
+	 * diff format and wishes to actually see all differences even if they
+	 * haven't yet been committed to the submodule yet.
+	 */
+	if (!(dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
+		argv_array_push(&cp.args, sha1_to_hex(new));
+
+	if (run_command(&cp))
+		fprintf(f, "(diff failed)\n");
+
+done:
+	strbuf_release(&submodule_dir);
+}
+
 void set_config_fetch_recurse_submodules(int value)
 {
 	config_fetch_recurse_submodules = value;
diff --git a/submodule.h b/submodule.h
index 2af939099819..e2ebc0756f6a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -46,6 +46,12 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
+void show_submodule_inline_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		unsigned char one[20], unsigned char two[20],
+		unsigned dirty_submodule, const char *meta,
+		const char *del, const char *add, const char *reset,
+		const struct diff_options *opt);
 void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
diff --git a/t/t4059-diff-submodule-option-diff-format.sh b/t/t4059-diff-submodule-option-diff-format.sh
new file mode 100755
index 000000000000..88484f1ba847
--- /dev/null
+++ b/t/t4059-diff-submodule-option-diff-format.sh
@@ -0,0 +1,733 @@
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
+	Submodule sm1 0000000...1beffeb (new submodule)
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
+	Submodule sm1 30b9670..dafb207 (rewind):
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
+	Submodule sm1 30b9670...d176589:
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
+	Submodule sm1 d176589...0000000 (submodule deleted)
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
+	Submodule sm1 0000000...d176589 (new submodule)
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
+	Submodule sm1 $head4...0000000 (submodule deleted)
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
+	Submodule sm1 d176589...17243c9 (commits not present)
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
+	Submodule sm1 0000000...17243c9 (new submodule)
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
+	Submodule sm1 17243c9...0000000 (submodule deleted)
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
+	Submodule sm1 17243c9...0000000 (submodule deleted)
+	Submodule sm2 0000000...a5a65c9 (new submodule)
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
+	Submodule sm2 0000000...a5a65c9 (new submodule)
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
+	Submodule sm1 17243c9...0000000 (submodule deleted)
+	Submodule sm2 0000000...a5a65c9 (new submodule)
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
+	Submodule sm1 17243c9...0000000 (submodule deleted)
+	Submodule sm2 0000000...a5a65c9 (new submodule)
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
2.10.0.rc0.217.g609f9e8.dirty

