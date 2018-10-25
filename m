Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DAFD1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 02:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJYLLM (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 07:11:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52390 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727418AbeJYLLL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Oct 2018 07:11:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 92D9E61B89;
        Thu, 25 Oct 2018 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540435229;
        bh=RTgQTJagmXdmVneV6JwwX5E8v6jOQZhyDfn5jS8LGMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vIVEOy633t9BB9OpnIhSI45s+CTk2c55gHc1tVmjlGA1h3BuPqDhNm0dyuxV/oMFu
         2HSj3pSNxjdl6BXWySXlUG4sSv+mNCGHBlSbMHPaTeKpPBIKjgOvjw/emulrxByU5T
         XhGG12LwG/mjtaDPM1AdZXavHGrCUZXzI1MRMDJgVzs21Osx5xvLzn+9TNaLE0jq3z
         Y8hZCiDlkbE5UOA9+DGAuppVi3OX4p4BqDMc6SlxVPhgrvz+MKU0VOqcyhSPqlp5UG
         NMbSTPoNvgRGEUzW9p1IL70/eIQvoY3kVq9+BBKfYYpYFAN56biEthFNXRIwGN90+m
         D10rStagtL2OpAQhDlHFj2cbGW7wYYu+65aH/gGgfb08303LzFHt4mth+eAVhsFWHv
         iRu/zrShp64QmgLrjMi5SGVdujyZNpPYsQXILlATE6cqFKmRfhQLd/TGN8CZPtAmhe
         So3fUafeOptCmKs/rWgT/a1ALfAUjd0XVbyITyTIEe/VqME/8RT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 12/12] hash: add an SHA-256 implementation using OpenSSL
Date:   Thu, 25 Oct 2018 02:40:05 +0000
Message-Id: <20181025024005.154208-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181025024005.154208-1-sandals@crustytoothpaste.net>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have OpenSSL routines available for SHA-1, so add routines
for SHA-256 as well.

On a Core i7-6600U, this SHA-256 implementation compares favorably to
the SHA1DC SHA-1 implementation:

SHA-1: 157 MiB/s (64 byte chunks); 337 MiB/s (16 KiB chunks)
SHA-256: 165 MiB/s (64 byte chunks); 408 MiB/s (16 KiB chunks)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile | 7 +++++++
 hash.h   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index 5a07e03100..36fd3a149b 100644
--- a/Makefile
+++ b/Makefile
@@ -183,6 +183,8 @@ all::
 #
 # Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
 #
+# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
+#
 # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
@@ -1638,6 +1640,10 @@ endif
 endif
 endif
 
+ifdef OPENSSL_SHA256
+	EXTLIBS += $(LIB_4_CRYPTO)
+	BASIC_CFLAGS += -DSHA256_OPENSSL
+else
 ifdef GCRYPT_SHA256
 	BASIC_CFLAGS += -DSHA256_GCRYPT
 	EXTLIBS += -lgcrypt
@@ -1645,6 +1651,7 @@ else
 	LIB_OBJS += sha256/block/sha256.o
 	BASIC_CFLAGS += -DSHA256_BLK
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/hash.h b/hash.h
index 2ef098052d..adde708cf2 100644
--- a/hash.h
+++ b/hash.h
@@ -17,6 +17,8 @@
 
 #if defined(SHA256_GCRYPT)
 #include "sha256/gcrypt.h"
+#elif defined(SHA256_OPENSSL)
+#include <openssl/sha.h>
 #else
 #include "sha256/block/sha256.h"
 #endif
