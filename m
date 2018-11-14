Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490D61F97E
	for <e@80x24.org>; Wed, 14 Nov 2018 04:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbeKNOLr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:11:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54410 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbeKNOLp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 09:11:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D8BBB60FE0;
        Wed, 14 Nov 2018 04:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542168619;
        bh=7RbrEqzjD5ck8zRjGxKcU98+UlK6Y7BjXyfI2NXXrVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BhrCApEWEpoe2QEt5bgf9DeZUSszL/Kk8atrdyLQZh6WVFSMj3SlBkHdas+K4fvWg
         dq6ErLyZ26rd/+JqIsDjBdS2mYUGKfxP4i85wiU7XJapVYIipLBy2UU6pPZ8Ci0/Vi
         f/83xo3gtS8gN/lKeI3wVccmUi5ixnhkQHNP+9tfDkoe1vumyCfj34Kag1xk2FMqrA
         zKabWj9Ia8RUozL3uq+W2e0c9pE/lIcFbTWNgTsXrmO0O5Fr6YJ0WmLml5+dF0vouV
         vPJYzanAMYDm/pMc9LjCOSSe0uUQCM6npleeCP9LyqqtMDP5Gj0s1mPUYtoQwd4mSq
         QcgDDah5f6LLdRQyD/w7YQJWO9wap0V58fgaF45EFSNeblPcxyLXnKfJeSFpbzsrPU
         2k+t5UCmWbD53WmAJ/NdTahmg4q+Oqf85hJ9SE2CgL1RCD4DkvsKhx4bGqGDG4j0Iv
         glNHJC6LfXuXbSNWr86Tq6wXeFXlVsHbTxvbxZoT+bAPVWCpvAa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 06/12] t: make the sha1 test-tool helper generic
Date:   Wed, 14 Nov 2018 04:09:32 +0000
Message-Id: <20181114040938.517289-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245
In-Reply-To: <20181114040938.517289-1-sandals@crustytoothpaste.net>
References: <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181114040938.517289-1-sandals@crustytoothpaste.net>
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
index 016fdcdb81..daf0b198ec 100644
--- a/Makefile
+++ b/Makefile
@@ -724,6 +724,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
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
index 042f12464b..b5b7712a1d 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -51,4 +51,6 @@ int cmd__windows_named_pipe(int argc, const char **argv);
 #endif
 int cmd__write_cache(int argc, const char **argv);
 
+int cmd_hash_impl(int ac, const char **av, int algo);
+
 #endif
