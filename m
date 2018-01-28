Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E331F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeA1P5i (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:57:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58382 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751963AbeA1P5e (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:57:34 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2FF2C60FBD;
        Sun, 28 Jan 2018 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517155053;
        bh=LRZeHrz3zS3x9FLviB8PG/8RY4uHAhIhQPa4TnBeaXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FU7SWvw2ZHMV+OifsTt5rqz6zdHstNqpL62lMErjlu4bE95UCsPcKzZI0FgvgaxuP
         bYQf4FtJPg+aMCcpUZcS5ZTUqPl4Mn6b0yGbpOafCpx0QosKPNoM4PN20K2MYjZYlG
         bM0wNehBn7/d/55mqBMKfLU/B9ncxfeqSOl5ksel16GmL1Fujpmph+gUAFiSToTqjE
         IjUzmo+vKfk5Nv3CdV7rVWhT1MRmOXikvNUORBsLqnD9vBhmx4k4sOs+WY+pWy7pGK
         xI72xuuvMEp0Lfqgu8LFZ+M/XvnuoRhbuPvJDPOEWpqq4v6o7J+JCfg7fMyyCEc1Q5
         ZSD9uYpn66++Wt0hpAJCN58+KYnxWb2py10eau7h9udvz83r5mCPxTo1lVk6jBgyKH
         +Z0y8KOhm0iIh7FWguJ02hklvtt2Y2uKxeqfhWWtcMrL9/a19GPMBuO/f6zJHQ8eeU
         HAZLN3nbUXifISlyA+rZ4IOqlZFie+wIoaKtd4RBaU33D547kO/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 02/12] hash: create union for hash context allocation
Date:   Sun, 28 Jan 2018 15:57:12 +0000
Message-Id: <20180128155722.880805-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180128155722.880805-1-sandals@crustytoothpaste.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
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
the stack and a typedef for ease of use.  Remove the ctxsz element for
struct git_hash_algo, which is no longer very useful.

This does mean that stack allocations will grow slightly as additional
hash functions are added, but this should not be a significant problem,
since we don't allocate many hash contexts.  The improved usability and
benefits from avoiding dynamic allocation outweigh this small downside.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h      | 9 ++++++---
 sha1_file.c | 2 --
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hash.h b/hash.h
index 7122dea7b3..365846a6b5 100644
--- a/hash.h
+++ b/hash.h
@@ -55,6 +55,12 @@
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA1 + 1)
 
+/* A suitably aligned type for stack allocations of hash contexts. */
+union git_hash_ctx {
+	git_SHA_CTX sha1;
+};
+typedef union git_hash_ctx git_hash_ctx;
+
 typedef void (*git_hash_init_fn)(void *ctx);
 typedef void (*git_hash_update_fn)(void *ctx, const void *in, size_t len);
 typedef void (*git_hash_final_fn)(unsigned char *hash, void *ctx);
@@ -69,9 +75,6 @@ struct git_hash_algo {
 	/* A four-byte version identifier, used in pack indices. */
 	uint32_t format_id;
 
-	/* The size of a hash context (e.g. git_SHA_CTX). */
-	size_t ctxsz;
-
 	/* The length of the hash in binary. */
 	size_t rawsz;
 
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..e61d93a6e8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
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
