Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C891CE7A8C
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 04:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjIWEB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 00:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIWEB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 00:01:28 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE619B
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 21:01:18 -0700 (PDT)
From:   Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1695441676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8zZzOvRtJjniV1MbByCvFQI79pJLGsiBkTU8QHWuURI=;
        b=Q447miPoPnyr5pU+sydL1kj29HyJsxHPO6pUO79EDNhsxLf1v4a6SRGn7h4jmSMPl9SPcx
        091Y5aIQiPvne/90m5i0JRvWLjKC+ci7cbzQorNCrwZnOZQ29evBaN361rMSf0Li7ZiXNz
        Sp+eKXkhgH0kLdumDPmRpftYwAWmP3pe9Ex4axHPOYKio+77vg20RIgZgsM7JgpqPDUz+0
        LQZ0RrrbyAJ5LQ11wAzJ4YtO3uxbZOO39JWvbOmrd0Wj4l/9YQ5bWkVRzmgXo1b27LMY+j
        ORGTJH+mt64jewLEW+Iu0DCndx5sQ8tSy2ZiRWLlIbCqnVFlxmxC6fddEJB1hg==
To:     git@vger.kernel.org
Subject: [PATCH v2] diff --stat: set the width defaults in a helper function
Date:   Sat, 23 Sep 2023 06:01:14 +0200
Message-Id: <d45d1dac1a20699e370905b88b6fd0ec296751e7.1695441501.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract the commonly used initialization of the --stat-width=<width>,
--stat-name-width=<width> and --stat-graph-with=<width> parameters to their
internal default values into a helper function, to avoid repeating the same
initialization code in a few places.

Add a couple of tests to additionally cover existing configuration options
diff.statNameWidth=<width> and diff.statGraphWidth=<width> when used by
git-merge to generate --stat outputs.  This closes the gap that existed
previously in the --stat tests, and reduces the chances for having any
regressions introduced by this commit.

While there, perform a small bunch of minor wording tweaks in the improved
unit test, to improve its test-level consistency a bit.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 builtin/diff.c         |  4 +--
 builtin/log.c          |  6 ++---
 builtin/merge.c        |  4 +--
 builtin/rebase.c       |  4 +--
 diff.c                 |  7 +++++
 diff.h                 |  1 +
 t/t4052-stat-output.sh | 60 ++++++++++++++++++++++++++----------------
 7 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index c0f564273a..55e7d21755 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -474,9 +474,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	repo_init_revisions(the_repository, &rev, prefix);
 
 	/* Set up defaults that will apply to both no-index and regular diffs. */
-	rev.diffopt.stat_width = -1;
-	rev.diffopt.stat_name_width = -1;
-	rev.diffopt.stat_graph_width = -1;
+	init_diffstat_widths(&rev.diffopt);
 	rev.diffopt.flags.allow_external = 1;
 	rev.diffopt.flags.allow_textconv = 1;
 
diff --git a/builtin/log.c b/builtin/log.c
index 80e1be1645..ba775d7b5c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -176,17 +176,15 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	if (default_follow)
 		rev->diffopt.flags.default_follow_renames = 1;
 	rev->verbose_header = 1;
+	init_diffstat_widths(&rev->diffopt);
 	rev->diffopt.flags.recursive = 1;
-	rev->diffopt.stat_width = -1; /* use full terminal width */
-	rev->diffopt.stat_name_width = -1; /* respect statNameWidth config */
-	rev->diffopt.stat_graph_width = -1; /* respect statGraphWidth config */
+	rev->diffopt.flags.allow_textconv = 1;
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	rev->patch_name_max = fmt_patch_name_max;
 	rev->show_signature = default_show_signature;
 	rev->encode_email_headers = default_encode_email_headers;
-	rev->diffopt.flags.allow_textconv = 1;
 
 	if (default_date_mode)
 		parse_date_format(default_date_mode, &rev->date_mode);
diff --git a/builtin/merge.c b/builtin/merge.c
index fd21c0d4f4..8f397cbeff 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -466,9 +466,7 @@ static void finish(struct commit *head_commit,
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
 		repo_diff_setup(the_repository, &opts);
-		opts.stat_width = -1; /* use full terminal width */
-		opts.stat_name_width = -1; /* respect statNameWidth config */
-		opts.stat_graph_width = -1; /* respect statGraphWidth config */
+		init_diffstat_widths(&opts);
 		opts.output_format |=
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename = DIFF_DETECT_RENAME;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b93dca95a6..4783f90ac5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1806,9 +1806,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		/* We want color (if set), but no pager */
 		repo_diff_setup(the_repository, &opts);
-		opts.stat_width = -1; /* use full terminal width */
-		opts.stat_name_width = -1; /* respect statNameWidth config */
-		opts.stat_graph_width = -1; /* respect statGraphWidth config */
+		init_diffstat_widths(&opts);
 		opts.output_format |=
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename = DIFF_DETECT_RENAME;
diff --git a/diff.c b/diff.c
index 353e3b2cc9..2c602df10a 100644
--- a/diff.c
+++ b/diff.c
@@ -6936,6 +6936,13 @@ void diff_queued_diff_prefetch(void *repository)
 	oid_array_clear(&to_fetch);
 }
 
