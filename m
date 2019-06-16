Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71701F462
	for <e@80x24.org>; Sun, 16 Jun 2019 18:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfFPSx5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 14:53:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60172 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727351AbfFPSx5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Jun 2019 14:53:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:159e:486:c87b:cfd7])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 71A8E60745;
        Sun, 16 Jun 2019 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560711235;
        bh=UxwWHo2TSb3qE7r58BZQeSbub9Eke0heb/Wo8Q0Jj7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZhFz6r73tSOQrq/kyBQr8SBlf/rPXA+8BE18ARMqJlvEOxMEdVEv0owrhovtpo4Yz
         L/l6Yi6JTZWgWjkYdOkCAmDHtSfxf3DYQZcjY6JrHRaFTfPQiVs+KwWr1LCB2ThOd3
         bZx27aVCS45HhFPnC4h66dOQWfBGuwvuIwn1rbBdp/q6bPbIaE1cRlkCc2lnsvDX3w
         1DNFu8i5ih6JunJkAWtlp5KMTrJuLyeNdtv6VgZRq16pIToIu1i8PhVyCRWbWgXdpB
         QEruREaDwkQqF2BegvOi1BrUzaDftyMstNUprRrh/XzAvXtohP78cgCmi5ixrBbtSk
         5fF3oaYp29o8PG0iS8onkjblkM2a7F5Fa8w7JD38DeoIDgemKjDxYBa5ZLtsfwlpI2
         Fna/pqu6S5EryWkeAmWDn9tw8iLvpRCyFKrT6oLRc7E3mIOmAAV9vgEHoBRZq2pGlX
         D8WMXL9DDehFIX4NAHczMvnQIKJf3tQbHuV3OQ9PaSXeUO7/Bpb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/10] t6030: make test work with SHA-256
Date:   Sun, 16 Jun 2019 18:53:25 +0000
Message-Id: <20190616185330.549436-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5
In-Reply-To: <20190616185330.549436-1-sandals@crustytoothpaste.net>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute several object ID values instead of hard-coding them, and use
test_oid_to_path to cleanly produce a path for an object.

Note that the bisect code which is tested here remains sensitive to the
hash algorithm in use because it uses the object ID to disambiguate
between two equidistant commits.  Fortunately, SHA-1 and SHA-256
disambiguate identically in the cases we care about, so there is no need
to modify the test to accommodate this situation.  However, if a further
hash algorithm change occurs, this test may require some restructuring.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6030-bisect-porcelain.sh | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 49a394bd75..bdc42e9440 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -615,6 +615,7 @@ test_expect_success 'broken branch creation' '
 	git add missing/MISSING &&
 	git commit -m "6(broken): Added file that will be deleted" &&
 	git tag BROKEN_HASH6 &&
+	deleted=$(git rev-parse --verify HEAD:missing) &&
 	add_line_into_file "7(broken): second line on a broken branch" hello2 &&
 	git tag BROKEN_HASH7 &&
 	add_line_into_file "8(broken): third line on a broken branch" hello2 &&
@@ -622,12 +623,12 @@ test_expect_success 'broken branch creation' '
 	git rm missing/MISSING &&
 	git commit -m "9(broken): Remove missing file" &&
 	git tag BROKEN_HASH9 &&
-	rm .git/objects/39/f7e61a724187ab767d2e08442d9b6b9dab587d
+	rm .git/objects/$(test_oid_to_path $deleted)
 '
 
 echo "" > expected.ok
 cat > expected.missing-tree.default <<EOF
-fatal: unable to read tree 39f7e61a724187ab767d2e08442d9b6b9dab587d
+fatal: unable to read tree $deleted
 EOF
 
 test_expect_success 'bisect fails if tree is broken on start commit' '
@@ -713,12 +714,12 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
 "
 
 cat > expected.bisect-log <<EOF
-# bad: [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
-# good: [7b7f204a749c3125d5224ed61ea2ae1187ad046f] Add <2: A new day for git> into <hello>.
-git bisect start '32a594a3fdac2d57cf6d02987e30eec68511498c' '7b7f204a749c3125d5224ed61ea2ae1187ad046f'
-# good: [3de952f2416b6084f557ec417709eac740c6818c] Add <3: Another new day for git> into <hello>.
-git bisect good 3de952f2416b6084f557ec417709eac740c6818c
-# first bad commit: [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
+# bad: [$HASH4] Add <4: Ciao for now> into <hello>.
+# good: [$HASH2] Add <2: A new day for git> into <hello>.
+git bisect start '$HASH4' '$HASH2'
+# good: [$HASH3] Add <3: Another new day for git> into <hello>.
+git bisect good $HASH3
+# first bad commit: [$HASH4] Add <4: Ciao for now> into <hello>.
 EOF
 
 test_expect_success 'bisect log: successful result' '
@@ -731,14 +732,14 @@ test_expect_success 'bisect log: successful result' '
 '
 
 cat > expected.bisect-skip-log <<EOF
-# bad: [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
-# good: [7b7f204a749c3125d5224ed61ea2ae1187ad046f] Add <2: A new day for git> into <hello>.
-git bisect start '32a594a3fdac2d57cf6d02987e30eec68511498c' '7b7f204a749c3125d5224ed61ea2ae1187ad046f'
-# skip: [3de952f2416b6084f557ec417709eac740c6818c] Add <3: Another new day for git> into <hello>.
-git bisect skip 3de952f2416b6084f557ec417709eac740c6818c
+# bad: [$HASH4] Add <4: Ciao for now> into <hello>.
+# good: [$HASH2] Add <2: A new day for git> into <hello>.
+git bisect start '$HASH4' '$HASH2'
+# skip: [$HASH3] Add <3: Another new day for git> into <hello>.
+git bisect skip $HASH3
 # only skipped commits left to test
-# possible first bad commit: [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
-# possible first bad commit: [3de952f2416b6084f557ec417709eac740c6818c] Add <3: Another new day for git> into <hello>.
+# possible first bad commit: [$HASH4] Add <4: Ciao for now> into <hello>.
+# possible first bad commit: [$HASH3] Add <3: Another new day for git> into <hello>.
 EOF
 
 test_expect_success 'bisect log: only skip commits left' '
