Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207961F453
	for <e@80x24.org>; Fri, 25 Jan 2019 00:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfAYAWu (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 19:22:50 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34182 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAYAWt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 19:22:49 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so8980046qtp.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 16:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aM3DdTeTjIcJHsVU6xnU1w5psIezPMc1vEk6DTdNZic=;
        b=if7FQhYHoJD+g0S2CFLiVMyIW8n//AIZn/HEY9OFxC0AwEshlVwLmQbrs0nNaHMdS+
         QEVAyhBZHPvsgS4GWLg9/P4Kwstc5CPnYkN8oJYdWqEUAtILNBmpDNhXm+xlhysS4++0
         jVh5f4w919dVOlRtQSl47NfEyz6mb4+VQ7akVkL4H0gqYD6ATfoREiqI39w0fIqbA6uN
         zfJwJeUF1WmAQqly9CcVsMyf41TGNPcBVwwi6V3yV/f/D8ZVB3KDwFiWchyXTSdJEDzI
         cPfp2s3i1SW1xQ5z+LiVoHcZ91dbYqWmy2PzsWo/8SJ1nadLmLyPtQ5X9OYs6PADp1MB
         h0CA==
X-Gm-Message-State: AJcUukctS1DZjMso4GWGfpspPgPF7uDduh55Dv8f+3TH77+GYN8M+xx5
        SM9rX8bGM04NqIlxe+mbaleeeoGy8Q==
X-Google-Smtp-Source: ALg8bN5nnP7TZngK5kPo2OyWe4Q/AUY8geUXj4+z+BpF8F7aNcsfnCars+Nbe2D2G/EmDsl+W0F7GA==
X-Received: by 2002:ac8:6949:: with SMTP id n9mr8974527qtr.308.1548375768113;
        Thu, 24 Jan 2019 16:22:48 -0800 (PST)
Received: from localhost.localdomain (pool-71-112-205-176.pitbpa.fios.verizon.net. [71.112.205.176])
        by smtp.googlemail.com with ESMTPSA id u50sm92121549qta.23.2019.01.24.16.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 16:22:47 -0800 (PST)
From:   Patrick Hogg <phogg@novamoon.net>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, newren@gmail.com, Patrick Hogg <phogg@novamoon.net>
Subject: [PATCH v4 1/2] pack-objects: move read mutex to packing_data struct
Date:   Thu, 24 Jan 2019 19:22:03 -0500
Message-Id: <20190125002203.38756-1-phogg@novamoon.net>
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
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
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

