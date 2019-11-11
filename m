Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ACC21F454
	for <e@80x24.org>; Mon, 11 Nov 2019 09:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKKJEN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 04:04:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:44348 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727166AbfKKJEM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 04:04:12 -0500
Received: (qmail 18248 invoked by uid 109); 11 Nov 2019 09:04:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 09:04:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4204 invoked by uid 111); 11 Nov 2019 09:07:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 04:07:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 04:04:11 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] hex: drop sha1_to_hex_r()
Message-ID: <20191111090411.GA12545@sigill.intra.peff.net>
References: <20191111090332.GA2275@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191111090332.GA2275@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no callers left; everybody uses oid_to_hex_r() or
hash_to_hex_algop_r(). This used to actually be the underlying
implementation for oid_to_hex_r(), but that's no longer the case since
47edb64997 (hex: introduce functions to print arbitrary hashes,
2018-11-14).

Let's get rid of it to de-clutter and to make sure nobody uses it.
Likewise we can drop the coccinelle rules that mention it, since the
compiler will make it quite clear that the code does not work.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h                            |  1 -
 contrib/coccinelle/object_id.cocci | 17 -----------------
 hex.c                              |  5 -----
 3 files changed, 23 deletions(-)

diff --git a/cache.h b/cache.h
index 04cabaac11..6a4eb221b3 100644
--- a/cache.h
+++ b/cache.h
@@ -1462,7 +1462,6 @@ int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
  *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
  */
 char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
-char *sha1_to_hex_r(char *out, const unsigned char *sha1);
 char *oid_to_hex_r(char *out, const struct object_id *oid);
 char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *);	/* static buffer result! */
 char *sha1_to_hex(const unsigned char *sha1);						/* same static buffer */
diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index 3e536a9834..6c0d21d8e2 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -25,23 +25,6 @@ struct object_id *OIDPTR;
 + oid_to_hex(OIDPTR)
   ...>}
 
-@@
-expression E;
-struct object_id OID;
-@@
-- sha1_to_hex_r(E, OID.hash)
-+ oid_to_hex_r(E, &OID)
-
-@@
-identifier f != oid_to_hex_r;
-expression E;
-struct object_id *OIDPTR;
-@@
-   f(...) {<...
-- sha1_to_hex_r(E, OIDPTR->hash)
-+ oid_to_hex_r(E, OIDPTR)
-  ...>}
-
 @@
 struct object_id OID;
 @@
diff --git a/hex.c b/hex.c
index 7850a8879d..8c3f06a192 100644
--- a/hex.c
+++ b/hex.c
@@ -90,11 +90,6 @@ char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
 	return buffer;
 }
 
-char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
-{
-	return hash_to_hex_algop_r(buffer, sha1, &hash_algos[GIT_HASH_SHA1]);
-}
-
 char *oid_to_hex_r(char *buffer, const struct object_id *oid)
 {
 	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
-- 
2.24.0.739.gb5632e4929

