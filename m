Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D3AC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 16:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiGGQTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiGGQS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 12:18:59 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AE72657C
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 09:18:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24FEA1ADF31;
        Thu,  7 Jul 2022 12:18:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GtCtFnbhrMeLo5KVxbrDD9tpjO8zJqJohTurGq
        CWuQY=; b=LiVCcq6G9xufXIGBg0bEGA/k7V8UlToIQFPLuaztgzSRQPrBhMJEU9
        6a5gmjkB/EDXRL3x6ZJyzZTy7e6qpjcZg7AyvSFNBJqDF659uWwE2/A6zD9SE5kc
        BSai59iapK0N9IREiSZsTtgSvedgaxZb3BxDnPy3hm4qmSwgyqTE8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D7F41ADF30;
        Thu,  7 Jul 2022 12:18:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C0AEA1ADF2E;
        Thu,  7 Jul 2022 12:18:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] sha256: add support for Nettle
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
        <xmqqedyyi11y.fsf@gitster.g> <xmqqilo94zc2.fsf@gitster.g>
        <xmqqpmih2zix.fsf@gitster.g>
Date:   Thu, 07 Jul 2022 09:18:52 -0700
In-Reply-To: <xmqqpmih2zix.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Jul 2022 23:43:50 -0700")
Message-ID: <xmqqk08o3ngz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E91B6A0-FE10-11EC-8309-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> FWIW, I needed the following to successfully build with
>> NETTLE_SHA256=YesPlease defined.  The final linkage step complained
>> about missing nettle_SHA256_{Init,Update,Final}() functions without
>> the tweak.
>> ...
>
> Another glitch.
> 
> As "make hdr-check" is pretty much indiscriminatory, my build failed
> on a box without libnettle-dev (hence /usr/include/nettle/sha2.h
> missing).
> ...

Taking all together, here is a copy I have in my tree right now (see
the range diff for what changed since your initial version).

Thanks.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From e8713290975d171764768bea99d686243e23ef8e Mon Sep 17 00:00:00 2001
From: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Tue, 5 Jul 2022 23:05:18 +0000
Subject: [PATCH] sha256: add support for Nettle

For SHA-256, we currently have support for OpenSSL and libgcrypt because
these two libraries contain optimized implementations that can take
advantage of native processor instructions.  However, OpenSSL is not
suitable for linking against for Linux distros due to licensing
incompatibilities with the GPLv2, and libgcrypt has been less favored
by cryptographers due to some security-related implementation issues.

Let's add another option that's compatible with the GPLv2, which is
Nettle, and give it preference over all others when Nettle and other
choices are possible.  It also has recently gained support for
Intel's SHA-NI instructions, which compare very favorably to other
implementations.  For example, using this implementation and SHA-1
DC on a machine with SHA-NI, hashing a 2 GiB file with SHA-1 takes
7.582 seconds, while hashing the same file with SHA-256 takes 2.278
seconds.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

1:  3bcd13c813 ! 1:  e871329097 sha256: add support for Nettle
    @@ Commit message
         by cryptographers due to some security-related implementation issues.
     
         Let's add another option that's compatible with the GPLv2, which is
    -    Nettle.  It also has recently gained support for Intel's SHA-NI
    -    instructions, which compare very favorably to other implementations.
    -    For example, using this implementation and SHA-1 DC on a machine with
    -    SHA-NI, hashing a 2 GiB file with SHA-1 takes 7.582 seconds, while
    -    hashing the same file with SHA-256 takes 2.278 seconds.
    +    Nettle, and give it preference over all others when Nettle and other
    +    choices are possible.  It also has recently gained support for
    +    Intel's SHA-NI instructions, which compare very favorably to other
    +    implementations.  For example, using this implementation and SHA-1
    +    DC on a machine with SHA-NI, hashing a 2 GiB file with SHA-1 takes
    +    7.582 seconds, while hashing the same file with SHA-256 takes 2.278
    +    seconds.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ Makefile: else
      
      ifdef SHA1_MAX_BLOCK_SIZE
      	LIB_OBJS += compat/sha1-chunked.o
    +@@ Makefile: $(SP_OBJ): %.sp: %.c %.o
    + sparse: $(SP_OBJ)
    + 
    + EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
    ++ifndef NETTLE_SHA256
    ++	EXCEPT_HDRS += sha256/nettle.h
    ++endif
    + ifndef GCRYPT_SHA256
    + 	EXCEPT_HDRS += sha256/gcrypt.h
    + endif
     
      ## hash.h ##
     @@
    @@ hash.h
     
      ## sha256/nettle.h (new) ##
     @@
    -+#ifndef SHA256_GCRYPT_H
    -+#define SHA256_GCRYPT_H
    ++#ifndef SHA256_NETTLE_H
    ++#define SHA256_NETTLE_H
     +
     +#include <nettle/sha2.h>
     +
     +typedef struct sha256_ctx nettle_SHA256_CTX;
     +
    -+inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
    ++static inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
     +{
     +	sha256_init(ctx);
     +}
     +
    -+inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx, const void *data, size_t len)
    ++static inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx, const void *data, size_t len)
     +{
     +	sha256_update(ctx, len, data);
     +}
     +
    -+inline void nettle_SHA256_Final(unsigned char *digest, nettle_SHA256_CTX *ctx)
    ++static inline void nettle_SHA256_Final(unsigned char *digest, nettle_SHA256_CTX *ctx)
     +{
     +	sha256_digest(ctx, SHA256_DIGEST_SIZE, digest);
     +}



 Makefile        | 10 ++++++++++
 hash.h          |  4 +++-
 sha256/nettle.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 sha256/nettle.h

