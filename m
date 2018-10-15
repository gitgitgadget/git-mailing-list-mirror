Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0718F1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 02:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeJOKCa (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 06:02:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50760 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbeJOKC3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 06:02:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6E21261B82;
        Mon, 15 Oct 2018 02:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539569960;
        bh=/3RJHTWb2H6ef+TSidJppObUyplD9azMI9l4Hu8vh+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uhStilCiEmak/c/Ysdkev1ddZ6F9ms1luNPBvSN6kVWed7esHRWYGJ98gWTpnocnP
         ezcWcKpcjsOiFcvBnMSG85PlPYgG1JkrvvuPiXJqgCALl0vm7MpLqRd6qyT7I675Ta
         J88/n1EffAVqW39cUa+8/7iI2dl/dfXPXdUv53c4iQF1aCTriyyBltDaiA0utEhIIc
         Vo1FP2ZdEDfoUyg6qeOAHhDZYbgie3zHh67JL/FiaRHJsiQ1bueoDg2VlqZlS36KQx
         xSixBYIPAFFWuBjup/AMZD2tHswekiVeYtqjjehVBV5OMV2yfUNQZBs3PbljpLoeLO
         pWpaZubz9Up2wLjbJcZnF/fiiNh4Hryjsw3OAHm00pF29m1pO6gt8yz2Bhl+eAJb+M
         KR/WBKHV9tkNOWqH6lDYmJ8BeqcQJ40iydG+xg2RR4EPK+mjws6jURLPlDsmvcEqgw
         Qi8tgPElWTWnL9Dr4KRigXZBgYIavoAULeegk1u/xU+Hk8h5pnK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/13] hash: add an SHA-256 implementation using OpenSSL
Date:   Mon, 15 Oct 2018 02:18:59 +0000
Message-Id: <20181015021900.1030041-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have OpenSSL routines available for SHA-1, so add routines
for SHA-256 as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile | 7 +++++++
 hash.h   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index 3d91555a81..3164e2aeee 100644
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
index 9df562f2f6..9df06d56b4 100644
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
