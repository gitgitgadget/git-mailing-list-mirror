Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851C41F859
	for <e@80x24.org>; Wed,  7 Sep 2016 15:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934485AbcIGPN3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 11:13:29 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48146 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933183AbcIGPN2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 11:13:28 -0400
Received: from x590d6d43.dyn.telefonica.de ([89.13.109.67] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1bheXQ-0006Yc-8p; Wed, 07 Sep 2016 17:13:21 +0200
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Leho Kraav <leho@conversionready.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/5] t7004-tag: use test_config helper
Date:   Wed,  7 Sep 2016 17:12:48 +0200
Message-Id: <20160907151251.30978-3-szeder@ira.uka.de>
X-Mailer: git-send-email 2.10.0.74.g6632b1b
In-Reply-To: <20160907151251.30978-1-szeder@ira.uka.de>
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1473261202.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... instead of setting and then manually unsetting configuration
variables, on one occasion even outside the test_expect_success block.

Signed-off-by: SZEDER Gábor <szeder@ira.uka.de>
---
 t/t7004-tag.sh | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 396cffeeb5ad..920a1b4b2e58 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -297,11 +297,9 @@ EOF
 '
 
 test_expect_success 'listing tags in column with column.*' '
-	git config column.tag row &&
-	git config column.ui dense &&
+	test_config column.tag row &&
+	test_config column.ui dense &&
 	COLUMNS=40 git tag -l >actual &&
-	git config --unset column.ui &&
-	git config --unset column.tag &&
 	cat >expected <<\EOF &&
 a1      aa1   cba     t210    t211
 v0.2.1  v1.0  v1.0.1  v1.1.3
@@ -314,9 +312,8 @@ test_expect_success 'listing tag with -n --column should fail' '
 '
 
 test_expect_success 'listing tags -n in column with column.ui ignored' '
-	git config column.ui "row dense" &&
+	test_config column.ui "row dense" &&
 	COLUMNS=40 git tag -l -n >actual &&
-	git config --unset column.ui &&
 	cat >expected <<\EOF &&
 a1              Foo
 aa1             Foo
@@ -1200,11 +1197,10 @@ test_expect_success GPG,RFC1991 \
 '
 
 # try to sign with bad user.signingkey
-git config user.signingkey BobTheMouse
 test_expect_success GPG \
 	'git tag -s fails if gpg is misconfigured (bad key)' \
-	'test_must_fail git tag -s -m tail tag-gpg-failure'
-git config --unset user.signingkey
+	'test_config user.signingkey BobTheMouse &&
+	test_must_fail git tag -s -m tail tag-gpg-failure'
 
 # try to produce invalid signature
 test_expect_success GPG \
@@ -1484,7 +1480,7 @@ test_expect_success 'reverse lexical sort' '
 '
 
 test_expect_success 'configured lexical sort' '
-	git config tag.sort "v:refname" &&
+	test_config tag.sort "v:refname" &&
 	git tag -l "foo*" >actual &&
 	cat >expect <<-\EOF &&
 	foo1.3
@@ -1495,6 +1491,7 @@ test_expect_success 'configured lexical sort' '
 '
 
 test_expect_success 'option override configured sort' '
+	test_config tag.sort "v:refname" &&
 	git tag -l --sort=-refname "foo*" >actual &&
 	cat >expect <<-\EOF &&
 	foo1.6
@@ -1509,13 +1506,12 @@ test_expect_success 'invalid sort parameter on command line' '
 '
 
 test_expect_success 'invalid sort parameter in configuratoin' '
-	git config tag.sort "v:notvalid" &&
+	test_config tag.sort "v:notvalid" &&
 	test_must_fail git tag -l "foo*"
 '
 
 test_expect_success 'version sort with prerelease reordering' '
-	git config --unset tag.sort &&
-	git config versionsort.prereleaseSuffix -rc &&
+	test_config versionsort.prereleaseSuffix -rc &&
 	git tag foo1.6-rc1 &&
 	git tag foo1.6-rc2 &&
 	git tag -l --sort=version:refname "foo*" >actual &&
@@ -1530,6 +1526,7 @@ test_expect_success 'version sort with prerelease reordering' '
 '
 
 test_expect_success 'reverse version sort with prerelease reordering' '
+	test_config versionsort.prereleaseSuffix -rc &&
 	git tag -l --sort=-version:refname "foo*" >actual &&
 	cat >expect <<-\EOF &&
 	foo1.10
-- 
2.10.0.74.g6632b1b

