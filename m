Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515C91F454
	for <e@80x24.org>; Sat, 19 Jan 2019 15:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfASPpF (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 10:45:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34246 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbfASPpF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 10:45:05 -0500
Received: by mail-qt1-f194.google.com with SMTP id r14so18652334qtp.1
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 07:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vmRsXBTXpdkmdJO3GN4hZbzijSxp0EZV+bi1gQLQksc=;
        b=T062YSWUJwcTI+kmXtQ5qahkrKgrmd+7EmTduVY3JDvx6BXTxHz0oMLIw4OxHdpDgl
         wogp7U2EDHwMc7ViTyrRbjbl8pPYkd/p2ohz7JDg4TfAwUyddMyy6YoEP3Q9JTSCehVf
         qqbLDFFu/QNUOwdWHEwMzYth6AMQlaxBI0uXfyMQmYhW0B1h0XHKFTCoS+fAzsVC2aTA
         hT+ZdCtL0A16ey1LDOPZoH88143RftDt4CH710fo6cwZeCFuVUVtkvL210ld8pfnjiMc
         VrYI+8Ee/QpYIIDXiLUR6u/mPOpunGnVthHQ7f6DwVKWjxpPsah7sgalHbfJL02ZukLP
         6JfA==
X-Gm-Message-State: AJcUukcz6goODYiP6NUNrW0kZCJjRvlJNXunxKv6AtYfZk807x4X40rO
        rBiJWKdub1KhQxAJp17I4kSeekB9/A==
X-Google-Smtp-Source: ALg8bN6VUX7ZfMXQ67AxlEWKZuxEg3Hj7fUoPfz9UiiqVWXSbZS40xalS9NkFKn6iZY+GkLAwIK4Iw==
X-Received: by 2002:a0c:9626:: with SMTP id 35mr19646538qvx.207.1547912703674;
        Sat, 19 Jan 2019 07:45:03 -0800 (PST)
Received: from localhost.localdomain (pool-71-112-205-176.pitbpa.fios.verizon.net. [71.112.205.176])
        by smtp.googlemail.com with ESMTPSA id k22sm47119147qtm.73.2019.01.19.07.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 07:45:02 -0800 (PST)
From:   Patrick Hogg <phogg@novamoon.net>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, Johannes.Schindelin@gmx.de,
        Patrick Hogg <phogg@novamoon.net>
Subject: [PATCH v2] pack-objects: Use packing_data lock instead of read_mutex
Date:   Sat, 19 Jan 2019 10:43:38 -0500
Message-Id: <20190119154337.6556-1-phogg@novamoon.net>
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

Resolve this by using the existing lock in packing_data which is
initialized early in cmd_pack_objects instead of read_mutex.
Additionally, upgrade the packing_data lock to a recursive mutex to
make it a suitable replacement for read_mutex.

Signed-off-by: Patrick Hogg <phogg@novamoon.net>
---

As I mentioned in the prior thread I think that it will be simpler
to simply use the existing lock in packing_data instead of moving
read_mutex. I can go back to simply moving read_mutex to the
packing_data struct if that that is preferable, though.

I also removed the #ifndef NO_PTHREADS in prepare_packing_data around
the initialization of &pdata->lock since I had to upgrade the lock to
a recursive mutex. As far as I can tell init_recursive_mutex (and
pthread_mutex_init for that matter) have that protection already so it
appears to be redundant.

 builtin/pack-objects.c | 27 ++++++++++++---------------
 pack-objects.c         |  4 +---
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 411aefd68..5439b434c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1954,9 +1954,8 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 }
 
 /* Protect access to object database */
-static pthread_mutex_t read_mutex;
-#define read_lock()		pthread_mutex_lock(&read_mutex)
-#define read_unlock()		pthread_mutex_unlock(&read_mutex)
+#define pack_lock()		packing_data_lock(&to_pack)
+#define pack_unlock()		packing_data_unlock(&to_pack)
 
 /* Protect delta_cache_size */
 static pthread_mutex_t cache_mutex;
@@ -1993,11 +1992,11 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	unsigned long used, avail, size;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
-		read_lock();
+		pack_lock();
 		if (oid_object_info(the_repository, &e->idx.oid, &size) < 0)
 			die(_("unable to get size of %s"),
 			    oid_to_hex(&e->idx.oid));
-		read_unlock();
+		pack_unlock();
 		return size;
 	}
 
@@ -2005,7 +2004,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	if (!p)
 		BUG("when e->type is a delta, it must belong to a pack");
 
-	read_lock();
+	pack_lock();
 	w_curs = NULL;
 	buf = use_pack(p, &w_curs, e->in_pack_offset, &avail);
 	used = unpack_object_header_buffer(buf, avail, &type, &size);
@@ -2014,7 +2013,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 		    oid_to_hex(&e->idx.oid));
 
 	unuse_pack(&w_curs);
-	read_unlock();
+	pack_unlock();
 	return size;
 }
 
@@ -2076,9 +2075,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Load data if not already done */
 	if (!trg->data) {
-		read_lock();
+		pack_lock();
 		trg->data = read_object_file(&trg_entry->idx.oid, &type, &sz);
-		read_unlock();
+		pack_unlock();
 		if (!trg->data)
 			die(_("object %s cannot be read"),
 			    oid_to_hex(&trg_entry->idx.oid));
@@ -2089,9 +2088,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		*mem_usage += sz;
 	}
 	if (!src->data) {
-		read_lock();
+		pack_lock();
 		src->data = read_object_file(&src_entry->idx.oid, &type, &sz);
-		read_unlock();
+		pack_unlock();
 		if (!src->data) {
 			if (src_entry->preferred_base) {
 				static int warned = 0;
@@ -2337,9 +2336,9 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 
 static void try_to_free_from_threads(size_t size)
 {
-	read_lock();
+	pack_lock();
 	release_pack_memory(size);
-	read_unlock();
+	pack_unlock();
 }
 
 static try_to_free_t old_try_to_free_routine;
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
index b6cdbb016..6f32a7ba0 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -148,9 +148,7 @@ void prepare_packing_data(struct packing_data *pdata)
 					     1U << OE_SIZE_BITS);
 	pdata->oe_delta_size_limit = git_env_ulong("GIT_TEST_OE_DELTA_SIZE",
 						   1UL << OE_DELTA_SIZE_BITS);
-#ifndef NO_PTHREADS
-	pthread_mutex_init(&pdata->lock, NULL);
-#endif
+	init_recursive_mutex(&pdata->lock);
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-- 
2.20.1.windows.1

