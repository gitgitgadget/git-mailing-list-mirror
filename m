Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7401F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfJEVMY (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36302 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfJEVMV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 52AF461C66;
        Sat,  5 Oct 2019 21:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309940;
        bh=w/+wbft3C9E50SobW5TLIelUCHgfvWYMz4HIcJUKMz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HNq4X0ScZky8hUYuHd1O2q45JQvaVLlhwj+rBR9SGzjMKPtRH6zDfc7oG4Skc24WF
         5RtkAuIbAYISt+azf1AXCtE4pE160gh4Klq0PGoUV73zD0GRYnwshamFbxvhIGJ3O5
         fRRuKZrB3Jwys5F7gmdv6nYbbpJ+ElJ3ZRhbCEvV3UuHfXFGoDPDbaYwlv42GSU3fx
         Y7TvNrJyCN1oIjiR8hMdsoFX1yNc8sNy1KFCRpp+IIHh5CgeHKV9ZNkzN86RKOYOBW
         N/HGq8J55ktRZNeEghuhGBnlYhgCfqtZHQ8svIE8hSSZyC4n0YnsJHcLn7q28+btBE
         gbqXJSyI/+k3OlWzzT0Ena76eut3hMeS+GHbbMwwTwJQ6sQAQOtCwzovJDZ11qiZ0b
         grKZrw/y0SzLlHaOssyrJifWP4SlIKPiGXx6WbpbF7ijaOv2+SzR9NtAfxMXAOqaCY
         nsaImreFJb6fiRxakC8h7zO3ugNqOsivB5qMFQdMfLz8pMNFjRF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 09/15] t4027: make hash-size independent
Date:   Sat,  5 Oct 2019 21:12:03 +0000
Message-Id: <20191005211209.18237-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the length of an object ID, look this value up
using the translation tables.  Similarly, compute input data for invalid
submodule entries using the tables as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4027-diff-submodule.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 9aa8e2b39b..e29deaf4a5 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -6,6 +6,7 @@ test_description='difference in submodules'
 . "$TEST_DIRECTORY"/diff-lib.sh
 
 test_expect_success setup '
+	test_oid_init &&
 	test_tick &&
 	test_create_repo sub &&
 	(
@@ -36,7 +37,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'git diff --raw HEAD' '
-	git diff --raw --abbrev=40 HEAD >actual &&
+	hexsz=$(test_oid hexsz) &&
+	git diff --raw --abbrev=$hexsz HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -245,23 +247,21 @@ test_expect_success 'git diff (empty submodule dir)' '
 '
 
 test_expect_success 'conflicted submodule setup' '
-
-	# 39 efs
-	c=fffffffffffffffffffffffffffffffffffffff &&
+	c=$(test_oid ff_1) &&
 	(
 		echo "000000 $ZERO_OID 0	sub" &&
 		echo "160000 1$c 1	sub" &&
 		echo "160000 2$c 2	sub" &&
 		echo "160000 3$c 3	sub"
 	) | git update-index --index-info &&
-	echo >expect.nosub '\''diff --cc sub
+	echo >expect.nosub "diff --cc sub
 index 2ffffff,3ffffff..0000000
 --- a/sub
 +++ b/sub
 @@@ -1,1 -1,1 +1,1 @@@
-- Subproject commit 2fffffffffffffffffffffffffffffffffffffff
- -Subproject commit 3fffffffffffffffffffffffffffffffffffffff
-++Subproject commit 0000000000000000000000000000000000000000'\'' &&
+- Subproject commit 2$c
+ -Subproject commit 3$c
+++Subproject commit $ZERO_OID" &&
 
 	hh=$(git rev-parse HEAD) &&
 	sed -e "s/$ZERO_OID/$hh/" expect.nosub >expect.withsub