+void init_diffstat_widths(struct diff_options *options)
+{
+	options->stat_width = -1;        /* use full terminal width */
+	options->stat_name_width = -1;   /* respect diff.statNameWidth config */
+	options->stat_graph_width = -1;  /* respect diff.statGraphWidth config */
+}
+
 void diffcore_std(struct diff_options *options)
 {
 	int output_formats_to_prefetch = DIFF_FORMAT_DIFFSTAT |
diff --git a/diff.h b/diff.h
index caf1528bf0..66bd8aeb29 100644
--- a/diff.h
+++ b/diff.h
@@ -573,6 +573,7 @@ int git_config_rename(const char *var, const char *value);
 
 #define DIFF_PICKAXE_IGNORE_CASE	32
 
+void init_diffstat_widths(struct diff_options *);
 void diffcore_std(struct diff_options *);
 void diffcore_fix_diff_index(void);
 
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index beb2ec2a55..7badd72488 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -12,7 +12,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-# 120 character name
+# 120-character name
 name=aaaaaaaaaa
 name=$name$name$name$name$name$name$name$name$name$name$name$name
 test_expect_success 'preparation' '
@@ -58,15 +58,15 @@ while read verb expect cmd args
 do
 	# No width limit applied when statNameWidth is ignored
 	case "$expect" in expect72|expect.6030)
-		test_expect_success "$cmd $verb statNameWidth config with long name" '
+		test_expect_success "$cmd $verb diff.statNameWidth with long name" '
 			git -c diff.statNameWidth=30 $cmd $args >output &&
 			grep " | " output >actual &&
 			test_cmp $expect actual
 		';;
 	esac
 	# Maximum width limit still applied when statNameWidth is ignored
 	case "$expect" in expect.60|expect.6030)
-		test_expect_success "$cmd --stat=width $verb statNameWidth config with long name" '
+		test_expect_success "$cmd --stat=width $verb diff.statNameWidth with long name" '
 			git -c diff.statNameWidth=30 $cmd $args --stat=60 >output &&
 			grep " | " output >actual &&
 			test_cmp $expect actual
@@ -111,19 +111,19 @@ do
 		test_cmp $expect.6030 actual
 	'
 
-	test_expect_success "$cmd --stat-name-width with long name" '
+	test_expect_success "$cmd --stat-name-width=width with long name" '
 		git $cmd $args --stat-name-width=30 >output &&
 		grep " | " output >actual &&
 		test_cmp $expect.6030 actual
 	'
 done <<\EOF
 expect2 format-patch --cover-letter -1 --stdout
 expect diff HEAD^ HEAD --stat
 expect show --stat
 expect log -1 --stat
 EOF
 
-test_expect_success 'preparation for big change tests' '
+test_expect_success 'preparation for big-change tests' '
 	>abcd &&
 	git add abcd &&
 	git commit -m message &&
@@ -139,7 +139,7 @@ cat >expect72 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
-test_expect_success "format-patch --cover-letter ignores COLUMNS (big change)" '
+test_expect_success "format-patch --cover-letter ignores COLUMNS with big change" '
 	COLUMNS=200 git format-patch -1 --stdout --cover-letter >output &&
 	grep " | " output >actual &&
 	test_cmp expect72 actual
@@ -159,15 +159,15 @@ cat >expect200-graph <<'EOF'
 EOF
 while read verb expect cmd args
 do
-	test_expect_success "$cmd $verb COLUMNS (big change)" '
+	test_expect_success "$cmd $verb COLUMNS with big change" '
 		COLUMNS=200 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
 
 	case "$cmd" in diff|show) continue;; esac
 
-	test_expect_success "$cmd --graph $verb COLUMNS (big change)" '
+	test_expect_success "$cmd --graph $verb COLUMNS with big change" '
 		COLUMNS=200 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
@@ -187,15 +187,15 @@ cat >expect40-graph <<'EOF'
 EOF
 while read verb expect cmd args
 do
-	test_expect_success "$cmd $verb not enough COLUMNS (big change)" '
+	test_expect_success "$cmd $verb not enough COLUMNS with big change" '
 		COLUMNS=40 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
 
 	case "$cmd" in diff|show) continue;; esac
 
