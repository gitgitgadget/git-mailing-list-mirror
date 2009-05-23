From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] diff: change semantics of "ignore whitespace" options
Date: Sat, 23 May 2009 12:24:49 -0700
Message-ID: <1243106690-6385-2-git-send-email-gitster@pobox.com>
References: <1243106690-6385-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:25:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wqm-0002Cd-M2
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892AbZEWTY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbZEWTY4
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:24:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbZEWTYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C38319150
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:24:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E18471914F for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:53 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243106690-6385-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 64FA66F2-47CF-11DE-AEAB-B4FDD46C8AFF-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119796>

Traditionally, the --ignore-whitespace* options have merely meant to tell
the diff output routine that some class of differences are not worth
showing in the textual diff output, so that the end user has easier time
to review the remaining (presumably more meaningful) changes.  These
options never affected the outcome of the command, given as the exit
status when the --exit-code option was in effect (either directly or
indirectly).

When you have only whitespace changes, however, you might expect

	git diff -b --exit-code

to report that there is _no_ change with zero exit status.

Change the semantics of --ignore-whitespace* options to mean more than
"omit showing the difference in text".

The exit status, when --exit-code is in effect, is computed by checking if
we found any differences at the path level, while diff frontends feed
filepairs to the diffcore engine.  When "ignore whitespace" options are in
effect, we defer this determination until the very end of diffcore
transformation.  We simply do not know until the textual diff is
generated, which comes very late in the pipeline.

When --quiet is in effect, various diff frontends optimize by breaking out
early from the loop that enumerates the filepairs, when we find the first
path level difference; when --ignore-whitespace* is used the above change
automatically disables this optimization.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                       |   35 +++++++++++++++++++++--
 diff.h                       |    1 +
 t/t4037-whitespace-status.sh |   63 ++++++++++++++++++++++++++++++++++++++++++
 tree-diff.c                  |    3 +-
 4 files changed, 98 insertions(+), 4 deletions(-)
 create mode 100755 t/t4037-whitespace-status.sh

diff --git a/diff.c b/diff.c
index f06876b..e4ab696 100644
--- a/diff.c
+++ b/diff.c
@@ -2370,6 +2370,21 @@ int diff_setup_done(struct diff_options *options)
 	if (count > 1)
 		die("--name-only, --name-status, --check and -s are mutually exclusive");
 
+	/*
+	 * Most of the time we can say "there are changes"
+	 * only by checking if there are changed paths, but
+	 * --ignore-whitespace* options force us to look
+	 * inside contets.
+	 */
+
+	if ((XDF_IGNORE_WHITESPACE|
+	     XDF_IGNORE_WHITESPACE_CHANGE|
+	     XDF_IGNORE_WHITESPACE_AT_EOL) & options->xdl_opts) {
+		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
+	} else {
+		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
+	}
+
 	if (DIFF_OPT_TST(options, FIND_COPIES_HARDER))
 		options->detect_rename = DIFF_DETECT_COPY;
 
@@ -3322,6 +3337,18 @@ free_queue:
 	q->nr = q->alloc = 0;
 	if (options->close_file)
 		fclose(options->file);
+
+	/*
+	 * Report the contents level differences with HAS_CHANGES;
+	 * diff_addremove/diff_change does not set the bit when
+	 * DIFF_FROM_CONTENTS is in effect (e.g. with -w).
+	 */
+	if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
+		if (options->found_changes)
+			DIFF_OPT_SET(options, HAS_CHANGES);
+		else
+			DIFF_OPT_CLR(options, HAS_CHANGES);
+	}
 }
 
 static void diffcore_apply_filter(const char *filter)
@@ -3458,7 +3485,7 @@ void diffcore_std(struct diff_options *options)
 	diff_resolve_rename_copy();
 	diffcore_apply_filter(options->filter);
 
