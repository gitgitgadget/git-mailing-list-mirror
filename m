Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D42620951
	for <e@80x24.org>; Tue, 14 Mar 2017 20:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbdCNUow (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 16:44:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58107 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751201AbdCNUov (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 16:44:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB8E46C41B;
        Tue, 14 Mar 2017 16:44:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PxlQB0eXMex40Mcmsmvf0bnhcHM=; b=La/Adu
        +wwlTj3gSbvYstmFP4XUSR40fI77fmANZIQtvOzOkfBAEZd70fard78KDtw2DKqz
        VfTZVp3uwcxbD6OlE2Ta25SGR8VDOvNN/E6MlplhDtI2NJI9TSl/0A63yEwRumzu
        /LE9R6zxPwR8v/7zIPOL+/hxZ7cF2WaUM2Q8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rj3B26etVdzkbS8cIkNeYNTvCIaVycFL
        wCJLr8+gZoPmNmV6MU6S/1y1aboiDYOM/DALnghUWd31qd/g7YrC2yrp3ocv7MRj
        Ff7yJl5f17nPd98P8NIJKWGIFN6EehymGFptlqIUb4bCCXeJojEbRCIbdbgiezuq
        78F1YR0VyHQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D47B46C419;
        Tue, 14 Mar 2017 16:44:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 417236C418;
        Tue, 14 Mar 2017 16:44:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header file
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
        <20170314184126.GJ26789@aiede.mtv.corp.google.com>
        <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>
Date:   Tue, 14 Mar 2017 13:44:48 -0700
In-Reply-To: <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 14 Mar 2017 16:14:24 -0400")
Message-ID: <xmqq1stzio5b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10F948B0-08F7-11E7-83C0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, then I'll queue this.  The selection still goes to BASIC_CFLAGS
so the dependencies for re-compilation should be right, I'd think.

-- >8 --
From: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Sat, 11 Mar 2017 22:28:18 +0000
Subject: [PATCH] hash.h: move SHA-1 implementation selection into a header file

Many developers use functionality in their editors that allows for quick
syntax checks, including warning about questionable constructs.  This
functionality allows rapid development with fewer errors.  However, such
functionality generally does not allow the specification of
project-specific defines or command-line options.

Since the SHA1_HEADER include is not defined in such a case, developers
see spurious errors when using these tools.  Furthermore, while using a
macro as the argument to #include is permitted by C11, it isn't
permitted by C89 and C99, and there are known implementations which
reject it.

Instead of using SHA1_HEADER, create a hash.h header and use #if
and #elif to select the desired header.  Have the Makefile pass an
appropriate option to help the header select the right implementation to
use.

[jc: make BLK_SHA1 the fallback default as discussed on list,
e.g. <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>; also
remove SHA1_HEADER and SHA1_HEADER_SQ that are no longer used].

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 12 +++++-------
 cache.h  |  2 +-
 hash.h   | 14 ++++++++++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 8e4081e061..25c21f08b1 100644
--- a/Makefile
+++ b/Makefile
@@ -1387,19 +1387,19 @@ ifdef APPLE_COMMON_CRYPTO
 endif
 
 ifdef BLK_SHA1
-	SHA1_HEADER = "block-sha1/sha1.h"
 	LIB_OBJS += block-sha1/sha1.o
+	BASIC_CFLAGS += -DSHA1_BLK
 else
 ifdef PPC_SHA1
-	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
+	BASIC_CFLAGS += -DSHA1_PPC
 else
 ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
-	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
+	BASIC_CFLAGS += -DSHA1_APPLE
 else
-	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
+	BASIC_CFLAGS += -DSHA1_OPENSSL
 endif
 endif
 endif
@@ -1591,7 +1591,6 @@ endif
 
 # Shell quote (do not use $(call) to accommodate ancient setups);
 
-SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
 ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
 
@@ -1624,8 +1623,7 @@ PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
 # from the dependency list, that would make each entry appear twice.
 LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
 
-BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
-	$(COMPAT_CFLAGS)
+BASIC_CFLAGS += $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
 
 # Quote for C
diff --git a/cache.h b/cache.h
index 61fc86e6d7..f98c95bf2a 100644
--- a/cache.h
+++ b/cache.h
@@ -10,8 +10,8 @@
 #include "trace.h"
 #include "string-list.h"
 #include "pack-revindex.h"
+#include "hash.h"
 
-#include SHA1_HEADER
 #ifndef platform_SHA_CTX
 /*
  * platform's underlying implementation of SHA-1; could be OpenSSL,
diff --git a/hash.h b/hash.h
new file mode 100644
index 0000000000..f0d9ddd0c2
--- /dev/null
+++ b/hash.h
@@ -0,0 +1,14 @@
+#ifndef HASH_H
+#define HASH_H
+
+#if defined(SHA1_PPC)
+#include "ppc/sha1.h"
+#elif defined(SHA1_APPLE)
+#include <CommonCrypto/CommonDigest.h>
+#elif defined(SHA1_OPENSSL)
+#include <openssl/sha.h>
+#else /* SHA1_BLK */
+#include "block-sha1/sha1.h"
+#endif
+
+#endif