-	test_expect_success "$cmd --graph $verb not enough COLUMNS (big change)" '
+	test_expect_success "$cmd --graph $verb not enough COLUMNS with big change" '
 		COLUMNS=40 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
@@ -215,15 +215,15 @@ cat >expect40-graph <<'EOF'
 EOF
 while read verb expect cmd args
 do
-	test_expect_success "$cmd $verb statGraphWidth config" '
+	test_expect_success "$cmd $verb diff.statGraphWidth" '
 		git -c diff.statGraphWidth=26 $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
 
 	case "$cmd" in diff|show) continue;; esac
 
-	test_expect_success "$cmd --graph $verb statGraphWidth config" '
+	test_expect_success "$cmd --graph $verb diff.statGraphWidth" '
 		git -c diff.statGraphWidth=26 $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
@@ -255,33 +255,33 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "$cmd --stat-graph-width with big change" '
+	test_expect_success "$cmd --stat-graph-width=width with big change" '
 		git $cmd $args --stat-graph-width=26 >output &&
 		grep " | " output >actual &&
 		test_cmp expect actual
 	'
 
 	case "$cmd" in diff|show) continue;; esac
 
 	test_expect_success "$cmd --stat-width=width --graph with big change" '
 		git $cmd $args --stat-width=40 --graph >output &&
 		grep " | " output >actual &&
 		test_cmp expect-graph actual
 	'
 
-	test_expect_success "$cmd --stat-graph-width --graph with big change" '
+	test_expect_success "$cmd --stat-graph-width=width --graph with big change" '
 		git $cmd $args --stat-graph-width=26 --graph >output &&
 		grep " | " output >actual &&
 		test_cmp expect-graph actual
 	'
 done <<\EOF
 format-patch -1 --stdout
 diff HEAD^ HEAD --stat
 show --stat
 log -1 --stat
 EOF
 
-test_expect_success 'preparation for long filename tests' '
+test_expect_success 'preparation for long-name tests' '
 	cp abcd aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
 	git add aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
 	git commit -m message
@@ -329,15 +329,15 @@ cat >expect200-graph <<'EOF'
 EOF
 while read verb expect cmd args
 do
-	test_expect_success "$cmd $verb COLUMNS (long filename)" '
+	test_expect_success "$cmd $verb COLUMNS with long name" '
 		COLUMNS=200 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
 
 	case "$cmd" in diff|show) continue;; esac
 
-	test_expect_success "$cmd --graph $verb COLUMNS (long filename)" '
+	test_expect_success "$cmd --graph $verb COLUMNS with long name" '
 		COLUMNS=200 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
@@ -358,41 +358,57 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success COLUMNS_CAN_BE_1 \
-		"$cmd $verb prefix greater than COLUMNS (big change)" '
+		"$cmd $verb prefix greater than COLUMNS with big change" '
 		COLUMNS=1 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
 
 	case "$cmd" in diff|show) continue;; esac
 
 	test_expect_success COLUMNS_CAN_BE_1 \
-		"$cmd --graph $verb prefix greater than COLUMNS (big change)" '
+		"$cmd --graph $verb prefix greater than COLUMNS with big change" '
 		COLUMNS=1 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
 done <<\EOF
 ignores expect72 format-patch -1 --stdout
 respects expect1 diff HEAD^ HEAD --stat
 respects expect1 show --stat
 respects expect1 log -1 --stat
 EOF
 
 cat >expect <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
-test_expect_success 'merge --stat respects COLUMNS (big change)' '
-	git checkout -b branch HEAD^^ &&
+test_expect_success 'merge --stat respects diff.statGraphWidth with big change' '
+	git checkout -b branch1 HEAD^^ &&
+	git -c diff.statGraphWidth=26 merge --stat --no-ff main^ >output &&
+	grep " | " output >actual &&
+	test_cmp expect40 actual
+'
+test_expect_success 'merge --stat respects COLUMNS with big change' '
+	git checkout -b branch2 HEAD^^ &&
 	COLUMNS=100 git merge --stat --no-ff main^ >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
 
 cat >expect <<'EOF'
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++
 EOF
-test_expect_success 'merge --stat respects COLUMNS (long filename)' '
+cat >expect.30 <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++++++++++++++++++++++++++++++
+EOF
+test_expect_success 'merge --stat respects diff.statNameWidth with long name' '
+	git switch branch1 &&
+	git -c diff.statNameWidth=30 merge --stat --no-ff main >output &&
+	grep " | " output >actual &&
+	test_cmp expect.30 actual
+'
+test_expect_success 'merge --stat respects COLUMNS with long name' '
+	git switch branch2 &&
 	COLUMNS=100 git merge --stat --no-ff main >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
