Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7A020958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbdCWNrX (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:47:23 -0400
Received: from siwi.pair.com ([209.68.5.199]:28992 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754947AbdCWNrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:47:20 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0A66B8466C;
        Thu, 23 Mar 2017 09:47:19 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 1/7] name-hash: specify initial size for istate.dir_hash table
Date:   Thu, 23 Mar 2017 13:46:59 +0000
Message-Id: <1490276825-41544-2-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Specify an initial size for the istate.dir_hash HashMap matching
the size of the istate.name_hash.

Previously hashmap_init() was given 0, causing a 64 bucket
hashmap to be created.  When working with very large
repositories, this would cause numerous rehash() calls to
realloc and rebalance the hashmap. This is especially true
when the worktree is deep, with many directories containing
a few files.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 name-hash.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/name-hash.c b/name-hash.c
index 6d9f23e..3f7722a 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -120,7 +120,8 @@ static void lazy_init_name_hash(struct index_state *istate)
 		return;
 	hashmap_init(&istate->name_hash, (hashmap_cmp_fn) cache_entry_cmp,
 			istate->cache_nr);
-	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp, 0);
+	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp,
+			istate->cache_nr);
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized = 1;
-- 
2.7.4

