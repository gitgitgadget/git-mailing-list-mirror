Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3731F453
	for <e@80x24.org>; Mon, 22 Oct 2018 02:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeJVLAi (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 07:00:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51744 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbeJVLAi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Oct 2018 07:00:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:65d4:dc3c:f6f5:933b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1017C61B72;
        Mon, 22 Oct 2018 02:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540176242;
        bh=XVVV80Dg40MdoQCB5bL8m47RLJMZzEwJV54qtH9JW8U=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rXIb+sn4IW+qRxub33FytBWZG1r/OEjWGNiPYCXtQgHadISfON+h8bX/gCNi5fioh
         aBqzAnxPwdnvpZgDXL1uyuqlr8Rvthv21/gXaf9LElKlQZgOzfukJN62JKf66kmJJ2
         uBU0dJe5Jkz6+0Fg+zGl/Xy5HIPzTcB4cHhCdbID33j892rZvCkXB2z+55R2xS7Z6Q
         HYEXnhrdtXBIV8Cp8AlrZC5jkFSTHyLgOulXVY23/VXUDW0k32eznKUQZdCKZcLuHt
         kutdFaoQD/pDQSx7hribpLcM+vV19hmlkHo0rTshiAbHio+rVCAOeBld/6OyfsxqsR
         JnR/JMAo7WWQuI3VGZF/F1VmXGI/lM3Xl8O613MZLmpihORodZqbJLxMTNwKuRRYcw
         YpIbnhnUzoto29fDuKFJAb0eihCghl4+OOAutXrmwcOKE3p3b8omGFk/i5PGXrAM+w
         NVXNm2OM4hAm0RQz/KtsfYG7eSWSvQL1qujjSNPikjI34drkFA9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 00/12] Base SHA-256 implementation
Date:   Mon, 22 Oct 2018 02:43:30 +0000
Message-Id: <20181022024342.489564-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series provides a functional SHA-256 implementation and wires it
up, along with some housekeeping patches to make it suitable for
testing.

Changes from v2:
* Improve commit messages to include timing and performance information.
* Improve commit messages to be less ambiguous and more friendly to a
  wider variety of English speakers.
* Prefer functions taking struct git_hash_algo in hex.c.
* Port pieces of the block-sha1 implementation over to the block-sha256
  implementation for better compatibility.
* Drop patch 13 in favor of further discussion about the best way
  forward for versioning commit graph.
* Rename the test so as to have a different number from other tests.
* Rebase on master.

Changes from v1:
* Add a hash_to_hex function mirroring sha1_to_hex, but for
  the_hash_algo.
* Strip commit message explanation about why we chose SHA-256.
* Rebase on master
* Strip leading whitespace from commit message.
* Improve commit-graph patch to cover new code added since v1.
* Be more honest about the scope of work involved in porting the SHA-256
  implementation out of libtomcrypt.
* Revert change to limit hashcmp to 20 bytes.

brian m. carlson (12):
  sha1-file: rename algorithm to "sha1"
  sha1-file: provide functions to look up hash algorithms
  hex: introduce functions to print arbitrary hashes
  cache: make hashcmp and hasheq work with larger hashes
  t: add basic tests for our SHA-1 implementation
  t: make the sha1 test-tool helper generic
  sha1-file: add a constant for hash block size
  t/helper: add a test helper to compute hash speed
  commit-graph: convert to using the_hash_algo
  Add a base implementation of SHA-256 support
  sha256: add an SHA-256 implementation using libgcrypt
  hash: add an SHA-256 implementation using OpenSSL

 Makefile                              |  22 +++
 cache.h                               |  51 ++++---
 commit-graph.c                        |  33 ++---
 hash.h                                |  41 +++++-
 hex.c                                 |  32 +++--
 sha1-file.c                           |  70 +++++++++-
 sha256/block/sha256.c                 | 186 ++++++++++++++++++++++++++
 sha256/block/sha256.h                 |  26 ++++
 sha256/gcrypt.h                       |  30 +++++
 t/helper/test-hash-speed.c            |  61 +++++++++
 t/helper/{test-sha1.c => test-hash.c} |  19 +--
 t/helper/test-sha1.c                  |  52 +------
 t/helper/test-sha256.c                |   7 +
 t/helper/test-tool.c                  |   2 +
 t/helper/test-tool.h                  |   4 +
 t/t0015-hash.sh                       |  54 ++++++++
 16 files changed, 586 insertions(+), 104 deletions(-)
 create mode 100644 sha256/block/sha256.c
 create mode 100644 sha256/block/sha256.h
 create mode 100644 sha256/gcrypt.h
 create mode 100644 t/helper/test-hash-speed.c
 copy t/helper/{test-sha1.c => test-hash.c} (65%)
 create mode 100644 t/helper/test-sha256.c
 create mode 100755 t/t0015-hash.sh

