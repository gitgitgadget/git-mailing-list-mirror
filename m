Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489BE201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 21:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbdKLV3L (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 16:29:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55970 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750943AbdKLV3H (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 16:29:07 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 850166049A;
        Sun, 12 Nov 2017 21:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510522145;
        bh=JjKyx0VMOwAXL8lktap4JLk0fRvwiADzsP0JFq5+RIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZMHmXFQwhIRSnhdmo6t4k9nC+0OzxwvElPD3OZRoxG6LBGyOxG+dDF0NJgaHzCc/w
         NdplKsKB1Ah9ZqWlRv1RezNaFJf7ZtsRTDBlYrFJsTE8XNmOFs/ufxhLywk2BWmBxD
         XuFqT5LtbdsgawasTZkGQ/VQCCGwzjZFLpiqAG3Vx/hPUy3tPMG1w5L2SPMJuRl87S
         A7YlyeU2evBCaloaM1DLR41O8qJvGjRGIPcpUg6FKV/DJ2RE0+U8dQoee2b2MApJu1
         5El1Xg9Q0Sw+jvVsDYu67bT3xNUjJP0TlapVCU0UNpIhG2oRjo45AAz1Z3F51PvuxV
         6GdmNvBJJ4w/Fs4X6MVLCLRlWD4/h5aYBq2VEwGLrc061YeYjBvXTPRi4Uo/UzaMnm
         4YXUES6nPd8TC1WN5/OpUh/pDyDDi9cVGmf7ncm5YSfo2o4Jngw0gCue25D9mIDp+f
         Kr+BRyLws2L54yDh4IBAnk7+UIQQIR/hQFu6Apb2Im9YPxr0XIT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/4] Add structure representing hash algorithm
Date:   Sun, 12 Nov 2017 21:28:52 +0000
Message-Id: <20171112212854.791179-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a
In-Reply-To: <20171112212854.791179-1-sandals@crustytoothpaste.net>
References: <20171112212854.791179-1-sandals@crustytoothpaste.net>
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
we must look the correct value up.  Provide dummy API functions that die
in this case.

Finally, include git-compat-util.h in hash.h so that the required types
are available.  This aids people using automated tools their editors.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h      | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1_file.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/hash.h b/hash.h
index 024d0d3d50..7d7a864f5d 100644
--- a/hash.h
+++ b/hash.h
@@ -1,6 +1,8 @@
 #ifndef HASH_H
 #define HASH_H
 
+#include "git-compat-util.h"
+
 #if defined(SHA1_PPC)
 #include "ppc/sha1.h"
 #elif defined(SHA1_APPLE)
@@ -13,4 +15,59 @@
 #include "block-sha1/sha1.h"
 #endif
 
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
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index d708981376..a04389be71 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -39,6 +39,64 @@ const struct object_id empty_blob_oid = {
 	EMPTY_BLOB_SHA1_BIN_LITERAL
 };
 
+static void git_hash_sha1_init(void *ctx)
+{
+	git_SHA1_Init((git_SHA_CTX *)ctx);
+}
+
+static void git_hash_sha1_update(void *ctx, const void *data, size_t len)
+{
+	git_SHA1_Update((git_SHA_CTX *)ctx, data, len);
+}
+
+static void git_hash_sha1_final(unsigned char *hash, void *ctx)
+{
+	git_SHA1_Final(hash, (git_SHA_CTX *)ctx);
+}
+
+static void git_hash_unknown_init(void *ctx)
+{
+	die("trying to init unknown hash");
+}
+
+static void git_hash_unknown_update(void *ctx, const void *data, size_t len)
+{
+	die("trying to update unknown hash");
+}
+
+static void git_hash_unknown_final(unsigned char *hash, void *ctx)
+{
+	die("trying to finalize unknown hash");
+}
+
+const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
+	{
+		NULL,
+		0x00000000,
+		0,
+		0,
+		0,
+		git_hash_unknown_init,
+		git_hash_unknown_update,
+		git_hash_unknown_final,
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
