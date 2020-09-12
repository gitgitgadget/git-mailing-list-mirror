Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F1CC43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 20:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C510621531
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 20:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgILUwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 16:52:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58476 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbgILUwN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Sep 2020 16:52:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 993A96088D;
        Sat, 12 Sep 2020 20:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599943901;
        bh=sUhIsFR1Lz2uRf9wmUDKEHdYIlXBrbDSM99R9FQLBVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=T4jCkMnXv0aQQKIY39t2hIC1cpmvo0AhVBu1lMgEpRvalwegGiW4GZxRRC702ur5h
         d+Z8ggIMt/B24JNW4JdFbEnBZymCUlHwBIlEnsLGqBSKxOrMUyLiqv3ddWgSQMxJ8p
         y4OQiPDLFFkAvM+PVvIBSJw2tfD7QQFhxbVJaee9yqLnN1TKO2xr0pU6MMS3VIa5Cw
         8exdpJEPzd4Z5aeDxEb2ddsWQguJ9B7iGxCQucDvgNn+6pUOokc7BIXaAaMEUERWJs
         PK5B77JfCwoBkm2ez2Ao0o6vZU3XPFcipUocIfQDXVjBrJ00Cnbv8VkVd2a9HGasa/
         JLkMKz3rrDnHA7Bww5FR/R2eAcuplhjglgiTs4YFU15FZp3NXtzUtFnL6a7+ZI9ryh
         HegE5evp06SfLv5yDIcXkzw21CRfG4DNxwODEoRya5Dh4CoT/Tw6h6PIIVBUJ0nwU2
         UQEIxzzQxeNU3ybPeRMlXZWajpwiTYGJwB0Ebl9P48lX5t70ZbW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH 2/3] docs: explain why reverts are not always applied on merge
Date:   Sat, 12 Sep 2020 20:48:23 +0000
Message-Id: <20200912204824.2824106-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A common scenario is for a user to apply a change to one branch and
cherry-pick it into another, then later revert it in the first branch.
This results in the change being present when the two branches are
merge, which is confusing to many users.

We already have documentation for how this works in `git merge`, but it
is clear from the frequency with which this is asked that it's hard to
grasp.  We also don't explain to users that they are better off doing a
rebase in this case, which will do what they intended.  Let's add an
entry to the FAQ telling users what's happening and advising them to use
rebase here.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 550f4e30d6..154f0cce54 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -274,6 +274,25 @@ original merge base.
 As a consequence, if you want to merge two long-running branches, it's best to
 always use a regular merge commit.
 
+[[merge-two-revert-one]]
+If I make a change on two branches but revert it on one, why does the merge of those branches include the change?::
+	By default, when Git does a merge, it uses a strategy called the recursive
+	strategy, which does a fancy three-way merge.  In such a case, when Git
+	performs the merge, it considers exactly three points: the two heads and a
+	third point, called the _merge base_, which is usually the common ancestor of
+	those commits.  Git does not consider the history or the individual commits
+	that have happened on those branches at all.
++
+As a result, if both sides have a change and one side has reverted that change,
+the result is to include the change.  This is because the code has changed on
+one side and there is no net change on the other, and in this scenario, Git
+adopts the change.
++
+If this is a problem for you, you can do a rebase instead, rebasing the branch
+with the revert onto the other branch.  A rebase in this scenario will revert
+the change, because a rebase applies each individual commit, including the
+revert.
+
 Hooks
 -----
 
