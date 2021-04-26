Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C683C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C54611CD
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhDZBEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41808 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231566AbhDZBEk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:40 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 64CEA6044F;
        Mon, 26 Apr 2021 01:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399009;
        bh=/BPU5d4vW6FMwXZHEMVcyXATrb3ZPVyCoFKIycmZ7nU=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=aaJdZuc++DUA7jbu4rkMMlj8fcgvGxFzyPR2x8AlZ6CkGww/eDK/9ih89BI0zcOD/
         RCef6FRNzxf6T3hoNoX5mhQQi0XHd26U+/g/ZAJgFB3aA4gN/Mk+fj7U/VbwJ28Ery
         ewiTPRboLgrlwsEbGNyrBoHSj4rRDdUvu8hN1b9SFvl/v+PcH5nFdH9JnwWzl60nDi
         8MUubr8QN/ebGQnNwxoYuzPsmOa0ghfxNyF3t3+KPp1aNE3iZGL5lLtrEqyYpYt4rr
         gfCMBQxofTkoThAqsR9WAZfFmILBvzkOrjY0uG4n965B3nKtrNO7uEFvE6lZ6LerCZ
         O1oljb+I8RD/0bJenHA8OOPPUzio2G+Yjvudg/GZxbGnuvttO5svtfoAL3XFoKRORC
         flMw0nkNZS0+VCE6JizbgWQptPOqX/7ChKEjx3hgbQMpEW9Ohc+vRNNHX9kfThJlBB
         nzpRUG4opI35WtPmRFHsV7/sibLES3MEtazer7ZBkTPqN0MwVEp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/13] SHA-256 / SHA-1 interop, part 1
Date:   Mon, 26 Apr 2021 01:02:48 +0000
Message-Id: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces some preparatory work for SHA-256 / SHA-1
interoperability.

Changes from v1:
* Drop initial two patches.
* Fix a test failure.
* Include performance measurements.
* Change the algorithm used to compare object IDs to avoid comparing the
  entire buffer.
* Fix commit message section now that struct object_id is defined
  elsewhere.
* Use designated initializers.
* Consolidate two patches that are now logically one.

brian m. carlson (13):
  hash: add an algo member to struct object_id
  Always use oidread to read into struct object_id
  http-push: set algorithm when reading object ID
  hash: add a function to finalize object IDs
  Use the final_oid_fn to finalize hashing of object IDs
  builtin/pack-redundant: avoid casting buffers to struct object_id
  hash: set, copy, and use algo field in struct object_id
  hash: provide per-algorithm null OIDs
  builtin/show-index: set the algorithm for object IDs
  commit-graph: don't store file hashes as struct object_id
  builtin/pack-objects: avoid using struct object_id for pack hash
  hex: default to the_hash_algo on zero algorithm value
  hex: print objects using the hash algorithm member

 archive.c                                    |  6 +-
 blame.c                                      |  2 +-
 branch.c                                     |  2 +-
 builtin/checkout.c                           |  6 +-
 builtin/clone.c                              |  2 +-
 builtin/describe.c                           |  2 +-
 builtin/diff.c                               |  2 +-
 builtin/fast-export.c                        | 10 +-
 builtin/fast-import.c                        |  8 +-
 builtin/grep.c                               |  2 +-
 builtin/index-pack.c                         |  6 +-
 builtin/ls-files.c                           |  2 +-
 builtin/pack-objects.c                       | 20 ++--
 builtin/pack-redundant.c                     | 28 +++---
 builtin/rebase.c                             |  4 +-
 builtin/receive-pack.c                       |  2 +-
 builtin/show-index.c                         |  4 +-
 builtin/submodule--helper.c                  | 29 +++---
 builtin/unpack-objects.c                     |  7 +-
 builtin/worktree.c                           |  4 +-
 bulk-checkin.c                               |  2 +-
 combine-diff.c                               |  2 +-
 commit-graph.c                               | 25 ++---
 connect.c                                    |  2 +-
 diff-lib.c                                   |  6 +-
 diff-no-index.c                              |  2 +-
 diff.c                                       |  6 +-
 dir.c                                        |  6 +-
 grep.c                                       |  2 +-
 hash.h                                       | 98 +++++++++++++-------
 hex.c                                        | 20 +++-
 http-push.c                                  |  2 +
 http-walker.c                                |  2 +-
 http.c                                       |  2 +-
 log-tree.c                                   |  2 +-
 match-trees.c                                |  2 +-
 merge-ort.c                                  | 20 ++--
 merge-recursive.c                            | 10 +-
 midx.c                                       |  2 +-
 notes-merge.c                                |  2 +-
 notes.c                                      |  9 +-
 object-file.c                                | 65 +++++++++++--
 parse-options-cb.c                           |  2 +-
 range-diff.c                                 |  2 +-
 read-cache.c                                 |  4 +-
 refs.c                                       |  4 +-
 refs/debug.c                                 |  2 +-
 refs/files-backend.c                         |  2 +-
 reset.c                                      |  2 +-
 sequencer.c                                  |  4 +-
 split-index.c                                |  2 +-
 submodule-config.c                           |  2 +-
 submodule.c                                  | 26 +++---
 t/helper/test-submodule-nested-repo-config.c |  2 +-
 tree-diff.c                                  |  4 +-
 tree-walk.c                                  |  2 +-
 wt-status.c                                  |  4 +-
 xdiff-interface.c                            |  2 +-
 58 files changed, 305 insertions(+), 198 deletions(-)

