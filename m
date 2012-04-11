From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/3] index-pack: split second pass obj handling into own function
Date: Wed, 11 Apr 2012 12:49:47 +0700
Message-ID: <1334123388-6083-3-git-send-email-pclouds@gmail.com>
References: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 07:51:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHqSQ-00041M-P4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 07:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab2DKFvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 01:51:01 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52384 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab2DKFvA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 01:51:00 -0400
Received: by pbcun15 with SMTP id un15so807121pbc.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7tlUZBef7tWlxFAjx4XvIKAjXPnssC4RGjr8lLfWiuI=;
        b=loLHA8C5fM9+OLhAK9HQlWd0qs3+CIW4ey4lPb3ysQKv/qMwiBsm0QswVFlr7c3dxc
         Y7VsFzNNZdHeb/y4S2DXsJQbL4/jhF7fz+l2bSpub7Fj9bwHwEfH10fyIS/MvoFPBBII
         N8VWi6EE8yHHxl9uSmV1WP5WLuz9g91UJ+INVDpA6mH1zejXDh/Hlft+1gc8Ogl/8Pwj
         P58PxyUXWvXO7Yfkzi2CdSdH48dFN5xrPo44MuY/6JpY1XKZq6AjIScpuC5uBmAQqAu2
         VgrUxwHQcva/LlkgV6GQ2uDxs+yoM3hkGl3p4QpTg/0GcyXJaRdPmN5nQcvRcoNNVVCQ
         JdvQ==
Received: by 10.68.216.167 with SMTP id or7mr13635159pbc.140.1334123460178;
        Tue, 10 Apr 2012 22:51:00 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id d3sm1937633pbq.9.2012.04.10.22.50.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 22:50:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Apr 2012 12:50:13 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195148>


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