Range-diff against v2:
 1:  b5845548ac <  -:  ---------- :hash-impl
 2:  804ec2fd27 !  1:  cf9f7f5620 sha1-file: rename algorithm to "sha1"
    @@ -5,14 +5,14 @@
         The transition plan anticipates us using a syntax such as "^{sha1}" for
         disambiguation.  Since this is a syntax some people will be typing a
         lot, it makes sense to provide a short, easy-to-type syntax.  Omitting
    -    the dash doesn't create any ambiguity, but it does make it shorter and
    -    easier to type, especially for touch typists.  In addition, the
    -    transition plan already uses "sha1" in this context.
    +    the dash doesn't create any ambiguity; however, it does make the syntax
    +    shorter and easier to type, especially for touch typists.  In addition,
    +    the transition plan already uses "sha1" in this context.
     
         Rename the name of SHA-1 implementation to "sha1".
     
         Note that this change creates no backwards compatibility concerns, since
    -    we haven't yet used this field in any serialized data formats.
    +    we haven't yet used this field in any configuration settings.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
 3:  5196e00b26 !  2:  0144deaebe sha1-file: provide functions to look up hash algorithms
    @@ -27,7 +27,7 @@
     +/* Identical, except based on the format ID. */
     +int hash_algo_by_id(uint32_t format_id);
     +/* Identical, except for a pointer to struct git_hash_algo. */
    -+inline int hash_algo_by_ptr(const struct git_hash_algo *p)
    ++static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
     +{
     +	return p - hash_algos;
     +}
 4:  5873510d0a !  3:  b74858fb03 hex: introduce functions to print arbitrary hashes
    @@ -45,13 +45,13 @@
     -extern char *oid_to_hex_r(char *out, const struct object_id *oid);
     -extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
     -extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
    -+char *hash_to_hex_algo_r(char *buffer, const unsigned char *hash, int algo);
    ++char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
     +char *sha1_to_hex_r(char *out, const unsigned char *sha1);
     +char *oid_to_hex_r(char *out, const struct object_id *oid);
    -+char *hash_to_hex_algo(const unsigned char *hash, int algo);	/* static buffer result! */
    -+char *sha1_to_hex(const unsigned char *sha1);			/* same static buffer */
    -+char *hash_to_hex(const unsigned char *hash);			/* same static buffer */
    -+char *oid_to_hex(const struct object_id *oid);			/* same static buffer */
    ++char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *);	/* static buffer result! */
    ++char *sha1_to_hex(const unsigned char *sha1);						/* same static buffer */
    ++char *hash_to_hex(const unsigned char *hash);						/* same static buffer */
    ++char *oid_to_hex(const struct object_id *oid);						/* same static buffer */
      
      /*
       * Parse a 40-character hexadecimal object ID starting from hex, updating the
    @@ -64,7 +64,7 @@
      }
      
     -char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
    -+static inline char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
    ++inline char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
     +					const struct git_hash_algo *algop)
      {
      	static const char hex[] = "0123456789abcdef";
    @@ -83,44 +83,39 @@
      }
      
     -char *oid_to_hex_r(char *buffer, const struct object_id *oid)
    -+char *hash_to_hex_algo_r(char *buffer, const unsigned char *hash, int algo)
    ++char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
      {
     -	return sha1_to_hex_r(buffer, oid->hash);
    -+	return hash_to_hex_algop_r(buffer, hash, &hash_algos[algo]);
    ++	return hash_to_hex_algop_r(buffer, sha1, &hash_algos[GIT_HASH_SHA1]);
      }
      
     -char *sha1_to_hex(const unsigned char *sha1)
    -+char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
    -+{
    -+	return hash_to_hex_algo_r(buffer, sha1, GIT_HASH_SHA1);
    -+}
    -+
     +char *oid_to_hex_r(char *buffer, const struct object_id *oid)
     +{
     +	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
     +}
     +
    -+char *hash_to_hex_algo(const unsigned char *hash, int algo)
    ++char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *algop)
      {
      	static int bufno;
      	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
      	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
     -	return sha1_to_hex_r(hexbuffer[bufno], sha1);
    -+	return hash_to_hex_algo_r(hexbuffer[bufno], hash, algo);
    ++	return hash_to_hex_algop_r(hexbuffer[bufno], hash, algop);
     +}
     +
     +char *sha1_to_hex(const unsigned char *sha1)
     +{
    -+	return hash_to_hex_algo(sha1, GIT_HASH_SHA1);
    ++	return hash_to_hex_algop(sha1, &hash_algos[GIT_HASH_SHA1]);
     +}
     +
     +char *hash_to_hex(const unsigned char *hash)
     +{
    -+	return hash_to_hex_algo(hash, hash_algo_by_ptr(the_hash_algo));
    ++	return hash_to_hex_algop(hash, the_hash_algo);
      }
      
      char *oid_to_hex(const struct object_id *oid)
      {
     -	return sha1_to_hex(oid->hash);
    -+	return hash_to_hex_algo(oid->hash, hash_algo_by_ptr(the_hash_algo));
    ++	return hash_to_hex_algop(oid->hash, the_hash_algo);
      }
 5:  e22bf99c93 =  4:  e9703017a4 cache: make hashcmp and hasheq work with larger hashes
 6:  02cbcae270 !  5:  ab85a834fd t: add basic tests for our SHA-1 implementation
    @@ -11,10 +11,10 @@
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    - diff --git a/t/t0014-hash.sh b/t/t0014-hash.sh
    + diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
      new file mode 100755
      --- /dev/null
    - +++ b/t/t0014-hash.sh
    + +++ b/t/t0015-hash.sh
     @@
     +#!/bin/sh
     +
 7:  e9ac5f265a !  6:  962f6d8903 t: make the sha1 test-tool helper generic
    @@ -23,7 +23,7 @@
      TEST_BUILTINS_OBJS += test-json-writer.o
     
      diff --git a/t/helper/test-sha1.c b/t/helper/test-hash.c
    - similarity index 66%
    + similarity index 65%
      copy from t/helper/test-sha1.c
      copy to t/helper/test-hash.c
      --- a/t/helper/test-sha1.c
    @@ -78,7 +78,7 @@
     +		fwrite(hash, 1, algop->rawsz, stdout);
      	else
     -		puts(sha1_to_hex(sha1));
    -+		puts(hash_to_hex_algo(hash, algo));
    ++		puts(hash_to_hex_algop(hash, algop));
      	exit(0);
      }
     
 8:  44c9f27f9d =  7:  53addf4d58 sha1-file: add a constant for hash block size
 9:  59be7f1f37 =  8:  9ace10faa2 t/helper: add a test helper to compute hash speed
10:  09f1286769 !  9:  9adc56d01e commit-graph: convert to using the_hash_algo
    @@ -4,7 +4,9 @@
     
         Instead of using hard-coded constants for object sizes, use
         the_hash_algo to look them up.  In addition, use a function call to look
    -    up the object ID version and produce the correct value.
    +    up the object ID version and produce the correct value.  For now, we use
    +    version 1, which means to use the default algorithm used in the rest of
    +    the repository.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ -78,13 +80,13 @@
      			      (uint32_t)chunk_offset);
      			goto cleanup_fail;
     @@
    - 	int num_chunks;
      	int num_extra_edges;
      	struct commit_list *parent;
    + 	struct progress *progress = NULL;
     +	const unsigned hashsz = the_hash_algo->rawsz;
      
    - 	oids.nr = 0;
    - 	oids.alloc = approximate_object_count() / 4;
    + 	if (!commit_graph_compatible(the_repository))
    + 		return;
     @@
      	hashwrite_be32(f, GRAPH_SIGNATURE);
      
    @@ -115,4 +117,4 @@
     +	write_graph_chunk_data(f, hashsz, commits.list, commits.nr);
      	write_graph_chunk_large_edges(f, commits.list, commits.nr);
      
    - 	close_commit_graph();
    + 	close_commit_graph(the_repository);
11:  cdec8c1b49 ! 10:  8e82cb0dfb Add a base implementation of SHA-256 support
    @@ -8,9 +8,10 @@
     
         Add a basic implementation of SHA-256 based off libtomcrypt, which is in
         the public domain.  Optimize it and restructure it to meet our coding
    -    standards.  Place it in a directory called "sha256" where it and any
    -    future implementations can live so as to avoid a proliferation of
    -    implementation directories.
    +    standards.  Pull in the update and final functions from the SHA-1 block
    +    implementation, as we know these function correctly with all compilers.
    +    This implementation is slower than SHA-1, but more performant
    +    implementations will be introduced in future commits.
     
         Wire up SHA-256 in the list of hash algorithms, and add a test that the
         algorithm works correctly.
    @@ -211,7 +212,7 @@
     +void blk_SHA256_Init(blk_SHA256_CTX *ctx)
     +{
     +	ctx->offset = 0;
    -+	ctx->length = 0;
    ++	ctx->size = 0;
     +	ctx->state[0] = 0x6A09E667UL;
     +	ctx->state[1] = 0xBB67AE85UL;
     +	ctx->state[2] = 0x3C6EF372UL;
    @@ -329,55 +330,61 @@
     +	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],63,0xc67178f2);
     +
     +#undef RND
    ++#undef Ch
    ++#undef Maj
    ++#undef S
    ++#undef R
    ++#undef Sigma0
    ++#undef Sigma1
    ++#undef Gamma0
    ++#undef Gamma1
     +
     +	for (i = 0; i < 8; i++) {
     +		ctx->state[i] = ctx->state[i] + S[i];
     +	}
     +}
     +
    -+#define MIN(x, y) ((x) < (y) ? (x) : (y))
     +void blk_SHA256_Update(blk_SHA256_CTX *ctx, const void *data, size_t len)
     +{
    -+	const unsigned char *in = data;
    -+	size_t n;
    -+	ctx->length += len;
    -+	while (len > 0) {
    -+		if (!ctx->offset && len >= BLKSIZE) {
    -+			blk_SHA256_Transform(ctx, in);
    -+			in += BLKSIZE;
    -+			len -= BLKSIZE;
    -+		} else {
    -+			n = MIN(len, (BLKSIZE - ctx->offset));
    -+			memcpy(ctx->buf + ctx->offset, in, n);
    -+			ctx->offset += n;
    -+			in += n;
    -+			len -= n;
    -+			if (ctx->offset == BLKSIZE) {
    -+				blk_SHA256_Transform(ctx, ctx->buf);
    -+				ctx->offset = 0;
    -+			}
    -+		}
    ++	unsigned int len_buf = ctx->size & 63;
    ++
    ++	ctx->size += len;
    ++
    ++	/* Read the data into buf and process blocks as they get full */
    ++	if (len_buf) {
    ++		unsigned int left = 64 - len_buf;
    ++		if (len < left)
    ++			left = len;
    ++		memcpy(len_buf + ctx->buf, data, left);
    ++		len_buf = (len_buf + left) & 63;
    ++		len -= left;
    ++		data = ((const char *)data + left);
    ++		if (len_buf)
    ++			return;
    ++		blk_SHA256_Transform(ctx, ctx->buf);
     +	}
    ++	while (len >= 64) {
    ++		blk_SHA256_Transform(ctx, data);
    ++		data = ((const char *)data + 64);
    ++		len -= 64;
    ++	}
    ++	if (len)
    ++		memcpy(ctx->buf, data, len);
     +}
     +
     +void blk_SHA256_Final(unsigned char *digest, blk_SHA256_CTX *ctx)
     +{
    -+	const unsigned trip = BLKSIZE - sizeof(ctx->length);
    ++	static const unsigned char pad[64] = { 0x80 };
    ++	unsigned int padlen[2];
     +	int i;
     +
    -+	ctx->length <<= 3;
    -+	ctx->buf[ctx->offset++] = 0x80;
    ++	/* Pad with a binary 1 (ie 0x80), then zeroes, then length */
    ++	padlen[0] = htonl((uint32_t)(ctx->size >> 29));
    ++	padlen[1] = htonl((uint32_t)(ctx->size << 3));
     +
    -+	if (ctx->offset > trip) {
    -+		memset(ctx->buf + ctx->offset, 0, BLKSIZE - ctx->offset);
    -+		blk_SHA256_Transform(ctx, ctx->buf);
    -+		ctx->offset = 0;
    -+	}
    -+
    -+	memset(ctx->buf + ctx->offset, 0, BLKSIZE - ctx->offset - sizeof(ctx->length));
    -+
    -+	put_be64(ctx->buf + trip, ctx->length);
    -+	blk_SHA256_Transform(ctx, ctx->buf);
    ++	i = ctx->size & 63;
    ++	blk_SHA256_Update(ctx, pad, 1 + (63 & (55 - i)));
    ++	blk_SHA256_Update(ctx, padlen, 8);
     +
     +	/* copy output */
     +	for (i = 0; i < 8; i++, digest += sizeof(uint32_t))
    @@ -398,7 +405,7 @@
     +
     +struct blk_SHA256_CTX {
     +	uint32_t state[8];
    -+	uint64_t length;
    ++	uint64_t size;
     +	uint32_t offset;
     +	uint8_t buf[blk_SHA256_BLKSIZE];
     +};
    @@ -453,9 +460,9 @@
      int cmd__strcmp_offset(int argc, const char **argv);
      int cmd__string_list(int argc, const char **argv);
     
    - diff --git a/t/t0014-hash.sh b/t/t0014-hash.sh
    - --- a/t/t0014-hash.sh
    - +++ b/t/t0014-hash.sh
    + diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
    + --- a/t/t0015-hash.sh
    + +++ b/t/t0015-hash.sh
     @@
      	grep 4b825dc642cb6eb9a060e54bf8d69288fbee4904 actual
      '
12:  d085802a89 ! 11:  9e0061bd74 sha256: add an SHA-256 implementation using libgcrypt
    @@ -9,10 +9,15 @@
     
         Most systems with GnuPG will also have libgcrypt, since it is a
         dependency of GnuPG.  libgcrypt is also faster than the SHA1DC
    -    implementation for messages of a few KiB and larger. It is licensed
    -    under the LGPL 2.1, which is compatible with the GPL.
    +    implementation for messages of a few KiB and larger.
     
    -    Add an implementation of SHA-256 that uses libgcrypt.
    +    For comparison, on a Core i7-6600U, this implementation processes 16 KiB
    +    chunks at 355 MiB/s while SHA1DC processes equivalent chunks at 337
    +    MiB/s.
    +
    +    In addition, libgcrypt is licensed under the LGPL 2.1, which is
    +    compatible with the GPL.  Add an implementation of SHA-256 that uses
    +    libgcrypt.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
13:  4e4daf4000 ! 12:  128d6b8150 hash: add an SHA-256 implementation using OpenSSL
    @@ -5,6 +5,12 @@
         We already have OpenSSL routines available for SHA-1, so add routines
         for SHA-256 as well.
     
    +    On a Core i7-6600U, this SHA-256 implementation compares favorably to
    +    the SHA1DC SHA-1 implementation:
    +
    +    SHA-1: 157 MiB/s (64 byte chunks); 337 MiB/s (16 KiB chunks)
    +    SHA-256: 165 MiB/s (64 byte chunks); 408 MiB/s (16 KiB chunks)
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      diff --git a/Makefile b/Makefile
14:  f206f45426 <  -:  ---------- commit-graph: specify OID version for SHA-256
