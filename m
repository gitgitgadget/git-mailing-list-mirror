Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C0141F90A
	for <e@80x24.org>; Fri, 13 Jul 2018 16:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbeGMRM0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:31847 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732689AbeGMRMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:03 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2CB033F4155;
        Fri, 13 Jul 2018 12:56:36 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B83AD3F415C;
        Fri, 13 Jul 2018 12:56:35 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 09/25] structured-logging: add detail-event for lazy_init_name_hash
Date:   Fri, 13 Jul 2018 16:56:05 +0000
Message-Id: <20180713165621.52017-10-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach git to generate a structured logging detail-event for
lazy_init_name_hash().  This is marked as an "index" category
event and includes time and size data for the hashmaps.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 name-hash.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/name-hash.c b/name-hash.c
index 1638498..939b26a 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -7,6 +7,8 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "json-writer.h"
+#include "structured-logging.h"
 
 struct dir_entry {
 	struct hashmap_entry ent;
@@ -603,6 +605,30 @@ static void lazy_init_name_hash(struct index_state *istate)
 
 	istate->name_hash_initialized = 1;
 	trace_performance_since(start, "initialize name hash");
+
+	if (slog_want_detail_event("index")) {
+		struct json_writer jw = JSON_WRITER_INIT;
+		uint64_t now_ns = getnanotime();
+		uint64_t elapsed_us = (now_ns - start) / 1000;
+
+		jw_object_begin(&jw, slog_is_pretty());
+		{
+			jw_object_intmax(&jw, "cache_nr", istate->cache_nr);
+			jw_object_intmax(&jw, "elapsed_us", elapsed_us);
+			jw_object_intmax(&jw, "dir_count",
+					 hashmap_get_size(&istate->dir_hash));
+			jw_object_intmax(&jw, "dir_tablesize",
+					 istate->dir_hash.tablesize);
+			jw_object_intmax(&jw, "name_count",
+					 hashmap_get_size(&istate->name_hash));
+			jw_object_intmax(&jw, "name_tablesize",
+					 istate->name_hash.tablesize);
+		}
+		jw_end(&jw);
+
+		slog_emit_detail_event("index", "lazy_init_name_hash", &jw);
+		jw_release(&jw);
+	}
 }
 
 /*
-- 
2.9.3

