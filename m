Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9DC1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 17:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeA1RHD (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 12:07:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58446 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751518AbeA1RG4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 12:06:56 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7DCE2609D7
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 17:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517159215;
        bh=MNang9U59ZLsrXzPI1jRwk4OMbUbhvjs0qYhFwSH/oU=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=lLtQqzxHz4+1FdCjgZuA5pdTrAmdytAPTwP17FmVwYw97E0MYFcvoYY/BuBa5wPaF
         IvfIfYzo4ldBKIr3dZbrUqU8V+Wm6UqT9i+uynRlYmx7tjTt10+CphIsyBw72KkVZA
         2wyKqelr0gixv979bA9nf0XXFpQWoCcaU/gb86zN4dxZeDaPaPFS/YrU/lfWp5nWdL
         p/84zk485pH2znKgUVfwKRad6+Crxk24RfA2mA71mJYDKbtGsvvkj0sPFCtZnXmFbB
         t5JDk6WihQVemBlo0SuMQhr5Ze8DLyleqAep1kyUeC303VEvrjviDg0xg9GCizoVUO
         XoBKULCu/V7vxF9ekHGP4WYNgm6r3/egcnFiWdn4GSTESzqbPCJwENw4lQZTDLm8pR
         qVjvpNxsu32AV36o8QQyFyg3ZGzf0pdgZBRd6DQT41uRKW1lfOEgYQQcaJy7jNs2Cw
         HBa37hPYKd4sS8Ypas/A5ptt7xqz1SBXxjacMU7wl2fmEK797IE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 1/2] Base test implementation for short BLAKE2b support
Date:   Sun, 28 Jan 2018 17:06:38 +0000
Message-Id: <20180128170639.216397-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180128170639.216397-1-sandals@crustytoothpaste.net>
References: <20180128170639.216397-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the implementation of a second hash algorithm with "short"
(160-bit) BLAKE2b support.  Simply add an additional algorithm to the
codebase without changing the use of any hash function and add a test
helper.

BLAKE2b was chosen simply because it provides a readily accessible hash
algorithm with arbitrary length support.  A 160-bit (20-byte) hash was
chosen to allow identification of tests that depend on the hash
algorithm in use while not causing buffer overflows, since parts of the
codebase still assume a 20-byte hash.

This is a preliminary commit for test purposes only and should not be
used in production in any way.
---
 Makefile                 |  3 +++
 cache.h                  | 16 ++++++++++++++
 hash.h                   |  9 +++++++-
 sha1_file.c              | 33 ++++++++++++++++++++++++++++
 t/helper/test-sblake2b.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-sblake2b.c

diff --git a/Makefile b/Makefile
index 1a9b23b679..d46247586b 100644
--- a/Makefile
+++ b/Makefile
@@ -677,6 +677,7 @@ TEST_PROGRAMS_NEED_X += test-ref-store
 TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
+TEST_PROGRAMS_NEED_X += test-sblake2b
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sha1-array
@@ -1539,6 +1540,8 @@ endif
 endif
 endif
 
+EXTLIBS += -lb2
+
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
diff --git a/cache.h b/cache.h
index bfde6f757a..638d832350 100644
--- a/cache.h
+++ b/cache.h
@@ -45,6 +45,10 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 #define GIT_SHA1_RAWSZ 20
 #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
 
+/* The length in bytes and in hex digits of an object name (short BLAKE2b value). */
+#define GIT_SBLAKE2B_RAWSZ 20
+#define GIT_SBLAKE2B_HEXSZ (2 * GIT_SBLAKE2B_RAWSZ)
+
 /* The length in byte and in hex digits of the largest possible hash value. */
 #define GIT_MAX_RAWSZ GIT_SHA1_RAWSZ
 #define GIT_MAX_HEXSZ GIT_SHA1_HEXSZ
@@ -1013,7 +1017,13 @@ static inline void oidclr(struct object_id *oid)
 #define EMPTY_TREE_SHA1_BIN_LITERAL \
 	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
 	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
+#define EMPTY_TREE_SBLAKE2B_HEX \
+	"f44422a644bfa5212387098f253a1e89eba94548"
+#define EMPTY_TREE_SBLAKE2B_BIN_LITERAL \
+	"\xf4\x44\x22\xa6\x44\xbf\xa5\x21\x23\x87" \
+	"\x09\x8f\x25\x3a\x1e\x89\xeb\xa9\x45\x48"
 extern const struct object_id empty_tree_oid;
+const struct object_id empty_tree_oid_sblake2b;
 #define EMPTY_TREE_SHA1_BIN (empty_tree_oid.hash)
 
 #define EMPTY_BLOB_SHA1_HEX \
@@ -1021,7 +1031,13 @@ extern const struct object_id empty_tree_oid;
 #define EMPTY_BLOB_SHA1_BIN_LITERAL \
 	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
 	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
+#define EMPTY_BLOB_SBLAKE2B_HEX \
+	"a706650a477f63b9b00eba41272bf36ef5a7dfa2"
+#define EMPTY_BLOB_SBLAKE2B_BIN_LITERAL \
+	"\xa7\x06\x65\x0a\x47\x7f\x63\xb9\xb0\x0e" \
+	"\xba\x41\x27\x2b\xf3\x6e\xf5\xa7\xdf\xa2"
 extern const struct object_id empty_blob_oid;
+const struct object_id empty_blob_oid_sblake2b;
 #define EMPTY_BLOB_SHA1_BIN (empty_blob_oid.hash)
 
 
