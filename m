Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062AE1F78F
	for <e@80x24.org>; Mon,  1 May 2017 22:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbdEAWNy (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 18:13:54 -0400
Received: from [192.252.130.194] ([192.252.130.194]:18354 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751005AbdEAWNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 18:13:47 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 252C261872;
        Mon,  1 May 2017 18:13:45 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     Git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/4] diff: enable indent heuristic by default
Date:   Mon,  1 May 2017 18:13:44 -0400
Message-Id: <20170501221345.4025-4-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.0.rc1.15.gf67d331ad
In-Reply-To: <20170501221345.4025-1-marcnarc@xiplink.com>
References: <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net>
 <20170501221345.4025-1-marcnarc@xiplink.com>
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

Tested the sed "2a" command's escaping in both Ubuntu 17.04 and FreeBSD 10.3.
Threw in a little indenting so that it isn't too ugly.

 diff.c                           | 2 +-
 t/t4051-diff-function-context.sh | 3 ++-
 t/t4061-diff-indent.sh           | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index da96577ea..2c47ccb4a 100644
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
index 13d3dc96a..56d7d7760 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -153,7 +153,7 @@ test_expect_success 'prepare' '
 '
 
 test_expect_success 'diff: ugly spaces' '
-	git diff old new -- spaces.txt >out &&
+	git diff --no-indent-heuristic old new -- spaces.txt >out &&
 	compare_diff spaces-expect out
 '
 
@@ -183,7 +183,7 @@ test_expect_success 'diff: --indent-heuristic with --histogram' '
 '
 
 test_expect_success 'diff: ugly functions' '
-	git diff old new -- functions.c >out &&
+	git diff --no-indent-heuristic old new -- functions.c >out &&
 	compare_diff functions-expect out
 '
 
@@ -193,7 +193,7 @@ test_expect_success 'diff: nice functions with --indent-heuristic' '
 '
 
 test_expect_success 'blame: ugly spaces' '
-	git blame old..new -- spaces.txt >out-blame &&
+	git blame --no-indent-heuristic old..new -- spaces.txt >out-blame &&
 	compare_blame spaces-expect out-blame
 '
 
-- 
2.13.0.rc1.15.gf67d331ad

