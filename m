Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF7A20D0A
	for <e@80x24.org>; Wed, 31 May 2017 10:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbdEaKme (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 06:42:34 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:13638 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdEaKmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 06:42:32 -0400
Received: from lindisfarne.localdomain ([92.22.34.189])
        by smtp.talktalk.net with SMTP
        id G154d4KIzcpskG15Bd2uBa; Wed, 31 May 2017 11:42:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1496227350; bh=hVHrU/erK3UFuNIUoNwz25ritwupatVgWP7mGMDi+ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=GqE7KFydI1ryTYYScu1/sYrLwIsCmPsJmq3/urXs2LEy0qyRZJkDrfiqY6TSD4U1M
         T4OL8tP7G+zeq0hYUy6m3RnV5LmBrkEJ5Obn3zODPyPiys9fWJJRxtnFO0JB0vHbhx
         YLVeIBChU7EftsbWtpvwWBNyKuQjZdAyxZcYf2o8=
X-Originating-IP: [92.22.34.189]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=vjpdqwq13QoU7KiiDtdC/A==:117
 a=vjpdqwq13QoU7KiiDtdC/A==:17 a=evINK-nbAAAA:8 a=DBGb29j47n2B0gFy0FgA:9
 a=2sTboKvTglnB5s9h:21 a=vDM_Rg1MDXyVM9gC:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/3] rebase -i: Add test for reflog message
Date:   Wed, 31 May 2017 11:42:11 +0100
Message-Id: <20170531104213.16944-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170531104213.16944-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJeT83uTGekRZtRUV66LuzvB0CMocdrS+6Y8CMfOZUffUAj5OuwjkkxJ1AuTI8EKqCk2aUfWBdEGuBT+LszMIqGTr3e1dlEmiJJXzxIKaIqbGgWeB/cA
 sGhCgSZxn6SG9Z1wjG/k3cILkXkG9gUSZkm9N7LCZMF/p1pQNFpUW3/4RgF0n2i5sVY3HW+K1PiAsoLf8u+om69m1oWCC6YJWZc2w5NeI3CeJVu3GeV1apWu
 QelkWLiaB65JCbxH7i9uZi+G0Ih9jZYqZuG16fuXdJtCAliF9iKE/oaaIdDGvmSV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check that the reflog message written to the branch reflog when the
rebase is completed is correct. This checks for regressions for the
fix in commit
4ab867b8fc rebase -i: fix reflog message

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3404-rebase-interactive.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5bd0275930b715c25507fc9744c8946e7f73900b..37821d245433f757fa13f0a3e27da0312bebb7db 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -169,6 +169,13 @@ test_expect_success 'reflog for the branch shows state before rebase' '
 	test $(git rev-parse branch1@{1}) = $(git rev-parse original-branch1)
 '
 
+test_expect_success 'reflog for the branch shows correct finish message' '
+	printf "rebase -i (finish): refs/heads/branch1 onto %s\n" \
+		"$(git rev-parse branch2)" >expected &&
+	git log -g --pretty=%gs -1 refs/heads/branch1 >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'exchange two commits' '
 	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
-- 
2.13.0

