Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9B11F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbeGMRMG (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:06 -0400
Received: from siwi.pair.com ([209.68.5.199]:31872 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbeGMRMG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:06 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 052913F47F8;
        Fri, 13 Jul 2018 12:56:39 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 918163F47EE;
        Fri, 13 Jul 2018 12:56:38 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 14/25] structured-logging: add timer around preload_index
Date:   Fri, 13 Jul 2018 16:56:10 +0000
Message-Id: <20180713165621.52017-15-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use a SLOG timer to record the time spend in preload_index() and
report it in the "cmd_exit" event.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 preload-index.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/preload-index.c b/preload-index.c
index 4d08d44..572bb56 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -116,8 +116,14 @@ static void preload_index(struct index_state *index,
 int read_index_preload(struct index_state *index,
 		       const struct pathspec *pathspec)
 {
+	int slog_tid;
 	int retval = read_index(index);
 
+	slog_tid = slog_start_timer("index", "preload");
+
 	preload_index(index, pathspec);
+
+	slog_stop_timer(slog_tid);
+
 	return retval;
 }
-- 
2.9.3

