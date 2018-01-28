Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7661F404
	for <e@80x24.org>; Sun, 28 Jan 2018 17:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeA1RG5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 12:06:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58444 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751288AbeA1RG4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 12:06:56 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 52FCD60402
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517159205;
        bh=GrlG7o94xg9eT7/Sf8hiXakAroWROpBhM0d9UUCun34=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0bkm8O2UsDHELShgu9SjzUEAPDvsiosu5Co6RgSt0+e0dWxbxCmA8Zg/QTe6/wxnx
         jdfxnXdCQKGqX/k2S6ttgp8elLeEdL2cbuujqGQunIXQ45q3b41C3fCBBeuoF6zooX
         lcd5KdC2aaMJfu1zSL3gwX5Slwv3gOnqgiiTT4S1/m4xDo7DfoOo/9HbtvvdNoaVDB
         sHi5BLSxzymUHDVsdcI6hlWIVp9SpCZ0NIwtwtqbEoq1QSRyH+uvOoxJ9jyl5HZVgF
         rrnIXbc8BoFrt6r4HBdZqk1pq7PWb7BhNJ71c4Ikv+ik7+TqOBxVBkX6zi0I1rj+an
         EiESRTKmwyi74Ix27v2kcz9lhkOd3WenwUQzHO0y9bOddbNt5DQpnzWuftBbaArIWt
         /Km+TVNE+XLvU3LofdBB/oHFvR9xWzTKM8sXBMSsHZSNfNwRlStEy9tiVwIJ2TdlGe
         mB9kEhAcVnLiWwHKXbA7XJkHG0RfwBHL9TPeZxql/v2aIRfidS9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 0/2] alternate hash test
Date:   Sun, 28 Jan 2018 17:06:37 +0000
Message-Id: <20180128170639.216397-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series wires up an alternate hash implementation, namely
BLAKE2b-160.  The goal is to allow us to identify tests which rely on
the hash algorithm in use so that we can fix those tests.

For this test, I picked BLAKE2b-160 for a couple reasons:
* Debian ships a libb2-1 package which can be used easily (in other
  words, I was lazy and didn't want to add a crypto implementation just
  for test purposes);
* The API of the libb2 package easily allows arbitrary hash lengths, so
  I didn't have to manage truncation myself;
* Our codebase isn't yet ready for a hash function larger than 20 bytes,
  as there's still more work to do on the object_id conversions.

This isn't an endorsement for or against any particular algorithm
choice, just an artifact of the tools that were easily available to me.
Provoking discussion of which hash to pick for NewHash is explicitly
*not* a goal for this series.  I'm only interested in the ability to
identify and fix tests.

The first patch does no feature detection and just assumes you have
libb2 installed.  For obvious reasons, this series is not meant for
production use.

This series applies on top of the object_id part 11 series I just sent
out.

Below is a list of the prove output indicating which tests failed on my
system with these patches.

Test Summary Report
-------------------
t0002-gitfile.sh                                 (Wstat: 256 Tests: 14 Failed: 3)
  Failed tests:  12-14
  Non-zero exit status: 1
t0005-signals.sh                                 (Wstat: 256 Tests: 5 Failed: 2)
  Failed tests:  4-5
  Non-zero exit status: 1
t0000-basic.sh                                   (Wstat: 256 Tests: 78 Failed: 12)
  Failed tests:  47, 54, 56, 58, 60, 62, 64, 66, 71, 74-76
  Non-zero exit status: 1
t1007-hash-object.sh                             (Wstat: 256 Tests: 38 Failed: 15)
  Failed tests:  6, 8, 10-11, 19-29
  Non-zero exit status: 1
t1011-read-tree-sparse-checkout.sh               (Wstat: 256 Tests: 21 Failed: 3)
  Failed tests:  1-2, 5
  Non-zero exit status: 1
t1300-repo-config.sh                             (Wstat: 256 Tests: 146 Failed: 1)
  Failed test:  144
  Non-zero exit status: 1
