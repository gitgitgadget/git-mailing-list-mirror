From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/32] path.c: make get_pathname() return strbuf instead of static buffer
Date: Sat, 30 Aug 2014 15:33:31 +0700
Message-ID: <1409387642-24492-2-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:34:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe6x-0001BU-Eo
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbaH3IeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:34:07 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:57505 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaH3IeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:34:04 -0400
Received: by mail-pa0-f47.google.com with SMTP id hz1so8194938pad.34
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YXHEEImvPpden93A8Z+iOWK0BmSFl5pSrcAHOXSI76k=;
        b=wwbZ4ts+SRDDulssR04LorM0moHYTur9M+rl7J9LuX7ZSr8xv5jh9Qk5ReMVG4xDrf
         TRA/HBQjzLPWVWnbbAOd9MWL4YZhntUJdz+lCIOnLynSWUKCuOGDsFuX9dXXbuZq1M6o
         zuSI73cRA2R4e/4qQdWZnUkIwxxZJekU+j+OMN6plblXcZDV4jPdl6TI/USPB3g9jAAJ
         8MLdegZG3yf69hkTvGel9mxZxHbM6BJ9pBxwkeJgp04irzLvDZy8EHfy59d+TpF++cWq
         B7mEJXGMHK62xqrDy6TNDkVoUavgf9bLDAGE0pEwzyfjKtwvkjtEMRT44Y1IEwMg9EuQ
         BoxA==
X-Received: by 10.66.182.130 with SMTP id ee2mr22673934pac.48.1409387643085;
        Sat, 30 Aug 2014 01:34:03 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id q1sm3146970pdq.67.2014.08.30.01.34.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:34:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:34:12 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256211>

We've been avoiding PATH_MAX whenever possible. This patch makes
get_pathname() return a strbuf and updates the callers to take
advantage of this. The code is simplified as we no longer need to
worry about buffer overflow.

vsnpath() behavior is changed slightly: previously it always clears
the buffer before writing, now it just appends. Fortunately this is a
static function and all of its callers prepare the buffer properly:
git_path() gets the buffer from get_pathname() which resets the
buffer, the remaining call sites start with STRBUF_INIT'd buffer.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c | 120 ++++++++++++++++++++++++++++-----------------------------=
--------
 1 file changed, 51 insertions(+), 69 deletions(-)

diff --git a/path.c b/path.c
index bc804a3..42ef3af 100644
--- a/path.c
+++ b/path.c
@@ -16,11 +16,15 @@ static int get_st_mode_bits(const char *path, int *=
mode)
=20
 static char bad_path[] =3D "/bad-path/";
=20
-static char *get_pathname(void)
+static struct strbuf *get_pathname(void)
 {
-	static char pathname_array[4][PATH_MAX];
+	static struct strbuf pathname_array[4] =3D {
+		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
+	};
 	static int index;
-	return pathname_array[3 & ++index];
+	struct strbuf *sb =3D &pathname_array[3 & ++index];
+	strbuf_reset(sb);
+	return sb;
 }
=20
 static char *cleanup_path(char *path)
@@ -34,6 +38,13 @@ static char *cleanup_path(char *path)
 	return path;
 }
=20
+static void strbuf_cleanup_path(struct strbuf *sb)
+{
+	char *path =3D cleanup_path(sb->buf);
+	if (path > sb->buf)
+		strbuf_remove(sb, 0, path - sb->buf);
+}
+
 char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 {
 	va_list args;
@@ -49,85 +60,70 @@ char *mksnpath(char *buf, size_t n, const char *fmt=
, ...)
 	return cleanup_path(buf);
 }
=20
-static char *vsnpath(char *buf, size_t n, const char *fmt, va_list arg=
s)
+static void vsnpath(struct strbuf *buf, const char *fmt, va_list args)
 {
 	const char *git_dir =3D get_git_dir();
-	size_t len;
-
-	len =3D strlen(git_dir);
-	if (n < len + 1)
-		goto bad;
-	memcpy(buf, git_dir, len);
-	if (len && !is_dir_sep(git_dir[len-1]))
-		buf[len++] =3D '/';
-	len +=3D vsnprintf(buf + len, n - len, fmt, args);
-	if (len >=3D n)
-		goto bad;
-	return cleanup_path(buf);
-bad:
-	strlcpy(buf, bad_path, n);
-	return buf;
+	strbuf_addstr(buf, git_dir);
+	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
+		strbuf_addch(buf, '/');
+	strbuf_vaddf(buf, fmt, args);
+	strbuf_cleanup_path(buf);
 }
