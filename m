Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472602095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdCRV0u (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:26:50 -0400
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:52112 "EHLO
        koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdCRV0o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 17:26:44 -0400
Received: from localhost.localdomain (unknown [145.129.9.233])
        by koekblik.kaarsemaker.net (Postfix) with ESMTP id 8FCC380381;
        Sat, 18 Mar 2017 22:00:33 +0100 (CET)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v3 1/2] diff --no-index: optionally follow symlinks
Date:   Sat, 18 Mar 2017 22:00:37 +0100
Message-Id: <20170318210038.22638-2-dennis@kaarsemaker.net>
X-Mailer: git-send-email 2.12.0-437-g0cc2799
In-Reply-To: <20170318210038.22638-1-dennis@kaarsemaker.net>
References: <20170318210038.22638-1-dennis@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's diff machinery does not follow symlinks, which makes sense as git
itself also does not, but stores the symlink destination.

In --no-index mode however, it is useful for diff to be able to follow
symlinks, matching the behaviour of ordinary diff. A new --dereference
(name copied from diff) option has been added to enable this behaviour.
--no-dereference can be used to disable it again.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 Documentation/diff-options.txt |  9 +++++++++
 diff-no-index.c                |  7 ++++---
 diff.c                         | 12 ++++++++++--
 diff.h                         |  2 +-
 t/t4053-diff-no-index.sh       | 44 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 2d77a19626..5a9d58b701 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -216,6 +216,15 @@ any of those replacements occurred.
 	commit range.  Defaults to `diff.submodule` or the 'short' format
 	if the config option is unset.
 
+ifdef::git-diff[]
+--dereference::
+--no-dereference::
+	Normally, "git diff --no-index" will compare symlinks by comparing what
+	they point to. The `--dereference` option will make it compare the content
+	of the linked files. The `--no-dereference` option disables an earlier
+	`--dereference`.
+endif::git-diff[]
+
 --color[=<when>]::
 	Show colored diff.
 	`--color` (i.e. without '=<when>') is the same as `--color=always`.
diff --git a/diff-no-index.c b/diff-no-index.c
index f420786039..fe48f32ddd 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -40,7 +40,7 @@ static int read_directory_contents(const char *path, struct string_list *list)
  */
 static const char file_from_standard_input[] = "-";
 
-static int get_mode(const char *path, int *mode)
+static int get_mode(const char *path, int *mode, int dereference)
 {
 	struct stat st;
 
@@ -52,7 +52,7 @@ static int get_mode(const char *path, int *mode)
 #endif
 	else if (path == file_from_standard_input)
 		*mode = create_ce_mode(0666);
-	else if (lstat(path, &st))
+	else if (dereference ? stat(path, &st) : lstat(path, &st))
 		return error("Could not access '%s'", path);
 	else
 		*mode = st.st_mode;
@@ -93,7 +93,8 @@ static int queue_diff(struct diff_options *o,
 {
 	int mode1 = 0, mode2 = 0;
 
-	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
+	if (get_mode(name1, &mode1, DIFF_OPT_TST(o, DEREFERENCE)) ||
+		get_mode(name2, &mode2, DIFF_OPT_TST(o, DEREFERENCE)))
 		return -1;
 
 	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
diff --git a/diff.c b/diff.c
index be11e4ef2b..2afecfb939 100644
--- a/diff.c
+++ b/diff.c
@@ -2815,7 +2815,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		s->size = xsize_t(st.st_size);
 		if (!s->size)
 			goto empty;
-		if (S_ISLNK(st.st_mode)) {
+		if (S_ISLNK(s->mode)) {
 			struct strbuf sb = STRBUF_INIT;
 
 			if (strbuf_readlink(&sb, s->path, s->size))
@@ -2825,6 +2825,10 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 			s->should_free = 1;
 			return 0;
 		}
+		if (S_ISLNK(st.st_mode)) {
+			stat(s->path, &st);
+			s->size = xsize_t(st.st_size);
+		}
 		if (size_only)
 			return 0;
 		if ((flags & CHECK_BINARY) &&
@@ -3884,7 +3888,11 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-follow")) {
 		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
 		DIFF_OPT_CLR(options, DEFAULT_FOLLOW_RENAMES);
-	} else if (!strcmp(arg, "--color"))
+	} else if (!strcmp(arg, "--dereference"))
+		DIFF_OPT_SET(options, DEREFERENCE);
+	else if (!strcmp(arg, "--no-dereference"))
+		DIFF_OPT_CLR(options, DEREFERENCE);
+	else if (!strcmp(arg, "--color"))
 		options->use_color = 1;
 	else if (skip_prefix(arg, "--color=", &arg)) {
 		int value = git_config_colorbool(NULL, arg);
diff --git a/diff.h b/diff.h
index 25ae60d5ff..db33dc67f6 100644
--- a/diff.h
+++ b/diff.h
@@ -69,7 +69,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
 #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
-/* (1 <<  9) unused */
+#define DIFF_OPT_DEREFERENCE         (1 <<  9)
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
 #define DIFF_OPT_QUICK               (1 << 11)
 #define DIFF_OPT_NO_INDEX            (1 << 12)
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 453e6c35eb..8c87bffb34 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -127,4 +127,48 @@ test_expect_success 'diff --no-index from repo subdir respects config (implicit)
 	test_cmp expect actual.head
 '
 
+test_expect_success SYMLINKS 'diff --no-index does not follows symlinks' '
+	echo a >1 &&
+	echo b >2 &&
+	ln -s 1 3 &&
+	ln -s 2 4 &&
+	cat >expect <<-EOF &&
+		--- a/3
+		+++ b/4
+		@@ -1 +1 @@
+		-1
+		\ No newline at end of file
+		+2
+		\ No newline at end of file
+	EOF
+	test_expect_code 1 git diff --no-index 3 4 | tail -n +3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success SYMLINKS 'diff --no-index --dereference does follows symlinks' '
+	cat >expect <<-EOF &&
+		--- a/3
+		+++ b/4
+		@@ -1 +1 @@
+		-a
+		+b
+	EOF
+	test_expect_code 1 git diff --no-index --dereference 3 4 | tail -n +3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success SYMLINKS 'diff --no-index --no-dereference does not follow symlinks' '
+	cat >expect <<-EOF &&
+		--- a/3
+		+++ b/4
+		@@ -1 +1 @@
+		-1
+		\ No newline at end of file
+		+2
+		\ No newline at end of file
+	EOF
+	test_expect_code 1 git diff --no-index --no-dereference 3 4 | tail -n +3 > actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0-437-g0cc2799

