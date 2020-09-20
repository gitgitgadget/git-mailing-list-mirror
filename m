Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352F9C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 23:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E908320C09
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 23:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgITXWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 19:22:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35284 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgITXWm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Sep 2020 19:22:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BB44E61FE6;
        Sun, 20 Sep 2020 23:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600644161;
        bh=6XXWfnJkzP+rZYezUWZjelojZzEadDGsdO9dUWpeU6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=j4PvrXRvkxQ87qLZvQuvT6TsOFf359Z9qu8lpbMMUCXFXEcLFQ30OyI42agW92vDd
         aNspO7czUJF5CQorzg2/bGf0ZF8tkpv+/A4LdxK7n11JPDuDUvuhtv0l80gL4IwYZX
         x222xMtlBtprn3BFINWov1CmFmC0NeGEVgQZmncf7VE2Pamw3y/3p/tpBkDo9xqR6o
         sE4n3DC1qIyXV4ghIPd3z7mXPK6DRh7QOPQJm5oXpr9tbk5YOiqSldjF6erKMUzycO
         bfNFyycRwYYT/c1WxhACMyfABugwgYKODupigy6JfAb+PE9u7gYBeVLq9jbnD/jPzb
         5FPB6P6FdsAF1ar5EdbgxlbjEMMihR0Mg15AbdjUcvjUqAD46Ybpm0hEfAallBkYU6
         xjTZtjzw+gXdmYw4C+b/OrIucJ/pq9d1ZUOnOB0w7cichwitI7+sfxmaDe2Y0n/FUL
         tMiIR/Kb6N9H68SbICibkYe5viiXwKxc6NLk6+DJZ5YfumI6NXT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 2/3] docs: explain why reverts are not always applied on merge
Date:   Sun, 20 Sep 2020 23:22:30 +0000
Message-Id: <20200920232231.1300394-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200920232231.1300394-1-sandals@crustytoothpaste.net>
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
 <20200920232231.1300394-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A common scenario is for a user to apply a change to one branch and
cherry-pick it into another, then later revert it in the first branch.
This results in the change being present when the two branches are
merged, which is confusing to many users.

We already have documentation for how this works in `git merge`, but it
is clear from the frequency with which this is asked that it's hard to
grasp.  We also don't explain to users that they are better off doing a
rebase in this case, which will do what they intended.  Let's add an
entry to the FAQ telling users what's happening and advising them to use
rebase here.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 51d305d58f..176b097cf7 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -273,6 +273,27 @@ original merge base.
 As a consequence, if you want to merge two long-lived branches repeatedly, it's
 best to always use a regular merge commit.
 
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
+revert.  Note that rebases rewrite history, so you should avoid rebasing
+published branches unless you're sure you're comfortable with that.  See the
+NOTES section in linkgit:git-rebase[1] for more details.
+
 Hooks
 -----
 
