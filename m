Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D81B1FAE2
	for <e@80x24.org>; Wed, 14 Mar 2018 11:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCNLLr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 07:11:47 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:16091 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeCNLLg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 07:11:36 -0400
Received: from lindisfarne.localdomain ([89.242.187.47])
        by smtp.talktalk.net with SMTP
        id w4JdeGnv5HCoww4JjeseBY; Wed, 14 Mar 2018 11:11:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521025895;
        bh=C+S1MvlQ7e9gJuw+XmsVE4Xipd/atQ6kXyz1oUvRqVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=np7+ZJDIRsZwzWCdK8MmIOHeDV31TT1p4YBeJdcRlWabv8KzFWSR2hQo0ocuPuKP8
         69qQ1uD9eTIDzuvFkZGfjWBwigSjQydXz3gpiDCQbyhub6NE9U3qNNtuQA0qKpjTAW
         87iSURqCttIhtsQT+v4b8IXBfkcyIcX2vcCmcFFM=
X-Originating-IP: [89.242.187.47]
X-Spam: 0
X-OAuthority: v=2.3 cv=SfXZiMZu c=1 sm=1 tr=0 a=xTMdeSjPtcrjTRwaJcecEQ==:117
 a=xTMdeSjPtcrjTRwaJcecEQ==:17 a=evINK-nbAAAA:8 a=QF6gQJHC3-umlHK4fNoA:9
 a=Ucl9CbKQXAmX0Ou1:21 a=Iq9wVlJON6C8ib91:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/2] rebase --root -k: fix when root commit is empty
Date:   Wed, 14 Mar 2018 11:11:27 +0000
Message-Id: <20180314111127.14217-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180314111127.14217-1-phillip.wood@talktalk.net>
References: <20180314111127.14217-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfMQstxS9hlDKOrJ4Yzx7E7AfPyrgaY5q6akfM7lM+dKy8SUo6lJt7Ne65O8PeVnCWANpLkec7AZchjq5aQFTkzmU22SxA07c/2Ln0SwLaEyc4AJ3M1sS
 g5REcJNod/YnOiXY3xrUehsBfatmMpJt+HSqaCmZhgVOtXwrwNtedjFrywvcZbeiGf3kjJAQZu94JqaDfbCHJhm/aWl7gXNQxfJGoEhlJN+27r3lVCoxxaec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the root commit was empty it was being pruned by the
--cherry-pick option passed to rev-parse. This is because when --onto
is omitted rebase creates an empty commit (which it later amends) for
the new root commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-rebase--interactive.sh | 7 ++++++-
 git-rebase.sh              | 1 +
 t/t3428-rebase-signoff.sh  | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4ea54fc1c4..3ad74fc57c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -894,7 +894,12 @@ then
 	revisions=$upstream...$orig_head
 	shortrevisions=$shortupstream..$shorthead
 else
-	revisions=$onto...$orig_head
+	if test -n "$squash_onto"
+	then
+		revisions=$orig_head
+	else
+		revisions=$onto...$orig_head
+	fi
 	shortrevisions=$shorthead
 fi
 if test t != "$preserve_merges"
diff --git a/git-rebase.sh b/git-rebase.sh
index 40301756be..30b8eaf489 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -61,6 +61,7 @@ $(gettext 'Resolve all conflicts manually, mark them as resolved with
 You can instead skip this commit: run "git rebase --skip".
 To abort and get back to the state before "git rebase", run "git rebase --abort".')
 "
+squash_onto=
 unset onto
 unset restrict_revision
 cmd=
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index 2ff7f534e3..90ca6636d5 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -59,7 +59,7 @@ test_expect_success 'rebase --exec --signoff adds a sign-off line' '
 	test_cmp expected-signed actual
 '
 
-test_expect_failure 'rebase --root --signoff adds a sign-off line' '
+test_expect_success 'rebase --root --signoff adds a sign-off line' '
 	git commit --amend -m "first" &&
 	git rebase --root --keep-empty --signoff &&
 	git cat-file commit HEAD^ | sed -e "1,/^\$/d" >actual &&
-- 
2.16.2

