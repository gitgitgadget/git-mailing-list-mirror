Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24E61F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbcHSA4K (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:56:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:18431 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754245AbcHSAy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:54:26 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP; 18 Aug 2016 17:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,542,1464678000"; 
   d="scan'208";a="867906838"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2016 17:00:37 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v8 0/8] submodule show inline diff
Date:   Thu, 18 Aug 2016 17:00:23 -0700
Message-Id: <20160819000031.24854-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.217.g609f9e8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

v8 has changes suggested by Junio and Stefan Beller, as well as a few
modifications of my own, plus more tests.

Series interdiff of v7 and v8:
diff --git c/builtin/rev-list.c w/builtin/rev-list.c
index 1a75a83538f4..21cde8dd6b31 100644
--- c/builtin/rev-list.c
+++ w/builtin/rev-list.c
@@ -129,20 +129,20 @@ static void show_commit(struct commit *commit, void *data)
 			graph_show_commit_msg(revs->graph, stdout, &buf);
 
 			/*
-				* Add a newline after the commit message.
-				*
-				* Usually, this newline produces a blank
-				* padding line between entries, in which case
-				* we need to add graph padding on this line.
-				*
-				* However, the commit message may not end in a
-				* newline.  In this case the newline simply
-				* ends the last line of the commit message,
-				* and we don't need any graph output.  (This
-				* always happens with CMIT_FMT_ONELINE, and it
-				* happens with CMIT_FMT_USERFORMAT when the
-				* format doesn't explicitly end in a newline.)
-				*/
+			* Add a newline after the commit message.
+			*
+			* Usually, this newline produces a blank
+			* padding line between entries, in which case
+			* we need to add graph padding on this line.
+			*
+			* However, the commit message may not end in a
+			* newline.  In this case the newline simply
+			* ends the last line of the commit message,
+			* and we don't need any graph output.  (This
+			* always happens with CMIT_FMT_ONELINE, and it
+			* happens with CMIT_FMT_USERFORMAT when the
+			* format doesn't explicitly end in a newline.)
+			*/
 			if (buf.len && buf.buf[buf.len - 1] == '\n')
 				graph_show_padding(revs->graph);
 			putchar('\n');
diff --git c/cache.h w/cache.h
index f30a4417efdf..da9f0be67d7b 100644
--- c/cache.h
+++ w/cache.h
@@ -964,6 +964,8 @@ static inline void oidclr(struct object_id *oid)
 #define EMPTY_BLOB_SHA1_BIN \
 	((const unsigned char *) EMPTY_BLOB_SHA1_BIN_LITERAL)
 
