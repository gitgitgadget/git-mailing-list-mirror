From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] index-pack: eliminate recursion in find_unresolved_deltas
Date: Mon, 26 Dec 2011 19:04:39 +0700
Message-ID: <1324901080-23215-2-git-send-email-pclouds@gmail.com>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 26 13:01:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rf9Fd-0003AG-9s
	for gcvg-git-2@lo.gmane.org; Mon, 26 Dec 2011 13:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab1LZMBz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Dec 2011 07:01:55 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50135 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab1LZMBp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2011 07:01:45 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so18804004iae.19
        for <git@vger.kernel.org>; Mon, 26 Dec 2011 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kjeTadG1k5ulwxU+YftTl6IzdfpIWortH5MbJmqt9tQ=;
        b=ZfyTiK+ji9eHTr7cTJ5tcCd8MQ9xcX58C8ld+LwXoygqdNCKeMP9j+F+zCSibjMFUj
         M14gu1xdMxGGShJVqwxVOdzclX/oYyibYZrFWAVAaJ0IVEjFi5UYamcKf3+ScvsWEO1k
         wsLxWiQH9+ukvKzYm3h1VOK9kY6goDN57xU2c=
Received: by 10.50.183.199 with SMTP id eo7mr26205249igc.5.1324900905020;
        Mon, 26 Dec 2011 04:01:45 -0800 (PST)
Received: from tre ([115.74.49.128])
        by mx.google.com with ESMTPS id vr1sm4250358igb.7.2011.12.26.04.01.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Dec 2011 04:01:44 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 26 Dec 2011 19:04:49 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187696>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |  112 +++++++++++++++++++++++++++++++-----------=
-------
 1 files changed, 71 insertions(+), 41 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 98025da..d311c05 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -34,6 +34,8 @@ struct base_data {
 	struct object_entry *obj;
 	void *data;
 	unsigned long size;
+	int ref_first, ref_last;
+	int ofs_first, ofs_last;
 };
