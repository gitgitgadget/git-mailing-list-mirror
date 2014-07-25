From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] refs.c: move ref parsing code out of resolve_ref()
Date: Fri, 25 Jul 2014 17:43:58 +0700
Message-ID: <1406285039-22469-4-git-send-email-pclouds@gmail.com>
References: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:44:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAczU-0004K2-IO
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 12:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760173AbaGYKob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 06:44:31 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47118 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759993AbaGYKoa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 06:44:30 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so5877878pab.19
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZQEgP0N8DgFY78QRewRtbTD3xA8M9cJ411vS16rtf+Q=;
        b=DkSmTxEICPA/nZw8Yiq9NNjI2TSU2fPr9lKj73t9QHYpMg80Di5KzAO870FmMgLOey
         OfbJVF9cYAVrsNgH94w3UTpIuzRzM9eEDwuG1LNFVcT1PbW1ilqZLKNkFXbNk32HWczQ
         2nQbpZ27cTD7JF75dxvrHKc/zCgZz1n+LxpPdIDL9Yvd6GFA4V1na7XEXdJuyN9g1fd/
         ETfjPepQW4zaqHh4mq0ktZ0PkeasZO/Fr4RQmwMM3UtwEhImxmiaLhEhZqIhw92evoYB
         5qnGTc/EPfNP1vDsYsGIYMwig2Sd25jf9Np5LJrakXZDfUCzA+oiQXMzE9gJWlqVAQUa
         FkEQ==
X-Received: by 10.70.101.163 with SMTP id fh3mr17584363pdb.57.1406285069459;
        Fri, 25 Jul 2014 03:44:29 -0700 (PDT)
Received: from lanh ([115.73.251.194])
        by mx.google.com with ESMTPSA id nx12sm11143886pdb.81.2014.07.25.03.44.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jul 2014 03:44:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 25 Jul 2014 17:44:26 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254206>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  11 ++++
 refs.c  | 204 ++++++++++++++++++++++++++++++++++----------------------=
--------
 2 files changed, 120 insertions(+), 95 deletions(-)

diff --git a/cache.h b/cache.h
index 5ffbafb..40a63d9 100644
--- a/cache.h
+++ b/cache.h
@@ -1003,6 +1003,17 @@ extern int read_ref(const char *refname, unsigne=
d char *sha1);
 extern const char *resolve_ref_unsafe(const char *ref, unsigned char *=
sha1, int reading, int *flag);
 extern char *resolve_refdup(const char *ref, unsigned char *sha1, int =
reading, int *flag);
 extern int resolve_ref(const char *refname, struct strbuf *result, uns=
igned char *sha1, int reading, int *flag);
+/*
+ * Given a ref in "ref" and its path, returns
+ *
+ * -2  failed to open with ENOENT, the caller is responsible for
+ *     checking missing loose ref (see resolve_ref for example)
+ * -1  if there's an error, "ref" can no longer be trusted, "flag" may
+ *     be set. errno is valid.
+ *  0  this is a symref, "ref" now contains the linked ref
+ * +1  normal ref, "sha1" is valid
+ */
+extern int parse_ref(const char *path, struct strbuf *ref, unsigned ch=
ar *sha1, int *flag);
=20
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, cha=
r **ref);
diff --git a/refs.c b/refs.c
index bec2bb1..2769f20 100644
--- a/refs.c
+++ b/refs.c
@@ -1533,6 +1533,105 @@ static int handle_missing_loose_ref(const char =
*refname,
 	}
 }
