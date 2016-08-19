Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66D991F859
	for <e@80x24.org>; Fri, 19 Aug 2016 23:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755045AbcHSXfe (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 19:35:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:6539 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754491AbcHSXfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 19:35:33 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 19 Aug 2016 16:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,547,1464678000"; 
   d="scan'208";a="1044481252"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2016 16:34:36 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v9 0/8] submodule show inline diff
Date:   Fri, 19 Aug 2016 16:34:24 -0700
Message-Id: <20160819233432.15188-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

More suggestions from Junio and a few changes to support submodule name
lookup. Hopefully we're getting close to the goal!

interdiff between v8 and current:
diff --git c/builtin/rev-list.c w/builtin/rev-list.c
index 21cde8dd6b31..8479f6ed28aa 100644
--- c/builtin/rev-list.c
+++ w/builtin/rev-list.c
@@ -129,29 +129,29 @@ static void show_commit(struct commit *commit, void *data)
 			graph_show_commit_msg(revs->graph, stdout, &buf);
 
 			/*
-			* Add a newline after the commit message.
-			*
-			* Usually, this newline produces a blank
-			* padding line between entries, in which case
-			* we need to add graph padding on this line.
-			*
-			* However, the commit message may not end in a
-			* newline.  In this case the newline simply
-			* ends the last line of the commit message,
-			* and we don't need any graph output.  (This
-			* always happens with CMIT_FMT_ONELINE, and it
-			* happens with CMIT_FMT_USERFORMAT when the
-			* format doesn't explicitly end in a newline.)
-			*/
+			 * Add a newline after the commit message.
+			 *
+			 * Usually, this newline produces a blank
+			 * padding line between entries, in which case
+			 * we need to add graph padding on this line.
+			 *
+			 * However, the commit message may not end in a
+			 * newline.  In this case the newline simply
+			 * ends the last line of the commit message,
+			 * and we don't need any graph output.  (This
+			 * always happens with CMIT_FMT_ONELINE, and it
+			 * happens with CMIT_FMT_USERFORMAT when the
+			 * format doesn't explicitly end in a newline.)
+			 */
 			if (buf.len && buf.buf[buf.len - 1] == '\n')
 				graph_show_padding(revs->graph);
 			putchar('\n');
 		} else {
 			/*
-				* If the message buffer is empty, just show
-				* the rest of the graph output for this
-				* commit.
-				*/
+			 * If the message buffer is empty, just show
+			 * the rest of the graph output for this
+			 * commit.
+			 */
 			if (graph_show_remainder(revs->graph))
 				putchar('\n');
 			if (revs->commit_format == CMIT_FMT_ONELINE)
diff --git c/cache.h w/cache.h
index da9f0be67d7b..70428e92d7ed 100644
--- c/cache.h
+++ w/cache.h
@@ -953,24 +953,39 @@ static inline void oidclr(struct object_id *oid)
 #define EMPTY_TREE_SHA1_BIN_LITERAL \
 	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
 	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
-#define EMPTY_TREE_SHA1_BIN \
-	 ((const unsigned char *) EMPTY_TREE_SHA1_BIN_LITERAL)
+extern const struct object_id empty_tree_oid;
+#define EMPTY_TREE_SHA1_BIN (empty_tree_oid.hash)
 
 #define EMPTY_BLOB_SHA1_HEX \
 	"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"
 #define EMPTY_BLOB_SHA1_BIN_LITERAL \
 	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
 	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
-#define EMPTY_BLOB_SHA1_BIN \
-	((const unsigned char *) EMPTY_BLOB_SHA1_BIN_LITERAL)
+extern const struct object_id empty_blob_oid;
+#define EMPTY_BLOB_SHA1_BIN (empty_blob_oid.hash)
 
-extern const struct object_id empty_tree_oid;
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
 {
 	return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
 }
 
+static inline int is_empty_blob_oid(const struct object_id *oid)
+{
+	return !hashcmp(oid->hash, EMPTY_BLOB_SHA1_BIN);
+}
+
+static inline int is_empty_tree_sha1(const unsigned char *sha1)
+{
+	return !hashcmp(sha1, EMPTY_TREE_SHA1_BIN);
+}
+
+static inline int is_empty_tree_oid(const struct object_id *oid)
+{
+	return !hashcmp(oid->hash, EMPTY_TREE_SHA1_BIN);
+}
+
+
 int git_mkstemp(char *path, size_t n, const char *template);
 
 /* set default permissions by passing mode arguments to open(2) */
diff --git c/diff.h w/diff.h
index 192c0eedd0ff..ec76a90522ea 100644
--- c/diff.h
+++ w/diff.h
@@ -112,7 +112,7 @@ enum diff_words_type {
 enum diff_submodule_format {
 	DIFF_SUBMODULE_SHORT = 0,
 	DIFF_SUBMODULE_LOG,
-	DIFF_SUBMODULE_INLINE_DIFF,
+	DIFF_SUBMODULE_INLINE_DIFF
 };
 
 struct diff_options {
diff --git c/path.c w/path.c
index 188abfebbafe..081a22c1163c 100644
--- c/path.c
+++ w/path.c
@@ -6,6 +6,7 @@
 #include "string-list.h"
 #include "dir.h"
 #include "worktree.h"
+#include "submodule-config.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -474,6 +475,7 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 	const char *git_dir;
 	struct strbuf git_submodule_common_dir = STRBUF_INIT;
 	struct strbuf git_submodule_dir = STRBUF_INIT;
+	const struct submodule *submodule_config;
 
 	strbuf_addstr(buf, path);
 	strbuf_complete(buf, '/');
@@ -486,7 +488,16 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 	}
 	if (!is_git_directory(buf->buf)) {
 		strbuf_reset(buf);
-		strbuf_git_path(buf, "%s/%s", "modules", path);
+		/*
+		 * Lookup the submodule name from the config. If that fails
+		 * fall back to assuming the path is the name.
+		 */
+		submodule_config = submodule_from_path(null_sha1, path);
+		if (submodule_config)
+			strbuf_git_path(buf, "%s/%s", "modules",
+					submodule_config->name);
+		else
+			strbuf_git_path(buf, "%s/%s", "modules", path);
 	}
 
 	strbuf_addch(buf, '/');
diff --git c/sha1_file.c w/sha1_file.c
index 10883d56a600..21cf923bcf1f 100644
--- c/sha1_file.c
+++ w/sha1_file.c
@@ -39,7 +39,10 @@ static inline uintmax_t sz_fmt(size_t s) { return s; }
 const unsigned char null_sha1[20];
 const struct object_id null_oid;
 const struct object_id empty_tree_oid = {
-	.hash = EMPTY_TREE_SHA1_BIN_LITERAL
+	EMPTY_TREE_SHA1_BIN_LITERAL
+};
+const struct object_id empty_blob_oid = {
+	EMPTY_BLOB_SHA1_BIN_LITERAL
 };
 
 /*
diff --git c/submodule.c w/submodule.c
index cecd3cd98de4..405fa9e4eb32 100644
--- c/submodule.c
+++ w/submodule.c
@@ -277,9 +277,10 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 }
 
 static int prepare_submodule_summary(struct rev_info *rev, const char *path,
-		struct commit *left, struct commit *right)
+		struct commit *left, struct commit *right,
+		struct commit_list *merge_bases)
 {
-	struct commit_list *merge_bases, *list;
+	struct commit_list *list;
 
 	init_revisions(rev, NULL);
 	setup_revisions(0, NULL, rev, NULL);
@@ -288,7 +289,6 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	left->object.flags |= SYMMETRIC_LEFT;
 	add_pending_object(rev, &left->object, path);
 	add_pending_object(rev, &right->object, path);
-	merge_bases = get_merge_bases(left, right);
 	for (list = merge_bases; list; list = list->next) {
 		list->item->object.flags |= UNINTERESTING;
 		add_pending_object(rev, &list->item->object,
@@ -336,9 +336,9 @@ static void show_submodule_header(FILE *f, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *reset,
-		struct commit **left, struct commit **right)
+		struct commit **left, struct commit **right,
+		struct commit_list **merge_bases)
 {
-	struct commit_list *merge_bases;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
 	int fast_forward = 0, fast_backward = 0;
@@ -376,11 +376,11 @@ static void show_submodule_header(FILE *f, const char *path,
 	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
-	merge_bases = get_merge_bases(*left, *right);
-	if (merge_bases) {
-		if (merge_bases->item == *left)
+	*merge_bases = get_merge_bases(*left, *right);
+	if (*merge_bases) {
+		if ((*merge_bases)->item == *left)
 			fast_forward = 1;
-		else if (merge_bases->item == *right)
+		else if ((*merge_bases)->item == *right)
 			fast_backward = 1;
 	}
 
@@ -412,9 +412,10 @@ void show_submodule_summary(FILE *f, const char *path,
 {
 	struct rev_info rev;
 	struct commit *left = NULL, *right = NULL;
+	struct commit_list *merge_bases = NULL;
 
 	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
-			      meta, reset, &left, &right);
+			      meta, reset, &left, &right, &merge_bases);
 
 	/*
 	 * If we don't have both a left and a right pointer, there is no
@@ -422,15 +423,19 @@ void show_submodule_summary(FILE *f, const char *path,
 	 * all the information the user needs.
 	 */
 	if (!left || !right)
-		return;
+		goto out;
 
 	/* Treat revision walker failure the same as missing commits */
-	if (prepare_submodule_summary(&rev, path, left, right)) {
+	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
 		fprintf(f, "%s(revision walker failed)\n", line_prefix);
-		return;
+		goto out;
 	}
 
 	print_submodule_summary(&rev, f, line_prefix, del, add, reset);
+
+out:
+	if (merge_bases)
+		free_commit_list(merge_bases);
 	clear_commit_marks(left, ~0);
 	clear_commit_marks(right, ~0);
 }
@@ -444,11 +449,12 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 {
 	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
 	struct commit *left = NULL, *right = NULL;
+	struct commit_list *merge_bases = NULL;
 	struct strbuf submodule_dir = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 
 	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
-			      meta, reset, &left, &right);
+			      meta, reset, &left, &right, &merge_bases);
 
 	/* We need a valid left and right commit to display a difference */
 	if (!(left || is_null_oid(one)) ||
@@ -467,7 +473,7 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 	cp.no_stdin = 1;
 
 	/* TODO: other options may need to be passed here. */
-	argv_array_pushl(&cp.args, "diff");
+	argv_array_push(&cp.args, "diff");
 	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
@@ -495,6 +501,12 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 
 done:
 	strbuf_release(&submodule_dir);
+	if (merge_bases)
+		free_commit_list(merge_bases);
+	if (left)
+		clear_commit_marks(left, ~0);
+	if (right)
+		clear_commit_marks(right, ~0);
 }
 
 void set_config_fetch_recurse_submodules(int value)
