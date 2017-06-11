Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC991F8CF
	for <e@80x24.org>; Sun, 11 Jun 2017 11:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbdFKLmS (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Jun 2017 07:42:18 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:55844
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751595AbdFKLmS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Jun 2017 07:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1497181336;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=dUThUcSz2FcWXOj/h8G9kCrA5mQzpkH3Cm+lhVBLSS4=;
        b=f6bLTNF9SxZWB3UOf/9EVCOKx4rczUinHFJmj72kSMrGWCmQ9XXD6jh+opOTLugD
        e8T8p6Ao3cjaNNiwKkIGOjTgQCk6Tt3oIGYrONHi8Pr4D1Mi5Hn7Sli7OH4jnpvHVTa
        JLrm39EsZvxkVRG2pCyRlK9ejnjspJA84Q+iyRJg=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c96f631f3-557a7960-2557-4aab-894b-efccf6728f31-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c7a68c647-372a5a13-5412-4838-921d-66980bac4099-000000@eu-west-1.amazonses.com>
References: <0102015c7a68c647-372a5a13-5412-4838-921d-66980bac4099-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] t3200: add test for single parameter passed to -m option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 11 Jun 2017 11:42:16 +0000
X-SES-Outgoing: 2017.06.11-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the case when only one parameter is passed to '-m'
(move/rename) option.

For example - if 'git branch -m bbb' is run, it should rename the
currently checked out branch to bbb. There was no test for this
particular case with only one parameter for -m option. However,
there's one similar test case for -M option.

Add test for making sure HEAD points to the bbb (new branch name). Also
add a test for making sure the reflog that is moved to 'bbb' retains
entries created for the currently checked out branch.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 t/t3200-branch.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fe62e7c775da6..720400c0e42af 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -100,6 +100,20 @@ test_expect_success 'git branch -m n/n n should work' '
 	git reflog exists refs/heads/n
 '
 
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
