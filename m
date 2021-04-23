Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67DEC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D7D6128B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbhDWTn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbhDWTn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:26 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF33C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:42:48 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 5F23C80594;
        Fri, 23 Apr 2021 15:42:48 -0400 (EDT)
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
Subject: [PATCH 08/30] subtree: t7900: fix 'verify one file change per commit'
Date:   Fri, 23 Apr 2021 13:42:08 -0600
Message-Id: <20210423194230.1388945-9-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

As far as I can tell, this test isn't actually testing anything, because
someone forgot to tack on `--name-only` to `git log`.  This seems to
have been the case since the test was first written, back in fa16ab36ad
("test.sh: make sure no commit changes more than one file at a time.",
2009-04-26), unless `git log` used to do that by default and didn't need
the flag back then?

Convincing myself that it's not actually testing anything was tricky,
the code is a little hard to reason about.  It can be made a lot simpler
if instead of trying to parse all of the info from a single `git log`,
we're OK calling `git log` from inside of a loop.  And it's my opinion
that tests are not the place for clever optimized code.

So, fix and simplify the test, so that it's actually testing something
and is simpler to reason about.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/t/t7900-subtree.sh | 41 +++++-------------------------
 1 file changed, 6 insertions(+), 35 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 96acd4f8be..70be18246b 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -22,29 +22,6 @@ subtree_test_create_repo () {
 	git -C "$1" config log.date relative
 }
 
-# Make sure no patch changes more than one file.
-# The original set of commits changed only one file each.
-# A multi-file change would imply that we pruned commits
-# too aggressively.
-join_commits () {
-	commit=
-	all=
-	while read x y; do
-		if [ -z "$x" ]; then
-			continue
-		elif [ "$x" = "commit:" ]; then
-			if [ -n "$commit" ]; then
-				echo "$commit $all"
-				all=
-			fi
-			commit="$y"
-		else
-			all="$all $y"
-		fi
-	done
-	echo "$commit $all"
-}
-
 test_create_commit () (
 	repo=$1 &&
 	commit=$2 &&
@@ -865,18 +842,12 @@ test_expect_success 'verify one file change per commit' '
 		cd "$test_count" &&
 		git subtree split --prefix="sub dir2" --branch subproj2-br &&
 
-		x= &&
-		git log --pretty=format:"commit: %H" | join_commits |
-		(
-			while read commit a b; do
-				test_debug "echo Verifying commit $commit"
-				test_debug "echo a: $a"
-				test_debug "echo b: $b"
-				test "$b" = ""
-				x=1
-			done
-			test "$x" = 1
-		)
+		git log --format="%H" > commit-list &&
+		while read commit
+		do
+			git log -n1 --format="" --name-only "$commit" >file-list &&
+			test_line_count -le 1 file-list || return 1
+		done <commit-list
 	)
 '
 
-- 
2.31.1

