Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE031F453
	for <e@80x24.org>; Fri, 18 Jan 2019 02:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbfARC2T (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 21:28:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46727 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfARC2T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 21:28:19 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so13650936qtm.13
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 18:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hsXJQrOpz4+lnd48lcIZWr74EdtfGRqFvsaG7FqkHLY=;
        b=WJPkOuo1v03+Ze10gAy+KW/IYI0BDY5FA6rcB5H9+k97QFzzQvmmXSSECOBxXRSQqk
         hFJYAHDjvlQU9ddG7N0MczqOqGW5RL74hSJwrQPbTweFuCOEDamNBC71eNnFvnGv5gc6
         hU1pWKNfZtRrkutB3PmSW4yXmdbFC3fNR5ldjAHwx+54EhCj3sPExbxHr1JqxqBdYU3P
         A7zMj/4fnLAey6iou2dwG0+txMtJKdTfsGZYyl4QvWYoR5knLQnFAEwTBEUeRSsFEZtu
         5wiVToy/Gtx2CoJaYTpylMzXABiqvySpFA4v7WSr5s32vEJ09q+gb7s8iQIdTMbp7z7w
         Xlrg==
X-Gm-Message-State: AJcUukcMEXc0LP2KpChE22roMMCiBm5IGXKFX0UYAX/F+gCqYcXRqVXF
        YtiWtsSs17WCPrgLkxpMlA67W85+4Q==
X-Google-Smtp-Source: ALg8bN6Ak1v5wWxgjAJTEB2YnhhVLgNHiEJMlekoUkWwP8SMassbhIV+W8gRVIOICbjp564OCMez2w==
X-Received: by 2002:a0c:b11a:: with SMTP id q26mr14046850qvc.2.1547778497229;
        Thu, 17 Jan 2019 18:28:17 -0800 (PST)
Received: from localhost.localdomain (pool-71-112-205-176.pitbpa.fios.verizon.net. [71.112.205.176])
        by smtp.googlemail.com with ESMTPSA id o25sm61006308qtj.10.2019.01.17.18.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 18:28:16 -0800 (PST)
From:   Patrick Hogg <phogg@novamoon.net>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Patrick Hogg <phogg@novamoon.net>
Subject: [PATCH] pack-objects.c: Initialize read mutex in cmd_pack_objects
Date:   Thu, 17 Jan 2019 21:27:36 -0500
Message-Id: <20190118022736.36832-1-phogg@novamoon.net>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ac77d0c37 ("pack-objects: shrink size field in struct object_entry",
2018-04-14) added an extra usage of read_lock/read_unlock in the newly
introduced oe_get_size_slow for thread safety in parallel calls to
try_delta(). Unfortunately oe_get_size_slow is also used in serial
code, some of which is called before the first invocation of
ll_find_deltas. As such the read mutex is not guaranteed to be
initialized.

Resolve this by splitting off the read mutex initialization from
init_threaded_search. Instead initialize (and clean up) the read
mutex in cmd_pack_objects.

Signed-off-by: Patrick Hogg <phogg@novamoon.net>
---
 builtin/pack-objects.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 411aefd68..9084bef02 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2381,22 +2381,30 @@ static pthread_cond_t progress_cond;
  */
 static void init_threaded_search(void)
 {
-	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
 	old_try_to_free_routine = set_try_to_free_routine(try_to_free_from_threads);
 }
 
+static void init_read_mutex(void)
+{
+	init_recursive_mutex(&read_mutex);
+}
+
 static void cleanup_threaded_search(void)
 {
 	set_try_to_free_routine(old_try_to_free_routine);
 	pthread_cond_destroy(&progress_cond);
-	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&cache_mutex);
 	pthread_mutex_destroy(&progress_mutex);
 }
 
+static void cleanup_read_mutex(void)
+{
+	pthread_mutex_destroy(&read_mutex);
+}
+
 static void *threaded_find_deltas(void *arg)
 {
 	struct thread_params *me = arg;
@@ -3319,6 +3327,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	init_read_mutex();
+
 	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
 		BUG("too many dfs states, increase OE_DFS_STATE_BITS");
 
@@ -3495,5 +3505,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
 			     " reused %"PRIu32" (delta %"PRIu32")"),
 			   written, written_delta, reused, reused_delta);
+
+	cleanup_read_mutex();
 	return 0;
 }
-- 
2.20.1.windows.1

