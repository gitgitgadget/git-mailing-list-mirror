Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251FE1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 23:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758287AbcHYXhV (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 19:37:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:23240 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758151AbcHYXg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 19:36:56 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP; 25 Aug 2016 16:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,578,1464678000"; 
   d="scan'208";a="161062171"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2016 16:32:47 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v11 8/8] diff: teach diff to display submodule difference with an inline diff
Date:   Thu, 25 Aug 2016 16:32:43 -0700
Message-Id: <20160825233243.30700-9-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
In-Reply-To: <20160825233243.30700-1-jacob.e.keller@intel.com>
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 diff.h                                       |   3 +-
 submodule.c                                  |  69 +++
 submodule.h                                  |   6 +
 t/t4060-diff-submodule-option-diff-format.sh | 749 +++++++++++++++++++++++++++
 7 files changed, 863 insertions(+), 21 deletions(-)
 create mode 100755 t/t4060-diff-submodule-option-diff-format.sh

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
index 16253b191f53..b38d95eb249c 100644
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
+				&one->oid, &two->oid,
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
index 43b353aea091..ec76a90522ea 100644
--- a/diff.h
+++ b/diff.h
@@ -111,7 +111,8 @@ enum diff_words_type {
 
 enum diff_submodule_format {
 	DIFF_SUBMODULE_SHORT = 0,
-	DIFF_SUBMODULE_LOG
+	DIFF_SUBMODULE_LOG,
+	DIFF_SUBMODULE_INLINE_DIFF
 };
 
 struct diff_options {
diff --git a/submodule.c b/submodule.c
index 2d88c555895d..5a62aa296098 100644
--- a/submodule.c
+++ b/submodule.c
@@ -442,6 +442,75 @@ void show_submodule_summary(FILE *f, const char *path,
 	clear_commit_marks(right, ~0);
 }
 
+void show_submodule_inline_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		struct object_id *one, struct object_id *two,
+		unsigned dirty_submodule, const char *meta,
+		const char *del, const char *add, const char *reset,
+		const struct diff_options *o)
+{
+	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
+	struct commit *left = NULL, *right = NULL;
+	struct commit_list *merge_bases = NULL;
+	struct strbuf submodule_dir = STRBUF_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
+			      meta, reset, &left, &right, &merge_bases);
+
+	/* We need a valid left and right commit to display a difference */
+	if (!(left || is_null_oid(one)) ||
+	    !(right || is_null_oid(two)))
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
+	argv_array_push(&cp.args, "diff");
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
+	argv_array_push(&cp.args, oid_to_hex(old));
+	/*
+	 * If the submodule has modified content, we will diff against the
+	 * work tree, under the assumption that the user has asked for the
+	 * diff format and wishes to actually see all differences even if they
+	 * haven't yet been committed to the submodule yet.
+	 */
+	if (!(dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
+		argv_array_push(&cp.args, oid_to_hex(new));
+
+	if (run_command(&cp))
+		fprintf(f, "(diff failed)\n");
+
+done:
+	strbuf_release(&submodule_dir);
+	if (merge_bases)
+		free_commit_list(merge_bases);
+	if (left)
+		clear_commit_marks(left, ~0);
+	if (right)
+		clear_commit_marks(right, ~0);
+}
+
 void set_config_fetch_recurse_submodules(int value)
 {
 	config_fetch_recurse_submodules = value;
diff --git a/submodule.h b/submodule.h
index d83df57e24ff..d9e197a948fd 100644
--- a/submodule.h
+++ b/submodule.h
@@ -46,6 +46,12 @@ void show_submodule_summary(FILE *f, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
+void show_submodule_inline_diff(FILE *f, const char *path,
+		const char *line_prefix,
+		struct object_id *one, struct object_id *two,
+		unsigned dirty_submodule, const char *meta,
+		const char *del, const char *add, const char *reset,
+		const struct diff_options *opt);
 void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
new file mode 100755
index 000000000000..7e23b55ea4c5
--- /dev/null
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -0,0 +1,749 @@
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
+
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
+
+commit_file () {
+	test_tick &&
+	git commit "$@" -m "Commit $*" >/dev/null
+}
+
+test_expect_success 'setup repository' '
+	test_create_repo sm1 &&
+	add_file . foo &&
+	head1=$(add_file sm1 foo1 foo2) &&
+	fullhead1=$(git -C sm1 rev-parse --verify HEAD)
+'
+
+test_expect_success 'added submodule' '
+	git add sm1 &&
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 0000000...$head1 (new submodule)
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
+	test_config diff.submodule log &&
+	git add sm1 &&
+	git diff-index -p --submodule=diff HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm1 0000000...$head1 (new submodule)
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
+	Submodule sm1 $head1..$head2:
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
+	Submodule sm1 $head1..$head2:
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
+	Submodule sm1 $head2..$head3 (rewind):
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
+	Submodule sm1 $head2...$head4:
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
+	Submodule sm1 $head4...0000000 (submodule deleted)
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
+	Submodule sm1 0000000...$head4 (new submodule)
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
+	index 0000000..9da5fb8
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
+	Submodule sm1 $head4...$head6 (commits not present)
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
+	Submodule sm1 0000000...$head6 (new submodule)
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
+	Submodule sm1 17243c9..$head8:
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
+	Submodule sm1 17243c9..$head8:
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
+	Submodule sm1 17243c9..$head8:
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
2.10.0.rc0.259.g83512d9

