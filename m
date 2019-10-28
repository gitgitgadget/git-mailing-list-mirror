Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1522A1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfJ1A7h (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54296 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729040AbfJ1A7d (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6F77862062;
        Mon, 28 Oct 2019 00:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224372;
        bh=w/+wbft3C9E50SobW5TLIelUCHgfvWYMz4HIcJUKMz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LKrH1GF7Vvs1O2DXW3eVCKIQBHTb99qGepPVctMnSlwHLZtx46NbgHuhBc8BDxkS7
         e8mlt04aCnuxjzLqQVr+CDMbALDLYO0ED5s+C/3UaMPWxixcRAGudb9yZ8FXKhPUar
         +t/dywHbtJt7Vqzdh812nm1/lVzc0D7feFqn5aJZrvF7azEHtcMDgGBVmvAp1kWIZD
         c1bkdEI0UvqEOvpdPRd4IY+RmTIUHJQKsRjp3HR9gW1rjNjdXdhufilHxU/IDH4BWj
         A+wY/shUq9xzS5Sy/qlwzumBVHWroUSDVmYIBrVCyPcguRyk/kqyVqt6W7bc/ngjFm
         H91StgQBAVAEI1Bj4i99ifXJ46e3edPVnMY3d+PKdCpqGjbsAcFdDm1AirX1xWCsYs
         XQ1ZgpD8a9Xo/a0v3wpfyzMD0LY4zVNM825/+8FODQ+qZdfAa39puec95uOYzxVK2q
         nYEx6ApgMQmwoC7R6SS2ky3Rw6CXkadt4X6iGDMUCNuslfpTFj2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 09/15] t4027: make hash-size independent
Date:   Mon, 28 Oct 2019 00:59:01 +0000
Message-Id: <20191028005907.24985-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
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
