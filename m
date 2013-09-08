From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/11] pack-objects: support writing pack v4
Date: Sun,  8 Sep 2013 22:04:20 +0700
Message-ID: <1378652660-6731-12-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:02:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgVU-0003vm-Bv
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab3IHPC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:02:28 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:48804 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3IHPC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:02:27 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so5174559pdj.35
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Qt7t/wVkCdHQDMgLkN9UmoNHfnBQeCio6x3Fk8GQUI4=;
        b=OZAVKlP4wJUDNE9N0qbRcZenTzDz8gpVBj72ppxISnMu9Z7Z9bsKlhdX717wVJpWxG
         YQQgjd3u3sK6cF792AK+tYZP6dIYxlqaPIJFZDzLVRlqhXNYm3OkZdU04iUjwySW7APe
         RNQ8l6ofUhatGGNhTjS3JMZceaFtlXWCdFnYTKPiDPtDic1bxlXmGqafl9r4g7+EGMvC
         uPqNSxYNtwChPNLuGMGTFa1gwbyWnUAHqIo0zbIynxOR1gJCQ/cTTadHkJ6C6k2pbU7Y
         VrvZTDkVjaxqOjRfof51ZY3H61beDV5BrPYlWNGiK4uIIrhlK1iBHPI2ogP6Bn9Vp9xH
         7WcA==
X-Received: by 10.66.182.229 with SMTP id eh5mr2225869pac.139.1378652547002;
        Sun, 08 Sep 2013 08:02:27 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id xn12sm11456067pac.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:02:26 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:05:35 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234250>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 85 ++++++++++++++++++++++++++++++++++++++++++=
