Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD211F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeA1P5u (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:57:50 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58432 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751559AbeA1P5o (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:57:44 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3870961390;
        Sun, 28 Jan 2018 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517155063;
        bh=temQzreer9kPAM8RPqKqV7bk2FwreWjt9+zEr4I1rwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lDcj7yKdloKnko4qZke/tqLo8LLZ06s+Uf1+SdBmUsC/l6BERaJZC6mfwuwxSy0H2
         fXZrU8x4DHx41c/c57izqF3IXjFO3JGhdK8ZFb+mnVzOyaDFF184L6IhP7n6QlT0LT
         ijutvLIdDSrlyO7UJ0awHFDEhIX2duNi3jyQ7lOyJRV6JQHTmoHZD6LMJwEXbY/r91
         R8FA1XVkF85VKh1a/uL1Zt6ilgmH5TL6cEmR8pks51vuH7E9qnOk0o0zs1C8Sntpc9
         XkGeLOruWxRpXacwaAoQQ/LdMoxxoAolUJdNUYT2HtfXS2ks46YdZTAikCTYVFnTXE
         9P46VlkKZTKMaXBAcfUISb1SEarqUoUXd1CjN6+iWBpMCgIvdvuGKYPGaZIMHhw9oL
         FzLw1QU8CtgBjenh7ns7LyGSLc+1Zgca+L6CrcqO4IK1orOL+PkHRNrxGiDVjaIT00
         3F8kRYqfFUecCXcY4hcKLGVNRkDnbY03DxCfvJcM1y7MyICtLYv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 12/12] bulk-checkin: abstract SHA-1 usage
Date:   Sun, 28 Jan 2018 15:57:22 +0000
Message-Id: <20180128155722.880805-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180128155722.880805-1-sandals@crustytoothpaste.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert uses of the direct SHA-1 functions to use the_hash_algo instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bulk-checkin.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 5f79ed6ea3..8bcd1c8665 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -93,7 +93,7 @@ static int already_written(struct bulk_checkin_state *state, unsigned char sha1[
  * with a new pack.
  */
 static int stream_to_pack(struct bulk_checkin_state *state,
-			  git_SHA_CTX *ctx, off_t *already_hashed_to,
+			  git_hash_ctx *ctx, off_t *already_hashed_to,
 			  int fd, size_t size, enum object_type type,
 			  const char *path, unsigned flags)
 {
@@ -127,7 +127,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 				if (rsize < hsize)
 					hsize = rsize;
 				if (hsize)
-					git_SHA1_Update(ctx, ibuf, hsize);
+					the_hash_algo->update_fn(ctx, ibuf, hsize);
 				*already_hashed_to = offset;
 			}
 			s.next_in = ibuf;
@@ -192,7 +192,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 			   unsigned flags)
 {
 	off_t seekback, already_hashed_to;
-	git_SHA_CTX ctx;
+	git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint;
@@ -204,8 +204,8 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 
 	header_len = xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
 			       typename(type), (uintmax_t)size) + 1;
-	git_SHA1_Init(&ctx);
-	git_SHA1_Update(&ctx, obuf, header_len);
+	the_hash_algo->init_fn(&ctx);
+	the_hash_algo->update_fn(&ctx, obuf, header_len);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & HASH_WRITE_OBJECT) != 0)
@@ -236,7 +236,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-	git_SHA1_Final(result_sha1, &ctx);
+	the_hash_algo->final_fn(result_sha1, &ctx);
 	if (!idx)
 		return 0;
 
