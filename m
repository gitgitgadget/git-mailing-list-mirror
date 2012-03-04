From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/10] index-pack: split second pass obj handling into own function
Date: Sun,  4 Mar 2012 19:59:52 +0700
Message-ID: <1330865996-2069-7-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 14:03:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4B5a-0003aH-RU
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 14:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab2CDNC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 08:02:56 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:42943 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab2CDNCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 08:02:55 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so3847615dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 05:02:55 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.226.41 as permitted sender) client-ip=10.68.226.41;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.226.41 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.226.41])
        by 10.68.226.41 with SMTP id rp9mr37403272pbc.162.1330866175394 (num_hops = 1);
        Sun, 04 Mar 2012 05:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mn0/qQVmGY0jhHs0pirGodZ77HpYV6Jn0HX2yfSC9BI=;
        b=MggscKyZ+nJMkDvPgTolZD7QGcxYl2M+0TKaYEBZzywMptrK0H/c4wub7W+zNnRnM6
         MjXoPxj1pyz3lQpUXZBJorxkv9OZyJ/xl63cF3NrVzTNV3e2G54ajEYBLo1JjRTPZJNh
         EbB/BpBCOIMnq0UlOi1QOnNgjdvt3MmswGSyqGEJ4RYLUs9nOtsXH33L+okJaqCp4BwK
         SR6mrv6iB8yPKUNk710d2Ba62woLqfd0FbcBdciMlsIs33BKyDkbF4lKN8iC/NryevZc
         1pae0Eb9S6SCyd3rigm/u43pIcZR2QEATw7eCQVVyxtuxsaTaWnageCgAz2waSYSEgQe
         /RDA==
Received: by 10.68.226.41 with SMTP id rp9mr31865381pbc.162.1330866175329;
        Sun, 04 Mar 2012 05:02:55 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.34.94])
        by mx.google.com with ESMTPS id l8sm10461592pbi.0.2012.03.04.05.02.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 05:02:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 04 Mar 2012 20:00:48 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192155>


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
1.7.8.36.g69ee2
