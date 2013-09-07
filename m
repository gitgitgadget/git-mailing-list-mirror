From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/12] index-pack: resolve v4 one-base trees
Date: Sat,  7 Sep 2013 17:43:19 +0700
Message-ID: <1378550599-25365-13-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:41:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFxb-0003Hy-Iv
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362Ab3IGKln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:41:43 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:64124 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab3IGKlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:41:42 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so4312130pdi.33
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JSi2o0L37Pa04w5AxjCIsctsYTg/u3otPVQIg9nwBhY=;
        b=EDBJo3zILAj9efntb8ZmrmUeW2FCZh53+6/s8B7bCD5rHSF6Ge1FaTa7e667x/OLs8
         qQ/sM3yuxPdqCX3PjqeJRfe2siaMMoCeuLp6Ezs0W5AllAJKWfchS+AL/izCVRS9cXk6
         Qjh0/m4RhNQHVjL5l1XHhEFU5ez8Scvo0uIzj4X6/voD1p/37Gfz+vWfVmzJnZv7vHLG
         ccxojciyzWrgvKQiLsaxXi/szpZbFkmfc3xTOARizJz6VKe6vn0GXeMv3haXl+fXv1UB
         C0gXuLxWgNem22/spM5nBxM9pu4DbNBMIOAMIym6BoArNmOHuTR0EiJz+BVuHUdyFMF4
         xXCw==
X-Received: by 10.68.216.227 with SMTP id ot3mr7977447pbc.80.1378550502258;
        Sat, 07 Sep 2013 03:41:42 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id iu7sm3366108pbc.45.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:41:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:44:50 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234130>

This is the most common case for delta trees. In fact it's the only
kind that's produced by packv4-create. It fits well in the way
index-pack resolves deltas and benefits from threading (the set of
objects depending on this base does not overlap with the set of
objects depending on another base)

Multi-base trees will be probably processed differently.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 194 +++++++++++++++++++++++++++++++++++++++++++=
+++-----
 1 file changed, 178 insertions(+), 16 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1fa74f4..4a24bc3 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -12,6 +12,8 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "packv4-parse.h"
+#include "varint.h"
+#include "tree-walk.h"
=20
 static const char index_pack_usage[] =3D
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=3D<msg>] [--ve=
rify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -38,8 +40,8 @@ struct base_data {
 	struct object_entry *obj;
 	void *data;
 	unsigned long size;
-	int ref_first, ref_last;
-	int ofs_first, ofs_last;
+	int ref_first, ref_last, tree_first;
+	int ofs_first, ofs_last, tree_last;
 };
=20
 #if !defined(NO_PTHREADS) && defined(NO_THREAD_SAFE_PREAD)
@@ -437,6 +439,7 @@ static struct base_data *alloc_base_data(void)
 	memset(base, 0, sizeof(*base));
 	base->ref_last =3D -1;
 	base->ofs_last =3D -1;
+	base->tree_last =3D -1;
 	return base;
 }
=20
@@ -670,6 +673,8 @@ static void *unpack_tree_v4(struct object_entry *ob=
j,
 	}
