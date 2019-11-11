Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579D21F4C0
	for <e@80x24.org>; Mon, 11 Nov 2019 09:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKKJET (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 04:04:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:44354 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726829AbfKKJET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 04:04:19 -0500
Received: (qmail 18255 invoked by uid 109); 11 Nov 2019 09:04:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 09:04:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4215 invoked by uid 111); 11 Nov 2019 09:07:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 04:07:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 04:04:18 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] hex: drop sha1_to_hex()
Message-ID: <20191111090418.GB12545@sigill.intra.peff.net>
References: <20191111090332.GA2275@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191111090332.GA2275@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's only a single caller left of sha1_to_hex(), since everybody now
uses oid_to_hex() instead. This case is in the sha1dc wrapper, where we
print a hex sha1 when we find a collision. This one will always be sha1,
regardless of the current hash algorithm, so we can't use oid_to_hex()
here. In practice we'd probably not be running sha1 at all if it isn't
the current algorithm, but it's possible we might still occasionally
need to compute a sha1 in a post-sha256 world.

Since sha1_to_hex() is just a wrapper for hash_to_hex_algop(), let's
call that ourselves. There's value in getting rid of the sha1-specific
wrapper to de-clutter the global namespace, and to make sure nobody uses
it (and as with sha1_to_hex_r() in the previous patch, we'll drop the
coccinelle transformations, too).

The sha1_to_hex() function is mentioned in a comment; we can easily swap
that out for oid_to_hex() to give a better example. It's also mentioned
in some test vectors in t4100, but that's not runnable code, so there's
no point in trying to clean it up.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h                            |  3 +--
 contrib/coccinelle/object_id.cocci | 15 ---------------
 hex.c                              |  5 -----
 sha1dc_git.c                       |  2 +-
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index 6a4eb221b3..a2ab10503f 100644
--- a/cache.h
+++ b/cache.h
@@ -1459,12 +1459,11 @@ int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
  * The non-`_r` variant returns a static buffer, but uses a ring of 4
  * buffers, making it safe to make multiple calls for a single statement, like:
  *
- *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
+ *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
  */
 char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
 char *oid_to_hex_r(char *out, const struct object_id *oid);
 char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *);	/* static buffer result! */
-char *sha1_to_hex(const unsigned char *sha1);						/* same static buffer */
 char *hash_to_hex(const unsigned char *hash);						/* same static buffer */
 char *oid_to_hex(const struct object_id *oid);						/* same static buffer */
 
diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index 6c0d21d8e2..ddf4f22bd7 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -10,21 +10,6 @@ struct object_id *OIDPTR;
 - is_null_sha1(OIDPTR->hash)
 + is_null_oid(OIDPTR)
 
-@@
-struct object_id OID;
-@@
-- sha1_to_hex(OID.hash)
-+ oid_to_hex(&OID)
-
-@@
-identifier f != oid_to_hex;
-struct object_id *OIDPTR;
-@@
-  f(...) {<...
-- sha1_to_hex(OIDPTR->hash)
-+ oid_to_hex(OIDPTR)
-  ...>}
-
 @@
 struct object_id OID;
 @@
diff --git a/hex.c b/hex.c
index 8c3f06a192..fd7f00c43f 100644
--- a/hex.c
+++ b/hex.c
@@ -103,11 +103,6 @@ char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *a
 	return hash_to_hex_algop_r(hexbuffer[bufno], hash, algop);
 }
 
-char *sha1_to_hex(const unsigned char *sha1)
-{
-	return hash_to_hex_algop(sha1, &hash_algos[GIT_HASH_SHA1]);
-}
-
 char *hash_to_hex(const unsigned char *hash)
 {
 	return hash_to_hex_algop(hash, the_hash_algo);
diff --git a/sha1dc_git.c b/sha1dc_git.c
index e0cc9d988c..5c300e812e 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -19,7 +19,7 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
 	if (!SHA1DCFinal(hash, ctx))
 		return;
 	die("SHA-1 appears to be part of a collision attack: %s",
-	    sha1_to_hex(hash));
+	    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
 }
 
 /*
-- 
2.24.0.739.gb5632e4929
