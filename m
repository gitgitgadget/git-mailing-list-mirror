From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Thu, 17 Nov 2011 16:32:15 +0700
Message-ID: <1321522335-24193-9-git-send-email-pclouds@gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 10:29:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQyI1-0002wU-2w
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 10:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab1KQJ3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 04:29:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44094 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab1KQJ3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 04:29:44 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so1839093iag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 01:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=F35XuCiq816DbWkeszIlnof0wZreqy8y3A+XgPl0L+o=;
        b=AGakKhfCOuertIJAObGTZUTaejmJTYHe6ICxbC/ehpipf7bG+R4Cx+3PDYVTpGHtVL
         fOafg3W6TG1ARsI69gHSDPj1vqmCB/azTiCE+qiGUffQUyL2/da7WYaJOlAKTdCquzft
         0GQThbad72L8z8wDX/aK2jVnmalOQivkdJxLA=
Received: by 10.42.151.196 with SMTP id f4mr40329181icw.17.1321522184534;
        Thu, 17 Nov 2011 01:29:44 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id el2sm55704300ibb.10.2011.11.17.01.29.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:29:43 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 17 Nov 2011 16:33:20 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185588>

Make git_pathname() use xmalloc_mmap/xfree_mmap to catch invalid access
to old buffer when it's already overwritten.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |   11 +++++++----
 path.c  |   28 +++++++++++++++++++---------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index feb44a5..66365fb 100644
--- a/cache.h
+++ b/cache.h
@@ -661,10 +661,13 @@ extern char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
=20
 /* Return a statically allocated filename matching the sha1 signature =
*/
-extern char *mkpath(const char *fmt, ...) __attribute__((format (print=
f, 1, 2)));
-extern char *git_path(const char *fmt, ...) __attribute__((format (pri=
ntf, 1, 2)));
-extern char *git_path_submodule(const char *path, const char *fmt, ...=
)
-	__attribute__((format (printf, 2, 3)));
+#define mkpath(...) mkpath_real(__FUNCTION__, __LINE__, __VA_ARGS__)
+extern char *mkpath_real(const char *file, int line, const char *fmt, =
=2E..) __attribute__((format (printf, 3, 4)));
+#define git_path( ...) git_path_real(__FUNCTION__, __LINE__, __VA_ARGS=
__)
+extern char *git_path_real(const char *file, int line, const char *fmt=
, ...) __attribute__((format (printf, 3, 4)));
+#define git_path_submodule(path, ...) git_path_submodule_real(__FUNCTI=
ON__, __LINE__, path, __VA_ARGS__)
+extern char *git_path_submodule_real(const char *file, int line, const=
 char *path, const char *fmt, ...)
+	__attribute__((format (printf, 4, 5)));
=20
 extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
diff --git a/path.c b/path.c
index b6f71d1..d2aa941 100644
--- a/path.c
+++ b/path.c
@@ -15,11 +15,21 @@
=20
 static char bad_path[] =3D "/bad-path/";
=20
-static char *get_pathname(void)
+static char *get_pathname(const char *file, int line)
 {
-	static char pathname_array[4][PATH_MAX];
+	static char real_pathname_array[4][PATH_MAX];
+	static char *pathname_array[4];
 	static int index;
-	return pathname_array[3 & ++index];
+	int idx =3D 3 & ++index;
+
+	if (!pathname_array[idx] && !getenv("GIT_DEBUG_MEMCHECK"))
+		pathname_array[idx] =3D real_pathname_array[idx];
+
+	if (pathname_array[idx] !=3D real_pathname_array[idx]) {
+		xfree_mmap(pathname_array[idx]);
+		pathname_array[idx] =3D xmalloc_mmap(PATH_MAX, file, line);
+	}
+	return pathname_array[idx];
 }
=20
 static char *cleanup_path(char *path)
@@ -87,11 +97,11 @@ char *git_pathdup(const char *fmt, ...)
 	return xstrdup(path);
 }
=20
-char *mkpath(const char *fmt, ...)
+char *mkpath_real(const char *file, int line, const char *fmt, ...)
 {
 	va_list args;
 	unsigned len;
-	char *pathname =3D get_pathname();
+	char *pathname =3D get_pathname(file, line);
=20
 	va_start(args, fmt);
 	len =3D vsnprintf(pathname, PATH_MAX, fmt, args);
@@ -101,10 +111,10 @@ char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname);
 }
=20
-char *git_path(const char *fmt, ...)
+char *git_path_real(const char *file, int line, const char *fmt, ...)
 {
 	const char *git_dir =3D get_git_dir();
-	char *pathname =3D get_pathname();
+	char *pathname =3D get_pathname(file, line);
 	va_list args;
 	unsigned len;
=20
@@ -122,9 +132,9 @@ char *git_path(const char *fmt, ...)
 	return cleanup_path(pathname);
 }
=20
-char *git_path_submodule(const char *path, const char *fmt, ...)
+char *git_path_submodule_real(const char *file, int line, const char *=
path, const char *fmt, ...)
 {
-	char *pathname =3D get_pathname();
+	char *pathname =3D get_pathname(file, line);
 	struct strbuf buf =3D STRBUF_INIT;
 	const char *git_dir;
 	va_list args;
--=20
1.7.4.74.g639db
