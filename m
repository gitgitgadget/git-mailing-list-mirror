Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9122EC433E5
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71519206F4
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dvINLmYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGMCtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40638 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726991AbgGMCtb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8566B60A67;
        Mon, 13 Jul 2020 02:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608569;
        bh=NUMBJgJTDnnaRbInDei/FYetn+BbdtANfNw+W3zGqkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=dvINLmYOQtiIjvXQV/oqGCO3LQT2vq9PnW9OrmkxUGBd8QpL14WSytmt9ddMeJAvK
         okGTF4C048rwCOo56vPmTMbC1pmy2Mv3sXEQHk+XQ/ZYCjjarfwHHI0iigNb7Ix2Xf
         o16Ogy8GAO5HQEhIZ4c0dyHsdbX8qHw6ToFPqL1QXjHrL92wW0fmyR/zTltCqqs0i/
         HNSfAkXqYZ2UrFKws8sd9BlrQnf8+2YrJOnr94gvYXxt0NEqUd5l1mL3xMrcw9if2U
         8jjGi8WyIG7eu72UfC0PsDtYo4XGbLOsICkOAw3qWFNzuP/uV9fxr0HtqEh/Byp+sl
         qOgoeBrkl6Ze+ojg3pzg9N2kYPs6GQljJARQVoJQV/H5tUNGylc6AuS4Nz5ghOJv4F
         wUzj9GdJU+yQ35FKg7eh64irt9A+etIi+Xj/waxh1LQRaPqGJt0TmQcIKOdFkqE/cZ
         qYzPqjiY7pl0pdKKn4C6mIMymqyjdx1ozhHeNMCUyRmaad1G35l
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 14/39] t7400: make hash size independent
Date:   Mon, 13 Jul 2020 02:48:44 +0000
Message-Id: <20200713024909.3714837-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
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
 
