From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/12] pack v4: split pv4_create_dict() out of load_dict()
Date: Sat,  7 Sep 2013 17:43:08 +0700
Message-ID: <1378550599-25365-2-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:40:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFwd-0002W8-OH
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab3IGKkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:40:43 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:42103 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab3IGKkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:40:42 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so4286686pdj.3
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+mmf+PF6xMm6/xVHZ02eBIWl7T9P9MVvBL3ot3TBd6A=;
        b=xX1tIIXWW3QpvscS9tx0NCzeTNnAgbgEyoUv3G3zKGDQBWZOqsNX0I0oZVqmONWyeq
         ljRh5q3OgqDMaqfUroahm0/n2c4O97egmewjWYOduWbVAPLrPKztPg685CGxA12Zg35k
         7K7YaCWlhxScoxYYyslHvaOUC8TUzoNDiIRnIosqEo0WhwJMLfx77ySeUN24TuNl2wNz
         BshlYnqMJlFfqPoQhZTP5LbhhYANA0vwrrSk7c8/FHfVn6aesEI77+FmlwFqWUP/L3CV
         AZRP0sRe1Po9RB3NuyaVGfWpHQVK1zXdfEmpa/O2ppQ4fKQVFNSzv/IdoPDRYHPLISj9
         sHZw==
X-Received: by 10.66.146.199 with SMTP id te7mr9024784pab.106.1378550441534;
        Sat, 07 Sep 2013 03:40:41 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id ry4sm3958535pab.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:40:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:43:49 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234119>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 63 ++++++++++++++++++++++++++++++++------------------=
--------
 packv4-parse.h |  8 ++++++++
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index 63bba03..82661ba 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -30,11 +30,38 @@ const unsigned char *get_sha1ref(struct packed_git =
*p,
 	return sha1;
 }
=20
-struct packv4_dict {
-	const unsigned char *data;
-	unsigned int nb_entries;
-	unsigned int offsets[FLEX_ARRAY];
-};
+struct packv4_dict *pv4_create_dict(const unsigned char *data, int dic=
t_size)
+{
+	struct packv4_dict *dict;
+	int i;
+
+	/* count number of entries */
+	int nb_entries =3D 0;
+	const unsigned char *cp =3D data;
+	while (cp < data + dict_size - 3) {
+		cp +=3D 2;  /* prefix bytes */
+		cp +=3D strlen((const char *)cp);  /* entry string */
+		cp +=3D 1;  /* terminating NUL */
+		nb_entries++;
+	}
+	if (cp - data !=3D dict_size) {
+		error("dict size mismatch");
+		return NULL;
+	}
+
+	dict =3D xmalloc(sizeof(*dict) + nb_entries * sizeof(dict->offsets[0]=
));
+	dict->data =3D data;
+	dict->nb_entries =3D nb_entries;
+
+	cp =3D data;
+	for (i =3D 0; i < nb_entries; i++) {
+		dict->offsets[i] =3D cp - data;
+		cp +=3D 2;
+		cp +=3D strlen((const char *)cp) + 1;
+	}
+
+	return dict;
+}
=20
 static struct packv4_dict *load_dict(struct packed_git *p, off_t *offs=
et)
 {
@@ -45,7 +72,7 @@ static struct packv4_dict *load_dict(struct packed_gi=
t *p, off_t *offset)
 	const unsigned char *cp;
 	git_zstream stream;
 	struct packv4_dict *dict;
-	int nb_entries, i, st;
+	int st;
=20
 	/* get uncompressed dictionary data size */
 	src =3D use_pack(p, &w_curs, curpos, &avail);
@@ -77,32 +104,12 @@ static struct packv4_dict *load_dict(struct packed=
_git *p, off_t *offset)
 		return NULL;
 	}
=20
-	/* count number of entries */
-	nb_entries =3D 0;
-	cp =3D data;
-	while (cp < data + dict_size - 3) {
-		cp +=3D 2;  /* prefix bytes */
-		cp +=3D strlen((const char *)cp);  /* entry string */
-		cp +=3D 1;  /* terminating NUL */
-		nb_entries++;
-	}
-	if (cp - data !=3D dict_size) {
-		error("dict size mismatch");
+	dict =3D pv4_create_dict(data, dict_size);
+	if (!dict) {
 		free(data);
 		return NULL;
 	}
=20
-	dict =3D xmalloc(sizeof(*dict) + nb_entries * sizeof(dict->offsets[0]=
));
-	dict->data =3D data;
-	dict->nb_entries =3D nb_entries;
-
-	cp =3D data;
-	for (i =3D 0; i < nb_entries; i++) {
-		dict->offsets[i] =3D cp - data;
-		cp +=3D 2;
-		cp +=3D strlen((const char *)cp) + 1;
-	}
-
 	*offset =3D curpos;
 	return dict;
 }
diff --git a/packv4-parse.h b/packv4-parse.h
index 5f9d809..0b2405a 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -1,6 +1,14 @@
 #ifndef PACKV4_PARSE_H
 #define PACKV4_PARSE_H
=20
+struct packv4_dict {
+	const unsigned char *data;
+	unsigned int nb_entries;
+	unsigned int offsets[FLEX_ARRAY];
+};
+
+struct packv4_dict *pv4_create_dict(const unsigned char *data, int dic=
t_size);
+
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs=
,
 		     off_t offset, unsigned long size);
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
--=20
1.8.2.83.gc99314b
