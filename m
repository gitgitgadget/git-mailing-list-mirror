Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E7A200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeEFXSK (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41032 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751625AbeEFXSI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 80A2260444;
        Sun,  6 May 2018 23:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648678;
        bh=oV08iUGdR9nFKPIddaJW0QFT9UUHh85M2RMA5dEkpQM=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gVYNyYIcDsBtMDLp4MwntXdPe266Rao0GjfyR+JUYijP6omHZGJyYSYLb7UnmutAi
         4V8YRP+jMx+Cy8FlNb3HTxT3I6Ruhs5Uazg6s4/piCWnZZnjV34PvNqDZT1uqNUUiZ
         Fd8XgSlWnzLHww4HUnSpjmmBdRoyxLjeN4EtD+yKvmjKqCCdcCyY/ftHdGmLHdNgNT
         aWwqfodnzlMarUykYE5J833QXyrkFpGO6MPaQve2Ca8WIb7BFd0yZTre8y9GHimXvb
         hL5rNefavPUI0JcKr3THVzN9o2D+gn4+s3GGb3QaaLS/yanBnMVaaUTnon9ffE70NF
         mYDbFdpSqGE655wyyHLe+RNqm023ZVGJnsG29eNux5I9fRmYUQe2SnqijmvkRncUbJ
         4gjlUdSSXu0sQaFI+GcU2y8WrXqM5RAU2EdXzYbSq7lbhSPYCftW99O/ipwf2H1qbk
         jpoIOtF/6BH8qDlwLt4/KodoJmLknhiz7SXT4UgHDJBSfdXQIeE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 00/28] Hash-independent tests (part 2)
Date:   Sun,  6 May 2018 23:17:24 +0000
Message-Id: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part 2 in the series to make tests hash independent.

This series introduces an SHA1 prerequisite which checks if the hash in
use is SHA-1, and can be used to skip the test if it is not.
Additionally, because NewHash will be 256-bit, I introduced aliases for
the test constants $_x40 and $_z40 which will be less confusing when the
hash isn't 40 hex characters long.  I opted to leave the old names in
place for the moment to prevent any potential conflicts with other
series and will clean up any stragglers later.

Several tests are skipped because of SHA-1-specific dependencies: some
of these are core tests which test basic expected hash values, some
depend on colliding short names, and some depend on specially named
object (the pack tests).

Elsewhere, tests are modified to compute values using git hash-object
and git rev-parse.  There is one cleanup patch that fixes indentation so
we can use an indented heredoc in the following patch.

The order in this series is by patch type, then roughly by test number.

All of these tests pass with an alternate 160-bit hash as well as SHA-1.
An additional series cleaning up the remainder of the tests is required
to make the entire testsuite pass with an alternate 160-bit hash.

