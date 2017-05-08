Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199431FC44
	for <e@80x24.org>; Mon,  8 May 2017 16:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdEHQDt (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 12:03:49 -0400
Received: from [192.252.130.194] ([192.252.130.194]:13107 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751312AbdEHQDk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 12:03:40 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id CB9CE61815;
        Mon,  8 May 2017 12:03:39 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/4] diff: have the diff-* builtins configure diff before initializing revisions
Date:   Mon,  8 May 2017 12:03:37 -0400
Message-Id: <20170508160339.4551-3-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.0.rc1.15.gf67d331ad
In-Reply-To: <20170508160339.4551-1-marcnarc@xiplink.com>
References: <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com>
 <20170508160339.4551-1-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This matches how the diff Porcelain works.  It makes the plumbing commands
respect diff's configuration options, such as indentHeuristic, because
init_revisions() calls diff_setup() which fills in the diff_options struct.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 builtin/diff-files.c   |  2 +-
 builtin/diff-index.c   |  2 +-
 builtin/diff-tree.c    |  2 +-
 t/t4061-diff-indent.sh | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 15c61fd8d..a572da9d5 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -20,9 +20,9 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	int result;
 	unsigned options = 0;
 
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(&rev, prefix);
 	gitmodules_config();
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 1af373d00..f084826a2 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -17,9 +17,9 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	int i;
 	int result;
 
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(&rev, prefix);
 	gitmodules_config();
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 326f88b65..36a3a1976 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -105,9 +105,9 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	struct setup_revision_opt s_r_opt;
 	int read_stdin = 0;
 
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(opt, prefix);
 	gitmodules_config();
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt->abbrev = 0;
 	opt->diff = 1;
 	opt->disable_stdin = 1;
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 556450609..13d3dc96a 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -213,4 +213,70 @@ test_expect_success 'blame: --no-indent-heuristic overrides config' '
 	compare_blame spaces-expect out-blame2
 '
 
+test_expect_success 'diff-tree: nice spaces with --indent-heuristic' '
+	git diff-tree --indent-heuristic -p old new -- spaces.txt >out-diff-tree-compacted &&
+	compare_diff spaces-compacted-expect out-diff-tree-compacted
+'
+
+test_expect_success 'diff-tree: nice spaces with diff.indentHeuristic' '
+	git -c diff.indentHeuristic=true diff-tree -p old new -- spaces.txt >out-diff-tree-compacted2 &&
+	compare_diff spaces-compacted-expect out-diff-tree-compacted2
+'
+
+test_expect_success 'diff-tree: --no-indent-heuristic overrides config' '
+	git -c diff.indentHeuristic=true diff-tree --no-indent-heuristic -p old new -- spaces.txt >out-diff-tree &&
+	compare_diff spaces-expect out-diff-tree
+'
+
+test_expect_success 'diff-index: nice spaces with --indent-heuristic' '
+	git checkout -B diff-index &&
+	git reset --soft HEAD~ &&
+	git diff-index --indent-heuristic -p old -- spaces.txt >out-diff-index-compacted &&
+	compare_diff spaces-compacted-expect out-diff-index-compacted &&
+	git checkout -f master
+'
+
+test_expect_success 'diff-index: nice spaces with diff.indentHeuristic' '
+	git checkout -B diff-index &&
+	git reset --soft HEAD~ &&
+	git -c diff.indentHeuristic=true diff-index -p old -- spaces.txt >out-diff-index-compacted2 &&
+	compare_diff spaces-compacted-expect out-diff-index-compacted2 &&
+	git checkout -f master
+'
+
+test_expect_success 'diff-index: --no-indent-heuristic overrides config' '
+	git checkout -B diff-index &&
+	git reset --soft HEAD~ &&
+	git -c diff.indentHeuristic=true diff-index --no-indent-heuristic -p old -- spaces.txt >out-diff-index &&
+	compare_diff spaces-expect out-diff-index &&
+	git checkout -f master
+'
+
+test_expect_success 'diff-files: nice spaces with diff.indentHeuristic' '
+	git checkout -B diff-files &&
+	git reset HEAD~ &&
+	git -c diff.indentHeuristic=true diff-files -p spaces.txt >out-diff-files-raw &&
+	grep -v index out-diff-files-raw >out-diff-files-compacted &&
+	compare_diff spaces-compacted-expect out-diff-files-compacted &&
+	git checkout -f master
+'
+
+test_expect_success 'diff-files: nice spaces with diff.indentHeuristic' '
+	git checkout -B diff-files &&
+	git reset HEAD~ &&
+	git -c diff.indentHeuristic=true diff-files -p spaces.txt >out-diff-files-raw2 &&
+	grep -v index out-diff-files-raw2 >out-diff-files-compacted2 &&
+	compare_diff spaces-compacted-expect out-diff-files-compacted2 &&
+	git checkout -f master
+'
+
+test_expect_success 'diff-files: --no-indent-heuristic overrides config' '
+	git checkout -B diff-files &&
+	git reset HEAD~ &&
+	git -c diff.indentHeuristic=true diff-files --no-indent-heuristic -p spaces.txt >out-diff-files-raw3 &&
+	grep -v index out-diff-files-raw3 >out-diff-files &&
+	compare_diff spaces-expect out-diff-files &&
+	git checkout -f master
+'
+
 test_done
-- 
2.13.0.rc1.15.gf67d331ad

