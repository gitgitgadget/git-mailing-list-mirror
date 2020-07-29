Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2253C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C5C2067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GNafXMo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgG2XP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41164 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728179AbgG2XPZ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 32EAC61012;
        Wed, 29 Jul 2020 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064492;
        bh=NUMBJgJTDnnaRbInDei/FYetn+BbdtANfNw+W3zGqkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=GNafXMo9tnI/dYVlVDVJ7NZKZyFXnMhm0hpsHEjPaDSGEiJ5RdrheKEeUlzPden60
         1n1EWbCL038Fpmt8B9SgaPhkwRpjNZ1DSe+qiMSAJMTslh60I78n3xyN06T2rmAKr9
         5AhMY1tboOXgq7CWVOGCVXA0w16XGBiFe4Ai601nin+r1L4r8Q0aolUk3cYgNKF5sB
         8LJFc643PKxfTAlGVZM58Vep8xNVXsPaY1/RIr2X+zebhpdori2fxft3dmsT8u+m5B
         7oTsaZEnmt2Ahn9oL4VUUO7zRom9KvLl1ZOqJUN7o9C5oGYtchZTVj5URFCUlmD+87
         VYPu53oA9+fdvRrSKIyn/Vb3I7XmvKtHhgER0XOTSw2rlUxpjyfhWR2Sch3/ZwzNjR
         651LgL3LWAYhbL4U/TQCIGR5g7boQh8OyXclr5RYEJ6/q9G2EhBY33P/uoDoFC0NDH
         +epE0Sy5DRj1IkrNIyXO8RcqAptIXWxmg9byvH4UZBAP+23yzVq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 14/39] t7400: make hash size independent
Date:   Wed, 29 Jul 2020 23:14:03 +0000
Message-Id: <20200729231428.3658647-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
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
 
