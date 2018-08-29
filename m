Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ED7C1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH2ExW (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:53:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37316 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbeH2ExW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:53:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4725660758
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504346;
        bh=uA0UwQ0iF0j8fCciis/7jCahG8EHxYto8/2TXZw65uk=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0GebC6f3UhyIkfy6Yy0V9mRCZiTkfAuNgbA2WDYVG2g03Zt7zm74Fz840FanZDwKy
         G57oNFsUxvpA4MBrRoz1K92lmzkhyU22okxNNcezteLkuKkXTSlfnNjEGGsE1UAEzA
         4oaB2PphX+Z+BLvCUmV3w/j2JylIyz5ruuxeDnFNANodV+CK1TzQc/6cpkVABGeCq4
         X3qkvv7juKG2iiQtLLCBNMpEJ9U5VCx1Sphl0Uf5fApZ0XcH/DuNJp9uXul8DE9BbH
         n8VDlo8Oe2kOVXzX0dGgGh9B0U+/hYyydyOZ04RFQE85Ax4Hfk8lvn5azeqmq+pNJm
         rj53zzuCViq7EEX/3u4Fth1KVbGAZgQsE5ayA31727Axt6hOdFJq+2WfTRC4WDU+Jj
         2eTJnkCV2hWPzRkUBJWi8aChMnQ4iEVfNOmMJnM1tQIYK+rRouRDoHT9L2KUiAXaTy
         lXPGAA/7jlGAhW1JczHg9+3O2DlnHkymtTuDI0YUbdXEu4/2P/M
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 00/12] Base SHA-256 algorithm implementation
Date:   Wed, 29 Aug 2018 00:58:45 +0000
Message-Id: <20180829005857.980820-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC series provides an actual SHA-256 implementation and wires it
up, along with a few housekeeping patches to make it usable for testing.

As discussed in some threads, this changes the algorithm name from
"sha-1" to "sha1" (and also adds "sha256") because it's far easier to
type.

I introduced some basic tests for the hash algorithms in use.  Since I
did not import the SHA-256 implementation verbatim, I felt it was
necessary to ensure that the hash algorithm implementations continued to
function as expected.  My main changes were to adjust the code to use
our endianness functions, to adopt something closer to our style, and to
make use of memcpy and friends for performance reasons.

I opted to place all the implementation code for SHA-256 into one
directory, as opposed to the various directories we have for the SHA-1
implementations, mostly for tidiness and ease of use.

I wired up OpenSSL because we already have it and libgcrypt because it
performs better than SHA-1.  I didn't provide an implementation for
SHA-1 with libgcrypt because everybody should be using SHA1DC for
security.

I didn't provide an implementation based on libnettle because its x86-64
assembly implementation isn't vectorized and is pretty slow.  Since this
was written before I had access to a Mac, Apple Common Crypto hasn't
been wired up, either.  Patches welcome.

If libgit2 would like to import this SHA-256 implementation, they're
welcome to do so under their normal license terms.  If not, that's fine,
too.

brian m. carlson (12):
  sha1-file: rename algorithm to "sha1"
  sha1-file: provide functions to look up hash algorithms
  hex: introduce functions to print arbitrary hashes
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
 cache.h                               |  28 ++--
 commit-graph.c                        |  38 +++---
 hash.h                                |  41 +++++-
 hex.c                                 |  32 +++--
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
 16 files changed, 573 insertions(+), 93 deletions(-)
 create mode 100644 sha256/block/sha256.c
 create mode 100644 sha256/block/sha256.h
 create mode 100644 sha256/gcrypt.h
 create mode 100644 t/helper/test-hash-speed.c
 copy t/helper/{test-sha1.c => test-hash.c} (66%)
 create mode 100644 t/helper/test-sha256.c
 create mode 100755 t/t0014-hash.sh

