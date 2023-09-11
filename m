Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA375CA0EC5
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349242AbjIKVcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242475AbjIKPjz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:39:55 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42A7E9
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:39:48 -0700 (PDT)
From:   Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1694446785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EAmjbRZTBp7OJP7V8XLULB4LsHHEttWLXu0n1bOpMTs=;
        b=bIx05cdSGW7h6qDZK0q2LBS5xhA3sZ3E39lrrpucVpFMD1f0kr8OQpShNFNOTYhQv2I52C
        ytNWF/IpD0Cl2GiVWaIflsZzjTWC+G14VbScBqdM+cKyYAbb/Myh0RztoAbeZ4dUKHxMXq
        MPvGjzLCAXkvZ3hGG6ffsnDMckS/JL6mk+LGsnB8xU8dYy2DleQ1wb4NzOTWihUzNZzL9C
        YXtKrMsnftQG5xuCYnt8jFArwAGPZOhNdEw3TxsaBGcHFeixBcZ0AkNSRFSQRmwzROfTZI
        QzRY6xDVCzfcCl6CmZwk34wUcwUye+NXPL5rDwezBJaK2bGjnFUfpLbYJUiuQQ==
To:     git@vger.kernel.org
Subject: [PATCH] diff --stat: add config option to limit filename width
Date:   Mon, 11 Sep 2023 17:39:44 +0200
Message-Id: <87badb12f040d1c66cd9b89074d3de5015a45983.1694446743.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new configuration option diff.statNameWidth=<width> that is equivalent
to the command-line option --stat-name-width=<width>, but it is ignored
by format-patch.  This follows the logic established by the already
existing configuration option diff.statGraphWidth=<width>.

Limiting the widths of names and graphs in the --stat output makes sense
for interactive work on wide terminals with many columns, hence the support
for these configuration options.  They don't affect format-patch because
it already adheres to the traditional 80-column standard.

Update the documentation and add more tests to cover new configuration
option diff.statNameWidth=<width>.  While there, perform a few minor code
and whitespace cleanups here and there, as spotted.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/config/diff.txt  |  4 ++++
 Documentation/diff-options.txt | 17 +++++++-------
 builtin/diff.c                 |  1 +
 builtin/log.c                  |  1 +
 builtin/merge.c                |  1 +
 builtin/rebase.c               |  1 +
 diff.c                         | 11 +++++++--
 graph.c                        |  1 -
 t/t4052-stat-output.sh         | 41 ++++++++++++++++++++++++++++------
 9 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 35a7bf86d7..9391c77e55 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -52,6 +52,10 @@ directories with less than 10% of the total amount of changed files,
 and accumulating child directory counts in the parent directories:
 `files,10,cumulative`.
 
+diff.statNameWidth::
+	Limit the width of the filename part in --stat output. If set, applies
+	to all commands generating --stat output except format-patch.
+
 diff.statGraphWidth::
 	Limit the width of the graph part in --stat output. If set, applies
 	to all commands generating --stat output except format-patch.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9f33f88771..6603470dbe 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -210,14 +210,15 @@ have to use `--diff-algorithm=default` option.
 	part. Maximum width defaults to terminal width, or 80 columns
 	if not connected to a terminal, and can be overridden by
 	`<width>`. The width of the filename part can be limited by
-	giving another width `<name-width>` after a comma. The width
-	of the graph part can be limited by using
-	`--stat-graph-width=<width>` (affects all commands generating
-	a stat graph) or by setting `diff.statGraphWidth=<width>`
-	(does not affect `git format-patch`).
-	By giving a third parameter `<count>`, you can limit the
-	output to the first `<count>` lines, followed by `...` if
-	there are more.
+	giving another width `<name-width>` after a comma or by setting
+	`diff.statNameWidth=<width>`. The width of the graph part can be
+	limited by using `--stat-graph-width=<width>` or by setting
+	`diff.statGraphWidth=<width>`. Using `--stat` or
+	`--stat-graph-width` affects all commands generating a stat graph,
+	while setting `diff.statNameWidth` or `diff.statGraphWidth`
+	does not affect `git format-patch`.
+	By giving a third parameter `<count>`, you can limit the output to
+	the first `<count>` lines, followed by `...` if there are more.
 +
 These parameters can also be set individually with `--stat-width=<width>`,
 `--stat-name-width=<name-width>` and `--stat-count=<count>`.
diff --git a/builtin/diff.c b/builtin/diff.c
index 0b313549c7..c0f564273a 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -475,6 +475,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	/* Set up defaults that will apply to both no-index and regular diffs. */
 	rev.diffopt.stat_width = -1;
+	rev.diffopt.stat_name_width = -1;
 	rev.diffopt.stat_graph_width = -1;
 	rev.diffopt.flags.allow_external = 1;
 	rev.diffopt.flags.allow_textconv = 1;
diff --git a/builtin/log.c b/builtin/log.c
index 87088077d9..2901514778 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -175,6 +175,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->verbose_header = 1;
 	rev->diffopt.flags.recursive = 1;
 	rev->diffopt.stat_width = -1; /* use full terminal width */
