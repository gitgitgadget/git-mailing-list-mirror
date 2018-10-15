Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB7E1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 02:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeJOKCR (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 06:02:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50692 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbeJOKCR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 06:02:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7045461B73;
        Mon, 15 Oct 2018 02:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539569947;
        bh=vhYt91NMeNOqOBRxmzyvlniu7ZeyOjifJQZt1v/CgqE=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EvfgEBWMp3oOOEYsq48QIbfSJryiqTKyzkuW/T2SdDOTidxy8/sQUfyy9j1hhfuih
         yiOM0SKAx2fDucTB6Wrjny7E2k0Tbq3c1dOvNJTCWxSnYLCy+fVGCRDlrHTK5TzJed
         gzcNrZuhUZBlt9Aw2NbaNerjKnKyJ0hImM0bTL86sJipaQVLzhgNzx4K3GaE16hvu3
         txVz6cuMM4EwJg2KSrAYol3ErY6eslRjBplQ0YTkkldKVb98OFrz5+hWGWiZ+sNu/Y
         IZ1pBNB3gdxxoOuBjydMPSLFPv+e2ozd+zN8MzSYJf8cBO3HRHkYzfl26BYcAQcHqm
         6jrihiNwKbjxriDTb5nJyErtxxfEjNrcRFKMl4tMUMZgEenSet1pIBbeJUB3Z3J7ZR
         GGkIT5xV9RjZ1YBgs8pz9aIgTjR2KKpKr7DoN6zdjBU5hTuPU3n3rjMa8kf6prv4JF
         f8DwPZI80RW7HAdOrS3UOqeBQDiPQQR6dYB8v/xfVxNGwYdruSL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/13] Base SHA-256 implementation
Date:   Mon, 15 Oct 2018 02:18:47 +0000
Message-Id: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series provides an actual SHA-256 implementation and wires it up,
along with some housekeeping patches to make it suitable for testing.

New in this version is a patch which reverts the change to limit hashcmp
to 20 bytes.  I've taken care to permit the compiler to inline as much
as possible for efficiency, but it would be helpful to see what the
performance impact of these changes is on real-life workflows, or with
MSVC and other non-GCC and non-clang compilers.  The resulting change is
uglier and more duplicative than I wanted, but oh, well.

I didn't attempt to pull in the full complement of code from libtomcrypt
to try to show the changes made, since that would have involved
importing a significant quantity of code in order to make things work.

I realize the increase to GIT_MAX_HEXSZ will result in an increase in
memory usage, but we're going to need to do it at some point, and the
sooner the code is in the codebase, the sooner people can play around
with it and test it.

This piece should be the final piece of preparatory work required for a
fully functioning SHA-256-only Git.  Additional work should be able to
come into the testsuite and codebase without needing to build on work in
any series after this one.

v1, which was RFC, can be seen at
https://public-inbox.org/git/20180829005857.980820-1-sandals@crustytoothpaste.net/.

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

brian m. carlson (13):
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
  commit-graph: specify OID version for SHA-256

 Makefile                              |  22 ++++
 cache.h                               |  51 +++++---
 commit-graph.c                        |  40 +++---
 hash.h                                |  41 +++++-
 hex.c                                 |  37 ++++--
 sha1-file.c                           |  70 +++++++++-
 sha256/block/sha256.c                 | 180 ++++++++++++++++++++++++++
 sha256/block/sha256.h                 |  26 ++++
 sha256/gcrypt.h                       |  30 +++++
 t/helper/test-hash-speed.c            |  61 +++++++++
 t/helper/{test-sha1.c => test-hash.c} |  19 +--
 t/helper/test-sha1.c                  |  52 +-------
 t/helper/test-sha256.c                |   7 +
 t/helper/test-tool.c                  |   2 +
 t/helper/test-tool.h                  |   4 +
 t/t0014-hash.sh                       |  54 ++++++++
 16 files changed, 592 insertions(+), 104 deletions(-)
 create mode 100644 sha256/block/sha256.c
 create mode 100644 sha256/block/sha256.h
 create mode 100644 sha256/gcrypt.h
 create mode 100644 t/helper/test-hash-speed.c
 copy t/helper/{test-sha1.c => test-hash.c} (66%)
 create mode 100644 t/helper/test-sha256.c
 create mode 100755 t/t0014-hash.sh

