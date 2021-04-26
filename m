Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6BFC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA02613B3
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhDZRs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:48:28 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:39098 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237560AbhDZRsX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:48:23 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 1130480594;
        Mon, 26 Apr 2021 13:47:40 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v2 05/30] subtree: t7900: comment subtree_test_create_repo
Date:   Mon, 26 Apr 2021 11:45:00 -0600
Message-Id: <20210426174525.3937858-6-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174525.3937858-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <20210426174525.3937858-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

It's unclear what the purpose of t7900-subtree.sh's
`subtree_test_create_repo` helper function is.  It wraps test-lib.sh's,
`test_create_repo` but follows that up by setting log.date=relative.  Why
does it set log.date=relative?

My first guess was that at one point the tests required that, but no
longer do, and that the function is now vestigial.  I even wrote a patch
to get rid of it and was moments away from `git send-email`ing it.

However, by chance when looking for something else in the history, I
discovered the true reason, from e7aac44ed2 (contrib/subtree: ignore
log.date configuration, 2015-07-21).  It's testing that setting
log.date=relative doesn't break `git subtree`, as at one point in the past
that did break `git subtree`.

So, add a comment about this, to avoid future such confusion.

And while at it, go ahead and (1) touch up the function to avoid a
pointless subshell and (2) update the one test that didn't use it.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - Also switch the few uses of vanilla test_create_repo over to
   subtree_test_create_repo.  In v1 this was erroneously included
   in a different commit.

 contrib/subtree/t/t7900-subtree.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 5e1390c287..cac08af7f7 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -13,12 +13,14 @@ TEST_DIRECTORY=$(pwd)/../../../t
 export TEST_DIRECTORY
 . "$TEST_DIRECTORY"/test-lib.sh
 
+# Use our own wrapper around test-lib.sh's test_create_repo, in order
+# to set log.date=relative.  `git subtree` parses the output of `git
+# log`, and so it must be careful to not be affected by settings that
+# change the `git log` output.  We test this by setting
+# log.date=relative for every repo in the tests.
 subtree_test_create_repo () {
 	test_create_repo "$1" &&
-	(
-		cd "$1" &&
-		git config log.date relative
-	)
+	git -C "$1" config log.date relative
 }
 
 create () {
@@ -241,8 +243,8 @@ test_expect_success 'merge the added subproj again, should do nothing' '
 '
 
 test_expect_success 'merge new subproj history into subdir/ with a slash appended to the argument of --prefix' '
-	test_create_repo "$test_count" &&
-	test_create_repo "$test_count/subproj" &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/subproj" &&
 	test_create_commit "$test_count" main1 &&
 	test_create_commit "$test_count/subproj" sub1 &&
 	(
-- 
2.31.1

