Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20F6202F3
	for <e@80x24.org>; Tue, 19 Jul 2016 22:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbcGSWNd (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 18:13:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:20802 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbcGSWNa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 18:13:30 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 695FF84638;
	Tue, 19 Jul 2016 18:13:29 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, gitster@pobox.com, jeffhost@microsoft.com
Subject: [PATCH v1 2/6] Status and checkout unit tests for --porcelain[=<n>]
Date:	Tue, 19 Jul 2016 18:10:54 -0400
Message-Id: <1468966258-11191-3-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Simple unit tests to validate the argument parsing.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7060-wtstatus.sh | 21 +++++++++++++++++++++
 t/t7501-commit.sh   | 14 ++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 44bf1d8..a39b0e2 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -228,4 +228,25 @@ test_expect_success 'status --branch with detached HEAD' '
 	test_i18ncmp expected actual
 '
 
+## Duplicate the above test and verify --porcelain=1 has no effect.
+test_expect_success 'status --branch with detached HEAD' '
+	git reset --hard &&
+	git checkout master^0 &&
+	git status --branch --porcelain=1 >actual &&
+	cat >expected <<-EOF &&
+	## HEAD (no branch)
+	?? .gitconfig
+	?? actual
+	?? expect
+	?? expected
+	?? mdconflict/
+	EOF
+	test_i18ncmp expected actual
+'
+
+## Verify parser error on --porcelain argument.
+test_expect_failure 'status --porcelain=bogus' '
+	git status --porcelain=bogus
+'
+
 test_done
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index d84897a..1a74d75 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -73,6 +73,10 @@ test_expect_success '--porcelain fails with nothing to commit' '
 	test_must_fail git commit -m initial --porcelain
 '
 
+test_expect_success '--porcelain=1 fails with nothing to commit' '
+	test_must_fail git commit -m initial --porcelain=1
+'
+
 test_expect_success '--long fails with nothing to commit' '
 	test_must_fail git commit -m initial --long
 '
@@ -97,6 +101,16 @@ test_expect_failure '--porcelain with stuff to commit returns ok' '
 	git commit -m next -a --porcelain
 '
 
+test_expect_failure '--porcelain=1 with stuff to commit returns ok' '
+	echo bongo bongo bongo >>file &&
+	git commit -m next -a --porcelain=1
+'
+
+test_expect_failure '--porcelain=bogus with stuff to commit returns ok' '
+	echo bongo bongo bongo >>file &&
+	git commit -m next -a --porcelain=bogus
+'
+
 test_expect_success '--long with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --long
-- 
2.8.0.rc4.17.gac42084.dirty

