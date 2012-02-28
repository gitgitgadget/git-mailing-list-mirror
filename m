From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] index-pack: split second pass obj handling into own function
Date: Tue, 28 Feb 2012 11:36:52 +0700
Message-ID: <1330403813-2770-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 05:37:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Eow-0000Yx-Tw
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 05:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab2B1EhT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 23:37:19 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50622 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648Ab2B1EhR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 23:37:17 -0500
Received: by pbcup15 with SMTP id up15so2845664pbc.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 20:37:17 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.197.166 as permitted sender) client-ip=10.68.197.166;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.197.166 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.197.166])
        by 10.68.197.166 with SMTP id iv6mr14108815pbc.44.1330403837221 (num_hops = 1);
        Mon, 27 Feb 2012 20:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=7tlUZBef7tWlxFAjx4XvIKAjXPnssC4RGjr8lLfWiuI=;
        b=FoiA0oZVT98SQ1MKjlPZCjq0+6h0iDZdkixaXGhGR7I2MD+m7xrK1HVQavIgSETKeg
         9O5RYuPqGVY8udTbuqqN0Ob5S/F+if3Upt+FZXDPTbszi5pvfsVu98J8a/kXN9rg7Bgo
         K5yMHBKfNH8awQ2inR8qHoP2yMeEECNzaLKrQ=
Received: by 10.68.197.166 with SMTP id iv6mr11631715pbc.44.1330403837187;
        Mon, 27 Feb 2012 20:37:17 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id k2sm14576015pba.28.2012.02.27.20.37.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 20:37:16 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 28 Feb 2012 11:36:54 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191698>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dd1c5c9..918684f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -682,6 +682,23 @@ static int compare_delta_entry(const void *a, cons=
t void *b)
 				   objects[delta_b->obj_no].type);
 }
=20
+/*
+ * Second pass:
+ * - for all non-delta objects, look if it is used as a base for
+ *   deltas;
+ * - if used as a base, uncompress the object and apply all deltas,
+ *   recursively checking if the resulting object is used as a base
+ *   for some more deltas.
+ */
+static void second_pass(struct object_entry *obj)
+{
+	struct base_data *base_obj =3D alloc_base_data();
+	base_obj->obj =3D obj;
+	base_obj->data =3D NULL;
+	find_unresolved_deltas(base_obj);
+	display_progress(progress, nr_resolved_deltas);
+}
+
 /* Parse all objects and return the pack content SHA1 hash */
 static void parse_pack_objects(unsigned char *sha1)
 {
@@ -736,26 +753,14 @@ static void parse_pack_objects(unsigned char *sha=
1)
 	qsort(deltas, nr_deltas, sizeof(struct delta_entry),
 	      compare_delta_entry);
=20
-	/*
-	 * Second pass:
-	 * - for all non-delta objects, look if it is used as a base for
-	 *   deltas;
-	 * - if used as a base, uncompress the object and apply all deltas,
-	 *   recursively checking if the resulting object is used as a base
-	 *   for some more deltas.
-	 */
 	if (verbose)
 		progress =3D start_progress("Resolving deltas", nr_deltas);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		struct base_data *base_obj =3D alloc_base_data();
=20
 		if (is_delta_type(obj->type))
 			continue;
-		base_obj->obj =3D obj;
-		base_obj->data =3D NULL;
-		find_unresolved_deltas(base_obj);
-		display_progress(progress, nr_resolved_deltas);
+		second_pass(obj);
 	}
 }
=20
--=20
1.7.3.1.256.g2539c.dirty