Diff-intervalle contre v1 :
 1:  e1e9764fb3 !  1:  f5c0c3fbc4 cache: add an algo member to struct object_id
    @@ Metadata
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Commit message ##
    -    cache: add an algo member to struct object_id
    +    hash: add an algo member to struct object_id
     
         Now that we're working with multiple hash algorithms in the same repo,
         it's best if we label each object ID with its algorithm so we can
         determine how to format a given object ID. Add a member called algo to
         struct object_id.
     
    +    Performance testing on object ID-heavy workloads doesn't reveal a clear
    +    change in performance.  Out of performance tests t0001 and t1450, there
    +    are slight variations in performance both up and down, but all
    +    measurements are within the margin of error.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## hash.h ##
 2:  49c7f019b5 =  2:  208c133f60 Always use oidread to read into struct object_id
 3:  80882322ee =  3:  0a172e363a http-push: set algorithm when reading object ID
 4:  25fda43ebb =  4:  f8392b49e3 hash: add a function to finalize object IDs
 5:  c2bf775951 =  5:  a813465c5c Use the final_oid_fn to finalize hashing of object IDs
 6:  0906dc5a23 =  6:  3382eed81e builtin/pack-redundant: avoid casting buffers to struct object_id
 7:  438c559c19 <  -:  ---------- cache: compare the entire buffer for struct object_id
 8:  6373a0a39a <  -:  ---------- hash: set and copy algo field in struct object_id
 -:  ---------- >  7:  7f109a5717 hash: set, copy, and use algo field in struct object_id
 9:  4c6e8b5568 !  8:  c69e47253c hash: provide per-algorithm null OIDs
    @@ hash.h: static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
     -extern const struct object_id null_oid;
     +const struct object_id *null_oid(void);
      
    - static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
    + static inline int hashcmp_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
      {
     @@ hash.h: static inline int oideq(const struct object_id *oid1, const struct object_id *oi
      
    @@ object-file.c
      
     -const struct object_id null_oid;
      static const struct object_id empty_tree_oid = {
    - 	EMPTY_TREE_SHA1_BIN_LITERAL,
    - 	GIT_HASH_SHA1,
    + 	.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
    + 	.algo = GIT_HASH_SHA1,
     @@ object-file.c: static const struct object_id empty_blob_oid = {
    - 	EMPTY_BLOB_SHA1_BIN_LITERAL,
    - 	GIT_HASH_SHA1,
    + 	.hash = EMPTY_BLOB_SHA1_BIN_LITERAL,
    + 	.algo = GIT_HASH_SHA1,
      };
    -+const struct object_id null_oid_sha1 = {
    -+	{0}, GIT_HASH_SHA1,
    ++static const struct object_id null_oid_sha1 = {
    ++	.hash = {0},
    ++	.algo = GIT_HASH_SHA1,
     +};
      static const struct object_id empty_tree_oid_sha256 = {
    - 	EMPTY_TREE_SHA256_BIN_LITERAL,
    - 	GIT_HASH_SHA256,
    + 	.hash = EMPTY_TREE_SHA256_BIN_LITERAL,
    + 	.algo = GIT_HASH_SHA256,
     @@ object-file.c: static const struct object_id empty_blob_oid_sha256 = {
    - 	EMPTY_BLOB_SHA256_BIN_LITERAL,
    - 	GIT_HASH_SHA256,
    + 	.hash = EMPTY_BLOB_SHA256_BIN_LITERAL,
    + 	.algo = GIT_HASH_SHA256,
      };
     +static const struct object_id null_oid_sha256 = {
    -+	{0}, GIT_HASH_SHA256,
    ++	.hash = {0},
    ++	.algo = GIT_HASH_SHA256,
     +};
      
      static void git_hash_sha1_init(git_hash_ctx *ctx)
10:  b277bc3886 =  9:  1441319169 builtin/show-index: set the algorithm for object IDs
11:  04d410fa49 = 10:  833db41082 commit-graph: don't store file hashes as struct object_id
12:  5d7ed1848c = 11:  d560b8b0da builtin/pack-objects: avoid using struct object_id for pack hash
13:  8de052f576 = 12:  3a4633d99c hex: default to the_hash_algo on zero algorithm value
14:  d5ea997cde = 13:  e9cba50ccb hex: print objects using the hash algorithm member
