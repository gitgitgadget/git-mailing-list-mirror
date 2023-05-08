Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8841C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjEHTBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHTBT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:01:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1A619E
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:01:13 -0700 (PDT)
Received: (qmail 13876 invoked by uid 109); 8 May 2023 19:01:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 May 2023 19:01:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3621 invoked by uid 111); 8 May 2023 19:01:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 May 2023 15:01:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 May 2023 15:01:12 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] t7001: avoid git on upstream of pipe
Message-ID: <20230508190112.GA2366490@coredump.intra.peff.net>
References: <20230508185953.GA2108869@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508185953.GA2108869@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We generally avoid git on the left-hand side of a pipe, because it loses
the exit code of the command (and thus we'd miss things like segfaults
or unexpected failures). In the cases in t7001, we wouldn't expect
failures (they are just inspecting the repository state, and are not the
main point of the test), but it doesn't hurt to be careful.

In all but one case here we're piping "ls-files --stage" to cut off the
pathname (since we compare entries before and after moving). Let's pull
that into a helper function to avoid repeating the slightly awkward
replacement.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7001-mv.sh | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index d72cef8826..ea70419928 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -4,6 +4,11 @@ test_description='git mv in subdirs'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
+index_at_path () {
+	entry=$(git ls-files --stage "$@") &&
+	echo "$entry" | cut -f 1
+}
+
 test_expect_success 'mv -f refreshes updated index entry' '
 	echo test >bar &&
 	git add bar &&
@@ -187,7 +192,8 @@ test_expect_success "Michael Cassar's test case" '
 	git mv papers/unsorted/Thesis.pdf papers/all-papers/moo-blah.pdf &&
 
 	T=$(git write-tree) &&
-	git ls-tree -r $T | verbose grep partA/outline.txt
+	git ls-tree -r $T >out &&
+	verbose grep partA/outline.txt out
 '
 
 rm -fr papers partA path?
@@ -260,12 +266,12 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 	git init &&
 	echo 1 >dirty &&
 	git add dirty &&
-	entry="$(git ls-files --stage dirty | cut -f 1)" &&
+	entry="$(index_at_path dirty)" &&
 	git mv dirty dirty2 &&
-	test "$entry" = "$(git ls-files --stage dirty2 | cut -f 1)" &&
+	test "$entry" = "$(index_at_path dirty2)" &&
 	echo 2 >dirty2 &&
 	git mv dirty2 dirty &&
-	test "$entry" = "$(git ls-files --stage dirty | cut -f 1)"
+	test "$entry" = "$(index_at_path dirty)"
 '
 
 rm -f dirty dirty2
@@ -342,7 +348,7 @@ test_expect_success 'git mv cannot move a submodule in a file' '
 '
 
 test_expect_success 'git mv moves a submodule with a .git directory and no .gitmodules' '
-	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	entry="$(index_at_path sub)" &&
 	git rm .gitmodules &&
 	(
 		cd sub &&
@@ -353,7 +359,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	mkdir mod &&
 	git mv sub mod/sub &&
 	test_path_is_missing sub &&
-	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
+	test "$entry" = "$(index_at_path mod/sub)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -363,7 +369,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
-	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	entry="$(index_at_path sub)" &&
 	(
 		cd sub &&
 		rm -f .git &&
@@ -373,7 +379,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	mkdir mod &&
 	git mv sub mod/sub &&
 	test_path_is_missing sub &&
-	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
+	test "$entry" = "$(index_at_path mod/sub)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
@@ -386,11 +392,11 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
-	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	entry="$(index_at_path sub)" &&
 	mkdir mod &&
 	git -C mod mv ../sub/ . &&
 	test_path_is_missing sub &&
-	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
+	test "$entry" = "$(index_at_path mod/sub)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
@@ -404,12 +410,12 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	git reset --hard &&
 	git submodule update &&
 	git rm .gitmodules &&
-	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	entry="$(index_at_path sub)" &&
 	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
 	test_path_is_missing sub &&
-	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
+	test "$entry" = "$(index_at_path mod/sub)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -420,7 +426,7 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	git reset --hard &&
 	git submodule update &&
 	git config -f .gitmodules foo.bar true &&
-	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	entry="$(index_at_path sub)" &&
 	mkdir mod &&
 	test_must_fail git mv sub mod/sub 2>actual.err &&
 	test_file_not_empty actual.err &&
@@ -430,7 +436,7 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
 	test_path_is_missing sub &&
-	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
+	test "$entry" = "$(index_at_path mod/sub)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -442,13 +448,13 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	git submodule update &&
 	git config -f .gitmodules --remove-section submodule.sub &&
 	git add .gitmodules &&
-	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	entry="$(index_at_path sub)" &&
 	echo "warning: Could not find section in .gitmodules where path=sub" >expect.err &&
 	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	test_cmp expect.err actual.err &&
 	test_path_is_missing sub &&
-	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
+	test "$entry" = "$(index_at_path mod/sub)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
-- 
2.40.1.802.gdef2a8734a

