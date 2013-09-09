From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/16] pack-objects: prepare SHA-1 table in v4
Date: Mon,  9 Sep 2013 20:58:03 +0700
Message-ID: <1378735087-4813-13-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:56:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1xH-00040i-PL
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab3IIN4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:56:35 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:50065 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab3IIN4e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:56:34 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so6090127pbc.7
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cyDjn9O/2FBqfDVE6XVggu0JCjkZuqBTVCe+6V6U0Jw=;
        b=rLdn+WXnuhPwz6/dcXG1rP5kGj1r5DtUh2k74KoaBfazHBgLp8vMRZdW4XKFLbpTJg
         G4x4jzgcaL3Pqcbkg9iPNxFpktBrVXTlLJAYqaFNWdW2R7FCUtN+w9mv2aA/vR4iNwW/
         ug5uCzEgGyFulepi4a0hiLsSTvZT/qA+IEEHFTrVYcjXMpxmU6a+IvmrMR7w/+eTOvhY
         NnMmiMen9LCe7JBGca65ugGncwmvQLhygmy5jRN39VjKar89gnZdRTY8WfG4vfYafjBj
         PxL2s53eAEipA1SlhA/XKijpSklSYwB3lhDiQllJjl7Tv8gWeylMXtiAzbGlTq/bvwgW
         OBUg==
X-Received: by 10.68.234.130 with SMTP id ue2mr3269428pbc.159.1378734994016;
        Mon, 09 Sep 2013 06:56:34 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id nv6sm16458046pbc.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:56:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:59:43 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234340>

SHA-1 table is trickier than ident or path tables because it must
contains exactly the number entries in pack. In the thin pack case it
must also cover bases that will be appended by index-pack.

The problem is not all preferred_base entries end up becoming actually
needed. So we do a fake write_one() round just to get what is written
and what is not. It also helps the case when the multiple packs are
written.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 55 ++++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 60ea5a7..055b59d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -434,7 +434,7 @@ static unsigned long write_object(struct sha1file *=
f,
 	unsigned long limit, len;
 	int usable_delta, to_reuse;
=20
-	if (!pack_to_stdout)
+	if (f && !pack_to_stdout)
 		crc32_begin(f);
=20
 	/* apply size limit if limited packsize and not first object */
@@ -477,6 +477,12 @@ static unsigned long write_object(struct sha1file =
*f,
 				 * and we do not need to deltify it.
 				 */
=20
+	if (!f) {
+		if (usable_delta && entry->delta->idx.offset < 2)
+			entry->delta->idx.offset =3D 2;
+		return 2;
+	}
+
 	if (!to_reuse)
 		len =3D write_no_reuse_object(f, entry, limit, usable_delta);
 	else
@@ -543,10 +549,14 @@ static enum write_one_status write_one(struct sha=
1file *f,
 		e->idx.offset =3D recursing;
 		return WRITE_ONE_BREAK;
 	}
+	if (!f) {
+		*offset +=3D size;
+		return WRITE_ONE_WRITTEN;
+	}
 	written_list[nr_written++] =3D &e->idx;
=20
 	/* make sure off_t is sufficiently large not to wrap */
-	if (signed_add_overflows(*offset, size))
+	if (f && signed_add_overflows(*offset, size))
 		die("pack too large for current definition of off_t");
 	*offset +=3D size;
 	return WRITE_ONE_WRITTEN;
@@ -716,6 +726,39 @@ static struct object_entry **compute_write_order(v=
oid)
 	return wo;
 }
=20
+static int sha1_idx_sort(const void *a_, const void *b_)
+{
+	const struct pack_idx_entry *a =3D a_;
+	const struct pack_idx_entry *b =3D b_;
+	return hashcmp(a->sha1, b->sha1);
+}
+
+/*
+ * Do a fake writting round to detemine what's in the SHA-1 table.
+ */
+static void prepare_sha1_table(uint32_t start, struct object_entry **w=
rite_order)
+{
+	int i =3D start;
+	off_t fake_offset =3D 2;
+	for (; i < nr_objects; i++) {
+		struct object_entry *e =3D write_order[i];
+		if (write_one(NULL, e, &fake_offset) =3D=3D WRITE_ONE_BREAK)
+			break;
+	}
+
+	v4.all_objs_nr =3D 0;
+	for (i =3D 0; i < nr_objects; i++) {
+		struct object_entry *e =3D write_order[i];
+		if (e->idx.offset > 0) {
+			v4.all_objs[v4.all_objs_nr++] =3D e->idx;
+			fprintf(stderr, "%s in\n", sha1_to_hex(e->idx.sha1));
+			e->idx.offset =3D 0;
+		}
+	}
+	qsort(v4.all_objs, v4.all_objs_nr, sizeof(*v4.all_objs),
+	      sha1_idx_sort);
+}
+
 static void write_pack_file(void)
 {
 	uint32_t i =3D 0, j;
@@ -739,7 +782,12 @@ static void write_pack_file(void)
 		else
 			f =3D create_tmp_packfile(&pack_tmp_name);
=20
-		offset =3D write_pack_header(f, pack_version, nr_remaining);
+		if (pack_version =3D=3D 4)
+			prepare_sha1_table(i, write_order);
+
+		offset =3D write_pack_header(f, pack_version,
+					   pack_version < 4 ? nr_remaining : v4.all_objs_nr);
+
 		if (!offset)
 			die_errno("unable to write pack header");
 		nr_written =3D 0;
@@ -2058,6 +2106,7 @@ static void prepare_pack(int window, int depth)
 	if (pack_version =3D=3D 4) {
 		sort_dict_entries_by_hits(v4.commit_ident_table);
 		sort_dict_entries_by_hits(v4.tree_path_table);
+		v4.all_objs =3D xmalloc(nr_objects * sizeof(*v4.all_objs));
 	}
=20
 	get_object_details();
--=20
1.8.2.83.gc99314b
