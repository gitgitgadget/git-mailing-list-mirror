From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/16] pack v4: stop using static/global variables in packv4-create.c
Date: Mon,  9 Sep 2013 20:57:53 +0700
Message-ID: <1378735087-4813-3-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:55:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1wI-0002Rx-QA
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab3IINz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:55:28 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:61199 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab3IINzX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:55:23 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so6255147pdj.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WXaFzixUEXgXi0buKoxUJtze56P5IaRg8/stEN44d9k=;
        b=K1dZccy3gTZhLwQpYYrB70kIeq4eWHy68Evb9cE2M31708L2TABNBhsQ1Wns3Rl1uO
         /2Que6sD3xPjq9f5BeQUzP63CefjAuHbw6ALoW+J3W/5y1RfXHMO9gB0cZYRnaoLui9x
         iCsa7l0ozbSlsmsGGDXtFqmoboAFPbhm3/mbynuJFqtvra/WVAaieH8XU16nT1JDOwDd
         C/dL11PHZRDRszqSH+cUZ3pIptxWff4EMxaLYEQLwMCI6gUL4HJ4s+oJ+FNAu/5pDKnq
         yco0IaM5fmOUECou7dv/boHnGu68oeqfvnnJl9sQJE5BavdUpcL0L4PPPHjNJD6DjVdZ
         LzOg==
X-Received: by 10.66.216.129 with SMTP id oq1mr20570276pac.75.1378734922808;
        Mon, 09 Sep 2013 06:55:22 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id sy2sm16439702pbc.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:55:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:58:31 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234330>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-create.c       | 103 ++++++++++++++++++++++++++++--------------=
--------
 packv4-create.h (new) |  11 ++++++
 2 files changed, 69 insertions(+), 45 deletions(-)
 create mode 100644 packv4-create.h

diff --git a/packv4-create.c b/packv4-create.c
index dbc2a03..920a0b4 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -15,6 +15,7 @@
 #include "pack-revindex.h"
 #include "progress.h"
 #include "varint.h"
+#include "packv4-create.h"
=20
=20
 static int pack_compression_seen;
@@ -145,9 +146,6 @@ static void sort_dict_entries_by_hits(struct dict_t=
able *t)
 	rehash_entries(t);
 }
=20
-static struct dict_table *commit_ident_table;
-static struct dict_table *tree_path_table;
-
 /*
  * Parse the author/committer line from a canonical commit object.
  * The 'from' argument points right after the "author " or "committer =
"
@@ -243,10 +241,10 @@ void dump_dict_table(struct dict_table *t)
 	}
 }
=20
-static void dict_dump(void)
+static void dict_dump(struct packv4_tables *v4)
 {
-	dump_dict_table(commit_ident_table);
-	dump_dict_table(tree_path_table);
+	dump_dict_table(v4->commit_ident_table);
+	dump_dict_table(v4->tree_path_table);
 }
=20
 /*
@@ -254,10 +252,12 @@ static void dict_dump(void)
  * pack SHA1 table incremented by 1, or the literal SHA1 value prefixe=
d
  * with a zero byte if the needed SHA1 is not available in the table.
  */
