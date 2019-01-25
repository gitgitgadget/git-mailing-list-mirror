Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441A81F453
	for <e@80x24.org>; Fri, 25 Jan 2019 00:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfAYAXW (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 19:23:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34250 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAYAXW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 19:23:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so8981223qtp.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 16:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/E86izoRb+tjeL73XlVWdtxPnD7LJyu+fxhX7CKWqQ=;
        b=Q81bXKnwBTbQ1q8PaOM+YQnEyNaiBH7Mcn4lBUgiYZcJSj9vfQ49c4bV92X50g8sO0
         N2plyp0FA9u/YdVHR6e1BkWiZLDkvt6UG+MI4gOuaRLVbLccJ85TYzplzob8G/q6C1rP
         dtdLSdprZSgjmbdjGa0XVzGC68AYzSM0EnePsaiIZTIUV4CqyxbYlGTZ3BA84SF2FT2D
         3kVq9wI7HRfy0ocHcXbe3JydDuub3DstQIJp+Z5WREsnR3iQJMRj8nIl+BpL3umptl6Q
         3EJoIPfOdBz1do06o6cR8ywVeG/6CrHuwZiY8ZS/EWGxtl3Y/fRsL+iWwfM1rve4eEQj
         B61w==
X-Gm-Message-State: AJcUukcA/sdh8a62Iqep22YmiYe7TfNac7wgUlLIb7iEKLak4xeknC78
        8h9/BINLVv4PReih1HNz5H7I2MS0Ww==
X-Google-Smtp-Source: ALg8bN7sQLbHJ+zNLoAKY6mwiiG+T+yZdOjlilBchChjbOfzkdJQvc5exMDDJwAL2ojUG+azC36kpg==
X-Received: by 2002:ac8:3b52:: with SMTP id r18mr8627725qtf.81.1548375800293;
        Thu, 24 Jan 2019 16:23:20 -0800 (PST)
Received: from localhost.localdomain (pool-71-112-205-176.pitbpa.fios.verizon.net. [71.112.205.176])
        by smtp.googlemail.com with ESMTPSA id u50sm92121549qta.23.2019.01.24.16.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 16:23:19 -0800 (PST)
From:   Patrick Hogg <phogg@novamoon.net>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, newren@gmail.com, Patrick Hogg <phogg@novamoon.net>
Subject: [PATCH v4 2/2] pack-objects: merge read_lock and lock in packing_data struct
Date:   Thu, 24 Jan 2019 19:22:05 -0500
Message-Id: <20190125002203.38756-2-phogg@novamoon.net>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190125002203.38756-1-phogg@novamoon.net>
References: <20190125002203.38756-1-phogg@novamoon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the packing_data lock to obd_lock and upgrade it to a recursive
mutex to make it suitable for current read_lock usages. Additionally
remove the superfluous #ifndef NO_PTHREADS guard around mutex
initialization in prepare_packing_data as the mutex functions
themselves are already protected.

Signed-off-by: Patrick Hogg <phogg@novamoon.net>
Thanks-to: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c | 24 ++++++++++--------------
 pack-objects.c         |  5 +----
 pack-objects.h         | 21 ++++++++-------------
 3 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 506061b4c..cfef48217 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1953,10 +1953,6 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 	return 0;
 }
 
-/* Protect access to object database */
-#define read_lock()		packing_data_read_lock(&to_pack)
-#define read_unlock()		packing_data_read_unlock(&to_pack)
-
 /* Protect delta_cache_size */
 static pthread_mutex_t cache_mutex;
 #define cache_lock()		pthread_mutex_lock(&cache_mutex)
@@ -1992,11 +1988,11 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	unsigned long used, avail, size;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
-		read_lock();
+		packing_data_lock(&to_pack);
 		if (oid_object_info(the_repository, &e->idx.oid, &size) < 0)
 			die(_("unable to get size of %s"),
 			    oid_to_hex(&e->idx.oid));
-		read_unlock();
+		packing_data_unlock(&to_pack);
 		return size;
 	}
 
@@ -2004,7 +2000,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	if (!p)
 		BUG("when e->type is a delta, it must belong to a pack");
 
-	read_lock();
+	packing_data_lock(&to_pack);
 	w_curs = NULL;
 	buf = use_pack(p, &w_curs, e->in_pack_offset, &avail);
 	used = unpack_object_header_buffer(buf, avail, &type, &size);
@@ -2013,7 +2009,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 		    oid_to_hex(&e->idx.oid));
 
 	unuse_pack(&w_curs);
-	read_unlock();
+	packing_data_unlock(&to_pack);
 	return size;
 }
 
@@ -2075,9 +2071,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Load data if not already done */
 	if (!trg->data) {
-		read_lock();
+		packing_data_lock(&to_pack);
 		trg->data = read_object_file(&trg_entry->idx.oid, &type, &sz);
-		read_unlock();
+		packing_data_unlock(&to_pack);
 		if (!trg->data)
 			die(_("object %s cannot be read"),
 			    oid_to_hex(&trg_entry->idx.oid));
@@ -2088,9 +2084,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		*mem_usage += sz;
 	}
 	if (!src->data) {
-		read_lock();
+		packing_data_lock(&to_pack);
 		src->data = read_object_file(&src_entry->idx.oid, &type, &sz);
-		read_unlock();
+		packing_data_unlock(&to_pack);
 		if (!src->data) {
 			if (src_entry->preferred_base) {
 				static int warned = 0;
@@ -2336,9 +2332,9 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 
 static void try_to_free_from_threads(size_t size)
 {
-	read_lock();
+	packing_data_lock(&to_pack);
 	release_pack_memory(size);
-	read_unlock();
+	packing_data_unlock(&to_pack);
 }
 
 static try_to_free_t old_try_to_free_routine;
diff --git a/pack-objects.c b/pack-objects.c
index 3554c43ac..a1dc5eb72 100644
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
+	init_recursive_mutex(&pdata->odb_lock);
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
diff --git a/pack-objects.h b/pack-objects.h
index 0a038e3bc..1667cbad8 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -145,8 +145,11 @@ struct packing_data {
 	struct packed_git **in_pack_by_idx;
 	struct packed_git **in_pack;
 
-	pthread_mutex_t lock;
-	pthread_mutex_t read_lock;
+	/*
+	 * During packing with multiple threads, protect the in-core
+	 * object database from concurrent accesses.
+	 */
+	pthread_mutex_t odb_lock;
 
 	/*
 	 * This list contains entries for bases which we know the other side
@@ -166,22 +169,14 @@ struct packing_data {
 
 void prepare_packing_data(struct packing_data *pdata);
 
+/* Protect access to object database */
 static inline void packing_data_lock(struct packing_data *pdata)
 {
-	pthread_mutex_lock(&pdata->lock);
+	pthread_mutex_lock(&pdata->odb_lock);
 }
 static inline void packing_data_unlock(struct packing_data *pdata)
 {
-	pthread_mutex_unlock(&pdata->lock);
-}
-
-static inline void packing_data_read_lock(struct packing_data *pdata)
-{
-	pthread_mutex_lock(&pdata->read_lock);
-}
-static inline void packing_data_read_unlock(struct packing_data *pdata)
-{
-	pthread_mutex_unlock(&pdata->read_lock);
+	pthread_mutex_unlock(&pdata->odb_lock);
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-- 
2.20.1.windows.1

