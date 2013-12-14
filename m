From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/21] setup.c: refactor path manipulation out of read_gitfile()
Date: Sat, 14 Dec 2013 17:54:54 +0700
Message-ID: <1387018507-21999-9-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Dec 14 11:52:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrmpJ-00010P-Ee
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab3LNKwA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:52:00 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:39390 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:51:59 -0500
Received: by mail-pa0-f49.google.com with SMTP id kx10so1042456pab.8
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8gOL6Jp4oelpDTrfBU0hnBR7dXu3VRKYarCC61tATZA=;
        b=imJaMwFM/1oYfLdX8xuJmG9pO8RPZHwR1SP7xruX8SYqHRHGWhRPVSpeoITyjPP4jP
         TJ6tT0+D99aIPlZi6Glny3sANcpCwJWQhJGbS7ekYOa7lM+UZpiQiUTTzBddUSZ8u4jz
         SIQP59ROpMx5MeQup9jJvAjvZHJXh1027WYPftbECwJdcpJZ4W+gpaxZD2KbsPCJOx0Y
         HJZ9A15j6wTi5G5K5l1rIFDi8LsDGVJfzQUwsxwHP3FkBmFAmrO6Ii4NpIHO071kjgr0
         qoSmSkvMDakk1b8gi74lqDv68NCIKIZ/DdClc93Hz1Jfe6eN7Jmih9OPiGFr2bD+H08v
         vWsw==
X-Received: by 10.68.224.138 with SMTP id rc10mr8823649pbc.19.1387018319145;
        Sat, 14 Dec 2013 02:51:59 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id er3sm11397824pbb.40.2013.12.14.02.51.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:51:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:56:51 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239290>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/setup.c b/setup.c
index 5432a31..c040981 100644
--- a/setup.c
+++ b/setup.c
@@ -278,15 +278,31 @@ static int check_repository_format_gently(const c=
har *gitdir, int *nongit_ok)
 	return 0;
 }
=20
+static char *path_from_gitfile(const char *path, const char *buf, int =
len)
+{
+	const char *slash;
+	if (len < 1)
+		die("No path in gitfile: %s", path);
+
+	if (!is_absolute_path(buf) && (slash =3D strrchr(path, '/'))) {
+		size_t pathlen =3D slash+1 - path;
+		size_t dirlen =3D pathlen + len;
+		char *p =3D xmalloc(dirlen + 1);
+		strncpy(p, path, pathlen);
+		strncpy(p + pathlen, buf, len);
+		p[dirlen] =3D '\0';
+		return p;
+	} else
+		return xmemdupz(buf, len);
+}
+
 /*
  * Try to read the location of the git directory from the .git file,
  * return path to git directory if found.
  */
 const char *read_gitfile(const char *path)
 {
-	char *buf;
-	char *dir;
-	const char *slash;
+	char *buf, *dir;
 	struct stat st;
 	int fd;
 	ssize_t len;
@@ -303,31 +319,19 @@ const char *read_gitfile(const char *path)
 	close(fd);
 	if (len !=3D st.st_size)
 		die("Error reading %s", path);
-	buf[len] =3D '\0';
-	if (prefixcmp(buf, "gitdir: "))
-		die("Invalid gitfile format: %s", path);
-	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
+	while (len > 0 && (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\=
r'))
 		len--;
-	if (len < 9)
-		die("No path in gitfile: %s", path);
 	buf[len] =3D '\0';
-	dir =3D buf + 8;
=20
-	if (!is_absolute_path(dir) && (slash =3D strrchr(path, '/'))) {
-		size_t pathlen =3D slash+1 - path;
-		size_t dirlen =3D pathlen + len - 8;
-		dir =3D xmalloc(dirlen + 1);
-		strncpy(dir, path, pathlen);
-		strncpy(dir + pathlen, buf + 8, len - 8);
-		dir[dirlen] =3D '\0';
-		free(buf);
-		buf =3D dir;
-	}
+	if (prefixcmp(buf, "gitdir: "))
+		die("Invalid gitfile format: %s", path);
+	dir =3D path_from_gitfile(path, buf + 8, len - 8);
=20
 	if (!is_git_directory(dir))
 		die("Not a git repository: %s", dir);
 	path =3D real_path(dir);
=20
+	free(dir);
 	free(buf);
 	return path;
 }
--=20
1.8.5.1.77.g42c48fa
