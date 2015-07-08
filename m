From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] pack-objects: rename the field "type" to "real_type"
Date: Wed,  8 Jul 2015 18:56:31 +0700
Message-ID: <1436356591-8148-2-git-send-email-pclouds@gmail.com>
References: <20150707160630.GA4456@peff.net>
 <1436356591-8148-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 13:56:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCnxh-0004HD-9n
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 13:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158AbbGHL4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 07:56:15 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33880 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756953AbbGHL4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 07:56:11 -0400
Received: by pdbep18 with SMTP id ep18so144629461pdb.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ieh+We7eSSVL5Bv2e/tbGIeTxurh5UfkgSRrAHNpp48=;
        b=xmWZ1LgPMhC7QXGWYMLq/8lIwLhz83Z39cCgMvZjGwpqCE+MQkx1iYGmbnnCiOYQR7
         S/9SwPB0kyambybNcLVmW/LpGlZVA2HhKxla1pGNNKHPBcOZVbYVoT7C55bOcptdDAjG
         J9k3SD+QnyTzlN0L5bwY1DWljcsHWBBd7C7XtYm6vIUoBzTfXHsuQ/52j6HHVWDExMAN
         uItZ3aSitAy4PiIcdfMmNCfeNZdSlnwnBvmAtnz0wiKsNhDS4MmklNSeLXLcF6FX482E
         4vucpXf2zTBmxFcN++17DLFsrkXe2FKFafnxOtSoeZK4289bxDCB3DZUqGc8ydaGp/sH
         8dew==
X-Received: by 10.68.222.227 with SMTP id qp3mr19701838pbc.60.1436356571184;
        Wed, 08 Jul 2015 04:56:11 -0700 (PDT)
Received: from lanh ([115.73.45.219])
        by smtp.gmail.com with ESMTPSA id uz9sm2312264pac.34.2015.07.08.04.56.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 04:56:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jul 2015 18:56:57 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436356591-8148-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273674>

