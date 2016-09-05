Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939E21F6BF
	for <e@80x24.org>; Mon,  5 Sep 2016 09:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbcIEJpl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 05:45:41 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50176 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932416AbcIEJpg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 05:45:36 -0400
X-AuditID: 1207440c-217ff700000008d5-e6-57cd3eaac44a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id E5.69.02261.AAE3DC75; Mon,  5 Sep 2016 05:45:14 -0400 (EDT)
Received: from bagpipes.fritz.box (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u859iwtT008788
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 5 Sep 2016 05:45:12 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 6/8] diff: improve positioning of add/delete blocks in diffs
Date:   Mon,  5 Sep 2016 11:44:51 +0200
Message-Id: <c271923828dfe0b950d8f22803fc509784532fcb.1473068229.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473068229.git.mhagger@alum.mit.edu>
References: <cover.1473068229.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqLvK7my4wa/zuhZdV7qZLBp6rzBb
        7F7cz2yx4uocZoszW4Gs2yvmM1v8aOlhtph51dpi8+Z2FgdOj7/vPzB57Jx1l91jwaZSj2e9
        exg9Ll5S9ti/dBubx+dNch63n21jCeCI4rJJSc3JLEst0rdL4Mp4/a+FreDyL8aK1y9WsjQw
        /t7D2MXIySEhYCLROm8TcxcjF4eQwFZGiYnv5jFBOCeZJF7/WcYOUsUmoCuxqKeZCcQWERCX
        eHt8JjtIEbPAXyaJxY/usoEkhAX8JV4ensIKYrMIqEo0Ny8BW8ErECWxcfJ3Noh1chKXtn1h
        BrE5BSwklnzpA1sgJGAuMW9eM/MERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIz
        S/RSU0o3MUJCkGcH47d1MocYBTgYlXh4LbTPhAuxJpYVV+YeYpTkYFIS5S1QPRsuxJeUn1KZ
        kVicEV9UmpNafIhRgoNZSYQ3xxYox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoE
        k5Xh4FCS4FUDaRQsSk1PrUjLzClBSDNxcIIM5wEa7mwDMry4IDG3ODMdIn+KUVFKnDcFJCEA
        ksgozYPrhaWIV4ziQK8I884HWcEDTC9w3a+ABjMBDV63+zTI4JJEhJRUA2PeRK7HMx5sLnjy
        6ofc9gIDpSmavuqHE2deLJGJ2660lffi3ov2JxhkFgff3fZFbwXrEzbm3dc+aBSe/G+4yvPD
        3rsm7ku9HpZmHpLLe13utkWnPFbHbolo7Y5dZgFlmTfSN/hvDPjoa+hionWSXdrA5qpaucA6
        yT9+02RWM2Q1ap29us5RtkeJpTgj0VCLuag4EQC/AMhx7AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

This patch teaches Git to pick better positions for such "diff sliders"
using heuristics that take the positions of nearby blank lines and the
indentation of nearby lines into account.

The existing Git code basically always shifts such "sliders" as far down
in the file as possible. The only exception is when the slider can be
aligned with a group of changed lines in the other file, in which case
Git favors depicting the change as one add+delete block rather than one
add and a slightly offset delete block. This naive algorithm often
yields ugly diffs.

Commit d634d61ed6 improved the situation somewhat by preferring to
position add/delete groups to make their last line a blank line, when
that is possible. This heuristic does more good than harm, but (1) it
can only help if there are blank lines in the right places, and (2)
always picks the last blank line, even if there are others that might be
better. The end result is that it makes perhaps 1/3 as many errors as
the default Git algorithm, but that still leaves a lot of ugly diffs.

This commit implements a new and much better heuristic for picking
optimal "slider" positions using the following approach: First observe
that each hypothetical positioning of a diff slider introduces two
splits: one between the context lines preceding the group and the first
added/deleted line, and the other between the last added/deleted line
and the first line of context following it. It tries to find the
positioning that creates the least bad splits.