diff --git c/t/t4059-diff-submodule-not-initialized.sh w/t/t4059-diff-submodule-not-initialized.sh
index cc787454033a..c8775854d3c2 100755
--- c/t/t4059-diff-submodule-not-initialized.sh
+++ w/t/t4059-diff-submodule-not-initialized.sh
@@ -9,7 +9,6 @@ This test tries to verify that add_submodule_odb works when the submodule was
 initialized previously but the checkout has since been removed.
 '
 
-TEST_NO_CREATE_REPO=1
 . ./test-lib.sh
 
 # Tested non-UTF-8 encoding
@@ -18,6 +17,7 @@ test_encoding="ISO8859-1"
 # String "added" in German (translated with Google Translate), encoded in UTF-8,
 # used in sample commit log messages in add_file() function below.
 added=$(printf "hinzugef\303\274gt")
+
 add_file () {
 	(
 		cd "$1" &&
@@ -35,44 +35,45 @@ add_file () {
 		git rev-parse --short --verify HEAD
 	)
 }
+
 commit_file () {
 	test_tick &&
 	git commit "$@" -m "Commit $*" >/dev/null
 }
 
-test_create_repo sm1 &&
-test_create_repo sm2 &&
-add_file sm1 foo >/dev/null &&
-add_file sm2 foo1 foo2 >/dev/null &&
-smhead1=$(cd sm2; git rev-parse --short --verify HEAD) &&
-cd sm1
+test_expect_success 'setup - submodules' '
+	test_create_repo sm2 &&
+	add_file . foo &&
+	add_file sm2 foo1 foo2 &&
+	smhead1=$(git -C sm2 rev-parse --short --verify HEAD)
+'
 
-test_expect_success 'setup - submodule directory' '
-	git submodule add ../sm2 sm2 &&
-	commit_file sm2 &&
+test_expect_success 'setup - git submodule add' '
+	git submodule add ./sm2 sm1 &&
+	commit_file sm1 &&
 	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm2 0000000...$smhead1 (new submodule)
+	Submodule sm1 0000000...$smhead1 (new submodule)
 	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'submodule directory removed' '
-	rm -rf sm2 &&
+	rm -rf sm1 &&
 	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm2 0000000...$smhead1 (new submodule)
+	Submodule sm1 0000000...$smhead1 (new submodule)
 	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'setup - submodule multiple commits' '
-	git submodule update --checkout sm2 &&
-	smhead2=$(add_file sm2 foo3 foo4) &&
-	commit_file sm2 &&
+	git submodule update --checkout sm1 &&
+	smhead2=$(add_file sm1 foo3 foo4) &&
+	commit_file sm1 &&
 	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm2 $smhead1..$smhead2:
+	Submodule sm1 $smhead1..$smhead2:
 	  > Add foo4 ($added foo4)
 	  > Add foo3 ($added foo3)
 	EOF
@@ -80,26 +81,47 @@ test_expect_success 'setup - submodule multiple commits' '
 '
 
 test_expect_success 'submodule removed multiple commits' '
-	rm -rf sm2 &&
+	rm -rf sm1 &&
 	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm2 $smhead1..$smhead2:
+	Submodule sm1 $smhead1..$smhead2:
 	  > Add foo4 ($added foo4)
 	  > Add foo3 ($added foo3)
 	EOF
 	test_cmp expected actual
 '
 
-cd ..
-
 test_expect_success 'submodule not initialized in new clone' '
-	git clone sm1 sm3 &&
+	git clone . sm3 &&
 	git -C sm3 diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm2 $smhead1...$smhead2 (not initialized)
+	Submodule sm1 $smhead1...$smhead2 (not initialized)
 	EOF
 	test_cmp expected actual
+'
 
+test_expect_success 'setup submodule moved' '
+	git submodule update --checkout sm1 &&
+	git mv sm1 sm4 &&
+	commit_file sm4 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm4 0000000...$smhead2 (new submodule)
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule moved then removed' '
+	smhead3=$(add_file sm4 foo6 foo7) &&
+	commit_file sm4 &&
+	rm -rf sm4 &&
+	git diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
+	cat >expected <<-EOF &&
+	Submodule sm4 $smhead2..$smhead3:
+	  > Add foo7 ($added foo7)
+	  > Add foo6 ($added foo6)
+	EOF
+	test_cmp expected actual
 '
 
 test_done
diff --git c/t/t4060-diff-submodule-option-diff-format.sh w/t/t4060-diff-submodule-option-diff-format.sh
index 836caef5c8ba..7e23b55ea4c5 100755
--- c/t/t4060-diff-submodule-option-diff-format.sh
+++ w/t/t4060-diff-submodule-option-diff-format.sh
@@ -18,6 +18,7 @@ test_encoding="ISO8859-1"
 # String "added" in German (translated with Google Translate), encoded in UTF-8,
 # used in sample commit log messages in add_file() function below.
 added=$(printf "hinzugef\303\274gt")
+
 add_file () {
 	(
 		cd "$1" &&
@@ -35,16 +36,18 @@ add_file () {
 		git rev-parse --short --verify HEAD
 	)
 }
+
 commit_file () {
 	test_tick &&
 	git commit "$@" -m "Commit $*" >/dev/null
 }
 
-test_create_repo sm1 &&
-add_file . foo >/dev/null
-
-head1=$(add_file sm1 foo1 foo2)
-fullhead1=$(cd sm1; git rev-parse --verify HEAD)
+test_expect_success 'setup repository' '
+	test_create_repo sm1 &&
+	add_file . foo &&
+	head1=$(add_file sm1 foo1 foo2) &&
+	fullhead1=$(git -C sm1 rev-parse --verify HEAD)
+'
 
 test_expect_success 'added submodule' '
 	git add sm1 &&

-------->8


Jacob Keller (7):
  cache: add empty_tree_oid object and helper function
  graph: add support for --line-prefix on all graph-aware output
  diff: prepare for additional submodule formats
  submodule: allow add_submodule_odb to work even if path is not checked
    out
  submodule: convert show_submodule_summary to use struct object_id *
  submodule: refactor show_submodule_summary with helper function
  diff: teach diff to display submodule difference with an inline diff

Junio C Hamano (1):
  diff.c: remove output_prefix_length field

 Documentation/diff-config.txt                      |   9 +-
 Documentation/diff-options.txt                     |  20 +-
 builtin/rev-list.c                                 |  70 +-
 cache.h                                            |  25 +-
 diff.c                                             |  64 +-
 diff.h                                             |  11 +-
 graph.c                                            | 100 ++-
 graph.h                                            |  22 +-
 log-tree.c                                         |   5 +-
 path.c                                             |  16 +
 sha1_file.c                                        |   6 +
 submodule.c                                        | 186 ++++-
 submodule.h                                        |   8 +-
 t/t4013-diff-various.sh                            |   6 +
 ...diff.diff_--line-prefix=abc_master_master^_side |  29 +
 t/t4013/diff.diff_--line-prefix_--cached_--_file0  |  15 +
 t/t4059-diff-submodule-not-initialized.sh          | 127 ++++
 t/t4060-diff-submodule-option-diff-format.sh       | 749 +++++++++++++++++++++
 t/t4202-log.sh                                     | 323 +++++++++
 19 files changed, 1637 insertions(+), 154 deletions(-)
 create mode 100644 t/t4013/diff.diff_--line-prefix=abc_master_master^_side
 create mode 100644 t/t4013/diff.diff_--line-prefix_--cached_--_file0
 create mode 100755 t/t4059-diff-submodule-not-initialized.sh
 create mode 100755 t/t4060-diff-submodule-option-diff-format.sh

-- 
2.10.0.rc0.259.g83512d9

