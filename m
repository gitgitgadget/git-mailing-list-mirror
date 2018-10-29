Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1E21F453
	for <e@80x24.org>; Mon, 29 Oct 2018 20:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeJ3Fco (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 01:32:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35317 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbeJ3Fco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 01:32:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id a10-v6so10974904qtp.2
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 13:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVhCIJ1CJY4/VqxN0iudC+/tiS4OZRDP4mpGtrVGc7E=;
        b=Ok3+S6eqRtlbT+r3wAO8g31PgPACjCZJiv804TJPTYTFbrv33YNW8il6MRlBSBbL1x
         NywLXUFNllZ9P8DOw1N+679KtuDByKTGMiIb5LH+8ZMp+6JlRHM2vi3J4zRh+tuE6s/H
         gEg5reyQ7vc1Mc8wpOOKsUQbS+76pW2LzuE76Dqcbkhu0cXRnQrSBHLPz9dF06V2W6wf
         t3lZ8c9f8YCMxfUn0ZYyXYXV2Yj8/bCWTOgmle62vvDZdAALNPr4AcDD1DaZrIeuBmKs
         ZAUtQZqM4wKkgE3lY+V3xgY2P26w0TJgx+kqRsyfOoqnFh/cZI01IjwWYAjSUrT0gbK4
         k35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVhCIJ1CJY4/VqxN0iudC+/tiS4OZRDP4mpGtrVGc7E=;
        b=Kxep3GrHLvLUytNxAG+95CKrQOGzLdWFoRr0BNjogqOW1q8H6vQN4l6/SsANw9TnbT
         2SrZapOnmEBYOLS3nN/+nKd22JvLSPVEu0+9WgFaLEcZFHQZx4QRzWKYYIBGQQj3vBWy
         8SszZveQUy4vLKwqSaGDCO6DOc3jR1R+9cDd432/JHFabuor9aM7GyEgRwU0CiPszK7O
         UeFU+5k9gecebJjFhrE+0sVmcGEag5f+/8zxo0KjIGPYTm7bJAgy8AVbmGRTZuLaD4fe
         rF0u+PgrgXRnxrBWp+zLBtD6jFN1uGAbhA/vm8bjX3/fJOwKulIDjxALrsxFLcYhGycA
         UtOQ==
X-Gm-Message-State: AGRZ1gIrYgs0/ONG4FN1DTeW9AR7VI9gijfvaeD+csRr4g9TJZjVUwme
        ZKLUinTEJDEM4glXCugxgbW/ed/v
X-Google-Smtp-Source: AJdET5c45gkXLkbsCrljaeZoZk9YhZe3PLopMdfk6WL97HaYoJ3F/25d+8WfY+w7U95sZKtEWfF2Ew==
X-Received: by 2002:aed:37e4:: with SMTP id j91-v6mr14026676qtb.50.1540845743221;
        Mon, 29 Oct 2018 13:42:23 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id z196sm7601459qkz.37.2018.10.29.13.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 13:42:22 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1] speed up refresh_index() by utilizing preload_index()
Date:   Mon, 29 Oct 2018 16:41:59 -0400
Message-Id: <20181029204159.18208-1-peartben@gmail.com>
X-Mailer: git-send-email 2.9.2.gvfs.2.27918.g0990287eef
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Speed up refresh_index() by utilizing preload_index() to do most of the work
spread across multiple threads.  This works because most cache entries will
get marked CE_UPTODATE so that refresh_cache_ent() can bail out early when
called from within refresh_index().

On a Windows repo with ~200K files, this drops refresh times from 6.64
seconds to 2.87 seconds for a savings of 57%.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/feee1054c2
    Checkout: git fetch https://github.com/benpeart/git refresh-index-multithread-preload-v1 && git checkout feee1054c2

 cache.h         | 3 +++
 preload-index.c | 8 ++++----
 read-cache.c    | 6 ++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index f7fabdde8f..883099db08 100644
--- a/cache.h
+++ b/cache.h
@@ -659,6 +659,9 @@ extern int daemonize(void);
 /* Initialize and use the cache information */
 struct lock_file;
 extern int read_index(struct index_state *);
+extern void preload_index(struct index_state *index,
+			  const struct pathspec *pathspec,
+			  unsigned int refresh_flags);
 extern int read_index_preload(struct index_state *,
 			      const struct pathspec *pathspec,
 			      unsigned int refresh_flags);
diff --git a/preload-index.c b/preload-index.c
index 9e7152ab14..222792ccbc 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -9,7 +9,7 @@
 #include "progress.h"
 
 #ifdef NO_PTHREADS
-static void preload_index(struct index_state *index,
+void preload_index(struct index_state *index,
 			  const struct pathspec *pathspec,
 			  unsigned int refresh_flags)
 {
@@ -100,9 +100,9 @@ static void *preload_thread(void *_data)
 	return NULL;
 }
 
-static void preload_index(struct index_state *index,
-			  const struct pathspec *pathspec,
-			  unsigned int refresh_flags)
+void preload_index(struct index_state *index,
+		   const struct pathspec *pathspec,
+		   unsigned int refresh_flags)
 {
 	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
diff --git a/read-cache.c b/read-cache.c
index d57958233e..53733d651d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1496,6 +1496,12 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
 	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
 	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
+	/*
+	 * Use the multi-threaded preload_index() to refresh most of the
+	 * cache entries quickly then in the single threaded loop below,
+	 * we only have to do the special cases that are left.
+	 */
+	preload_index(istate, pathspec, 0);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;

base-commit: c670b1f876521c9f7cd40184bf7ed05aad843433
-- 
2.9.2.gvfs.2.27918.g0990287eef