brian m. carlson (28):
  t/test-lib: add an SHA1 prerequisite
  t/test-lib: introduce ZERO_OID
  t: switch $_z40 to $ZERO_OID
  t/test-lib: introduce FULL_HEX
  t: switch $_x40 to $FULL_HEX
  t0000: annotate with SHA1 prerequisite
  t1007: annotate with SHA1 prerequisite
  t1512: skip test if not using SHA-1
  t4044: skip test if not using SHA-1
  t: skip pack tests if not using SHA-1
  t2203: abstract away SHA-1-specific constants
  t3103: abstract away SHA-1-specific constants
  t3702: abstract away SHA-1-specific constants
  t3905: abstract away SHA-1-specific constants
  t4007: abstract away SHA-1-specific constants
  t4008: abstract away SHA-1-specific constants
  t4014: abstract away SHA-1-specific constants
  t4020: abstract away SHA-1-specific constants
  t4022: abstract away SHA-1-specific constants
  t4029: fix test indentation
  t4029: abstract away SHA-1-specific constants
  t4030: abstract away SHA-1-specific constants
  t/lib-diff-alternative: abstract away SHA-1-specific constants
  t4205: sort log output in a hash-independent way
  t4042: abstract away SHA-1-specific constants
  t4045: abstract away SHA-1-specific constants
  t4208: abstract away SHA-1-specific constants
  t5300: abstract away SHA-1-specific constants

 t/diff-lib.sh                       |  4 +-
 t/lib-diff-alternative.sh           | 12 ++++--
 t/t0000-basic.sh                    | 24 ++++++------
 t/t0090-cache-tree.sh               |  2 +-
 t/t1000-read-tree-m-3way.sh         |  2 +-
 t/t1001-read-tree-m-2way.sh         |  2 +-
 t/t1002-read-tree-m-u-2way.sh       |  2 +-
 t/t1006-cat-file.sh                 |  8 ++--
 t/t1007-hash-object.sh              | 16 ++++----
 t/t1012-read-tree-df.sh             |  2 +-
 t/t1400-update-ref.sh               |  2 +-
 t/t1407-worktree-ref-store.sh       |  8 ++--
 t/t1450-fsck.sh                     |  4 +-
 t/t1501-work-tree.sh                |  6 +--
 t/t1512-rev-parse-disambiguation.sh |  6 +++
 t/t1601-index-bogus.sh              |  2 +-
 t/t1700-split-index.sh              |  2 +-
 t/t2011-checkout-invalid-head.sh    |  2 +-
 t/t2025-worktree-add.sh             |  8 ++--
 t/t2027-worktree-list.sh            |  2 +-
 t/t2107-update-index-basic.sh       |  4 +-
 t/t2201-add-update-typechange.sh    | 16 ++++----
 t/t2203-add-intent.sh               | 14 +++----
 t/t3100-ls-tree-restrict.sh         |  2 +-
 t/t3101-ls-tree-dirname.sh          |  2 +-
 t/t3103-ls-tree-misc.sh             |  3 +-
 t/t3200-branch.sh                   |  4 +-
 t/t3510-cherry-pick-sequence.sh     |  8 ++--
 t/t3702-add-edit.sh                 |  7 ++--
 t/t3905-stash-include-untracked.sh  | 12 +++---
 t/t4002-diff-basic.sh               |  2 +-
 t/t4006-diff-mode.sh                |  2 +-
 t/t4007-rename-3.sh                 | 17 +++++----
 t/t4008-diff-break-rewrite.sh       | 59 ++++++++++++++++-------------
 t/t4014-format-patch.sh             | 11 +++---
 t/t4020-diff-external.sh            | 18 +++++----
 t/t4022-diff-rewrite.sh             |  5 ++-
 t/t4027-diff-submodule.sh           |  6 +--
 t/t4029-diff-trailing-space.sh      | 38 ++++++++++---------
 t/t4030-diff-textconv.sh            |  5 ++-
 t/t4042-diff-textconv-caching.sh    | 16 +++++---
 t/t4044-diff-index-unique-abbrev.sh |  6 +++
 t/t4045-diff-relative.sh            |  6 ++-
 t/t4046-diff-unmerged.sh            | 14 +++----
 t/t4054-diff-bogus-tree.sh          | 12 +++---
 t/t4058-diff-duplicates.sh          | 12 +++---
 t/t4150-am.sh                       |  4 +-
 t/t4200-rerere.sh                   |  2 +-
 t/t4201-shortlog.sh                 |  2 +-
 t/t4205-log-pretty-formats.sh       |  8 ++--
 t/t4208-log-magic-pathspec.sh       |  3 +-
 t/t5150-request-pull.sh             |  2 +-
 t/t5300-pack-object.sh              |  8 ++--
 t/t5308-pack-detect-duplicates.sh   |  6 +++
 t/t5309-pack-delta-cycles.sh        |  6 +++
 t/t5516-fetch-push.sh               | 22 +++++------
 t/t5527-fetch-odd-refs.sh           |  2 +-
 t/t5571-pre-push-hook.sh            |  8 ++--
 t/t6006-rev-list-format.sh          |  4 +-
 t/t6012-rev-list-simplify.sh        |  2 +-
 t/t6111-rev-list-treesame.sh        |  2 +-
 t/t6120-describe.sh                 |  2 +-
 t/t6300-for-each-ref.sh             |  2 +-
 t/t6301-for-each-ref-errors.sh      |  2 +-
 t/t7009-filter-branch-null-sha1.sh  |  2 +-
 t/t7011-skip-worktree-reading.sh    |  2 +-
 t/t7064-wtstatus-pv2.sh             | 58 ++++++++++++++--------------
 t/t7506-status-submodule.sh         |  2 +-
 t/t9010-svn-fe.sh                   | 14 +++----
 t/t9300-fast-import.sh              |  6 +--
 t/test-lib.sh                       | 11 +++++-
 71 files changed, 331 insertions(+), 268 deletions(-)

