Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9115A1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbeGMRMG (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:06 -0400
Received: from siwi.pair.com ([209.68.5.199]:31833 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730822AbeGMRMF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:05 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D862A3F47F0;
        Fri, 13 Jul 2018 12:56:37 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 706EE3F47EE;
        Fri, 13 Jul 2018 12:56:37 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 12/25] structured-logging: add timer around do_write_index
Date:   Fri, 13 Jul 2018 16:56:08 +0000
Message-Id: <20180713165621.52017-13-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use a SLOG timer to record the time spend in do_write_index() and
report it in the "cmd_exit" event.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index df5dc87..7fe66b5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2433,7 +2433,9 @@ static int commit_locked_index(struct lock_file *lk)
 static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
 				 unsigned flags)
 {
+	int slog_timer = slog_start_timer("index", "do_write_index");
 	int ret = do_write_index(istate, lock->tempfile, 0);
+	slog_stop_timer(slog_timer);
 	if (ret)
 		return ret;
 	if (flags & COMMIT_LOCK)
@@ -2514,11 +2516,14 @@ static int clean_shared_index_files(const char *current_hex)
 static int write_shared_index(struct index_state *istate,
 			      struct tempfile **temp)
 {
+	int slog_tid = SLOG_UNDEFINED_TIMER_ID;
 	struct split_index *si = istate->split_index;
 	int ret;
 
 	move_cache_to_base_index(istate);
+	slog_tid = slog_start_timer("index", "do_write_index");
 	ret = do_write_index(si->base, *temp, 1);
+	slog_stop_timer(slog_tid);
 	if (ret)
 		return ret;
 	ret = adjust_shared_perm(get_tempfile_path(*temp));
-- 
2.9.3

