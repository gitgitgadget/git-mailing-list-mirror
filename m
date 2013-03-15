From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 05/45] pathspec: add copy_pathspec
Date: Fri, 15 Mar 2013 13:06:20 +0700
Message-ID: <1363327620-29017-6-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:25:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO4g-0003xW-4A
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644Ab3COGYi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:24:38 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:49216 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab3COGYh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:24:37 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so4003642ieb.34
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=A6mE9Nb5XWofkZpzov7F/PXTs2oKioX2N3Iqq0AbTvU=;
        b=K7XIvEFvndh7xSbHANlLQuhFuovIBcXcbRwDyChEontOdzirNS8B5H1Scwc7C+GE/4
         HMRmqYwla+fqCzQVN0IZ+n+WUAmzZc8MAKaYLzS61ETjZbgD5Sg3raPkXKON5vgZkN/k
         5OdLq/rgOczoSTvYu7fDpaQnKNla5AktXD5/HL8egAleseCSG1GcnitzdnPMmwk2XnVo
         E2TA3GxYafZyLLIzjBYGJalXw3iw0tPdkaJNnBeAMNGwHK2nMHhj+DkCc8CbstEfbKpv
         r1htxguqzsqUKWy1+11On0gVxlV4ojFrn+APmGKxsGE0vseN1Xq9Cx74VcEfVBWGskZN
         lLGA==
X-Received: by 10.42.91.209 with SMTP id q17mr3868247icm.50.1363328676919;
        Thu, 14 Mar 2013 23:24:36 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ua6sm631999igb.0.2013.03.14.23.24.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:24:36 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:07:39 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218192>

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
index 94d64d2..ab53b8a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -248,3 +248,11 @@ const char **get_pathspec(const char *prefix, cons=
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
1.8.0.rc0.19.g7bbb31d