+extern const struct object_id empty_tree_oid;
+
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
 {
 	return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
diff --git c/diff.c w/diff.c
index e119758aba82..b38d95eb249c 100644
--- c/diff.c
+++ w/diff.c
@@ -2318,7 +2318,7 @@ static void builtin_diff(const char *name_a,
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one->path ? one->path : two->path,
 				line_prefix,
-				one->oid.hash, two->oid.hash,
+				&one->oid, &two->oid,
 				two->dirty_submodule,
 				meta, del, add, reset);
 		return;
@@ -2329,7 +2329,7 @@ static void builtin_diff(const char *name_a,
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_inline_diff(o->file, one->path ? one->path : two->path,
 				line_prefix,
-				one->oid.hash, two->oid.hash,
+				&one->oid, &two->oid,
 				two->dirty_submodule,
 				meta, del, add, reset, o);
 		return;
diff --git c/graph.c w/graph.c
index b140c096b7f3..06f1139f2e20 100644
--- c/graph.c
+++ w/graph.c
@@ -1215,10 +1215,10 @@ void graph_show_commit(struct git_graph *graph)
 	struct strbuf msgbuf = STRBUF_INIT;
 	int shown_commit_line = 0;
 
-	if (!graph) {
-		graph_show_line_prefix(default_diffopt);
+	graph_show_line_prefix(default_diffopt);
+
+	if (!graph)
 		return;
-	}
 
 	/*
 	 * When showing a diff of a merge against each of its parents, we
@@ -1232,11 +1232,12 @@ void graph_show_commit(struct git_graph *graph)
 
 	while (!shown_commit_line && !graph_is_commit_finished(graph)) {
 		shown_commit_line = graph_next_line(graph, &msgbuf);
-		graph_show_line_prefix(&graph->revs->diffopt);
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len,
 			graph->revs->diffopt.file);
-		if (!shown_commit_line)
+		if (!shown_commit_line) {
 			putc('\n', graph->revs->diffopt.file);
+			graph_show_line_prefix(&graph->revs->diffopt);
+		}
 		strbuf_setlen(&msgbuf, 0);
 	}
 
@@ -1247,13 +1248,12 @@ void graph_show_oneline(struct git_graph *graph)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
 
-	if (!graph) {
-		graph_show_line_prefix(default_diffopt);
+	graph_show_line_prefix(default_diffopt);
+
+	if (!graph)
 		return;
-	}
 
 	graph_next_line(graph, &msgbuf);
-	graph_show_line_prefix(&graph->revs->diffopt);
 	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, graph->revs->diffopt.file);
 	strbuf_release(&msgbuf);
 }
@@ -1262,13 +1262,12 @@ void graph_show_padding(struct git_graph *graph)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
 
-	if (!graph) {
-		graph_show_line_prefix(default_diffopt);
+	graph_show_line_prefix(default_diffopt);
+
+	if (!graph)
 		return;
-	}
 
 	graph_padding_line(graph, &msgbuf);
-	graph_show_line_prefix(&graph->revs->diffopt);
 	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, graph->revs->diffopt.file);
 	strbuf_release(&msgbuf);
 }
@@ -1278,28 +1277,27 @@ int graph_show_remainder(struct git_graph *graph)
 	struct strbuf msgbuf = STRBUF_INIT;
 	int shown = 0;
 
-	if (!graph) {
-		graph_show_line_prefix(default_diffopt);
-		return 0;
-	}
+	graph_show_line_prefix(default_diffopt);
 
-	if (graph_is_commit_finished(graph)) {
-		graph_show_line_prefix(&graph->revs->diffopt);
+	if (!graph)
+		return 0;
+
+	if (graph_is_commit_finished(graph))
 		return 0;
-	}
 
 	for (;;) {
 		graph_next_line(graph, &msgbuf);
-		graph_show_line_prefix(&graph->revs->diffopt);
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len,
 			graph->revs->diffopt.file);
 		strbuf_setlen(&msgbuf, 0);
 		shown = 1;
 
-		if (!graph_is_commit_finished(graph))
+		if (!graph_is_commit_finished(graph)) {
 			putc('\n', graph->revs->diffopt.file);
-		else
+			graph_show_line_prefix(&graph->revs->diffopt);
+		} else {
 			break;
+		}
 	}
 	strbuf_release(&msgbuf);
 
diff --git c/path.c w/path.c
index d1af029152a2..0cb30123e988 100644
--- c/path.c
+++ w/path.c
@@ -477,11 +477,16 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 	strbuf_complete(buf, '/');
 	strbuf_addstr(buf, ".git");
 
-	git_dir = resolve_gitdir(buf->buf);
-	if (git_dir && git_dir != buf->buf) {
+	git_dir = read_gitfile(buf->buf);
+	if (git_dir) {
 		strbuf_reset(buf);
 		strbuf_addstr(buf, git_dir);
 	}
+	if (!is_git_directory(buf->buf)) {
+		strbuf_reset(buf);
+		strbuf_git_path(buf, "%s/%s", "modules", path);
+	}
+
 	strbuf_addch(buf, '/');
 	strbuf_addbuf(&git_submodule_dir, buf);
 
diff --git c/sha1_file.c w/sha1_file.c
index 1e23fc186a02..10883d56a600 100644
--- c/sha1_file.c
+++ w/sha1_file.c
@@ -38,6 +38,9 @@ static inline uintmax_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
 const struct object_id null_oid;
+const struct object_id empty_tree_oid = {
+	.hash = EMPTY_TREE_SHA1_BIN_LITERAL
+};
 
 /*
  * This is meant to hold a *small* number of objects that you would
diff --git c/submodule.c w/submodule.c
index e5f1138f4362..cecd3cd98de4 100644
--- c/submodule.c
+++ w/submodule.c
@@ -333,7 +333,7 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
  */
 static void show_submodule_header(FILE *f, const char *path,
 		const char *line_prefix,
-		unsigned char one[20], unsigned char two[20],
+		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *reset,
 		struct commit **left, struct commit **right)
@@ -350,30 +350,30 @@ static void show_submodule_header(FILE *f, const char *path,
 		fprintf(f, "%sSubmodule %s contains modified content\n",
 			line_prefix, path);
 
-	if (is_null_sha1(one))
+	if (is_null_oid(one))
 		message = "(new submodule)";
-	else if (is_null_sha1(two))
+	else if (is_null_oid(two))
 		message = "(submodule deleted)";
 
 	if (add_submodule_odb(path)) {
 		if (!message)
-			message = "(submodule not initialized)";
+			message = "(not initialized)";
 		goto output_header;
 	}
 
 	/*
 	 * Attempt to lookup the commit references, and determine if this is
-	 * a fast forward or fast backwards update
+	 * a fast forward or fast backwards update.
 	 */
-	*left = lookup_commit_reference(one);
-	*right = lookup_commit_reference(two);
+	*left = lookup_commit_reference(one->hash);
+	*right = lookup_commit_reference(two->hash);
 
 	/*
 	 * Warn about missing commits in the submodule project, but only if
-	 * they aren't null
+	 * they aren't null.
 	 */
-	if ((!is_null_sha1(one) && !*left) ||
-	     (!is_null_sha1(two) && !*right))
+	if ((!is_null_oid(one) && !*left) ||
+	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
 	merge_bases = get_merge_bases(*left, *right);
@@ -384,17 +384,17 @@ static void show_submodule_header(FILE *f, const char *path,
 			fast_backward = 1;
 	}
 
-	if (!hashcmp(one, two)) {
+	if (!oidcmp(one, two)) {
 		strbuf_release(&sb);
 		return;
 	}
 
 output_header:
 	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
-			find_unique_abbrev(one, DEFAULT_ABBREV));
+			find_unique_abbrev(one->hash, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
-	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
+	strbuf_addf(&sb, "%s", find_unique_abbrev(two->hash, DEFAULT_ABBREV));
 	if (message)
 		strbuf_addf(&sb, " %s%s\n", message, reset);
 	else
@@ -406,7 +406,7 @@ static void show_submodule_header(FILE *f, const char *path,
 
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
-		unsigned char one[20], unsigned char two[20],
+		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset)
 {
@@ -417,33 +417,32 @@ void show_submodule_summary(FILE *f, const char *path,
 			      meta, reset, &left, &right);
 
 	/*
-	 * if we don't have both a left and a right pointer, then we can't
-	 * display a summary
+	 * If we don't have both a left and a right pointer, there is no
+	 * reason to try and display a summary. The header line should contain
+	 * all the information the user needs.
 	 */
 	if (!left || !right)
 		return;
 
+	/* Treat revision walker failure the same as missing commits */
 	if (prepare_submodule_summary(&rev, path, left, right)) {
 		fprintf(f, "%s(revision walker failed)\n", line_prefix);
 		return;
 	}
 
 	print_submodule_summary(&rev, f, line_prefix, del, add, reset);
-
-	if (left)
-		clear_commit_marks(left, ~0);
-	if (right)
-		clear_commit_marks(right, ~0);
+	clear_commit_marks(left, ~0);
+	clear_commit_marks(right, ~0);
 }
 
 void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *line_prefix,
-		unsigned char one[20], unsigned char two[20],
+		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *o)
 {
-	const char *old = EMPTY_TREE_SHA1_BIN, *new = EMPTY_TREE_SHA1_BIN;
+	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
 	struct commit *left = NULL, *right = NULL;
 	struct strbuf submodule_dir = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -452,8 +451,8 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 			      meta, reset, &left, &right);
 
 	/* We need a valid left and right commit to display a difference */
-	if (!(left || is_null_sha1(one)) ||
-	    !(right || is_null_sha1(two)))
+	if (!(left || is_null_oid(one)) ||
+	    !(right || is_null_oid(two)))
 		goto done;
 
 	if (left)
@@ -481,14 +480,15 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 		argv_array_pushf(&cp.args, "--dst-prefix=%s%s/",
 				 o->b_prefix, path);
 	}
-	argv_array_push(&cp.args, sha1_to_hex(old));
-	/* If the submodule has modified content, we will diff against the
+	argv_array_push(&cp.args, oid_to_hex(old));
+	/*
+	 * If the submodule has modified content, we will diff against the
 	 * work tree, under the assumption that the user has asked for the
 	 * diff format and wishes to actually see all differences even if they
 	 * haven't yet been committed to the submodule yet.
 	 */
 	if (!(dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
-		argv_array_push(&cp.args, sha1_to_hex(new));
+		argv_array_push(&cp.args, oid_to_hex(new));
 
 	if (run_command(&cp))
 		fprintf(f, "(diff failed)\n");
diff --git c/submodule.h w/submodule.h
index e2ebc0756f6a..d9e197a948fd 100644
--- c/submodule.h
+++ w/submodule.h
@@ -43,12 +43,12 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
-		unsigned char one[20], unsigned char two[20],
+		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
 void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *line_prefix,
-		unsigned char one[20], unsigned char two[20],
+		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
diff --git c/t/t4059-diff-submodule-not-initialized.sh w/t/t4059-diff-submodule-not-initialized.sh
new file mode 100755
index 000000000000..cc787454033a
--- /dev/null
+++ w/t/t4059-diff-submodule-not-initialized.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Jacob Keller, based on t4041 by Jens Lehmann
+#
+
+test_description='Test for submodule diff on non-checked out submodule
+
+This test tries to verify that add_submodule_odb works when the submodule was
+initialized previously but the checkout has since been removed.
+'
+
+TEST_NO_CREATE_REPO=1
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
+test_create_repo sm2 &&
+add_file sm1 foo >/dev/null &&
+add_file sm2 foo1 foo2 >/dev/null &&
+smhead1=$(cd sm2; git rev-parse --short --verify HEAD) &&
+cd sm1
+
+test_expect_success 'setup - submodule directory' '
+	git submodule add ../sm2 sm2 &&
+	commit_file sm2 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 0000000...$smhead1 (new submodule)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule directory removed' '
+	rm -rf sm2 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 0000000...$smhead1 (new submodule)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'setup - submodule multiple commits' '
+	git submodule update --checkout sm2 &&
+	smhead2=$(add_file sm2 foo3 foo4) &&
+	commit_file sm2 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 $smhead1..$smhead2:
+	  > Add foo4 ($added foo4)
+	  > Add foo3 ($added foo3)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule removed multiple commits' '
+	rm -rf sm2 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 $smhead1..$smhead2:
+	  > Add foo4 ($added foo4)
+	  > Add foo3 ($added foo3)
+	EOF
+	test_cmp expected actual
+'
+
+cd ..
+
+test_expect_success 'submodule not initialized in new clone' '
+	git clone sm1 sm3 &&
+	git -C sm3 diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm2 $smhead1...$smhead2 (not initialized)
+	EOF
+	test_cmp expected actual
+
+'
+
+test_done
diff --git c/t/t4059-diff-submodule-option-diff-format.sh w/t/t4060-diff-submodule-option-diff-format.sh
similarity index 95%
rename from t/t4059-diff-submodule-option-diff-format.sh
rename to t/t4060-diff-submodule-option-diff-format.sh
index 88484f1ba847..836caef5c8ba 100755
--- c/t/t4059-diff-submodule-option-diff-format.sh
+++ w/t/t4060-diff-submodule-option-diff-format.sh
@@ -50,7 +50,7 @@ test_expect_success 'added submodule' '
 	git add sm1 &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 0000000...1beffeb (new submodule)
+	Submodule sm1 0000000...$head1 (new submodule)
 	diff --git a/sm1/foo1 b/sm1/foo1
 	new file mode 100644
 	index 0000000..1715acd
@@ -70,13 +70,26 @@ test_expect_success 'added submodule' '
 '
 
 test_expect_success 'added submodule, set diff.submodule' '
-	git config diff.submodule log &&
+	test_config diff.submodule log &&
 	git add sm1 &&
-	git diff --cached >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 0000000...$head1 (new submodule)
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
 	EOF
-	git config --unset diff.submodule &&
 	test_cmp expected actual
 '
 
@@ -117,7 +130,7 @@ head2=$(add_file sm1 foo3)
 test_expect_success 'modified submodule(forward)' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 1beffeb..30b9670:
+	Submodule sm1 $head1..$head2:
 	diff --git a/sm1/foo3 b/sm1/foo3
 	new file mode 100644
 	index 0000000..c1ec6c6
@@ -132,7 +145,7 @@ test_expect_success 'modified submodule(forward)' '
 test_expect_success 'modified submodule(forward)' '
 	git diff --submodule=diff >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 1beffeb..30b9670:
+	Submodule sm1 $head1..$head2:
 	diff --git a/sm1/foo3 b/sm1/foo3
 	new file mode 100644
 	index 0000000..c1ec6c6
@@ -178,7 +191,7 @@ head3=$(
 test_expect_success 'modified submodule(backward)' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 30b9670..dafb207 (rewind):
+	Submodule sm1 $head2..$head3 (rewind):
 	diff --git a/sm1/foo2 b/sm1/foo2
 	deleted file mode 100644
 	index 54b060e..0000000
@@ -201,7 +214,7 @@ head4=$(add_file sm1 foo4 foo5)
 test_expect_success 'modified submodule(backward and forward)' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 30b9670...d176589:
+	Submodule sm1 $head2...$head4:
 	diff --git a/sm1/foo2 b/sm1/foo2
 	deleted file mode 100644
 	index 54b060e..0000000
@@ -245,7 +258,7 @@ mv sm1-bak sm1
 test_expect_success 'typechanged submodule(submodule->blob), --cached' '
 	git diff --submodule=diff --cached >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 d176589...0000000 (submodule deleted)
+	Submodule sm1 $head4...0000000 (submodule deleted)
 	diff --git a/sm1/foo1 b/sm1/foo1
 	deleted file mode 100644
 	index 1715acd..0000000
@@ -288,7 +301,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	+++ /dev/null
 	@@ -1 +0,0 @@
 	-sm1
-	Submodule sm1 0000000...d176589 (new submodule)
+	Submodule sm1 0000000...$head4 (new submodule)
 	diff --git a/sm1/foo1 b/sm1/foo1
 	new file mode 100644
 	index 0000000..1715acd
@@ -322,7 +335,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	Submodule sm1 $head4...0000000 (submodule deleted)
 	diff --git a/sm1 b/sm1
 	new file mode 100644
-	index 0000000..$head5
+	index 0000000..9da5fb8
 	--- /dev/null
 	+++ b/sm1
 	@@ -0,0 +1 @@
@@ -338,7 +351,7 @@ fullhead6=$(cd sm1; git rev-parse --verify HEAD)
 test_expect_success 'nonexistent commit' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 d176589...17243c9 (commits not present)
+	Submodule sm1 $head4...$head6 (commits not present)
 	EOF
 	test_cmp expected actual
 '
@@ -354,7 +367,7 @@ test_expect_success 'typechanged submodule(blob->submodule)' '
 	+++ /dev/null
 	@@ -1 +0,0 @@
 	-sm1
-	Submodule sm1 0000000...17243c9 (new submodule)
+	Submodule sm1 0000000...$head6 (new submodule)
 	diff --git a/sm1/foo6 b/sm1/foo6
 	new file mode 100644
 	index 0000000..462398b
@@ -472,7 +485,7 @@ head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
 test_expect_success 'submodule is modified' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 17243c9..cfce562:
+	Submodule sm1 17243c9..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..3e75765 100644
 	--- a/sm1/foo6
@@ -489,7 +502,7 @@ test_expect_success 'modified submodule contains untracked content' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
-	Submodule sm1 17243c9..cfce562:
+	Submodule sm1 17243c9..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..3e75765 100644
 	--- a/sm1/foo6
@@ -504,7 +517,7 @@ test_expect_success 'modified submodule contains untracked content' '
 test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
 	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 17243c9..cfce562:
+	Submodule sm1 17243c9..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..3e75765 100644
 	--- a/sm1/foo6

------>8

Jacob Keller (7):
  graph: add support for --line-prefix on all graph-aware output
  diff: prepare for additional submodule formats
  submodule: allow add_submodule_odb to work even if path is not checked
    out
  submodule: convert show_submodule_summary to use struct object_id *
  submodule: refactor show_submodule_summary with helper function
  cache: add empty_tree_oid object
  diff: teach diff to display submodule difference with an inline diff

Junio C Hamano (1):
  diff.c: remove output_prefix_length field

 Documentation/diff-config.txt                      |   9 +-
 Documentation/diff-options.txt                     |  20 +-
 builtin/rev-list.c                                 |  70 +-
 cache.h                                            |   2 +
 diff.c                                             |  64 +-
 diff.h                                             |  11 +-
 graph.c                                            | 100 ++-
 graph.h                                            |  22 +-
 log-tree.c                                         |   5 +-
 path.c                                             |   5 +
 sha1_file.c                                        |   3 +
 submodule.c                                        | 178 ++++-
 submodule.h                                        |   8 +-
 t/t4013-diff-various.sh                            |   6 +
 ...diff.diff_--line-prefix=abc_master_master^_side |  29 +
 t/t4013/diff.diff_--line-prefix_--cached_--_file0  |  15 +
 t/t4059-diff-submodule-not-initialized.sh          | 105 +++
 t/t4060-diff-submodule-option-diff-format.sh       | 746 +++++++++++++++++++++
 t/t4202-log.sh                                     | 323 +++++++++
 19 files changed, 1569 insertions(+), 152 deletions(-)
 create mode 100644 t/t4013/diff.diff_--line-prefix=abc_master_master^_side
 create mode 100644 t/t4013/diff.diff_--line-prefix_--cached_--_file0
 create mode 100755 t/t4059-diff-submodule-not-initialized.sh
 create mode 100755 t/t4060-diff-submodule-option-diff-format.sh

-- 
2.10.0.rc0.217.g609f9e8.dirty

