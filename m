Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4F3D1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbeDWXkF (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60460 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932707AbeDWXkA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4A14D60400;
        Mon, 23 Apr 2018 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526799;
        bh=m2UjInMuWEFP+HbBAoD57YFDKsPTB99bnECsjosZfbM=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vxbBwrtEGMeUPj9BONv9T1qUVYZUXlN9ECgzo0MiIm9N8oB5PjEKtZIzZ/eI+x+Kp
         /ru0LaLPcT1V4HdL+1K2CWEFKkTxwz3WO4Ypu4R86H5Y0LkpXl3HUV1m15n4rYKLP7
         ok5/IcoTyE1zyaFe9qnRlhcKckWd9B94tATpHqqaLPgV75oFhyj5RhjuM0BV8Z8Ytl
         NXJ7i6IbgKlwVF1Vu9vvbKr+sI0JCyMB0IkvmENvm+T29Dw7YQKI13YN6dc+8OXF5q
         MquMlF1Uowd5fDUwY8cPkNluP3M7kMah4t5jkqbdwfn1kohSviRR5rNJrvwYj/fh6y
         WG+/Lp1KARh9eEXFN91wYthNxwvH2fvvgS55hti+BNt2ElqTplZibZxFKd+BzsiiD3
         tG5mfdpoOf2nycmsCD3K9oNp2KSxRm0BH4VB8Mi4+B6JLSEUgBa173L9mhLFXsThOY
         F9W7iBIW9Fz5Foao1EA624HSYxHe+jnMmZNM4+CElw4SkPIg3AV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 00/41] object_id part 13
Date:   Mon, 23 Apr 2018 23:39:10 +0000
Message-Id: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the thirteenth series of patches to convert to struct object_id
and the_hash_algo.

The series adds an oidread function to read object IDs from a buffer,
removes unused structure members (which therefore don't require
conversion), converts various functions to struct object_id, and
improves usage of the_hash_algo.  It also makes empty_blob_oid and
empty_tree_oid static, exposed only through the hash algorithm
abstraction, and updates all the hard-coded instances of the empty blob
and empty tree object IDs in scripts (excepting the testsuite).

Outside of the testsuite, these are the only changes required to use a
different 160-bit hash algorithm.  To get the testsuite working will
require two additional sets of patches, one of which I will send out
soon.

I expect part 14 to be the last (or next to it) of the object_id series.
I'm starting work on testing the codebase with a 256-bit hash[0], and I
expect that part 14 (or possibly a 15) will include the final pieces
necessary to make it pass the testsuite with a 256-bit hash (sans
multi-hash support).

[0] I can synthesize blobs, trees, and commits, but things are currently
totally broken, which is, I suppose, to be expected.

brian m. carlson (41):
  cache: add a function to read an object ID from a buffer
  server-info: remove unused members from struct pack_info
  Remove unused member in struct object_context
  packfile: remove unused member from struct pack_entry
  packfile: convert has_sha1_pack to object_id
  sha1_file: convert freshen functions to object_id
  packfile: convert find_pack_entry to object_id
  packfile: abstract away hash constant values
  pack-objects: abstract away hash algorithm
  pack-redundant: abstract away hash algorithm
  tree-walk: avoid hard-coded 20 constant
  tree-walk: convert get_tree_entry_follow_symlinks to object_id
  fsck: convert static functions to struct object_id
  submodule-config: convert structures to object_id
  split-index: convert struct split_index to object_id
  Update struct index_state to use struct object_id
  pack-redundant: convert linked lists to use struct object_id
  index-pack: abstract away hash function constant
  commit: convert uses of get_sha1_hex to get_oid_hex
  dir: convert struct untracked_cache_dir to object_id
  http: eliminate hard-coded constants
  revision: replace use of hard-coded constants
  upload-pack: replace use of several hard-coded constants
  diff: specify abbreviation size in terms of the_hash_algo
  builtin/receive-pack: avoid hard-coded constants for push certs
  builtin/am: convert uses of EMPTY_TREE_SHA1_BIN to the_hash_algo
  builtin/merge: switch tree functions to use object_id
  merge: convert empty tree constant to the_hash_algo
  sequencer: convert one use of EMPTY_TREE_SHA1_HEX
  submodule: convert several uses of EMPTY_TREE_SHA1_HEX
  wt-status: convert two uses of EMPTY_TREE_SHA1_HEX
  builtin/receive-pack: convert one use of EMPTY_TREE_SHA1_HEX
  builtin/reset: convert use of EMPTY_TREE_SHA1_BIN
  sha1_file: convert cached object code to struct object_id
  cache-tree: use is_empty_tree_oid
  sequencer: use the_hash_algo for empty tree object ID
  dir: use the_hash_algo for empty blob object ID
  sha1_file: only expose empty object constants through git_hash_algo
  Update shell scripts to compute empty tree object ID
  add--interactive: compute the empty tree value
  merge-one-file: compute empty blob object ID

 builtin/am.c                         |  8 +--
 builtin/count-objects.c              |  2 +-
 builtin/fsck.c                       |  2 +-
 builtin/index-pack.c                 |  3 +-
 builtin/merge.c                      | 14 ++---
 builtin/pack-objects.c               | 32 +++++------
 builtin/pack-redundant.c             | 62 ++++++++++++----------
 builtin/prune-packed.c               |  2 +-
 builtin/receive-pack.c               |  8 +--
 builtin/reset.c                      |  2 +-
 builtin/rev-parse.c                  |  4 +-
 cache-tree.c                         |  4 +-
 cache.h                              | 25 +++------
 commit.c                             |  4 +-
 diff.c                               | 20 ++++---
 dir.c                                | 25 ++++-----
 dir.h                                |  5 +-
 fsck.c                               | 20 +++----
 git-add--interactive.perl            | 11 +++-
 git-filter-branch.sh                 |  4 +-
 git-merge-one-file.sh                |  2 +-
 git-rebase--interactive.sh           |  4 +-
 http.c                               | 11 ++--
 merge.c                              |  5 +-
 packfile.c                           | 79 +++++++++++++++-------------
 packfile.h                           |  4 +-
 read-cache.c                         | 34 ++++++------
 resolve-undo.c                       |  2 +-
 revision.c                           |  7 +--
 sequencer.c                          |  5 +-
 server-info.c                        |  3 --
 sha1_file.c                          | 69 +++++++++++++-----------
 sha1_name.c                          |  5 +-
 split-index.c                        | 10 ++--
 split-index.h                        |  4 +-
 submodule-config.c                   | 66 +++++++++++------------
 submodule-config.h                   |  7 +--
 submodule.c                          |  6 +--
 t/helper/test-dump-split-index.c     |  4 +-
 t/helper/test-dump-untracked-cache.c |  2 +-
 templates/hooks--pre-commit.sample   |  2 +-
 tree-walk.c                          | 18 +++----
 tree-walk.h                          |  2 +-
 unpack-trees.c                       |  2 +-
 upload-pack.c                        | 18 +++----
 wt-status.c                          |  6 ++-
 46 files changed, 333 insertions(+), 301 deletions(-)

