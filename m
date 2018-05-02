Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD0821847
	for <e@80x24.org>; Wed,  2 May 2018 00:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeEBA0V (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:26:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37592 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751825AbeEBA0U (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DCC2160129;
        Wed,  2 May 2018 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220779;
        bh=oMWoVUWTuElibP/YbSkbki8hCNqek2C92d7s2T2redk=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BpnYfTQ7roxQpPGNI2UFZjaAzjLAngoRKVJ42J8rCF9YM6wutaxEfvI/FnJ3eiYuo
         X0E7ulewAmc6VhQZiQKO9HcIVldbAClb/fr6cicwt52xN0TrDvX4FhyfA3PGb7MYat
         vyuJoUWhFX9tOVgm9X8ehs6Eoa8zXLRJPecrEzqGqDocWLBnZqzhtjyi5gqI02/q5E
         kDgGLwPAa6jSmx8YGqKeSCY0S9gtQ+pXeWpgB25bb72gsUpD23587vgrEWh5DYH3eA
         SIfJGQKdnOhkuXaAg6u1tL+H1gf8KpP910KQ3+qR3k75DBlNz69+NX/ymhbT7qEuG5
         DpM2g9+AC9kiceoWrFmthFwVqNFBgHBk35fAF3qF1FSBaAXtO21/RO5TG+GgPzZbB6
         cFT3MFlNPJbYT3oidix70AGO2EspJN3vk8afix9FqCu47keJwu1B6lL6lU6RMaz+UU
         t9gCSNCpOX+2dSG3SEvn9NPxsXArnWvv09A7o0Iytv0RvgFq67H
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 00/42] object_id part 13
Date:   Wed,  2 May 2018 00:25:28 +0000
Message-Id: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
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

Changes from v1:
* Add missing sign-off.
* Removed unneeded braces from init_pack_info.
* Express 51 in terms of the_hash_algo->hexsz.
* Fix comments referring to SHA-1.
* Update commit messages as suggested.
* Add and use empty_tree_oid_hex and empty_blob_oid_hex.

brian m. carlson (42):
  cache: add a function to read an object ID from a buffer
  server-info: remove unused members from struct pack_info
  Remove unused member in struct object_context
  packfile: remove unused member from struct pack_entry
  packfile: convert has_sha1_pack to object_id
  sha1-file: convert freshen functions to object_id
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
  sha1-file: add functions for hex empty tree and blob OIDs
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
 builtin/pack-redundant.c             | 62 +++++++++++----------
 builtin/prune-packed.c               |  2 +-
 builtin/receive-pack.c               |  8 +--
 builtin/reset.c                      |  2 +-
 builtin/rev-parse.c                  |  4 +-
 cache-tree.c                         |  4 +-
 cache.h                              | 28 ++++------
 commit.c                             |  4 +-
 diff.c                               | 20 ++++---
 dir.c                                | 25 ++++-----
 dir.h                                |  5 +-
 fsck.c                               | 20 +++----
 git-add--interactive.perl            | 11 +++-
 git-filter-branch.sh                 |  4 +-
 git-merge-one-file.sh                |  2 +-
 git-rebase--interactive.sh           |  4 +-
 http.c                               | 13 ++---
 merge.c                              |  5 +-
 packfile.c                           | 79 ++++++++++++++-------------
 packfile.h                           |  4 +-
 read-cache.c                         | 34 ++++++------
 resolve-undo.c                       |  2 +-
 revision.c                           |  7 +--
 sequencer.c                          |  4 +-
 server-info.c                        |  9 +---
 sha1-file.c                          | 81 +++++++++++++++++-----------
 sha1-name.c                          |  5 +-
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
 wt-status.c                          |  4 +-
 46 files changed, 348 insertions(+), 306 deletions(-)

