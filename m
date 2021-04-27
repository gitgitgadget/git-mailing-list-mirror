Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC3C43462
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773F7613F3
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbhD0VTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:31 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:41518 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239050AbhD0VTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:16 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 9E6D680594;
        Tue, 27 Apr 2021 17:18:32 -0400 (EDT)
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
Subject: [PATCH v3 15/30] subtree: use `git merge-base --is-ancestor`
Date:   Tue, 27 Apr 2021 15:17:33 -0600
Message-Id: <20210427211748.2607474-16-lukeshu@lukeshu.com>
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

Instead of writing a slow `rev_is_descendant_of_branch $a $b` function
in shell, just use the fast `git merge-base --is-ancestor $b $a`.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 4503564f7e..70e16b807b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -280,20 +280,6 @@ rev_exists () {
 	fi
 }
 
-rev_is_descendant_of_branch () {
-	newrev="$1"
-	branch="$2"
-	branch_hash=$(git rev-parse "$branch")
-	match=$(git rev-list -1 "$branch_hash" "^$newrev")
-
-	if test -z "$match"
-	then
-		return 0
-	else
-		return 1
-	fi
-}
-
 # if a commit doesn't have a parent, this might not work.  But we only want
 # to remove the parent from the rev-list, and since it doesn't exist, it won't
 # be there anyway, so do nothing in that case.
@@ -811,7 +797,7 @@ cmd_split () {
 	then
 		if rev_exists "refs/heads/$branch"
 		then
-			if ! rev_is_descendant_of_branch "$latest_new" "$branch"
+			if ! git merge-base --is-ancestor "$branch" "$latest_new"
 			then
 				die "Branch '$branch' is not an ancestor of commit '$latest_new'."
 			fi
-- 
2.31.1