=20
+int parse_ref(const char *path, struct strbuf *ref,
+	      unsigned char *sha1, int *flag)
+{
+	struct strbuf buffer =3D STRBUF_INIT;
+	struct stat st;
+	const char *buf;
+
+	/*
+	 * We might have to loop back here to avoid a race condition:
+	 * first we lstat() the file, then we try to read it as a link
+	 * or as a file.  But if somebody changes the type of the file
+	 * (file <-> directory <-> symlink) between the lstat() and
+	 * reading, then we don't want to report that as an error but
+	 * rather try again starting with the lstat().
+	 */
+stat_ref:
+	if (lstat(path, &st) < 0)
+		return errno =3D=3D ENOENT ? -2 : -1;
+
+	/* Follow "normalized" - ie "refs/.." symlinks by hand */
+	if (S_ISLNK(st.st_mode)) {
+		struct strbuf new_path =3D STRBUF_INIT;
+		if (strbuf_readlink(&new_path, path, 256) < 0) {
+			strbuf_release(&new_path);
+			if (errno =3D=3D ENOENT || errno =3D=3D EINVAL)
+				/* inconsistent with lstat; retry */
+				goto stat_ref;
+			else
+				return -1;
+		}
+		if (starts_with(new_path.buf, "refs/") &&
+		    !check_refname_format(new_path.buf, 0)) {
+			strbuf_reset(ref);
+			strbuf_addbuf(ref, &new_path);
+			if (flag)
+				*flag |=3D REF_ISSYMREF;
+			strbuf_release(&new_path);
+			return 0;
+		}
+		strbuf_release(&new_path);
+	}
+
+	/* Is it a directory? */
+	if (S_ISDIR(st.st_mode)) {
+		errno =3D EISDIR;
+		return -1;
+	}
+
+	/*
+	 * Anything else, just open it and try to use it as
+	 * a ref
+	 */
+	if (strbuf_read_file(&buffer, path, 256) < 0) {
+		strbuf_release(&buffer);
+		if (errno =3D=3D ENOENT)
+			/* inconsistent with lstat; retry */
+			goto stat_ref;
+		else
+			return -1;
+	}
+	strbuf_rtrim(&buffer);
+
+	/*
+	 * Is it a symbolic ref?
+	 */
+	if (!skip_prefix(buffer.buf, "ref:", &buf)) {
+		int ret;
+		/*
+		 * Please note that FETCH_HEAD has a second line
+		 * containing other data.
+		 */
+		if (get_sha1_hex(buffer.buf, sha1) ||
+		    (buffer.buf[40] !=3D '\0' && !isspace(buffer.buf[40]))) {
+			if (flag)
+				*flag |=3D REF_ISBROKEN;
+			errno =3D EINVAL;
+			ret =3D -1;
+		} else
+			ret =3D 1;
+		strbuf_release(&buffer);
+		return ret;
+	}
+	if (flag)
+		*flag |=3D REF_ISSYMREF;
+	while (isspace(*buf))
+		buf++;
+	if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
+		if (flag)
+			*flag |=3D REF_ISBROKEN;
+		strbuf_release(&buffer);
+		errno =3D EINVAL;
+		return -1;
+	}
+	strbuf_reset(ref);
+	strbuf_addstr(ref, buf);
+	strbuf_release(&buffer);
+	return 0;
+}
+
 /*
  * 'result' content will be destroyed. Its value may be undefined if
  * resolve_ref returns -1.
@@ -1542,9 +1641,8 @@ static int handle_missing_loose_ref(const char *r=
efname,
 int resolve_ref(const char *refname, struct strbuf *result,
 		unsigned char *sha1, int reading, int *flag)
 {
-	struct strbuf buffer =3D STRBUF_INIT;
 	int depth =3D MAXDEPTH;
-	int ret =3D -1;
+	int ret =3D 0;
=20
 	if (flag)
 		*flag =3D 0;
@@ -1557,108 +1655,24 @@ int resolve_ref(const char *refname, struct st=
rbuf *result,
 	strbuf_reset(result);
 	strbuf_addstr(result, refname);
=20
-	for (;;) {
+	while (!ret) {
 		char path[PATH_MAX];
-		const char *ref =3D result->buf;
-		struct stat st;
-		const char *buf;
=20
 		if (--depth < 0) {
 			errno =3D ELOOP;
+			ret =3D -1;
 			break;
 		}
=20
-		git_snpath(path, sizeof(path), "%s", ref);
-
-		/*
-		 * We might have to loop back here to avoid a race
-		 * condition: first we lstat() the file, then we try
-		 * to read it as a link or as a file.  But if somebody
-		 * changes the type of the file (file <-> directory
-		 * <-> symlink) between the lstat() and reading, then
-		 * we don't want to report that as an error but rather
-		 * try again starting with the lstat().
-		 */
-	stat_ref:
-		if (lstat(path, &st) < 0) {
-			if (errno =3D=3D ENOENT)
-				ret =3D handle_missing_loose_ref(ref, sha1,
-							       reading, flag);
-			break;
+		git_snpath(path, sizeof(path), "%s", result->buf);
+		ret =3D parse_ref(path, result, sha1, flag);
+		if (ret =3D=3D -2) {
+			ret =3D handle_missing_loose_ref(result->buf, sha1,
+						       reading, flag);
+			ret =3D ret ? -1 : 1;
 		}
-
-		/* Follow "normalized" - ie "refs/.." symlinks by hand */
-		if (S_ISLNK(st.st_mode)) {
-			/* no need to reset buffer, strbuf_readlink does that */
-			if (strbuf_readlink(&buffer, path, 256) < 0) {
-				if (errno =3D=3D ENOENT || errno =3D=3D EINVAL)
-					/* inconsistent with lstat; retry */
-					goto stat_ref;
-				else
-					break;
-			}
-			if (starts_with(buffer.buf, "refs/") &&
-			    !check_refname_format(buffer.buf, 0)) {
-				strbuf_reset(result);
-				strbuf_addbuf(result, &buffer);
-				if (flag)
-					*flag |=3D REF_ISSYMREF;
-				continue;
-			}
-		}
-
-		/* Is it a directory? */
-		if (S_ISDIR(st.st_mode)) {
-			errno =3D EISDIR;
-			break;
-		}
-
-		/*
-		 * Anything else, just open it and try to use it as
-		 * a ref
-		 */
-		strbuf_reset(&buffer);
-		if (strbuf_read_file(&buffer, path, 256) < 0) {
-			if (errno =3D=3D ENOENT)
-				/* inconsistent with lstat; retry */
-				goto stat_ref;
-			else
-				break;
-		}
-		strbuf_rtrim(&buffer);
-
-		/*
-		 * Is it a symbolic ref?
-		 */
-		if (!skip_prefix(buffer.buf, "ref:", &buf)) {
-			/*
-			 * Please note that FETCH_HEAD has a second
-			 * line containing other data.
-			 */
-			if (get_sha1_hex(buffer.buf, sha1) ||
-			    (buffer.buf[40] !=3D '\0' && !isspace(buffer.buf[40]))) {
-				if (flag)
-					*flag |=3D REF_ISBROKEN;
-				errno =3D EINVAL;
-			} else
-				ret =3D 0;
-			break;
-		}
-		if (flag)
-			*flag |=3D REF_ISSYMREF;
-		while (isspace(*buf))
-			buf++;
-		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-			if (flag)
-				*flag |=3D REF_ISBROKEN;
-			errno =3D EINVAL;
-			break;
-		}
-		strbuf_reset(result);
-		strbuf_addstr(result, buf);
 	}
-	strbuf_release(&buffer);
-	return ret;
+	return ret > 0 ? 0 : -1;
 }
=20
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha=
1, int reading, int *flag)
--=20
1.9.1.346.ga2b5940
