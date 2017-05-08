Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC751FC44
	for <e@80x24.org>; Mon,  8 May 2017 16:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbdEHQDs (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 12:03:48 -0400
Received: from [192.252.130.194] ([192.252.130.194]:7777 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751342AbdEHQDk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 12:03:40 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id E272761825;
        Mon,  8 May 2017 12:03:39 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/4] diff: enable indent heuristic by default
Date:   Mon,  8 May 2017 12:03:38 -0400
Message-Id: <20170508160339.4551-4-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.0.rc1.15.gf67d331ad
In-Reply-To: <20170508160339.4551-1-marcnarc@xiplink.com>
References: <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com>
 <20170508160339.4551-1-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

The feature was included in v2.11 (released 2016-11-29) and we got no
negative feedback. Quite the opposite, all feedback we got was positive.

Turn it on by default. Users who dislike the feature can turn it off
by setting diff.indentHeuristic (which also configures plumbing commands,
see prior patches).

The change to t/t4051-diff-function-context.sh is needed because the
heuristic shifts the changed hunk in the patch.  To get the same result
regardless of the heuristic configuration, we modify the test file
differently:  We insert a completely new line after line 2, instead of
simply duplicating it.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

 diff.c                           |   2 +-
 t/t4051-diff-function-context.sh |   3 +-
 t/t4061-diff-indent.sh           | 140 +++++++++++++++++++++++++++++++--------
 3 files changed, 116 insertions(+), 29 deletions(-)

diff --git a/diff.c b/diff.c
index b6e3ffe92..a24452051 100644
--- a/diff.c
+++ b/diff.c
@@ -27,7 +27,7 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_indent_heuristic; /* experimental */
+static int diff_indent_heuristic = 1;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 6154acb45..3e6b485ec 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -72,7 +72,8 @@ test_expect_success 'setup' '
 
 	# overlap function context of 1st change and -u context of 2nd change
 	grep -v "delete me from hello" <"$dir/hello.c" >file.c &&
-	sed 2p <"$dir/dummy.c" >>file.c &&
+	sed "2a\\
+	     extra line" <"$dir/dummy.c" >>file.c &&
 	commit_and_tag changed_hello_dummy file.c &&
 
 	git checkout initial &&
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 13d3dc96a..2affd7a10 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -152,26 +152,28 @@ test_expect_success 'prepare' '
 	EOF
 '
 
+# --- diff tests ----------------------------------------------------------
+
 test_expect_success 'diff: ugly spaces' '
-	git diff old new -- spaces.txt >out &&
+	git diff --no-indent-heuristic old new -- spaces.txt >out &&
 	compare_diff spaces-expect out
 '
 
+test_expect_success 'diff: --no-indent-heuristic overrides config' '
+	git -c diff.indentHeuristic=true diff --no-indent-heuristic old new -- spaces.txt >out2 &&
+	compare_diff spaces-expect out2
+'
+
 test_expect_success 'diff: nice spaces with --indent-heuristic' '
-	git diff --indent-heuristic old new -- spaces.txt >out-compacted &&
+	git -c diff.indentHeuristic=false diff --indent-heuristic old new -- spaces.txt >out-compacted &&
 	compare_diff spaces-compacted-expect out-compacted
 '
 
-test_expect_success 'diff: nice spaces with diff.indentHeuristic' '
+test_expect_success 'diff: nice spaces with diff.indentHeuristic=true' '
 	git -c diff.indentHeuristic=true diff old new -- spaces.txt >out-compacted2 &&
 	compare_diff spaces-compacted-expect out-compacted2
 '
 
-test_expect_success 'diff: --no-indent-heuristic overrides config' '
-	git -c diff.indentHeuristic=true diff --no-indent-heuristic old new -- spaces.txt >out2 &&
-	compare_diff spaces-expect out2
-'
-
 test_expect_success 'diff: --indent-heuristic with --patience' '
 	git diff --indent-heuristic --patience old new -- spaces.txt >out-compacted3 &&
 	compare_diff spaces-compacted-expect out-compacted3
@@ -183,7 +185,7 @@ test_expect_success 'diff: --indent-heuristic with --histogram' '
 '
 
 test_expect_success 'diff: ugly functions' '
-	git diff old new -- functions.c >out &&
+	git diff --no-indent-heuristic old new -- functions.c >out &&
 	compare_diff functions-expect out
 '
 
@@ -192,42 +194,73 @@ test_expect_success 'diff: nice functions with --indent-heuristic' '
 	compare_diff functions-compacted-expect out-compacted
 '
 
-test_expect_success 'blame: ugly spaces' '
-	git blame old..new -- spaces.txt >out-blame &&
-	compare_blame spaces-expect out-blame
-'
+# --- blame tests ---------------------------------------------------------
 
 test_expect_success 'blame: nice spaces with --indent-heuristic' '
 	git blame --indent-heuristic old..new -- spaces.txt >out-blame-compacted &&
 	compare_blame spaces-compacted-expect out-blame-compacted
 '
 
-test_expect_success 'blame: nice spaces with diff.indentHeuristic' '
+test_expect_success 'blame: nice spaces with diff.indentHeuristic=true' '
 	git -c diff.indentHeuristic=true blame old..new -- spaces.txt >out-blame-compacted2 &&
 	compare_blame spaces-compacted-expect out-blame-compacted2
 '
 
+test_expect_success 'blame: ugly spaces with --no-indent-heuristic' '
+	git blame --no-indent-heuristic old..new -- spaces.txt >out-blame &&
+	compare_blame spaces-expect out-blame
+'
+
+test_expect_success 'blame: ugly spaces with diff.indentHeuristic=false' '
+	git -c diff.indentHeuristic=false blame old..new -- spaces.txt >out-blame2 &&
+	compare_blame spaces-expect out-blame2
+'
+
 test_expect_success 'blame: --no-indent-heuristic overrides config' '
-	git -c diff.indentHeuristic=true blame --no-indent-heuristic old..new -- spaces.txt >out-blame2 &&
+	git -c diff.indentHeuristic=true blame --no-indent-heuristic old..new -- spaces.txt >out-blame3 &&
 	git blame old..new -- spaces.txt >out-blame &&
-	compare_blame spaces-expect out-blame2
+	compare_blame spaces-expect out-blame3
 '
 
+test_expect_success 'blame: --indent-heuristic overrides config' '
+	git -c diff.indentHeuristic=false blame --indent-heuristic old..new -- spaces.txt >out-blame-compacted3 &&
+	compare_blame spaces-compacted-expect out-blame-compacted2
+'
+
+# --- diff-tree tests -----------------------------------------------------
+
 test_expect_success 'diff-tree: nice spaces with --indent-heuristic' '
 	git diff-tree --indent-heuristic -p old new -- spaces.txt >out-diff-tree-compacted &&
 	compare_diff spaces-compacted-expect out-diff-tree-compacted
 '
 
-test_expect_success 'diff-tree: nice spaces with diff.indentHeuristic' '
+test_expect_success 'diff-tree: nice spaces with diff.indentHeuristic=true' '
 	git -c diff.indentHeuristic=true diff-tree -p old new -- spaces.txt >out-diff-tree-compacted2 &&
 	compare_diff spaces-compacted-expect out-diff-tree-compacted2
 '
 
-test_expect_success 'diff-tree: --no-indent-heuristic overrides config' '
-	git -c diff.indentHeuristic=true diff-tree --no-indent-heuristic -p old new -- spaces.txt >out-diff-tree &&
+test_expect_success 'diff-tree: ugly spaces with --no-indent-heuristic' '
+	git diff-tree --no-indent-heuristic -p old new -- spaces.txt >out-diff-tree &&
 	compare_diff spaces-expect out-diff-tree
 '
 
+test_expect_success 'diff-tree: ugly spaces with diff.indentHeuristic=false' '
+	git -c diff.indentHeuristic=false diff-tree -p old new -- spaces.txt >out-diff-tree2 &&
+	compare_diff spaces-expect out-diff-tree2
+'
+
+test_expect_success 'diff-tree: --indent-heuristic overrides config' '
+	git -c diff.indentHeuristic=false diff-tree --indent-heuristic -p old new -- spaces.txt >out-diff-tree-compacted3 &&
+	compare_diff spaces-compacted-expect out-diff-tree-compacted3
+'
+
+test_expect_success 'diff-tree: --no-indent-heuristic overrides config' '
+	git -c diff.indentHeuristic=true diff-tree --no-indent-heuristic -p old new -- spaces.txt >out-diff-tree3 &&
+	compare_diff spaces-expect out-diff-tree3
+'
+
+# --- diff-index tests ----------------------------------------------------
+
 test_expect_success 'diff-index: nice spaces with --indent-heuristic' '
 	git checkout -B diff-index &&
 	git reset --soft HEAD~ &&
@@ -236,7 +269,7 @@ test_expect_success 'diff-index: nice spaces with --indent-heuristic' '
 	git checkout -f master
 '
 
-test_expect_success 'diff-index: nice spaces with diff.indentHeuristic' '
+test_expect_success 'diff-index: nice spaces with diff.indentHeuristic=true' '
 	git checkout -B diff-index &&
 	git reset --soft HEAD~ &&
 	git -c diff.indentHeuristic=true diff-index -p old -- spaces.txt >out-diff-index-compacted2 &&
@@ -244,24 +277,50 @@ test_expect_success 'diff-index: nice spaces with diff.indentHeuristic' '
 	git checkout -f master
 '
 
-test_expect_success 'diff-index: --no-indent-heuristic overrides config' '
+test_expect_success 'diff-index: ugly spaces with --no-indent-heuristic' '
 	git checkout -B diff-index &&
 	git reset --soft HEAD~ &&
-	git -c diff.indentHeuristic=true diff-index --no-indent-heuristic -p old -- spaces.txt >out-diff-index &&
+	git diff-index --no-indent-heuristic -p old -- spaces.txt >out-diff-index &&
 	compare_diff spaces-expect out-diff-index &&
 	git checkout -f master
 '
 
-test_expect_success 'diff-files: nice spaces with diff.indentHeuristic' '
+test_expect_success 'diff-index: ugly spaces with diff.indentHeuristic=false' '
+	git checkout -B diff-index &&
+	git reset --soft HEAD~ &&
+	git -c diff.indentHeuristic=false diff-index -p old -- spaces.txt >out-diff-index2 &&
+	compare_diff spaces-expect out-diff-index2 &&
+	git checkout -f master
+'
+
+test_expect_success 'diff-index: --indent-heuristic overrides config' '
+	git checkout -B diff-index &&
+	git reset --soft HEAD~ &&
+	git -c diff.indentHeuristic=false diff-index --indent-heuristic -p old -- spaces.txt >out-diff-index-compacted3 &&
+	compare_diff spaces-compacted-expect out-diff-index-compacted3 &&
+	git checkout -f master
+'
+
+test_expect_success 'diff-index: --no-indent-heuristic overrides config' '
+	git checkout -B diff-index &&
+	git reset --soft HEAD~ &&
+	git -c diff.indentHeuristic=true diff-index --no-indent-heuristic -p old -- spaces.txt >out-diff-index3 &&
+	compare_diff spaces-expect out-diff-index3 &&
+	git checkout -f master
+'
+
+# --- diff-files tests ----------------------------------------------------
+
+test_expect_success 'diff-files: nice spaces with --indent-heuristic' '
 	git checkout -B diff-files &&
 	git reset HEAD~ &&
-	git -c diff.indentHeuristic=true diff-files -p spaces.txt >out-diff-files-raw &&
+	git diff-files --indent-heuristic -p spaces.txt >out-diff-files-raw &&
 	grep -v index out-diff-files-raw >out-diff-files-compacted &&
 	compare_diff spaces-compacted-expect out-diff-files-compacted &&
 	git checkout -f master
 '
 
-test_expect_success 'diff-files: nice spaces with diff.indentHeuristic' '
+test_expect_success 'diff-files: nice spaces with diff.indentHeuristic=true' '
 	git checkout -B diff-files &&
 	git reset HEAD~ &&
 	git -c diff.indentHeuristic=true diff-files -p spaces.txt >out-diff-files-raw2 &&
@@ -270,11 +329,38 @@ test_expect_success 'diff-files: nice spaces with diff.indentHeuristic' '
 	git checkout -f master
 '
 
+test_expect_success 'diff-files: ugly spaces with --no-indent-heuristic' '
+	git checkout -B diff-files &&
+	git reset HEAD~ &&
+	git diff-files --no-indent-heuristic -p spaces.txt >out-diff-files-raw &&
+	grep -v index out-diff-files-raw >out-diff-files &&
+	compare_diff spaces-expect out-diff-files &&
+	git checkout -f master
+'
+
+test_expect_success 'diff-files: ugly spaces with diff.indentHeuristic=false' '
+	git checkout -B diff-files &&
+	git reset HEAD~ &&
+	git -c diff.indentHeuristic=false diff-files -p spaces.txt >out-diff-files-raw2 &&
+	grep -v index out-diff-files-raw2 >out-diff-files &&
+	compare_diff spaces-expect out-diff-files &&
+	git checkout -f master
+'
+
+test_expect_success 'diff-files: --indent-heuristic overrides config' '
+	git checkout -B diff-files &&
+	git reset HEAD~ &&
+	git -c diff.indentHeuristic=false diff-files --indent-heuristic -p spaces.txt >out-diff-files-raw3 &&
+	grep -v index out-diff-files-raw3 >out-diff-files-compacted &&
+	compare_diff spaces-compacted-expect out-diff-files-compacted &&
+	git checkout -f master
+'
+
 test_expect_success 'diff-files: --no-indent-heuristic overrides config' '
 	git checkout -B diff-files &&
 	git reset HEAD~ &&
-	git -c diff.indentHeuristic=true diff-files --no-indent-heuristic -p spaces.txt >out-diff-files-raw3 &&
-	grep -v index out-diff-files-raw3 >out-diff-files &&
+	git -c diff.indentHeuristic=true diff-files --no-indent-heuristic -p spaces.txt >out-diff-files-raw4 &&
+	grep -v index out-diff-files-raw4 >out-diff-files &&
 	compare_diff spaces-expect out-diff-files &&
 	git checkout -f master
 '
-- 
2.13.0.rc1.15.gf67d331ad

