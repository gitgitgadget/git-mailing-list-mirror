Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37B81F404
	for <e@80x24.org>; Thu,  1 Feb 2018 02:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeBACTG (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 21:19:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932159AbeBACTD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 21:19:03 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 66F2160FBC;
        Thu,  1 Feb 2018 02:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517451540;
        bh=EUbHXqrjeLUyjr9vy3gQIa8MvrYvukUZrghzWKb1BrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Huf+ybwigVs7kb5mhLpdlDadDtkaqvnuJAznea0V/PnEwM0qsC5+tOZZ62a/F2mZw
         2m2ivslpjUKjrz4USEH5vp701+d3ZN9d95a64+46KFFQnCBbNrwNKgIGT9zdj+2tRt
         OnUYRTtJRLOiPUaHzb8eou0dT42AI7UAtMcHE+O3/j6JhTAiX94YF39WJ65yerXBU4
         mm1Jn0HsdysCnGCFxVyBxkpBG52dH+jLEEg8i+AE3HezDQJaCkmSgCyZe6UsSEWQhV
         upYV+yZ6QsiSh9omaoKkaA6jgIYgNKOG26/TP9SB9h8De+0hrScyc/kKLLL7rwTTDu
         wj5Mqwz9xZw1QOsln2opKJVTgMYpsMPa9cZq5J/WhmzIsYT7oSesLO8nGUsvcon7/o
         Zv3yBvBbRPgG977ZdoVgKZ2uWdH2zE2WNbrcYG4CNJ4i599k5HbYtGuPpp+vnOIQ5N
         hGfblZhgkaax6BBYvA99jxxejKG7SwPgYEoan3yfCqTEpwGJtpt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/12] hash: create union for hash context allocation
Date:   Thu,  1 Feb 2018 02:18:38 +0000
Message-Id: <20180201021848.533188-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180201021848.533188-1-sandals@crustytoothpaste.net>
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In various parts of our code, we want to allocate a structure
representing the internal state of a hash algorithm.  The original
implementation of the hash algorithm abstraction assumed we would do
that using heap allocations, and added a context size element to struct
git_hash_algo.  However, most of the existing code uses stack
allocations and conversion would needlessly complicate various parts of
the code.  Add a union for the purpose of allocating hash contexts on
the stack and a typedef for ease of use.  Use this union for defining
the init, update, and final functions to avoid casts.  Remove the ctxsz
element for struct git_hash_algo, which is no longer very useful.

This does mean that stack allocations will grow slightly as additional
hash functions are added, but this should not be a significant problem,
since we don't allocate many hash contexts.  The improved usability and
benefits from avoiding dynamic allocation outweigh this small downside.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h      | 15 +++++++++------
 sha1_file.c | 20 +++++++++-----------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/hash.h b/hash.h
index 7122dea7b3..eb30f59be3 100644
--- a/hash.h
+++ b/hash.h
@@ -55,9 +55,15 @@
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA1 + 1)
 
-typedef void (*git_hash_init_fn)(void *ctx);
-typedef void (*git_hash_update_fn)(void *ctx, const void *in, size_t len);
-typedef void (*git_hash_final_fn)(unsigned char *hash, void *ctx);
+/* A suitably aligned type for stack allocations of hash contexts. */
+union git_hash_ctx {
+	git_SHA_CTX sha1;
+};
+typedef union git_hash_ctx git_hash_ctx;
+
+typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
+typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size_t len);
+typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
 
 struct git_hash_algo {
 	/*
@@ -69,9 +75,6 @@ struct git_hash_algo {
 	/* A four-byte version identifier, used in pack indices. */
 	uint32_t format_id;
 
-	/* The size of a hash context (e.g. git_SHA_CTX). */
-	size_t ctxsz;
-
 	/* The length of the hash in binary. */
 	size_t rawsz;
 
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..ec6ecea170 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -39,32 +39,32 @@ const struct object_id empty_blob_oid = {
 	EMPTY_BLOB_SHA1_BIN_LITERAL
 };
 
-static void git_hash_sha1_init(void *ctx)
+static void git_hash_sha1_init(git_hash_ctx *ctx)
 {
-	git_SHA1_Init((git_SHA_CTX *)ctx);
+	git_SHA1_Init(&ctx->sha1);
 }
 
-static void git_hash_sha1_update(void *ctx, const void *data, size_t len)
+static void git_hash_sha1_update(git_hash_ctx *ctx, const void *data, size_t len)
 {
-	git_SHA1_Update((git_SHA_CTX *)ctx, data, len);
+	git_SHA1_Update(&ctx->sha1, data, len);
 }
 
-static void git_hash_sha1_final(unsigned char *hash, void *ctx)
+static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
 {
-	git_SHA1_Final(hash, (git_SHA_CTX *)ctx);
+	git_SHA1_Final(hash, &ctx->sha1);
 }
 
-static void git_hash_unknown_init(void *ctx)
+static void git_hash_unknown_init(git_hash_ctx *ctx)
 {
 	die("trying to init unknown hash");
 }
 
-static void git_hash_unknown_update(void *ctx, const void *data, size_t len)
+static void git_hash_unknown_update(git_hash_ctx *ctx, const void *data, size_t len)
 {
 	die("trying to update unknown hash");
 }
 
-static void git_hash_unknown_final(unsigned char *hash, void *ctx)
+static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
 {
 	die("trying to finalize unknown hash");
 }
@@ -75,7 +75,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		0x00000000,
 		0,
 		0,
-		0,
 		git_hash_unknown_init,
 		git_hash_unknown_update,
 		git_hash_unknown_final,
@@ -86,7 +85,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		"sha-1",
 		/* "sha1", big-endian */
 		0x73686131,
-		sizeof(git_SHA_CTX),
 		GIT_SHA1_RAWSZ,
 		GIT_SHA1_HEXSZ,
 		git_hash_sha1_init,
