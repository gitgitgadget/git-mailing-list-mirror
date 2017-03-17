Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53EE320951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdCQRJo (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:09:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60849 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751023AbdCQRJn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:09:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACBC9750DB;
        Fri, 17 Mar 2017 13:09:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=F/6J
        a5OJ3DhN1BaqbNJNEGD3Pog=; b=KLn1cZu1H1J1sg2bdk9r9A75/15+lNRkTG/U
        //OmTF3pTNGJ4OoKib5TMOqOPQFbxMMhJuwKtIevgP+PUhVxiE5NCnVRymVSL6d7
        Hf/7G6ye0B/Y2ttI0q7YUd0Cm5SMN1h+Tm3orK3NDB2WJhGIiv39TFulWbSsSKZs
        D2xINcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        PEk7R2V4hY5Xja8HzaTmGOWc7xo0tCWV7ZFySDI0CbgnLX7YxsIxzdxNsvQwobDP
        oLb9vvGeuw3zXlNTofsMlY1kDbcsYbNjiu9qAgzwjYKI09vo+r48JSQfUa0lmS4X
        h8Ev54tRrfZbXv/TNAPYtdvlVgMHwlwg0Cx/vGse1VQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A511B750D9;
        Fri, 17 Mar 2017 13:09:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 072C2750D8;
        Fri, 17 Mar 2017 13:09:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] Makefile: add DC_SHA1 knob
Date:   Fri, 17 Mar 2017 10:09:36 -0700
Message-Id: <20170317170938.20593-2-gitster@pobox.com>
X-Mailer: git-send-email 2.12.0-317-g32c43f595f
In-Reply-To: <20170317170938.20593-1-gitster@pobox.com>
References: <20170317111814.tkzeqfyr3aiyxsxr@sigill.intra.peff.net>
 <20170317170938.20593-1-gitster@pobox.com>
X-Pobox-Relay-ID: 824DD1FE-0B34-11E7-9D4B-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile      | 10 ++++++++++
 hash.h        |  2 ++
 sha1dc/sha1.c | 20 ++++++++++++++++++++
 sha1dc/sha1.h | 15 +++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/Makefile b/Makefile
index 25c21f08b1..05a96d7177 100644
--- a/Makefile
+++ b/Makefile
@@ -142,6 +142,10 @@ all::
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
+# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
+# algorithm. This is slower, but may detect attempted collision attacks.
+# Takes priority over other *_SHA1 knobs.
+#
 # Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
 # in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
 # wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
@@ -1386,6 +1390,11 @@ ifdef APPLE_COMMON_CRYPTO
 	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 endif
 
+ifdef DC_SHA1
+	LIB_OBJS += sha1dc/sha1.o
+	LIB_OBJS += sha1dc/ubc_check.o
+	BASIC_CFLAGS += -DSHA1_DC
+else
 ifdef BLK_SHA1
 	LIB_OBJS += block-sha1/sha1.o
 	BASIC_CFLAGS += -DSHA1_BLK
@@ -1403,6 +1412,7 @@ else
 endif
 endif
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/hash.h b/hash.h
index f0d9ddd0c2..a11fc9233f 100644
--- a/hash.h
+++ b/hash.h
@@ -7,6 +7,8 @@
 #include <CommonCrypto/CommonDigest.h>
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
+#elif defined(SHA1_DC)
+#include "sha1dc/sha1.h"
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
 #endif
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 8ff2321dfb..6dd0da3608 100644
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
index 7d4d423b9d..bd8bd928fb 100644
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
2.12.0-317-g32c43f595f

