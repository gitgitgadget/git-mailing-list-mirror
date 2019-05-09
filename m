Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6A81F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfEIV3q (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:29:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:53678 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726682AbfEIV3q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:29:46 -0400
Received: (qmail 10053 invoked by uid 109); 9 May 2019 21:29:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:29:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6469 invoked by uid 111); 9 May 2019 21:30:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:30:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:29:44 -0400
Date:   Thu, 9 May 2019 17:29:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/14] read-cache: drop unused parameter from threaded load
Message-ID: <20190509212944.GE15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The load_cache_entries_threaded() function takes a src_offset parameter
that it doesn't use. This has been there since its inception in
77ff1127a4 (read-cache: load cache entries on worker threads,
2018-10-10).

Digging on the mailing list, that parameter was part of an earlier
iteration of the series[1], but became unnecessary when the code
switched to using the IEOT extension.

[1] https://public-inbox.org/git/20180906210227.54368-5-benpeart@microsoft.com/

Signed-off-by: Jeff King <peff@peff.net>
---
 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 61b043bac3..3369f42dd9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2037,7 +2037,7 @@ static void *load_cache_entries_thread(void *_data)
 }
 
 static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
-			unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)
+						 int nr_threads, struct index_entry_offset_table *ieot)
 {
 	int i, offset, ieot_blocks, ieot_start, err;
 	struct load_cache_entries_thread_data *data;
@@ -2198,7 +2198,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
 
 	if (ieot) {
-		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, src_offset, nr_threads, ieot);
+		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);
 		free(ieot);
 	} else {
 		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
-- 
2.21.0.1382.g4c6032d436

