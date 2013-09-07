From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/12] index-pack: record all delta bases in v4 (tree and ref-delta)
Date: Sat,  7 Sep 2013 17:43:17 +0700
Message-ID: <1378550599-25365-11-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:41:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFxQ-00036y-5P
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349Ab3IGKlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:41:32 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:49030 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3IGKlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:41:31 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so4300268pdi.14
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=U2ukqEWwfsE6G6trDGEhIHV6M6Tv7KEbiPzuxEoL9C0=;
        b=NPIxJxJOCdYV/R3R8eax4uQ9yI2CIbEpu9woJohO7mIRiR0OMoVxO2QBflEgw2uc8c
         G9DrlyGrnnBq8bp0H024dHzbAPC89ybd/AO3lxfFU5YGDxzhIz7rPt1PDID0AbH4Js7o
         OzpE3OtbvrJ/1C3+87SujeQzNJANUDYIWdVpowrZRdcf89akH+gBGNoT+fxWd5L3U8Q2
         Nz5VV0XKy3w2KqPXGa10qPz3LIpAE6qwwKe2keKWwuCBxu+dMhvMefF3dbF/LIP0zmat
         uRiGOjQlipSfd6N6eTH9MKm46p4RMC8wATHipcyGDOuR8t7aiHee7F24WcMSAK8zKLkY
         N5EA==
X-Received: by 10.66.26.132 with SMTP id l4mr8964401pag.138.1378550491235;
        Sat, 07 Sep 2013 03:41:31 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id lm2sm3966916pab.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:41:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:44:39 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234128>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c5a8f68..33722e1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,6 +24,7 @@ struct object_entry {
 	enum object_type real_type;
 	unsigned delta_depth;
 	int base_object_no;
+	int nr_bases;		/* only valid for v4 trees */
 };
=20
 union delta_base {
@@ -489,6 +490,11 @@ static int is_delta_type(enum object_type type)
 	return (type =3D=3D OBJ_REF_DELTA || type =3D=3D OBJ_OFS_DELTA);
 }
=20
+static int is_delta_tree(const struct object_entry *obj)
+{
+	return obj->type =3D=3D OBJ_PV4_TREE && obj->nr_bases > 0;
+}
+
 static void read_and_inflate(unsigned long offset,
 			     void *buf, unsigned long size,
 			     unsigned long wraparound,
@@ -595,6 +601,20 @@ static void add_ofs_delta(struct object_entry *obj=
,
 	nr_deltas++;
 }
=20
+static void add_tree_delta_base(struct object_entry *obj,
+				const unsigned char *base,
+				int delta_start)
+{
+	int i;
+
+	for (i =3D delta_start; i < nr_deltas; i++)
+		if (!hashcmp(base, deltas[i].base.sha1))
+			return;
+
+	add_sha1_delta(obj, base);
+	obj->nr_bases++;
+}
+
 /*
  * v4 trees are actually kind of deltas and we don't do delta in the
  * first pass. This function only walks through a tree object to find
@@ -608,12 +628,14 @@ static void *unpack_tree_v4(struct object_entry *=
obj,
 	unsigned int nr =3D read_varint();
 	const unsigned char *last_base =3D NULL;
 	struct strbuf sb =3D STRBUF_INIT;
+	int delta_start =3D nr_deltas;
 	while (nr) {
 		unsigned int copy_start_or_path =3D read_varint();
 		if (copy_start_or_path & 1) { /* copy_start */
 			unsigned int copy_count =3D read_varint();
 			if (copy_count & 1) { /* first delta */
 				last_base =3D read_sha1table_ref();
+				add_tree_delta_base(obj, last_base, delta_start);
 			} else if (!last_base)
 				bad_object(offset,
 					   _("bad copy count index in unpack_tree_v4"));
@@ -735,9 +757,15 @@ static void *unpack_raw_entry(struct object_entry =
*obj,
=20
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		add_sha1_delta(obj, fill_and_use(20));
+		if (packv4)
+			add_sha1_delta(obj, read_sha1table_ref());
+		else
+			add_sha1_delta(obj, fill_and_use(20));
 		break;
 	case OBJ_OFS_DELTA:
+		if (packv4)
+			die(_("pack version 4 does not support ofs-delta type (offset %lu)"=
),
+			    obj->idx.offset);
 		offset =3D obj->idx.offset - read_varint();
 		if (offset <=3D 0 || offset >=3D obj->idx.offset)
 			bad_object(obj->idx.offset,
@@ -1293,8 +1321,7 @@ static void parse_pack_objects(unsigned char *sha=
1)
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
 		void *data =3D unpack_raw_entry(obj, obj->idx.sha1);
-		if (is_delta_type(obj->type) ||
-		    (!data && obj->type =3D=3D OBJ_PV4_TREE)) {
+		if (is_delta_type(obj->type) || is_delta_tree(obj)) {
 			/* delay sha1_object() until second pass */
 		} else if (!data) {
 			/* large blobs, check later */
--=20
1.8.2.83.gc99314b
