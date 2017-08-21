Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD94720899
	for <e@80x24.org>; Mon, 21 Aug 2017 00:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbdHUAAk (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 20:00:40 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57056 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753428AbdHUAAb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Aug 2017 20:00:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9AE07280AD
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1503273630;
        bh=UT6QxpFt7CtRhct3jzMaQdTcxF0FYjk/C8k6XAu7cOo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AdBtABCVEqsE8q/4dnqFCsrl7SCE6BJhr+WqN/3D9u1ZOhDX8QDxflTDiw1cYzsek
         9nTBGKqntWoSq8xkP1Ww0q7GZQDFaVhBBvkygQJJyqBGSwEDYelUvAhmExOBxJxrX8
         u9VrTbRKT1zgWl3Q/WnwVV2peKnMD8mRMN9O9rDLxqqs/BU8f1lALbK9QhCS3jsdzH
         WcPAK7h5E+sp4GywVD8OHHHN2p85I5vd9Hvoqm1iBiBt8Bu8onDEsZQg5qIMtSNDx2
         /eNn5jIkfDJZbvZq1MmoI2iK5G7KJ/uYJRfOtPOQKJrkhHSyJOoZHHvzDUS4zR3tNP
         uWQ0dAmCnaTrNEX5HrqcWG0Ft9q5Rdp+y6r6/a5eWV3+xxd6zcqDDHQXkYsB+mms7J
         1NoRVRL8wpMGmLKHjk8+AfENZ6eV0b/BRUaNQCkUF8yMNUYbIDUtqsRgBLIdXau51z
         hpx5oHfgab/DwW1xV3JOkdVV/PmD+euyWvdOgr8UDqCK2jTWbxQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 4/6] Add structure representing hash algorithm
Date:   Mon, 21 Aug 2017 00:00:20 +0000
Message-Id: <20170821000022.26729-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <20170821000022.26729-1-sandals@crustytoothpaste.net>
References: <20170821000022.26729-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since in the future we want to support an additional hash algorithm, add
a structure that represents a hash algorithm and all the data that must
go along with it.  Add a constant to allow easy enumeration of hash
algorithms.  Implement function typedefs to create an abstract API that
can be used by any hash algorithm, and wrappers for the existing SHA1
functions that conform to this API.

Don't include an entry in the hash algorithm structure for the null
object ID.  As this value is all zeros, any suitably sized all-zero
object ID can be used, and there's no need to store a given one on a
per-hash basis.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 36 ++++++++++++++++++++++++++++++++++++
 sha1_file.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/cache.h b/cache.h
index 1c69d2a05a..375a7fb15e 100644
--- a/cache.h
+++ b/cache.h
@@ -76,6 +76,42 @@ struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
 };
 
+#define GIT_HASH_SHA1 0
+
+typedef void (*git_hash_init_fn)(void *ctx);
+typedef void (*git_hash_update_fn)(void *ctx, const void *in, size_t len);
+typedef void (*git_hash_final_fn)(unsigned char *hash, void *ctx);
+
+struct git_hash_algo {
+	/* The name of the algorithm, as appears in the config file. */
+	const char *name;
+
+	/* The size of a hash context (e.g. git_SHA_CTX). */
+	size_t ctxsz;
+
+	/* The length of the hash in bytes. */
+	size_t rawsz;
+
+	/* The length of the hash in hex characters. */
+	size_t hexsz;
+
+	/* The hash initialization function. */
+	git_hash_init_fn init_fn;
+
+	/* The hash update function. */
+	git_hash_update_fn update_fn;
+
+	/* The hash finalization function. */
+	git_hash_final_fn final_fn;
+
+	/* The OID of the empty tree. */
+	const struct object_id *empty_tree;
+
+	/* The OID of the empty blob. */
+	const struct object_id *empty_blob;
+};
+extern const struct git_hash_algo hash_algos[1];
+
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
diff --git a/sha1_file.c b/sha1_file.c
index b60ae15f70..bd9ff02802 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -41,6 +41,35 @@ const struct object_id empty_blob_oid = {
 	EMPTY_BLOB_SHA1_BIN_LITERAL
 };
 
+static inline void git_hash_sha1_init(void *ctx)
+{
+	git_SHA1_Init((git_SHA_CTX *)ctx);
+}
+
+static inline void git_hash_sha1_update(void *ctx, const void *data, size_t len)
+{
+	git_SHA1_Update((git_SHA_CTX *)ctx, data, len);
+}
+
+static inline void git_hash_sha1_final(unsigned char *hash, void *ctx)
+{
+	git_SHA1_Final(hash, (git_SHA_CTX *)ctx);
+}
+
+const struct git_hash_algo hash_algos[1] = {
+	[GIT_HASH_SHA1] = {
+		.name = "sha-1",
+		.ctxsz = sizeof(git_SHA_CTX),
+		.rawsz = GIT_SHA1_RAWSZ,
+		.hexsz = GIT_SHA1_HEXSZ,
+		.init_fn = git_hash_sha1_init,
+		.update_fn = git_hash_sha1_update,
+		.final_fn = git_hash_sha1_final,
+		.empty_tree = &empty_tree_oid,
+		.empty_blob = &empty_blob_oid,
+	},
+};
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
