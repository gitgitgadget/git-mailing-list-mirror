Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196B91F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeH2Ex0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:53:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37322 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbeH2ExZ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:53:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5C95C6075B
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504349;
        bh=Zpgd2drTN2e+5CC7oiIMMx96g4bx5XosV+DvSHjKESo=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=W4ievECy2SWdXJde29LSpaHCTXrk7KqZ5sZUBdhk8F3SZtt/MJ+IrW+mKkvIsPOcB
         TqqhvLCevMqWqWOlEdg63NOginwQFEtCFV1ny0SMwBtPJGdbUAJLy7Y5P9T52pnI7F
         ezwOhJtso32LqKXC+42aF6lIDUSgxZdmQ/fBO0YlLP/NwvKWKo40Ibyn+M62UnmOm3
         QzOBpBYUtLT2Yi98WMc7Xn6XYi1khLV6AXlM1Yacw30mhthl63sysCA7bdyR9ODmRv
         QEyU0yKkCBL2ZnLaubDaSCXoDAWpzcVrdbQDxIFRpkJg1QNIH50LMn357RPLOkOre0
         bVHSG5Dcq16D3h74HX1t3Vmwl5fY0inI8OV99B4VjuZbNZM5t6GhiaqVbt2Pl86ogX
         gH4pdBYbAC4Wqv7ZIq7IxeSpw2ZmYTJaUheT5+VPS3xpPjpBuDlTQHuJTkZW52ZDoh
         icagJupV4rixr+mkwBTL1VacY/G11Xd/9sGX46im1RN6tsKIhnE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 05/12] t: make the sha1 test-tool helper generic
Date:   Wed, 29 Aug 2018 00:58:50 +0000
Message-Id: <20180829005857.980820-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005857.980820-1-sandals@crustytoothpaste.net>
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we're going to have multiple hash algorithms to test, it makes
sense to share as much of the test code as possible.  Convert the sha1
helper for the test-tool to be generic and move it out into its own
module.  This will allow us to share most of this code with our NewHash
implementation.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile                              |  1 +
 t/helper/{test-sha1.c => test-hash.c} | 19 +++++-----
 t/helper/test-sha1.c                  | 52 +--------------------------
 t/helper/test-tool.h                  |  2 ++
 4 files changed, 14 insertions(+), 60 deletions(-)
 copy t/helper/{test-sha1.c => test-hash.c} (66%)

diff --git a/Makefile b/Makefile
index 5a969f5830..eb1a080cc9 100644
--- a/Makefile
+++ b/Makefile
@@ -712,6 +712,7 @@ TEST_BUILTINS_OBJS += test-dump-cache-tree.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
+TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-json-writer.o
diff --git a/t/helper/test-sha1.c b/t/helper/test-hash.c
similarity index 66%
copy from t/helper/test-sha1.c
copy to t/helper/test-hash.c
index 1ba0675c75..9992de2212 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-hash.c
@@ -1,13 +1,14 @@
 #include "test-tool.h"
 #include "cache.h"
 
-int cmd__sha1(int ac, const char **av)
+int cmd_hash_impl(int ac, const char **av, int algo)
 {
-	git_SHA_CTX ctx;
-	unsigned char sha1[20];
+	git_hash_ctx ctx;
+	unsigned char hash[GIT_MAX_HEXSZ];
 	unsigned bufsz = 8192;
 	int binary = 0;
 	char *buffer;
+	const struct git_hash_algo *algop = &hash_algos[algo];
 
 	if (ac == 2) {
 		if (!strcmp(av[1], "-b"))
@@ -26,7 +27,7 @@ int cmd__sha1(int ac, const char **av)
 			die("OOPS");
 	}
 
-	git_SHA1_Init(&ctx);
+	algop->init_fn(&ctx);
 
 	while (1) {
 		ssize_t sz, this_sz;
@@ -38,20 +39,20 @@ int cmd__sha1(int ac, const char **av)
 			if (sz == 0)
 				break;
 			if (sz < 0)
-				die_errno("test-sha1");
+				die_errno("test-hash");
 			this_sz += sz;
 			cp += sz;
 			room -= sz;
 		}
 		if (this_sz == 0)
 			break;
-		git_SHA1_Update(&ctx, buffer, this_sz);
+		algop->update_fn(&ctx, buffer, this_sz);
 	}
-	git_SHA1_Final(sha1, &ctx);
+	algop->final_fn(hash, &ctx);
 
 	if (binary)
-		fwrite(sha1, 1, 20, stdout);
+		fwrite(hash, 1, algop->rawsz, stdout);
 	else
-		puts(sha1_to_hex(sha1));
+		puts(hash_to_hex_algo(hash, algo));
 	exit(0);
 }
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index 1ba0675c75..d860c387c3 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -3,55 +3,5 @@
 
 int cmd__sha1(int ac, const char **av)
 {
-	git_SHA_CTX ctx;
-	unsigned char sha1[20];
-	unsigned bufsz = 8192;
-	int binary = 0;
-	char *buffer;
-
-	if (ac == 2) {
-		if (!strcmp(av[1], "-b"))
-			binary = 1;
-		else
-			bufsz = strtoul(av[1], NULL, 10) * 1024 * 1024;
-	}
-
-	if (!bufsz)
-		bufsz = 8192;
-
-	while ((buffer = malloc(bufsz)) == NULL) {
-		fprintf(stderr, "bufsz %u is too big, halving...\n", bufsz);
-		bufsz /= 2;
-		if (bufsz < 1024)
-			die("OOPS");
-	}
-
-	git_SHA1_Init(&ctx);
-
-	while (1) {
-		ssize_t sz, this_sz;
-		char *cp = buffer;
-		unsigned room = bufsz;
-		this_sz = 0;
-		while (room) {
-			sz = xread(0, cp, room);
-			if (sz == 0)
-				break;
-			if (sz < 0)
-				die_errno("test-sha1");
-			this_sz += sz;
-			cp += sz;
-			room -= sz;
-		}
-		if (this_sz == 0)
-			break;
-		git_SHA1_Update(&ctx, buffer, this_sz);
-	}
-	git_SHA1_Final(sha1, &ctx);
-
-	if (binary)
-		fwrite(sha1, 1, 20, stdout);
-	else
-		puts(sha1_to_hex(sha1));
-	exit(0);
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA1);
 }
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e954e8c522..9026a8f608 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -41,4 +41,6 @@ int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
 int cmd__write_cache(int argc, const char **argv);
 
+int cmd_hash_impl(int ac, const char **av, int algo);
+
 #endif
