Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA91201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 22:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755426AbdCKW2a (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 17:28:30 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:44378 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753882AbdCKW23 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Mar 2017 17:28:29 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 92F9A280AD
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489271307;
        bh=DbdqChBWCM8pathyeWCVuvAqzFRrnW9r/0ZqN6cJvTM=;
        h=From:To:Subject:Date:From;
        b=HO3QUXFed8pz0j5FuYXYjPls+4sv1Gh74rMpaoUsh8bwJFz3rr9cQmSGFOxvql2hK
         g3g/cNhpPYv6Jzk/62VBaoFdL9zA2IDeY7PJMXEBtvdWIXgIIWiNityUpirvx4seou
         qeY7IOANFpVl64Hbyh1HjlLrK3AWk/HjUCTbT2NggWrQJCH95/5RbYgbxTUyxv0TaQ
         dANC6qWXv/0TlEU6TY56Xx9N+fCNFpz093UDivukjK0tsv0arhTHhkvpKxS43sTplR
         BMSouRJGtRjT5N076Y7apwqlNLIDKFXted+3Zn9FIHL5H7ZlvU5lAGeKynDHSHgujI
         t8Ral1UIxpFsu+yD5Mf8ue41jqw+73j1rOSKO8gIdQcfhqHKn8Ov6rkBKPVDZQ1OXn
         twmOBFOnp04DXpMVQDwvBn6hsk7F6Dwbub4qgQZZVQx8hx3fEFIVWXJGT7anMaPl2B
         oCR2VeoE2yq9OnPyP8ihJfpHEaUy8IuoecfeDLzRpSmXyLTkefb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH] Move SHA-1 implementation selection into a header file
Date:   Sat, 11 Mar 2017 22:28:18 +0000
Message-Id: <20170311222818.518541-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---

Fixing this makes my development using the vim-ale plugin much nicer.  I
don't care which implementation is selected by default, as long as
*some* implementation is selected by default.

I called this "hash.h" instead of "sha1.h" to allow for future hash
function extensions.  I was worried that some OS might define a hash.h
header as well, but the use of quotation marks instead of angle brackets
should cause it to look in the current directory first.

I also picked "SHA1_*" instead of "*_SHA1" as it makes it easier to find
all the constants.

 Makefile |  8 ++++----
 cache.h  |  2 +-
 hash.h   | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)
 create mode 100644 hash.h

diff --git a/Makefile b/Makefile
index ed68700acb..244eb6a0f2 100644
--- a/Makefile
+++ b/Makefile
@@ -1384,19 +1384,19 @@ ifdef APPLE_COMMON_CRYPTO
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
diff --git a/cache.h b/cache.h
index 283ab8fb40..6a9afb8561 100644
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
index 0000000000..7c6b52835c
--- /dev/null
+++ b/hash.h
@@ -0,0 +1,14 @@
+#ifndef HASH_H
+#define HASH_H
+
+#if defined(SHA1_BLK)
+#include "block-sha1/sha1.h"
+#elif defined(SHA1_PPC)
+#include "ppc/sha1.h"
+#elif defined(SHA1_APPLE)
+#include <CommonCrypto/CommonDigest.h>
+#else /* SHA1_OPENSSL */
+#include <openssl/sha.h>
+#endif
+
+#endif
