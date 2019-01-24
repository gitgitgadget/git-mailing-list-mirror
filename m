Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C9B11F453
	for <e@80x24.org>; Thu, 24 Jan 2019 01:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAXBGZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 20:06:25 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44973 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfAXBGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 20:06:24 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so4678495qte.11
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 17:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igbUZ3GYTxRyW7xobx6MMC/HBKJr2kJV1c0rkxlgON4=;
        b=L+BfDEFENFdzBQvt1vDRZP6Nw0ytptbkdq/yzdhOvNhFITBCFKyxdyLPOgyirhF78G
         B9sA/fTUdqQK6HYLN5IttZRuUGpycTvsq1xoJ52SqZ/qjvDsDvdvRjR+tnypJ9FO66cf
         hhakoGlqQAgpbt0QJriDJP6OwTdVixxM88AK8NJw+Oz6fRtcFBQlRgQYMWJPzzcJG52t
         XeNSTCPOc8qbIUB7bLc7rruVtdGETc3Gu9C69H19OGu8ZuqtIV78V0EVuBZPDt0o427r
         eWNsfbWvLNWMkujlwEmpGiLkqusVxkeBToYFVQS7lh0ryrVVjMYY0pU6hjE7iMtjwTeA
         nhuQ==
X-Gm-Message-State: AJcUukeW2fZiFUJEblXF4y8D5oDZ1SBixEjKtQsHQRpjZN0l2HYb/MJG
        yWnGaCnD56gePxv3/G5iIo6ymoWzyQ==
X-Google-Smtp-Source: ALg8bN5Vo26ddMHXpP0nsdHxJJP4DrFAXNlEFxKSVpATR4D86Y4QeEaVIuajf9MixT/eKNrnA8vN+g==
X-Received: by 2002:ac8:6784:: with SMTP id b4mr4828845qtp.103.1548291983177;
        Wed, 23 Jan 2019 17:06:23 -0800 (PST)
Received: from localhost.localdomain (pool-71-112-205-176.pitbpa.fios.verizon.net. [71.112.205.176])
        by smtp.googlemail.com with ESMTPSA id 5sm87549678qtw.50.2019.01.23.17.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 17:06:22 -0800 (PST)
From:   Patrick Hogg <phogg@novamoon.net>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, newren@gmail.com, Patrick Hogg <phogg@novamoon.net>
Subject: [PATCH v3 2/2] pack-objects: merge read_lock and lock in packing_data struct
Date:   Wed, 23 Jan 2019 20:05:23 -0500
Message-Id: <20190124010521.28452-2-phogg@novamoon.net>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190124010521.28452-1-phogg@novamoon.net>
References: <20190124010521.28452-1-phogg@novamoon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Upgrade the packing_data lock to a recursive mutex to make it suitable
for current read_lock usages. Additionally remove the superfluous
#ifndef NO_PTHREADS guard around mutex initialization in
prepare_packing_data as the mutex functions themselves are already
protected.

Signed-off-by: Patrick Hogg <phogg@novamoon.net>
---
 builtin/pack-objects.c | 24 ++++++++++++------------
 pack-objects.c         |  5 +----
 pack-objects.h         | 10 ----------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 506061b4c..5439b434c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1954,8 +1954,8 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 }
 
 /* Protect access to object database */
-#define read_lock()		packing_data_read_lock(&to_pack)
-#define read_unlock()		packing_data_read_unlock(&to_pack)
+#define pack_lock()		packing_data_lock(&to_pack)
+#define pack_unlock()		packing_data_unlock(&to_pack)
 
 /* Protect delta_cache_size */
 static pthread_mutex_t cache_mutex;
@@ -1992,11 +1992,11 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
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
 
@@ -2004,7 +2004,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	if (!p)
 		BUG("when e->type is a delta, it must belong to a pack");
 
-	read_lock();
+	pack_lock();
 	w_curs = NULL;
 	buf = use_pack(p, &w_curs, e->in_pack_offset, &avail);
 	used = unpack_object_header_buffer(buf, avail, &type, &size);
@@ -2013,7 +2013,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 		    oid_to_hex(&e->idx.oid));
 
 	unuse_pack(&w_curs);
-	read_unlock();
+	pack_unlock();
 	return size;
 }
 
@@ -2075,9 +2075,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
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
@@ -2088,9 +2088,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
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
@@ -2336,9 +2336,9 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 
 static void try_to_free_from_threads(size_t size)
 {
-	read_lock();
+	pack_lock();
 	release_pack_memory(size);
-	read_unlock();
+	pack_unlock();
 }
 
 static try_to_free_t old_try_to_free_routine;
diff --git a/pack-objects.c b/pack-objects.c
index 3554c43ac..6f32a7ba0 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -148,10 +148,7 @@ void prepare_packing_data(struct packing_data *pdata)
 					     1U << OE_SIZE_BITS);
 	pdata->oe_delta_size_limit = git_env_ulong("GIT_TEST_OE_DELTA_SIZE",
 						   1UL << OE_DELTA_SIZE_BITS);
-#ifndef NO_PTHREADS
-	pthread_mutex_init(&pdata->lock, NULL);
-	init_recursive_mutex(&pdata->read_lock);
-#endif
+	init_recursive_mutex(&pdata->lock);
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
diff --git a/pack-objects.h b/pack-objects.h
index 0a038e3bc..dc869f26c 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -146,7 +146,6 @@ struct packing_data {
 	struct packed_git **in_pack;
 
 	pthread_mutex_t lock;
-	pthread_mutex_t read_lock;
 
 	/*
 	 * This list contains entries for bases which we know the other side
@@ -175,15 +174,6 @@ static inline void packing_data_unlock(struct packing_data *pdata)
 	pthread_mutex_unlock(&pdata->lock);
 }
 
-static inline void packing_data_read_lock(struct packing_data *pdata)
-{
-	pthread_mutex_lock(&pdata->read_lock);
-}
-static inline void packing_data_read_unlock(struct packing_data *pdata)
-{
-	pthread_mutex_unlock(&pdata->read_lock);
-}
-
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
 				    uint32_t index_pos);
-- 
2.20.1.windows.1

