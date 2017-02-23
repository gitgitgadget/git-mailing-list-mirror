Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9EE2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbdBWXGg (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:06:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:32972 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbdBWXGf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:06:35 -0500
Received: (qmail 26119 invoked by uid 109); 23 Feb 2017 23:06:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 23:06:24 +0000
Received: (qmail 9668 invoked by uid 111); 23 Feb 2017 23:06:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 18:06:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 18:06:21 -0500
Date:   Thu, 23 Feb 2017 18:06:21 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] Makefile: add USE_SHA1DC knob
Message-ID: <20170223230621.43anex65ndoqbgnf@sigill.intra.peff.net>
References: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This knob lets you use the sha1dc implementation from:

      https://github.com/cr-marcstevens/sha1collisiondetection

which can detect certain types of collision attacks (even
when we only see half of the colliding pair).

The big downside is that it's slower than either the openssl
or block-sha1 implementations.

Here are some timings based off of linux.git:

  - compute sha1 over whole packfile
    before: 1.349s
     after: 5.067s
    change: +275%

  - rev-list --all
    before: 5.742s
     after: 5.730s
    change: -0.2%

  - rev-list --all --objects
    before: 33.257s
     after: 33.392s
    change: +0.4%

  - index-pack --verify
    before: 2m20s
     after: 5m43s
    change: +145%

  - git log --no-merges -10000 -p
    before: 9.532s
     after: 9.683s
    change: +1.5%

So overall the sha1 computation is about 3-4x slower. But of
course most operations do more than just sha1. Accessing
commits and trees isn't slowed at all (both the +/- changes
there are well within the run-to-run noise). Accessing the
blobs is a little slower, but mostly drowned out by the cost
of things like actually generating patches.

The most-affected operation is `index-pack --verify`, which
is essentially just computing the sha1 on every object. It's
a bit worse than twice as slow, which means every push and
every fetch is going to experience that.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile      | 10 ++++++++++
 sha1dc/sha1.c | 22 ++++++++++++++++++++++
 sha1dc/sha1.h | 16 ++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Makefile b/Makefile
index 8e4081e06..7c4906250 100644
--- a/Makefile
+++ b/Makefile
@@ -142,6 +142,10 @@ all::
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
+# Define USE_SHA1DC to unconditionally enable the collision-detecting sha1
+# algorithm. This is slower, but may detect attempted collision attacks.
+# Takes priority over other *_SHA1 knobs.
+#
 # Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
 # in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
 # wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
@@ -1386,6 +1390,11 @@ ifdef APPLE_COMMON_CRYPTO
 	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 endif
 
+ifdef USE_SHA1DC
+	SHA1_HEADER = "sha1dc/sha1.h"
+	LIB_OBJS += sha1dc/sha1.o
+	LIB_OBJS += sha1dc/ubc_check.o
+else
 ifdef BLK_SHA1
 	SHA1_HEADER = "block-sha1/sha1.h"
 	LIB_OBJS += block-sha1/sha1.o
@@ -1403,6 +1412,7 @@ else
 endif
 endif
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 762c6fff8..1566ec4c7 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -1141,3 +1141,25 @@ int SHA1DCFinal(unsigned char output[20], SHA1_CTX *ctx)
 	output[19] = (unsigned char)(ctx->ihv[4]);
 	return ctx->found_collision;
 }
+
+static const char collision_message[] =
+"The SHA1 computation detected evidence of a collision attack;\n"
+"refusing to process the contents.";
+
+void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
+{
+	if (SHA1DCFinal(hash, ctx))
+		die(collision_message);
+}
+
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
+{
+	const char *data = vdata;
+	/* We expect an unsigned long, but sha1dc only takes an int */
+	while (len > INT_MAX) {
+		SHA1DCUpdate(ctx, data, INT_MAX);
+		data += INT_MAX;
+		len -= INT_MAX;
+	}
+	SHA1DCUpdate(ctx, data, len);
+}
diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
index ce5390397..1bb0ace99 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -90,3 +90,19 @@ void SHA1DCUpdate(SHA1_CTX*, const char*, unsigned);
 // obtain SHA-1 hash from SHA-1 context
 // returns: 0 = no collision detected, otherwise = collision found => warn user for active attack
 int  SHA1DCFinal(unsigned char[20], SHA1_CTX*); 
+
+
+/*
+ * Same as SHA1DCFinal, but convert collision attack case into a verbose die().
+ */
+void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
+
+/*
+ * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
+ */
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
+
+#define platform_SHA_CTX SHA1_CTX
+#define platform_SHA1_Init SHA1DCInit
+#define platform_SHA1_Update git_SHA1DCUpdate
+#define platform_SHA1_Final git_SHA1DCFinal
-- 
2.12.0.rc2.629.ga7951ed82
