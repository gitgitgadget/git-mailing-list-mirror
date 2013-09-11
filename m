From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/21] pack-objects: respect compression level in v4
Date: Wed, 11 Sep 2013 13:06:09 +0700
Message-ID: <1378879582-15372-9-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:07:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdak-0005kH-SL
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166Ab3IKGHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:07:50 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:53128 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab3IKGHu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:07:50 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so8709144pdj.30
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PUkHsBvbvYr4+JKjXqBszNpaAGqhIeEAfxPtnLWxZX8=;
        b=uJxbh2VigvS2c4FBpGyUjwwgtxC9gF8xTnI4O0wN35Duo2GJ5C2GJ1DwqtEWZAXmYw
         IZm99+ZcwJFLXB6AV49LIU59BixfESYdpmferLz6tnNoszj7NWlRb4SiVx4nKE5KP4PM
         2EL/M/V7qle+DVKRA8S/1Z+QAbr1l89XJ+U0EdMo9MBhxc/bKcmThxUN3FaOvMiieVQh
         qKWmjkLqvSFD6wNys8qy6TQbD1L+u2/lGM/utwxuABYn6WNSj5uC1K49ZJ2xDBk2W0vY
         g4JEE94l8UvbQl/yR311hVJsrXeNlrsu1S/QfYanmd7kaogemIxzmUEIFc+rEUy0G65l
         7s9g==
X-Received: by 10.66.27.175 with SMTP id u15mr1740114pag.146.1378879669559;
        Tue, 10 Sep 2013 23:07:49 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id xn12sm1094901pac.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:07:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:07:42 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234532>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c |  5 +++--
 packv4-create.c        | 17 ++++++++++-------
 packv4-create.h        |  6 ++++--
 test-packv4.c          |  9 +++++----
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 39d1e08..63c9b9e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -295,7 +295,8 @@ static unsigned long write_no_reuse_object(struct s=
ha1file *f, struct object_ent
 		datalen =3D size;
 	else if (pack_version =3D=3D 4 && entry->type =3D=3D OBJ_COMMIT) {
 		datalen =3D size;
-		result =3D pv4_encode_commit(&v4, buf, &datalen);
+		result =3D pv4_encode_commit(&v4, buf, &datalen,
+					   pack_compression_level);
 		if (result) {
 			free(buf);
 			buf =3D result;
@@ -857,7 +858,7 @@ static void write_pack_file(void)
 		if (!offset)
 			die_errno("unable to write pack header");
 		if (pack_version =3D=3D 4)
-			offset +=3D packv4_write_tables(f, &v4);
+			offset +=3D packv4_write_tables(f, &v4, pack_compression_level);
 		nr_written =3D 0;
 		for (; i < nr_objects; i++) {
 			struct object_entry *e =3D write_order[i];
diff --git a/packv4-create.c b/packv4-create.c
index 83a6336..3acd10f 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -18,8 +18,6 @@
 #include "packv4-create.h"
=20
=20
-int pack_compression_seen;
-int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
 int min_tree_copy =3D 1;
=20
 struct data_entry {
@@ -285,7 +283,8 @@ int encode_sha1ref(const struct packv4_tables *v4,
  * regenerated and produce the same hash.
  */
 void *pv4_encode_commit(const struct packv4_tables *v4,
-			void *buffer, unsigned long *sizep)
+			void *buffer, unsigned long *sizep,
+			int pack_compression_level)
 {
 	unsigned long size =3D *sizep;
 	char *in, *tail, *end;
@@ -611,7 +610,8 @@ void *pv4_encode_tree(const struct packv4_tables *v=
4,
 	return buffer;
 }
=20
-static unsigned long write_dict_table(struct sha1file *f, struct dict_=
table *t)
+static unsigned long write_dict_table(struct sha1file *f, struct dict_=
table *t,
+				      int pack_compression_level)
 {
 	unsigned char buffer[1024];
 	unsigned hdrlen;
@@ -661,7 +661,8 @@ static unsigned long write_dict_table(struct sha1fi=
le *f, struct dict_table *t)
 }
=20
 unsigned long packv4_write_tables(struct sha1file *f,
-				  const struct packv4_tables *v4)
+				  const struct packv4_tables *v4,
+				  int pack_compression_level)
 {
 	unsigned nr_objects =3D v4->all_objs_nr;
 	struct pack_idx_entry *objs =3D v4->all_objs;
@@ -676,10 +677,12 @@ unsigned long packv4_write_tables(struct sha1file=
 *f,
 	written =3D 20 * nr_objects;
=20
 	/* Then the commit dictionary table */
-	written +=3D write_dict_table(f, commit_ident_table);
+	written +=3D write_dict_table(f, commit_ident_table,
+				    pack_compression_level);
=20
 	/* Followed by the path component dictionary table */
-	written +=3D write_dict_table(f, tree_path_table);
+	written +=3D write_dict_table(f, tree_path_table,
+				    pack_compression_level);
=20
 	return written;
 }
diff --git a/packv4-create.h b/packv4-create.h
index ba4929a..4ac4d71 100644
--- a/packv4-create.h
+++ b/packv4-create.h
@@ -25,9 +25,11 @@ void sort_dict_entries_by_hits(struct dict_table *t)=
;
 int encode_sha1ref(const struct packv4_tables *v4,
 		   const unsigned char *sha1, unsigned char *buf);
 unsigned long packv4_write_tables(struct sha1file *f,
-				  const struct packv4_tables *v4);
+				  const struct packv4_tables *v4,
+				  int pack_compression_level);
 void *pv4_encode_commit(const struct packv4_tables *v4,
-			void *buffer, unsigned long *sizep);
+			void *buffer, unsigned long *sizep,
+			int pack_compression_level);
 void *pv4_encode_tree(const struct packv4_tables *v4,
 		      void *_buffer, unsigned long *sizep,
 		      void *delta, unsigned long delta_size,
diff --git a/test-packv4.c b/test-packv4.c
index 3b0d7a2..b50422a 100644
--- a/test-packv4.c
+++ b/test-packv4.c
@@ -5,8 +5,8 @@
 #include "varint.h"
 #include "packv4-create.h"
=20
-extern int pack_compression_seen;
-extern int pack_compression_level;
+static int pack_compression_seen;
+static int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
 extern int min_tree_copy;
=20
 static struct pack_idx_entry *get_packed_object_list(struct packed_git=
 *p)
@@ -291,7 +291,8 @@ static off_t packv4_write_object(struct packv4_tabl=
es *v4,
=20
 	switch (type) {
 	case OBJ_COMMIT:
-		result =3D pv4_encode_commit(v4, src, &buf_size);
+		result =3D pv4_encode_commit(v4, src, &buf_size,
+					   pack_compression_level);
 		break;
 	case OBJ_TREE:
 		if (packed_type !=3D OBJ_TREE) {
@@ -407,7 +408,7 @@ void process_one_pack(struct packv4_tables *v4, cha=
r *src_pack, char *dst_pack)
 	if (!f)
 		die("unable to open destination pack");
 	written +=3D packv4_write_header(f, nr_objects);
-	written +=3D packv4_write_tables(f, v4);
+	written +=3D packv4_write_tables(f, v4, pack_compression_level);
=20
 	/* Let's write objects out, updating the object index list in place *=
/
 	progress_state =3D start_progress("Writing objects", nr_objects);
--=20
1.8.2.82.gc24b958
