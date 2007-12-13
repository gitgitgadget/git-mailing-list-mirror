From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 1/5] "diff --check" should affect exit status
Date: Thu, 13 Dec 2007 14:32:27 +0100
Message-ID: <1197552751-53480-2-git-send-email-win@wincent.com>
References: <1197552751-53480-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 14:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oC8-0003vl-Lh
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 14:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbXLMNdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 08:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbXLMNdC
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 08:33:02 -0500
Received: from wincent.com ([72.3.236.74]:47241 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092AbXLMNc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 08:32:59 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBDDWZ4Y019847;
	Thu, 13 Dec 2007 07:32:37 -0600
X-Mailer: git-send-email 1.5.4.rc0.4.g50348
In-Reply-To: <1197552751-53480-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68148>

"git diff" has a --check option that can be used to check for whitespace
problems but it only reported by printing warnings to the
console.

Now when the --check option is used we give a non-zero exit status,
making "git diff --check" nicer to use in scripts and hooks.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/diff-options.txt |    4 +-
 builtin-diff-files.c           |    2 +
 builtin-diff-index.c           |    2 +
 builtin-diff-tree.c            |   28 ++++----
 builtin-diff.c                 |    3 +-
 diff.c                         |   37 +++++++----
 diff.h                         |    1 +
 t/t4015-diff-whitespace.sh     |  137 +++++++++++++++++++++++++++++++++++++++-
 8 files changed, 184 insertions(+), 30 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 5d22b7b..9ecc1d7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -93,7 +93,9 @@ endif::git-format-patch[]
 
 --check::
 	Warn if changes introduce trailing whitespace
-	or an indent that uses a space before a tab.
+	or an indent that uses a space before a tab. Exits with
+	non-zero status if problems are found. Not compatible with
+	--exit-code.
 
 --full-index::
 	Instead of the first handful characters, show full
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 046b7e3..4afc872 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -33,5 +33,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	result = run_diff_files_cmd(&rev, argc, argv);
 	if (DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
 		return DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0;
+	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
+		return DIFF_OPT_TST(&rev.diffopt, CHECK_FAILED) != 0;
 	return result;
 }
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 556c506..532b284 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -46,5 +46,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	result = run_diff_index(&rev, cached);
 	if (DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
 		return DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0;
+	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
+		return DIFF_OPT_TST(&rev.diffopt, CHECK_FAILED) != 0;
 	return result;
 }
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 2e13716..9ab90cb 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -117,23 +117,23 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (!read_stdin)
-		return DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS)
-			&& DIFF_OPT_TST(&opt->diffopt, HAS_CHANGES);
+	if (read_stdin) {
+		if (opt->diffopt.detect_rename)
+			opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
+					       DIFF_SETUP_USE_CACHE);
+		while (fgets(line, sizeof(line), stdin)) {
+			unsigned char sha1[20];
 
-	if (opt->diffopt.detect_rename)
-		opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
-				       DIFF_SETUP_USE_CACHE);
-	while (fgets(line, sizeof(line), stdin)) {
-		unsigned char sha1[20];
-
-		if (get_sha1_hex(line, sha1)) {
-			fputs(line, stdout);
-			fflush(stdout);
+			if (get_sha1_hex(line, sha1)) {
+				fputs(line, stdout);
+				fflush(stdout);
+			}
+			else
+				diff_tree_stdin(line);
 		}
-		else
-			diff_tree_stdin(line);
 	}
+	if (opt->diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
+		return DIFF_OPT_TST(&opt->diffopt, CHECK_FAILED) != 0;
 	return DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS)
 		&& DIFF_OPT_TST(&opt->diffopt, HAS_CHANGES);
 }
