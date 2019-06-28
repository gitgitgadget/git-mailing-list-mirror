Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACE81F461
	for <e@80x24.org>; Fri, 28 Jun 2019 22:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfF1W7q (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 18:59:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56348 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbfF1W7o (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jun 2019 18:59:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f01a:2fd6:a95e:5f84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F28E56100C;
        Fri, 28 Jun 2019 22:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561762782;
        bh=UxwWHo2TSb3qE7r58BZQeSbub9Eke0heb/Wo8Q0Jj7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XEqav1tDebh1MUm/we6qB1VyzEdhxKLgbE9sG1sb1e49viyVes2odV2EDDoYDgCKU
         Qmh6meknpGDGfSpNcovh9DsRHHLWbg2htDTHBTi4dXBbxTBMQSZ7OLEEq5IOLy9vM0
         dE1/Lnmh3cuhBZoBYZN3eNBygHIbZsgR12XpKJMdpJvMd5wPSkX8QiZCnVvx3Hzc6p
         vusaoueVgDoWBpr5awIIBjs4p/HguBa/PswdiuFzsxvI7+oi4O/xQRHzMTpJEGL/8U
         GT4mJB0hhCuQu6hQmZjEtz4quND+KTHZZuq1ZQXoeT6fZMunfyNKQSsPMtKKCrG+fn
         7bO8AoDr16cMEQMJJD/hp6BjxDYJLItrd6vmsp8TczC5QlkinFRhH/LGBPrSbp/xh6
         tdavSwu5YfpYmoqVBhZLTExkYXDfWeaA6Buu/Lhj334iDU9j4Y8gfcfECRe7U2apTV
         EjqDdubxyp/YPFlomufvWipx9iqOjX4OI1U49EeMdjDiUm6ENzH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/10] t6030: make test work with SHA-256
Date:   Fri, 28 Jun 2019 22:59:23 +0000
Message-Id: <20190628225928.622372-6-sandals@crustytoothpaste.net>
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