Splits are evaluated based only on the presence and locations of nearby
blank lines, and the indentation of lines near the split. Basically, it
prefers to introduce splits adjacent to blank lines, between lines that
are indented less, and between lines with the same level of indentation.
In more detail:

1. It measures the following characteristics of a proposed splitting
   position in a `struct split_measurement`:

   * the number of blank lines above the proposed split
   * whether the line directly after the split is blank
   * the number of blank lines following that line
   * the indentation of the nearest non-blank line above the split
   * the indentation of the line directly below the split
   * the indentation of the nearest non-blank line after that line

2. It combines the measured attributes using a bunch of
   empirically-optimized weighting factors to derive a `struct
   split_score` that measures the "badness" of splitting the text at
   that position.

3. It combines the `split_score` for the top and the bottom of the
   slider at each of its possible positions, and selects the position
   that has the best `split_score`.

I determined the initial set of weighting factors by collecting a corpus
of Git histories from 29 open-source software projects in various
programming languages. I generated many diffs from this corpus, and
determined the best positioning "by eye" for about 6600 diff sliders. I
used about half of the repositories in the corpus (corresponding to
about 2/3 of the sliders) as a training set, and optimized the weights
against this corpus using a crude automated search of the parameter
space to get the best agreement with the manually-determined values.
Then I tested the resulting heuristic against the full corpus. The
results are summarized in the following table, in column `indent-1`:

| repository            | count |      Git 2.9.0 |     compaction | compaction-fixed |       indent-1 |       indent-2 |
| --------------------- | ----- | -------------- | -------------- | ---------------- | -------------- | -------------- |
| afnetworking          |   109 |    89  (81.7%) |    37  (33.9%) |      37  (33.9%) |     2   (1.8%) |     2   (1.8%) |
| alamofire             |    30 |    18  (60.0%) |    14  (46.7%) |      15  (50.0%) |     0   (0.0%) |     0   (0.0%) |
| angular               |   184 |   127  (69.0%) |    39  (21.2%) |      23  (12.5%) |     5   (2.7%) |     5   (2.7%) |
| animate               |   313 |     2   (0.6%) |     2   (0.6%) |       2   (0.6%) |     2   (0.6%) |     2   (0.6%) |
| ant                   |   380 |   356  (93.7%) |   152  (40.0%) |     148  (38.9%) |    15   (3.9%) |    15   (3.9%) | *
| bugzilla              |   306 |   263  (85.9%) |   109  (35.6%) |      99  (32.4%) |    14   (4.6%) |    15   (4.9%) | *
| corefx                |   126 |    91  (72.2%) |    22  (17.5%) |      21  (16.7%) |     6   (4.8%) |     6   (4.8%) |
| couchdb               |    78 |    44  (56.4%) |    26  (33.3%) |      28  (35.9%) |     6   (7.7%) |     6   (7.7%) | *
| cpython               |   937 |   158  (16.9%) |    50   (5.3%) |      49   (5.2%) |     5   (0.5%) |     5   (0.5%) | *
| discourse             |   160 |    95  (59.4%) |    42  (26.2%) |      36  (22.5%) |    18  (11.2%) |    13   (8.1%) |
| docker                |   307 |   194  (63.2%) |   198  (64.5%) |     253  (82.4%) |     8   (2.6%) |     8   (2.6%) | *
| electron              |   163 |   132  (81.0%) |    38  (23.3%) |      39  (23.9%) |     6   (3.7%) |     6   (3.7%) |
| git                   |   536 |   470  (87.7%) |    73  (13.6%) |      78  (14.6%) |    16   (3.0%) |    16   (3.0%) | *
| gitflow               |   127 |     0   (0.0%) |     0   (0.0%) |       0   (0.0%) |     0   (0.0%) |     0   (0.0%) |
| ionic                 |   133 |    89  (66.9%) |    29  (21.8%) |      38  (28.6%) |     1   (0.8%) |     1   (0.8%) |
| ipython               |   482 |   362  (75.1%) |   167  (34.6%) |     169  (35.1%) |    11   (2.3%) |    11   (2.3%) | *
| junit                 |   161 |   147  (91.3%) |    67  (41.6%) |      66  (41.0%) |     1   (0.6%) |     1   (0.6%) | *
| lighttable            |    15 |     5  (33.3%) |     0   (0.0%) |       2  (13.3%) |     0   (0.0%) |     0   (0.0%) |
| magit                 |    88 |    75  (85.2%) |    11  (12.5%) |       9  (10.2%) |     1   (1.1%) |     0   (0.0%) |
| neural-style          |    28 |     0   (0.0%) |     0   (0.0%) |       0   (0.0%) |     0   (0.0%) |     0   (0.0%) |
| nodejs                |   781 |   649  (83.1%) |   118  (15.1%) |     111  (14.2%) |     4   (0.5%) |     5   (0.6%) | *
| phpmyadmin            |   491 |   481  (98.0%) |    75  (15.3%) |      48   (9.8%) |     2   (0.4%) |     2   (0.4%) | *
| react-native          |   168 |   130  (77.4%) |    79  (47.0%) |      81  (48.2%) |     0   (0.0%) |     0   (0.0%) |
| rust                  |   171 |   128  (74.9%) |    30  (17.5%) |      27  (15.8%) |    16   (9.4%) |    14   (8.2%) |
| spark                 |   186 |   149  (80.1%) |    52  (28.0%) |      52  (28.0%) |     2   (1.1%) |     2   (1.1%) |
| tensorflow            |   115 |    66  (57.4%) |    48  (41.7%) |      48  (41.7%) |     5   (4.3%) |     5   (4.3%) |
| test-more             |    19 |    15  (78.9%) |     2  (10.5%) |       2  (10.5%) |     1   (5.3%) |     1   (5.3%) | *
| test-unit             |    51 |    34  (66.7%) |    14  (27.5%) |       8  (15.7%) |     2   (3.9%) |     2   (3.9%) | *
| xmonad                |    23 |    22  (95.7%) |     2   (8.7%) |       2   (8.7%) |     1   (4.3%) |     1   (4.3%) | *
| --------------------- | ----- | -------------- | -------------- | ---------------- | -------------- | -------------- |
| totals                |  6668 |  4391  (65.9%) |  1496  (22.4%) |    1491  (22.4%) |   150   (2.2%) |   144   (2.2%) |
| totals (training set) |  4552 |  3195  (70.2%) |  1053  (23.1%) |    1061  (23.3%) |    86   (1.9%) |    88   (1.9%) |
| totals (test set)     |  2116 |  1196  (56.5%) |   443  (20.9%) |     430  (20.3%) |    64   (3.0%) |    56   (2.6%) |

