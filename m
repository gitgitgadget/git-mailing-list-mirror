Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57450C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BB361075
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbhDWTnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbhDWTnX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:23 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F333C06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:42:46 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id BCBB780590;
        Fri, 23 Apr 2021 15:42:45 -0400 (EDT)
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
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 05/30] subtree: t7900: comment subtree_test_create_repo
Date:   Fri, 23 Apr 2021 13:42:05 -0600
Message-Id: <20210423194230.1388945-6-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
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

And while at it, go ahead and touch up the function to avoid a pointless
subshell.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/t/t7900-subtree.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 74516513cd..827bd3fcd8 100755
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
-- 
2.31.1

