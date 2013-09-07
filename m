From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/12] index-pack: move delta base queuing code to unpack_raw_entry
Date: Sat,  7 Sep 2013 17:43:16 +0700
Message-ID: <1378550599-25365-10-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:41:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFxK-000329-9q
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346Ab3IGKl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:41:26 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:49940 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3IGKl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:41:26 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so4359928pab.26
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MhxH0NDmQ3dQ7g6m1oZWftRSRYRp3LMYJx+WkhJtp68=;
        b=zqMbC98F/xdmXpYdUCgBqaUuVvPX2fr0JloihKMnhka6k1QDBo/LW6M4bLw63xsgdC
         m55jJH515XdptM7zGgL3x7ZYbmPZ2eb+MAx+IeiKnZq31ZzjmpODqKT4iSsAnkrNUwuY
         u6hnCE6qg6c5EPqJUYF9H9/augDRaMs0I38w7HaX/tbdSHD3a4/lkYyMj+6omrT6R7Es
         Ilr4XNH2m73wZ3TcmkIRXHsFJo2TFymMCwHs5cDkI0lwkAhR0ZLnFKJpSxfsRDX80Sb4
         v3DG7cl8XA1gTOu9nDsG+Df7Zt3KG3jchnni2Q2f0kct7oYkHsNSOkz7D3GEjuwHimU0
         +Yog==
X-Received: by 10.68.234.41 with SMTP id ub9mr133213pbc.201.1378550485548;
        Sat, 07 Sep 2013 03:41:25 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id s5sm3376148pbo.38.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:41:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:44:33 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234127>

=46or v2, ofs-delta and ref-delta can only have queue one delta base at
a time. A v4 tree can have more than one delta base. Move the queuing
code up to unpack_raw_entry() and give unpack_tree_v4() more
flexibility to add its bases.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 46 ++++++++++++++++++++++++++++++--------------=
--
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 51ca64b..c5a8f68 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -576,6 +576,25 @@ static void *unpack_commit_v4(unsigned int offset,
 	return dst.buf;
 }
=20
+static void add_sha1_delta(struct object_entry *obj,
+			   const unsigned char *sha1)
+{
+	struct delta_entry *delta =3D deltas + nr_deltas;
+	delta->obj_no =3D obj - objects;
+	hashcpy(delta->base.sha1, sha1);
+	nr_deltas++;
+}
+
+static void add_ofs_delta(struct object_entry *obj,
+			  off_t offset)
+{
+	struct delta_entry *delta =3D deltas + nr_deltas;
+	delta->obj_no =3D obj - objects;
+	memset(&delta->base, 0, sizeof(delta->base));
+	delta->base.offset =3D offset;
+	nr_deltas++;
+}
+
 /*
  * v4 trees are actually kind of deltas and we don't do delta in the
  * first pass. This function only walks through a tree object to find
@@ -698,17 +717,16 @@ static void read_typesize_v2(struct object_entry =
*obj)
 }
=20
 static void *unpack_raw_entry(struct object_entry *obj,
-			      union delta_base *delta_base,
 			      unsigned char *sha1)
 {
 	void *data;
-	uintmax_t val;
+	off_t offset;
=20
 	obj->idx.offset =3D consumed_bytes;
 	input_crc32 =3D crc32(0, NULL, 0);
=20
 	if (packv4) {
-		val =3D read_varint();
+		uintmax_t val =3D read_varint();
 		obj->type =3D val & 15;
 		obj->size =3D val >> 4;
 	} else
@@ -717,14 +735,14 @@ static void *unpack_raw_entry(struct object_entry=
 *obj,
=20
 	switch (obj->type) {
 	case OBJ_REF_DELTA:
-		hashcpy(delta_base->sha1, fill_and_use(20));
+		add_sha1_delta(obj, fill_and_use(20));
 		break;
 	case OBJ_OFS_DELTA:
-		memset(delta_base, 0, sizeof(*delta_base));
-		val =3D read_varint();
-		delta_base->offset =3D obj->idx.offset - val;
-		if (delta_base->offset <=3D 0 || delta_base->offset >=3D obj->idx.of=
fset)
-			bad_object(obj->idx.offset, _("delta base offset is out of bound"))=
;
+		offset =3D obj->idx.offset - read_varint();
+		if (offset <=3D 0 || offset >=3D obj->idx.offset)
+			bad_object(obj->idx.offset,
+				   _("delta base offset is out of bound"));
+		add_ofs_delta(obj, offset);
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
@@ -1266,7 +1284,6 @@ static void parse_dictionaries(void)
 static void parse_pack_objects(unsigned char *sha1)
 {
 	int i, nr_delays =3D 0;
-	struct delta_entry *delta =3D deltas;
 	struct stat st;
=20
 	if (verbose)
@@ -1275,12 +1292,9 @@ static void parse_pack_objects(unsigned char *sh=
a1)
 				nr_objects);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		void *data =3D unpack_raw_entry(obj, &delta->base, obj->idx.sha1);
-		if (is_delta_type(obj->type)) {
-			nr_deltas++;
-			delta->obj_no =3D i;
-			delta++;
-		} else if (!data && obj->type =3D=3D OBJ_PV4_TREE) {
+		void *data =3D unpack_raw_entry(obj, obj->idx.sha1);
+		if (is_delta_type(obj->type) ||
+		    (!data && obj->type =3D=3D OBJ_PV4_TREE)) {
 			/* delay sha1_object() until second pass */
 		} else if (!data) {
 			/* large blobs, check later */
--=20
1.8.2.83.gc99314b
