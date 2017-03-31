Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196D51FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933363AbdCaRcy (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:32:54 -0400
Received: from siwi.pair.com ([209.68.5.199]:36872 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933313AbdCaRcx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:32:53 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 745F6845DB;
        Fri, 31 Mar 2017 13:32:46 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, kewill@microsoft.com,
        Kevin Willford <kewillf@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH] name-hash: fix buffer overrun
Date:   Fri, 31 Mar 2017 17:32:14 +0000
Message-Id: <20170331173214.47514-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170331173214.47514-1-git@jeffhostetler.com>
References: <20170331173214.47514-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <kewillf@microsoft.com>

Add check for the end of the entries for the thread partition.
Add test for lazy init name hash with specific directory structure

The lazy init hash name was causing a buffer overflow when the last
entry in the index was multiple folder deep with parent folders that
did not have any files in them.

This adds a test for the boundary condition of the thread partitions
with the folder structure that was triggering the buffer overflow.

The fix was to check if it is the last entry for the thread partition
in the handle_range_dir and not try to use the next entry in the cache.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>

---
 name-hash.c                             |  4 +++-
 t/t3008-ls-files-lazy-init-name-hash.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 t/t3008-ls-files-lazy-init-name-hash.sh

diff --git a/name-hash.c b/name-hash.c
index cac313c..39309ef 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -342,7 +342,9 @@ static int handle_range_dir(
 	 * Scan forward in the index array for index entries having the same
 	 * path prefix (that are also in this directory).
 	 */
-	if (strncmp(istate->cache[k_start + 1]->name, prefix->buf, prefix->len) > 0)
+	if (k_start + 1 >= k_end)
+		k = k_end;
+	else if (strncmp(istate->cache[k_start + 1]->name, prefix->buf, prefix->len) > 0)
 		k = k_start + 1;
 	else if (strncmp(istate->cache[k_end - 1]->name, prefix->buf, prefix->len) == 0)
 		k = k_end;
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
new file mode 100644
index 0000000..e46a11b
--- /dev/null
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='Test the lazy init name hash with various folder structures'
+
+. ./test-lib.sh
+
+test_expect_success 'no buffer overflow in lazy_init_name_hash' '
+	(
+	    test_seq 2000 | sed "s/^/a_/"
+	    echo b/b/b
+	    test_seq 2000 | sed "s/^/c_/"
+	    test_seq 50 | sed "s/^/d_/" | tr "\n" "/"; echo d
+	) |
+	sed "s/^/100644 $EMPTY_BLOB\t/" |
+	git update-index --index-info &&
+	test-lazy-init-name-hash -m
+'
+
+test_done
-- 
2.9.3

