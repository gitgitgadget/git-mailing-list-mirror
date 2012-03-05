From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/11] index-pack: split second pass obj handling into own function
Date: Mon,  5 Mar 2012 10:43:43 +0700
Message-ID: <1330919028-6611-7-git-send-email-pclouds@gmail.com>
References: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 04:45:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4OrI-0003uf-4c
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 04:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441Ab2CEDpE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 22:45:04 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41418 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab2CEDpC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 22:45:02 -0500
Received: by mail-pw0-f46.google.com with SMTP id un15so2292252pbc.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 19:45:02 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.230.70 as permitted sender) client-ip=10.68.230.70;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.230.70 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.230.70])
        by 10.68.230.70 with SMTP id sw6mr22389669pbc.9.1330919102413 (num_hops = 1);
        Sun, 04 Mar 2012 19:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7tlUZBef7tWlxFAjx4XvIKAjXPnssC4RGjr8lLfWiuI=;
        b=XUJphkwECbA6TyTD5/535RhXyZMmrhcH/7cVCJBqsLOuX21SFeljkhGQQklpH3NEY9
         JEKFOEet7cAUyChSso+sw5wKbL8IF8UTQ7QS1uKVppz6oI8Gi6UC2ESSeodKkrunp24U
         0Cp6DcbOUdosHPx3sURbs3rWNODP0CUC5//m2AQsZSVFmuQZv1bqYD2uCDxaJ03Ucdqv
         nJyKiJT6iP8IYxl0ZdjD6orPxFwmuU5W2oRLi4gTNTJMxrs+yMn29Sy6O7y0e8pY9FvX
         piwGYsdSGdsvfSs/jPA3GmDMTNp4bncAPvuxSF9dYVqSkA4QVmr53BvjumMl2MD8r6Po
         8A7w==
Received: by 10.68.230.70 with SMTP id sw6mr19623957pbc.9.1330919102372;
        Sun, 04 Mar 2012 19:45:02 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id d10sm12089922pbr.59.2012.03.04.19.44.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 19:45:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 05 Mar 2012 10:44:37 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192199>


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
