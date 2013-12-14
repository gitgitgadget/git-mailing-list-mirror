From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/21] setup.c: add split-repo support to .git files
Date: Sat, 14 Dec 2013 17:54:55 +0700
Message-ID: <1387018507-21999-10-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Dec 14 11:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrmpP-000121-4s
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab3LNKwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:52:06 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:59872 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKwF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:52:05 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so3482219pde.21
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=T+oZqjuyx0wSvvKmZm2DuCkgIZw3u+Q8X2aRIC0i7Ok=;
        b=Nc90x8wK/1k/8jX2+mxhsic3x/WnC/5OS/JuTfDYwgfl7JuZNzHj/l2QpdkBYyjhyA
         Har4jfCCojzaLH1WEAfp1witAfOZiEsObIBinoET7COJuBci0W9hrTwBemEOC/lu6G1K
         Rb5f4uiI+51q1Lj6qax/jnJ2ltrAS6eSKVLh+4htN3g3+iQM0x4EPX8CoL9u1iNs5Nv1
         yRy8vJKY3y6B6g0CgLIdmK/jIACjkPKymlMnVFCnhaaTeI74KzfBbe2CIkEd6uTzB2Lk
         dCZyEuEf0x6gsnSZ6DSd2ZU0kJ4hE5gJvMKxdeJNZRUwNWHq9dgZ8Ure1iN7UsxjLjoz
         fhqg==
X-Received: by 10.66.248.227 with SMTP id yp3mr8664241pac.116.1387018325118;
        Sat, 14 Dec 2013 02:52:05 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id ql10sm11394321pbc.44.2013.12.14.02.52.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:52:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:56:57 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239291>

If a .git file contains

gitsuper: <path>
gitdir: <id>

then we set GIT_SUPER_DIR to <path> and GIT_DIR to
$GIT_SUPER_DIR/repos/<id>.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  1 +
 setup.c | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 823582f..f85ee70 100644
--- a/cache.h
+++ b/cache.h
@@ -410,6 +410,7 @@ extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile(const char *path);
+extern const char *read_gitfile_super(const char *path, char **super);
 extern const char *resolve_gitdir(const char *suspect);
 extern void set_git_work_tree(const char *tree);
=20
diff --git a/setup.c b/setup.c
index c040981..e9f0ef6 100644
--- a/setup.c
+++ b/setup.c
@@ -299,14 +299,20 @@ static char *path_from_gitfile(const char *path, =
const char *buf, int len)
 /*
  * Try to read the location of the git directory from the .git file,
  * return path to git directory if found.
+ *
+ * If "gitsuper: " line is found and super is not NULL, *super points
+ * to the absolute path of the given path. The next line contains the
+ * repo id.
  */
-const char *read_gitfile(const char *path)
+const char *read_gitfile_super(const char *path, char **super)
 {
 	char *buf, *dir;
 	struct stat st;
 	int fd;
 	ssize_t len;
=20
+	if (super)
+		*super =3D NULL;
 	if (stat(path, &st))
 		return NULL;
 	if (!S_ISREG(st.st_mode))
@@ -323,9 +329,30 @@ const char *read_gitfile(const char *path)
 		len--;
 	buf[len] =3D '\0';
=20
-	if (prefixcmp(buf, "gitdir: "))
-		die("Invalid gitfile format: %s", path);
-	dir =3D path_from_gitfile(path, buf + 8, len - 8);
+	if (super && !prefixcmp(buf, "gitsuper: ")) {
+		char *p =3D buf, *end =3D buf + len;
+		while (p < end && *p !=3D '\n' && *p !=3D '\r')
+			p++;
+		if (p =3D=3D end)
+			die("Invalid gitfile format: %s", path);
+		*super =3D buf + strlen("gitsuper: ");
+		*p =3D '\0';
+		*super =3D path_from_gitfile(path, *super, p - *super);
+		p++;
+		while (p < end && (*p =3D=3D '\n' || *p =3D=3D '\r'))
+			p++;
+		if (prefixcmp(p, "gitdir: "))
+			die("Invalid gitfile format: %s", path);
+		p +=3D 8;
+		if (p =3D=3D end)
+			die("Invalid gitfile format: %s", path);
+		dir =3D xmalloc(strlen(*super) + strlen("/repos/") + (end - p) + 1);
+		sprintf(dir, "%s/repos/%s", *super, p);
+	} else {
+		if (prefixcmp(buf, "gitdir: "))
+			die("Invalid gitfile format: %s", path);
+		dir =3D path_from_gitfile(path, buf + 8, len - 8);
+	}
=20
 	if (!is_git_directory(dir))
 		die("Not a git repository: %s", dir);
@@ -336,6 +363,12 @@ const char *read_gitfile(const char *path)
 	return path;
 }
=20
+const char *read_gitfile(const char *path)
+{
+	return read_gitfile_super(path, NULL);
+}
+
+
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 					  char *cwd, int len,
 					  int *nongit_ok)
--=20
1.8.5.1.77.g42c48fa
