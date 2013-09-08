From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/14] index-pack: resolve v4 one-base trees
Date: Sun,  8 Sep 2013 14:22:40 +0700
Message-ID: <1378624960-8919-15-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:21:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZIu-0004Rj-6W
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab3IHHU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:59 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:36967 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:20:58 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so4867637pbb.38
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Aq5Pen8uJDtzeHHp31qqx/OIsc7X/lFLOpegEEGw7DA=;
        b=DgZDs9Vje7fMljP0KPetmFvZx+Zpek0ger5dbvHvKkmwQuPv07iWNFnw6IaRIvG4bV
         emfAAQQHZn5whYW2U5NLUL9oVfbWz+i0AwKaU2pG3SwIn8IMCxu4A/QnRzytxqIeSh6k
         hzNvmG2UUtVh9zzvhh8EF/brz1CwsbUVPfeVnqr+PUST1K0Dy6JfqoazhhmdMJYXhw00
         VulPVnMy0WQs5r8lmJYR5yh2crlG7bMhj386bwp/Ueo6Bood3chzfR9AcifdHBKn+mLD
         uu1yIIJE1xjkLKTO09FZru0A90/CO8Pn9hZgyq73VIT0bc5k1Atogvz1TbBCX5elmuXP
         9KPw==
X-Received: by 10.68.108.3 with SMTP id hg3mr12165039pbb.91.1378624858338;
        Sun, 08 Sep 2013 00:20:58 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id ct4sm8419679pbb.41.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:20:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:24:04 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234211>

This is the most common case for delta trees. In fact it's the only
kind that's produced by packv4-create. It fits well in the way
index-pack resolves deltas and benefits from threading (the set of
objects depending on this base does not overlap with the set of
objects depending on another base)

Multi-base trees will be probably processed differently.
---
 builtin/index-pack.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 179 insertions(+), 16 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ce06473..88340b5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -12,6 +12,8 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "packv4-parse.h"
+#include "varint.h"
+#include "tree-walk.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -38,8 +40,8 @@ struct base_data {
 	struct object_entry *obj;
 	void *data;
 	unsigned long size;
-	int ref_first, ref_last;
-	int ofs_first, ofs_last;
+	int ref_first, ref_last, tree_first;
+	int ofs_first, ofs_last, tree_last;
 };
 
 #if !defined(NO_PTHREADS) && defined(NO_THREAD_SAFE_PREAD)
@@ -430,6 +432,7 @@ static struct base_data *alloc_base_data(void)
 	memset(base, 0, sizeof(*base));
 	base->ref_last = -1;
 	base->ofs_last = -1;
+	base->tree_last = -1;
 	return base;
 }
 
