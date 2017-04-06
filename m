Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9EBB1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 13:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbdDFNpW (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 09:45:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:43465 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755489AbdDFNpS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 09:45:18 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 768768464B;
        Thu,  6 Apr 2017 09:45:17 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 1/2] string-list: use ALLOC_GROW macro when reallocing string_list
Date:   Thu,  6 Apr 2017 13:45:07 +0000
Message-Id: <20170406134508.31711-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170406134508.31711-1-git@jeffhostetler.com>
References: <20170406134508.31711-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use ALLOC_GROW() macro when reallocing a string_list array
rather than simply increasing it by 32.  This is a performance
optimization.

During status on a very large repo and there are many changes,
a significant percentage of the total run time is spent
reallocing the wt_status.changes array.

This change decreases the time in wt_status_collect_changes_worktree()
from 125 seconds to 45 seconds on my very large repository.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 string-list.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/string-list.c b/string-list.c
index 45016ad..003ca18 100644
--- a/string-list.c
+++ b/string-list.c
@@ -41,10 +41,7 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 	if (exact_match)
 		return -1 - index;
 
-	if (list->nr + 1 >= list->alloc) {
-		list->alloc += 32;
-		REALLOC_ARRAY(list->items, list->alloc);
-	}
+	ALLOC_GROW(list->items, list->nr+1, list->alloc);
 	if (index < list->nr)
 		memmove(list->items + index + 1, list->items + index,
 				(list->nr - index)
-- 
2.9.3

