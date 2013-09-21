From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/17] index-pack: encode appended trees using v4 format in pack v4
Date: Sat, 21 Sep 2013 20:57:59 +0700
Message-ID: <1379771883-10278-14-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:56:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNfF-0001fa-LT
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab3IUNz6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:58 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:43360 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3IUNz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:57 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so1829027pad.0
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rIkB49GqLc130GYAdUbKzL5TSlJkrCh2oGlT89C9zLM=;
        b=N3YfUCKNw2eyqp22eRm5APTJjrg2YDo5JUXdLkxwIGHzoCxh1g9KUaD3MZBwN3eVNp
         C4BtxynEfBWmxnkx/qlqKiWvZRyQ5Hlvqe763Jh6Nd/OKBgAfzrI5FR61UnDNHKr3Cnr
         J9qaKy5wxIB0LAava2yDJupeuY/aVFiR9JrbOWZnHLWhcRif3Ge3hFW+3KCgQ5VYpsMG
         M+u6eNJwpiGobmiaBesz0A7bYde6QBAYvXwPACwJPtLizX7xaHGXEZtQD/Fv1+XcE3Jy
         rSwOyv4QD1Giax384284yRVBNBWQyVRjj5yidsxmMZz85VKaGhxI3zm8n1TVcoAHsN0k
         54RQ==
X-Received: by 10.68.129.99 with SMTP id nv3mr13872002pbb.40.1379771756655;
        Sat, 21 Sep 2013 06:55:56 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id xe9sm25730003pab.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:55:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:59:19 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235114>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 packv4-create.c      | 20 ++++++++++++++++++++
 packv4-create.h      |  2 ++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index db885b1..caec388 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -12,6 +12,7 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "packv4-parse.h"
+#include "packv4-create.h"
 #include "varint.h"
 #include "tree-walk.h"
=20
@@ -76,6 +77,7 @@ static struct delta_entry *deltas;
 static struct thread_local nothread_data;
 static unsigned char *sha1_table;
 static struct packv4_dict *name_dict, *path_dict;
+static struct packv4_tables pv4_tables;
 static int nr_objects;
 static int nr_deltas;
 static int nr_resolved_deltas;
@@ -1717,18 +1719,48 @@ static int write_compressed(struct sha1file *f,=
 void *in, unsigned int size)
 	return size;
 }
=20
+static void initialize_packv4_tables(void)
+{
+	static int initialized;
+	int i, nr =3D nr_objects_final;
+	if (initialized)
+		return;
+	pv4_tables.commit_ident_table =3D pv4_dict_to_dict_table(name_dict);
+	pv4_tables.tree_path_table =3D pv4_dict_to_dict_table(path_dict);
+	pv4_tables.all_objs_nr =3D nr;
+	pv4_tables.all_objs =3D xmalloc(nr * sizeof(struct pack_idx_entry));
+	/* for pv4_encode_tree() pv4_tables[].offset is not needed */
+	for (i =3D 0; i < nr; i++)
+		hashcpy(pv4_tables.all_objs[i].sha1, sha1_table + i * 20);
+	initialized =3D 1;
+}
+
 static struct object_entry *append_obj_to_pack(struct sha1file *f,
 			       const unsigned char *sha1, void *buf,
 			       unsigned long size, enum object_type type)
 {
 	struct object_entry *obj =3D &objects[nr_objects++];
+	void *v4_data =3D NULL;
 	unsigned char header[10];
+	unsigned long v4_size;
+	enum object_type real_type =3D type;
 	int n;
=20
 	if (packv4) {
 		if (nr_objects > nr_objects_final)
 			die(_("too many objects"));
-		/* TODO: convert OBJ_TREE to OBJ_PV4_TREE using pv4_encode_tree */
+
+		if (type =3D=3D OBJ_TREE) {
+			initialize_packv4_tables();
+			v4_size =3D size;
+			v4_data =3D pv4_encode_tree(&pv4_tables, buf, &v4_size,
+						  NULL, 0, NULL);
+			if (v4_data)
+				type =3D OBJ_PV4_TREE;
+		}
+
+		/* TODO: convert OBJ_COMMIT to OBJ_PV4_COMMIT using pv4_encode_commi=
t */
+
 		n =3D pv4_encode_object_header(type, size, header);
 	} else
 		n =3D encode_in_pack_object_header(type, size, header);
@@ -1737,12 +1769,17 @@ static struct object_entry *append_obj_to_pack(=
struct sha1file *f,
 	obj[0].size =3D size;
 	obj[0].hdr_size =3D n;
 	obj[0].type =3D type;
-	obj[0].real_type =3D type;
+	obj[0].real_type =3D real_type;
 	obj[1].idx.offset =3D obj[0].idx.offset + n;
-	obj[1].idx.offset +=3D write_compressed(f, buf, size);
+	if (type !=3D real_type) { /* must be v4 representation */
+		sha1write(f, v4_data, v4_size);
+		obj[1].idx.offset +=3D v4_size;
+	} else
+		obj[1].idx.offset +=3D write_compressed(f, buf, size);
 	obj[0].idx.crc32 =3D crc32_end(f);
 	sha1flush(f);
 	hashcpy(obj->idx.sha1, sha1);
+	free(v4_data);
 	return obj;
 }
=20
diff --git a/packv4-create.c b/packv4-create.c
index 3acd10f..14be867 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -15,6 +15,7 @@
 #include "pack-revindex.h"
 #include "progress.h"
 #include "varint.h"
+#include "packv4-parse.h"
 #include "packv4-create.h"
=20
=20
@@ -144,6 +145,25 @@ void sort_dict_entries_by_hits(struct dict_table *=
t)
 	rehash_entries(t);
 }
=20
+struct dict_table *pv4_dict_to_dict_table(struct packv4_dict *pv4dict)
+{
+	struct dict_table *dict;
+	int i;
+
+	dict =3D create_dict_table();
+	for (i =3D 0; i < pv4dict->nb_entries; i++) {
+		const unsigned char *mode_bytes;
+		const char *str;
+		int mode, str_len;
+		mode_bytes =3D pv4dict->data + pv4dict->offsets[i];
+		mode =3D (mode_bytes[0] << 8) | mode_bytes[1];
+		str =3D (const char *)mode_bytes + 2;
+		str_len =3D pv4dict->offsets[i+1] - pv4dict->offsets[i] - 2;
+		str_len--;  /* for NUL, dict_add_entry will add one back */
+		dict_add_entry(dict, mode, str, str_len);
+	}
+	return dict;
+}
 /*
  * Parse the author/committer line from a canonical commit object.
  * The 'from' argument points right after the "author " or "committer =
"
diff --git a/packv4-create.h b/packv4-create.h
index 4ac4d71..e0d4b1f 100644
--- a/packv4-create.h
+++ b/packv4-create.h
@@ -8,11 +8,13 @@ struct packv4_tables {
 	struct dict_table *tree_path_table;
 };
=20
+struct packv4_dict;
 struct dict_table;
 struct sha1file;
=20
 struct dict_table *create_dict_table(void);
 int dict_add_entry(struct dict_table *t, int val, const char *str, int=
 str_len);
+struct dict_table *pv4_dict_to_dict_table(struct packv4_dict *dict);
 void destroy_dict_table(struct dict_table *t);
 void dict_dump(struct packv4_tables *v4);
=20
--=20
1.8.2.83.gc99314b