=20
 char *git_snpath(char *buf, size_t n, const char *fmt, ...)
 {
-	char *ret;
+	struct strbuf sb =3D STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	ret =3D vsnpath(buf, n, fmt, args);
+	vsnpath(&sb, fmt, args);
 	va_end(args);
-	return ret;
+	if (sb.len >=3D n)
+		strlcpy(buf, bad_path, n);
+	else
+		memcpy(buf, sb.buf, sb.len + 1);
+	strbuf_release(&sb);
+	return buf;
 }
=20
 char *git_pathdup(const char *fmt, ...)
 {
-	char path[PATH_MAX], *ret;
+	struct strbuf path =3D STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	ret =3D vsnpath(path, sizeof(path), fmt, args);
+	vsnpath(&path, fmt, args);
 	va_end(args);
-	return xstrdup(ret);
+	return strbuf_detach(&path, NULL);
 }
=20
 char *mkpathdup(const char *fmt, ...)
 {
-	char *path;
 	struct strbuf sb =3D STRBUF_INIT;
 	va_list args;
-
 	va_start(args, fmt);
 	strbuf_vaddf(&sb, fmt, args);
 	va_end(args);
-	path =3D xstrdup(cleanup_path(sb.buf));
-
-	strbuf_release(&sb);
-	return path;
+	strbuf_cleanup_path(&sb);
+	return strbuf_detach(&sb, NULL);
 }
=20
 char *mkpath(const char *fmt, ...)
 {
 	va_list args;
-	unsigned len;
-	char *pathname =3D get_pathname();
-
+	struct strbuf *pathname =3D get_pathname();
 	va_start(args, fmt);
-	len =3D vsnprintf(pathname, PATH_MAX, fmt, args);
+	strbuf_vaddf(pathname, fmt, args);
 	va_end(args);
-	if (len >=3D PATH_MAX)
-		return bad_path;
-	return cleanup_path(pathname);
+	return cleanup_path(pathname->buf);
 }
=20
 char *git_path(const char *fmt, ...)
 {
-	char *pathname =3D get_pathname();
+	struct strbuf *pathname =3D get_pathname();
 	va_list args;
-	char *ret;
-
 	va_start(args, fmt);
-	ret =3D vsnpath(pathname, PATH_MAX, fmt, args);
+	vsnpath(pathname, fmt, args);
 	va_end(args);
-	return ret;
+	return pathname->buf;
 }
=20
 void home_config_paths(char **global, char **xdg, char *file)
@@ -158,41 +154,27 @@ void home_config_paths(char **global, char **xdg,=
 char *file)
=20
 char *git_path_submodule(const char *path, const char *fmt, ...)
 {
-	char *pathname =3D get_pathname();
-	struct strbuf buf =3D STRBUF_INIT;
+	struct strbuf *buf =3D get_pathname();
 	const char *git_dir;
 	va_list args;
-	unsigned len;
-
-	len =3D strlen(path);
-	if (len > PATH_MAX-100)
-		return bad_path;
=20
-	strbuf_addstr(&buf, path);
-	if (len && path[len-1] !=3D '/')
-		strbuf_addch(&buf, '/');
-	strbuf_addstr(&buf, ".git");
+	strbuf_addstr(buf, path);
+	if (buf->len && buf->buf[buf->len - 1] !=3D '/')
+		strbuf_addch(buf, '/');
+	strbuf_addstr(buf, ".git");
=20
-	git_dir =3D read_gitfile(buf.buf);
+	git_dir =3D read_gitfile(buf->buf);
 	if (git_dir) {
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, git_dir);
+		strbuf_reset(buf);
+		strbuf_addstr(buf, git_dir);
 	}
-	strbuf_addch(&buf, '/');
-
-	if (buf.len >=3D PATH_MAX)
-		return bad_path;
-	memcpy(pathname, buf.buf, buf.len + 1);
-
-	strbuf_release(&buf);
-	len =3D strlen(pathname);
+	strbuf_addch(buf, '/');
=20
 	va_start(args, fmt);
-	len +=3D vsnprintf(pathname + len, PATH_MAX - len, fmt, args);
+	strbuf_vaddf(buf, fmt, args);
 	va_end(args);
-	if (len >=3D PATH_MAX)
-		return bad_path;
-	return cleanup_path(pathname);
+	strbuf_cleanup_path(buf);
+	return buf->buf;
 }
=20
 int validate_headref(const char *path)
--=20
2.1.0.rc0.78.gc0d8480