-	if (diff_queued_diff.nr)
+	if (diff_queued_diff.nr && !DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
 		DIFF_OPT_SET(options, HAS_CHANGES);
 	else
 		DIFF_OPT_CLR(options, HAS_CHANGES);
@@ -3518,7 +3545,8 @@ void diff_addremove(struct diff_options *options,
 		fill_filespec(two, sha1, mode);
 
 	diff_queue(&diff_queued_diff, one, two);
-	DIFF_OPT_SET(options, HAS_CHANGES);
+	if (!DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
+		DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
 void diff_change(struct diff_options *options,
@@ -3550,7 +3578,8 @@ void diff_change(struct diff_options *options,
 	fill_filespec(two, new_sha1, new_mode);
 
 	diff_queue(&diff_queued_diff, one, two);
-	DIFF_OPT_SET(options, HAS_CHANGES);
+	if (!DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
+		DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
 void diff_unmerge(struct diff_options *options,
diff --git a/diff.h b/diff.h
index 6616877..538e4f0 100644
--- a/diff.h
+++ b/diff.h
@@ -66,6 +66,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
+#define DIFF_OPT_DIFF_FROM_CONTENTS  (1 << 22)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
diff --git a/t/t4037-whitespace-status.sh b/t/t4037-whitespace-status.sh
new file mode 100755
index 0000000..a30b03b
--- /dev/null
+++ b/t/t4037-whitespace-status.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='diff --exit-code with whitespace'
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir a b &&
+	echo >c &&
+	echo >a/d &&
+	echo >b/e &&
+	git add . &&
+	test_tick &&
+	git commit -m initial &&
+	echo " " >a/d &&
+	test_tick &&
+	git commit -a -m second &&
+	echo "  " >a/d &&
+	echo " " >b/e &&
+	git add a/d
+'
+
+test_expect_success 'diff-tree --exit-code' '
+	test_must_fail git diff --exit-code HEAD^ HEAD &&
+	test_must_fail git diff-tree --exit-code HEAD^ HEAD
+'
+
+test_expect_success 'diff-tree -b --exit-code' '
+	git diff -b --exit-code HEAD^ HEAD &&
+	git diff-tree -b -p --exit-code HEAD^ HEAD &&
+	git diff-tree -b --exit-code HEAD^ HEAD
+'
+
+test_expect_success 'diff-index --cached --exit-code' '
+	test_must_fail git diff --cached --exit-code HEAD &&
+	test_must_fail git diff-index --cached --exit-code HEAD
+'
+
+test_expect_success 'diff-index -b -p --cached --exit-code' '
+	git diff -b --cached --exit-code HEAD &&
+	git diff-index -b -p --cached --exit-code HEAD
+'
+
+test_expect_success 'diff-index --exit-code' '
+	test_must_fail git diff --exit-code HEAD &&
+	test_must_fail git diff-index --exit-code HEAD
+'
+
+test_expect_success 'diff-index -b -p --exit-code' '
+	git diff -b --exit-code HEAD &&
+	git diff-index -b -p --exit-code HEAD
+'
+
+test_expect_success 'diff-files --exit-code' '
+	test_must_fail git diff --exit-code &&
+	test_must_fail git diff-files --exit-code
+'
+
+test_expect_success 'diff-files -b -p --exit-code' '
+	git diff -b --exit-code &&
+	git diff-files -b -p --exit-code
+'
+
+test_done
diff --git a/tree-diff.c b/tree-diff.c
index edd8394..4b1e3f2 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -280,7 +280,8 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, stru
 	int baselen = strlen(base);
 
 	for (;;) {
-		if (DIFF_OPT_TST(opt, QUIET) && DIFF_OPT_TST(opt, HAS_CHANGES))
+		if (DIFF_OPT_TST(opt, QUIET) &&
+		    DIFF_OPT_TST(opt, HAS_CHANGES))
 			break;
 		if (opt->nr_paths) {
 			skip_uninteresting(t1, base, baselen, opt);
-- 
1.6.3.1.145.gb74d77