diff --git a/hash.h b/hash.h
index 365846a6b5..ef510bd51a 100644
--- a/hash.h
+++ b/hash.h
@@ -15,6 +15,8 @@
 #include "block-sha1/sha1.h"
 #endif
 
+#include <blake2.h>
+
 #ifndef platform_SHA_CTX
 /*
  * platform's underlying implementation of SHA-1; could be OpenSSL,
@@ -40,6 +42,8 @@
 #define git_SHA1_Update		git_SHA1_Update_Chunked
 #endif
 
+#define git_BLAKE2B_CTX		blake2b_state
+
 /*
  * Note that these constants are suitable for indexing the hash_algos array and
  * comparing against each other, but are otherwise arbitrary, so they should not
@@ -52,12 +56,15 @@
 #define GIT_HASH_UNKNOWN 0
 /* SHA-1 */
 #define GIT_HASH_SHA1 1
+/* 20-byte BLAKE2b ("short" BLAKE2b) */
+#define GIT_HASH_SBLAKE2 2
 /* Number of algorithms supported (including unknown). */
-#define GIT_HASH_NALGOS (GIT_HASH_SHA1 + 1)
+#define GIT_HASH_NALGOS (GIT_HASH_SBLAKE2 + 1)
 
 /* A suitably aligned type for stack allocations of hash contexts. */
 union git_hash_ctx {
 	git_SHA_CTX sha1;
+	git_BLAKE2B_CTX blake2b;
 };
 typedef union git_hash_ctx git_hash_ctx;
 
diff --git a/sha1_file.c b/sha1_file.c
index d9e2b1f285..5067b22a30 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -38,6 +38,12 @@ const struct object_id empty_tree_oid = {
 const struct object_id empty_blob_oid = {
 	EMPTY_BLOB_SHA1_BIN_LITERAL
 };
+const struct object_id empty_tree_oid_sblake2b = {
+	EMPTY_TREE_SBLAKE2B_BIN_LITERAL
+};
+const struct object_id empty_blob_oid_sblake2b = {
+	EMPTY_BLOB_SBLAKE2B_BIN_LITERAL
+};
 
 static void git_hash_sha1_init(void *ctx)
 {
@@ -54,6 +60,21 @@ static void git_hash_sha1_final(unsigned char *hash, void *ctx)
 	git_SHA1_Final(hash, (git_SHA_CTX *)ctx);
 }
 
+static void git_hash_sblake2b_init(void *ctx)
+{
+	blake2b_init((git_BLAKE2B_CTX *)ctx, GIT_SBLAKE2B_RAWSZ);
+}
+
+static void git_hash_sblake2b_update(void *ctx, const void *data, size_t len)
+{
+	blake2b_update((git_BLAKE2B_CTX *)ctx, data, len);
+}
+
+static void git_hash_sblake2b_final(unsigned char *hash, void *ctx)
+{
+	blake2b_final((git_BLAKE2B_CTX *)ctx, hash, GIT_SBLAKE2B_RAWSZ);
+}
+
 static void git_hash_unknown_init(void *ctx)
 {
 	die("trying to init unknown hash");
@@ -93,6 +114,18 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		&empty_tree_oid,
 		&empty_blob_oid,
 	},
+	{
+		"sblake2b",
+		/* "sb2b", big-endian */
+		0x73623262,
+		GIT_SBLAKE2B_RAWSZ,
+		GIT_SBLAKE2B_HEXSZ,
+		git_hash_sblake2b_init,
+		git_hash_sblake2b_update,
+		git_hash_sblake2b_final,
+		&empty_tree_oid_sblake2b,
+		&empty_blob_oid_sblake2b,
+	}
 };
 
 /*
diff --git a/t/helper/test-sblake2b.c b/t/helper/test-sblake2b.c
new file mode 100644
index 0000000000..6623aaa4d5
--- /dev/null
+++ b/t/helper/test-sblake2b.c
@@ -0,0 +1,56 @@
+#include "cache.h"
+
+int cmd_main(int ac, const char **av)
+{
+	git_hash_ctx ctx;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	unsigned bufsz = 8192;
+	int binary = 0;
+	char *buffer;
+
+	if (ac == 2) {
+		if (!strcmp(av[1], "-b"))
+			binary = 1;
+		else
+			bufsz = strtoul(av[1], NULL, 10) * 1024 * 1024;
+	}
+
+	if (!bufsz)
+		bufsz = 8192;
+
+	while ((buffer = malloc(bufsz)) == NULL) {
+		fprintf(stderr, "bufsz %u is too big, halving...\n", bufsz);
+		bufsz /= 2;
+		if (bufsz < 1024)
+			die("OOPS");
+	}
+
+	hash_algos[GIT_HASH_SBLAKE2].init_fn(&ctx);
+
+	while (1) {
+		ssize_t sz, this_sz;
+		char *cp = buffer;
+		unsigned room = bufsz;
+		this_sz = 0;
+		while (room) {
+			sz = xread(0, cp, room);
+			if (sz == 0)
+				break;
+			if (sz < 0)
+				die_errno("test-sha1");
+			this_sz += sz;
+			cp += sz;
+			room -= sz;
+		}
+		if (this_sz == 0)
+			break;
+		hash_algos[GIT_HASH_SBLAKE2].update_fn(&ctx, buffer, this_sz);
+	}
+	hash_algos[GIT_HASH_SBLAKE2].final_fn(hash, &ctx);
+
+	if (binary)
+		fwrite(hash, 1, hash_algos[GIT_HASH_SBLAKE2].rawsz, stdout);
+	else
+		puts(sha1_to_hex(hash));
+	exit(0);
+}
