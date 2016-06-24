Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D271FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbcFXXJ7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:09:59 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52604 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751463AbcFXXJn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 19:09:43 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DC6D1280A6;
	Fri, 24 Jun 2016 23:09:41 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466809782;
	bh=9UuIGjKD31SXVUHj3QWu3YNys2NigbOp/Wh8JmBFQrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wICbTNWXv1euqe8lUH9QcXovFQnLEAc680s/jjbfXKTp/QklWscmPLdsKNiH2EVUZ
	 12uALZPK6IFBLpq8rXGtXuYGKicsCjP7BhqLbxamjGxzryyzCcbHSXWCnz4oAzxWvN
	 00NcMTTgxtmCbMAJ3zrHtX52hRSgEAHAHCpFfEUltz1JiAKmA5CChuseasWN+B9ler
	 km3R4/NpV6tbnHl76RZ229nasRtpcwvwv/lKhNMNeGdXw+OjRtrE53MjpLArMUlioM
	 ym4iho76jVszpjqOX69CZdGjD/fDs3Mlrll6Sq4AZKsD5zGUfhd00rkkE696tkkPRR
	 upMOE4nwpOFc9itKM1rUWhKOzW7OtYQMwv3E+B5K+2PF/QiUhAHabCm1vSMP3tSi96
	 cwblHitxwmPHUfGDe2C7B10ejxWlfJSiQ1XGLtAVc8TrXwt/RpLKvY1QBx1lnal5Th
	 p33I7L+PImtNAhENFMybulhH5ymGg7Dx4MMPNMyv7cufTFbt00W
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 07/11] merge-recursive: convert struct stage_data to use object_id
Date:	Fri, 24 Jun 2016 23:09:25 +0000
Message-Id: <20160624230929.82222-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160624230929.82222-1-sandals@crustytoothpaste.net>
References: <20160624230929.82222-1-sandals@crustytoothpaste.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Convert the anonymous struct within struct stage_data to use struct
object_id.  The following Coccinelle semantic patch was used to
implement this, followed by the transformations in object_id.cocci:

@@
struct stage_data o;
expression E1;
@@
- o.stages[E1].sha
+ o.stages[E1].oid.hash

@@
struct stage_data *p;
expression E1;
@@
- p->stages[E1].sha
+ p->stages[E1].oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1e802097..a07050cd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -90,7 +90,7 @@ struct rename_conflict_info {
 struct stage_data {
 	struct {
 		unsigned mode;
-		unsigned char sha[20];
+		struct object_id oid;
 	} stages[4];
 	struct rename_conflict_info *rename_conflict_info;
 	unsigned processed:1;
@@ -134,13 +134,11 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 		int ostage2 = ostage1 ^ 1;
 
 		ci->ren1_other.path = pair1->one->path;
-		hashcpy(ci->ren1_other.oid.hash,
-			src_entry1->stages[ostage1].sha);
+		oidcpy(&ci->ren1_other.oid, &src_entry1->stages[ostage1].oid);
 		ci->ren1_other.mode = src_entry1->stages[ostage1].mode;
 
 		ci->ren2_other.path = pair2->one->path;
-		hashcpy(ci->ren2_other.oid.hash,
-			src_entry2->stages[ostage2].sha);
+		oidcpy(&ci->ren2_other.oid, &src_entry2->stages[ostage2].oid);
 		ci->ren2_other.mode = src_entry2->stages[ostage2].mode;
 	}
 }
@@ -316,11 +314,11 @@ static struct stage_data *insert_stage_data(const char *path,
 	struct string_list_item *item;
 	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
 	get_tree_entry(o->object.oid.hash, path,
-			e->stages[1].sha, &e->stages[1].mode);
+			e->stages[1].oid.hash, &e->stages[1].mode);
 	get_tree_entry(a->object.oid.hash, path,
-			e->stages[2].sha, &e->stages[2].mode);
+			e->stages[2].oid.hash, &e->stages[2].mode);
 	get_tree_entry(b->object.oid.hash, path,
-			e->stages[3].sha, &e->stages[3].mode);
+			e->stages[3].oid.hash, &e->stages[3].mode);
 	item = string_list_insert(entries, path);
 	item->util = e;
 	return e;
@@ -351,7 +349,7 @@ static struct string_list *get_unmerged(void)
 		}
 		e = item->util;
 		e->stages[ce_stage(ce)].mode = ce->ce_mode;
-		hashcpy(e->stages[ce_stage(ce)].sha, ce->sha1);
+		hashcpy(e->stages[ce_stage(ce)].oid.hash, ce->sha1);
 	}
 
 	return unmerged;
@@ -574,9 +572,9 @@ static void update_entry(struct stage_data *entry,
 	entry->stages[1].mode = o->mode;
 	entry->stages[2].mode = a->mode;
 	entry->stages[3].mode = b->mode;
-	hashcpy(entry->stages[1].sha, o->oid.hash);
-	hashcpy(entry->stages[2].sha, a->oid.hash);
-	hashcpy(entry->stages[3].sha, b->oid.hash);
+	oidcpy(&entry->stages[1].oid, &o->oid);
+	oidcpy(&entry->stages[2].oid, &a->oid);
+	oidcpy(&entry->stages[3].oid, &b->oid);
 }
 
 static int remove_file(struct merge_options *o, int clean,
@@ -1111,7 +1109,7 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 						 struct stage_data *entry,
 						 int stage)
 {
-	unsigned char *sha = entry->stages[stage].sha;
+	unsigned char *sha = entry->stages[stage].oid.hash;
 	unsigned mode = entry->stages[stage].mode;
 	if (mode == 0 || is_null_sha1(sha))
 		return NULL;
@@ -1425,11 +1423,11 @@ static int process_renames(struct merge_options *o,
 			remove_file(o, 1, ren1_src,
 				    renamed_stage == 2 || !was_tracked(ren1_src));
 
-			hashcpy(src_other.oid.hash,
-				ren1->src_entry->stages[other_stage].sha);
+			oidcpy(&src_other.oid,
+			       &ren1->src_entry->stages[other_stage].oid);
 			src_other.mode = ren1->src_entry->stages[other_stage].mode;
-			hashcpy(dst_other.oid.hash,
-				ren1->dst_entry->stages[other_stage].sha);
+			oidcpy(&dst_other.oid,
+			       &ren1->dst_entry->stages[other_stage].oid);
 			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
@@ -1703,9 +1701,9 @@ static int process_entry(struct merge_options *o,
 	unsigned o_mode = entry->stages[1].mode;
 	unsigned a_mode = entry->stages[2].mode;
 	unsigned b_mode = entry->stages[3].mode;
-	unsigned char *o_sha = stage_sha(entry->stages[1].sha, o_mode);
-	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
-	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
+	unsigned char *o_sha = stage_sha(entry->stages[1].oid.hash, o_mode);
+	unsigned char *a_sha = stage_sha(entry->stages[2].oid.hash, a_mode);
+	unsigned char *b_sha = stage_sha(entry->stages[3].oid.hash, b_mode);
 
 	entry->processed = 1;
 	if (entry->rename_conflict_info) {