diff --git a/Makefile b/Makefile
index 04d0fd1fe6..52a9f97997 100644
--- a/Makefile
+++ b/Makefile
@@ -182,6 +182,8 @@ include shared.mak
 #
 # Define BLK_SHA256 to use the built-in SHA-256 routines.
 #
+# Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
+#
 # Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
 #
 # Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
@@ -1842,6 +1844,10 @@ ifdef OPENSSL_SHA256
 	EXTLIBS += $(LIB_4_CRYPTO)
 	BASIC_CFLAGS += -DSHA256_OPENSSL
 else
+ifdef NETTLE_SHA256
+	BASIC_CFLAGS += -DSHA256_NETTLE
+	EXTLIBS += -lnettle
+else
 ifdef GCRYPT_SHA256
 	BASIC_CFLAGS += -DSHA256_GCRYPT
 	EXTLIBS += -lgcrypt
@@ -1850,6 +1856,7 @@ else
 	BASIC_CFLAGS += -DSHA256_BLK
 endif
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
@@ -3091,6 +3098,9 @@ $(SP_OBJ): %.sp: %.c %.o
 sparse: $(SP_OBJ)
 
 EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
+ifndef NETTLE_SHA256
+	EXCEPT_HDRS += sha256/nettle.h
+endif
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
diff --git a/hash.h b/hash.h
index 5d40368f18..ea87ae9d92 100644
--- a/hash.h
+++ b/hash.h
@@ -16,7 +16,9 @@
 #include "block-sha1/sha1.h"
 #endif
 
-#if defined(SHA256_GCRYPT)
+#if defined(SHA256_NETTLE)
+#include "sha256/nettle.h"
+#elif defined(SHA256_GCRYPT)
 #define SHA256_NEEDS_CLONE_HELPER
 #include "sha256/gcrypt.h"
 #elif defined(SHA256_OPENSSL)
diff --git a/sha256/nettle.h b/sha256/nettle.h
new file mode 100644
index 0000000000..8c93f29dda
--- /dev/null
+++ b/sha256/nettle.h
@@ -0,0 +1,28 @@
+#ifndef SHA256_NETTLE_H
+#define SHA256_NETTLE_H
+
+#include <nettle/sha2.h>
+
+typedef struct sha256_ctx nettle_SHA256_CTX;
+
+static inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
+{
+	sha256_init(ctx);
+}
+
+static inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx, const void *data, size_t len)
+{
+	sha256_update(ctx, len, data);
+}
+
+static inline void nettle_SHA256_Final(unsigned char *digest, nettle_SHA256_CTX *ctx)
+{
+	sha256_digest(ctx, SHA256_DIGEST_SIZE, digest);
+}
+
+#define platform_SHA256_CTX nettle_SHA256_CTX
+#define platform_SHA256_Init nettle_SHA256_Init
+#define platform_SHA256_Update nettle_SHA256_Update
+#define platform_SHA256_Final nettle_SHA256_Final
+
+#endif
-- 
2.37.0-211-gafcdf5f063

