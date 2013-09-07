From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/12] index-pack: parse v4 commit format
Date: Sat,  7 Sep 2013 17:43:14 +0700
Message-ID: <1378550599-25365-8-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:41:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFxB-0002wa-5g
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab3IGKlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:41:16 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:50518 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3IGKlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:41:15 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so4232718pbc.3
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kQ0NB6GisIsWEdE6y7Fo6iRRqYLkV0xBHRHh4UcaMhI=;
        b=b1MWBq7lH+1d3BoKhIA6c0kdNuL4v6MtrNrAu2cibXoaFmu3eeHxnVQogLSgNTQZ7U
         47Ls9qIMxoRlf045ge3AJCybag0izdsZ+FRPd1535UNA+XWSmGSqROXPvksula4U+mN/
         PoWPP3ooUf9FfqpXOAJu+LemQMbgrv/K+gGxlJK4QkDdqvp0+RL4N2X63rB3lapIxVsF
         qHJ67aU6WdO1o7DHGUEctcJHBPlqGiQfdTwEjz3q4wTxLIz4sLHS/98E6jALzfUjg/I4
         GNB5eOLL0jJtBzQ/2nSOBFaG5pkL3DizuH76D0p1AOq5Gl+28JZdayNd0366UEua7ePR
         lvpg==
X-Received: by 10.66.154.1 with SMTP id vk1mr8905244pab.85.1378550474543;
        Sat, 07 Sep 2013 03:41:14 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id w6sm3381991pbt.32.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:41:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:44:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234125>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 95 ++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index db2370d..210b78d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -304,6 +304,30 @@ static uintmax_t read_varint(void)
 	return val;
 }
=20
+static const unsigned char *read_sha1ref(void)
+{
+	unsigned int index =3D read_varint();
+	if (!index) {
+		static unsigned char sha1[20];
+		hashcpy(sha1, fill_and_use(20));
+		return sha1;
+	}
+	index--;
+	if (index >=3D nr_objects)
+		bad_object(consumed_bytes,
+			   _("bad index in read_sha1ref"));
+	return sha1_table + index * 20;
+}
+
+static const unsigned char *read_dictref(struct packv4_dict *dict)
+{
+	unsigned int index =3D read_varint();
+	if (index >=3D dict->nb_entries)
+		bad_object(consumed_bytes,
+			   _("bad index in read_dictref"));
+	return  dict->data + dict->offsets[index];
+}
+
 static void *read_data(int size)
 {
 	const int max =3D sizeof(input_buffer);
@@ -484,6 +508,59 @@ static void read_and_inflate(unsigned long offset,
 		git_SHA1_Final(sha1, ctx);
 }
=20
+static void *unpack_commit_v4(unsigned int offset,
+			      unsigned long size,
+			      unsigned char *sha1)
+{
+	unsigned int nb_parents;
+	const unsigned char *committer, *author, *ident;
+	unsigned long author_time, committer_time;
+	git_SHA_CTX ctx;
+	char hdr[32];
+	int hdrlen;
+	int16_t committer_tz, author_tz;
+	struct strbuf dst;
+
+	strbuf_init(&dst, size);
+
+	strbuf_addf(&dst, "tree %s\n", sha1_to_hex(read_sha1ref()));
+	nb_parents =3D read_varint();
+	while (nb_parents--)
+		strbuf_addf(&dst, "parent %s\n", sha1_to_hex(read_sha1ref()));
+
+	committer_time =3D read_varint();
+	ident =3D read_dictref(name_dict);
+	committer_tz =3D (ident[0] << 8) | ident[1];
+	committer =3D ident + 2;
+
+	author_time =3D read_varint();
+	ident =3D read_dictref(name_dict);
+	author_tz =3D (ident[0] << 8) | ident[1];
+	author =3D ident + 2;
+
+	if (author_time & 1)
+		author_time =3D committer_time + (author_time >> 1);
+	else
+		author_time =3D committer_time - (author_time >> 1);
+
+	strbuf_addf(&dst,
+		    "author %s %lu %+05d\n"
+		    "committer %s %lu %+05d\n",
+		    author, author_time, author_tz,
+		    committer, committer_time, committer_tz);
+
+	if (dst.len > size)
+		bad_object(offset, _("bad commit"));
+
+	hdrlen =3D sprintf(hdr, "commit %lu", size) + 1;
+	git_SHA1_Init(&ctx);
+	git_SHA1_Update(&ctx, hdr, hdrlen);
+	git_SHA1_Update(&ctx, dst.buf, dst.len);
+	read_and_inflate(offset, dst.buf + dst.len, size - dst.len,
+			 0, &ctx, sha1);
+	return dst.buf;
+}
+
 static void *unpack_entry_data(unsigned long offset, unsigned long siz=
e,
 			       enum object_type type, unsigned char *sha1)
 {
@@ -493,6 +570,9 @@ static void *unpack_entry_data(unsigned long offset=
, unsigned long size,
 	char hdr[32];
 	int hdrlen;
=20
+	if (type =3D=3D OBJ_PV4_COMMIT)
+		return unpack_commit_v4(offset, size, sha1);
+
 	if (!is_delta_type(type)) {
 		hdrlen =3D sprintf(hdr, "%s %lu", typename(type), size) + 1;
 		git_SHA1_Init(&c);
@@ -536,7 +616,13 @@ static void *unpack_raw_entry(struct object_entry =
*obj,
 	obj->idx.offset =3D consumed_bytes;
 	input_crc32 =3D crc32(0, NULL, 0);
=20
-	read_typesize_v2(obj);
+	if (packv4) {
+		val =3D read_varint();
+		obj->type =3D val & 15;
+		obj->size =3D val >> 4;
+	} else
+		read_typesize_v2(obj);
+	obj->real_type =3D obj->type;
=20
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
@@ -554,6 +640,10 @@ static void *unpack_raw_entry(struct object_entry =
*obj,
 	case OBJ_BLOB:
 	case OBJ_TAG:
 		break;
+
+	case OBJ_PV4_COMMIT:
+		obj->real_type =3D OBJ_COMMIT;
+		break;
 	default:
 		bad_object(obj->idx.offset, _("unknown object type %d"), obj->type);
 	}
@@ -1092,7 +1182,6 @@ static void parse_pack_objects(unsigned char *sha=
1)
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
 		void *data =3D unpack_raw_entry(obj, &delta->base, obj->idx.sha1);
-		obj->real_type =3D obj->type;
 		if (is_delta_type(obj->type)) {
 			nr_deltas++;
 			delta->obj_no =3D i;
@@ -1104,7 +1193,7 @@ static void parse_pack_objects(unsigned char *sha=
1)
 			check_against_sha1table(obj);
 		} else {
 			check_against_sha1table(obj);
-			sha1_object(data, NULL, obj->size, obj->type,
+			sha1_object(data, NULL, obj->size, obj->real_type,
 				    obj->idx.sha1);
 		}
 		free(data);
--=20
1.8.2.83.gc99314b
