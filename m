Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0E9C33CB0
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F8820678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZLj5FCQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgAMMku (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:50 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37698 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728741AbgAMMkq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:46 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3F08E60809;
        Mon, 13 Jan 2020 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919244;
        bh=3jHcppxLGE4Za6iMdX4YGpER+IYmmrm5+fCZnYM9gqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZLj5FCQGP9dhI9cUdH8N1dF1epZvYnzscUqQ98rPyIMTEnFjguxYO97uzG09iWbQs
         VrK55Nkb8SO3jvhSDRVFzUQXylMj5l0IpH9J8erEi17xwtA/OcDE/59DQPR08EeWYR
         zZUB2zf0BvFPq8twzy2IQ7pqcl8Q7fJYWDPY2t7SW+QI49D6yPPB1CD3phCSzfVq9v
         ofVAgm5dW/Ixm/v4eiT00AcUqBWQKGFICt5CFbkUU83GnaZnBcw+BFfMZxQQ2o9qO8
         fJpKUW2DTrb74+RjLH7ICi05pWlCiOw3taoe5ptAKCg4XW9REh+JTi7Lvc7AYoqAm7
         SiribPBvY93peCekY+gPY4LVUn1Bv990zuNdVksUkyuCARQvUlszbaEUwaJ2UP+kzJ
         ur7oetbJCw2QR/P3ZwDE7I7SDrh5nzu1LBarki8Dj8u+7Y7QcU9m3tG2VChFR1ZhfN
         uUgLg+/VfFMXOy+ZKIPhMaxGhQt+QfJajNL2bpQm9hyWBHN8QSG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 24/24] t6024: update for SHA-256
Date:   Mon, 13 Jan 2020 12:38:57 +0000
Message-Id: <20200113123857.3684632-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make this test work with SHA-256, compute two of the items in the
conflicted index entry.  The other entry is a conflict within a conflict
and computing it is difficult, so use test_oid_cache to specify the
proper values for both hash algorithms.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6024-recursive-merge.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 0c9e3c20e8..332cfc53fd 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -57,7 +57,12 @@ test_expect_success 'setup tests' '
 	git rev-parse C >.git/MERGE_HEAD &&
 	echo F >a1 &&
 	git update-index a1 &&
-	GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
+	GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F &&
+
+	test_oid_cache <<-EOF
+	idxstage1 sha1:ec3fe2a791706733f2d8fa7ad45d9a9672031f5e
+	idxstage1 sha256:b3c8488929903aaebdeb22270cb6d36e5b8724b01ae0d4da24632f158c99676f
+	EOF
 '
 
 test_expect_success 'combined merge conflicts' '
@@ -79,10 +84,10 @@ test_expect_success 'result contains a conflict' '
 test_expect_success 'virtual trees were processed' '
 	git ls-files --stage >out &&
 
-	cat >expect <<-\EOF &&
-	100644 ec3fe2a791706733f2d8fa7ad45d9a9672031f5e 1	a1
-	100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
-	100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
+	cat >expect <<-EOF &&
+	100644 $(test_oid idxstage1) 1	a1
+	100644 $(git rev-parse F:a1) 2	a1
+	100644 $(git rev-parse G:a1) 3	a1
 	EOF
 
 	test_cmp expect out