=20
 	if (last_base) {
+		if (nr_deltas - delta_start > 1)
+			die("sorry guys, multi-base trees are not supported yet");
 		strbuf_release(&sb);
 		return NULL;
 	} else {
@@ -794,6 +799,83 @@ static void *unpack_raw_entry(struct object_entry =
*obj,
 	return data;
 }
=20
+static void *patch_one_base_tree(const struct object_entry *src,
+				 const unsigned char *src_buf,
+				 const unsigned char *delta_buf,
+				 unsigned long delta_size,
+				 unsigned long *dst_size)
+{
+	unsigned int nr;
+	const unsigned char *last_base =3D NULL;
+	struct strbuf sb =3D STRBUF_INIT;
+	const unsigned char *p =3D delta_buf;
+
+	nr =3D decode_varint(&p);
+	while (nr && p < delta_buf + delta_size) {
+		unsigned int copy_start_or_path =3D decode_varint(&p);
+		if (copy_start_or_path & 1) { /* copy_start */
+			struct tree_desc desc;
+			struct name_entry entry;
+			unsigned int copy_count =3D decode_varint(&p);
+			unsigned int copy_start =3D copy_start_or_path >> 1;
+			if (!src)
+				die("we are not supposed to copy from another tree!");
+			if (copy_count & 1) { /* first delta */
+				unsigned int id =3D decode_varint(&p);
+				if (!id) {
+					last_base =3D p;
+					p +=3D 20;
+				} else
+					last_base =3D sha1_table + (id - 1) * 20;
+				if (hashcmp(last_base, src->idx.sha1))
+					die(_("bad tree base in patch_one_base_tree"));
+			} else if (!last_base)
+				die(_("bad copy count index in patch_one_base_tree"));
+			copy_count >>=3D 1;
+			if (!copy_count)
+				die(_("bad copy count index in patch_one_base_tree"));
+			nr -=3D copy_count;
+
+			init_tree_desc(&desc, src_buf, src->size);
+			while (tree_entry(&desc, &entry)) {
+				if (copy_start)
+					copy_start--;
+				else if (copy_count) {
+					strbuf_addf(&sb, "%o %s%c", entry.mode, entry.path, '\0');
+					strbuf_add(&sb, entry.sha1, 20);
+					copy_count--;
+				} else
+					break;
+			}
+		} else {	/* path */
+			unsigned int path_idx =3D copy_start_or_path >> 1;
+			const unsigned char *path;
+			unsigned mode;
+			unsigned int id;
+			const unsigned char *entry_sha1;
+
+			if (path_idx >=3D path_dict->nb_entries)
+				die(_("bad path index in unpack_tree_v4"));
+			id =3D decode_varint(&p);
+			if (!id) {
+				entry_sha1 =3D p;
+				p +=3D 20;
+			} else
+				entry_sha1 =3D sha1_table + (id - 1) * 20;
+			nr--;
+
+			path =3D path_dict->data + path_dict->offsets[path_idx];
+			mode =3D (path[0] << 8) | path[1];
+			strbuf_addf(&sb, "%o %s%c", mode, path+2, '\0');
+			strbuf_add(&sb, entry_sha1, 20);
+		}
+	}
+	if (nr !=3D 0 || p !=3D delta_buf + delta_size)
+		die(_("bad delta tree"));
+	*dst_size =3D sb.len;
+	return sb.buf;
+}
+
 static void *unpack_data(struct object_entry *obj,
 			 int (*consume)(const unsigned char *, unsigned long, void *),
 			 void *cb_data)
@@ -855,8 +937,33 @@ static void *unpack_data(struct object_entry *obj,
 	return data;
 }
=20
+static void *get_tree_v4_from_pack(struct object_entry *obj,
+				   unsigned long *len_p)
+{
+	off_t from =3D obj[0].idx.offset + obj[0].hdr_size;
+	unsigned long len =3D obj[1].idx.offset - from;
+	unsigned char *data;
+	ssize_t n;
+
+	data =3D xmalloc(len);
+	n =3D pread(pack_fd, data, len, from);
+	if (n < 0)
+		die_errno(_("cannot pread pack file"));
+	if (!n)
+		die(Q_("premature end of pack file, %lu byte missing",
+		       "premature end of pack file, %lu bytes missing",
+		       len),
+		    len);
+	if (len_p)
+		*len_p =3D len;
+	return data;
+}
+
 static void *get_data_from_pack(struct object_entry *obj)
 {
+	if (obj->type =3D=3D OBJ_PV4_COMMIT || obj->type =3D=3D OBJ_PV4_TREE)
+		die("BUG: unsupported code path");
+
 	return unpack_data(obj, NULL, NULL);
 }
=20
@@ -1096,14 +1203,25 @@ static void *get_base_data(struct base_data *c)
 		struct object_entry *obj =3D c->obj;
 		struct base_data **delta =3D NULL;
 		int delta_nr =3D 0, delta_alloc =3D 0;
+		unsigned long size, len;
=20
-		while (is_delta_type(c->obj->type) && !c->data) {
+		while ((is_delta_type(c->obj->type) ||
+			(c->base && c->obj->type =3D=3D OBJ_PV4_TREE)) &&
+		       !c->data) {
 			ALLOC_GROW(delta, delta_nr + 1, delta_alloc);
 			delta[delta_nr++] =3D c;
 			c =3D c->base;
 		}
 		if (!delta_nr) {
-			c->data =3D get_data_from_pack(obj);
+			if (c->obj->type =3D=3D OBJ_PV4_TREE) {
+				void *tree_v4 =3D get_tree_v4_from_pack(obj, &len);
+				c->data =3D patch_one_base_tree(NULL, NULL,
+							      tree_v4, len, &size);
+				if (size !=3D obj->size)
+					die("size mismatch");
+				free(tree_v4);
+			} else
+				c->data =3D get_data_from_pack(obj);
 			c->size =3D obj->size;
 			get_thread_data()->base_cache_used +=3D c->size;
 			prune_base_data(c);
@@ -1113,11 +1231,18 @@ static void *get_base_data(struct base_data *c)
 			c =3D delta[delta_nr - 1];
 			obj =3D c->obj;
 			base =3D get_base_data(c->base);
-			raw =3D get_data_from_pack(obj);
-			c->data =3D patch_delta(
-				base, c->base->size,
-				raw, obj->size,
-				&c->size);
+			if (c->obj->type =3D=3D OBJ_PV4_TREE) {
+				raw =3D get_tree_v4_from_pack(obj, &len);
+				c->data =3D patch_one_base_tree(c->base->obj, base,
+							      raw, len, &size);
+				if (size !=3D obj->size)
+					die("size mismatch");
+			} else {
+				raw =3D get_data_from_pack(obj);
+				c->data =3D patch_delta(base, c->base->size,
+						      raw, obj->size,
+						      &c->size);
+			}
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, _("failed to apply delta"));
@@ -1133,6 +1258,8 @@ static void resolve_delta(struct object_entry *de=
lta_obj,
 			  struct base_data *base, struct base_data *result)
 {
 	void *base_data, *delta_data;
+	int tree_v4 =3D delta_obj->type =3D=3D OBJ_PV4_TREE;
+	unsigned long tree_size;
=20
 	delta_obj->real_type =3D base->obj->real_type;
 	if (show_stat) {
@@ -1143,10 +1270,18 @@ static void resolve_delta(struct object_entry *=
delta_obj,
 		deepest_delta_unlock();
 	}
 	delta_obj->base_object_no =3D base->obj - objects;
-	delta_data =3D get_data_from_pack(delta_obj);
+	if (tree_v4)
+		delta_data =3D get_tree_v4_from_pack(delta_obj, &tree_size);
+	else
+		delta_data =3D get_data_from_pack(delta_obj);
 	base_data =3D get_base_data(base);
 	result->obj =3D delta_obj;
-	result->data =3D patch_delta(base_data, base->size,
+	if (tree_v4)
+		result->data =3D patch_one_base_tree(base->obj, base_data,
+						   delta_data, tree_size,
+						   &result->size);
+	else
+		result->data =3D patch_delta(base_data, base->size,
 				   delta_data, delta_obj->size, &result->size);
 	free(delta_data);
 	if (!result->data)
@@ -1164,7 +1299,8 @@ static void resolve_delta(struct object_entry *de=
lta_obj,
 static struct base_data *find_unresolved_deltas_1(struct base_data *ba=
se,
 						  struct base_data *prev_base)
 {
-	if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D -1) {
+	if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D -1 &&
+	    base->tree_last =3D=3D -1) {
 		union delta_base base_spec;
=20
 		hashcpy(base_spec.sha1, base->obj->idx.sha1);
@@ -1177,9 +1313,15 @@ static struct base_data *find_unresolved_deltas_=
1(struct base_data *base,
 			find_delta_children(&base_spec,
 					    &base->ofs_first, &base->ofs_last,
 					    OBJ_OFS_DELTA);
+		} else {
+			hashcpy(base_spec.sha1, base->obj->idx.sha1);
+			find_delta_children(&base_spec,
+					    &base->tree_first, &base->tree_last,
+					    OBJ_PV4_TREE);
 		}
=20
-		if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D -1) {
+		if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D -1 &&
+		    base->tree_last =3D=3D -1) {
 			free(base->data);
 			return NULL;
 		}
@@ -1213,6 +1355,25 @@ static struct base_data *find_unresolved_deltas_=
1(struct base_data *base,
 		return result;
 	}
=20
+	while (base->tree_first <=3D base->tree_last) {
+		struct object_entry *child =3D objects + deltas[base->tree_first].ob=
j_no;
+		struct base_data *result;
+
+		assert(child->type =3D=3D OBJ_PV4_TREE);
+		if (child->nr_bases > 1) {
+			/* maybe resolved in the third pass or something */
+			base->tree_first++;
+			continue;
+		}
+		result =3D alloc_base_data();
+		resolve_delta(child, base, result);
+		if (base->tree_first =3D=3D base->tree_last)
+			free_base_data(base);
+
+		base->tree_first++;
+		return result;
+	}
+
 	unlink_base_data(base);
 	return NULL;
 }
@@ -1266,7 +1427,8 @@ static void *threaded_second_pass(void *data)
 		counter_unlock();
 		work_lock();
 		while (nr_dispatched < nr_objects &&
-		       is_delta_type(objects[nr_dispatched].type))
+		       (is_delta_type(objects[nr_dispatched].type) ||
+			is_delta_tree(objects + nr_dispatched)))
 			nr_dispatched++;
 		if (nr_dispatched >=3D nr_objects) {
 			work_unlock();
@@ -1411,7 +1573,7 @@ static void resolve_deltas(void)
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
=20
-		if (is_delta_type(obj->type))
+		if (is_delta_type(obj->type) || is_delta_tree(obj))
 			continue;
 		resolve_base(obj);
 		display_progress(progress, nr_resolved_deltas);
@@ -1956,7 +2118,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 		show_pack_info(stat_only);
=20
 	if (packv4)
-		die("we're not there yet");
+		opts.version =3D 3;
=20
 	idx_objects =3D xmalloc((nr_objects) * sizeof(struct pack_idx_entry *=
));
 	for (i =3D 0; i < nr_objects; i++)
--=20
1.8.2.83.gc99314b
