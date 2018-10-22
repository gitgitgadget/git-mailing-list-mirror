Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1713A1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 02:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeJVLAw (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 07:00:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51790 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727418AbeJVLAt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Oct 2018 07:00:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:65d4:dc3c:f6f5:933b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D4CDC61B82;
        Mon, 22 Oct 2018 02:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540176255;
        bh=RTgQTJagmXdmVneV6JwwX5E8v6jOQZhyDfn5jS8LGMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=EnI2Sjfx03vtihH9FzAOKrtMFXj/Hxwyy0a0fbe0Ufos7XMS536vqU2xz3EYE6+lU
         BjiWcJhCBfZ9zv4Z5JZR5dpPCMB4Bd1FFz07kozpMmftAZ+w1Cttpx9bUOZgqDE6Kz
         Ztt4FNBse7z22ovxNRniEBgHkh9UPN5wrMbyVmFJKnFgm7DEP+Ql444Hp0lpSVnQcN
         8fvarCkFr2/aj4SCshdLF2y8zZQa5Owy+mQerRckk2iiJHylwqNebkyFA9m85quZ/v
         il9+wKipMsjuBKqiD5mvEx1Y4bXNGoYBMnB9bNslIbEUovfXXLB8/jkFe/3sdAlwHs
         g+K6Dwic1HFbchDm7jNJzQ9jEXMpE204C3XcEI4URzo8EiMU9Ny2m9/9zbrxVC6znu
         I5jcql1yPIpLOoeaPRtQjg7uSvAD2x1n831wR6LlqRUi8MHIHMWNbwck1SLqXLVA7u
         R0i+ChhwbZVVQKSy0sKKybl5mQNMOcqUuOcdHszMqG7fwqLy/db
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 12/12] hash: add an SHA-256 implementation using OpenSSL
Date:   Mon, 22 Oct 2018 02:43:42 +0000
Message-Id: <20181022024342.489564-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181022024342.489564-1-sandals@crustytoothpaste.net>
References: <20181022024342.489564-1-sandals@crustytoothpaste.net>
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
