Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31EA41F453
	for <e@80x24.org>; Thu, 25 Oct 2018 02:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJYLK5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 07:10:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52340 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbeJYLK4 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Oct 2018 07:10:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 84D0B61B72;
        Thu, 25 Oct 2018 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540435214;
        bh=5LRGr1G7jLT392wsthzzIr9r1AeKj00fBotATOJUocU=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yTe1HYB4inhT3G+YBf65PSr4GOYClgf3eteCnNsrIKTSeN02qyleA/vO/6li7NJWN
         P6a12+fTDUc3fYrc6Ic6ezALC7FfajRLIqEwvJPlGRgEt2ykWQm8sLpQLQXJyfAV5G
         WQg7nJMdFIok+wZlXlE+hSilrE4gVVlSOAg9SN4ZAfq3iV2w1xa74FtQQLxzljluW3
         NwkLgmjrRbqyhfNJy4lgTyaSVQl1+sFu4msX5GeiXNYY91E4BK3mnJTmhrHzCCcxwv
         kzqk759gwoSQs1owXIN7tLDbUvI4eA7FlVtwcvlbeuciGoEtw5aUmBlghgqvzcSfkE
         xiOah1j5DPly7Qn8DZFwd3Uxco6e2WiQs6UXGBfEgOclX6M+mVRtrak/+ghGXcPgdq
         oWLOSzfI9DRhanCM/laLWT6MPFWQOu5F7B4jZkn/JEiKjvsk0FaXwJCtG1r6xLNmXw
         b/qJkELFh3vG6qq620EYnEKrPMaxhyiFj5qwLPvc1zpUkfPYbDv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 00/12] Base SHA-256 implementation
Date:   Thu, 25 Oct 2018 02:39:53 +0000
Message-Id: <20181025024005.154208-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
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

While I was fixing the macros, I wondered if I could make the code a bit
cleaner by using inline functions.  I tried it and found that not only
did it make the code cleaner, it made the code significantly faster
across all sizes of output, with larger gains on larger chunks (e.g.,
214 MiB/s on 16 KiB chunks vs 151 MiB/s).  I'm unsure why this effect
occurs, but I figured nobody would complain about improved performance.

Changes from v3:
* Switch to using inline functions instead of macros in many cases.
* Undefine remaining macros at the top.

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
 commit-graph.c                        |  33 +++--
 hash.h                                |  41 +++++-
 hex.c                                 |  32 +++-
 sha1-file.c                           |  70 ++++++++-
 sha256/block/sha256.c                 | 201 ++++++++++++++++++++++++++
 sha256/block/sha256.h                 |  26 ++++
 sha256/gcrypt.h                       |  30 ++++
 t/helper/test-hash-speed.c            |  61 ++++++++
 t/helper/{test-sha1.c => test-hash.c} |  19 +--
 t/helper/test-sha1.c                  |  52 +------
 t/helper/test-sha256.c                |   7 +
 t/helper/test-tool.c                  |   2 +
 t/helper/test-tool.h                  |   4 +
 t/t0015-hash.sh                       |  54 +++++++
 16 files changed, 601 insertions(+), 104 deletions(-)
 create mode 100644 sha256/block/sha256.c
 create mode 100644 sha256/block/sha256.h
 create mode 100644 sha256/gcrypt.h
 create mode 100644 t/helper/test-hash-speed.c
 copy t/helper/{test-sha1.c => test-hash.c} (65%)
 create mode 100644 t/helper/test-sha256.c
 create mode 100755 t/t0015-hash.sh

Range-diff against v3:
 1:  a004a4c982 <  -:  ---------- :hash-impl
 2:  cf9f7f5620 =  1:  cf9f7f5620 sha1-file: rename algorithm to "sha1"
 3:  0144deaebe =  2:  0144deaebe sha1-file: provide functions to look up hash algorithms
 4:  b74858fb03 =  3:  b74858fb03 hex: introduce functions to print arbitrary hashes
 5:  e9703017a4 =  4:  e9703017a4 cache: make hashcmp and hasheq work with larger hashes
 6:  ab85a834fd =  5:  ab85a834fd t: add basic tests for our SHA-1 implementation
 7:  962f6d8903 =  6:  962f6d8903 t: make the sha1 test-tool helper generic
 8:  53addf4d58 =  7:  53addf4d58 sha1-file: add a constant for hash block size
 9:  9ace10faa2 =  8:  9ace10faa2 t/helper: add a test helper to compute hash speed
