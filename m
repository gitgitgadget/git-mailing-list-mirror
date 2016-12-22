Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CF11FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 21:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966670AbcLVVMR (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:12:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62204 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966666AbcLVVMP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:12:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32D4459C54;
        Thu, 22 Dec 2016 16:12:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RurJMEucbpYB8YT2SDpxEwzCg6Y=; b=jf4jP6
        iK7zM52jTkj1XDRLxtSCz7LJh3gpFjrwrcZNywyRoTZVEPKVz8BRC5xO4hRePJbz
        LVh7sRj7c1eLQgPS+uyIHK9A7gJd6jdGSl7lWK51pOpk39LEP47qi4082deKfsDE
        miELEQ9N4puxhh70jAHRBNUSjIzi/jeIL+0v0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ds2WMb9q1GZPF1va3htyZZ0WuNk20X23
        xv3gwoFCZK7P4DIbYbGQPzr5AvMm4szCvFOaCpfpw+0o0MZ+6xwQbD1jSndgyEdh
        vrjnpHrOWpMxSw0KdsLJv+F3+xcpyDAj19TSI300LDcAa4DxrCKmVlX1PYQZyGEK
        reoxIitizpU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A1F359C53;
        Thu, 22 Dec 2016 16:12:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7430959C52;
        Thu, 22 Dec 2016 16:12:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
        <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
Date:   Thu, 22 Dec 2016 13:12:12 -0800
In-Reply-To: <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
        (Jacob Keller's message of "Sat, 17 Dec 2016 00:02:40 -0800")
Message-ID: <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F208FF6-C88B-11E6-8442-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I don't think we have too many config options that interact in this
> way, so I understand that "last writing of a particular configuration"
> makes sense, but interactions between configs is something that would
> have never occurred to me. I'll send a patch to drop the compaction
> heuristic since I think we're all 100% in agreement that it is
> superseded by the new configuration (as no case has been shown where
> the new one is worse than compaction, and most show it to be better).

If I recall correctly, we agreed that we'll drop the implementation
of compaction, but use the name --compaction-heuristics to trigger
the new and improved "indent heuristics":

    <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>

So let's do this.

-- >8 --
Subject: [PATCH] diff: retire the original experimental "compaction" heuristics

This retires the experimental "compaction" heuristics but with a
twist.  It removes the mention of "indent" heuristics, which was a
competing experiment, from everywhere, guts the core logic of the
original "compaction" heuristics out and replaces it with the logic
used by the "indent" heuristics.

The externally visible effect of this change is that people who have
been experimenting by setting diff.compactionHeuristic configuration
or giving the command line option --compaction-heuristic will start
getting the behaviour based on the improved heuristics that used to
be called "indent" heuristics.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-config.txt            |  6 ++---
 Documentation/diff-heuristic-options.txt |  2 --
 builtin/blame.c                          |  3 +--
 diff.c                                   | 25 ++++-----------------
 git-add--interactive.perl                |  5 +----
 t/t4061-diff-indent.sh                   | 38 ++++++++++++++++----------------
 xdiff/xdiff.h                            |  1 -
 xdiff/xdiffi.c                           | 37 +++----------------------------
 8 files changed, 30 insertions(+), 87 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 58f4bd6afa..39fff3aef9 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -171,11 +171,9 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
-diff.indentHeuristic::
 diff.compactionHeuristic::
-	Set one of these options to `true` to enable one of two
-	experimental heuristics that shift diff hunk boundaries to
-	make patches easier to read.
+	Set this option to `true` to enable experimental heuristics
+	that shift diff hunk boundaries to make patches easier to read.
 
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
diff --git a/Documentation/diff-heuristic-options.txt b/Documentation/diff-heuristic-options.txt
index 36cb549df9..3cb024aa22 100644
--- a/Documentation/diff-heuristic-options.txt
+++ b/Documentation/diff-heuristic-options.txt
@@ -1,5 +1,3 @@
---indent-heuristic::
---no-indent-heuristic::
 --compaction-heuristic::
 --no-compaction-heuristic::
 	These are to help debugging and tuning experimental heuristics
diff --git a/builtin/blame.c b/builtin/blame.c
index 4ddfadb71f..395d4011fb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2596,7 +2596,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		 * and are only included here to get included in the "-h"
 		 * output:
 		 */
-		{ OPTION_LOWLEVEL_CALLBACK, 0, "indent-heuristic", NULL, NULL, N_("Use an experimental indent-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
 		{ OPTION_LOWLEVEL_CALLBACK, 0, "compaction-heuristic", NULL, NULL, N_("Use an experimental blank-line-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
 
 		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
@@ -2645,7 +2644,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	}
 parse_done:
 	no_whole_file_rename = !DIFF_OPT_TST(&revs.diffopt, FOLLOW_RENAMES);
-	xdl_opts |= revs.diffopt.xdl_opts & (XDF_COMPACTION_HEURISTIC | XDF_INDENT_HEURISTIC);
+	xdl_opts |= revs.diffopt.xdl_opts & XDF_COMPACTION_HEURISTIC;
 	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
 
diff --git a/diff.c b/diff.c
index 8981477c43..f1b01f5b1e 100644
--- a/diff.c
+++ b/diff.c
@@ -27,7 +27,6 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_indent_heuristic; /* experimental */
 static int diff_compaction_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
@@ -223,16 +222,8 @@ void init_diff_ui_defaults(void)
 
 int git_diff_heuristic_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "diff.indentheuristic")) {
-		diff_indent_heuristic = git_config_bool(var, value);
-		if (diff_indent_heuristic)
-			diff_compaction_heuristic = 0;
-	}
-	if (!strcmp(var, "diff.compactionheuristic")) {
+	if (!strcmp(var, "diff.compactionheuristic"))
 		diff_compaction_heuristic = git_config_bool(var, value);
-		if (diff_compaction_heuristic)
-			diff_indent_heuristic = 0;
-	}
 	return 0;
 }
 
@@ -3378,9 +3369,7 @@ void diff_setup(struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
-	if (diff_indent_heuristic)
-		DIFF_XDL_SET(options, INDENT_HEURISTIC);
-	else if (diff_compaction_heuristic)
+	if (diff_compaction_heuristic)
 		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
@@ -3876,15 +3865,9 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
-	else if (!strcmp(arg, "--indent-heuristic")) {
-		DIFF_XDL_SET(options, INDENT_HEURISTIC);
-		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
-	} else if (!strcmp(arg, "--no-indent-heuristic"))
-		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-	else if (!strcmp(arg, "--compaction-heuristic")) {
+	else if (!strcmp(arg, "--compaction-heuristic"))
 		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
-		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-	} else if (!strcmp(arg, "--no-compaction-heuristic"))
+	else if (!strcmp(arg, "--no-compaction-heuristic"))
 		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ee3d812695..642cce1ac6 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -45,7 +45,6 @@
 my $normal_color = $repo->get_color("", "reset");
 
 my $diff_algorithm = $repo->config('diff.algorithm');
-my $diff_indent_heuristic = $repo->config_bool('diff.indentheuristic');
 my $diff_compaction_heuristic = $repo->config_bool('diff.compactionheuristic');
 my $diff_filter = $repo->config('interactive.difffilter');
 
@@ -751,9 +750,7 @@ sub parse_diff {
 	if (defined $diff_algorithm) {
 		splice @diff_cmd, 1, 0, "--diff-algorithm=${diff_algorithm}";
 	}
-	if ($diff_indent_heuristic) {
-		splice @diff_cmd, 1, 0, "--indent-heuristic";
-	} elsif ($diff_compaction_heuristic) {
+	if ($diff_compaction_heuristic) {
 		splice @diff_cmd, 1, 0, "--compaction-heuristic";
 	}
 	if (defined $patch_mode_revision) {
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 556450609b..30f809d0d3 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test diff indent heuristic.
+test_description='Test diff compaction heuristic.
 
 '
 . ./test-lib.sh
@@ -157,28 +157,28 @@ test_expect_success 'diff: ugly spaces' '
 	compare_diff spaces-expect out
 '
 
-test_expect_success 'diff: nice spaces with --indent-heuristic' '
-	git diff --indent-heuristic old new -- spaces.txt >out-compacted &&
+test_expect_success 'diff: nice spaces with --compaction-heuristic' '
+	git diff --compaction-heuristic old new -- spaces.txt >out-compacted &&
 	compare_diff spaces-compacted-expect out-compacted
 '
 
-test_expect_success 'diff: nice spaces with diff.indentHeuristic' '
-	git -c diff.indentHeuristic=true diff old new -- spaces.txt >out-compacted2 &&
+test_expect_success 'diff: nice spaces with diff.compactionHeuristic' '
+	git -c diff.compactionHeuristic=true diff old new -- spaces.txt >out-compacted2 &&
 	compare_diff spaces-compacted-expect out-compacted2
 '
 
-test_expect_success 'diff: --no-indent-heuristic overrides config' '
-	git -c diff.indentHeuristic=true diff --no-indent-heuristic old new -- spaces.txt >out2 &&
+test_expect_success 'diff: --no-compaction-heuristic overrides config' '
+	git -c diff.compactionHeuristic=true diff --no-compaction-heuristic old new -- spaces.txt >out2 &&
 	compare_diff spaces-expect out2
 '
 
-test_expect_success 'diff: --indent-heuristic with --patience' '
-	git diff --indent-heuristic --patience old new -- spaces.txt >out-compacted3 &&
+test_expect_success 'diff: --compaction-heuristic with --patience' '
+	git diff --compaction-heuristic --patience old new -- spaces.txt >out-compacted3 &&
 	compare_diff spaces-compacted-expect out-compacted3
 '
 
-test_expect_success 'diff: --indent-heuristic with --histogram' '
-	git diff --indent-heuristic --histogram old new -- spaces.txt >out-compacted4 &&
+test_expect_success 'diff: --compaction-heuristic with --histogram' '
+	git diff --compaction-heuristic --histogram old new -- spaces.txt >out-compacted4 &&
 	compare_diff spaces-compacted-expect out-compacted4
 '
 
@@ -187,8 +187,8 @@ test_expect_success 'diff: ugly functions' '
 	compare_diff functions-expect out
 '
 
-test_expect_success 'diff: nice functions with --indent-heuristic' '
-	git diff --indent-heuristic old new -- functions.c >out-compacted &&
+test_expect_success 'diff: nice functions with --compaction-heuristic' '
+	git diff --compaction-heuristic old new -- functions.c >out-compacted &&
 	compare_diff functions-compacted-expect out-compacted
 '
 
@@ -197,18 +197,18 @@ test_expect_success 'blame: ugly spaces' '
 	compare_blame spaces-expect out-blame
 '
 
-test_expect_success 'blame: nice spaces with --indent-heuristic' '
-	git blame --indent-heuristic old..new -- spaces.txt >out-blame-compacted &&
+test_expect_success 'blame: nice spaces with --compaction-heuristic' '
+	git blame --compaction-heuristic old..new -- spaces.txt >out-blame-compacted &&
 	compare_blame spaces-compacted-expect out-blame-compacted
 '
 
-test_expect_success 'blame: nice spaces with diff.indentHeuristic' '
-	git -c diff.indentHeuristic=true blame old..new -- spaces.txt >out-blame-compacted2 &&
+test_expect_success 'blame: nice spaces with diff.compactionHeuristic' '
+	git -c diff.compactionHeuristic=true blame old..new -- spaces.txt >out-blame-compacted2 &&
 	compare_blame spaces-compacted-expect out-blame-compacted2
 '
 
-test_expect_success 'blame: --no-indent-heuristic overrides config' '
-	git -c diff.indentHeuristic=true blame --no-indent-heuristic old..new -- spaces.txt >out-blame2 &&
+test_expect_success 'blame: --no-compaction-heuristic overrides config' '
+	git -c diff.compactionHeuristic=true blame --no-compaction-heuristic old..new -- spaces.txt >out-blame2 &&
 	git blame old..new -- spaces.txt >out-blame &&
 	compare_blame spaces-expect out-blame2
 '
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 8db16d4ae6..7423f77fc8 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -42,7 +42,6 @@ extern "C" {
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
 #define XDF_COMPACTION_HEURISTIC (1 << 8)
-#define XDF_INDENT_HEURISTIC (1 << 9)
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 760fbb6db7..2131ea4920 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,11 +400,6 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
-static int is_blank_line(xrecord_t *rec, long flags)
-{
-	return xdl_blankline(rec->ptr, rec->size, flags);
-}
-
 static int recs_match(xrecord_t *rec1, xrecord_t *rec2, long flags)
 {
 	return (rec1->ha == rec2->ha &&
@@ -821,7 +816,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	struct xdlgroup g, go;
 	long earliest_end, end_matching_other;
 	long groupsize;
-	unsigned int blank_lines;
 
 	group_init(xdf, &g);
 	group_init(xdfo, &go);
@@ -846,13 +840,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 */
 			end_matching_other = -1;
 
-			/*
-			 * Boolean value that records whether there are any blank
-			 * lines that could be made to be the last line of this
-			 * group.
-			 */
-			blank_lines = 0;
-
 			/* Shift the group backward as much as possible: */
 			while (!group_slide_up(xdf, &g, flags))
 				if (group_previous(xdfo, &go))
@@ -869,11 +856,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 			/* Now shift the group forward as far as possible: */
 			while (1) {
-				if (!blank_lines)
-					blank_lines = is_blank_line(
-							xdf->recs[g.end - 1],
-							flags);
-
 				if (group_slide_down(xdf, &g, flags))
 					break;
 				if (group_next(xdfo, &go))
@@ -906,24 +888,11 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				if (group_previous(xdfo, &go))
 					xdl_bug("group sync broken sliding to match");
 			}
-		} else if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
+		} else if (flags & XDF_COMPACTION_HEURISTIC) {
 			/*
-			 * Compaction heuristic: if it is possible to shift the
-			 * group to make its bottom line a blank line, do so.
+			 * Heuristic based on the indentation level.
 			 *
-			 * As we already shifted the group forward as far as
-			 * possible in the earlier loop, we only need to handle
-			 * backward shifts, not forward ones.
-			 */
-			while (!is_blank_line(xdf->recs[g.end - 1], flags)) {
-				if (group_slide_up(xdf, &g, flags))
-					xdl_bug("blank line disappeared");
-				if (group_previous(xdfo, &go))
-					xdl_bug("group sync broken sliding to blank line");
-			}
-		} else if (flags & XDF_INDENT_HEURISTIC) {
-			/*
-			 * Indent heuristic: a group of pure add/delete lines
+			 * A group of pure add/delete lines
 			 * implies two splits, one between the end of the "before"
 			 * context and the start of the group, and another between
 			 * the end of the group and the beginning of the "after"
-- 
2.11.0-448-g9a11f8a62b

