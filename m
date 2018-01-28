Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8AE1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeA1P54 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:57:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58426 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751601AbeA1P5n (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:57:43 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4C24261352;
        Sun, 28 Jan 2018 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517155062;
        bh=fbEQCz+oocS20Ha+gZhIyNrBkP0MSQcpgGg1lWiMveY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uqWgrZeyOo315vcryqwzXDah99k2d7MGZ2VaaT5Rko2jUfrLD9bx1HI9ZhfD43YWE
         udGQFXW4/A9bo6YEzr0v40YhMQk0ebYtCdcwPdfx8NA/KqoW3vgRhVfvpQKgSEwd+z
         V9bMdGnaA0l4d0W1U8U+rN/oX7uqz+8oEmmFecyj3gbX1gqe0xQ66shiWYNOuPET/P
         YRw+Qvf1cHntqpliQWHAaqKM+to5OqxwHMyrSzZVTb8zfyHDNrL2JpiYZESii+8xVN
         Evv19m2jXvSH0igphY/394zTIjA42Gz1I0WmKsSZTROYVh7Hm7DDnP33Bt1/Dem2Fe
         JlQs8U1vs+LWpbFRIkctyrd7GcLrmdjmd5o8JmkyZLVJ2bxlM0DbLyuzIx9J67/te3
         hyhpJlSlb38uiU91FhQ/CzqEpT5gDcokMUGIPzrOVaNEW8+PuKGyNZQle8x2b7hw0J
         am6VIvlTswzjqGMYaH9BYvCJtOP7++BogmKz4sbJqEeUHh3xcZ/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 11/12] csum-file: abstract uses of SHA-1
Date:   Sun, 28 Jan 2018 15:57:21 +0000
Message-Id: <20180128155722.880805-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180128155722.880805-1-sandals@crustytoothpaste.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert several direct uses of SHA-1 to use the_hash_algo instead.
Convert one use of the constant 20 as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 csum-file.c | 10 +++++-----
 csum-file.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index e4ad6337dc..5eda7fb6af 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -47,7 +47,7 @@ void hashflush(struct hashfile *f)
 	unsigned offset = f->offset;
 
 	if (offset) {
-		git_SHA1_Update(&f->ctx, f->buffer, offset);
+		the_hash_algo->update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -58,12 +58,12 @@ int hashclose(struct hashfile *f, unsigned char *result, unsigned int flags)
 	int fd;
 
 	hashflush(f);
-	git_SHA1_Final(f->buffer, &f->ctx);
+	the_hash_algo->final_fn(f->buffer, &f->ctx);
 	if (result)
 		hashcpy(result, f->buffer);
 	if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
 		/* write checksum and close fd */
-		flush(f, f->buffer, 20);
+		flush(f, f->buffer, the_hash_algo->rawsz);
 		if (flags & CSUM_FSYNC)
 			fsync_or_die(f->fd, f->name);
 		if (close(f->fd))
@@ -110,7 +110,7 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 		buf = (char *) buf + nr;
 		left -= nr;
 		if (!left) {
-			git_SHA1_Update(&f->ctx, data, offset);
+			the_hash_algo->update_fn(&f->ctx, data, offset);
 			flush(f, data, offset);
 			offset = 0;
 		}
@@ -149,7 +149,7 @@ struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp
 	f->tp = tp;
 	f->name = name;
 	f->do_crc = 0;
-	git_SHA1_Init(&f->ctx);
+	the_hash_algo->init_fn(&f->ctx);
 	return f;
 }
 
diff --git a/csum-file.h b/csum-file.h
index ceb3e5712d..992e5c0141 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -8,7 +8,7 @@ struct hashfile {
 	int fd;
 	int check_fd;
 	unsigned int offset;
-	git_SHA_CTX ctx;
+	git_hash_ctx ctx;
 	off_t total;
 	struct progress *tp;
 	const char *name;
@@ -20,7 +20,7 @@ struct hashfile {
 /* Checkpoint */
 struct hashfile_checkpoint {
 	off_t offset;
-	git_SHA_CTX ctx;
+	git_hash_ctx ctx;
 };
 
 extern void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *);
