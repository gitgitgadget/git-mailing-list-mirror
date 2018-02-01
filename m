Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0D51F404
	for <e@80x24.org>; Thu,  1 Feb 2018 02:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeBACTX (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 21:19:23 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58620 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932228AbeBACTN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 21:19:13 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EAFD760FBD;
        Thu,  1 Feb 2018 02:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517451552;
        bh=fbEQCz+oocS20Ha+gZhIyNrBkP0MSQcpgGg1lWiMveY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xIUGVoVTwX/NscwH5UJwm5vf19Dv8+iwrd1/jAeysDrcjkQiohHLlopgp6roDTxc4
         9Zi57EqESp1uufUdwIMxHlwzFHyYrXkYDRY04Q5P32bxCRqcCxMMad3/zejPR0Lnb/
         wqgQyvC3cJ1pTMGc4rkl3PQloHgo4fiT+G133Ne3kXqnmXo3pLFk4ZSrdq6rWM2FdM
         KI7f7vV6QZu5gODYURiXht+YiJT9kmG47PzY261Wcrskg/FK4OzGgo49pWdzSyOUZi
         HGHWbNWpb9V/lggxVDgeYwmBTTU9kWXOYkvFqkYte2fUTvoixzlxTOLcndeSHpZzz+
         368YLSSEY7mgAbE7LLj+XNO6HD3b5SoVd88RHGuU6mnLnJSENJby/gOLB6iYleeKAp
         xGp3RRh3vMkJiCdhch4Uunk/ZSNB6/FRQx7sMXZCggMDsvO1sdqrsWrUbcUPE75Msz
         RygKPPII7KFU6ZD3UJ7Ms9NfBzNKXh3xyPFTlbguMd91pBeaXSp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/12] csum-file: abstract uses of SHA-1
Date:   Thu,  1 Feb 2018 02:18:47 +0000
Message-Id: <20180201021848.533188-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180201021848.533188-1-sandals@crustytoothpaste.net>
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
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
