From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/8] mv: move index search code out
Date: Fri,  8 Aug 2014 20:11:00 +0700
Message-ID: <1407503462-32632-7-git-send-email-pclouds@gmail.com>
References: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 15:11:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFjxR-00014F-M7
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 15:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714AbaHHNLl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 09:11:41 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:54997 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756698AbaHHNLk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 09:11:40 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so7323350pad.10
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 06:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EEJzhyRWOvvbs5fk5yCdF1LoBKlcFPu1erKpwXG70NA=;
        b=aZ2o1bOjjoRE3IdnnDrhHAV69KdVqeS9Mcb0EnYqrZ/+j0lzTvsyZSFy4o28gsFOdT
         j3xMwc2NXBI8QgeB+89VtvtwtkO88NyYBanj6GdyU4pgvh9IzmGwzwx+3at7OZ954qmw
         I8MyYfOHLKvi+m4ikf7ByNuq2bJmGIY2kDkU7LlgcgpxXaqVL4HSWsir4Gx3590/eMXp
         nj3+ThfzbjDR9qqtSa4wqLDupUF5bGrIG9uj3Q1CAaKK2jk3CAQmxNdjGzBhSasb6+HG
         4mjuYiu/42dp4FrcykW8nJv/618T+IE1RlJCaVZW0jQwxpiSdBkrAkYtB/ptPL9NQN95
         M1Sg==
X-Received: by 10.70.60.226 with SMTP id k2mr24370051pdr.130.1407503500123;
        Fri, 08 Aug 2014 06:11:40 -0700 (PDT)
Received: from lanh ([115.73.206.39])
        by mx.google.com with ESMTPSA id f16sm4344268pdm.43.2014.08.08.06.11.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 06:11:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 08 Aug 2014 20:11:42 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255012>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index a45226e..f8d65e2 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -83,6 +83,29 @@ static void prepare_move_submodule(const char *src, =
int first,
 	strbuf_release(&submodule_dotgit);
 }
=20
+static int index_range_of_same_dir(const char *src, int length,
+				   int *first_p, int *last_p)
+{
+	const char *src_w_slash =3D add_slash(src);
+	int first, last, len_w_slash =3D length + 1;
+
+	first =3D cache_name_pos(src_w_slash, len_w_slash);
+	if (first >=3D 0)
+		die (_("%.*s is in index"), len_w_slash, src_w_slash);
+
+	first =3D -1 - first;
+	for (last =3D first; last < active_nr; last++) {
+		const char *path =3D active_cache[last]->name;
+		if (strncmp(path, src_w_slash, len_w_slash))
+			break;
+	}
+	if (src_w_slash !=3D src)
+		free((char *)src_w_slash);
+	*first_p =3D first;
+	*last_p =3D last;
+	return last - first;
+}
+
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, gitmodules_modified =3D 0;
@@ -158,24 +181,10 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 				prepare_move_submodule(src, first,
 						       submodule_gitfile + i);
 			else {
-				const char *src_w_slash =3D add_slash(src);
-				int last, len_w_slash =3D length + 1;
+				int last;
=20
 				modes[i] =3D WORKING_DIRECTORY;
-
-				first =3D cache_name_pos(src_w_slash, len_w_slash);
-				if (first >=3D 0)
-					die (_("%.*s is in index"), len_w_slash, src_w_slash);
-
-				first =3D -1 - first;
-				for (last =3D first; last < active_nr; last++) {
-					const char *path =3D active_cache[last]->name;
-					if (strncmp(path, src_w_slash, len_w_slash))
-						break;
-				}
-				if (src_w_slash !=3D src)
-					free((char *)src_w_slash);
-
+				index_range_of_same_dir(src, length, &first, &last);
 				if (last - first < 1)
 					bad =3D _("source directory is empty");
 				else {
--=20
2.1.0.rc0.78.gc0d8480
