Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89BF520958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755765AbdCWNrX (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:47:23 -0400
Received: from siwi.pair.com ([209.68.5.199]:28987 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755322AbdCWNrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:47:20 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E59958466B;
        Thu, 23 Mar 2017 09:47:18 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 0/7] thread lazy_init_name_hash
Date:   Thu, 23 Mar 2017 13:46:58 +0000
Message-Id: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 2 of this patch series addresses the coding
style issues, compile errors in non-threaded builds,
and updated API documentation.


This patch series is a performance optimization for
lazy_init_name_hash() in name-hash.c on very large
repositories.

This change allows lazy_init_name_hash() to optionally
use multiple threads when building the the_index.dir_hash
and the_index.name_hash hashmaps.  The original code path
has been preserved and is used when the repo is small or
the system does not have sufficient CPUs.

A helper command (t/helper/test-lazy-init-name-hash) was
created to demonstrate performance differences and validate
output.  For example, use the '-p' option to compare both
code paths on a large repo.

During our testing on the Windows source tree (3.1M
files, 500K folders, 450MB index) with an 8 (logical)
core machine, we reduced the runtime of lazy_init_name_hash()
from 1.4 to 0.27 seconds.

This patch series replaces my earlier
     * jh/memihash-opt (2017-02-17) 5 commits
patch series.  This series is an improvement over the
original proposal because it completely isolates the changes
in name name-hash.c (rather than having parts in preload-index.c)
and eliminates the need to update/invalidate precomputed hash
values as cache_entries are changed.


Jeff Hostetler (7):
  name-hash: specify initial size for istate.dir_hash table
  hashmap: allow memihash computation to be continued
  hashmap: Add disallow_rehash setting
  hashmap: document memihash_cont, hashmap_disallow_rehash api
  name-hash: perf improvement for lazy_init_name_hash
  name-hash: add test-lazy-init-name-hash
  name-hash: add perf test for lazy_init_name_hash

 Documentation/technical/api-hashmap.txt |  22 ++
 Makefile                                |   1 +
 cache.h                                 |   1 +
 hashmap.c                               |  29 +-
 hashmap.h                               |  25 ++
 name-hash.c                             | 495 +++++++++++++++++++++++++++++++-
 t/helper/test-lazy-init-name-hash.c     | 264 +++++++++++++++++
 t/perf/p0004-lazy-init-name-hash.sh     |  19 ++
 8 files changed, 847 insertions(+), 9 deletions(-)
 create mode 100644 t/helper/test-lazy-init-name-hash.c
 create mode 100644 t/perf/p0004-lazy-init-name-hash.sh

-- 
2.7.4

