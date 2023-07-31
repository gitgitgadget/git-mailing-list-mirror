Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C72C001DC
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 12:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGaMPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 08:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjGaMPe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 08:15:34 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0F710E2
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 05:15:32 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5E3B01F547
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1690805288;
        bh=VQVCQI4Vw8/ZNlRzh9TR7lvqO2t17c8ikmbmzqe52Ok=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=F6WfjpH+bKpd3BOMO2YsleBNGfEbd1HUKffdJnerV68RPttvzXAVz2Ezwl6SAFkUw
         gWL10RyCIDpC/mRX+/uPG6ADFE5JNl4kTmjwXg7FgOsYo/B7GtSytu3Zk+zw+nI5bw
         X4e4AV7em0eO1sLOf0UctHPXkp5TdpHh1AmcZw70=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] sha256/gcrypt: fix build with SANITIZE=leak
Date:   Mon, 31 Jul 2023 12:08:06 +0000
Message-Id: <20230731120808.1230210-2-e@80x24.org>
In-Reply-To: <20230731120808.1230210-1-e@80x24.org>
References: <20230731120808.1230210-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Non-static functions cause `undefined reference' errors when
building with `SANITIZE=leak' due to the lack of prototypes.
Mark all these functions as `static inline' as we do in
sha256/nettle.h to avoid the need to maintain prototypes.

Signed-off-by: Eric Wong <e@80x24.org>
---
 sha256/gcrypt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha256/gcrypt.h b/sha256/gcrypt.h
index 501da5ed91..68cf6b6a54 100644
--- a/sha256/gcrypt.h
+++ b/sha256/gcrypt.h
@@ -7,22 +7,22 @@
 
 typedef gcry_md_hd_t gcrypt_SHA256_CTX;
 
-inline void gcrypt_SHA256_Init(gcrypt_SHA256_CTX *ctx)
+static inline void gcrypt_SHA256_Init(gcrypt_SHA256_CTX *ctx)
 {
 	gcry_md_open(ctx, GCRY_MD_SHA256, 0);
 }
 
-inline void gcrypt_SHA256_Update(gcrypt_SHA256_CTX *ctx, const void *data, size_t len)
+static inline void gcrypt_SHA256_Update(gcrypt_SHA256_CTX *ctx, const void *data, size_t len)
 {
 	gcry_md_write(*ctx, data, len);
 }
 
-inline void gcrypt_SHA256_Final(unsigned char *digest, gcrypt_SHA256_CTX *ctx)
+static inline void gcrypt_SHA256_Final(unsigned char *digest, gcrypt_SHA256_CTX *ctx)
 {
 	memcpy(digest, gcry_md_read(*ctx, GCRY_MD_SHA256), SHA256_DIGEST_SIZE);
 }
 
-inline void gcrypt_SHA256_Clone(gcrypt_SHA256_CTX *dst, const gcrypt_SHA256_CTX *src)
+static inline void gcrypt_SHA256_Clone(gcrypt_SHA256_CTX *dst, const gcrypt_SHA256_CTX *src)
 {
 	gcry_md_copy(dst, *src);
 }
