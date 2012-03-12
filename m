From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] index-pack: split second pass obj handling into own function
Date: Mon, 12 Mar 2012 09:32:28 +0700
Message-ID: <1331519549-28090-2-git-send-email-pclouds@gmail.com>
References: <1331519549-28090-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 03:33:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6v4S-0002hk-6A
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 03:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab2CLCdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 22:33:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35049 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab2CLCdF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 22:33:05 -0400
Received: by mail-pz0-f46.google.com with SMTP id r28so4490235daj.19
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7tlUZBef7tWlxFAjx4XvIKAjXPnssC4RGjr8lLfWiuI=;
        b=pRf6GI8P4WAi96GkNaE5h79YGDiz0T/PrCGF6lnuCtfMj/WZTuEV26/pOXFrTQydTr
         pApJP9uuHqiGawj8lU0F3u+2QJL/VM55bH+H8xmXipscwRtIIlIIlEYxBuZ1ey7MxG5n
         whLWGknxjJKfV87ae/sqSj+K0BOA6kQeHiLc1ZHzu7cVPSZgXQIGlnFW/v6dq/FUZb/q
         Oc35vfYON4ZRr9CYMHMooJe+d/3BLcr1Cshwlt5+X1m2c1VOvRE2lBiRjG79NgIaxWEP
         Dcvm8Dxb7hwzeF5yAd+A2aVcq1GX1yZpCon/WgoWtkq0MPxbbE6IgBtjKIkiDz/W8V3T
         BxnA==
Received: by 10.68.239.65 with SMTP id vq1mr10243802pbc.116.1331519585550;
        Sun, 11 Mar 2012 19:33:05 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id o7sm9245918pbq.8.2012.03.11.19.33.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Mar 2012 19:33:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 12 Mar 2012 09:32:37 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1331519549-28090-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192836>


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
