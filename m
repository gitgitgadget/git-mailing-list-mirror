Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B05F1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 15:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934837AbcIGPNg (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 11:13:36 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48198 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933183AbcIGPNf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 11:13:35 -0400
Received: from x590d6d43.dyn.telefonica.de ([89.13.109.67] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1bheXS-0006Yc-9e; Wed, 07 Sep 2016 17:13:24 +0200
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Leho Kraav <leho@conversionready.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/5] t7004-tag: add version sort tests to show prerelease reordering issues
Date:   Wed,  7 Sep 2016 17:12:49 +0200
Message-Id: <20160907151251.30978-4-szeder@ira.uka.de>
X-Mailer: git-send-email 2.10.0.74.g6632b1b
In-Reply-To: <20160907151251.30978-1-szeder@ira.uka.de>
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1473261204.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Version sort with prerelease reordering sometimes puts tagnames in the
wrong order, when the common part of two compared tagnames ends with
the leading character(s) of one or more configured prerelease
suffixes.  Add tests that demonstrate these issues.

The unrelated '--format should list tags as per format given' test
later uses tags matching the same prefix as the version sort tests,
thus was affected by the new tags added for the new tests in this
patch.  Change that test to perform its checks on a different set of
tags.

Signed-off-by: SZEDER Gábor <szeder@ira.uka.de>
---
 t/t7004-tag.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 920a1b4b2e58..d69ac4940388 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1511,14 +1511,14 @@ test_expect_success 'invalid sort parameter in configuratoin' '
 '
 
 test_expect_success 'version sort with prerelease reordering' '
-	test_config versionsort.prereleaseSuffix -rc &&
-	git tag foo1.6-rc1 &&
-	git tag foo1.6-rc2 &&
+	test_config versionsort.prereleaseSuffix -beta &&
+	git tag foo1.6-beta1 &&
+	git tag foo1.6-beta2 &&
 	git tag -l --sort=version:refname "foo*" >actual &&
 	cat >expect <<-\EOF &&
 	foo1.3
-	foo1.6-rc1
-	foo1.6-rc2
+	foo1.6-beta1
+	foo1.6-beta2
 	foo1.6
 	foo1.10
 	EOF
@@ -1526,18 +1526,54 @@ test_expect_success 'version sort with prerelease reordering' '
 '
 
 test_expect_success 'reverse version sort with prerelease reordering' '
-	test_config versionsort.prereleaseSuffix -rc &&
+	test_config versionsort.prereleaseSuffix -beta &&
 	git tag -l --sort=-version:refname "foo*" >actual &&
 	cat >expect <<-\EOF &&
 	foo1.10
 	foo1.6
-	foo1.6-rc2
-	foo1.6-rc1
+	foo1.6-beta2
+	foo1.6-beta1
 	foo1.3
 	EOF
 	test_cmp expect actual
 '
 
+test_expect_failure 'version sort with prerelease reordering and common leading character' '
+	test_config versionsort.prereleaseSuffix -beta &&
+	git tag foo1.6-after1 &&
+	git tag -l --sort=version:refname "foo*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.3
+	foo1.6-beta1
+	foo1.6-beta2
+	foo1.6
+	foo1.6-after1
+	foo1.10
+	EOF
+	test_cmp expect actual
+'
+
+# Capitalization of suffixes is important here, because "-RC" would normally
+# be sorted before "-beta" and the config settings should override that.
+test_expect_failure 'version sort with prerelease reordering, multiple suffixes and common leading character' '
+	test_config versionsort.prereleaseSuffix -beta &&
+	git config --add versionsort.prereleaseSuffix -RC &&
+	git tag foo1.6-RC1 &&
+	git tag foo1.6-RC2 &&
+	git tag -l --sort=version:refname "foo*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.3
+	foo1.6-beta1
+	foo1.6-beta2
+	foo1.6-RC1
+	foo1.6-RC2
+	foo1.6
+	foo1.6-after1
+	foo1.10
+	EOF
+	test_cmp expect actual
+'
+
 run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
@@ -1566,13 +1602,11 @@ EOF"
 
 test_expect_success '--format should list tags as per format given' '
 	cat >expect <<-\EOF &&
-	refname : refs/tags/foo1.10
-	refname : refs/tags/foo1.3
-	refname : refs/tags/foo1.6
-	refname : refs/tags/foo1.6-rc1
-	refname : refs/tags/foo1.6-rc2
+	refname : refs/tags/v1.0
+	refname : refs/tags/v1.0.1
+	refname : refs/tags/v1.1.3
 	EOF
-	git tag -l --format="refname : %(refname)" "foo*" >actual &&
+	git tag -l --format="refname : %(refname)" "v1*" >actual &&
 	test_cmp expect actual
 '
 
-- 
2.10.0.74.g6632b1b

