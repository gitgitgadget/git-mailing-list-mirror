From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] index-pack: move second pass code into separate function
Date: Sat, 25 Feb 2012 17:56:15 +0700
Message-ID: <1330167376-24859-4-git-send-email-pclouds@gmail.com>
References: <1330167376-24859-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 11:54:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1FGi-0000Y3-7X
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 11:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203Ab2BYKyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 05:54:19 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51114 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062Ab2BYKyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 05:54:18 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so3412318dae.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 02:54:18 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.211.202 as permitted sender) client-ip=10.68.211.202;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.211.202 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.211.202])
        by 10.68.211.202 with SMTP id ne10mr17601938pbc.164.1330167258195 (num_hops = 1);
        Sat, 25 Feb 2012 02:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sgTs96sAimvtJQOGEVgXXH2oyFINjd6OwgVUSqY0MTk=;
        b=xmTqFA86GhOefjrv7RourGWcgG6TfKOhEZ22z7YXMPWGnyj8Bk46BYgm12a1AX1M83
         mAAs0kKSpSE6qIWmMk1GLS4Uybm8nDjOX/BpyPPBg2+XwIfAyqtfvsjD02qkytm0m5kr
         DTnBbf9aiRyaRF599alk3vxCiMIu+3aouyQPY=
Received: by 10.68.211.202 with SMTP id ne10mr14641795pbc.164.1330167258151;
        Sat, 25 Feb 2012 02:54:18 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id x1sm6915754pbp.50.2012.02.25.02.54.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 02:54:17 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 25 Feb 2012 17:56:36 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330167376-24859-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191519>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   54 +++++++++++++++++++++++++++---------------=
-------
 1 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ab24dd8..e1e858a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -719,6 +719,35 @@ static int compare_delta_entry(const void *a, cons=
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
+ * - if the same object exists in repository and we're not in strict
+ *   mode, we skipped the sha-1 collision test in the first pass.
+ *   Do it now.
+ */
+static void second_pass(struct object_entry *obj)
+{
+	struct base_data *base_obj =3D alloc_base_data();
+
+	if (((!strict && !verify) ||
+	     (strict && !verify && obj->type =3D=3D OBJ_BLOB)) &&
+	    has_sha1_file(obj->idx.sha1)) {
+		void *data =3D get_data_from_pack(obj);
+		sha1_object(data, obj->size, obj->type, obj->idx.sha1);
+		free(data);
+	}
+
+	base_obj->obj =3D obj;
+	base_obj->data =3D NULL;
+	find_unresolved_deltas(base_obj);
+	display_progress(progress, nr_resolved_deltas);
+}
+
 /* Parse all objects and return the pack content SHA1 hash */
 static void parse_pack_objects(unsigned char *sha1)
 {
@@ -773,38 +802,15 @@ static void parse_pack_objects(unsigned char *sha=
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
-	 * - if the same object exists in repository and we're not in strict
-	 *   mode, we skipped the sha-1 collision test in the first pass.
-	 *   Do it now.
-	 */
 	if (verbose)
 		progress =3D start_progress("Resolving deltas", nr_deltas);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		struct base_data *base_obj =3D alloc_base_data();
=20
 		if (is_delta_type(obj->type))
 			continue;
=20
-		if (((!strict && !verify) ||
-		     (strict && !verify && obj->type =3D=3D OBJ_BLOB)) &&
-		    has_sha1_file(obj->idx.sha1)) {
-			void *data =3D get_data_from_pack(obj);
-			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
-			free(data);
-		}
-
-		base_obj->obj =3D obj;
-		base_obj->data =3D NULL;
-		find_unresolved_deltas(base_obj);
-		display_progress(progress, nr_resolved_deltas);
+		second_pass(obj);
 	}
 }
=20
--=20
1.7.8.36.g69ee2
