Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C093120964
	for <e@80x24.org>; Tue,  4 Apr 2017 21:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbdDDVJC (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 17:09:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:33548 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753722AbdDDVJB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 17:09:01 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C8B5784606;
        Tue,  4 Apr 2017 17:08:59 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 0/4] read-cache: speed up add_index_entry
Date:   Tue,  4 Apr 2017 21:08:43 +0000
Message-Id: <20170404210847.50860-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach add_index_entry_with_check() and has_dir_name()
to avoid index lookups if the given path sorts after
the last entry in the index.

This saves at least 2 binary searches per entry.

This improves performance during checkout and read-tree because
merge_working_tree() and unpack_trees() processes a list of already
sorted entries.

This helps performance on very large repositories.

================
Before and after numbers on index with 1M files.
./p0004-read-tree.sh
0004.2: read-tree (1003037)              3.24(2.46+0.72)
0004.3: switch branches (3038 1003037)   7.53(5.66+1.56)

$ ./p0004-read-tree.sh
0004.2: read-tree (1003040)              2.45(1.79+0.61)
0004.3: switch branches (3041 1003040)   6.65(4.22+1.60)

================
Before and after numbers on index with 100K files.

./p0004-read-tree.sh
0004.2: read-tree (103037)              0.30(0.20+0.08)
0004.3: switch branches (3038 103037)   0.65(0.47+0.16)

$ ./p0004-read-tree.sh
0004.2: read-tree (103040)              0.25(0.16+0.07)
0004.3: switch branches (3041 103040)   0.58(0.44+0.13)
================


Jeff Hostetler (4):
  p0004-read-tree: perf test to time read-tree
  read-cache: add strcmp_offset function
  test-strcmp-offset: created test for strcmp_offset
  read-cache: speed up add_index_entry during checkout

 Makefile                      |  1 +
 cache.h                       |  1 +
 read-cache.c                  | 73 ++++++++++++++++++++++++++++++++++++-
 t/helper/.gitignore           |  1 +
 t/helper/test-strcmp-offset.c | 64 +++++++++++++++++++++++++++++++++
 t/perf/p0004-read-tree.sh     | 84 +++++++++++++++++++++++++++++++++++++++++++
 t/t0065-strcmp-offset.sh      | 11 ++++++
 7 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-strcmp-offset.c
 create mode 100755 t/perf/p0004-read-tree.sh
 create mode 100755 t/t0065-strcmp-offset.sh

-- 
2.9.3

