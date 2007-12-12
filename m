From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 2/2] "diff --check" should affect exit status
Date: Wed, 12 Dec 2007 09:12:02 +0100
Message-ID: <1197447122-93416-3-git-send-email-win@wincent.com>
References: <1197447122-93416-1-git-send-email-win@wincent.com>
 <1197447122-93416-2-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 09:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Mhv-00044F-D4
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 09:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbXLLIMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 03:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbXLLIMT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 03:12:19 -0500
Received: from wincent.com ([72.3.236.74]:43593 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbXLLIMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 03:12:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBC8C5bj014818;
	Wed, 12 Dec 2007 02:12:13 -0600
X-Mailer: git-send-email 1.5.3.7.1116.gf11de
In-Reply-To: <1197447122-93416-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68008>

"git diff" has a --check option that can be used to check for whitespace
problems but it only reported by printing warnings to the
console.

Now when the --check option is used we give a non-zero exit status,
making "git diff --check" nicer to use in scripts and hooks.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/diff-options.txt |    4 +++-
 builtin-diff-files.c           |    2 ++
 builtin-diff-index.c           |    2 ++
 builtin-diff-tree.c            |    2 ++
 builtin-diff.c                 |    3 ++-
 diff.c                         |   37 ++++++++++++++++++++++++-------------
 diff.h                         |    1 +
 t/t4015-diff-whitespace.sh     |   34 ++++++++++++++++++++++++++++++++++
 8 files changed, 70 insertions(+), 15 deletions(-)

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
index 2e13716..556c31d 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -134,6 +134,8 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		else
 			diff_tree_stdin(line);
 	}
+	if (opt->diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
+		return DIFF_OPT_TST(&opt->diffopt, CHECK_FAILED) != 0;
 	return DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS)
 		&& DIFF_OPT_TST(&opt->diffopt, HAS_CHANGES);
 }
diff --git a/builtin-diff.c b/builtin-diff.c
index 1b61599..6aeea93 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -365,7 +365,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
index e74a303..e89c7ce 100644
--- a/diff.c
+++ b/diff.c
@@ -996,6 +996,7 @@ struct checkdiff_t {
 	const char *filename;
 	int lineno, color_diff;
 	unsigned ws_rule;
+	int status;
 };
 
 static void checkdiff_consume(void *priv, char *line, unsigned long len)
@@ -1022,6 +1023,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 			white_space_at_end = 1;
 
 		if (space_before_tab || white_space_at_end) {
+			data->status = 1;
 			printf("%s:%d: %s", data->filename, data->lineno, ws);
 			if (space_before_tab) {
 				printf("space before tab");
@@ -1412,7 +1414,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	diff_free_filespec_data(two);
 }
 
-static void builtin_checkdiff(const char *name_a, const char *name_b,
+static int builtin_checkdiff(const char *name_a, const char *name_b,
 			     struct diff_filespec *one,
 			     struct diff_filespec *two, struct diff_options *o)
 {
@@ -1420,7 +1422,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	struct checkdiff_t data;
 
 	if (!two)
-		return;
+		return 0;
 
 	memset(&data, 0, sizeof(data));
 	data.xm.consume = checkdiff_consume;
@@ -1449,6 +1451,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
  free_and_return:
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
+	return data.status;
 }
 
 struct diff_filespec *alloc_filespec(const char *path)
@@ -2033,14 +2036,14 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
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
@@ -2049,7 +2052,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	diff_fill_sha1_info(p->one);
 	diff_fill_sha1_info(p->two);
 
-	builtin_checkdiff(name, other, p->one, p->two, o);
+	return builtin_checkdiff(name, other, p->one, p->two, o);
 }
 
 void diff_setup(struct diff_options *options)
@@ -2079,7 +2082,12 @@ int diff_setup_done(struct diff_options *options)
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
@@ -2546,17 +2554,17 @@ static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
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
@@ -2675,16 +2683,19 @@ static int check_pair_status(struct diff_filepair *p)
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
@@ -2923,8 +2934,8 @@ void diff_flush(struct diff_options *options)
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
index 79fdff3..c110201 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -117,4 +117,38 @@ EOF
 git diff -b > out
 test_expect_success 'another test, with -b' 'git diff expect out'
 
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
+	echo " 	foo();" > x &&
+	git diff --check
+
+'
+
+test_expect_failure '--check and --exit-code are exclusive' '
+
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
 test_done
-- 
1.5.3.7.1116.gf11de