++------
 pack.h                 |  2 +-
 2 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index daa4349..f6586a1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -254,8 +254,10 @@ static unsigned long write_no_reuse_object(struct =
sha1file *f, struct object_ent
 	enum object_type type;
 	void *buf;
 	struct git_istream *st =3D NULL;
+	char *result =3D "OK";
=20
-	if (!usable_delta) {
+	if (!usable_delta ||
+	    (pack_version =3D=3D 4 || entry->type =3D=3D OBJ_TREE)) {
 		if (entry->type =3D=3D OBJ_BLOB &&
 		    entry->size > big_file_threshold &&
 		    (st =3D open_istream(entry->idx.sha1, &type, &size, NULL)) !=3D =
NULL)
@@ -287,7 +289,37 @@ static unsigned long write_no_reuse_object(struct =
sha1file *f, struct object_ent
=20
 	if (st)	/* large blob case, just assume we don't compress well */
 		datalen =3D size;
-	else if (entry->z_delta_size)
+	else if (pack_version =3D=3D 4 && entry->type =3D=3D OBJ_COMMIT) {
+		datalen =3D size;
+		result =3D pv4_encode_commit(&v4, buf, &datalen);
+		if (result) {
+			free(buf);
+			buf =3D result;
+			type =3D OBJ_PV4_COMMIT;
+		}
+	} else if (pack_version =3D=3D 4 && entry->type =3D=3D OBJ_TREE) {
+		datalen =3D size;
+		if (usable_delta) {
+			unsigned long base_size;
+			char *base_buf;
+			base_buf =3D read_sha1_file(entry->delta->idx.sha1, &type,
+						  &base_size);
+			if (!base_buf || type !=3D OBJ_TREE)
+				die("unable to read %s",
+				    sha1_to_hex(entry->delta->idx.sha1));
+			result =3D pv4_encode_tree(&v4, buf, &datalen,
+						 base_buf, base_size,
+						 entry->delta->idx.sha1);
+			free(base_buf);
+		} else
+			result =3D pv4_encode_tree(&v4, buf, &datalen,
+						 NULL, 0, NULL);
+		if (result) {
+			free(buf);
+			buf =3D result;
+			type =3D OBJ_PV4_TREE;
+		}
+	} else if (entry->z_delta_size)
 		datalen =3D entry->z_delta_size;
 	else
 		datalen =3D do_compress(&buf, size);
@@ -296,7 +328,10 @@ static unsigned long write_no_reuse_object(struct =
sha1file *f, struct object_ent
 	 * The object header is a byte of 'type' followed by zero or
 	 * more bytes of length.
 	 */
-	hdrlen =3D encode_in_pack_object_header(type, size, header);
+	if (pack_version < 4)
+		hdrlen =3D encode_in_pack_object_header(type, size, header);
+	else
+		hdrlen =3D pv4_encode_in_pack_object_header(type, size, header);
=20
 	if (type =3D=3D OBJ_OFS_DELTA) {
 		/*
@@ -318,7 +353,7 @@ static unsigned long write_no_reuse_object(struct s=
ha1file *f, struct object_ent
 		sha1write(f, header, hdrlen);
 		sha1write(f, dheader + pos, sizeof(dheader) - pos);
 		hdrlen +=3D sizeof(dheader) - pos;
-	} else if (type =3D=3D OBJ_REF_DELTA) {
+	} else if (type =3D=3D OBJ_REF_DELTA && pack_version < 4) {
 		/*
 		 * Deltas with a base reference contain
 		 * an additional 20 bytes for the base sha1.
@@ -332,6 +367,10 @@ static unsigned long write_no_reuse_object(struct =
sha1file *f, struct object_ent
 		sha1write(f, header, hdrlen);
 		sha1write(f, entry->delta->idx.sha1, 20);
 		hdrlen +=3D 20;
+	} else if (type =3D=3D OBJ_REF_DELTA && pack_version =3D=3D 4) {
+		hdrlen +=3D encode_sha1ref(&v4, entry->delta->idx.sha1,
+					header + hdrlen);
+		sha1write(f, header, hdrlen);
 	} else {
 		if (limit && hdrlen + datalen + 20 >=3D limit) {
 			if (st)
@@ -341,14 +380,26 @@ static unsigned long write_no_reuse_object(struct=
 sha1file *f, struct object_ent
 		}
 		sha1write(f, header, hdrlen);
 	}
+
 	if (st) {
 		datalen =3D write_large_blob_data(st, f, entry->idx.sha1);
 		close_istream(st);
-	} else {
-		sha1write(f, buf, datalen);
-		free(buf);
+		return hdrlen + datalen;
 	}
=20
+	if (!result) {
+		warning(_("can't convert %s object %s"),
+			typename(entry->type),
+			sha1_to_hex(entry->idx.sha1));
+		free(buf);
+		buf =3D read_sha1_file(entry->idx.sha1, &type, &size);
+		if (!buf)
+			die(_("unable to read %s"),
+			    sha1_to_hex(entry->idx.sha1));
+		datalen =3D do_compress(&buf, size);
+	}
+	sha1write(f, buf, datalen);
+	free(buf);
 	return hdrlen + datalen;
 }
=20
@@ -368,7 +419,10 @@ static unsigned long write_reuse_object(struct sha=
1file *f, struct object_entry
 	if (entry->delta)
 		type =3D (allow_ofs_delta && entry->delta->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
-	hdrlen =3D encode_in_pack_object_header(type, entry->size, header);
+	if (pack_version < 4)
+		hdrlen =3D encode_in_pack_object_header(type, entry->size, header);
+	else
+		hdrlen =3D pv4_encode_in_pack_object_header(type, entry->size, heade=
r);
=20
 	offset =3D entry->in_pack_offset;
 	revidx =3D find_pack_revindex(p, offset);
@@ -404,7 +458,7 @@ static unsigned long write_reuse_object(struct sha1=
file *f, struct object_entry
 		sha1write(f, dheader + pos, sizeof(dheader) - pos);
 		hdrlen +=3D sizeof(dheader) - pos;
 		reused_delta++;
-	} else if (type =3D=3D OBJ_REF_DELTA) {
+	} else if (type =3D=3D OBJ_REF_DELTA && pack_version < 4) {
 		if (limit && hdrlen + 20 + datalen + 20 >=3D limit) {
 			unuse_pack(&w_curs);
 			return 0;
@@ -413,6 +467,11 @@ static unsigned long write_reuse_object(struct sha=
1file *f, struct object_entry
 		sha1write(f, entry->delta->idx.sha1, 20);
 		hdrlen +=3D 20;
 		reused_delta++;
+	} else if (type =3D=3D OBJ_REF_DELTA && pack_version =3D=3D 4) {
+		hdrlen +=3D encode_sha1ref(&v4, entry->delta->idx.sha1,
+					header + hdrlen);
+		sha1write(f, header, hdrlen);
+		reused_delta++;
 	} else {
 		if (limit && hdrlen + datalen + 20 >=3D limit) {
 			unuse_pack(&w_curs);
@@ -477,7 +536,9 @@ static unsigned long write_object(struct sha1file *=
f,
 				 * and we do not need to deltify it.
 				 */
=20
-	if (!to_reuse)
+	if (!to_reuse ||
+	    (pack_version =3D=3D 4 &&
+	     (entry->type =3D=3D OBJ_TREE || entry->type =3D=3D OBJ_COMMIT)))
 		len =3D write_no_reuse_object(f, entry, limit, usable_delta);
 	else
 		len =3D write_reuse_object(f, entry, limit, usable_delta);
@@ -742,6 +803,8 @@ static void write_pack_file(void)
 		offset =3D write_pack_header(f, pack_version, nr_remaining);
 		if (!offset)
 			die_errno("unable to write pack header");
+		if (pack_version =3D=3D 4)
+			offset +=3D packv4_write_tables(f, &v4);
 		nr_written =3D 0;
 		for (; i < nr_objects; i++) {
 			struct object_entry *e =3D write_order[i];
@@ -2083,6 +2146,8 @@ static void prepare_pack(int window, int depth)
 		sort_dict_entries_by_hits(v4.commit_ident_table);
 		sort_dict_entries_by_hits(v4.tree_path_table);
 		prepare_sha1_table();
+		pack_idx_opts.version =3D 3;
+		allow_ofs_delta =3D 0;
 	}
=20
 	get_object_details();
diff --git a/pack.h b/pack.h
index 38f869d..fde60ec 100644
--- a/pack.h
+++ b/pack.h
@@ -8,7 +8,7 @@
  * Packed object header
  */
 #define PACK_SIGNATURE 0x5041434b	/* "PACK" */
-#define pack_version_ok(v) ((v) =3D=3D htonl(2) || (v) =3D=3D htonl(3)=
)
+#define pack_version_ok(v) ((v) =3D=3D htonl(2) || (v) =3D=3D htonl(3)=
 || (v) =3D=3D htonl(4))
 struct pack_header {
 	uint32_t hdr_signature;
 	uint32_t hdr_version;
--=20
1.8.2.83.gc99314b
