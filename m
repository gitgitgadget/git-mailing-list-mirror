Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0401F453
	for <e@80x24.org>; Thu, 24 Jan 2019 01:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfAXBGJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 20:06:09 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45276 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfAXBGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 20:06:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so4666085qtr.12
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 17:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hSC63tVyP7nNFwEzmqvkyJhTWJod+dS9PAoV+pVW040=;
        b=r9wKfdM1mg/AtC3GH/ULGgMl4Tr3h5Bh1Lvo5DavGpseSPb5uxxVHvby4knnJOrXr+
         CFjmdHod3kTthQJqG4ejiIax6zZndIWlJPG7d3JpCxXQQugXtBFsiSY1qxWeuHw9b56L
         XfpAN0yrofR7Jwga5LdA1chUJHeRSev8lt6eR+0O/PZ0Uu/hGOAuu87n1Kjr/COeSzyv
         nRWIZo2LgCZhNW2y2elbkLO9cBEi27lWlrE4P5GdfMKlBXzucHuQZmYiJw2Pn+QRudY5
         x4sB1c/K03rrCAV5HRu1xjEtQboyDc3qI44IlsdO5VljZG61Qim/HmgRQo3/bQXmOG4I
         QCTQ==
X-Gm-Message-State: AJcUukcX4SdoyU7hi//vGjpHT+ATD6va98TkjgRaQsus36kkAzs1/TRt
        2DyGCYrVwMfxBxiox7a0033tGoiidw==
X-Google-Smtp-Source: ALg8bN4uQk8FbzH3TB2d0ZpTjRefpOxMcDoHnI8qRlT9dcaeymK+GEDO6h2A8dhz4FOjldEU0hwUHQ==
X-Received: by 2002:a0c:985d:: with SMTP id e29mr4144895qvd.16.1548291967714;
        Wed, 23 Jan 2019 17:06:07 -0800 (PST)
Received: from localhost.localdomain (pool-71-112-205-176.pitbpa.fios.verizon.net. [71.112.205.176])
        by smtp.googlemail.com with ESMTPSA id 5sm87549678qtw.50.2019.01.23.17.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 17:06:06 -0800 (PST)
From:   Patrick Hogg <phogg@novamoon.net>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, newren@gmail.com, Patrick Hogg <phogg@novamoon.net>
Subject: [PATCH v3 1/2] pack-objects: move read mutex to packing_data struct
Date:   Wed, 23 Jan 2019 20:05:21 -0500
Message-Id: <20190124010521.28452-1-phogg@novamoon.net>
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

Resolve this by moving the read mutex to packing_data and initializing
it in prepare_packing_data which is initialized in cmd_pack_objects.

Signed-off-by: Patrick Hogg <phogg@novamoon.net>
---
 builtin/pack-objects.c |  7 ++-----
 pack-objects.c         |  1 +
 pack-objects.h         | 10 ++++++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 411aefd68..506061b4c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1954,9 +1954,8 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 }
 
 /* Protect access to object database */
-static pthread_mutex_t read_mutex;
-#define read_lock()		pthread_mutex_lock(&read_mutex)
-#define read_unlock()		pthread_mutex_unlock(&read_mutex)
+#define read_lock()		packing_data_read_lock(&to_pack)
+#define read_unlock()		packing_data_read_unlock(&to_pack)
 
 /* Protect delta_cache_size */
 static pthread_mutex_t cache_mutex;
@@ -2381,7 +2380,6 @@ static pthread_cond_t progress_cond;
  */
 static void init_threaded_search(void)
 {
-	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
@@ -2392,7 +2390,6 @@ static void cleanup_threaded_search(void)
 {
 	set_try_to_free_routine(old_try_to_free_routine);
 	pthread_cond_destroy(&progress_cond);
-	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&cache_mutex);
 	pthread_mutex_destroy(&progress_mutex);
 }
diff --git a/pack-objects.c b/pack-objects.c
index b6cdbb016..3554c43ac 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -150,6 +150,7 @@ void prepare_packing_data(struct packing_data *pdata)
 						   1UL << OE_DELTA_SIZE_BITS);
 #ifndef NO_PTHREADS
 	pthread_mutex_init(&pdata->lock, NULL);
+	init_recursive_mutex(&pdata->read_lock);
 #endif
 }
 
diff --git a/pack-objects.h b/pack-objects.h
index dc869f26c..0a038e3bc 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -146,6 +146,7 @@ struct packing_data {
 	struct packed_git **in_pack;
 
 	pthread_mutex_t lock;
+	pthread_mutex_t read_lock;
 
 	/*
 	 * This list contains entries for bases which we know the other side
@@ -174,6 +175,15 @@ static inline void packing_data_unlock(struct packing_data *pdata)
 	pthread_mutex_unlock(&pdata->lock);
 }
 
+static inline void packing_data_read_lock(struct packing_data *pdata)
+{
+	pthread_mutex_lock(&pdata->read_lock);
+}
+static inline void packing_data_read_unlock(struct packing_data *pdata)
+{
+	pthread_mutex_unlock(&pdata->read_lock);
+}
+
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
 				    uint32_t index_pos);
-- 
2.20.1.windows.1

