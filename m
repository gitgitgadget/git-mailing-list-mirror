From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 6/6] New --dirstat=lines mode,
 doing dirstat analysis based on diffstat
Date: Wed, 27 Apr 2011 04:12:39 +0200
Message-ID: <1303870359-26083-7-git-send-email-johan@herland.net>
References: <1303776102-9085-1-git-send-email-johan@herland.net>
 <1303870359-26083-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 04:13:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEuFZ-0001oQ-Up
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 04:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894Ab1D0CMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 22:12:52 -0400
Received: from smtp.getmail.no ([84.208.15.66]:46164 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756766Ab1D0CMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 22:12:50 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA0015UGT9JN30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:12:45 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8A37D1EA5944_DB77B9DB	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:12:45 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 36E201EA38AD_DB77B9CF	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:12:44 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA00ENJGT6U700@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:12:44 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1303870359-26083-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172154>

This patch adds an alternative implementation of show_dirstat(), called
show_dirstat_by_line(), which uses the more expensive diffstat analysis
(as opposed to show_dirstat()'s own (relatively inexpensive) analysis)
to derive the numbers from which the --dirstat output is computed.

The alternative implementation is controlled by the new "lines" parameter
to the --dirstat option (or the diff.dirstat config variable).

For binary files, the diffstat analysis counts bytes instead of lines,
so to prevent binary files from dominating the dirstat results, the
byte counts for binary files are divided by 64 before being compared to
their textual/line-based counterparts. This is a stupid and ugly - but
very cheap - heuristic.

In linux-2.6.git, running the three different --dirstat modes:

  time git diff v2.6.20..v2.6.30 --dirstat=changes > /dev/null
vs.
  time git diff v2.6.20..v2.6.30 --dirstat=lines > /dev/null
vs.
  time git diff v2.6.20..v2.6.30 --dirstat=files > /dev/null

yields the following average runtimes on my machine:

 - "changes" (default): ~6.0 s
 - "lines":             ~9.6 s
 - "files":             ~0.1 s

So, as expected, there's a considerable performance hit (~60%) by going
through the full diffstat analysis as compared to the default "changes"
analysis (obviously, "files" is much faster than both). As such, the
"lines" mode is probably only useful if you really need the --dirstat
numbers to be consistent with the numbers returned from the other
--*stat options.

The patch also includes documentation and tests for the new dirstat mode.

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt       |    8 +++
 Documentation/diff-options.txt |    8 +++
 diff.c                         |   62 ++++++++++++++++++++++++-
 diff.h                         |    1 +
 t/t4046-diff-dirstat.sh        |  100 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c18dd5a..0cad75c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -837,6 +837,14 @@ diff.dirstat::
 	the amount of pure code movements within a file.  In other words,
 	rearranging lines in a file is not counted as much as other changes.
 	This is the default behavior when no parameter is given.
+`lines`;;
+	Compute the dirstat numbers by doing the regular line-based diff
+	analysis, and summing the removed/added line counts. (For binary
+	files, count 64-byte chunks instead, since binary files have no
+	natural concept of lines). This is a more expensive `--dirstat`
+	behavior than the `changes` behavior, but it does count rearranged
+	lines within a file as much as other changes. The resulting output
+	is consistent with what you get from the other `--*stat` options.
 `files`;;
 	Compute the dirstat numbers by counting the number of files changed.
 	Each changed file counts equally in the dirstat analysis. This is
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 4ad50b9..327d10a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -81,6 +81,14 @@ endif::git-format-patch[]
 	the amount of pure code movements within a file.  In other words,
 	rearranging lines in a file is not counted as much as other changes.
 	This is the default behavior when no parameter is given.
+`lines`;;
+	Compute the dirstat numbers by doing the regular line-based diff
+	analysis, and summing the removed/added line counts. (For binary
+	files, count 64-byte chunks instead, since binary files have no
+	natural concept of lines). This is a more expensive `--dirstat`
+	behavior than the `changes` behavior, but it does count rearranged
+	lines within a file as much as other changes. The resulting output
+	is consistent with what you get from the other `--*stat` options.
 `files`;;
 	Compute the dirstat numbers by counting the number of files changed.
 	Each changed file counts equally in the dirstat analysis. This is
diff --git a/diff.c b/diff.c
index eb26104..37c5fb5 100644
--- a/diff.c
+++ b/diff.c
@@ -79,10 +79,17 @@ static void parse_dirstat_params(struct diff_options *options, const char *param
 	while (*p) {
 		if (!prefixcmp(p, "changes")) {
 			p += 7;
+			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
+			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
+		}
+		else if (!prefixcmp(p, "lines")) {
+			p += 5;
+			DIFF_OPT_SET(options, DIRSTAT_BY_LINE);
 			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
 		}
 		else if (!prefixcmp(p, "files")) {
 			p += 5;
+			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
 			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
 		}
 		else if (!prefixcmp(p, "noncumulative")) {
@@ -1671,6 +1678,50 @@ found_damage:
 	gather_dirstat(options, &dir, changed, "", 0);
 }
 
+static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *options)
+{
+	int i;
+	unsigned long changed;
+	struct dirstat_dir dir;
+
+	if (data->nr == 0)
+		return;
+
+	dir.files = NULL;
+	dir.alloc = 0;
+	dir.nr = 0;
+	dir.percent = options->dirstat_percent;
+	dir.cumulative = DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE);
+
+	changed = 0;
+	for (i = 0; i < data->nr; i++) {
+		struct diffstat_file *file = data->files[i];
+		unsigned long damage = file->added + file->deleted;
+		if (file->is_binary)
+			/*
+			 * binary files counts bytes, not lines. Must find some
+			 * way to normalize binary bytes vs. textual lines.
+			 * The following heuristic assumes that there are 64
+			 * bytes per "line".
+			 * This is stupid and ugly, but very cheap...
+			 */
+			damage = (damage + 63) / 64;
+		ALLOC_GROW(dir.files, dir.nr + 1, dir.alloc);
+		dir.files[dir.nr].name = file->name;
+		dir.files[dir.nr].changed = damage;
+		changed += damage;
+		dir.nr++;
+	}
+
+	/* This can happen even with many files, if everything was renames */
+	if (!changed)
+		return;
+
+	/* Show all directories with more than x% of the changes */
+	qsort(dir.files, dir.nr, sizeof(dir.files[0]), dirstat_compare);
+	gather_dirstat(options, &dir, changed, "", 0);
+}
+
 static void free_diffstat_info(struct diffstat_t *diffstat)
 {
 	int i;
@@ -4080,6 +4131,7 @@ void diff_flush(struct diff_options *options)
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i, output_format = options->output_format;
 	int separator = 0;
+	int dirstat_by_line = 0;
 
 	/*
 	 * Order: raw, stat, summary, patch
@@ -4100,7 +4152,11 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT)) {
+	if (output_format & DIFF_FORMAT_DIRSTAT && DIFF_OPT_TST(options, DIRSTAT_BY_LINE))
+		dirstat_by_line = 1;
+
+	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT) ||
+	    dirstat_by_line) {
 		struct diffstat_t diffstat;
 
 		memset(&diffstat, 0, sizeof(struct diffstat_t));
@@ -4115,10 +4171,12 @@ void diff_flush(struct diff_options *options)
 			show_stats(&diffstat, options);
 		if (output_format & DIFF_FORMAT_SHORTSTAT)
 			show_shortstats(&diffstat, options);
+		if (output_format & DIFF_FORMAT_DIRSTAT)
+			show_dirstat_by_line(&diffstat, options);
 		free_diffstat_info(&diffstat);
 		separator++;
 	}
-	if (output_format & DIFF_FORMAT_DIRSTAT)
+	if ((output_format & DIFF_FORMAT_DIRSTAT) && !dirstat_by_line)
 		show_dirstat(options);
 
 	if (output_format & DIFF_FORMAT_SUMMARY && !is_summary_empty(q)) {
diff --git a/diff.h b/diff.h
index 781c620..5f12049 100644
--- a/diff.h
+++ b/diff.h
@@ -78,6 +78,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
 #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
+#define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/t/t4046-diff-dirstat.sh b/t/t4046-diff-dirstat.sh
index 3cafd0d..f1946a1 100755
--- a/t/t4046-diff-dirstat.sh
+++ b/t/t4046-diff-dirstat.sh
@@ -805,4 +805,104 @@ test_expect_success 'diff.dirstat=16.7,cumulative,files' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+cat <<EOF >expect_diff_dirstat
+  10.6% dst/copy/changed/
+  10.6% dst/copy/rearranged/
+  10.6% dst/copy/unchanged/
+  10.6% dst/move/changed/
+  10.6% dst/move/rearranged/
+  10.6% dst/move/unchanged/
+  10.6% src/move/changed/
+  10.6% src/move/rearranged/
+  10.6% src/move/unchanged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+   5.3% changed/
+  26.3% dst/copy/changed/
+  26.3% dst/copy/rearranged/
+  26.3% dst/copy/unchanged/
+   5.3% dst/move/changed/
+   5.3% dst/move/rearranged/
+   5.3% rearranged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  16.7% changed/
+  16.7% dst/copy/changed/
+  16.7% dst/copy/rearranged/
+  16.7% dst/move/changed/
+  16.7% dst/move/rearranged/
+  16.7% rearranged/
+EOF
+
+test_expect_success '--dirstat=lines' '
+	git diff --dirstat=lines HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=lines -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=lines -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success 'diff.dirstat=lines' '
+	git -c diff.dirstat=lines diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=lines diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=lines diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+cat <<EOF >expect_diff_dirstat
+   2.1% changed/
+  10.6% dst/copy/changed/
+  10.6% dst/copy/rearranged/
+  10.6% dst/copy/unchanged/
+  10.6% dst/move/changed/
+  10.6% dst/move/rearranged/
+  10.6% dst/move/unchanged/
+   2.1% rearranged/
+  10.6% src/move/changed/
+  10.6% src/move/rearranged/
+  10.6% src/move/unchanged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+   5.3% changed/
+  26.3% dst/copy/changed/
+  26.3% dst/copy/rearranged/
+  26.3% dst/copy/unchanged/
+   5.3% dst/move/changed/
+   5.3% dst/move/rearranged/
+   5.3% rearranged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  16.7% changed/
+  16.7% dst/copy/changed/
+  16.7% dst/copy/rearranged/
+  16.7% dst/move/changed/
+  16.7% dst/move/rearranged/
+  16.7% rearranged/
+EOF
+
+test_expect_success '--dirstat=lines,0' '
+	git diff --dirstat=lines,0 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=lines,0 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=lines,0 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success 'diff.dirstat=0,lines' '
+	git -c diff.dirstat=0,lines diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=0,lines diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=0,lines diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 test_done
-- 
1.7.5.rc1.3.g4d7b
