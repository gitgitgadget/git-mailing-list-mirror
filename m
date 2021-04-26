Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BCBC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AF261185
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhDZRst (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbhDZRsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:48:32 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8BBC061763
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:47:48 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 1DFBB8059A;
        Mon, 26 Apr 2021 13:47:48 -0400 (EDT)
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
Subject: [PATCH v2 14/30] subtree: drop support for git < 1.7
Date:   Mon, 26 Apr 2021 11:45:09 -0600
Message-Id: <20210426174525.3937858-15-lukeshu@lukeshu.com>
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

Suport for Git versions older than 1.7.0 (older than February 2010) was
nice to have when git-subtree lived out-of-tree.  But now that it lives
in git.git, it's not necessary to keep around.  While it's technically
in contrib, with the standard 'git' packages for common systems
(including Arch Linux and macOS) including git-subtree, it seems
vanishingly likely to me that people are separately installing
git-subtree from git.git alongside an older 'git' install (although it
also seems vanishingly likely that people are still using >11 year old
git installs).

Not that there's much reason to remove it either, it's not much code,
and none of my changes depend on a newer git (to my knowledge, anyway;
I'm not actually testing against older git).  I just figure it's an easy
piece of fat to trim, in the journey to making the whole thing easier to
hack on.

"Ignore space change" is probably helpful when viewing this diff.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - Include rationale in the the commit message.

 contrib/subtree/git-subtree.sh | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 9ca498f81c..4503564f7e 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -852,23 +852,12 @@ cmd_merge () {
 		rev="$new"
 	fi
 
-	version=$(git version)
-	if test "$version" \< "git version 1.7"
+	if test -n "$message"
 	then
-		if test -n "$message"
-		then
-			git merge -s subtree --message="$message" "$rev"
-		else
-			git merge -s subtree "$rev"
-		fi
+		git merge -Xsubtree="$prefix" \
+		    --message="$message" "$rev"
 	else
-		if test -n "$message"
-		then
-			git merge -Xsubtree="$prefix" \
-				--message="$message" "$rev"
-		else
-			git merge -Xsubtree="$prefix" $rev
-		fi
+		git merge -Xsubtree="$prefix" $rev
 	fi
 }
 
-- 
2.31.1

