Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1315520401
	for <e@80x24.org>; Tue, 13 Jun 2017 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdFMKrZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 06:47:25 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:52672
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752078AbdFMKrY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Jun 2017 06:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1497350842;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ITJernXTqUN4orh+tK5qKWtntM4ZorrsOlSX3LEQ9Fw=;
        b=WqUJa1NVxi5+jNdnAHfRDGGJcdm2IH1UMHOV7Qy4jcaw9Yc3QyYlT0HREwGXWDKS
        bqJrHqjNLQXnfXqXOONVkmgH32aJpSCmPEvEfIWta19xoLcjiXEbC1KyBWLdHBMf7fq
        KhzDmopKo0jQl5ysvhugi+KrYFFFT4Gs24AJ/XgA=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ca110a839-f4703e91-1a4d-4d8e-8406-df06b24683da-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c96f631f3-557a7960-2557-4aab-894b-efccf6728f31-000000@eu-west-1.amazonses.com>
References: <0102015c96f631f3-557a7960-2557-4aab-894b-efccf6728f31-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3] t3200: add test for single parameter passed to -m option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Jun 2017 10:47:22 +0000
X-SES-Outgoing: 2017.06.13-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the case when only one parameter is passed to '-m'
(move/rename) option.

For example - if 'git branch -m bbb' is run while checked out on aaa
branch, it should rename the currently checked out branch to bbb.
There was no test for this particular case with only one parameter
for -m option. However, there's one similar test case for -M option.

Add test for making sure HEAD points to the bbb (new branch name). Also
add a test for making sure the reflog that is moved to 'bbb' retains
entries created for the currently checked out branch. Note that since
the topmost entry on reflog for bbb will be about branch creation, we
compare bbb@{1} (instead of bbb@{0}) with aaa@{0} to make sure the
reflog for bbb retains entries from aaa.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 t/t3200-branch.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fe62e7c775da6..8c9cd70696f87 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -100,6 +100,23 @@ test_expect_success 'git branch -m n/n n should work' '
 	git reflog exists refs/heads/n
 '
 
+# The topmost entry in reflog for branch bbb is about branch creation.
+# Hence, we compare bbb@{1} (instead of bbb@{0}) with aaa@{0}.
+
+test_expect_success 'git branch -m bbb should rename checked out branch' '
+	test_when_finished git branch -D bbb &&
+	test_when_finished git checkout master &&
+	git checkout -b aaa &&
+	git commit --allow-empty -m "a new commit" &&
+	git rev-parse aaa@{0} >expect &&
+	git branch -m bbb &&
+	git rev-parse bbb@{1} >actual &&
+	test_cmp expect actual &&
+	git symbolic-ref HEAD >actual &&
+	echo refs/heads/bbb >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
 	git branch o/o &&
 	git branch o/p &&

--
https://github.com/git/git/pull/371
