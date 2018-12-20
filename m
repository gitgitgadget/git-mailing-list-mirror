Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3586F211B5
	for <e@80x24.org>; Thu, 20 Dec 2018 00:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeLTA0U (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 19:26:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57808 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729613AbeLTA0T (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Dec 2018 19:26:19 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b469:672:eccb:defe])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0AF3A6042F;
        Thu, 20 Dec 2018 00:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545265577;
        bh=lllT2x/Fekp/jJj8pqjkXTukCbMqx7oSbPRc7YUZBGo=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vQOU/ueuR24I3peauiedVQ2SHEDIcGudx98KtuNtnsxkDAWxG2PIxiarvxE1PWg/+
         v8puQr2WRYeB/lazLxfRzrvIdYnLOWbZvVX5QkI+LnU8ClFXAOe2fmkTTPaKCvtbNp
         Rff2pcFQPJkCq0s7yLMVrSVWzcZWD52V9G1x3amhQECXOErr15u83aWfGhb1/NUur9
         ce38GlwMBccwYwF8sVJb5pQK1AjjBozhyGvjelMLmPrpcEtuSaOnedeRaCh0ChcqiU
         nKOBV5MXj4EINwx2BqAWeO/QY/0pQ/GhcDLeAILt7OvucO33VWAJV6jvbirsHV1VQN
         uEb4eUyoo/RKXB3c5t7a1AR/tfX0XA49mS0Dk3AqytkLeJgmFmevlWqRYADVhZ6Q2G
         BBrWKfG8ftLtL5AmZU6sMmBi16Uc0rotvMVZ1bwwORQS+yKugBrBaVEtARvT/85b/D
         hXFQYAF7AAeZJAME5UYfXnXAyF/OKtV62gO61m7NcIltXLp70jD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH] diff: add support for reading files literally with --no-index
Date:   Thu, 20 Dec 2018 00:26:10 +0000
Message-Id: <20181220002610.43832-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.415.g653613c723
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some shells, such as bash and zsh, it's possible to use a command
substitution to provide the output of a command as a file argument to
another process, like so:

  diff -u <(printf "a\nb\n") <(printf "a\nc\n")

However, this syntax does not produce useful results with git diff
--no-index.

On macOS, the arguments to the command are named pipes under /dev/fd,
and git diff doesn't know how to handle a named pipe. On Linux, the
arguments are symlinks to pipes, so git diff "helpfully" diffs these
symlinks, comparing their targets like "pipe:[1234]" and "pipe:[5678]".

Because this behavior is not very helpful, and because git diff has many
features that people would like to use even on non-Git files, add an
option to git diff --no-index to read files literally, dereferencing
symlinks and reading them as a normal file.

Note that this behavior requires that the files be read entirely into
memory, just as we do when reading from standard input.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
This is a long-standing annoyance of mine, and it also makes some use
cases possible (for example, diffing filtered and non-filtered objects).

We don't include a test for the pipe scenario because I couldn't get
that case to work in portable shell (although of course it works in
bash). I have, however, tested it on both macOS and Linux. No clue how
this works on Windows.

 Documentation/git-diff.txt |  5 +++++
 diff-no-index.c            | 34 +++++++++++++++++++++++++++-------
 diff.c                     | 24 +++++++++++++-----------
 diff.h                     |  1 +
 diffcore.h                 |  1 +
 t/t4053-diff-no-index.sh   | 28 ++++++++++++++++++++++++++++
 6 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 030f162f30..4c4695c88d 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -111,6 +111,11 @@ include::diff-options.txt[]
 	"Unmerged".  Can be used only when comparing the working tree
 	with the index.
 
+--literally::
+  Read the specified files literally, as `diff` would,
+  dereferencing any symlinks and reading data from pipes.
+  This option only works with `--no-index`.
+
 <path>...::
 	The <paths> parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
diff --git a/diff-no-index.c b/diff-no-index.c
index 9414e922d1..2707206aee 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -75,7 +75,25 @@ static int populate_from_stdin(struct diff_filespec *s)
 	return 0;
 }
 
-static struct diff_filespec *noindex_filespec(const char *name, int mode)
+static int populate_literally(struct diff_filespec *s)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t size = 0;
+	int fd = xopen(s->path, O_RDONLY);
+
+	if (strbuf_read(&buf, fd, 0) < 0)
+		return error_errno("error while reading from '%s'", s->path);
+
+	s->should_munmap = 0;
+	s->data = strbuf_detach(&buf, &size);
+	s->size = size;
+	s->should_free = 1;
+	s->read_literally = 1;
+	return 0;
+}
+
+static struct diff_filespec *noindex_filespec(const char *name, int mode,
+					      struct diff_options *o)
 {
 	struct diff_filespec *s;
 
@@ -85,6 +103,8 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode)
 	fill_filespec(s, &null_oid, 0, mode);
 	if (name == file_from_standard_input)
 		populate_from_stdin(s);
+	else if (o->flags.read_literally)
+		populate_literally(s);
 	return s;
 }
 