In this table, the numbers are the count and percentage of human-rated
sliders that the corresponding algorithm got *wrong*. The columns are

* "repository" - the name of the repository used. I used the diffs
  between successive non-merge commits on the HEAD branch of the
  corresponding repository.

* "count" - the number of sliders that were human-rated. I chose most,
  but not all, sliders to rate from those among which the various
  algorithms gave different answers.

* "Git 2.9.0" - the default algorithm used by `git diff` in Git 2.9.0.

* "compaction" - the heuristic used by `git diff --compaction-heuristic`
  in Git 2.9.0.

* "compaction-fixed" - the heuristic used by `git diff
  --compaction-heuristic` after the fixes from earlier in this patch
  series. Note that the results are not dramatically different than
  those for "compaction". Both produce non-ideal diffs only about 1/3 as
  often as the default `git diff`.

* "indent-1" - the new `--indent-heuristic` algorithm, using the first
  set of weighting factors, determined as described above.

* "indent-2" - the new `--indent-heuristic` algorithm, using the final
  set of weighting factors, determined as described below.

* `*` - indicates that repo was part of training set used to determine
  the first set of weighting factors.

The fact that the heuristic performed nearly as well on the test set as
on the training set in column "indent-1" is a good indication that the
heuristic was not over-trained. Given that fact, I ran a second round of
optimization, using the entire corpus as the training set. The resulting
set of weights gave the results in column "indent-2". These are the
weights included in this patch.

