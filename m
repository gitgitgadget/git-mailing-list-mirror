From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/45] pathspec: add copy_pathspec
Date: Sun,  9 Jun 2013 13:25:37 +0700
Message-ID: <1370759178-1709-5-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:25:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ4A-00089q-AN
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab3FIGZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:25:19 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57834 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3FIGZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:25:18 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so2400973pad.14
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qvIXPA8Q/oR0C7dlEq9lUlfx3SC5y8ejt0PJjehb2fU=;
        b=ML2emV5vkL0z13UY1GMh9J3JIdI+RPKkQBioVp8XO6wNM5oI//RAP5Queg8u++SnkM
         XquDo/7Uzzxs8cMRO8UXP97MZRCUtmAoIsjkqwRKo/WZUDUNLywplZn4W8xXsqbSPBdS
         HmrrMambGIrb5bK2oZQ4vAQ/psmWhjvafTJH9m0VzX0AywRxVoC/QeZ3T4nhClNwjFEB
         Rvxx8vMBVx4np9OkSQn9lc6HeDv9xSi2ir4PtA+PX1NZxfVQfUuC0CbGh9ILWKGhrTis
         jwM6FEFIHfe6MqbZz2ryL2koz+4Vyk42vXQUmWwxTyn1mZP6OFF6ClzcT1cs2ftLQqPa
         8Ugw==
X-Received: by 10.68.65.134 with SMTP id x6mr5040624pbs.219.1370759117610;
        Sat, 08 Jun 2013 23:25:17 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id eq4sm10212840pad.16.2013.06.08.23.25.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:25:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:26:48 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226896>

The function is made to use with free_pathspec() because a simple
struct assignment is not enough (free_pathspec wants to free "items"
pointer).

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
