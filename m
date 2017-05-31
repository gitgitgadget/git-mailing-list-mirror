Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526221FD09
	for <e@80x24.org>; Wed, 31 May 2017 23:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbdEaXfb (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 19:35:31 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:47504
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751349AbdEaXf3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 May 2017 19:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1496273713;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=NUpk4hA1OHNy25GQkT1dfvKF3AGZ9iA6UxsRxm6m82w=;
        b=OB9j2Y0RlxqQ+gM6s+sp3HzeDD2odO2FlKBG+dShcVp8Zk8v4a+FAf+xGfL1tsFW
        LTDREGAXbQBvmzFU3yx+f2u/Hd4ior6vqfCjaKQGEBd85b4pHFuBQ8XihKb+fpuu0uo
        YYIHYz6fIgeJWHn+yZ5GYpHF50R5EHb63B0xZx9s=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
References: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
Subject: [PATCH/RFC v2 1/6] branch: add tests for new copy branch feature
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 May 2017 23:35:12 +0000
X-SES-Outgoing: 2017.05.31-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds a few basic tests for getting any suggestions/feedback
about expected behavior for this new feature. Aim is to have an option -c
for copying a branch just like -m option for renaming a branch.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 t/t3200-branch.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fe62e7c775da6..2c95ed6ebf3c5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -341,6 +341,59 @@ test_expect_success 'config information was renamed, too' '
 	test_must_fail git config branch.s/s/dummy
 '
 
+test_expect_success 'git branch -c dumps usage' '
+	test_expect_code 128 git branch -c 2>err &&
+	test_i18ngrep "branch name required" err
+'
+
+git config branch.d.dummy Hello
+
+test_expect_success 'git branch -c d e should work' '
+	git branch -l d &&
+	git reflog exists refs/heads/d &&
+	git branch -c d e &&
+	git reflog exists refs/heads/d &&
+	git reflog exists refs/heads/e
+'
+
+test_expect_success 'config information was copied, too' '
+	test $(git config branch.e.dummy) = Hello &&
+	test $(git config branch.d.dummy) = Hello
+'
+
+git config branch.f/f.dummy Hello
+
+test_expect_success 'git branch -c f/f g/g should work' '
+	git branch -l f/f &&
+	git reflog exists refs/heads/f/f &&
+	git branch -c f/f g/g &&
+	git reflog exists refs/heads/f/f &&
+	git reflog exists refs/heads/g/g
+'
+
+test_expect_success 'config information was copied, too' '
+	test $(git config branch.f/f.dummy) = Hello &&
+	test $(git config branch.g/g.dummy) = Hello
+'
+
+test_expect_success 'git branch -c m2 m2 should work' '
+	git branch -l m2 &&
+	git reflog exists refs/heads/m2 &&
+	git branch -c m2 m2 &&
+	git reflog exists refs/heads/m2
+'
+
+test_expect_success 'git branch -c a a/a should fail' '
+	git branch -l a &&
+	git reflog exists refs/heads/a &&
+	test_must_fail git branch -c a a/a
+'
+
+test_expect_success 'git branch -c b/b b should fail' '
+	git branch -l b/b &&
+	test_must_fail git branch -c b/b b
+'
+
 test_expect_success 'deleting a symref' '
 	git branch target &&
 	git symbolic-ref refs/heads/symref refs/heads/target &&

--
https://github.com/git/git/pull/363
