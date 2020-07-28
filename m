Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89C7C43460
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871A72075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g4UfR4yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgG1Xfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40970 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730387AbgG1Xfc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4116B61017;
        Tue, 28 Jul 2020 23:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979301;
        bh=NUMBJgJTDnnaRbInDei/FYetn+BbdtANfNw+W3zGqkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=g4UfR4yt7JsX5an7wyOmtB/84ayQ68/5xV757lJ1IhGDCEwhz/eo7riOgPBdSnIB9
         /bqeXo9DmT+THUpcwB+VocsjYBamJ0+y1chvkkYl2X++W+4m0gsMubQeWn1e+LXSSH
         cHXLrE12J/zgo6dfGp5nUsHrzjKqC63UpPEESficHDH7MVI2eOAG7A8ggumbImXC7D
         xb4/FEvj731HSFf8sb/XhpjLyvP+8B5shpcnQJuUvifX5jN9lazT0zyJgMFilM0UnC
         2FSpj7YALe3207yAmt+jHcWfTl5g/+TTaah88dnLwwlznRX+wrmYIMHi5/Llsn8Am0
         D4qwIASNP41pKz7Q8Cl6xbdS4xAPsdsMRh74l9/ZVmxrRYZj2PwNHz/sfCkV1OAYGm
         /jOf6elNoOGKGy/7/A8xDHCHYpLNy/dD9ZVTjWL8GassLzAbvwDshkLes6P76IwMwg
         jfXaNLVbHapF4wpfj3Rr/sZkM+r+M6tlMIIVibxokAP3HqwzjnM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 14/39] t7400: make hash size independent
Date:   Tue, 28 Jul 2020 23:34:21 +0000
Message-Id: <20200728233446.3066485-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using cut with hard-coded hash sizes, use cut with fields, or
where that's not possible, sed with $OID_REGEX, so that the tests are
independent of hash size.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7400-submodule-basic.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 956e17abb3..fec7e0299d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1231,7 +1231,7 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	git submodule add /dir1/b dir1/b &&
 	git submodule add /dir2/b dir2/b &&
 	git commit -m "first submodule commit" &&
-	git submodule--helper list dir1/b |cut -c51- >actual &&
+	git submodule--helper list dir1/b | cut -f 2 >actual &&
 	echo "dir1/b" >expect &&
 	test_cmp expect actual
 '
@@ -1260,7 +1260,7 @@ test_expect_success 'submodule update --init with a specification' '
 	pwd=$(pwd) &&
 	git clone file://"$pwd"/multisuper multisuper_clone &&
 	git -C multisuper_clone submodule update --init . ":(exclude)sub0" &&
-	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	git -C multisuper_clone submodule status | sed "s/$OID_REGEX //" >actual &&
 	test_cmp expect actual
 '
 
@@ -1271,7 +1271,7 @@ test_expect_success 'submodule update --init with submodule.active set' '
 	git -C multisuper_clone config submodule.active "." &&
 	git -C multisuper_clone config --add submodule.active ":(exclude)sub0" &&
 	git -C multisuper_clone submodule update --init &&
-	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	git -C multisuper_clone submodule status | sed "s/$OID_REGEX //" >actual &&
 	test_cmp expect actual
 '
 
@@ -1290,7 +1290,7 @@ test_expect_success 'submodule update and setting submodule.<name>.active' '
 	-sub3
 	EOF
 	git -C multisuper_clone submodule update &&
-	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	git -C multisuper_clone submodule status | sed "s/$OID_REGEX //" >actual &&
 	test_cmp expect actual
 '
 
@@ -1307,12 +1307,12 @@ test_expect_success 'clone active submodule without submodule url set' '
 		git submodule update &&
 		git submodule status >actual_raw &&
 
-		cut -c 1,43- actual_raw >actual &&
+		cut -d" " -f3- actual_raw >actual &&
 		cat >expect <<-\EOF &&
-		 sub0 (test2)
-		 sub1 (test2)
-		 sub2 (test2)
-		 sub3 (test2)
+		sub0 (test2)
+		sub1 (test2)
+		sub2 (test2)
+		sub3 (test2)
 		EOF
 		test_cmp expect actual
 	)
@@ -1328,7 +1328,7 @@ test_expect_success 'clone --recurse-submodules with a pathspec works' '
 	EOF
 
 	git clone --recurse-submodules="sub0" multisuper multisuper_clone &&
-	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	git -C multisuper_clone submodule status | sed "s/$OID_REGEX //" >actual &&
 	test_cmp expected actual
 '
 
@@ -1345,7 +1345,7 @@ test_expect_success 'clone with multiple --recurse-submodules options' '
 		  --recurse-submodules=":(exclude)sub0" \
 		  --recurse-submodules=":(exclude)sub2" \
 		  multisuper multisuper_clone &&
-	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	git -C multisuper_clone submodule status | sed "s/$OID_REGEX //" >actual &&
 	test_cmp expect actual
 '
 
@@ -1373,7 +1373,7 @@ test_expect_success 'clone and subsequent updates correctly auto-initialize subm
 		  --recurse-submodules=":(exclude)sub4" \
 		  multisuper multisuper_clone &&
 
-	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	git -C multisuper_clone submodule status | sed "s/$OID_REGEX //" >actual &&
 	test_cmp expect actual &&
 
 	git -C multisuper submodule add ../sub1 sub4 &&
@@ -1382,7 +1382,7 @@ test_expect_success 'clone and subsequent updates correctly auto-initialize subm
 	# obtain the new superproject
 	git -C multisuper_clone pull &&
 	git -C multisuper_clone submodule update --init &&
-	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	git -C multisuper_clone submodule status | sed "s/$OID_REGEX //" >actual &&
 	test_cmp expect2 actual
 '
 