diff --git a/builtin-diff.c b/builtin-diff.c
index 55fb84c..86d01a3 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -353,7 +353,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 					     ent, ents);
 	if (DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
 		result = DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0;
-
+	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
+		return DIFF_OPT_TST(&rev.diffopt, CHECK_FAILED) != 0;
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
 	return result;
diff --git a/diff.c b/diff.c
index 9c79ee2..39109a6 100644
--- a/diff.c
+++ b/diff.c
@@ -1031,6 +1031,7 @@ struct checkdiff_t {
 	const char *filename;
 	int lineno, color_diff;
 	unsigned ws_rule;
+	unsigned status;
 };
 
 static void checkdiff_consume(void *priv, char *line, unsigned long len)
@@ -1064,6 +1065,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 			white_space_at_end = 1;
 
 		if (space_before_tab || white_space_at_end) {
+			data->status = 1;
 			printf("%s:%d: %s", data->filename, data->lineno, ws);
 			if (space_before_tab) {
 				printf("space before tab");
@@ -1454,7 +1456,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	diff_free_filespec_data(two);
 }
 
-static void builtin_checkdiff(const char *name_a, const char *name_b,
+static int builtin_checkdiff(const char *name_a, const char *name_b,
 			     struct diff_filespec *one,
 			     struct diff_filespec *two, struct diff_options *o)
 {
@@ -1462,7 +1464,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	struct checkdiff_t data;
 
 	if (!two)
-		return;
+		return 0;
 
 	memset(&data, 0, sizeof(data));
 	data.xm.consume = checkdiff_consume;
@@ -1491,6 +1493,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
  free_and_return:
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
+	return data.status;
 }
 
 struct diff_filespec *alloc_filespec(const char *path)
@@ -2075,14 +2078,14 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	builtin_diffstat(name, other, p->one, p->two, diffstat, o, complete_rewrite);
 }
 
-static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
+static int run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 {
 	const char *name;
 	const char *other;
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
-		return;
+		return 0;
 	}
 
 	name = p->one->path;
@@ -2091,7 +2094,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	diff_fill_sha1_info(p->one);
 	diff_fill_sha1_info(p->two);
 
-	builtin_checkdiff(name, other, p->one, p->two, o);
+	return builtin_checkdiff(name, other, p->one, p->two, o);
 }
 
 void diff_setup(struct diff_options *options)
@@ -2121,7 +2124,12 @@ int diff_setup_done(struct diff_options *options)
 	if (options->output_format & DIFF_FORMAT_NAME_STATUS)
 		count++;
 	if (options->output_format & DIFF_FORMAT_CHECKDIFF)
+	{
 		count++;
+		if (DIFF_OPT_TST(options, QUIET) ||
+		    DIFF_OPT_TST(options, EXIT_WITH_STATUS))
+			die("--check may not be used with --quiet or --exit-code");
+	}
 	if (options->output_format & DIFF_FORMAT_NO_OUTPUT)
 		count++;
 	if (count > 1)
@@ -2588,17 +2596,17 @@ static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
 	run_diffstat(p, o, diffstat);
 }
 
-static void diff_flush_checkdiff(struct diff_filepair *p,
+static int diff_flush_checkdiff(struct diff_filepair *p,
 		struct diff_options *o)
 {
 	if (diff_unmodified_pair(p))
-		return;
+		return 0;
 
 	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
-		return; /* no tree diffs in patch format */
+		return 0; /* no tree diffs in patch format */
 
-	run_checkdiff(p, o);
+	return run_checkdiff(p, o);
 }
 
 int diff_queue_is_empty(void)
@@ -2717,16 +2725,19 @@ static int check_pair_status(struct diff_filepair *p)
 	}
 }
 
-static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
+static int flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 {
 	int fmt = opt->output_format;
 
 	if (fmt & DIFF_FORMAT_CHECKDIFF)
-		diff_flush_checkdiff(p, opt);
+		return diff_flush_checkdiff(p, opt);
 	else if (fmt & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))
 		diff_flush_raw(p, opt);
 	else if (fmt & DIFF_FORMAT_NAME)
 		write_name_quoted(p->two->path, stdout, opt->line_termination);
+
+	/* return value only matters with DIFF_FORMAT_CHECKDIFF */
+	return 0;
 }
 
 static void show_file_mode_name(const char *newdelete, struct diff_filespec *fs)
@@ -2965,8 +2976,8 @@ void diff_flush(struct diff_options *options)
 			     DIFF_FORMAT_CHECKDIFF)) {
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				flush_one_pair(p, options);
+			if (check_pair_status(p) && flush_one_pair(p, options))
+				DIFF_OPT_SET(options, CHECK_FAILED);
 		}
 		separator++;
 	}