t1304-default-acl.sh                             (Wstat: 256 Tests: 4 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t1405-main-ref-store.sh                          (Wstat: 256 Tests: 17 Failed: 1)
  Failed test:  10
  Non-zero exit status: 1
t1411-reflog-show.sh                             (Wstat: 256 Tests: 18 Failed: 6)
  Failed tests:  3-5, 7, 10, 13
  Non-zero exit status: 1
t1450-fsck.sh                                    (Wstat: 256 Tests: 71 Failed: 3)
  Failed tests:  18, 26, 59
  Non-zero exit status: 1
t1507-rev-parse-upstream.sh                      (Wstat: 256 Tests: 28 Failed: 2)
  Failed tests:  25-26
  Non-zero exit status: 1
t1512-rev-parse-disambiguation.sh                (Wstat: 256 Tests: 33 Failed: 19)
  Failed tests:  2-5, 7-12, 16, 22, 26-32
  Non-zero exit status: 1
t1700-split-index.sh                             (Wstat: 256 Tests: 22 Failed: 9)
  Failed tests:  1-2, 5-7, 13-16
  Non-zero exit status: 1
t2011-checkout-invalid-head.sh                   (Wstat: 256 Tests: 10 Failed: 5)
  Failed tests:  3, 6-7, 9-10
  Non-zero exit status: 1
t2015-checkout-unborn.sh                         (Wstat: 256 Tests: 6 Failed: 2)
  Failed tests:  3-4
  Non-zero exit status: 1
t1013-read-tree-submodule.sh                     (Wstat: 256 Tests: 64 Failed: 15)
  Failed tests:  1-2, 4-7, 19-20, 22-25, 30, 34-35
  Non-zero exit status: 1
t2017-checkout-orphan.sh                         (Wstat: 256 Tests: 13 Failed: 7)
  Failed tests:  7-13
  Non-zero exit status: 1
t2020-checkout-detach.sh                         (Wstat: 256 Tests: 24 Failed: 2)
  Failed tests:  23-24
  Non-zero exit status: 1
t2101-update-index-reupdate.sh                   (Wstat: 256 Tests: 7 Failed: 6)
  Failed tests:  1-3, 5-7
  Non-zero exit status: 1
t2107-update-index-basic.sh                      (Wstat: 256 Tests: 9 Failed: 1)
  Failed test:  9
  Non-zero exit status: 1
t2203-add-intent.sh                              (Wstat: 256 Tests: 16 Failed: 4)
  Failed tests:  3, 12, 15-16
  Non-zero exit status: 1
t3033-merge-toplevel.sh                          (Wstat: 256 Tests: 13 Failed: 11)
  Failed tests:  3-13
  Non-zero exit status: 1
t3103-ls-tree-misc.sh                            (Wstat: 256 Tests: 2 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t3201-branch-contains.sh                         (Wstat: 256 Tests: 19 Failed: 1)
  Failed test:  18
  Non-zero exit status: 1
t3301-notes.sh                                   (Wstat: 256 Tests: 134 Failed: 50)
  Failed tests:  10, 18-23, 42-44, 46, 55-57, 60, 65-78
                80, 83-84, 86-91, 93-104
  Non-zero exit status: 1
t2013-checkout-submodule.sh                      (Wstat: 256 Tests: 70 Failed: 16)
  Failed tests:  7-8, 10-13, 19, 25-26, 28-31, 36, 40-41
  Non-zero exit status: 1
t3306-notes-prune.sh                             (Wstat: 256 Tests: 12 Failed: 8)
  Failed tests:  1-2, 4-5, 7, 9, 11-12
  Non-zero exit status: 1
t3308-notes-merge.sh                             (Wstat: 256 Tests: 19 Failed: 13)
  Failed tests:  2, 5-6, 10-19
  Non-zero exit status: 1
t3309-notes-merge-auto-resolve.sh                (Wstat: 256 Tests: 31 Failed: 27)
  Failed tests:  3, 5, 7-31
  Non-zero exit status: 1
t3310-notes-merge-manual-resolve.sh              (Wstat: 256 Tests: 22 Failed: 16)
  Failed tests:  2-6, 8-9, 13-21
  Non-zero exit status: 1
t3305-notes-fanout.sh                            (Wstat: 256 Tests: 6 Failed: 1)
  Failed test:  6
  Non-zero exit status: 1
t3402-rebase-merge.sh                            (Wstat: 256 Tests: 12 Failed: 4)
  Failed tests:  8, 10-12
  Non-zero exit status: 1
t3311-notes-merge-fanout.sh                      (Wstat: 256 Tests: 24 Failed: 8)
  Failed tests:  2, 7, 9, 12, 14, 16, 18, 23
  Non-zero exit status: 1
t3404-rebase-interactive.sh                      (Wstat: 256 Tests: 98 Failed: 11)
  Failed tests:  15, 68-71, 89-92, 94, 96
  Non-zero exit status: 1
t3421-rebase-topology-linear.sh                  (Wstat: 256 Tests: 76 Failed: 4)
  Failed tests:  73-76
  Non-zero exit status: 1
t3503-cherry-pick-root.sh                        (Wstat: 256 Tests: 6 Failed: 3)
  Failed tests:  3-5
  Non-zero exit status: 1
t3501-revert-cherry-pick.sh                      (Wstat: 256 Tests: 12 Failed: 2)
  Failed tests:  8-9
  Non-zero exit status: 1
t3506-cherry-pick-ff.sh                          (Wstat: 256 Tests: 11 Failed: 2)
  Failed tests:  10-11
  Non-zero exit status: 1
t3702-add-edit.sh                                (Wstat: 256 Tests: 3 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t3701-add-interactive.sh                         (Wstat: 256 Tests: 46 Failed: 9)
  Failed tests:  2, 4-5, 9, 21, 29, 31, 33, 37
  Non-zero exit status: 1
t3905-stash-include-untracked.sh                 (Wstat: 256 Tests: 18 Failed: 2)
  Failed tests:  3, 8
  Non-zero exit status: 1
t4002-diff-basic.sh                              (Wstat: 256 Tests: 63 Failed: 14)
  Failed tests:  45-58
  Non-zero exit status: 1
t4007-rename-3.sh                                (Wstat: 256 Tests: 8 Failed: 5)
  Failed tests:  3-5, 7-8
  Non-zero exit status: 1
t4008-diff-break-rewrite.sh                      (Wstat: 256 Tests: 14 Failed: 9)
  Failed tests:  3-4, 6-7, 9-11, 13-14
  Non-zero exit status: 1
t4010-diff-pathspec.sh                           (Wstat: 256 Tests: 17 Failed: 6)
  Failed tests:  3-6, 9-10
  Non-zero exit status: 1
t4011-diff-symlink.sh                            (Wstat: 256 Tests: 8 Failed: 1)
  Failed test:  8
  Non-zero exit status: 1
t4013-diff-various.sh                            (Wstat: 256 Tests: 172 Failed: 131)
  Failed tests:  6-13, 15, 17, 19, 21, 26-30, 32, 34, 36
                38, 40, 42-46, 51-79, 81-134, 136-139, 142-148
                153-154, 158-162, 169-171
  Non-zero exit status: 1
t4014-format-patch.sh                            (Wstat: 256 Tests: 142 Failed: 2)
  Failed tests:  53-54
  Non-zero exit status: 1
t4015-diff-whitespace.sh                         (Wstat: 256 Tests: 77 Failed: 11)
  Failed tests:  1-2, 53, 57-58, 60-65
  Non-zero exit status: 1
t4020-diff-external.sh                           (Wstat: 256 Tests: 25 Failed: 2)
  Failed tests:  18, 23
  Non-zero exit status: 1
t4022-diff-rewrite.sh                            (Wstat: 256 Tests: 11 Failed: 2)
  Failed tests:  3-4
  Non-zero exit status: 1
t4029-diff-trailing-space.sh                     (Wstat: 256 Tests: 1 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t4030-diff-textconv.sh                           (Wstat: 256 Tests: 19 Failed: 1)
  Failed test:  19
  Non-zero exit status: 1
t4033-diff-patience.sh                           (Wstat: 256 Tests: 4 Failed: 2)
  Failed tests:  2, 4
  Non-zero exit status: 1
t4034-diff-words.sh                              (Wstat: 256 Tests: 41 Failed: 33)
  Failed tests:  3-8, 10-11, 13-15, 17-20, 22-39
  Non-zero exit status: 1
t4039-diff-assume-unchanged.sh                   (Wstat: 256 Tests: 4 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t4042-diff-textconv-caching.sh                   (Wstat: 256 Tests: 7 Failed: 5)
  Failed tests:  2-6
  Non-zero exit status: 1
t4044-diff-index-unique-abbrev.sh                (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t4045-diff-relative.sh                           (Wstat: 256 Tests: 17 Failed: 8)
  Failed tests:  2-5, 14-17
  Non-zero exit status: 1
t4048-diff-combined-binary.sh                    (Wstat: 256 Tests: 14 Failed: 11)
  Failed tests:  2-4, 6-8, 10-14
  Non-zero exit status: 1
t4050-diff-histogram.sh                          (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  1, 3
  Non-zero exit status: 1
t4054-diff-bogus-tree.sh                         (Wstat: 256 Tests: 14 Failed: 2)
  Failed tests:  3-4
  Non-zero exit status: 1
t4060-diff-submodule-option-diff-format.sh       (Wstat: 256 Tests: 47 Failed: 28)
  Failed tests:  2-3, 6-7, 10-14, 16, 22-23, 26-30, 32-34
                36-37, 39-41, 43, 46-47
  Non-zero exit status: 1
t3903-stash.sh                                   (Wstat: 256 Tests: 90 Failed: 18)
  Failed tests:  2, 14, 20-21, 24-29, 32, 35, 38, 46, 48
                57, 62-63
  Non-zero exit status: 1
t4151-am-abort.sh                                (Wstat: 256 Tests: 18 Failed: 7)
  Failed tests:  12-18
  Non-zero exit status: 1
t4202-log.sh                                     (Wstat: 256 Tests: 80 Failed: 11)
  Failed tests:  8, 19-23, 62-63, 78-80
  Non-zero exit status: 1
t4205-log-pretty-formats.sh                      (Wstat: 256 Tests: 57 Failed: 2)
  Failed tests:  51-52
  Non-zero exit status: 1
t4208-log-magic-pathspec.sh                      (Wstat: 256 Tests: 17 Failed: 1)
  Failed test:  9
  Non-zero exit status: 1
t4211-line-log.sh                                (Wstat: 256 Tests: 37 Failed: 17)
  Failed tests:  2-18
  Non-zero exit status: 1
t4300-merge-tree.sh                              (Wstat: 256 Tests: 20 Failed: 12)
  Failed tests:  2, 5, 7, 9-10, 12, 14-15, 17-20
  Non-zero exit status: 1
t5150-request-pull.sh                            (Wstat: 256 Tests: 7 Failed: 6)
  Failed tests:  1, 3-7
  Non-zero exit status: 1
t5300-pack-object.sh                             (Wstat: 256 Tests: 38 Failed: 3)
  Failed tests:  36-38
  Non-zero exit status: 1
t5306-pack-nobase.sh                             (Wstat: 256 Tests: 4 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t5308-pack-detect-duplicates.sh                  (Wstat: 256 Tests: 5 Failed: 3)
  Failed tests:  1-2, 4
  Non-zero exit status: 1
t5309-pack-delta-cycles.sh                       (Wstat: 256 Tests: 6 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t5313-pack-bounds-checks.sh                      (Wstat: 256 Tests: 8 Failed: 1)
  Failed test:  7
  Non-zero exit status: 1
t5504-fetch-receive-strict.sh                    (Wstat: 256 Tests: 12 Failed: 2)
  Failed tests:  10-11
  Non-zero exit status: 1
t5512-ls-remote.sh                               (Wstat: 256 Tests: 26 Failed: 3)
  Failed tests:  21-22, 24
  Non-zero exit status: 1
t5515-fetch-merge-logic.sh                       (Wstat: 256 Tests: 65 Failed: 64)
  Failed tests:  2-65
  Non-zero exit status: 1
t5521-pull-options.sh                            (Wstat: 256 Tests: 18 Failed: 10)
  Failed tests:  2-11
  Non-zero exit status: 1
t5516-fetch-push.sh                              (Wstat: 256 Tests: 89 Failed: 9)
  Failed tests:  34, 78-83, 88-89
  Non-zero exit status: 1
t5520-pull.sh                                    (Wstat: 256 Tests: 64 Failed: 4)
  Failed tests:  2-3, 6, 58
  Non-zero exit status: 1
t6000-rev-list-misc.sh                           (Wstat: 256 Tests: 10 Failed: 1)
  Failed test:  8
  Non-zero exit status: 1
t6024-recursive-merge.sh                         (Wstat: 256 Tests: 6 Failed: 3)
  Failed tests:  3-5
  Non-zero exit status: 1
t6300-for-each-ref.sh                            (Wstat: 256 Tests: 205 Failed: 10)
  Failed tests:  83, 189-196, 199
  Non-zero exit status: 1
t6500-gc.sh                                      (Wstat: 256 Tests: 8 Failed: 3)
  Failed tests:  6-8
  Non-zero exit status: 1
t6030-bisect-porcelain.sh                        (Wstat: 256 Tests: 71 Failed: 18)
  Failed tests:  19, 22-27, 30, 32, 37, 41, 45-47, 53-56
  Non-zero exit status: 1
t7102-reset.sh                                   (Wstat: 256 Tests: 30 Failed: 13)
  Failed tests:  11, 13-19, 23-24, 26-28
  Non-zero exit status: 1
t7106-reset-unborn-branch.sh                     (Wstat: 256 Tests: 7 Failed: 4)
  Failed tests:  2, 4-5, 7
  Non-zero exit status: 1
t7003-filter-branch.sh                           (Wstat: 256 Tests: 42 Failed: 2)
  Failed tests:  34-35
  Non-zero exit status: 1
t7201-co.sh                                      (Wstat: 256 Tests: 36 Failed: 33)
  Failed tests:  2, 4-25, 27-36
  Non-zero exit status: 1
t7063-status-untracked-cache.sh                  (Wstat: 256 Tests: 43 Failed: 14)
  Failed tests:  5, 7, 9, 11, 13-14, 16-17, 19, 22, 26, 30
                36, 40
  Non-zero exit status: 1
t7112-reset-submodule.sh                         (Wstat: 256 Tests: 78 Failed: 15)
  Failed tests:  1-2, 4-7, 19-20, 22-25, 30, 34-35
  Non-zero exit status: 1
t7507-commit-verbose.sh                          (Wstat: 256 Tests: 44 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t7506-status-submodule.sh                        (Wstat: 256 Tests: 40 Failed: 2)
  Failed tests:  31-32
  Non-zero exit status: 1
t7600-merge.sh                                   (Wstat: 256 Tests: 56 Failed: 1)
  Failed test:  7
  Non-zero exit status: 1
t7607-merge-overwrite.sh                         (Wstat: 256 Tests: 18 Failed: 2)
  Failed tests:  14, 18
  Non-zero exit status: 1
t9300-fast-import.sh                             (Wstat: 256 Tests: 183 Failed: 19)
  Failed tests:  17, 32, 35, 50, 59, 61-66, 68-69, 71-72
                74, 174, 176, 178
  Non-zero exit status: 1
t9500-gitweb-standalone-no-errors.sh             (Wstat: 256 Tests: 118 Failed: 1)
  Failed test:  118
  Non-zero exit status: 1
t9903-bash-prompt.sh                             (Wstat: 256 Tests: 66 Failed: 53)
  Failed tests:  4, 6-10, 14-34, 36, 39-62, 65
  Non-zero exit status: 1

brian m. carlson (2):
  Base test implementation for short BLAKE2b support
  Switch default hash algorithm to short BLAKE2b for testing

 Makefile                 |  3 +++
 cache.h                  | 16 ++++++++++++++
 hash.h                   |  9 +++++++-
 repository.c             |  2 +-
 setup.c                  |  2 +-
 sha1_file.c              | 33 ++++++++++++++++++++++++++++
 t/helper/test-sblake2b.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh            |  4 ++--
 8 files changed, 120 insertions(+), 5 deletions(-)
 create mode 100644 t/helper/test-sblake2b.c

