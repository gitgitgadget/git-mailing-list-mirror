From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/21] setup.c: add split-repo support to is_git_directory()
Date: Sat, 14 Dec 2013 17:54:56 +0700
Message-ID: <1387018507-21999-11-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Dec 14 11:52:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrmpV-00015f-PL
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab3LNKwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:52:13 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:52340 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:52:12 -0500
Received: by mail-pa0-f54.google.com with SMTP id rd3so1056981pab.13
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=og7HogyVRfHo3IH/XZ2NwZ3L1phDykBK+EB3Mb+Pui0=;
        b=jUOv4tDW/z79g3tPP+itdZ2AKhrxDML+zZYWqnnFz/C+iHWs+NkaXQIjznb9IzB7sr
         xpZUXFkk9uLkqcfWentmUeZN/bdnyHtf0s7knjg72RRjS87ZxqRXLNK/MPFlSHoRSlq5
         RJqWLJbJ/rc8YdhXitihLPUqnVb5tFSZrQBMULvjkdvBD0GlELe+mM5I6Vf2kG9xa7iY
         ILLhsy2Hr4AE0JXUnHAkkXiGy34gp9fmq85wGkjGP/h9mtdXV5KLvnN0ijnDahUol8hc
         eLPDQ2Tp6a+sEkgD2mp/cFT3RBkqd5OPDxXPjSuiFuEvGzJkm5V+iigVg36F35Yuy0uG
         hDvQ==
X-Received: by 10.68.194.9 with SMTP id hs9mr8791132pbc.95.1387018331523;
        Sat, 14 Dec 2013 02:52:11 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id at4sm11411404pbc.30.2013.12.14.02.52.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:52:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:57:03 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239292>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/setup.c b/setup.c
index e9f0ef6..01fe89a 100644
--- a/setup.c
+++ b/setup.c
@@ -182,28 +182,38 @@ void verify_non_filename(const char *prefix, cons=
t char *arg)
  *    a proper "ref:", or a regular file HEAD that has a properly
  *    formatted sha1 object name.
  */
-int is_git_directory(const char *suspect)
+static int is_git_directory_super(const char *suspect, const char *sup=
er)
 {
 	char path[PATH_MAX];
 	size_t len =3D strlen(suspect);
+	size_t super_len;
+
+	if (!super) {
+		super =3D suspect;
+		super_len =3D len;
+	} else
+		super_len =3D strlen(super);
=20
-	if (PATH_MAX <=3D len + strlen("/objects"))
+	if (PATH_MAX <=3D super_len + strlen("/objects") ||
+	    PATH_MAX <=3D len + strlen("/HEAD"))
 		die("Too long path: %.*s", 60, suspect);
-	strcpy(path, suspect);
+	strcpy(path, super);
 	if (getenv(DB_ENVIRONMENT)) {
 		if (access(getenv(DB_ENVIRONMENT), X_OK))
 			return 0;
 	}
 	else {
-		strcpy(path + len, "/objects");
+		strcpy(path + super_len, "/objects");
 		if (access(path, X_OK))
 			return 0;
 	}
=20
-	strcpy(path + len, "/refs");
+	strcpy(path + super_len, "/refs");
 	if (access(path, X_OK))
 		return 0;
=20
+	if (super !=3D suspect)
+		strcpy(path, suspect);
 	strcpy(path + len, "/HEAD");
 	if (validate_headref(path))
 		return 0;
@@ -211,6 +221,12 @@ int is_git_directory(const char *suspect)
 	return 1;
 }
=20
+int is_git_directory(const char *suspect)
+{
+	return is_git_directory_super(suspect, NULL);
+}
+
+
 int is_inside_git_dir(void)
 {
 	if (inside_git_dir < 0)
@@ -354,7 +370,7 @@ const char *read_gitfile_super(const char *path, ch=
ar **super)
 		dir =3D path_from_gitfile(path, buf + 8, len - 8);
 	}
=20
-	if (!is_git_directory(dir))
+	if (!is_git_directory_super(dir, super ? *super : NULL))
 		die("Not a git repository: %s", dir);
 	path =3D real_path(dir);
=20
--=20
1.8.5.1.77.g42c48fa
