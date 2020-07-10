Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB3AC433E2
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4DE20663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="I3U3mobc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGJCt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40414 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbgGJCse (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:34 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AE85560A67;
        Fri, 10 Jul 2020 02:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349309;
        bh=NUMBJgJTDnnaRbInDei/FYetn+BbdtANfNw+W3zGqkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=I3U3mobc+A8EOrLukrxqRy3g7GmAfmzqrC6v6XBPqMWJSvAGxbRIq+IgVRd9kBUUB
         VGv+EaBAKMHc/RG80sOV8hzhBLQet0fiGArnqzXHnT+n774iNYogaen4lovEmhS4lN
         4e/oR8TZr5GT4Z0wZT+QB/hM/ZjxphDsK6w255u6n7fFUELFI+x0VTqC4OYX4vBTA+
         crHW5WugJeBJ93WoNH4b+ahUcTYtYDICyDj4TZn9TB3Nygnqp/HrFyAI89dAjnG6az
         n3fOkqI425Jf2OyCCteGnBINkyW8R6I3p3/3pi1vu/BYlH9gFlHrQ+LX6NPT1GD1im
         k2OzrXJ+nXyjxV6bHlA8nlJ+FDwjyiU8Y4bcmqIpnVGxM0xfiINg7ohEO26h8blS5V
         oVU/GzuVDOOCjlSXDDyum5UwAvid+lUKK90pTuvb2+rSvS7DBQ7d+HvToRNndPW5Nt
         JpdU7pTZl1GrHVkLo6q3egAVxa24JAK4rQbJRSkdBlu9XqYvHLc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 14/38] t7400: make hash size independent
Date:   Fri, 10 Jul 2020 02:47:04 +0000
Message-Id: <20200710024728.3100527-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
 