Range-diff against v1:
 1:  0a96c59452 =  1:  804ec2fd27 sha1-file: rename algorithm to "sha1"
 2:  65f9feba41 =  2:  5196e00b26 sha1-file: provide functions to look up hash algorithms
 3:  b6d960121d !  3:  5873510d0a hex: introduce functions to print arbitrary hashes
    @@ -13,9 +13,12 @@
         it.
     
         We use the variant taking the algorithm structure pointer as the
    -    internal variant, since in the future we'll want to replace sha1_to_hex
    -    with a hash_to_hex that handles the_hash_algo, and taking an algorithm
    -    pointer is the easiest way to handle all of the variants in use.
    +    internal variant, since taking an algorithm pointer is the easiest way
    +    to handle all of the variants in use.
    +
    +    Note that we maintain these functions because there are hashes which
    +    must change based on the hash algorithm in use but are not object IDs
    +    (such as pack checksums).
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ -47,6 +50,7 @@
     +char *oid_to_hex_r(char *out, const struct object_id *oid);
     +char *hash_to_hex_algo(const unsigned char *hash, int algo);	/* static buffer result! */
     +char *sha1_to_hex(const unsigned char *sha1);			/* same static buffer */
    ++char *hash_to_hex(const unsigned char *hash);			/* same static buffer */
     +char *oid_to_hex(const struct object_id *oid);			/* same static buffer */
      
      /*
    @@ -108,6 +112,11 @@
     +char *sha1_to_hex(const unsigned char *sha1)
     +{
     +	return hash_to_hex_algo(sha1, GIT_HASH_SHA1);
    ++}
    ++
    ++char *hash_to_hex(const unsigned char *hash)
    ++{
    ++	return hash_to_hex_algo(hash, hash_algo_by_ptr(the_hash_algo));
      }
      
      char *oid_to_hex(const struct object_id *oid)
 -:  ---------- >  4:  e22bf99c93 cache: make hashcmp and hasheq work with larger hashes
 4:  984698c42a =  5:  02cbcae270 t: add basic tests for our SHA-1 implementation
 5:  61632644bd !  6:  e9ac5f265a t: make the sha1 test-tool helper generic
    @@ -14,7 +14,7 @@
      --- a/Makefile
      +++ b/Makefile
     @@
    - TEST_BUILTINS_OBJS += test-dump-split-index.o
    + TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
      TEST_BUILTINS_OBJS += test-example-decorate.o
      TEST_BUILTINS_OBJS += test-genrandom.o
     +TEST_BUILTINS_OBJS += test-hash.o
    @@ -147,7 +147,7 @@
      --- a/t/helper/test-tool.h
      +++ b/t/helper/test-tool.h
     @@
    - int cmd__wildmatch(int argc, const char **argv);
    + #endif
      int cmd__write_cache(int argc, const char **argv);
      
     +int cmd_hash_impl(int ac, const char **av, int algo);
 6:  79d5246af6 =  7:  44c9f27f9d sha1-file: add a constant for hash block size
 7:  a83ceb35a8 =  8:  59be7f1f37 t/helper: add a test helper to compute hash speed
 8:  ef3c5f3370 !  9:  09f1286769  commit-graph: convert to using the_hash_algo
    @@ -1,6 +1,6 @@
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
    -     commit-graph: convert to using the_hash_algo
    +    commit-graph: convert to using the_hash_algo
     
         Instead of using hard-coded constants for object sizes, use
         the_hash_algo to look them up.  In addition, use a function call to look
    @@ -12,6 +12,12 @@
      --- a/commit-graph.c
      +++ b/commit-graph.c
     @@
    + #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
    + #define GRAPH_CHUNKID_LARGEEDGES 0x45444745 /* "EDGE" */
    + 
    +-#define GRAPH_DATA_WIDTH 36
    ++#define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
    + 
      #define GRAPH_VERSION_1 0x1
      #define GRAPH_VERSION GRAPH_VERSION_1
      
 9:  298b15b577 ! 10:  cdec8c1b49 Add a base implementation of SHA-256 support
    @@ -3,39 +3,14 @@
         Add a base implementation of SHA-256 support
     
         SHA-1 is weak and we need to transition to a new hash function.  For
    -    some time, we have referred to this new function as NewHash.
    -
    -    The selection criteria for NewHash specify that it should (a) be 256
    -    bits in length, (b) have high quality implementations available, (c)
    -    should match Git's needs in terms of security, and (d) ideally, be fast
    -    to compute.
    -
    -    SHA-256 has a variety of high quality implementations across various
    -    libraries.  It is implemented by every cryptographic library we support
    -    and is available on every platform and in almost every programming
    -    language.  It is often highly optimized, since it is commonly used in
    -    TLS and elsewhere.  Additionally, there are various command line
    -    utilities that implement it, which is useful for educational and testing
    -    purposes.
    -
    -    SHA-256 is presently considered secure and has received a reasonable
    -    amount of cryptanalysis in the literature.  It is, admittedly, not
    -    resistant to length extension attacks, but Git object storage is immune
    -    to those due to the length field at the beginning.
    -
    -    SHA-256 is somewhat slower to compute than SHA-1 in software.  However,
    -    since our default SHA-1 implementation is collision-detecting, a
    -    reasonable cryptographic library implementation of SHA-256 will actually
    -    be faster than SHA-256.  In addition, modern ARM and AMD processors (and
    -    some Intel processors) contain instructions for implementing SHA-256 in
    -    hardware, making it the fastest possible option.
    -
    -    There are other reasons to select SHA-256.  With signed commits and
    -    tags, it's possible to use SHA-256 for signatures and therefore have to
    -    rely on only one hash algorithm for security.
    +    some time, we have referred to this new function as NewHash.  Recently,
    +    we decided to pick SHA-256 as NewHash.
     
         Add a basic implementation of SHA-256 based off libtomcrypt, which is in
    -    the public domain.  Optimize it and tidy it somewhat.
    +    the public domain.  Optimize it and restructure it to meet our coding
    +    standards.  Place it in a directory called "sha256" where it and any
    +    future implementations can live so as to avoid a proliferation of
    +    implementation directories.
     
         Wire up SHA-256 in the list of hash algorithms, and add a test that the
         algorithm works correctly.
    @@ -51,8 +26,8 @@
      +++ b/Makefile
     @@
      TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
    - TEST_BUILTINS_OBJS += test-sha1-array.o
      TEST_BUILTINS_OBJS += test-sha1.o
    + TEST_BUILTINS_OBJS += test-sha1-array.o
     +TEST_BUILTINS_OBJS += test-sha256.o
      TEST_BUILTINS_OBJS += test-sigchain.o
      TEST_BUILTINS_OBJS += test-strcmp-offset.o
    @@ -459,8 +434,8 @@
      +++ b/t/helper/test-tool.c
     @@
      	{ "scrap-cache-tree", cmd__scrap_cache_tree },
    - 	{ "sha1-array", cmd__sha1_array },
      	{ "sha1", cmd__sha1 },
    + 	{ "sha1-array", cmd__sha1_array },
     +	{ "sha256", cmd__sha256 },
      	{ "sigchain", cmd__sigchain },
      	{ "strcmp-offset", cmd__strcmp_offset },
    @@ -471,8 +446,8 @@
      +++ b/t/helper/test-tool.h
     @@
      int cmd__scrap_cache_tree(int argc, const char **argv);
    - int cmd__sha1_array(int argc, const char **argv);
      int cmd__sha1(int argc, const char **argv);
    + int cmd__sha1_array(int argc, const char **argv);
     +int cmd__sha256(int argc, const char **argv);
      int cmd__sigchain(int argc, const char **argv);
      int cmd__strcmp_offset(int argc, const char **argv);
10:  c52b4be13c = 11:  d085802a89 sha256: add an SHA-256 implementation using libgcrypt
11:  225ec075d1 = 12:  4e4daf4000 hash: add an SHA-256 implementation using OpenSSL
12:  04a3ac6f29 = 13:  f206f45426 commit-graph: specify OID version for SHA-256
