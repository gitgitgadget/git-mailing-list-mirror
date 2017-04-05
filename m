Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC5620966
	for <e@80x24.org>; Wed,  5 Apr 2017 17:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbdDERjd (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 13:39:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:55031 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753605AbdDERiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 13:38:19 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 095D58464F;
        Wed,  5 Apr 2017 13:38:17 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 0/4] read-cache: speed up add_index_entry
Date:   Wed,  5 Apr 2017 17:38:05 +0000
Message-Id: <20170405173809.3098-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

[This is labeled as version 5 because of a cut-n-paste
accident where my first version of this patch was labeled
version 4.]

This version adds more perf tests to p0004-read-tree.sh

================
Teach add_index_entry_with_check() and has_dir_name()
to avoid index lookups if the given path sorts after
the last entry in the index.

This saves at least 2 binary searches per entry.

This improves performance during checkout and read-tree because
merge_working_tree() and unpack_trees() processes a list of already
sorted entries.

This helps performance on very large repositories.

================
Before and after numbers on index with 1M files
./p0004-read-tree.sh
0004.2: read-tree work1 (1003037)          3.21(2.54+0.62)
0004.3: switch base work1 (3038 1003037)   7.49(5.39+1.84)
0004.5: switch work1 work2 (1003037)       11.91(8.38+3.00)
0004.6: switch commit aliases (1003037)    12.22(8.30+3.06)

./p0004-read-tree.sh
0004.2: read-tree work1 (1003040)          2.40(1.65+0.73)
0004.3: switch base work1 (3041 1003040)   6.07(4.12+1.66)
0004.5: switch work1 work2 (1003040)       10.23(6.76+2.92)
0004.6: switch commit aliases (1003040)    10.53(6.97+2.83)
================

Jeff Hostetler (4):
  p0004-read-tree: perf test to time read-tree
  read-cache: add strcmp_offset function
  test-strcmp-offset: created test for strcmp_offset
  read-cache: speed up add_index_entry during checkout

 Makefile                      |   1 +
 cache.h                       |   1 +
 read-cache.c                  |  73 +++++++++++++++++++++++++-
 t/helper/.gitignore           |   1 +
 t/helper/test-strcmp-offset.c |  64 +++++++++++++++++++++++
 t/perf/p0004-read-tree.sh     | 116 ++++++++++++++++++++++++++++++++++++++++++
 t/t0065-strcmp-offset.sh      |  11 ++++
 7 files changed, 266 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-strcmp-offset.c
 create mode 100755 t/perf/p0004-read-tree.sh
 create mode 100755 t/t0065-strcmp-offset.sh

-- 
2.9.3