@@ -670,6 +673,8 @@ static void *unpack_tree_v4(struct object_entry *obj,
 	}
 
 	if (last_base) {
+		if (nr_deltas - delta_start > 1)
+			die("sorry guys, multi-base trees are not supported yet");
 		strbuf_release(&sb);
 		return NULL;
 	} else {
@@ -800,6 +805,84 @@ static void *unpack_raw_entry(struct object_entry *obj,
 }
 
 /*
+ * Some checks are skipped because they are already done by
+ * unpack_tree_v4() in the first pass.
+ */
+static void *patch_one_base_tree(const struct object_entry *src,
+				 const unsigned char *src_buf,
+				 const unsigned char *delta_buf,
+				 unsigned long delta_size,
+				 unsigned long *dst_size)
+{
+	int nr;
+	const unsigned char *last_base = NULL;
+	struct strbuf sb = STRBUF_INIT;
+	const unsigned char *p = delta_buf;
+
+	nr = decode_varint(&p);
+	while (nr > 0 && p < delta_buf + delta_size) {
+		unsigned int copy_start_or_path = decode_varint(&p);
+		if (copy_start_or_path & 1) { /* copy_start */
+			struct tree_desc desc;
+			struct name_entry entry;
+			unsigned int copy_count = decode_varint(&p);
+			unsigned int copy_start = copy_start_or_path >> 1;
+			if (!src)
+				die("we are not supposed to copy from another tree!");
+			if (copy_count & 1) { /* first delta */
+				unsigned int id = decode_varint(&p);
+				if (!id) {
+					last_base = p;
+					p += 20;
+				} else
+					last_base = sha1_table + (id - 1) * 20;
+				if (hashcmp(last_base, src->idx.sha1))
+					die(_("bad tree base in patch_one_base_tree"));
+			}
+
+			copy_count >>= 1;
+			nr -= copy_count;
+
+			init_tree_desc(&desc, src_buf, src->size);
+			while (tree_entry(&desc, &entry)) {
+				if (copy_start)
+					copy_start--;
+				else if (copy_count) {
+					strbuf_addf(&sb, "%o %s%c",
+						    entry.mode, entry.path, '\0');
+					strbuf_add(&sb, entry.sha1, 20);
+					copy_count--;
+				} else
+					break;
+			}
+		} else {	/* path */
+			unsigned int path_idx = copy_start_or_path >> 1;
+			const unsigned char *path;
+			unsigned mode;
+			unsigned int id;
+			const unsigned char *entry_sha1;
+
+			id = decode_varint(&p);
+			if (!id) {
+				entry_sha1 = p;
+				p += 20;
+			} else
+				entry_sha1 = sha1_table + (id - 1) * 20;
+			nr--;
+
+			path = path_dict->data + path_dict->offsets[path_idx];
+			mode = (path[0] << 8) | path[1];
+			strbuf_addf(&sb, "%o %s%c", mode, path+2, '\0');
+			strbuf_add(&sb, entry_sha1, 20);
+		}
+	}
+	if (nr != 0 || p != delta_buf + delta_size)
+		die(_("bad delta tree"));
+	*dst_size = sb.len;
+	return sb.buf;
+}
+
+/*
  * Unpack entry data in the second pass when the pack is already
  * stored on disk. consume call back is used for large-blob case. Must
  * be thread safe.
@@ -865,8 +948,33 @@ static void *unpack_data(struct object_entry *obj,
 	return data;
 }
 
+static void *get_tree_v4_from_pack(struct object_entry *obj,
+				   unsigned long *len_p)
+{
+	off_t from = obj[0].idx.offset + obj[0].hdr_size;
+	unsigned long len = obj[1].idx.offset - from;
+	unsigned char *data;
+	ssize_t n;
+
+	data = xmalloc(len);
+	n = pread(pack_fd, data, len, from);
+	if (n < 0)
+		die_errno(_("cannot pread pack file"));
+	if (!n)
+		die(Q_("premature end of pack file, %lu byte missing",
+		       "premature end of pack file, %lu bytes missing",
+		       len),
+		    len);
+	if (len_p)
+		*len_p = len;
+	return data;
+}
+
 static void *get_data_from_pack(struct object_entry *obj)
 {
+	if (obj->type == OBJ_PV4_COMMIT || obj->type == OBJ_PV4_TREE)
+		die("BUG: unsupported code path");
+
 	return unpack_data(obj, NULL, NULL);
 }
 
@@ -1093,14 +1201,25 @@ static void *get_base_data(struct base_data *c)
 		struct object_entry *obj = c->obj;
 		struct base_data **delta = NULL;
 		int delta_nr = 0, delta_alloc = 0;
+		unsigned long size, len;
 
-		while (is_delta_type(c->obj->type) && !c->data) {
+		while ((is_delta_type(c->obj->type) ||
+			(c->base && c->obj->type == OBJ_PV4_TREE)) &&
+		       !c->data) {
 			ALLOC_GROW(delta, delta_nr + 1, delta_alloc);
 			delta[delta_nr++] = c;
 			c = c->base;
 		}
 		if (!delta_nr) {
-			c->data = get_data_from_pack(obj);
+			if (c->obj->type == OBJ_PV4_TREE) {
+				void *tree_v4 = get_tree_v4_from_pack(obj, &len);
+				c->data = patch_one_base_tree(NULL, NULL,
+							      tree_v4, len, &size);
+				if (size != obj->size)
+					die("size mismatch");
+				free(tree_v4);
+			} else
+				c->data = get_data_from_pack(obj);
 			c->size = obj->size;
 			get_thread_data()->base_cache_used += c->size;
 			prune_base_data(c);
@@ -1110,11 +1229,18 @@ static void *get_base_data(struct base_data *c)
 			c = delta[delta_nr - 1];
 			obj = c->obj;
 			base = get_base_data(c->base);
-			raw = get_data_from_pack(obj);
-			c->data = patch_delta(
-				base, c->base->size,
-				raw, obj->size,
-				&c->size);
+			if (c->obj->type == OBJ_PV4_TREE) {
+				raw = get_tree_v4_from_pack(obj, &len);
+				c->data = patch_one_base_tree(c->base->obj, base,
+							      raw, len, &size);
+				if (size != obj->size)
+					die("size mismatch");
+			} else {
+				raw = get_data_from_pack(obj);
+				c->data = patch_delta(base, c->base->size,
+						      raw, obj->size,
+						      &c->size);
+			}
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, _("failed to apply delta"));
@@ -1130,6 +1256,8 @@ static void resolve_delta(struct object_entry *delta_obj,
 			  struct base_data *base, struct base_data *result)
 {
 	void *base_data, *delta_data;
+	int tree_v4 = delta_obj->type == OBJ_PV4_TREE;
+	unsigned long tree_size;
 
 	delta_obj->real_type = base->obj->real_type;
 	if (show_stat) {
@@ -1140,10 +1268,18 @@ static void resolve_delta(struct object_entry *delta_obj,
 		deepest_delta_unlock();
 	}
 	delta_obj->base_object_no = base->obj - objects;
-	delta_data = get_data_from_pack(delta_obj);
+	if (tree_v4)
+		delta_data = get_tree_v4_from_pack(delta_obj, &tree_size);
+	else
+		delta_data = get_data_from_pack(delta_obj);
 	base_data = get_base_data(base);
 	result->obj = delta_obj;
-	result->data = patch_delta(base_data, base->size,
+	if (tree_v4)
+		result->data = patch_one_base_tree(base->obj, base_data,
+						   delta_data, tree_size,
+						   &result->size);
+	else
+		result->data = patch_delta(base_data, base->size,
 				   delta_data, delta_obj->size, &result->size);
 	free(delta_data);
 	if (!result->data)
@@ -1166,7 +1302,8 @@ static void resolve_delta(struct object_entry *delta_obj,
 static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 						  struct base_data *prev_base)
 {
-	if (base->ref_last == -1 && base->ofs_last == -1) {
+	if (base->ref_last == -1 && base->ofs_last == -1 &&
+	    base->tree_last == -1) {
 		union delta_base base_spec;
 
 		hashcpy(base_spec.sha1, base->obj->idx.sha1);
@@ -1179,9 +1316,15 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 			find_delta_children(&base_spec,
 					    &base->ofs_first, &base->ofs_last,
 					    OBJ_OFS_DELTA);
+		} else {
+			hashcpy(base_spec.sha1, base->obj->idx.sha1);
+			find_delta_children(&base_spec,
+					    &base->tree_first, &base->tree_last,
+					    OBJ_PV4_TREE);
 		}
 
-		if (base->ref_last == -1 && base->ofs_last == -1) {
+		if (base->ref_last == -1 && base->ofs_last == -1 &&
+		    base->tree_last == -1) {
 			free(base->data);
 			return NULL;
 		}
@@ -1215,6 +1358,25 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 		return result;
 	}
 
+	while (base->tree_first <= base->tree_last) {
+		struct object_entry *child = objects + deltas[base->tree_first].obj_no;
+		struct base_data *result;
+
+		assert(child->type == OBJ_PV4_TREE);
+		if (child->nr_bases > 1) {
+			/* maybe resolved in the third pass or something */
+			base->tree_first++;
+			continue;
+		}
+		result = alloc_base_data();
+		resolve_delta(child, base, result);
+		if (base->tree_first == base->tree_last)
+			free_base_data(base);
+
+		base->tree_first++;
+		return result;
+	}
+
 	unlink_base_data(base);
 	return NULL;
 }
@@ -1273,7 +1435,8 @@ static void *threaded_second_pass(void *data)
 		counter_unlock();
 		work_lock();
 		while (nr_dispatched < nr_objects &&
-		       is_delta_type(objects[nr_dispatched].type))
+		       (is_delta_type(objects[nr_dispatched].type) ||
+			is_delta_tree(objects + nr_dispatched)))
 			nr_dispatched++;
 		if (nr_dispatched >= nr_objects) {
 			work_unlock();
@@ -1427,7 +1590,7 @@ static void resolve_deltas(void)
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 
-		if (is_delta_type(obj->type))
+		if (is_delta_type(obj->type) || is_delta_tree(obj))
 			continue;
 		resolve_base(obj);
 		display_progress(progress, nr_resolved_deltas);
@@ -1972,7 +2135,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		show_pack_info(stat_only);
 
 	if (packv4)
-		die("we're not there yet");
+		opts.version = 3;
 
 	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
 	for (i = 0; i < nr_objects; i++)
-- 
1.8.2.83.gc99314b