diff --git a/diff.h b/diff.h
index a52496a..5d50d93 100644
--- a/diff.h
+++ b/diff.h
@@ -59,6 +59,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_ALLOW_EXTERNAL      (1 << 13)
 #define DIFF_OPT_EXIT_WITH_STATUS    (1 << 14)
 #define DIFF_OPT_REVERSE_DIFF        (1 << 15)
+#define DIFF_OPT_CHECK_FAILED        (1 << 16)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6adf9d1..dc538b3 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -117,7 +117,6 @@ EOF
 git diff -b > out
 test_expect_success 'another test, with -b' 'git diff expect out'
 
-
 test_expect_success 'check mixed spaces and tabs in indent' '
 
 	# This is indented with SP HT SP.
@@ -126,4 +125,140 @@ test_expect_success 'check mixed spaces and tabs in indent' '
 
 '
 
+test_expect_success 'check with no whitespace errors' '
+
+	git commit -m "snapshot" &&
+	echo "foo();" > x &&
+	git diff --check
+
+'
+
+test_expect_failure 'check with trailing whitespace' '
+
+	echo "foo(); " > x &&
+	git diff --check
+
+'
+
+test_expect_failure 'check with space before tab in indent' '
+
+	# indent has space followed by hard tab
+	echo " 	foo();" > x &&
+	git diff --check
+
+'
+
+test_expect_failure '--check and --exit-code are exclusive' '
+
+	git checkout x &&
+	git diff --check --exit-code
+
+'
+
+test_expect_failure '--check and --quiet are exclusive' '
+
+	git diff --check --quiet
+
+'
+
+test_expect_success 'check staged with no whitespace errors' '
+
+	echo "foo();" > x &&
+	git add x &&
+	git diff --cached --check
+
+'
+
+test_expect_failure 'check staged with trailing whitespace' '
+
+	echo "foo(); " > x &&
+	git add x &&
+	git diff --cached --check
+
+'
+
+test_expect_failure 'check staged with space before tab in indent' '
+
+	# indent has space followed by hard tab
+	echo " 	foo();" > x &&
+	git add x &&
+	git diff --cached --check
+
+'
+
+test_expect_success 'check with no whitespace errors (diff-index)' '
+
+	echo "foo();" > x &&
+	git add x &&
+	git diff-index --check HEAD
+
+'
+
+test_expect_failure 'check with trailing whitespace (diff-index)' '
+
+	echo "foo(); " > x &&
+	git add x &&
+	git diff-index --check HEAD
+
+'
+
+test_expect_failure 'check with space before tab in indent (diff-index)' '
+
+	# indent has space followed by hard tab
+	echo " 	foo();" > x &&
+	git add x &&
+	git diff-index --check HEAD
+
+'
+
+test_expect_success 'check staged with no whitespace errors (diff-index)' '
+
+	echo "foo();" > x &&
+	git add x &&
+	git diff-index --cached --check HEAD
+
+'
+
+test_expect_failure 'check staged with trailing whitespace (diff-index)' '
+
+	echo "foo(); " > x &&
+	git add x &&
+	git diff-index --cached --check HEAD
+
+'
+
+test_expect_failure 'check staged with space before tab in indent (diff-index)' '
+
+	# indent has space followed by hard tab
+	echo " 	foo();" > x &&
+	git add x &&
+	git diff-index --cached --check HEAD
+
+'
+
+test_expect_success 'check with no whitespace errors (diff-tree)' '
+
+	echo "foo();" > x &&
+	git commit -m "new commit" x &&
+	git diff-tree --check HEAD^ HEAD
+
+'
+
+test_expect_failure 'check with trailing whitespace (diff-tree)' '
+
+	echo "foo(); " > x &&
+	git commit -m "another commit" x &&
+	git diff-tree --check HEAD^ HEAD
+
+'
+
+test_expect_failure 'check with space before tab in indent (diff-tree)' '
+
+	# indent has space followed by hard tab
+	echo " 	foo();" > x &&
+	git commit -m "yet another" x &&
+	git diff-tree --check HEAD^ HEAD
+
+'
+
 test_done
-- 
1.5.4.rc0.4.g50348