-static struct pack_idx_entry *all_objs;
-static unsigned all_objs_nr;
-static int encode_sha1ref(const unsigned char *sha1, unsigned char *bu=
f)
+
+int encode_sha1ref(const struct packv4_tables *v4,
+		   const unsigned char *sha1, unsigned char *buf)
 {
+	unsigned all_objs_nr =3D v4->all_objs_nr;
+	struct pack_idx_entry *all_objs =3D v4->all_objs;
 	unsigned lo =3D 0, hi =3D all_objs_nr;
=20
 	do {
@@ -284,7 +284,8 @@ static int encode_sha1ref(const unsigned char *sha1=
, unsigned char *buf)
  * strict so to ensure the canonical version may always be
  * regenerated and produce the same hash.
  */
-void *pv4_encode_commit(void *buffer, unsigned long *sizep)
+void *pv4_encode_commit(const struct packv4_tables *v4,
+			void *buffer, unsigned long *sizep)
 {
 	unsigned long size =3D *sizep;
 	char *in, *tail, *end;
@@ -310,7 +311,7 @@ void *pv4_encode_commit(void *buffer, unsigned long=
 *sizep)
 	if (get_sha1_lowhex(in + 5, sha1) < 0)
 		goto bad_data;
 	in +=3D 46;
-	out +=3D encode_sha1ref(sha1, out);
+	out +=3D encode_sha1ref(v4, sha1, out);
=20
 	/* count how many "parent" lines */
 	nb_parents =3D 0;
@@ -325,7 +326,7 @@ void *pv4_encode_commit(void *buffer, unsigned long=
 *sizep)
 	while (nb_parents--) {
 		if (get_sha1_lowhex(in + 7, sha1))
 			goto bad_data;
-		out +=3D encode_sha1ref(sha1, out);
+		out +=3D encode_sha1ref(v4, sha1, out);
 		in +=3D 48;
 	}
=20
@@ -337,7 +338,7 @@ void *pv4_encode_commit(void *buffer, unsigned long=
 *sizep)
 	end =3D get_nameend_and_tz(in, &tz_val);
 	if (!end)
 		goto bad_data;
-	author_index =3D dict_add_entry(commit_ident_table, tz_val, in, end -=
 in);
+	author_index =3D dict_add_entry(v4->commit_ident_table, tz_val, in, e=
nd - in);
 	if (author_index < 0)
 		goto bad_dict;
 	author_time =3D strtoul(end, &end, 10);
@@ -353,7 +354,7 @@ void *pv4_encode_commit(void *buffer, unsigned long=
 *sizep)
 	end =3D get_nameend_and_tz(in, &tz_val);
 	if (!end)
 		goto bad_data;
-	commit_index =3D dict_add_entry(commit_ident_table, tz_val, in, end -=
 in);
+	commit_index =3D dict_add_entry(v4->commit_ident_table, tz_val, in, e=
nd - in);
 	if (commit_index < 0)
 		goto bad_dict;
 	commit_time =3D strtoul(end, &end, 10);
@@ -436,7 +437,8 @@ static int compare_tree_entries(struct name_entry *=
e1, struct name_entry *e2)
  * If a delta buffer is provided, we may encode multiple ranges of tre=
e
  * entries against that buffer.
  */
-void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
+void *pv4_encode_tree(const struct packv4_tables *v4,
+		      void *_buffer, unsigned long *sizep,
 		      void *delta, unsigned long delta_size,
 		      const unsigned char *delta_sha1)
 {
@@ -551,7 +553,7 @@ void *pv4_encode_tree(void *_buffer, unsigned long =
*sizep,
 			cp +=3D encode_varint(copy_start, cp);
 			cp +=3D encode_varint(copy_count, cp);
 			if (first_delta)
-				cp +=3D encode_sha1ref(delta_sha1, cp);
+				cp +=3D encode_sha1ref(v4, delta_sha1, cp);
=20
 			/*
 			 * Now let's make sure this is going to take less
@@ -577,7 +579,7 @@ void *pv4_encode_tree(void *_buffer, unsigned long =
*sizep,
 		}
=20
 		pathlen =3D tree_entry_len(&name_entry);
-		index =3D dict_add_entry(tree_path_table, name_entry.mode,
+		index =3D dict_add_entry(v4->tree_path_table, name_entry.mode,
 				       name_entry.path, pathlen);
 		if (index < 0) {
 			error("missing tree dict entry");
@@ -585,7 +587,7 @@ void *pv4_encode_tree(void *_buffer, unsigned long =
*sizep,
 			return NULL;
 		}
 		out +=3D encode_varint(index << 1, out);
-		out +=3D encode_sha1ref(name_entry.sha1, out);
+		out +=3D encode_sha1ref(v4, name_entry.sha1, out);
 	}
=20
 	if (copy_count) {
@@ -596,7 +598,7 @@ void *pv4_encode_tree(void *_buffer, unsigned long =
*sizep,
 		cp +=3D encode_varint(copy_start, cp);
 		cp +=3D encode_varint(copy_count, cp);
 		if (first_delta)
-			cp +=3D encode_sha1ref(delta_sha1, cp);
+			cp +=3D encode_sha1ref(v4, delta_sha1, cp);
 		if (copy_count >=3D min_tree_copy &&
 		    cp - copy_buf < out - &buffer[copy_pos]) {
 			out =3D buffer + copy_pos;
@@ -649,14 +651,15 @@ static struct pack_idx_entry **sort_objs_by_offse=
t(struct pack_idx_entry *list,
 	return sorted;
 }
=20
-static int create_pack_dictionaries(struct packed_git *p,
+static int create_pack_dictionaries(struct packv4_tables *v4,
+				    struct packed_git *p,
 				    struct pack_idx_entry **obj_list)
 {
 	struct progress *progress_state;
 	unsigned int i;
=20
-	commit_ident_table =3D create_dict_table();
-	tree_path_table =3D create_dict_table();
+	v4->commit_ident_table =3D create_dict_table();
+	v4->tree_path_table =3D create_dict_table();
=20
 	progress_state =3D start_progress("Scanning objects", p->num_objects)=
;
 	for (i =3D 0; i < p->num_objects; i++) {
@@ -679,11 +682,11 @@ static int create_pack_dictionaries(struct packed=
_git *p,
 		switch (type) {
 		case OBJ_COMMIT:
 			add_dict_entries =3D add_commit_dict_entries;
-			dict =3D commit_ident_table;
+			dict =3D v4->commit_ident_table;
 			break;
 		case OBJ_TREE:
 			add_dict_entries =3D add_tree_dict_entries;
-			dict =3D tree_path_table;
+			dict =3D v4->tree_path_table;
 			break;
 		default:
 			continue;
@@ -776,9 +779,13 @@ static unsigned int packv4_write_header(struct sha=
1file *f, unsigned nr_objects)
 	return sizeof(hdr);
 }
=20
-static unsigned long packv4_write_tables(struct sha1file *f, unsigned =
nr_objects,
-					 struct pack_idx_entry *objs)
+unsigned long packv4_write_tables(struct sha1file *f,
+				  const struct packv4_tables *v4)
 {
+	unsigned nr_objects =3D v4->all_objs_nr;
+	struct pack_idx_entry *objs =3D v4->all_objs;
+	struct dict_table *commit_ident_table =3D v4->commit_ident_table;
+	struct dict_table *tree_path_table =3D v4->tree_path_table;
 	unsigned i;
 	unsigned long written =3D 0;
=20
@@ -823,7 +830,8 @@ static int write_object_header(struct sha1file *f, =
enum object_type type, unsign
 	return len;
 }
=20
-static unsigned long copy_object_data(struct sha1file *f, struct packe=
d_git *p,
+static unsigned long copy_object_data(struct packv4_tables *v4,
+				      struct sha1file *f, struct packed_git *p,
 				      off_t offset)
 {
 	struct pack_window *w_curs =3D NULL;
@@ -850,11 +858,13 @@ static unsigned long copy_object_data(struct sha1=
file *f, struct packed_git *p,
 		if (base_offset <=3D 0 || base_offset >=3D offset)
 			die("delta offset out of bound");
 		revidx =3D find_pack_revindex(p, base_offset);
-		reflen =3D encode_sha1ref(nth_packed_object_sha1(p, revidx->nr), buf=
);
+		reflen =3D encode_sha1ref(v4,
+					nth_packed_object_sha1(p, revidx->nr),
+					buf);
 		sha1write(f, buf, reflen);
 		written +=3D reflen;
 	} else if (type =3D=3D OBJ_REF_DELTA) {
-		reflen =3D encode_sha1ref(src + hdrlen, buf);
+		reflen =3D encode_sha1ref(v4, src + hdrlen, buf);
 		hdrlen +=3D 20;
 		sha1write(f, buf, reflen);
 		written +=3D reflen;
@@ -919,7 +929,8 @@ static unsigned char *get_delta_base(struct packed_=
git *p, off_t offset,
 	return sha1_buf;
 }
=20
-static off_t packv4_write_object(struct sha1file *f, struct packed_git=
 *p,
+static off_t packv4_write_object(struct packv4_tables *v4,
+				 struct sha1file *f, struct packed_git *p,
 				 struct pack_idx_entry *obj)
 {
 	void *src, *result;
@@ -941,7 +952,7 @@ static off_t packv4_write_object(struct sha1file *f=
, struct packed_git *p,
 	case OBJ_TREE:
 		break;
 	default:
-		return copy_object_data(f, p, obj->offset);
+		return copy_object_data(v4, f, p, obj->offset);
 	}
=20
 	/* The rest is converted into their new format */
@@ -955,7 +966,7 @@ static off_t packv4_write_object(struct sha1file *f=
, struct packed_git *p,
=20
 	switch (type) {
 	case OBJ_COMMIT:
-		result =3D pv4_encode_commit(src, &buf_size);
+		result =3D pv4_encode_commit(v4, src, &buf_size);
 		break;
 	case OBJ_TREE:
 		if (packed_type !=3D OBJ_TREE) {
@@ -972,11 +983,12 @@ static off_t packv4_write_object(struct sha1file =
*f, struct packed_git *p,
 			if (!ref || ref_type !=3D OBJ_TREE)
 				die("cannot obtain delta base for %s",
 						sha1_to_hex(obj->sha1));
-			result =3D pv4_encode_tree(src, &buf_size,
+			result =3D pv4_encode_tree(v4, src, &buf_size,
 						 ref, ref_size, ref_sha1);
 			free(ref);
 		} else {
-			result =3D pv4_encode_tree(src, &buf_size, NULL, 0, NULL);
+			result =3D pv4_encode_tree(v4, src, &buf_size,
+						 NULL, 0, NULL);
 		}
 		break;
 	default:
@@ -987,7 +999,7 @@ static off_t packv4_write_object(struct sha1file *f=
, struct packed_git *p,
 		warning("can't convert %s object %s",
 			typename(type), sha1_to_hex(obj->sha1));
 		/* fall back to copy the object in its original form */
-		return copy_object_data(f, p, obj->offset);
+		return copy_object_data(v4, f, p, obj->offset);
 	}
=20
 	/* Use bit 3 to indicate a special type encoding */
@@ -1041,7 +1053,7 @@ static struct packed_git *open_pack(const char *p=
ath)
 	return p;
 }
=20
-static void process_one_pack(char *src_pack, char *dst_pack)
+static void process_one_pack(struct packv4_tables *v4, char *src_pack,=
 char *dst_pack)
 {
 	struct packed_git *p;
 	struct sha1file *f;
@@ -1061,26 +1073,26 @@ static void process_one_pack(char *src_pack, ch=
ar *dst_pack)
 	objs =3D get_packed_object_list(p);
 	p_objs =3D sort_objs_by_offset(objs, nr_objects);
=20
-	create_pack_dictionaries(p, p_objs);
-	sort_dict_entries_by_hits(commit_ident_table);
-	sort_dict_entries_by_hits(tree_path_table);
+	create_pack_dictionaries(v4, p, p_objs);
+	sort_dict_entries_by_hits(v4->commit_ident_table);
+	sort_dict_entries_by_hits(v4->tree_path_table);
=20
 	packname =3D normalize_pack_name(dst_pack);
 	f =3D packv4_open(packname);
 	if (!f)
 		die("unable to open destination pack");
 	written +=3D packv4_write_header(f, nr_objects);
-	written +=3D packv4_write_tables(f, nr_objects, objs);
+	written +=3D packv4_write_tables(f, v4);
=20
 	/* Let's write objects out, updating the object index list in place *=
/
 	progress_state =3D start_progress("Writing objects", nr_objects);
-	all_objs =3D objs;
-	all_objs_nr =3D nr_objects;
+	v4->all_objs =3D objs;
+	v4->all_objs_nr =3D nr_objects;
 	for (i =3D 0; i < nr_objects; i++) {
 		off_t obj_pos =3D written;
 		struct pack_idx_entry *obj =3D p_objs[i];
 		crc32_begin(f);
-		written +=3D packv4_write_object(f, p, obj);
+		written +=3D packv4_write_object(v4, f, p, obj);
 		obj->offset =3D obj_pos;
 		obj->crc32 =3D crc32_end(f);
 		display_progress(progress_state, i+1);
@@ -1114,6 +1126,7 @@ static int git_pack_config(const char *k, const c=
har *v, void *cb)
=20
 int main(int argc, char *argv[])
 {
+	struct packv4_tables v4;
 	char *src_pack, *dst_pack;
=20
 	if (argc =3D=3D 3) {
@@ -1131,8 +1144,8 @@ int main(int argc, char *argv[])
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level =3D core_compression_level;
-	process_one_pack(src_pack, dst_pack);
+	process_one_pack(&v4, src_pack, dst_pack);
 	if (0)
-		dict_dump();
+		dict_dump(&v4);
 	return 0;
 }
diff --git a/packv4-create.h b/packv4-create.h
new file mode 100644
index 0000000..0c8c77b
--- /dev/null
+++ b/packv4-create.h
@@ -0,0 +1,11 @@
+#ifndef PACKV4_CREATE_H
+#define PACKV4_CREATE_H
+
+struct packv4_tables {
+	struct pack_idx_entry *all_objs;
+	unsigned all_objs_nr;
+	struct dict_table *commit_ident_table;
+	struct dict_table *tree_path_table;
+};
+
+#endif
--=20
1.8.2.83.gc99314b