The final result gives consistently and significantly better results
across the whole corpus than either `git diff` or `git diff
--compaction-heuristic`. It makes only about 1/30 as many errors as the
former and about 1/10 as many errors as the latter. (And a good fraction
of the remaining errors are for diffs that involve weirdly-formatted
code, sometimes apparently machine-generated.)

The tools that were used to do this optimization and analysis, along
with the human-generated data values, are recorded in a separate project
[1].

This patch adds a new command-line option `--indent-heuristic`, and a
new configuration setting `diff.indentHeuristic`, that activate this
heuristic. This interface is only meant for testing purposes, and should
be finalized before including this change in any release.

[1] https://github.com/mhagger/diff-slider-tools

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/diff-config.txt  |   7 +-
 Documentation/diff-options.txt |   9 +-
 diff.c                         |  23 ++-
 git-add--interactive.perl      |   5 +-
 t/t4059-diff-indent.sh         | 187 ++++++++++++++++++++++++
 xdiff/xdiff.h                  |   1 +
 xdiff/xdiffi.c                 | 325 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 546 insertions(+), 11 deletions(-)
 create mode 100755 t/t4059-diff-indent.sh

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index d5a5b17..c32bd85 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -170,10 +170,11 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
+diff.indentHeuristic::
 diff.compactionHeuristic::
-	Set this option to `true` to enable an experimental heuristic that
-	shifts the hunk boundary in an attempt to make the resulting
-	patch easier to read.
+	Set one of these options to `true` to enable one of two
+	experimental heuristics that shift diff hunk boundaries to
+	make patches easier to read.
 
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 705a873..ffc2b60 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,12 +63,13 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
+--indent-heuristic::
+--no-indent-heuristic::
 --compaction-heuristic::
 --no-compaction-heuristic::
-	These are to help debugging and tuning an experimental
-	heuristic (which is off by default) that shifts the hunk
-	boundary in an attempt to make the resulting patch easier
-	to read.
+	These are to help debugging and tuning experimental heuristics
+	(which are off by default) that shift diff hunk boundaries to
+	make patches easier to read.
 
 --minimal::
 	Spend extra time to make sure the smallest possible
diff --git a/diff.c b/diff.c
index 534c12e..8b15ed7 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@
 #endif
 
 static int diff_detect_rename_default;
+static int diff_indent_heuristic; /* experimental */
 static int diff_compaction_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
