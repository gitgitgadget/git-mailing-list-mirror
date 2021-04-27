Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDA2C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDA6613B1
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbhD0VTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:22 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:41518 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239185AbhD0VTM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:12 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 8B7A480593;
        Tue, 27 Apr 2021 17:18:26 -0400 (EDT)
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
Subject: [PATCH v3 08/30] subtree: t7900: fix 'verify one file change per commit'
Date:   Tue, 27 Apr 2021 15:17:26 -0600
Message-Id: <20210427211748.2607474-9-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427211748.2607474-1-lukeshu@lukeshu.com>
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
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
 contrib/subtree/t/t7900-subtree.sh | 46 ++++--------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 421ed9f003..1c717fcb96 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -22,33 +22,6 @@ subtree_test_create_repo () {
 	git -C "$1" config log.date relative
 }
 
-# Make sure no patch changes more than one file.
-# The original set of commits changed only one file each.
-# A multi-file change would imply that we pruned commits
-# too aggressively.
-join_commits () {
-	commit=
-	all=
-	while read x y
-	do
-		if test -z "$x"
-		then
-			continue
-		elif test "$x" = "commit:"
-		then
-			if test -n "$commit"
-			then
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
@@ -869,19 +842,12 @@ test_expect_success 'verify one file change per commit' '
 		cd "$test_count" &&
 		git subtree split --prefix="sub dir2" --branch subproj2-br &&
 
-		x= &&
-		git log --pretty=format:"commit: %H" | join_commits |
-		(
-			while read commit a b
-			do
-				test_debug "echo Verifying commit $commit"
-				test_debug "echo a: $a"
-				test_debug "echo b: $b"
-				test "$b" = ""
-				x=1
-			done
-			test "$x" = 1
-		)
+		git log --format="%H" >commit-list &&
+		while read commit
+		do
+			git log -n1 --format="" --name-only "$commit" >file-list &&
+			test_line_count -le 1 file-list || return 1
+		done <commit-list
 	)
 '
 
-- 
2.31.1

