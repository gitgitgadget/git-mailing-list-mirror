Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD50C1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfFTHls (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:45492 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726732AbfFTHlr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:47 -0400
Received: (qmail 16771 invoked by uid 109); 20 Jun 2019 07:41:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13047 invoked by uid 111); 20 Jun 2019 07:42:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:45 -0400
Date:   Thu, 20 Jun 2019 03:41:45 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 16/17] hash.h: move object_id definition from cache.h
Message-ID: <20190620074145.GP3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our hashmap.h helpfully defines a sha1hash() function. But it cannot
define a similar oidhash() without including all of cache.h, which
itself wants to include hashmap.h! Let's break this circular dependency
by moving the definition to hash.h, along with the remaining RAWSZ
macros, etc. That will put them with the existing git_hash_algo
definition.

One alternative would be to move oidhash() into cache.h, but it's
already quite bloated. We're better off moving things out than in.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h | 24 ------------------------
 hash.h  | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/cache.h b/cache.h
index bf20337ef4..37e0b82064 100644
--- a/cache.h
+++ b/cache.h
@@ -43,30 +43,6 @@ int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
 unsigned long git_deflate_bound(git_zstream *, unsigned long);
 
-/* The length in bytes and in hex digits of an object name (SHA-1 value). */
-#define GIT_SHA1_RAWSZ 20
-#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
-/* The block size of SHA-1. */
-#define GIT_SHA1_BLKSZ 64
-
-/* The length in bytes and in hex digits of an object name (SHA-256 value). */
-#define GIT_SHA256_RAWSZ 32
-#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
-/* The block size of SHA-256. */
-#define GIT_SHA256_BLKSZ 64
-
-/* The length in byte and in hex digits of the largest possible hash value. */
-#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
-#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
-/* The largest possible block size for any supported hash. */
-#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
-
-struct object_id {
-	unsigned char hash[GIT_MAX_RAWSZ];
-};
-
-#define the_hash_algo the_repository->hash_algo
-
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
diff --git a/hash.h b/hash.h
index 661c9f2281..52a4f1a3f4 100644
--- a/hash.h
+++ b/hash.h
@@ -139,4 +139,28 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 	return p - hash_algos;
 }
 
+/* The length in bytes and in hex digits of an object name (SHA-1 value). */
+#define GIT_SHA1_RAWSZ 20
+#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
+/* The block size of SHA-1. */
+#define GIT_SHA1_BLKSZ 64
+
+/* The length in bytes and in hex digits of an object name (SHA-256 value). */
+#define GIT_SHA256_RAWSZ 32
+#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
+/* The block size of SHA-256. */
+#define GIT_SHA256_BLKSZ 64
+
+/* The length in byte and in hex digits of the largest possible hash value. */
+#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
+#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
+/* The largest possible block size for any supported hash. */
+#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
+
+struct object_id {
+	unsigned char hash[GIT_MAX_RAWSZ];
+};
+
+#define the_hash_algo the_repository->hash_algo
+
 #endif
-- 
2.22.0.732.g5402924b4b

