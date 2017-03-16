Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FBEE20953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbdCPWJQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:09:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:45472 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbdCPWJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:09:16 -0400
Received: (qmail 2744 invoked by uid 109); 16 Mar 2017 22:09:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 22:09:15 +0000
Received: (qmail 7828 invoked by uid 111); 16 Mar 2017 22:09:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 18:09:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 18:09:12 -0400
Date:   Thu, 16 Mar 2017 18:09:12 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/5] Makefile: add USE_SHA1DC knob
Message-ID: <20170316220911.43zernzq643m5mmk@sigill.intra.peff.net>
References: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This knob lets you use the sha1dc implementation from:

      https://github.com/cr-marcstevens/sha1collisiondetection

which can detect certain types of collision attacks (even
when we only see half of the colliding pair). So it
mitigates any attack which consists of getting the "good"
half of a collision into a trusted repository, and then
later replacing it with the "bad" half. The "good" half is
rejected by the victim's version of Git (and even if they
run an old version of Git, any sha1dc-enabled git will
complain loudly if it ever has to interact with the object).

The big downside is that it's slower than either the openssl
or block-sha1 implementations.

Here are some timings based off of linux.git:

  - compute sha1 over whole packfile
      sha1dc: 3.580s
    blk-sha1: 2.046s (-43%)
     openssl: 1.335s (-62%)

  - rev-list --all --objects
      sha1dc: 33.512s
    blk-sha1: 33.514s (+0.0%)
     openssl: 33.650s (+0.4%)

  - git log --no-merges -10000 -p
      sha1dc: 8.124s
    blk-sha1: 7.986s (-1.6%)
     openssl: 8.203s (+0.9%)

  - index-pack --verify
      sha1dc: 4m19s
    blk-sha1: 2m57s (-32%)
     openssl: 2m19s (-42%)

So overall the sha1 computation with collision detection is
about 1.75x slower than block-sha1, and 2.7x slower than
sha1. But of course most operations do more than just sha1.
Normal object access isn't really slowed at all (both the
+/- changes there are well within the run-to-run noise); any
changes are drowned out by the other work Git is doing.

The most-affected operation is `index-pack --verify`, which
is essentially just computing the sha1 on every object. This
is similar to the `index-pack` invocation that the receiver
of a push or fetch would perform. So clearly there's some
extra CPU load here.

There will also be some latency for the user, though keep in
mind that such an operation will generally be network bound
(this is about a 1.2GB packfile). Some of that extra CPU is
"free" in the sense that we use it while the pack is
streaming in anyway. But most of it comes during the
delta-resolution phase, after the whole pack has been
received. So we can imagine that for this (quite large)
push, the user might have to wait an extra 100 seconds over
openssl (which is what we use now). If we assume they can
push to us at 20Mbit/s, that's 480s for a 1.2GB pack, which
is only 20% slower.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile      | 10 ++++++++++
 hash.h        |  2 ++
 sha1dc/sha1.c | 20 ++++++++++++++++++++
 sha1dc/sha1.h | 15 +++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/Makefile b/Makefile
index 9f9561147..0aa483890 100644
--- a/Makefile
+++ b/Makefile
@@ -140,6 +140,10 @@ all::
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
@@ -1383,6 +1387,11 @@ ifdef APPLE_COMMON_CRYPTO
 	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 endif
 
+ifdef USE_SHA1DC
+	LIB_OBJS += sha1dc/sha1.o
+	LIB_OBJS += sha1dc/ubc_check.o
+	BASIC_CFLAGS += -DSHA1_SHA1DC
+else
 ifdef BLK_SHA1
 	LIB_OBJS += block-sha1/sha1.o
 	BASIC_CFLAGS += -DSHA1_BLK
@@ -1400,6 +1409,7 @@ else
 endif
 endif
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/hash.h b/hash.h
index f0d9ddd0c..3760f436e 100644
--- a/hash.h
+++ b/hash.h
@@ -7,6 +7,8 @@
 #include <CommonCrypto/CommonDigest.h>
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
+#elif defined(SHA1_SHA1DC)
+#include "sha1dc/sha1.h"
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
 #endif
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 00760c352..3ce0a4f39 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -1786,3 +1786,23 @@ int SHA1DCFinal(unsigned char output[20], SHA1_CTX *ctx)
 	output[19] = (unsigned char)(ctx->ihv[4]);
 	return ctx->found_collision;
 }
+
+void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
+{
+	if (!SHA1DCFinal(hash, ctx))
+		return;
+	die("SHA-1 appears to be part of a collision attack: %s",
+	    sha1_to_hex(hash));
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
index 8a5bf0847..aa883df01 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -100,6 +100,21 @@ void SHA1DCUpdate(SHA1_CTX*, const char*, size_t);
 /* returns: 0 = no collision detected, otherwise = collision found => warn user for active attack */
 int  SHA1DCFinal(unsigned char[20], SHA1_CTX*); 
 
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
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.12.0.623.g86ec6c963