10:  9adc56d01e =  9:  9adc56d01e commit-graph: convert to using the_hash_algo
11:  8e82cb0dfb ! 10:  f48cb1ad27 Add a base implementation of SHA-256 support
    @@ -207,6 +207,9 @@
     +#include "git-compat-util.h"
     +#include "./sha256.h"
     +
    ++#undef RND
    ++#undef BLKSIZE
    ++
     +#define BLKSIZE blk_SHA256_BLKSIZE
     +
     +void blk_SHA256_Init(blk_SHA256_CTX *ctx)
    @@ -228,14 +231,35 @@
     +	return (x >> n) | (x << (32 - n));
     +}
     +
    -+#define Ch(x,y,z)       (z ^ (x & (y ^ z)))
    -+#define Maj(x,y,z)      (((x | y) & z) | (x & y))
    -+#define S(x, n)         ror((x),(n))
    -+#define R(x, n)         ((x)>>(n))
    -+#define Sigma0(x)       (S(x, 2) ^ S(x, 13) ^ S(x, 22))
    -+#define Sigma1(x)       (S(x, 6) ^ S(x, 11) ^ S(x, 25))
    -+#define Gamma0(x)       (S(x, 7) ^ S(x, 18) ^ R(x, 3))
    -+#define Gamma1(x)       (S(x, 17) ^ S(x, 19) ^ R(x, 10))
    ++static inline uint32_t ch(uint32_t x, uint32_t y, uint32_t z)
    ++{
    ++	return (z ^ (x & (y ^ z)));
    ++}
    ++
    ++static inline uint32_t maj(uint32_t x, uint32_t y, uint32_t z)
    ++{
    ++	return (((x | y) & z) | (x & y));
    ++}
    ++
    ++static inline uint32_t sigma0(uint32_t x)
    ++{
    ++	return ror(x, 2) ^ ror(x, 13) ^ ror(x, 22);
    ++}
    ++
    ++static inline uint32_t sigma1(uint32_t x)
    ++{
    ++	return ror(x, 6) ^ ror(x, 11) ^ ror(x, 25);
    ++}
    ++
    ++static inline uint32_t gamma0(uint32_t x)
    ++{
    ++	return ror(x, 7) ^ ror(x, 18) ^ (x >> 3);
    ++}
    ++
    ++static inline uint32_t gamma1(uint32_t x)
    ++{
    ++	return ror(x, 17) ^ ror(x, 19) ^ (x >> 10);
    ++}
     +
     +static void blk_SHA256_Transform(blk_SHA256_CTX *ctx, const unsigned char *buf)
     +{
    @@ -255,12 +279,12 @@
     +
     +	/* fill W[16..63] */
     +	for (i = 16; i < 64; i++) {
    -+		W[i] = Gamma1(W[i - 2]) + W[i - 7] + Gamma0(W[i - 15]) + W[i - 16];
    ++		W[i] = gamma1(W[i - 2]) + W[i - 7] + gamma0(W[i - 15]) + W[i - 16];
     +	}
     +
     +#define RND(a,b,c,d,e,f,g,h,i,ki)                    \
    -+	t0 = h + Sigma1(e) + Ch(e, f, g) + ki + W[i];   \
    -+	t1 = Sigma0(a) + Maj(a, b, c);                  \
    ++	t0 = h + sigma1(e) + ch(e, f, g) + ki + W[i];   \
    ++	t1 = sigma0(a) + maj(a, b, c);                  \
     +	d += t0;                                        \
     +	h  = t0 + t1;
     +
    @@ -329,15 +353,6 @@
     +	RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],62,0xbef9a3f7);
     +	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],63,0xc67178f2);
     +
    -+#undef RND
    -+#undef Ch
    -+#undef Maj
    -+#undef S
    -+#undef R
    -+#undef Sigma0
    -+#undef Sigma1
    -+#undef Gamma0
    -+#undef Gamma1
     +
     +	for (i = 0; i < 8; i++) {
     +		ctx->state[i] = ctx->state[i] + S[i];
12:  9e0061bd74 = 11:  fe8f2ba01c sha256: add an SHA-256 implementation using libgcrypt
13:  128d6b8150 = 12:  38142d8fc6 hash: add an SHA-256 implementation using OpenSSL
