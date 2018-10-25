Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D1C1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 02:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeJYLLF (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 07:11:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727221AbeJYLLD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Oct 2018 07:11:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C752F61B7D;
        Thu, 25 Oct 2018 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540435221;
        bh=eq6uz2zRn1FRia7VIpcK09IaJzAI1LgMumjeI1hEKmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FFgsAq9Sz2qnwWTxbmPVA+OGCXU7chys99sA99Cbnu36xngadtFM95v3Cv4vYADJ1
         5pvBRNM8CwfMKcgxk0GhmtqB/V4OZK4QG7BiRpmAylIexWa5ZNKNUZ2BjuTFJSF6EN
         GmCgMq899140FW8ti8q4JSnqwleiVhqVmMZ9vI6z2dEIjroZeoKaLgKPdNFOyeRgTU
         NjOA/0o1qb8R7wxReVMI8QZEFgu8R+L9ZtHf2M/lXw5vxaCjZDZ7cgQXFZVH2OAslS
         EBP8k0LrjhlygpVvKFs00gzRAZ2NiDV2Uluta2EKkTpd9pk0QQwL3NWrN9BJ5X3ndF
         v80XjBUIB5C8AItpWodSFLXiltPcuqXrSGQm5TJFLFQb8+0sCkxgS822JiE1bvDqTl
         65L/RbzJbfNdgcaZ7u9WQ2iVpGtZiuqziWvCW7C7mvTZa5V2kUKwRafTVuOQ9oCscL
         axAiWYR3pMSHszzltcw3rpC4I5TSWl/ocng0KOSNpO8U2ruaEuM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 07/12] sha1-file: add a constant for hash block size
Date:   Thu, 25 Oct 2018 02:40:00 +0000
Message-Id: <20181025024005.154208-8-sandals@crustytoothpaste.net>
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

There is one place we need the hash algorithm block size: the HMAC code
for push certs.  Expose this constant in struct git_hash_algo and expose
values for SHA-1 and for the largest value of any hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 4 ++++
 hash.h      | 3 +++
 sha1-file.c | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/cache.h b/cache.h
index bab8e8964f..9e5d1dd85a 100644
--- a/cache.h
+++ b/cache.h
@@ -45,10 +45,14 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 /* The length in bytes and in hex digits of an object name (SHA-1 value). */
 #define GIT_SHA1_RAWSZ 20
 #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
+/* The block size of SHA-1. */
+#define GIT_SHA1_BLKSZ 64
 
 /* The length in byte and in hex digits of the largest possible hash value. */
 #define GIT_MAX_RAWSZ GIT_SHA1_RAWSZ
 #define GIT_MAX_HEXSZ GIT_SHA1_HEXSZ
+/* The largest possible block size for any supported hash. */
+#define GIT_MAX_BLKSZ GIT_SHA1_BLKSZ
 
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
diff --git a/hash.h b/hash.h
index 80881eea47..1bcf7ab6fd 100644
--- a/hash.h
+++ b/hash.h
@@ -81,6 +81,9 @@ struct git_hash_algo {
 	/* The length of the hash in hex characters. */
 	size_t hexsz;
 
+	/* The block size of the hash. */
+	size_t blksz;
+
 	/* The hash initialization function. */
 	git_hash_init_fn init_fn;
 
diff --git a/sha1-file.c b/sha1-file.c
index 7e9dedc744..9bdd04ea45 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -90,6 +90,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		0x00000000,
 		0,
 		0,
+		0,
 		git_hash_unknown_init,
 		git_hash_unknown_update,
 		git_hash_unknown_final,
@@ -102,6 +103,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		0x73686131,
 		GIT_SHA1_RAWSZ,
 		GIT_SHA1_HEXSZ,
+		GIT_SHA1_BLKSZ,
 		git_hash_sha1_init,
 		git_hash_sha1_update,
 		git_hash_sha1_final,