@@ -101,14 +121,14 @@ static int queue_diff(struct diff_options *o,
 
 		if (S_ISDIR(mode1)) {
 			/* 2 is file that is created */
-			d1 = noindex_filespec(NULL, 0);
-			d2 = noindex_filespec(name2, mode2);
+			d1 = noindex_filespec(NULL, 0, o);
+			d2 = noindex_filespec(name2, mode2, o);
 			name2 = NULL;
 			mode2 = 0;
 		} else {
 			/* 1 is file that is deleted */
-			d1 = noindex_filespec(name1, mode1);
-			d2 = noindex_filespec(NULL, 0);
+			d1 = noindex_filespec(name1, mode1, o);
+			d2 = noindex_filespec(NULL, 0, o);
 			name1 = NULL;
 			mode1 = 0;
 		}
@@ -189,8 +209,8 @@ static int queue_diff(struct diff_options *o,
 			SWAP(name1, name2);
 		}
 
-		d1 = noindex_filespec(name1, mode1);
-		d2 = noindex_filespec(name2, mode2);
+		d1 = noindex_filespec(name1, mode1, o);
+		d2 = noindex_filespec(name2, mode2, o);
 		diff_queue(&diff_queued_diff, d1, d2);
 		return 0;
 	}
diff --git a/diff.c b/diff.c
index dc9965e836..740d0087b9 100644
--- a/diff.c
+++ b/diff.c
@@ -4282,18 +4282,18 @@ static void run_diff_cmd(const char *pgm,
 		fprintf(o->file, "* Unmerged path %s\n", name);
 }
 
-static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *istate)
+static void diff_fill_oid_info(struct diff_filespec *one, struct diff_options *o)
 {
 	if (DIFF_FILE_VALID(one)) {
 		if (!one->oid_valid) {
 			struct stat st;
-			if (one->is_stdin) {
+			if (one->is_stdin || one->read_literally) {
 				oidclr(&one->oid);
 				return;
 			}
 			if (lstat(one->path, &st) < 0)
 				die_errno("stat '%s'", one->path);
-			if (index_path(istate, &one->oid, one->path, &st, 0))
+			if (index_path(o->repo->index, &one->oid, one->path, &st, 0))
 				die("cannot hash %s", one->path);
 		}
 	}
@@ -4341,8 +4341,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 		return;
 	}
 
-	diff_fill_oid_info(one, o->repo->index);
-	diff_fill_oid_info(two, o->repo->index);
+	diff_fill_oid_info(one, o);
+	diff_fill_oid_info(two, o);
 
 	if (!pgm &&
 	    DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two) &&
@@ -4389,8 +4389,8 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
-	diff_fill_oid_info(p->one, o->repo->index);
-	diff_fill_oid_info(p->two, o->repo->index);
+	diff_fill_oid_info(p->one, o);
+	diff_fill_oid_info(p->two, o);
 
 	builtin_diffstat(name, other, p->one, p->two,
 			 diffstat, o, p);
@@ -4414,8 +4414,8 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
-	diff_fill_oid_info(p->one, o->repo->index);
-	diff_fill_oid_info(p->two, o->repo->index);
+	diff_fill_oid_info(p->one, o);
+	diff_fill_oid_info(p->two, o);
 
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
@@ -5159,6 +5159,8 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.funccontext = 1;
 	else if (!strcmp(arg, "--no-function-context"))
 		options->flags.funccontext = 0;
+	else if (!strcmp(arg, "--literally"))
+		options->flags.read_literally = 1;
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
 		char *path = prefix_filename(prefix, optarg);
 		options->file = xfopen(path, "w");
@@ -5720,8 +5722,8 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		if (DIFF_PAIR_UNMERGED(p))
 			continue;
 
-		diff_fill_oid_info(p->one, options->repo->index);
-		diff_fill_oid_info(p->two, options->repo->index);
+		diff_fill_oid_info(p->one, options);
+		diff_fill_oid_info(p->two, options);
 
 		len1 = remove_space(p->one->path, strlen(p->one->path));
 		len2 = remove_space(p->two->path, strlen(p->two->path));
diff --git a/diff.h b/diff.h
index ce5e8a8183..7dedd3bcd1 100644
--- a/diff.h
+++ b/diff.h
@@ -97,6 +97,7 @@ struct diff_flags {
 	unsigned stat_with_summary:1;
 	unsigned suppress_diff_headers:1;
 	unsigned dual_color_diffed_diffs:1;
+	unsigned read_literally:1;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
diff --git a/diffcore.h b/diffcore.h
index b651061c0e..363869447a 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -48,6 +48,7 @@ struct diff_filespec {
 #define DIRTY_SUBMODULE_UNTRACKED 1
 #define DIRTY_SUBMODULE_MODIFIED  2
 	unsigned is_stdin : 1;
+	unsigned read_literally : 1;
 	unsigned has_more_entries : 1; /* only appear in combined diff */
 	/* data should be considered "binary"; -1 means "don't know yet" */
 	signed int is_binary : 2;
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 6e0dd6f9e5..53e6bcdc19 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -137,4 +137,32 @@ test_expect_success 'diff --no-index from repo subdir with absolute paths' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff --no-index --literally' '
+	echo "diff --git a/../../non/git/a b/../../non/git/b" >expect &&
+	test_expect_code 1 \
+		git -C repo/sub \
+		diff --literally ../../non/git/a ../../non/git/b >actual &&
+	head -n 1 <actual >actual.head &&
+	test_cmp expect actual.head
+'
+
+test_expect_success SYMLINKS 'diff --no-index --literally with symlinks' '
+	test_write_lines a b c >f1 &&
+	test_write_lines a d c >f2 &&
+	ln -s f1 s1 &&
+	ln -s f2 s2 &&
+	cat >expect <<-\EOF &&
+	diff --git a/s1 b/s2
+	--- a/s1
+	+++ b/s2
+	@@ -1,3 +1,3 @@
+	 a
+	-b
+	+d
+	 c
+	EOF
+	test_expect_code 1 git diff --no-index --literally s1 s2 >actual &&
+	test_cmp expect actual
+'
+
 test_done
