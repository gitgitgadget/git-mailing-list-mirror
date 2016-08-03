Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CECC21F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888AbcHCWIt (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:08:49 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42594 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757179AbcHCWIi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:08:38 -0400
X-AuditID: 12074414-ca3ff70000000931-ac-57a2699a745f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 6A.F0.02353.A9962A75; Wed,  3 Aug 2016 18:00:58 -0400 (EDT)
Received: from michael.fritz.box (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73M0fSf023677
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:00:56 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	git@vger.kernel.org
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
Date:	Thu,  4 Aug 2016 00:00:36 +0200
Message-Id: <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsUixO6iqDsrc1G4wdb5AhZdV7qZLBp6rzBb
	7F7cz2yx4uocZovbK+YzW/xo6WG22Ly5ncWB3ePv+w9MHjtn3WX3WLCp1ONZ7x5Gj4uXlD0+
	b5ILYIvisklJzcksSy3St0vgymieaF5wcw5jxaefm5kbGLeVdTFyckgImEgcuPKVtYuRi0NI
	YCujxORF95hBEkICx5kk/u1IBrHZBHQlFvU0M4HYIgLiEm+Pz2QHaWAW6GeS+NHRxQiSEBbw
	kVi59QILiM0ioCox6c15sAZegSiJvQcms0Jsk5O4PP0BG4jNKWAhcXXSbCaIZeYSbzt2sU5g
	5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIySsRHYwHjkpd4hRgINR
	iYc3QnxRuBBrYllxZe4hRkkOJiVR3pxUoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3nspQDne
	lMTKqtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWpRTBZGQ4OJQne5AygRsGi1PTUirTMnBKE
	NBMHJ8hwHqDha0FqeIsLEnOLM9Mh8qcYFaXEeS3SgRICIImM0jy4Xljcv2IUB3pFmLcapJ0H
	mDLgul8BDWYCGnzCYAHI4JJEhJRUA6PSdb0LO4pWl9ZxLHnsP1kvuc7j5iq3lADdzKu6fgcf
	PDin+L1xHdflq1NFu2e0Bv07VsmnXNf24ZRmdO197kVzFibHljGZvrZWuj9l28Zz5swZ3+U9
	ve5V/Nx4uTR/wZV9v2RYrtgxMh6aMs+22Cn4Sf2kVXfZZX7/EbdpePf7aOnnH5bHlx9RYinO
	SDTUYi4qTgQAQwQj29YCAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Some groups of added/deleted lines in diffs can be slid up or down,
because lines at the edges of the group are not unique. Picking good
shifts for such groups is not a matter of correctness but definitely has
a big effect on aesthetics. For example, consider the following two
diffs. The first is what standard Git emits:

    --- a/9c572b21dd090a1e5c5bb397053bf8043ffe7fb4:git-send-email.perl
    +++ b/6dcfa306f2b67b733a7eb2d7ded1bc9987809edb:git-send-email.perl
    @@ -231,6 +231,9 @@ if (!defined $initial_reply_to && $prompting) {
     }

     if (!$smtp_server) {
    +       $smtp_server = $repo->config('sendemail.smtpserver');
    +}
    +if (!$smtp_server) {
            foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
                    if (-x $_) {
                            $smtp_server = $_;

The following diff is equivalent, but is obviously preferable from an
aesthetic point of view:

    --- a/9c572b21dd090a1e5c5bb397053bf8043ffe7fb4:git-send-email.perl
    +++ b/6dcfa306f2b67b733a7eb2d7ded1bc9987809edb:git-send-email.perl
    @@ -230,6 +230,9 @@ if (!defined $initial_reply_to && $prompting) {
            $initial_reply_to =~ s/(^\s+|\s+$)//g;
     }

    +if (!$smtp_server) {
    +       $smtp_server = $repo->config('sendemail.smtpserver');
    +}
     if (!$smtp_server) {
            foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
                    if (-x $_) {

This patch teaches Git to pick better positions for such "diff sliders".

The original Git code basically always shifted such "sliders" as far
down in the file as possible. The only exception is when the slider can
be aligned with a group of the lines in the other file, in which case
Git favors one add+delete block over one add and a slightly offset
delete block. This naive algorithm often yields ugly diffs.

Commit d634d61ed6 improved the situation somewhat by preferring to
position add/delete groups to make their last line a blank line, when
that is possible. This heuristic does more good than harm, but can only
help if there are blank lines in the right places. It still leaves a lot
of ugly diffs.

This commit implements a new and much better heuristic for picking
optimal "slider" positions using the following approach: First observe
that each hypothetical positioning of a diff slider introduces two
splits: one between the context lines preceding the group and the first
added/deleted line, and the other between the last added/deleted line
and the first line of context following it. It tries to find the
positioning that creates the least bad splits.

Splits are evaluated based only on the presence and locations of nearby
blank lines, and the indentation of lines near the split. Basically, it
prefers to introduce splits between lines that are indented less and
adjacent to blank lines. In more detail:

1. It measures the following characteristics of a proposed splitting
   position:

   * the number of blank lines above the proposed split
   * whether the line directly after the split is blank
   * the number of blank lines following that line
   * the indentation of the nearest non-blank line above the split
   * the indentation of the line directly below the split
   * the indentation of the nearest non-blank line after that line

2. It combines these attributes using a bunch of empirically-optimized
   weighting factors to estimate a score of the "badness" of splitting
   the text at that position.

3. It defines the score for a positioning of a diff slider to be the sum
   of the scores for the splits at the top and bottom of the slider.

4. It computes scores like this for all possible positions of the diff
   slider, and selects the position with the smallest "badness" score.

The weighting factors were found by collecting a corpus of code samples
in various programming languages, deciding "by eye" the best positioning
for about 2700 diff sliders, then optimizing the weights against this
corpus to get the best agreement with the manually-determined values.
(One caveat is that the same corpus was used for both optimization and
testing.)

The resulting numbers of non-optimal diff groups were as follows:

| repository           | default | compaction | indent | optimized |
| -------------------- | ------- | ---------- | ------ | --------- |
| ant                  |     225 |        102 |      7 |         5 |
| bugzilla             |     208 |         81 |     14 |         8 |
| couchdb              |      44 |         24 |     13 |         4 |
| docker               |     180 |        160 |     29 |         7 |
| git                  |     446 |         59 |     27 |         4 |
| ipython              |     358 |        163 |     61 |        11 |
| junit                |     146 |         67 |      5 |         1 |
| nodejs               |     489 |         78 |     12 |         2 |
| phpmyadmin           |     330 |         49 |      1 |         0 |
| test-more            |      15 |          2 |      2 |         0 |
| test-unit            |      33 |         13 |      4 |         0 |
| xmonad               |      20 |          1 |      1 |         0 |
| -------------------- | ------- | ---------- | ------ | --------- |
| totals               |    2494 |        788 |    176 |        42 |

This table shows the number of diff slider groups that were positioned
differently than the human-generated values, for various repositories.
"default" is the default "git diff" algorithm. "compaction" is Git 2.9.0
with the `--compaction-heuristic` option "indent" is an earlier,
hand-optimized version of this heuristic "optimized" is the
machine-optimized version, which is implemented in this patch. As you
can see, this new heuristic disagrees with the hand-optimized positions
only 1.7% as often as the default Git algorithm.

The tools that were used to do this optimization and analysis and the
human-generated data values are recorded in a separate project [1]. If
other people add more test data (especially in other programming
languages and/or other text formats) and come up with weighting factors
that work better over a wider breadth of samples, it will be easy to
tweak the factors in the code.

[1] https://github.com/mhagger/diff-slider-tools

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Most of the testing I've done is to run it against the large number of
diffs in the corpus that I have been using to optimize the heuristic.
The diffs that it generates are "equivalent" to the originals
generated by Git (modulo slider positioning), and they are the same
(including slider positioning) as the diffs generated by the Python
code that I used to prototype this heuristic. Since I have very
carefully tested the output of the Python version, I conclude that
this C version is working correctly.

I think it would be hard to add test cases for this code. Maybe one or
two sanity checks would be worthwhile?

 Documentation/diff-options.txt |   6 +-
 diff.c                         |  11 ++
 git-add--interactive.perl      |   5 +-
 xdiff/xdiff.h                  |   1 +
 xdiff/xdiffi.c                 | 276 +++++++++++++++++++++++++++++++++++++++--
 5 files changed, 289 insertions(+), 10 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 705a873..78733c8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,10 +63,12 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
+--indent-heuristic::
+--no-indent-heuristic::
 --compaction-heuristic::
 --no-compaction-heuristic::
-	These are to help debugging and tuning an experimental
-	heuristic (which is off by default) that shifts the hunk
+	These are to help debugging and tuning experimental
+	heuristics (which are off by default) that shift the hunk
 	boundary in an attempt to make the resulting patch easier
 	to read.
 
diff --git a/diff.c b/diff.c
index 7d03419..24b5818 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@
 #endif
 
 static int diff_detect_rename_default;
+static int diff_indent_heuristic; /* experimental */
 static int diff_compaction_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
@@ -190,6 +191,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.indentheuristic")) {
+		diff_indent_heuristic = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.compactionheuristic")) {
 		diff_compaction_heuristic = git_config_bool(var, value);
 		return 0;
@@ -3286,6 +3291,8 @@ void diff_setup(struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
+	if (diff_indent_heuristic)
+		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	if (diff_compaction_heuristic)
 		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
 
@@ -3808,6 +3815,10 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
+	else if (!strcmp(arg, "--indent-heuristic"))
+		DIFF_XDL_SET(options, INDENT_HEURISTIC);
+	else if (!strcmp(arg, "--no-indent-heuristic"))
+		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--compaction-heuristic"))
 		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
 	else if (!strcmp(arg, "--no-compaction-heuristic"))
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 642cce1..ee3d812 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -45,6 +45,7 @@ my ($diff_new_color) =
 my $normal_color = $repo->get_color("", "reset");
 
 my $diff_algorithm = $repo->config('diff.algorithm');
+my $diff_indent_heuristic = $repo->config_bool('diff.indentheuristic');
 my $diff_compaction_heuristic = $repo->config_bool('diff.compactionheuristic');
 my $diff_filter = $repo->config('interactive.difffilter');
 
@@ -750,7 +751,9 @@ sub parse_diff {
 	if (defined $diff_algorithm) {
 		splice @diff_cmd, 1, 0, "--diff-algorithm=${diff_algorithm}";
 	}
-	if ($diff_compaction_heuristic) {
+	if ($diff_indent_heuristic) {
+		splice @diff_cmd, 1, 0, "--indent-heuristic";
+	} elsif ($diff_compaction_heuristic) {
 		splice @diff_cmd, 1, 0, "--compaction-heuristic";
 	}
 	if (defined $patch_mode_revision) {
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 7423f77..8db16d4 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -42,6 +42,7 @@ extern "C" {
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
 #define XDF_COMPACTION_HEURISTIC (1 << 8)
+#define XDF_INDENT_HEURISTIC (1 << 9)
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 7518cd5..a07c63e 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -413,6 +413,228 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 			     flags));
 }
 
+/*
+ * If a line is indented more than this, get_indent() just returns this value.
+ * This avoids having to do absurd amounts of work for data that are not
+ * human-readable text, and also ensures that the output of get_indent fits within
+ * an int.
+ */
+#define MAX_INDENT 200
+
+/*
+ * Return the amount of indentation of the specified line, treating TAB as 8
+ * columns. Return -1 if line is empty or contains only whitespace. Clamp the
+ * output value at MAX_INDENT.
+ */
+static int get_indent(xrecord_t *rec)
+{
+	long i;
+	int ret = 0;
+
+	for (i = 0; i < rec->size; i++) {
+		char c = rec->ptr[i];
+
+		if (!XDL_ISSPACE(c))
+			return ret;
+		else if (c == ' ')
+			ret += 1;
+		else if (c == '\t')
+			ret += 8 - ret % 8;
+		/* ignore other whitespace characters */
+
+		if (ret >= MAX_INDENT)
+			return MAX_INDENT;
+	}
+	/*
+	 * We have reached the end of the line without finding any non-space
+	 * characters; i.e., the whole line consists of trailing spaces, which we
+	 * are not interested in.
+	 */
+	return -1;
+}
+
+/*
+ * If more than this number of consecutive blank rows are found, just return this
+ * value. This avoids requiring O(N^2) work for pathological cases, and also
+ * ensures that the output of score_split fits in an int.
+ */
+#define MAX_BLANKS 20
+
+/* Characteristics measured about a hypothetical split position. */
+struct split_measurement {
+	/*
+	 * Is the split at the end of the file (aside from any blank lines)?
+	 */
+	int end_of_file;
+
+	/*
+	 * How much is the line immediately following the split indented (or -1 if
+	 * the line is blank):
+	 */
+	int indent;
+
+	/*
+	 * How many consecutive lines above the split are blank?
+	 */
+	int pre_blank;
+
+	/*
+	 * How much is the nearest non-blank line above the split indented (or -1
+	 * if there is no such line)?
+	 */
+	int pre_indent;
+
+	/*
+	 * How many lines after the line following the split are blank?
+	 */
+	int post_blank;
+
+	/*
+	 * How much is the nearest non-blank line after the line following the
+	 * split indented (or -1 if there is no such line)?
+	 */
+	int post_indent;
+};
+
+/*
+ * Fill m with information about a hypothetical split of xdf above line split.
+ */
+void measure_split(const xdfile_t *xdf, long split, struct split_measurement *m)
+{
+	long i;
+
+	if (split >= xdf->nrec) {
+		m->end_of_file = 1;
+		m->indent = -1;
+	} else {
+		m->end_of_file = 0;
+		m->indent = get_indent(xdf->recs[split]);
+	}
+
+	m->pre_blank = 0;
+	for (i = split - 1; i >= 0; i--) {
+		m->pre_indent = get_indent(xdf->recs[i]);
+		if (m->pre_indent != -1)
+			break;
+		m->pre_blank += 1;
+		if (m->pre_blank == MAX_BLANKS) {
+			m->pre_indent = 0;
+			break;
+		}
+	}
+
+	m->post_blank = 0;
+	for (i = split + 1; i < xdf->nrec; i++) {
+		m->post_indent = get_indent(xdf->recs[i]);
+		if (m->post_indent != -1)
+			break;
+		m->post_blank += 1;
+		if (m->post_blank == MAX_BLANKS) {
+			m->post_indent = 0;
+			break;
+		}
+	}
+}
+
+#define START_OF_FILE_BONUS 9
+#define END_OF_FILE_BONUS 46
+#define TOTAL_BLANK_WEIGHT 4
+#define PRE_BLANK_WEIGHT 16
+#define RELATIVE_INDENT_BONUS -1
+#define RELATIVE_INDENT_HAS_BLANK_BONUS 15
+#define RELATIVE_OUTDENT_BONUS -19
+#define RELATIVE_OUTDENT_HAS_BLANK_BONUS 2
+#define RELATIVE_DEDENT_BONUS -63
+#define RELATIVE_DEDENT_HAS_BLANK_BONUS 50
+
+/*
+ * Compute a badness score for the hypothetical split whose measurements are
+ * stored in m. The weight factors were determined empirically using the tools and
+ * corpus described in
+ *
+ *     https://github.com/mhagger/diff-slider-tools
+ *
+ * Also see that project if you want to improve the weights based on, for example,
+ * a larger or more diverse corpus.
+ */
+int score_split(const struct split_measurement *m)
+{
+	/*
+	 * A place to accumulate bonus factors (positive makes this index more
+	 * favored):
+	 */
+        int bonus = 0, score, total_blanks, indent, any_blanks;
+
+        if (m->pre_indent == -1 && m->pre_blank == 0)
+		bonus += START_OF_FILE_BONUS;
+
+        if (m->end_of_file)
+		bonus += END_OF_FILE_BONUS;
+
+        total_blanks = m->pre_blank;
+        if (m->indent == -1)
+		total_blanks += 1 + m->post_blank;
+
+	/* Bonuses based on the location of blank lines: */
+        bonus += TOTAL_BLANK_WEIGHT * total_blanks;
+	bonus += PRE_BLANK_WEIGHT * m->pre_blank;
+
+        if (m->indent != -1)
+		indent = m->indent;
+        else
+		indent = m->post_indent;
+
+        any_blanks = (total_blanks != 0);
+
+        if (indent == -1) {
+		score = 0;
+        } else if (m->pre_indent == -1) {
+		score = indent;
+        } else if (indent > m->pre_indent) {
+		/*
+		 * The line is indented more than its predecessor. Score it based
+		 * on the larger indent:
+		 */
+		score = indent;
+		bonus += RELATIVE_INDENT_BONUS;
+		bonus += RELATIVE_INDENT_HAS_BLANK_BONUS * any_blanks;
+	} else if (indent < m->pre_indent) {
+		/*
+		 * The line is indented less than its predecessor. It could be
+		 * that this line is the start of a new block (e.g., of an "else"
+		 * block, or of a block without a block terminator) or it could be
+		 * the end of the previous block.
+		 */
+		if (m->post_indent == -1 || indent >= m->post_indent) {
+			/*
+			 * That was probably the end of a block. Score based on
+			 * the line's own indent:
+			 */
+			score = indent;
+			bonus += RELATIVE_DEDENT_BONUS;
+			bonus += RELATIVE_DEDENT_HAS_BLANK_BONUS * any_blanks;
+		} else {
+			/*
+			 * The following line is indented more. So it is likely
+			 * that this line is the start of a block. It's a pretty
+			 * good place to split, so score it based on its own
+			 * indent:
+			 */
+			score = indent;
+			bonus += RELATIVE_OUTDENT_BONUS;
+			bonus += RELATIVE_OUTDENT_HAS_BLANK_BONUS * any_blanks;
+		}
+	} else {
+		/*
+		 * The line has the same indentation level as its predecessor. We
+		 * score it based on its own indent:
+		 */
+		score = indent;
+	}
+
+        return 10 * score - bonus;
+}
+
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long start, end, earliest_end, end_matching_other;
 	long io, groupsize, nrec = xdf->nrec;
@@ -553,15 +775,18 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		if (end == earliest_end)
 			continue; /* no shifting is possible */
 
+		/*
+		 * The group can be shifted. Possibly use this freedom to produce
+		 * a more intuitive diff.
+		 *
+		 * The group is currently shifted as far down as possible, so the
+		 * heuristics below only have to handle upwards shifts.
+		 */
+
 		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
 			/*
-			 * Compaction heuristic: if a group can be moved back and
-			 * forth, then if possible shift the group to make its
-			 * bottom line a blank line.
-			 *
-			 * As we already shifted the group forward as far as
-			 * possible in the earlier loop, we only need to handle
-			 * backward shifts, not forward ones.
+			 * Compaction heuristic: if possible, shift the group to
+			 * make its bottom line a blank line.
 			 */
 			while (start > 0 &&
 			       !is_blank_line(recs[end - 1], flags) &&
@@ -587,6 +812,43 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				while (rchgo[io])
 					io--;
 			}
+		} else if (flags & XDF_INDENT_HEURISTIC) {
+			/*
+			 * Indent heuristic: a group of pure add/delete lines
+			 * implies two splits, one between the end of the "before"
+			 * context and the start of the group, and another between
+			 * the end of the group and the beginning of the "after"
+			 * context. Some splits are aesthetically better and some
+			 * are worse. We compute a badness "score" for each split,
+			 * and add the scores for the two splits to define a
+			 * "score" for each position that the group can be shifted
+			 * to. Then we pick the shift with the lowest score.
+			 */
+			long shift, best_shift = -1;
+			int best_score = 0;
+
+			for (shift = earliest_end; shift <= end; shift++) {
+				struct split_measurement m;
+				int score;
+
+				measure_split(xdf, shift, &m);
+				score = score_split(&m);
+				measure_split(xdf, shift - groupsize, &m);
+				score += score_split(&m);
+				if (best_shift == -1 || score <= best_score) {
+					best_score = score;
+					best_shift = shift;
+				}
+			}
+
+			while (end > best_shift) {
+				rchg[--start] = 1;
+				rchg[--end] = 0;
+
+				io--;
+				while (rchgo[io])
+					io--;
+			}
 		}
 	}
 
-- 
2.8.1

