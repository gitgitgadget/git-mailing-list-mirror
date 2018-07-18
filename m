Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB201F597
	for <e@80x24.org>; Wed, 18 Jul 2018 22:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeGRXbU (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:31:20 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55382 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729218AbeGRXbU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Jul 2018 19:31:20 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IMiO8K022135;
        Wed, 18 Jul 2018 15:51:14 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ka270h9rm-1;
        Wed, 18 Jul 2018 15:51:14 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E9A0922378FD;
        Wed, 18 Jul 2018 15:51:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id DFE682CDF12;
        Wed, 18 Jul 2018 15:51:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH] fix-v1: revert "pack-objects: shrink delta_size field in struct object_entry"
Date:   Wed, 18 Jul 2018 15:51:09 -0700
Message-Id: <20180718225110.17639-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.1.gd83e732e4e
In-Reply-To: <20180718225110.17639-1-newren@gmail.com>
References: <20180718225110.17639-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180247
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 0aca34e8269514ebb67676e0470a314615494ae8.

---
 builtin/pack-objects.c | 26 ++++++++++----------------
 pack-objects.h         | 23 +----------------------
 2 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 71056d8294..4775b4b4e5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -35,12 +35,10 @@
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
 #define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
-#define DELTA_SIZE(obj) oe_delta_size(&to_pack, obj)
 #define DELTA(obj) oe_delta(&to_pack, obj)
 #define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
 #define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
 #define SET_DELTA(obj, val) oe_set_delta(&to_pack, obj, val)
-#define SET_DELTA_SIZE(obj, val) oe_set_delta_size(&to_pack, obj, val)
 #define SET_DELTA_CHILD(obj, val) oe_set_delta_child(&to_pack, obj, val)
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
@@ -148,7 +146,7 @@ static void *get_delta(struct object_entry *entry)
 		    oid_to_hex(&DELTA(entry)->idx.oid));
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
-	if (!delta_buf || delta_size != DELTA_SIZE(entry))
+	if (!delta_buf || delta_size != entry->delta_size)
 		die("delta size changed");
 	free(buf);
 	free(base_buf);
@@ -299,14 +297,14 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		FREE_AND_NULL(entry->delta_data);
 		entry->z_delta_size = 0;
 	} else if (entry->delta_data) {
-		size = DELTA_SIZE(entry);
+		size = entry->delta_size;
 		buf = entry->delta_data;
 		entry->delta_data = NULL;
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	} else {
 		buf = get_delta(entry);
-		size = DELTA_SIZE(entry);
+		size = entry->delta_size;
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	}
@@ -1518,7 +1516,7 @@ static void check_object(struct object_entry *entry)
 			oe_set_type(entry, entry->in_pack_type);
 			SET_SIZE(entry, in_pack_size); /* delta size */
 			SET_DELTA(entry, base_entry);
-			SET_DELTA_SIZE(entry, in_pack_size);
+			entry->delta_size = in_pack_size;
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
 			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
@@ -1954,7 +1952,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		max_size = trg_size/2 - the_hash_algo->rawsz;
 		ref_depth = 1;
 	} else {
-		max_size = DELTA_SIZE(trg_entry);
+		max_size = trg_entry->delta_size;
 		ref_depth = trg->depth;
 	}
 	max_size = (uint64_t)max_size * (max_depth - src->depth) /
@@ -2023,14 +2021,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
-	if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
-		free(delta_buf);
-		return 0;
-	}
 
 	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
-		if (delta_size == DELTA_SIZE(trg_entry) &&
+		if (delta_size == trg_entry->delta_size &&
 		    src->depth + 1 >= trg->depth) {
 			free(delta_buf);
 			return 0;
@@ -2045,7 +2039,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	free(trg_entry->delta_data);
 	cache_lock();
 	if (trg_entry->delta_data) {
-		delta_cache_size -= DELTA_SIZE(trg_entry);
+		delta_cache_size -= trg_entry->delta_size;
 		trg_entry->delta_data = NULL;
 	}
 	if (delta_cacheable(src_size, trg_size, delta_size)) {
@@ -2058,7 +2052,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 
 	SET_DELTA(trg_entry, src_entry);
-	SET_DELTA_SIZE(trg_entry, delta_size);
+	trg_entry->delta_size = delta_size;
 	trg->depth = src->depth + 1;
 
 	return 1;
@@ -2181,11 +2175,11 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		if (entry->delta_data && !pack_to_stdout) {
 			unsigned long size;
 
-			size = do_compress(&entry->delta_data, DELTA_SIZE(entry));
+			size = do_compress(&entry->delta_data, entry->delta_size);
 			if (size < (1U << OE_Z_DELTA_BITS)) {
 				entry->z_delta_size = size;
 				cache_lock();
-				delta_cache_size -= DELTA_SIZE(entry);
+				delta_cache_size -= entry->delta_size;
 				delta_cache_size += entry->z_delta_size;
 				cache_unlock();
 			} else {
diff --git a/pack-objects.h b/pack-objects.h
index edf74dabdd..0e08f10437 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -14,7 +14,6 @@
  * above this limit. Don't lower it too much.
  */
 #define OE_SIZE_BITS		31
-#define OE_DELTA_SIZE_BITS	20
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -92,8 +91,7 @@ struct object_entry {
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
-	unsigned delta_size_valid:1;
+	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_valid:1;
@@ -327,23 +325,4 @@ static inline void oe_set_size(struct packing_data *pack,
 	}
 }
 
-static inline unsigned long oe_delta_size(struct packing_data *pack,
-					  const struct object_entry *e)
-{
-	if (e->delta_size_valid)
-		return e->delta_size_;
-	return oe_size(pack, e);
-}
-
-static inline void oe_set_delta_size(struct packing_data *pack,
-				     struct object_entry *e,
-				     unsigned long size)
-{
-	e->delta_size_ = size;
-	e->delta_size_valid = e->delta_size_ == size;
-	if (!e->delta_size_valid && size != oe_size(pack, e))
-		BUG("this can only happen in check_object() "
-		    "where delta size is the same as entry size");
-}
-
 #endif
-- 
2.18.0.1.gd83e732e4e

