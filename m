Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 4634 invoked by uid 111); 14 Jul 2008 02:08:08 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 13 Jul 2008 22:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbYGNCHw (ORCPT <rfc822;peff@peff.net>);
	Sun, 13 Jul 2008 22:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbYGNCHv
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 22:07:51 -0400
Received: from george.spearce.org ([209.20.77.23]:36303 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbYGNCHt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 22:07:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B3B3B383A8; Mon, 14 Jul 2008 02:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D97FE3836B;
	Mon, 14 Jul 2008 02:07:47 +0000 (UTC)
From:	"Shawn O. Pearce" <spearce@spearce.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Stephan Hennig <mailing_list@arcor.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
Subject: [PATCH 1/4] index-pack: Refactor base arguments of resolve_delta into a struct
Date:	Sun, 13 Jul 2008 22:07:44 -0400
Message-Id: <1216001267-33235-2-git-send-email-spearce@spearce.org>
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <1216001267-33235-1-git-send-email-spearce@spearce.org>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org>
In-Reply-To: <20080713011512.GB31050@spearce.org>
References: <20080713011512.GB31050@spearce.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Old-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4

We need to discard base objects which are not recently used if our
memory gets low, such as when we are unpacking a long delta chain
of a very large object.

To support tracking the available base objects we combine the
pointer and size into a struct.  Future changes would allow the
data pointer to be free'd and marked NULL if memory gets low.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 index-pack.c |   60 +++++++++++++++++++++++++++++++--------------------------
 1 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 25db5db..db03478 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -26,6 +26,11 @@ union delta_base {
 	off_t offset;
 };
 
+struct base_data {
+	void *data;
+	unsigned long size;
+};
+
 /*
  * Even if sizeof(union delta_base) == 24 on 64-bit archs, we really want
  * to memcmp() only the first 20 bytes.
@@ -426,25 +431,25 @@ static void sha1_object(const void *data, unsigned long size,
 	}
 }
 
-static void resolve_delta(struct object_entry *delta_obj, void *base_data,
-			  unsigned long base_size, enum object_type type)
+static void resolve_delta(struct object_entry *delta_obj,
+			  struct base_data *base_obj, enum object_type type)
 {
 	void *delta_data;
 	unsigned long delta_size;
-	void *result;
-	unsigned long result_size;
 	union delta_base delta_base;
 	int j, first, last;
+	struct base_data result;
 
 	delta_obj->real_type = type;
 	delta_data = get_data_from_pack(delta_obj);
 	delta_size = delta_obj->size;
-	result = patch_delta(base_data, base_size, delta_data, delta_size,
-			     &result_size);
+	result.data = patch_delta(base_obj->data, base_obj->size,
+			     delta_data, delta_size,
+			     &result.size);
 	free(delta_data);
-	if (!result)
+	if (!result.data)
 		bad_object(delta_obj->idx.offset, "failed to apply delta");
-	sha1_object(result, result_size, type, delta_obj->idx.sha1);
+	sha1_object(result.data, result.size, type, delta_obj->idx.sha1);
 	nr_resolved_deltas++;
 
 	hashcpy(delta_base.sha1, delta_obj->idx.sha1);
@@ -452,7 +457,7 @@ static void resolve_delta(struct object_entry *delta_obj, void *base_data,
 		for (j = first; j <= last; j++) {
 			struct object_entry *child = objects + deltas[j].obj_no;
 			if (child->real_type == OBJ_REF_DELTA)
-				resolve_delta(child, result, result_size, type);
+				resolve_delta(child, &result, type);
 		}
 	}
 
@@ -462,11 +467,11 @@ static void resolve_delta(struct object_entry *delta_obj, void *base_data,
 		for (j = first; j <= last; j++) {
 			struct object_entry *child = objects + deltas[j].obj_no;
 			if (child->real_type == OBJ_OFS_DELTA)
-				resolve_delta(child, result, result_size, type);
+				resolve_delta(child, &result, type);
 		}
 	}
 
-	free(result);
+	free(result.data);
 }
 
 static int compare_delta_entry(const void *a, const void *b)
@@ -481,7 +486,6 @@ static void parse_pack_objects(unsigned char *sha1)
 {
 	int i;
 	struct delta_entry *delta = deltas;
-	void *data;
 	struct stat st;
 
 	/*
@@ -496,7 +500,7 @@ static void parse_pack_objects(unsigned char *sha1)
 				nr_objects);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
-		data = unpack_raw_entry(obj, &delta->base);
+		void *data = unpack_raw_entry(obj, &delta->base);
 		obj->real_type = obj->type;
 		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
 			nr_deltas++;
@@ -545,6 +549,7 @@ static void parse_pack_objects(unsigned char *sha1)
 		struct object_entry *obj = &objects[i];
 		union delta_base base;
 		int j, ref, ref_first, ref_last, ofs, ofs_first, ofs_last;
+		struct base_data base_obj;
 
 		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA)
 			continue;
@@ -555,22 +560,22 @@ static void parse_pack_objects(unsigned char *sha1)
 		ofs = !find_delta_children(&base, &ofs_first, &ofs_last);
 		if (!ref && !ofs)
 			continue;
-		data = get_data_from_pack(obj);
+		base_obj.data = get_data_from_pack(obj);
+		base_obj.size = obj->size;
+
 		if (ref)
 			for (j = ref_first; j <= ref_last; j++) {
 				struct object_entry *child = objects + deltas[j].obj_no;
 				if (child->real_type == OBJ_REF_DELTA)
-					resolve_delta(child, data,
-						      obj->size, obj->type);
+					resolve_delta(child, &base_obj, obj->type);
 			}
 		if (ofs)
 			for (j = ofs_first; j <= ofs_last; j++) {
 				struct object_entry *child = objects + deltas[j].obj_no;
 				if (child->real_type == OBJ_OFS_DELTA)
-					resolve_delta(child, data,
-						      obj->size, obj->type);
+					resolve_delta(child, &base_obj, obj->type);
 			}
-		free(data);
+		free(base_obj.data);
 		display_progress(progress, nr_resolved_deltas);
 	}
 }
@@ -656,28 +661,29 @@ static void fix_unresolved_deltas(int nr_unresolved)
 
 	for (i = 0; i < n; i++) {
 		struct delta_entry *d = sorted_by_pos[i];
-		void *data;
-		unsigned long size;
 		enum object_type type;
 		int j, first, last;
+		struct base_data base_obj;
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
-		data = read_sha1_file(d->base.sha1, &type, &size);
-		if (!data)
+		base_obj.data = read_sha1_file(d->base.sha1, &type, &base_obj.size);
+		if (!base_obj.data)
 			continue;
 
 		find_delta_children(&d->base, &first, &last);
 		for (j = first; j <= last; j++) {
 			struct object_entry *child = objects + deltas[j].obj_no;
 			if (child->real_type == OBJ_REF_DELTA)
-				resolve_delta(child, data, size, type);
+				resolve_delta(child, &base_obj, type);
 		}
 
-		if (check_sha1_signature(d->base.sha1, data, size, typename(type)))
+		if (check_sha1_signature(d->base.sha1, base_obj.data,
+				base_obj.size, typename(type)))
 			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
-		append_obj_to_pack(d->base.sha1, data, size, type);
-		free(data);
+		append_obj_to_pack(d->base.sha1, base_obj.data,
+			base_obj.size, type);
+		free(base_obj.data);
 		display_progress(progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
-- 
1.5.6.2.393.g45096

