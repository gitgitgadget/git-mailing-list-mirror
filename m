From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/21] path.c: avoid PATH_MAX as buffer size from get_pathname()
Date: Sat, 14 Dec 2013 17:54:47 +0700
Message-ID: <1387018507-21999-2-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:51:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmp1-0000uB-Fs
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab3LNKvb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:51:31 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58080 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab3LNKvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:51:15 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so1055715pad.40
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dl7y+g8/nxKIT2mVkOSga6pMokHStfjkz3qfeqG4YfI=;
        b=ydCLSu1aUkgDIRW0QyeU6SdEr0Lhoy7+mWg+KXQYlP7nYAUa1VwWqB7x2m/baGGPY0
         ETZbkrEAt33NzCy+4qyMMWySmImjDdAqrPUQpChFnCUxIhpbs+0OuW3Gk3oXkkDRdCLd
         1kxM7RzZgW6DoVZJ9b3nUb019VP1zR5fQvNAqMv1pG6KBxLg5DJhtYPW8wNIzXbZFOs0
         8K2ZmEpf2dEwzQmozz2yopXl6qUUP4NVxyY/cdpWY+fo7LSYROQIM57baKLWBgDgk7ae
         DT1SPRUFi1yB+W8IjpH7IT1Z+T3MpyD+KBNO4ru8edHH9ATtI4u/eTeEH580m5m6PWE7
         3ZvQ==
X-Received: by 10.66.216.129 with SMTP id oq1mr8613315pac.75.1387018274744;
        Sat, 14 Dec 2013 02:51:14 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id qz9sm11437744pbc.3.2013.12.14.02.51.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:51:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:56:07 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239286>

We've been avoiding PATH_MAX whenever possible. This patch avoids
PATH_MAX in get_pathname() and gives it enough room not to worry about
really long paths.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/path.c b/path.c
index 24594c4..4c1c144 100644
--- a/path.c
+++ b/path.c
@@ -16,10 +16,11 @@ static int get_st_mode_bits(const char *path, int *=
mode)
=20
 static char bad_path[] =3D "/bad-path/";
=20
-static char *get_pathname(void)
+static char *get_pathname(size_t *len)
 {
-	static char pathname_array[4][PATH_MAX];
+	static char pathname_array[4][4096];
 	static int index;
+	*len =3D sizeof(pathname_array[0]);
 	return pathname_array[3 & ++index];
 }
=20
@@ -108,24 +109,26 @@ char *mkpath(const char *fmt, ...)
 {
 	va_list args;
 	unsigned len;
-	char *pathname =3D get_pathname();
+	size_t n;
+	char *pathname =3D get_pathname(&n);
=20
 	va_start(args, fmt);
-	len =3D vsnprintf(pathname, PATH_MAX, fmt, args);
+	len =3D vsnprintf(pathname, n, fmt, args);
 	va_end(args);
-	if (len >=3D PATH_MAX)
+	if (len >=3D n)
 		return bad_path;
 	return cleanup_path(pathname);
 }
=20
 char *git_path(const char *fmt, ...)
 {
-	char *pathname =3D get_pathname();
+	size_t len;
+	char *pathname =3D get_pathname(&len);
 	va_list args;
 	char *ret;
=20
 	va_start(args, fmt);
-	ret =3D vsnpath(pathname, PATH_MAX, fmt, args);
+	ret =3D vsnpath(pathname, len, fmt, args);
 	va_end(args);
 	return ret;
 }
@@ -158,14 +161,15 @@ void home_config_paths(char **global, char **xdg,=
 char *file)
=20
 char *git_path_submodule(const char *path, const char *fmt, ...)
 {
-	char *pathname =3D get_pathname();
+	size_t n;
+	char *pathname =3D get_pathname(&n);
 	struct strbuf buf =3D STRBUF_INIT;
 	const char *git_dir;
 	va_list args;
 	unsigned len;
=20
 	len =3D strlen(path);
-	if (len > PATH_MAX-100)
+	if (len > n-100)
 		return bad_path;
=20
 	strbuf_addstr(&buf, path);
@@ -180,7 +184,7 @@ char *git_path_submodule(const char *path, const ch=
ar *fmt, ...)
 	}
 	strbuf_addch(&buf, '/');
=20
-	if (buf.len >=3D PATH_MAX)
+	if (buf.len >=3D n)
 		return bad_path;
 	memcpy(pathname, buf.buf, buf.len + 1);
=20
@@ -188,9 +192,9 @@ char *git_path_submodule(const char *path, const ch=
ar *fmt, ...)
 	len =3D strlen(pathname);
=20
 	va_start(args, fmt);
-	len +=3D vsnprintf(pathname + len, PATH_MAX - len, fmt, args);
+	len +=3D vsnprintf(pathname + len, n - len, fmt, args);
 	va_end(args);
-	if (len >=3D PATH_MAX)
+	if (len >=3D n)
 		return bad_path;
 	return cleanup_path(pathname);
 }
--=20
1.8.5.1.77.g42c48fa