+	rev->diffopt.stat_name_width = -1; /* respect statNameWidth config */
 	rev->diffopt.stat_graph_width = -1; /* respect statGraphWidth config */
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
diff --git a/builtin/merge.c b/builtin/merge.c
index de68910177..fd6942d0ef 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -488,6 +488,7 @@ static void finish(struct commit *head_commit,
 		struct diff_options opts;
 		repo_diff_setup(the_repository, &opts);
 		opts.stat_width = -1; /* use full terminal width */
+		opts.stat_name_width = -1; /* respect statNameWidth config */
 		opts.stat_graph_width = -1; /* respect statGraphWidth config */
 		opts.output_format |=
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 50cb85751f..ed15accec9 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1804,6 +1804,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		/* We want color (if set), but no pager */
 		repo_diff_setup(the_repository, &opts);
 		opts.stat_width = -1; /* use full terminal width */
+		opts.stat_name_width = -1; /* respect statNameWidth config */
 		opts.stat_graph_width = -1; /* respect statGraphWidth config */
 		opts.output_format |=
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
diff --git a/diff.c b/diff.c
index bccb018da4..353e3b2cc9 100644
--- a/diff.c
+++ b/diff.c
@@ -65,6 +65,7 @@ int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
 static int diff_relative;
+static int diff_stat_name_width;
 static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
@@ -410,6 +411,10 @@ int git_diff_ui_config(const char *var, const char *value,
 		diff_relative = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.statnamewidth")) {
+		diff_stat_name_width = git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
 	if (!strcmp(var, "diff.statgraphwidth")) {
 		diff_stat_graph_width = git_config_int(var, value, ctx->kvi);
 		return 0;
@@ -2704,12 +2709,14 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	number_width = decimal_width(max_change) > number_width ?
 		decimal_width(max_change) : number_width;
 
+	if (options->stat_name_width == -1)
+		options->stat_name_width = diff_stat_name_width;
 	if (options->stat_graph_width == -1)
 		options->stat_graph_width = diff_stat_graph_width;
 
 	/*
-	 * Guarantee 3/8*16==6 for the graph part
-	 * and 5/8*16==10 for the filename part
+	 * Guarantee 3/8*16 == 6 for the graph part
+	 * and 5/8*16 == 10 for the filename part
 	 */
 	if (width < 16 + 6 + number_width)
 		width = 16 + 6 + number_width;
diff --git a/graph.c b/graph.c
index 2a9dc430fa..1ca34770ee 100644
--- a/graph.c
+++ b/graph.c
@@ -339,7 +339,6 @@ void graph_setup_line_prefix(struct diff_options *diffopt)
 		diffopt->output_prefix = diff_output_prefix_callback;
 }
 
-
 struct git_graph *graph_init(struct rev_info *opt)
 {
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 3ee27e277d..beb2ec2a55 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -49,34 +49,63 @@ log -1 --stat
 EOF
 
 cat >expect.60 <<-'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
 EOF
 cat >expect.6030 <<-'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
 EOF
-cat >expect2.60 <<-'EOF'
+while read verb expect cmd args
+do
+	# No width limit applied when statNameWidth is ignored
+	case "$expect" in expect72|expect.6030)
+		test_expect_success "$cmd $verb statNameWidth config with long name" '
+			git -c diff.statNameWidth=30 $cmd $args >output &&
+			grep " | " output >actual &&
+			test_cmp $expect actual
+		';;
+	esac
+	# Maximum width limit still applied when statNameWidth is ignored
+	case "$expect" in expect.60|expect.6030)
+		test_expect_success "$cmd --stat=width $verb statNameWidth config with long name" '
+			git -c diff.statNameWidth=30 $cmd $args --stat=60 >output &&
+			grep " | " output >actual &&
+			test_cmp $expect actual
+		';;
+	esac
+done <<\EOF
+ignores expect72 format-patch -1 --stdout
+ignores expect.60 format-patch -1 --stdout
+respects expect.6030 diff HEAD^ HEAD --stat
+respects expect.6030 show --stat
+respects expect.6030 log -1 --stat
+EOF
+
+cat >expect.40 <<-'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+cat >expect2.40 <<-'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
 EOF
 cat >expect2.6030 <<-'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
 EOF
 while read expect cmd args
 do
 	test_expect_success "$cmd --stat=width: a long name is given more room when the bar is short" '
 		git $cmd $args --stat=40 >output &&
 		grep " | " output >actual &&
-		test_cmp $expect.60 actual
+		test_cmp $expect.40 actual
 	'
 
 	test_expect_success "$cmd --stat-width=width with long name" '
 		git $cmd $args --stat-width=40 >output &&
 		grep " | " output >actual &&
-		test_cmp $expect.60 actual
+		test_cmp $expect.40 actual
 	'
 
-	test_expect_success "$cmd --stat=...,name-width with long name" '
+	test_expect_success "$cmd --stat=width,name-width with long name" '
 		git $cmd $args --stat=60,30 >output &&
 		grep " | " output >actual &&
 		test_cmp $expect.6030 actual
@@ -94,7 +123,6 @@ expect show --stat
 expect log -1 --stat
 EOF
 
-
 test_expect_success 'preparation for big change tests' '
 	>abcd &&
 	git add abcd &&
@@ -207,7 +235,6 @@ respects expect40 show --stat
 respects expect40 log -1 --stat
 EOF
 
-
 cat >expect <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++
 EOF