@@ -190,8 +191,16 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.indentheuristic")) {
+		diff_indent_heuristic = git_config_bool(var, value);
+		if (diff_indent_heuristic)
+			diff_compaction_heuristic = 0;
+		return 0;
+	}
 	if (!strcmp(var, "diff.compactionheuristic")) {
 		diff_compaction_heuristic = git_config_bool(var, value);
+		if (diff_compaction_heuristic)
+			diff_indent_heuristic = 0;
 		return 0;
 	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
@@ -3293,7 +3302,9 @@ void diff_setup(struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
-	if (diff_compaction_heuristic)
+	if (diff_indent_heuristic)
+		DIFF_XDL_SET(options, INDENT_HEURISTIC);
+	else if (diff_compaction_heuristic)
 		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
@@ -3815,9 +3826,15 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
-	else if (!strcmp(arg, "--compaction-heuristic"))
+	else if (!strcmp(arg, "--indent-heuristic")) {
+		DIFF_XDL_SET(options, INDENT_HEURISTIC);
+		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
+	} else if (!strcmp(arg, "--no-indent-heuristic"))
+		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
+	else if (!strcmp(arg, "--compaction-heuristic")) {
 		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
-	else if (!strcmp(arg, "--no-compaction-heuristic"))
+		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
+	} else if (!strcmp(arg, "--no-compaction-heuristic"))
 		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
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
diff --git a/t/t4059-diff-indent.sh b/t/t4059-diff-indent.sh
new file mode 100755
index 0000000..0a65b58
--- /dev/null
+++ b/t/t4059-diff-indent.sh
@@ -0,0 +1,187 @@
+#!/bin/sh
+
+test_description='Test diff indent heuristic.
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+# Compare two diff outputs. Ignore "index" lines, because we don't
+# care about SHA-1s or file modes.
+compare_diff () {
+	sed -e "/^index /d" <"$1" >.tmp-1
+	sed -e "/^index /d" <"$2" >.tmp-2
+	test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
+test_expect_success 'prepare' '
+	cat <<-\EOF >spaces.txt &&
+	1
+	2
+	a
+
+	b
+	3
+	4
+	EOF
+
+	cat <<-\EOF >functions.c &&
+	1
+	2
+	/* function */
+	foo() {
+	    foo
+	}
+
+	3
+	4
+	EOF
+
+	git add spaces.txt functions.c &&
+	test_tick &&
+	git commit -m initial &&
+	git branch old &&
+
+	cat <<-\EOF >spaces.txt &&
+	1
+	2
+	a
+
+	b
+	a
+
+	b
+	3
+	4
+	EOF
+
+	cat <<-\EOF >functions.c &&
+	1
+	2
+	/* function */
+	bar() {
+	    foo
+	}
+
+	/* function */
+	foo() {
+	    foo
+	}
+
+	3
+	4
+	EOF
+
+	git add spaces.txt functions.c &&
+	test_tick &&
+	git commit -m initial &&
+	git branch new &&
+
+	tr "_" " " <<-\EOF >spaces-expect &&
+	diff --git a/spaces.txt b/spaces.txt
+	--- a/spaces.txt
+	+++ b/spaces.txt
+	@@ -3,5 +3,8 @@
+	 a
+	_
+	 b
+	+a
+	+
+	+b
+	 3
+	 4
+	EOF
+
+	tr "_" " " <<-\EOF >spaces-compacted-expect &&
+	diff --git a/spaces.txt b/spaces.txt
+	--- a/spaces.txt
+	+++ b/spaces.txt
+	@@ -2,6 +2,9 @@
+	 2
+	 a
+	_
+	+b
+	+a
+	+
+	 b
+	 3
+	 4
+	EOF
+
+	tr "_" " " <<-\EOF >functions-expect &&
+	diff --git a/functions.c b/functions.c
+	--- a/functions.c
+	+++ b/functions.c
+	@@ -1,6 +1,11 @@
+	 1
+	 2
+	 /* function */
+	+bar() {
+	+    foo
+	+}
+	+
+	+/* function */
+	 foo() {
+	     foo
+	 }
+	EOF
+
+	tr "_" " " <<-\EOF >functions-compacted-expect
+	diff --git a/functions.c b/functions.c
+	--- a/functions.c
+	+++ b/functions.c
+	@@ -1,5 +1,10 @@
+	 1
+	 2
+	+/* function */
+	+bar() {
+	+    foo
+	+}
+	+
+	 /* function */
+	 foo() {
+	     foo
+	EOF
+'
+
+test_expect_success 'diff: ugly spaces' '
+	git diff old new -- spaces.txt >out &&
+	compare_diff spaces-expect out
+'
+
+test_expect_success 'diff: nice spaces with --indent-heuristic' '
+	git diff --indent-heuristic old new -- spaces.txt >out-compacted &&
+	compare_diff spaces-compacted-expect out-compacted
+'
+
+test_expect_success 'diff: nice spaces with diff.indentHeuristic' '
+	git -c diff.indentHeuristic=true diff old new -- spaces.txt >out-compacted2 &&
+	compare_diff spaces-compacted-expect out-compacted2
+'
+
+test_expect_success 'diff: --no-indent-heuristic overrides config' '
+	git -c diff.indentHeuristic=true diff --no-indent-heuristic old new -- spaces.txt >out2 &&
+	compare_diff spaces-expect out2
+'
+
+test_expect_success 'diff: --indent-heuristic with --patience' '
+	git diff --indent-heuristic --patience old new -- spaces.txt >out-compacted3 &&
+	compare_diff spaces-compacted-expect out-compacted3
+'
+
+test_expect_success 'diff: --indent-heuristic with --histogram' '
+	git diff --indent-heuristic --histogram old new -- spaces.txt >out-compacted4 &&
+	compare_diff spaces-compacted-expect out-compacted4
+'
+
+test_expect_success 'diff: ugly functions' '
+	git diff old new -- functions.c >out &&
+	compare_diff functions-expect out
+'
+
+test_expect_success 'diff: nice functions with --indent-heuristic' '
+	git diff --indent-heuristic old new -- functions.c >out-compacted &&
+	compare_diff functions-compacted-expect out-compacted
+'
+
+test_done
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
index 44fded6..67c1ccc 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -414,6 +414,286 @@ static int recs_match(xrecord_t *rec1, xrecord_t *rec2, long flags)
 }
 
 /*
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
+
+	/* The line contains only whitespace. */
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
+struct split_score {
+	/* The effective indent of this split (smaller is preferred). */
+	int effective_indent;
+
+	/* Penalty for this split (smaller is preferred). */
+	int penalty;
+};
+
+/*
+ * Fill m with information about a hypothetical split of xdf above line split.
+ */
+static void measure_split(const xdfile_t *xdf, long split,
+			  struct split_measurement *m)
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
+	m->pre_indent = -1;
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
+	m->post_indent = -1;
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
+/*
+ * The empirically-determined weight factors used by score_split() below.
+ * Larger values means that the position is a less favorable place to split.
+ *
+ * Note that scores are only ever compared against each other, so multiplying
+ * all of these weight/penalty values by the same factor wouldn't change the
+ * heuristic's behavior. Still, we need to set that arbitrary scale *somehow*.
+ * In practice, these numbers are chosen to be large enough that they can be
+ * adjusted relative to each other with sufficient precision despite using
+ * integer math.
+ */
+
+/* Penalty if there are no non-blank lines before the split */
+#define START_OF_FILE_PENALTY 1
+
+/* Penalty if there are no non-blank lines after the split */
+#define END_OF_FILE_PENALTY 21
+
+/* Multiplier for the number of blank lines around the split */
+#define TOTAL_BLANK_WEIGHT (-30)
+
+/* Multiplier for the number of blank lines after the split */
+#define POST_BLANK_WEIGHT 6
+
+/*
+ * Penalties applied if the line is indented more than its predecessor
+ */
+#define RELATIVE_INDENT_PENALTY (-4)
+#define RELATIVE_INDENT_WITH_BLANK_PENALTY 10
+
+/*
+ * Penalties applied if the line is indented less than both its predecessor and
+ * its successor
+ */
+#define RELATIVE_OUTDENT_PENALTY 24
+#define RELATIVE_OUTDENT_WITH_BLANK_PENALTY 17
+
+/*
+ * Penalties applied if the line is indented less than its predecessor but not
+ * less than its successor
+ */
+#define RELATIVE_DEDENT_PENALTY 23
+#define RELATIVE_DEDENT_WITH_BLANK_PENALTY 17
+
+/*
+ * We only consider whether the sum of the effective indents for splits are
+ * less than (-1), equal to (0), or greater than (+1) each other. The resulting
+ * value is multiplied by the following weight and combined with the penalty to
+ * determine the better of two scores.
+ */
+#define INDENT_WEIGHT 60
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
+static void score_add_split(const struct split_measurement *m, struct split_score *s)
+{
+	/*
+	 * A place to accumulate penalty factors (positive makes this index more
+	 * favored):
+	 */
+	int post_blank, total_blank, indent, any_blanks;
+
+	if (m->pre_indent == -1 && m->pre_blank == 0)
+		s->penalty += START_OF_FILE_PENALTY;
+
+	if (m->end_of_file)
+		s->penalty += END_OF_FILE_PENALTY;
+
+	/*
+	 * Set post_blank to the number of blank lines following the split,
+	 * including the line immediately after the split:
+	 */
+	post_blank = (m->indent == -1) ? 1 + m->post_blank : 0;
+	total_blank = m->pre_blank + post_blank;
+
+	/* Penalties based on nearby blank lines: */
+	s->penalty += TOTAL_BLANK_WEIGHT * total_blank;
+	s->penalty += POST_BLANK_WEIGHT * post_blank;
+
+	if (m->indent != -1)
+		indent = m->indent;
+	else
+		indent = m->post_indent;
+
+	any_blanks = (total_blank != 0);
+
+	/* Note that the effective indent is -1 at the end of the file: */
+	s->effective_indent += indent;
+
+	if (indent == -1) {
+		/* No additional adjustments needed. */
+	} else if (m->pre_indent == -1) {
+		/* No additional adjustments needed. */
+	} else if (indent > m->pre_indent) {
+		/*
+		 * The line is indented more than its predecessor.
+		 */
+		s->penalty += any_blanks ?
+			RELATIVE_INDENT_WITH_BLANK_PENALTY :
+			RELATIVE_INDENT_PENALTY;
+	} else if (indent == m->pre_indent) {
+		/*
+		 * The line has the same indentation level as its predecessor.
+		 * No additional adjustments needed.
+		 */
+	} else {
+		/*
+		 * The line is indented less than its predecessor. It could be
+		 * the block terminator of the previous block, but it could
+		 * also be the start of a new block (e.g., an "else" block, or
+		 * maybe the previous block didn't have a block terminator).
+		 * Try to distinguish those cases based on what comes next:
+		 */
+		if (m->post_indent != -1 && m->post_indent > indent) {
+			/*
+			 * The following line is indented more. So it is likely
+			 * that this line is the start of a block.
+			 */
+			s->penalty += any_blanks ?
+				RELATIVE_OUTDENT_WITH_BLANK_PENALTY :
+				RELATIVE_OUTDENT_PENALTY;
+		} else {
+			/*
+			 * That was probably the end of a block.
+			 */
+			s->penalty += any_blanks ?
+				RELATIVE_DEDENT_WITH_BLANK_PENALTY :
+				RELATIVE_DEDENT_PENALTY;
+		}
+	}
+}
+
+static int score_cmp(struct split_score *s1, struct split_score *s2)
+{
+	/* -1 if s1.effective_indent < s2->effective_indent, etc. */
+	int cmp_indents = ((s1->effective_indent > s2->effective_indent) -
+			   (s1->effective_indent < s2->effective_indent));
+
+	return INDENT_WEIGHT * cmp_indents + (s1->penalty - s2->penalty);
+}
+
+/*
  * Represent a group of changed lines in an xdfile_t (i.e., a contiguous group
  * of lines that was inserted or deleted from the corresponding version of the
  * file). We consider there to be such a group at the beginning of the file, at
@@ -604,6 +884,14 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			}
 		} while (groupsize != g.end - g.start);
 
+		/*
+		 * If the group can be shifted, then we can possibly use this
+		 * freedom to produce a more intuitive diff.
+		 *
+		 * The group is currently shifted as far down as possible, so the
+		 * heuristics below only have to handle upwards shifts.
+		 */
+
 		if (g.end == earliest_end) {
 			/* no shifting was possible */
 		} else if (end_matching_other != -1) {
@@ -633,6 +921,43 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				if (group_previous(xdfo, &go))
 					xdl_bug("group sync broken sliding to blank line");
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
+			struct split_score best_score;
+
+			for (shift = earliest_end; shift <= g.end; shift++) {
+				struct split_measurement m;
+				struct split_score score = {0, 0};
+
+				measure_split(xdf, shift, &m);
+				score_add_split(&m, &score);
+				measure_split(xdf, shift - groupsize, &m);
+				score_add_split(&m, &score);
+				if (best_shift == -1 ||
+				    score_cmp(&score, &best_score) <= 0) {
+					best_score.effective_indent = score.effective_indent;
+					best_score.penalty = score.penalty;
+					best_shift = shift;
+				}
+			}
+
+			while (g.end > best_shift) {
+				if (group_slide_up(xdf, &g, flags))
+					xdl_bug("best shift unreached");
+				if (group_previous(xdfo, &go))
+					xdl_bug("group sync broken sliding to blank line");
+			}
 		}
 
 	next:
-- 
2.9.3

