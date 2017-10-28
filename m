Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A886A2055E
	for <e@80x24.org>; Sat, 28 Oct 2017 18:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbdJ1SQD (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 14:16:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55562 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751327AbdJ1SP6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 14:15:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 853746044C;
        Sat, 28 Oct 2017 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509214557;
        bh=o8s1YFT3sdoGqTtkrz6A3DhKaMH9qPhX0avu+EAnLJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=e7QXSg2RH11uASKfWL5j2goAWU3xxKrcbtJFYaCfyh8WlBAAfCDqvbjCyeWq4bWBU
         KI5NPYek2u3E53/uqX5HOqdCVvZ0L7BXX5GscDpBkWWjvdujVO9Kqof+bhRWU2Bov5
         fvwJw/ZCg4GGg6W28OX9Nra6T2E/wpVGM5pfI0GVrwHiDXOr/7TMzSbokP7l3EWGE4
         idpJStg08cqDBmY9KbnonkZSBikoRXWToP20BkLeqHtXXY84GzXjbFigvc/ODv16AN
         Nf0O3MqiuIWBHzo3sbXtyi3mCVI1IKBcySOHyInrSzQzxucicJy9E1fzwt8BkpDPmp
         /wezv2gug0Q6cE1Smk5OrmUDygVaSlT40BisU2tE6V84T/CKyTF9eF0/L18hm52gXY
         LoTRrQPCYFp+TTYyvhlFH7fWs+auYJ0sdGsBWkrpcq2aytlCAi98zGgpSJfX1Uc2Fz
         dwEMVnWTtJOkHJ1etltOioZXhRJjGpb3txpbqEbUjE92Pg5G319
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 2/4] Add structure representing hash algorithm
Date:   Sat, 28 Oct 2017 18:12:37 +0000
Message-Id: <20171028181239.59458-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc2
In-Reply-To: <20171028181239.59458-1-sandals@crustytoothpaste.net>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
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

Expose a value for hex size as well as binary size.  While one will
always be twice the other, the two values are both used extremely
commonly throughout the codebase and providing both leads to improved
readability.

Don't include an entry in the hash algorithm structure for the null
object ID.  As this value is all zeros, any suitably sized all-zero
object ID can be used, and there's no need to store a given one on a
per-hash basis.

The current hash function transition plan envisions a time when we will
accept input from the user that might be in SHA-1 or in the NewHash
format.  Since we cannot know which the user has provided, add a
constant representing the unknown algorithm to allow us to indicate that
we must look the correct value up.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I believe I did get the format_id constant for SHA-1 right, but
sanity-checking would be appreciated.  We don't want another Referer
mess.

 cache.h     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1_file.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/cache.h b/cache.h
index 6440e2bf21..9e9eb08f05 100644
--- a/cache.h
+++ b/cache.h
@@ -77,6 +77,61 @@ struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
 };
 
+/*
+ * Note that these constants are suitable for indexing the hash_algos array and
+ * comparing against each other, but are otherwise arbitrary, so they should not
+ * be exposed to the user or serialized to disk.  To know whether a
+ * git_hash_algo struct points to some usable hash function, test the format_id
+ * field for being non-zero.  Use the name field for user-visible situations and
+ * the format_id field for fixed-length fields on disk.
+ */
+/* An unknown hash function. */
+#define GIT_HASH_UNKNOWN 0
+/* SHA-1 */
+#define GIT_HASH_SHA1 1
+/* Number of algorithms supported (including unknown). */
+#define GIT_HASH_NALGOS (GIT_HASH_SHA1 + 1)
+
+typedef void (*git_hash_init_fn)(void *ctx);
+typedef void (*git_hash_update_fn)(void *ctx, const void *in, size_t len);
+typedef void (*git_hash_final_fn)(unsigned char *hash, void *ctx);
+
+struct git_hash_algo {
+	/*
+	 * The name of the algorithm, as appears in the config file and in
+	 * messages.
+	 */
+	const char *name;
+
+	/* A four-byte version identifier, used in pack indices. */
+	uint32_t format_id;
+
+	/* The size of a hash context (e.g. git_SHA_CTX). */
+	size_t ctxsz;
+
+	/* The length of the hash in binary. */
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
+extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
+
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
diff --git a/sha1_file.c b/sha1_file.c
index 10c3a0083d..77b320126a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -39,6 +39,49 @@ const struct object_id empty_blob_oid = {
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
+const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
+	{
+		NULL,
+		0x00000000,
+		0,
+		0,
+		0,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+	},
+	{
+		"sha-1",
+		/* "sha1", big-endian */
+		0x73686131,
+		sizeof(git_SHA_CTX),
+		GIT_SHA1_RAWSZ,
+		GIT_SHA1_HEXSZ,
+		git_hash_sha1_init,
+		git_hash_sha1_update,
+		git_hash_sha1_final,
+		&empty_tree_oid,
+		&empty_blob_oid,
+	},
+};
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
-- 
2.15.0.rc2

