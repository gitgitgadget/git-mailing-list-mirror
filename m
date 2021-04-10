Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A685C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F1F611C9
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhDJPWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:22:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58480 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234392AbhDJPWq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:22:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4968660426;
        Sat, 10 Apr 2021 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068151;
        bh=JxJ9jB1hgLUu7klD4eHKy0hlVL7GQIh28jirBY20xxI=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Gs5KWsWzG5hD6u9m2NO4YZ1kgdXEsKkcOBI8G3s9ToK9hc8IrM6vLwR7Z4vrKbTyd
         bAUHvcusFsYuIZM/yYgVlp1/1zRZ/cxxOlOshX/W+UR8VOidAtFbneRIxiP5T00I6v
         ZX4FGhtYEFQGTbaeqIoobWAmdSaMRY5fLK3xF2YtVmS/xJos7urd87MkswBn/cBnaG
         kWCsZAGu4u9vCotDuC6vYrheVSVIalambsFBCRYgisPd1acJSD6ATTHCV0XRr/sa10
         nJ0THof95Hh51XhuoFKAkrZYOzpoqzv6jLNkTdSQHjzbGDhn2u3io+w3TKGndegpwq
         n+uhL4+ApAwC1viskQ8c4m6KjKUTDYrsGTaCHQKLZ5AjL6sZ+GKq+yMANsgQxXx+Dd
         ApTRVtuExN6geU/0ZNIpmuIENtVE7t4UBM2W9LaxsVNZD4kFwiVEyRi/WLSKeXKAkf
         NJ1fYDPOBBQLQ4HrXaeGAZprHQK6LCkFnQTbhpf+FF/89uAQ5kv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 00/15] SHA-256 / SHA-1 interop, part 1
Date:   Sat, 10 Apr 2021 15:21:25 +0000
Message-Id: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because I know the first twenty-something weren't enough, here's another
series of SHA-256-related patches.  This is the beginning of the work to
make SHA-256 and SHA-1 repositories interoperate, which of course is
part of the transition plan.

This series introduces code to make struct object_id take a hash
algorithm member and use that for printing the object ID.  This is the
first step to handling multiple hash algorithms in the same binary,
which we'll need if we're going to process both SHA-1 and SHA-256
versions of objects.

The major contributor to the size of this series is the patch to switch
to per-algorithm null OIDs via a null_oid function.  It's certainly
possible there are conflicts with topics in flight, but those should be
easy to resolve (just change "&null_oid" to "null_oid()").

In addition, there's an initial set of patches to allow hashing an
object literally with any algorithm.  Such objects cannot be written
into the object store, but their values can be printed.

This series is available as transition-interop-part-1 from the usual
places and is part of the transition-interop branch (the entirety of the
work) as well.  Be aware that the latter is very, very broken and its
use is not advised at this time.

Future series will likely include some fixes to our testsuite and code
to map objects across hash algorithms.

brian m. carlson (15):
  sha1-file: allow hashing objects literally with any algorithm
  builtin/hash-object: allow literally hashing with a given algorithm
  cache: add an algo member to struct object_id
  Always use oidread to read into struct object_id
  hash: add a function to finalize object IDs
  Use the final_oid_fn to finalize hashing of object IDs
  builtin/pack-redundant: avoid casting buffers to struct object_id
  cache: compare the entire buffer for struct object_id
  hash: set and copy algo field in struct object_id
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
 builtin/fast-export.c                        | 10 +--
 builtin/fast-import.c                        |  8 +-
 builtin/grep.c                               |  2 +-
 builtin/hash-object.c                        | 47 ++++++++----
 builtin/index-pack.c                         |  6 +-
 builtin/ls-files.c                           |  2 +-
 builtin/pack-objects.c                       | 20 ++---
 builtin/pack-redundant.c                     | 28 +++----
 builtin/rebase.c                             |  4 +-
 builtin/receive-pack.c                       |  2 +-
 builtin/show-index.c                         |  4 +-
 builtin/submodule--helper.c                  | 29 +++----
 builtin/unpack-objects.c                     |  7 +-
 builtin/worktree.c                           |  4 +-
 bulk-checkin.c                               |  2 +-
 combine-diff.c                               |  2 +-
 commit-graph.c                               | 25 ++++---
 connect.c                                    |  2 +-
 diff-lib.c                                   |  6 +-
 diff-no-index.c                              |  2 +-
 diff.c                                       |  6 +-
 dir.c                                        |  6 +-
 grep.c                                       |  2 +-
 hash.h                                       | 73 +++++++++++-------
 hex.c                                        | 20 +++--
 http-walker.c                                |  2 +-
 http.c                                       |  2 +-
 log-tree.c                                   |  2 +-
 match-trees.c                                |  2 +-
 merge-ort.c                                  | 20 ++---
 merge-recursive.c                            | 10 +--
 midx.c                                       |  2 +-
 notes-merge.c                                |  2 +-
 notes.c                                      |  9 ++-
 object-file.c                                | 79 +++++++++++++++++---
 object-store.h                               |  3 +
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
 submodule.c                                  | 26 ++++---
 t/helper/test-submodule-nested-repo-config.c |  2 +-
 t/t1007-hash-object.sh                       | 10 +++
 tree-diff.c                                  |  4 +-
 tree-walk.c                                  |  2 +-
 wt-status.c                                  |  4 +-
 xdiff-interface.c                            |  2 +-
 60 files changed, 341 insertions(+), 209 deletions(-)

