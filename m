From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 01/28] path.c: make get_pathname() return strbuf instead of static buffer
Date: Sat,  8 Mar 2014 09:47:53 +0700
Message-ID: <1394246900-31535-2-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:48:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7JQ-0004nV-NG
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbaCHCsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:48:06 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:59860 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbaCHCsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:48:00 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so4815014pdi.35
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KjaE0zoB5bLf8O3d3LzNI6IG1LdksgxmdAqlYZgZr7U=;
        b=ub/fP0aaXo110Zq4xmXCXUh3oevFRvY26vU+1EjS2ohO9j6GO8FocV3hChDGwkCsN0
         tETxWsrTqe/wAoOs031eHGlU2iARpfd9DNGUv4bWV5/d8oVSil+UyS499BuJBUf0Btvc
         Qo5GGqjesZmE37C/qYPZeLtsfhi07DsJwWaRe0T8iWNICOTCpMwiUFdnugEhHeN8hxb+
         SwgPLy9DfaA0yFghuYxwkDORjlBnUD6VN15bslrq8kIf+udvUaGDlgU4I+WtE96DWBMr
         3rvmabA7NPuKkVX6uBZM2fjk9ITrhcuZRNDHjoRmA9YSx/3o1OniMb5T8uqrtVtPoT8y
         dyxg==
X-Received: by 10.66.155.102 with SMTP id vv6mr26015387pab.89.1394246879958;
        Fri, 07 Mar 2014 18:47:59 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id ac5sm42476070pbc.37.2014.03.07.18.47.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:47:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:48:32 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243642>

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
---
 path.c | 120 ++++++++++++++++++++++++++++-----------------------------=
--------
 1 file changed, 51 insertions(+), 69 deletions(-)

diff --git a/path.c b/path.c
index 24594c4..5346700 100644
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
1.9.0.40.gaa8c3ea
