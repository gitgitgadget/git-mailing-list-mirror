From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/POC 3/7] setup.c: add split-repo support to .git files
Date: Wed, 11 Dec 2013 21:15:29 +0700
Message-ID: <1386771333-32574-4-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 15:11:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqkVK-0007bt-Cj
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 15:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab3LKOLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Dec 2013 09:11:05 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:62798 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3LKOLE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 09:11:04 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so9638933pdj.9
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 06:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YlPRoAZGdwgH/dgUl7472nHYyyGOolnYnzjBWWrO+B4=;
        b=zv4sMBPD49E+q8Mhag4riSR2fbwXBYLu56TJraYLXJ/BPwoAf3zQyZkfo37QFo1+tb
         fCs0XR5SSfkotFGVLSXVb6ssWQW8OEED4dibQWjOWOxLaCDWGSbZ8Xok7TmA0LACWvgL
         36k2jsSMHM5AiZ8pCTlzkJuEjPG+Ycb4NRqkf/iX6Beu3bJ+iXv8P/1c5KO97zrQ8zsW
         PcLyfuE2WwgWUZDpX0ekAxrqP8NruVckgbZse1R2cirhbdeKBhqu0K16HuqOQ/Vnpn4Q
         5rVGFkTppMXFJfZdjN4FK2NL/gtElCF9FkQoF46yMQdaG4lwuOn57dv//OcslTGhH4Kc
         O0XQ==
X-Received: by 10.66.255.39 with SMTP id an7mr1834628pad.7.1386771063929;
        Wed, 11 Dec 2013 06:11:03 -0800 (PST)
Received: from lanh ([115.73.201.231])
        by mx.google.com with ESMTPSA id yg3sm45412058pab.16.2013.12.11.06.11.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 06:11:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 11 Dec 2013 21:15:53 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239197>

If a .git file contains

gitsuper: <path>
gitdir: <id>

then we set GIT_SUPER_DIR to <path> and GIT_DIR to
$GIT_SUPER_DIR/repos/<id>.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  1 +
 setup.c | 40 +++++++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)

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
index 5432a31..84362a6 100644
--- a/setup.c
+++ b/setup.c
@@ -281,16 +281,23 @@ static int check_repository_format_gently(const c=
har *gitdir, int *nongit_ok)
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
-	char *buf;
+	struct strbuf sb =3D STRBUF_INIT;
+	char *buf, *to_free;
 	char *dir;
 	const char *slash;
 	struct stat st;
 	int fd;
 	ssize_t len;
=20
+	if (super)
+		*super =3D NULL;
 	if (stat(path, &st))
 		return NULL;
 	if (!S_ISREG(st.st_mode))
@@ -298,12 +305,19 @@ const char *read_gitfile(const char *path)
 	fd =3D open(path, O_RDONLY);
 	if (fd < 0)
 		die_errno("Error opening '%s'", path);
-	buf =3D xmalloc(st.st_size + 1);
+	to_free =3D buf =3D xmalloc(st.st_size + 1);
 	len =3D read_in_full(fd, buf, st.st_size);
 	close(fd);
 	if (len !=3D st.st_size)
 		die("Error reading %s", path);
 	buf[len] =3D '\0';
+	if (super &&!prefixcmp(buf, "gitsuper: ")) {
+		char *p =3D strchr(buf, '\n');
+		*super =3D buf + strlen("gitsuper: ");
+		*p =3D '\0';
+		len -=3D (p + 1) - buf;
+		buf =3D p + 1;
+	}
 	if (prefixcmp(buf, "gitdir: "))
 		die("Invalid gitfile format: %s", path);
 	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
@@ -312,6 +326,11 @@ const char *read_gitfile(const char *path)
 		die("No path in gitfile: %s", path);
 	buf[len] =3D '\0';
 	dir =3D buf + 8;
+	if (super && *super) {
+		strbuf_addf(&sb, "%s/repos/%s", *super, dir);
+		dir =3D sb.buf;
+		*super =3D xstrdup(real_path(*super));
+	}
=20
 	if (!is_absolute_path(dir) && (slash =3D strrchr(path, '/'))) {
 		size_t pathlen =3D slash+1 - path;
@@ -320,18 +339,25 @@ const char *read_gitfile(const char *path)
 		strncpy(dir, path, pathlen);
 		strncpy(dir + pathlen, buf + 8, len - 8);
 		dir[dirlen] =3D '\0';
-		free(buf);
-		buf =3D dir;
+		free(to_free);
+		to_free =3D buf =3D dir;
 	}
=20
-	if (!is_git_directory(dir))
+	if (!is_git_directory_super(dir, super ? *super : dir))
 		die("Not a git repository: %s", dir);
 	path =3D real_path(dir);
=20
-	free(buf);
+	free(to_free);
+	strbuf_release(&sb);
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
