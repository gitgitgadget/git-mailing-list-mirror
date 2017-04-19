Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0302C1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 17:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967888AbdDSRGk (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 13:06:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:15225 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967883AbdDSRGd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 13:06:33 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0FB4E84504;
        Wed, 19 Apr 2017 13:06:31 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v12 3/5] read-cache: speed up add_index_entry during checkout
Date:   Wed, 19 Apr 2017 17:06:16 +0000
Message-Id: <20170419170618.16535-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170419170618.16535-1-git@jeffhostetler.com>
References: <20170419170618.16535-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach add_index_entry_with_check() to see if the path
of the new item is greater than the last path in the
index array before attempting to search for it.

During checkout, merge_working_tree() populates the new
index in sorted order, so this change will save a binary
lookups per file.  This preserves the original behavior
but simply checks the last element before starting the
search.

This helps performance on very large repositories.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 97f13a1..6a27688 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1021,7 +1021,16 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 
 	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
 		cache_tree_invalidate_path(istate, ce->name);
-	pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
+
+	/*
+	 * If this entry's path sorts after the last entry in the index,
+	 * we can avoid searching for it.
+	 */
+	if (istate->cache_nr > 0 &&
+		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
+		pos = -istate->cache_nr - 1;
+	else
+		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
-- 
2.9.3

