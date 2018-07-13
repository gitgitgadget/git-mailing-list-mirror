Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B8C1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbeGMRMY (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:31847 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387691AbeGMRME (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:04 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4DA283F415C;
        Fri, 13 Jul 2018 12:56:37 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D9EAC3F4161;
        Fri, 13 Jul 2018 12:56:36 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 11/25] structured-logging: add timer around do_read_index
Date:   Fri, 13 Jul 2018 16:56:07 +0000
Message-Id: <20180713165621.52017-12-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use a SLOG timer to record the time spent in do_read_index()
and report it in the "cmd_exit" event.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 3725882..df5dc87 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1900,6 +1900,7 @@ static void freshen_shared_index(const char *shared_index, int warn)
 int read_index_from(struct index_state *istate, const char *path,
 		    const char *gitdir)
 {
+	int slog_tid;
 	uint64_t start = getnanotime();
 	struct split_index *split_index;
 	int ret;
@@ -1910,7 +1911,9 @@ int read_index_from(struct index_state *istate, const char *path,
 	if (istate->initialized)
 		return istate->cache_nr;
 
+	slog_tid = slog_start_timer("index", "do_read_index");
 	ret = do_read_index(istate, path, 0);
+	slog_stop_timer(slog_tid);
 	trace_performance_since(start, "read cache %s", path);
 
 	split_index = istate->split_index;
@@ -1926,7 +1929,9 @@ int read_index_from(struct index_state *istate, const char *path,
 
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
+	slog_tid = slog_start_timer("index", "do_read_index");
 	ret = do_read_index(split_index->base, base_path, 1);
+	slog_stop_timer(slog_tid);
 	if (oidcmp(&split_index->base_oid, &split_index->base->oid))
 		die("broken index, expect %s in %s, got %s",
 		    base_oid_hex, base_path,
-- 
2.9.3

