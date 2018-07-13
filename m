Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03121F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbeGMRMI (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:08 -0400
Received: from siwi.pair.com ([209.68.5.199]:31839 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387810AbeGMRMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:08 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B02783F481B;
        Fri, 13 Jul 2018 12:56:40 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 486643F4817;
        Fri, 13 Jul 2018 12:56:40 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 17/25] structured-logging: add aux-data for index size
Date:   Fri, 13 Jul 2018 16:56:13 +0000
Message-Id: <20180713165621.52017-18-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach do_read_index() and do_write_index() to record the size of the index
in aux-data.  This will be reported in the "cmd_exit" event.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 7fe66b5..b6e2cfa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1916,6 +1916,8 @@ int read_index_from(struct index_state *istate, const char *path,
 	slog_stop_timer(slog_tid);
 	trace_performance_since(start, "read cache %s", path);
 
+	slog_aux_intmax("index", "cache_nr", istate->cache_nr);
+
 	split_index = istate->split_index;
 	if (!split_index || is_null_oid(&split_index->base_oid)) {
 		post_read_index_from(istate);
@@ -1937,6 +1939,8 @@ int read_index_from(struct index_state *istate, const char *path,
 		    base_oid_hex, base_path,
 		    oid_to_hex(&split_index->base->oid));
 
+	slog_aux_intmax("index", "split_index_cache_nr", split_index->base->cache_nr);
+
 	freshen_shared_index(base_path, 0);
 	merge_base_index(istate);
 	post_read_index_from(istate);
-- 
2.9.3

