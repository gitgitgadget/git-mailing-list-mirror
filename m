Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65151F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeH2Ex0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:53:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37324 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727099AbeH2ExZ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:53:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EA3026075D
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504350;
        bh=5eQlKbZycKAyYrxXZPyTCbyhR8Nmq/SV08XNW9pLLtQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=vEehO5QaKiKnVymOnMNqRlGB1oskPQCElwvHvOsCeANKf7OsK1pBWza+iR+x7OKaN
         b7u455MPzYdJgfScAotQyvcdafAssqhLbH6aogXcNINeIWliaMzFriC6UA/Lt3YvXD
         nX3L8YNkaiIYms8WL3J1bGMu0e6x1WqXREkPrMTsLXSbafei1PATz5OMCEk3leOytG
         4V4ORBjPKFXfBaqwLtV4c629eJW2TpxhbKPNpXTfjgLaKCXhtXyOkf0NtduagBh+qt
         4bBoIzurv9CF5kNLE0ziiY/G8+pXYlzc9RpphvwnG0m5rw3DMGjh/kO7NyuR43PHZm
         dMgYOHrSis32LKFGnMFYSMXS+2qJJsnenKWZQQet3Ytwkbz8eH8qJc8ojz1vxUxZP3
         EhadNjRo1GBSbArwCPGnz/DArJWrmJcfutY48TrWGZUdghdFwX6mLsJ71zoQB4e8J9
         qeYmI4quVxY9Gf/x6WAZeNnAWf/0zSajC6QMKnBafo8N55XvF0C
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 06/12] sha1-file: add a constant for hash block size
Date:   Wed, 29 Aug 2018 00:58:51 +0000
Message-Id: <20180829005857.980820-7-sandals@crustytoothpaste.net>
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
index 3cb953445c..c1b5a7a337 100644
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
index 90f4344619..46dff69eb3 100644
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
index f6976b179f..a1ad1b8268 100644
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
