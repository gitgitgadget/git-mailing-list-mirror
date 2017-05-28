Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71421FD09
	for <e@80x24.org>; Sun, 28 May 2017 22:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbdE1W4z (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 18:56:55 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:47708
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750830AbdE1W4y (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 May 2017 18:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1496012212;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=xK+AbUuH16cx5Dyg18QFjDyGgdeYF5KxDL1wElxb1KE=;
        b=Y9USup231D3fp3AP8KSrh8sDIGR+INC5/DQoMgcxZUUocbKCO5Rfh4ueQMX2iznh
        ygrpYT0roLz9KLIxX6qJwWu/sQKCyW/myFA/pxDGQvxIEnxvIS3WW03iZJjTnAwEDRx
        9u9DIlGWVJkOIdE8xhnPZRuJBavAUW5nSLwPMdfM=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
Subject: [PATCH/RFC] branch: add tests for new copy branch feature
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 28 May 2017 22:56:52 +0000
X-SES-Outgoing: 2017.05.28-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New feature - copying a branch along with its config section.

Aim is to have an option -c for copying a branch just like -m option for
renaming a branch.

This commit adds a few basic tests for getting any suggestions/feedback
about expected behavior for this new feature.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 t/t3200-branch.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fe62e7c775da..2c95ed6ebf3c 100755
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
