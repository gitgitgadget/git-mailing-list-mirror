From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/46] pathspec: add copy_pathspec
Date: Sun, 14 Jul 2013 15:35:27 +0700
Message-ID: <1373790969-13000-5-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:36:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHnU-0001Ds-Fe
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab3GNIgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:36:45 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:39805 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:36:44 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so10377879pbc.15
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5IS7URitYALtQAvPnHI/uwvV2i/hx+oZlaGzg9Sr2es=;
        b=TfEK4GKmrq7P/W7VVxPJTUFQ3loEXSwreKPapRf2MhpshWgHPfuwC/M0AmtcY4TIxY
         B/dpXQ5JcgEV/YH6HnNffzQL4cd4zv01pcr7DSsp9lH9LyZmv75DBhUVR7McVMDAAkmq
         3K16RqJixi8o5g8XjMa88K43MDnSi9C5vFG66/belpjRgLdfw6G1Irn8FeLrHBp+ni9i
         5CQvBka5TNgeR4n51mDn05uGDNrQfr/VmVUMz7OnM1XhwHAth7TrW3GK7R1sd7vvBpa4
         /atPEcy+oAhFNiH9QBgzZxbcmGtzFt6h3igyMo1snV5OdVoEpiFCUUYZwnWramBxPAro
         cXlg==
X-Received: by 10.68.179.35 with SMTP id dd3mr48665149pbc.199.1373791003569;
        Sun, 14 Jul 2013 01:36:43 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id bs3sm54521995pbc.42.2013.07.14.01.36.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:36:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:36:55 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230316>

Because free_pathspec wants to free "items" pointer in the pathspec
structure, a simple structure assignment is not enough if you want to
copy an existing pathspec into another.  Freeing the original will
damage the copy unless a deep copy is made.

Note that the strings in pathspec->items->match and the array
pathspec->raw[] are still shared between the original and the copy.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 13 +++++++------
 pathspec.c   |  8 ++++++++
 pathspec.h   |  1 +
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 034fec9..16ce99b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -15,8 +15,9 @@ static const char * const builtin_mv_usage[] =3D {
 	NULL
 };
=20
-static const char **copy_pathspec(const char *prefix, const char **pat=
hspec,
-				  int count, int base_name)
+static const char **internal_copy_pathspec(const char *prefix,
+					   const char **pathspec,
+					   int count, int base_name)
 {
 	int i;
 	const char **result =3D xmalloc((count + 1) * sizeof(const char *));
@@ -81,17 +82,17 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
=20
-	source =3D copy_pathspec(prefix, argv, argc, 0);
+	source =3D internal_copy_pathspec(prefix, argv, argc, 0);
 	modes =3D xcalloc(argc, sizeof(enum update_mode));
-	dest_path =3D copy_pathspec(prefix, argv + argc, 1, 0);
+	dest_path =3D internal_copy_pathspec(prefix, argv + argc, 1, 0);
=20
 	if (dest_path[0][0] =3D=3D '\0')
 		/* special case: "." was normalized to "" */
-		destination =3D copy_pathspec(dest_path[0], argv, argc, 1);
+		destination =3D internal_copy_pathspec(dest_path[0], argv, argc, 1);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
 		dest_path[0] =3D add_slash(dest_path[0]);
-		destination =3D copy_pathspec(dest_path[0], argv, argc, 1);
+		destination =3D internal_copy_pathspec(dest_path[0], argv, argc, 1);
 	} else {
 		if (argc !=3D 1)
 			die("destination '%s' is not a directory", dest_path[0]);
diff --git a/pathspec.c b/pathspec.c
index 403095b..8fe56cd 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -249,3 +249,11 @@ const char **get_pathspec(const char *prefix, cons=
t char **pathspec)
 		return NULL;
 	return pathspec;
 }
+
+void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
+{
+	*dst =3D *src;
+	dst->items =3D xmalloc(sizeof(struct pathspec_item) * dst->nr);
+	memcpy(dst->items, src->items,
+	       sizeof(struct pathspec_item) * dst->nr);
+}
diff --git a/pathspec.h b/pathspec.h
index 7884068..a621676 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -18,6 +18,7 @@ struct pathspec {
 };
=20
 extern int init_pathspec(struct pathspec *, const char **);
+extern void copy_pathspec(struct pathspec *dst, const struct pathspec =
*src);
 extern void free_pathspec(struct pathspec *);
=20
 extern int limit_pathspec_to_literal(void);
--=20
1.8.2.83.gc99314b