=20
 /*
@@ -221,6 +223,15 @@ static NORETURN void bad_object(unsigned long offs=
et, const char *format, ...)
 	die("pack has bad object at offset %lu: %s", offset, buf);
 }
=20
+static struct base_data *alloc_base_data()
+{
+	struct base_data *base =3D xmalloc(sizeof(struct base_data));
+	memset(base, 0, sizeof(*base));
+	base->ref_last =3D -1;
+	base->ofs_last =3D -1;
+	return base;
+}
+
 static void free_base_data(struct base_data *c)
 {
 	if (c->data) {
@@ -553,58 +564,77 @@ static void resolve_delta(struct object_entry *de=
lta_obj,
 	nr_resolved_deltas++;
 }
=20
-static void find_unresolved_deltas(struct base_data *base,
-				   struct base_data *prev_base)
+static struct base_data *find_unresolved_deltas_1(struct base_data *ba=
se,
+						  struct base_data *prev_base)
 {
-	int i, ref_first, ref_last, ofs_first, ofs_last;
-
-	/*
-	 * This is a recursive function. Those brackets should help reducing
-	 * stack usage by limiting the scope of the delta_base union.
-	 */
-	{
+	if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D -1) {
 		union delta_base base_spec;
=20
 		hashcpy(base_spec.sha1, base->obj->idx.sha1);
 		find_delta_children(&base_spec,
-				    &ref_first, &ref_last, OBJ_REF_DELTA);
+				    &base->ref_first, &base->ref_last, OBJ_REF_DELTA);
=20
 		memset(&base_spec, 0, sizeof(base_spec));
 		base_spec.offset =3D base->obj->idx.offset;
 		find_delta_children(&base_spec,
-				    &ofs_first, &ofs_last, OBJ_OFS_DELTA);
-	}
+				    &base->ofs_first, &base->ofs_last, OBJ_OFS_DELTA);
=20
-	if (ref_last =3D=3D -1 && ofs_last =3D=3D -1) {
-		free(base->data);
-		return;
-	}
+		if (base->ref_last =3D=3D -1 && base->ofs_last =3D=3D -1) {
+			free(base->data);
+			return NULL;
+		}
=20
-	link_base_data(prev_base, base);
+		link_base_data(prev_base, base);
+	}
=20
-	for (i =3D ref_first; i <=3D ref_last; i++) {
-		struct object_entry *child =3D objects + deltas[i].obj_no;
-		struct base_data result;
+	if (base->ref_first <=3D base->ref_last) {
+		struct object_entry *child =3D objects + deltas[base->ref_first].obj=
_no;
+		struct base_data *result =3D alloc_base_data();
=20
 		assert(child->real_type =3D=3D OBJ_REF_DELTA);
-		resolve_delta(child, base, &result);
-		if (i =3D=3D ref_last && ofs_last =3D=3D -1)
+		resolve_delta(child, base, result);
+		if (base->ref_first =3D=3D base->ref_last && base->ofs_last =3D=3D -=
1)
 			free_base_data(base);
-		find_unresolved_deltas(&result, base);
+
+		base->ref_first++;
+		return result;
 	}
=20
-	for (i =3D ofs_first; i <=3D ofs_last; i++) {
-		struct object_entry *child =3D objects + deltas[i].obj_no;
-		struct base_data result;
+	if (base->ofs_first <=3D base->ofs_last) {
+		struct object_entry *child =3D objects + deltas[base->ofs_first].obj=
_no;
+		struct base_data *result =3D alloc_base_data();
=20
 		assert(child->real_type =3D=3D OBJ_OFS_DELTA);
-		resolve_delta(child, base, &result);
-		if (i =3D=3D ofs_last)
+		resolve_delta(child, base, result);
+		if (base->ofs_first =3D=3D base->ofs_last)
 			free_base_data(base);
-		find_unresolved_deltas(&result, base);
+
+		base->ofs_first++;
+		return result;
 	}
=20
 	unlink_base_data(base);
+	return NULL;
+}
+
+static void find_unresolved_deltas(struct base_data *base)
+{
+	struct base_data *new_base, *prev_base =3D NULL;
+	for (;;) {
+		new_base =3D find_unresolved_deltas_1(base, prev_base);
+
+		if (new_base) {
+			prev_base =3D base;
+			base =3D new_base;
+		}
+		else {
+			free(base);
+			base =3D prev_base;
+			if (!base)
+				return;
+			prev_base =3D base->base;
+		}
+	}
 }
=20
 static int compare_delta_entry(const void *a, const void *b)
@@ -684,13 +714,13 @@ static void parse_pack_objects(unsigned char *sha=
1)
 		progress =3D start_progress("Resolving deltas", nr_deltas);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		struct base_data base_obj;
+		struct base_data *base_obj =3D alloc_base_data();
=20
 		if (is_delta_type(obj->type))
 			continue;
-		base_obj.obj =3D obj;
-		base_obj.data =3D NULL;
-		find_unresolved_deltas(&base_obj, NULL);
+		base_obj->obj =3D obj;
+		base_obj->data =3D NULL;
+		find_unresolved_deltas(base_obj);
 		display_progress(progress, nr_resolved_deltas);
 	}
 }
@@ -783,20 +813,20 @@ static void fix_unresolved_deltas(struct sha1file=
 *f, int nr_unresolved)
 	for (i =3D 0; i < n; i++) {
 		struct delta_entry *d =3D sorted_by_pos[i];
 		enum object_type type;
-		struct base_data base_obj;
+		struct base_data *base_obj =3D alloc_base_data();
=20
 		if (objects[d->obj_no].real_type !=3D OBJ_REF_DELTA)
 			continue;
-		base_obj.data =3D read_sha1_file(d->base.sha1, &type, &base_obj.size=
);
-		if (!base_obj.data)
+		base_obj->data =3D read_sha1_file(d->base.sha1, &type, &base_obj->si=
ze);
+		if (!base_obj->data)
 			continue;
=20
-		if (check_sha1_signature(d->base.sha1, base_obj.data,
-				base_obj.size, typename(type)))
+		if (check_sha1_signature(d->base.sha1, base_obj->data,
+				base_obj->size, typename(type)))
 			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
-		base_obj.obj =3D append_obj_to_pack(f, d->base.sha1,
-					base_obj.data, base_obj.size, type);
-		find_unresolved_deltas(&base_obj, NULL);
+		base_obj->obj =3D append_obj_to_pack(f, d->base.sha1,
+					base_obj->data, base_obj->size, type);
+		find_unresolved_deltas(base_obj);
 		display_progress(progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
--=20
1.7.8.36.g69ee2
