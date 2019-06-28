Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E771F461
	for <e@80x24.org>; Fri, 28 Jun 2019 22:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfF1W7q (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 18:59:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56308 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbfF1W7k (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jun 2019 18:59:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f01a:2fd6:a95e:5f84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 434DA60B16;
        Fri, 28 Jun 2019 22:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561762777;
        bh=o+hxGFYz64vS5YwtrbB7b/CV3HWIJJVxh/QPX6mBBKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fLEIyLrXD9lN28GhBs1JXXOFUdlpFh7TgnCx6y16oCf+EwCXiQIO9x/apXMK5JA+D
         Nej1WHuw5fW6zFmmVUXHeEEmD1Eo1MEC3eDiatCi4dRYA5pghYvIpouBcBmXQ9yrY7
         dj/lzx7ZR0LGiMNwnfVmz6AMMpJfZZ+pu6sxpm80b3FifwfhR6XeFX0Uizi86XOWxm
         0bcob4cZtWYicmT6trVAU7oAUD46yVfYWXakPV8XE/o+cioHHy30a0qDOSPeVPzaRg
         PuS2iFd73/4cugpzjVLHzFy2p1O523I3u4tES8RRLZs20Fq0VlN57kjMClI8FpWjKs
         o7nZovf9It+NgAtcE3ajKd+VLbSWqlGBEyBvmtzbUDvr56cUy0M7rh+GHAIttL7Jyq
         3eqP0SM94WdLt1XHPe1O6AEeve9wn4Wb58Vx91ACDwZ66e5OqY2X7NCK03AYwpcvtw
         0Owv1Hphz5ZitMJxGybujf40NI1qEmj/TDwJCec13Wl7IEwZVZL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/10] t1410: make hash size independent
Date:   Fri, 28 Jun 2019 22:59:20 +0000
Message-Id: <20190628225928.622372-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190628225928.622372-1-sandals@crustytoothpaste.net>
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of parsing object IDs using fixed-length shell patterns, use cut
to extract the first two characters of an object ID in addition to the
test helper for object paths.  Update another test to look up an
appropriate object ID fragment from the all-zeros object ID instead of
hardcoding the value.

Although the test for parsing reflogs at BUFSIZ boundaries passes, mark
it with the SHA1 prerequisite, as it doesn't currently usefully test
anything when using a hash longer than 20 bytes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1410-reflog.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 79f731db37..82950c0282 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -30,14 +30,13 @@ check_fsck () {
 }
 
 corrupt () {
-	aa=${1%??????????????????????????????????????} zz=${1#??}
-	mv .git/objects/$aa/$zz .git/$aa$zz
+	mv .git/objects/$(test_oid_to_path $1) .git/$1
 }
 
 recover () {
-	aa=${1%??????????????????????????????????????} zz=${1#??}
+	aa=$(echo $1 | cut -c 1-2)
 	mkdir -p .git/objects/$aa
-	mv .git/$aa$zz .git/objects/$aa/$zz
+	mv .git/$1 .git/objects/$(test_oid_to_path $1)
 }
 
 check_dont_have () {
@@ -55,6 +54,7 @@ check_dont_have () {
 }
 
 test_expect_success setup '
+	test_oid_init &&
 	mkdir -p A/B &&
 	echo rat >C &&
 	echo ox >A/D &&
@@ -313,12 +313,12 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
 # Each line is 114 characters, so we need 75 to still have a few before the
 # last 8K. The 89-character padding on the final entry lines up our
 # newline exactly.
-test_expect_success 'parsing reverse reflogs at BUFSIZ boundaries' '
+test_expect_success SHA1 'parsing reverse reflogs at BUFSIZ boundaries' '
 	git checkout -b reflogskip &&
-	z38=00000000000000000000000000000000000000 &&
+	zf=$(test_oid zero_2) &&
 	ident="abc <xyz> 0000000001 +0000" &&
 	for i in $(test_seq 1 75); do
-		printf "$z38%02d $z38%02d %s\t" $i $(($i+1)) "$ident" &&
+		printf "$zf%02d $zf%02d %s\t" $i $(($i+1)) "$ident" &&
 		if test $i = 75; then
 			for j in $(test_seq 1 89); do
 				printf X
@@ -329,7 +329,7 @@ test_expect_success 'parsing reverse reflogs at BUFSIZ boundaries' '
 		printf "\n"
 	done >.git/logs/refs/heads/reflogskip &&
 	git rev-parse reflogskip@{73} >actual &&
-	echo ${z38}03 >expect &&
+	echo ${zf}03 >expect &&
 	test_cmp expect actual
 '
 
