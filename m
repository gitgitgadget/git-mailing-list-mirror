From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/12] index-pack: make sure all objects are registered in v4's SHA-1 table
Date: Sat,  7 Sep 2013 17:43:13 +0700
Message-ID: <1378550599-25365-7-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:41:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFx5-0002sb-Ib
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab3IGKlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:41:10 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:39641 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3IGKlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:41:09 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so4245695pbb.27
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BGOuFrAABs76xlKXQUXxtHTfnybyH9+5ochyJ9KsBps=;
        b=K9VtA8QAsnzNgt5Qi/irdNMTSAceUCj1k7WuxDXG7pGsw8UHbv6fLwlzBaOe91FJ5K
         aWvb0gSYP4BdVDxoU04L6W5N69x6Ui2wiCzEK2cUzxvcJA2FeO3fRpyA/kxwbbZwLmR9
         c12XJ1uAdZA/p9rNdNfSBKd1pQXATlLrKvMuJrdt+6QGJBRUQEoadeo2Azs/6cldCO3d
         86+zTCRc5PDM9FJ4rRO6KaWdZs00HoD91227RRIzWvltdPKMNR0/4wVSei/UgsjePETQ
         GsRN42aq1UBEcX5Aa3AgrJr2K3H5npoPAr+ZloTtqm8unGdoK+652CLMqAf16NoHycMI
         nQXA==
X-Received: by 10.66.25.232 with SMTP id f8mr8953474pag.25.1378550469072;
        Sat, 07 Sep 2013 03:41:09 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id gg10sm3363173pbc.46.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:41:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:44:17 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234124>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 59b6c56..db2370d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -742,6 +742,19 @@ static int check_collison(struct object_entry *ent=
ry)
 	return 0;
 }
=20
+static void check_against_sha1table(struct object_entry *obj)
+{
+	const unsigned char *found;
+	if (!packv4)
+		return;
+
+	found =3D bsearch(obj->idx.sha1, sha1_table, nr_objects, 20,
+			(int (*)(const void *, const void *))hashcmp);
+	if (!found)
+		die(_("object %s not found in SHA-1 table"),
+		    sha1_to_hex(obj->idx.sha1));
+}
+
 static void sha1_object(const void *data, struct object_entry *obj_ent=
ry,
 			unsigned long size, enum object_type type,
 			const unsigned char *sha1)
@@ -910,6 +923,7 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_sha1_file(result->data, result->size,
 		       typename(delta_obj->real_type), delta_obj->idx.sha1);
+	check_against_sha1table(delta_obj);
 	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
 	counter_lock();
@@ -1087,8 +1101,12 @@ static void parse_pack_objects(unsigned char *sh=
a1)
 			/* large blobs, check later */
 			obj->real_type =3D OBJ_BAD;
 			nr_delays++;
-		} else
-			sha1_object(data, NULL, obj->size, obj->type, obj->idx.sha1);
+			check_against_sha1table(obj);
+		} else {
+			check_against_sha1table(obj);
+			sha1_object(data, NULL, obj->size, obj->type,
+				    obj->idx.sha1);
+		}
 		free(data);
 		display_progress(progress, i+1);
 	}
--=20
1.8.2.83.gc99314b
