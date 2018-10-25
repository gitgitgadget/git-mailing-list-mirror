Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83181F453
	for <e@80x24.org>; Thu, 25 Oct 2018 02:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJYLLD (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 07:11:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52364 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727333AbeJYLLC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Oct 2018 07:11:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C09B461B77;
        Thu, 25 Oct 2018 02:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540435220;
        bh=yRvgtxvGTSzl/+jKMYcv4Wpdaj1EDryNpqg57rkcLq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Xj7elEIsIMm7Fv7zTqCkj12syM/Vr3SmmIl+g6K9wzaft6ZaGzq9ghTvNCa9reYQE
         FUa71pBNXL7FECdfkIQ+3rwWRDXUe6fG6ws8K+SlA7+rqem9MGFbesfLmzUHV0OH8y
         DTvGBWBRDe3MYyF/F4se35nTrAV0d2mOvtiz5maw+iQxfTMMnBAGEhQKCOlVg1jEaH
         +cH2wEH3xhT8MgFWDS5Py8h7oT2M0fqbUVcHkucG8qx/6dVIc75GQN50lxIIU6xXb7
         4yv4rKUcjlglkIBVCb9eOZQL8IPk5qn5S25MYZVLDCg99+x0WNqQeoEViDtNcR18B5
         WPCulK5wYi8yg9MNIRDQbOqmjq6eGYHoUna8FXxDy1rw/x6KmE1SpdRqSvXpxeZPtm
         qTrXrPepIry7aiEvfKIjL2a1gAXmdv1e5Oi9Y5H/5zfMRshhN2+kVKndN3NqbirwuP
         0Gib7qyHgfgOqJsZP6p8aIMD86KCIppWNK5zQmHcz23CkmWM5Or
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 06/12] t: make the sha1 test-tool helper generic
Date:   Thu, 25 Oct 2018 02:39:59 +0000
Message-Id: <20181025024005.154208-7-sandals@crustytoothpaste.net>
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
 copy t/helper/{test-sha1.c => test-hash.c} (65%)

diff --git a/Makefile b/Makefile
index d18ab0fe78..81dc9ac819 100644
--- a/Makefile
+++ b/Makefile
@@ -714,6 +714,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
+TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-json-writer.o
diff --git a/t/helper/test-sha1.c b/t/helper/test-hash.c
similarity index 65%
copy from t/helper/test-sha1.c
copy to t/helper/test-hash.c
index 1ba0675c75..0a31de66f3 100644
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
+		puts(hash_to_hex_algop(hash, algop));
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
index e4890566da..29ac7b0b0d 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -50,4 +50,6 @@ int cmd__windows_named_pipe(int argc, const char **argv);
 #endif
 int cmd__write_cache(int argc, const char **argv);
 
+int cmd_hash_impl(int ac, const char **av, int algo);
+
 #endif
