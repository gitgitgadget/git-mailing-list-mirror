Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC39C3F68F
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30A62071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VsiOT1ZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAYXBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:01:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729027AbgAYXAz (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:55 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 72A4A6160E;
        Sat, 25 Jan 2020 23:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993253;
        bh=3jHcppxLGE4Za6iMdX4YGpER+IYmmrm5+fCZnYM9gqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VsiOT1ZSzNf0fSKXWeeBE0y9sEyuy/AcsZ1BIkifoEZC+dNOyUPkMSHsh/6VO0RTu
         ZJBSHqCNjFGD9QMtYMZPaKnw2bFHeJjHEDWa9GiqBO9/pf1IFpp7tkiBIy4ZIc6pHZ
         cS8SkVuH/RqGNwIQR76sXzaGasAL68yx/Zk1FLkoF4Zi9/8JMuEXUBQ92RevDbu9Lt
         /15dksw8FSXvBD8ZrXTG6TmJuy4yNOQnFdMRGhm4onlVQo43aYb4ST8lWMYMZsLMPS
         WQnMXzyVzscaE3yj/HkJssjC5Soc86shpOv8RYk2NXOUe5MuFSURLzwLE4aF5nLkLC
         rNpHNn0o0X8SuPl5OWX+OOHzUy4smKmcZGDvidRGFAScG3s5HZQ3rx9WW34Fe6SvJY
         ADP/Kx3UXMM6jhumyps0oLrgRvqMHa8G5SDt1TDRMBk9MxfXSnOAmmYUj9ue4zctVv
         cEZb5fCZ05/elXxR5Pi/Y5ji0SPJ9GSUewQ3AN0oWGAwlF0bL6c
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 22/22] t6024: update for SHA-256
Date:   Sat, 25 Jan 2020 23:00:34 +0000
Message-Id: <20200125230035.136348-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
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