This is to avoid the too generic name "type" and harmonize with the
naming in index-pack. There's a subtle difference though: real_type in
index-pack is what the upper level see, no delta types (after delta
resolution). But real_type in pack-objects is the type to be written in
the pack, delta types are fine (it's actually markers for reused deltas=
)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 36 ++++++++++++++++++------------------
 pack-bitmap-write.c    |  6 +++---
 pack-objects.h         |  2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 80fe8c7..e03bf3e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -244,7 +244,7 @@ static unsigned long write_no_reuse_object(struct s=
ha1file *f, struct object_ent
 	struct git_istream *st =3D NULL;
=20
 	if (!usable_delta) {
-		if (entry->type =3D=3D OBJ_BLOB &&
+		if (entry->real_type =3D=3D OBJ_BLOB &&
 		    entry->size > big_file_threshold &&
 		    (st =3D open_istream(entry->idx.sha1, &type, &size, NULL)) !=3D =
NULL)
 			buf =3D NULL;
@@ -348,7 +348,7 @@ static unsigned long write_reuse_object(struct sha1=
file *f, struct object_entry
 	struct pack_window *w_curs =3D NULL;
 	struct revindex_entry *revidx;
 	off_t offset;
-	enum object_type type =3D entry->type;
+	enum object_type type =3D entry->real_type;
 	unsigned long datalen;
 	unsigned char header[10], dheader[10];
 	unsigned hdrlen;
@@ -452,11 +452,11 @@ static unsigned long write_object(struct sha1file=
 *f,
 		to_reuse =3D 0;	/* explicit */
 	else if (!entry->in_pack)
 		to_reuse =3D 0;	/* can't reuse what we don't have */
-	else if (entry->type =3D=3D OBJ_REF_DELTA || entry->type =3D=3D OBJ_O=
=46S_DELTA)
+	else if (entry->real_type =3D=3D OBJ_REF_DELTA || entry->real_type =3D=
=3D OBJ_OFS_DELTA)
 				/* check_object() decided it for us ... */
 		to_reuse =3D usable_delta;
 				/* ... but pack split may override that */
-	else if (entry->type !=3D entry->in_pack_type)
+	else if (entry->real_type !=3D entry->in_pack_type)
 		to_reuse =3D 0;	/* pack has delta which is unusable */
 	else if (entry->delta)
 		to_reuse =3D 0;	/* we want to pack afresh */
@@ -676,8 +676,8 @@ static struct object_entry **compute_write_order(vo=
id)
 	 * And then all remaining commits and tags.
 	 */
 	for (i =3D last_untagged; i < to_pack.nr_objects; i++) {
-		if (objects[i].type !=3D OBJ_COMMIT &&
-		    objects[i].type !=3D OBJ_TAG)
+		if (objects[i].real_type !=3D OBJ_COMMIT &&
+		    objects[i].real_type !=3D OBJ_TAG)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
 	}
@@ -686,7 +686,7 @@ static struct object_entry **compute_write_order(vo=
id)
 	 * And then all the trees.
 	 */
 	for (i =3D last_untagged; i < to_pack.nr_objects; i++) {
-		if (objects[i].type !=3D OBJ_TREE)
+		if (objects[i].real_type !=3D OBJ_TREE)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
 	}
@@ -994,7 +994,7 @@ static void create_object_entry(const unsigned char=
 *sha1,
 	entry =3D packlist_alloc(&to_pack, sha1, index_pos);
 	entry->hash =3D hash;
 	if (type)
-		entry->type =3D type;
+		entry->real_type =3D type;
 	if (exclude)
 		entry->preferred_base =3D 1;
 	else
@@ -1355,9 +1355,9 @@ static void check_object(struct object_entry *ent=
ry)
 		switch (entry->in_pack_type) {
 		default:
 			/* Not a delta hence we've already got all we need. */
-			entry->type =3D entry->in_pack_type;
+			entry->real_type =3D entry->in_pack_type;
 			entry->in_pack_header_size =3D used;
-			if (entry->type < OBJ_COMMIT || entry->type > OBJ_BLOB)
+			if (entry->real_type < OBJ_COMMIT || entry->real_type > OBJ_BLOB)
 				goto give_up;
 			unuse_pack(&w_curs);
 			return;
@@ -1411,7 +1411,7 @@ static void check_object(struct object_entry *ent=
ry)
 			 * deltify other objects against, in order to avoid
 			 * circular deltas.
 			 */
-			entry->type =3D entry->in_pack_type;
+			entry->real_type =3D entry->in_pack_type;
 			entry->delta =3D base_entry;
 			entry->delta_size =3D entry->size;
 			entry->delta_sibling =3D base_entry->delta_child;
@@ -1420,7 +1420,7 @@ static void check_object(struct object_entry *ent=
ry)
 			return;
 		}
=20
-		if (entry->type) {
+		if (entry->real_type) {
 			/*
 			 * This must be a delta and we already know what the
 			 * final object type is.  Let's extract the actual
@@ -1443,7 +1443,7 @@ static void check_object(struct object_entry *ent=
ry)
 		unuse_pack(&w_curs);
 	}
=20
-	entry->type =3D sha1_object_info(entry->idx.sha1, &entry->size);
+	entry->real_type =3D sha1_object_info(entry->idx.sha1, &entry->size);
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
@@ -1503,9 +1503,9 @@ static int type_size_sort(const void *_a, const v=
oid *_b)
 	const struct object_entry *a =3D *(struct object_entry **)_a;
 	const struct object_entry *b =3D *(struct object_entry **)_b;
=20
-	if (a->type > b->type)
+	if (a->real_type > b->real_type)
 		return -1;
-	if (a->type < b->type)
+	if (a->real_type < b->real_type)
 		return 1;
 	if (a->hash > b->hash)
 		return -1;
@@ -1581,7 +1581,7 @@ static int try_delta(struct unpacked *trg, struct=
 unpacked *src,
 	void *delta_buf;
=20
 	/* Don't bother doing diffs between different types */
-	if (trg_entry->type !=3D src_entry->type)
+	if (trg_entry->real_type !=3D src_entry->real_type)
 		return -1;
=20
 	/*
@@ -2149,11 +2149,11 @@ static void prepare_pack(int window, int depth)
=20
 		if (!entry->preferred_base) {
 			nr_deltas++;
-			if (entry->type < 0)
+			if (entry->real_type < 0)
 				die("unable to get type of object %s",
 				    sha1_to_hex(entry->idx.sha1));
 		} else {
-			if (entry->type < 0) {
+			if (entry->real_type < 0) {
 				/*
 				 * This object is not found, but we
 				 * don't have to include it anyway.
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c05d138..572f4d6 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -64,12 +64,12 @@ void bitmap_writer_build_type_index(struct pack_idx=
_entry **index,
=20
 		entry->in_pack_pos =3D i;
=20
-		switch (entry->type) {
+		switch (entry->real_type) {
 		case OBJ_COMMIT:
 		case OBJ_TREE:
 		case OBJ_BLOB:
 		case OBJ_TAG:
-			real_type =3D entry->type;
+			real_type =3D entry->real_type;
 			break;
=20
 		default:
@@ -96,7 +96,7 @@ void bitmap_writer_build_type_index(struct pack_idx_e=
ntry **index,
=20
 		default:
 			die("Missing type information for %s (%d/%d)",
-			    sha1_to_hex(entry->idx.sha1), real_type, entry->type);
+			    sha1_to_hex(entry->idx.sha1), real_type, entry->real_type);
 		}
 	}
 }
diff --git a/pack-objects.h b/pack-objects.h
index d1b98b3..33cde59 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -14,7 +14,7 @@ struct object_entry {
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
-	enum object_type type;
+	enum object_type real_type;
 	enum object_type in_pack_type;	/* could be delta */
 	uint32_t hash;			/* name hint hash */
 	unsigned int in_pack_pos;
--=20
2.3.0.rc1.137.g477eb31
