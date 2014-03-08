From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 16/28] setup.c: detect $GIT_COMMON_DIR in is_git_directory()
Date: Sat,  8 Mar 2014 09:48:08 +0700
Message-ID: <1394246900-31535-17-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7KS-0005Zy-NW
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbaCHCtd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:49:33 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:48853 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaCHCtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:49:32 -0500
Received: by mail-pb0-f43.google.com with SMTP id um1so4968239pbc.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tPhDxC9XyEnNg7RhMJTG+dcatdOU+BbnoTFEzv4ortg=;
        b=0/K0eBmIWRVdG6K+ocxP0lqVTyYdJMqYMdbgXVfP13/oeQ7PVCHGa914QIj+oJ00x7
         kZkpGChaFNt1gGHcw9e850ze7kb9Kik/PP5xoYXCLylRlmpQLMBdBaNXjYLh7UAxFhU2
         3f7PmS5Pc9iIYVDK7c1TFpHJxyqPBXcqSQjiASgMAz9nu2sSk3DweMjNbPdUUuce+icy
         5nHxW6LOa663GOjVfLbQU1xFS/4b7beqEve5K24Lo7be+/Ikrbc99/2U6HHEWbCqvVnb
         +OJOXb9gKy9GBr5c91gKWHt1KMhZj62aLv9N8sFw4m6tPrRHG8iAJU8MKLFKF6Tj9/+E
         pYvw==
X-Received: by 10.66.138.40 with SMTP id qn8mr26411339pab.154.1394246971820;
        Fri, 07 Mar 2014 18:49:31 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id xs1sm18671734pac.7.2014.03.07.18.49.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:49:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:50:05 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243657>

If the file "$GIT_DIR/commondir" exists, it contains the value of
$GIT_COMMON_DIR.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitrepository-layout.txt |  7 ++++++
 setup.c                                | 43 ++++++++++++++++++++++++++=
+++-----
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 556da09..c6f3649 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -233,6 +233,13 @@ shallow::
 	file is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/shallow" will be used instead.
=20
+commondir::
+	If this file exists, $GIT_COMMON_DIR (see linkgit:git[1]) will
+	be set to the path specified in this file if it is not
+	explicitly set. If the specified path is relative, it is
+	relative to $GIT_DIR. The repository with commondir is
+	incomplete without the repository pointed by "commondir".
+
 modules::
 	Contains the git-repositories of the submodules. This
 	directory is ignored if $GIT_COMMON_DIR is set and
diff --git a/setup.c b/setup.c
index 4994437..7e5b334 100644
--- a/setup.c
+++ b/setup.c
@@ -170,6 +170,33 @@ void verify_non_filename(const char *prefix, const=
 char *arg)
 	    "'git <command> [<revision>...] -- [<file>...]'", arg);
 }
=20
+static void get_common_dir(struct strbuf *sb, const char *gitdir)
+{
+	struct strbuf data =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+	const char *git_common_dir =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
+	if (git_common_dir) {
+		strbuf_addstr(sb, git_common_dir);
+		return;
+	}
+	strbuf_addf(&path, "%s/commondir", gitdir);
+	if (file_exists(path.buf)) {
+		if (strbuf_read_file(&data, path.buf, 0) <=3D 0)
+			die_errno(_("failed to read %s"), path.buf);
+		while (data.len && (data.buf[data.len - 1] =3D=3D '\n' ||
+				    data.buf[data.len - 1] =3D=3D '\r'))
+			data.len--;
+		data.buf[data.len] =3D '\0';
+		strbuf_reset(&path);
+		if (!is_absolute_path(data.buf))
+			strbuf_addf(&path, "%s/", gitdir);
+		strbuf_addbuf(&path, &data);
+		strbuf_addstr(sb, real_path(path.buf));
+	} else
+		strbuf_addstr(sb, gitdir);
+	strbuf_release(&data);
+	strbuf_release(&path);
+}
=20
 /*
  * Test if it looks like we're at a git directory.
@@ -188,13 +215,22 @@ int is_git_directory(const char *suspect)
 	int ret =3D 0;
 	size_t len;
=20
-	strbuf_addstr(&path, suspect);
+	/* Check worktree-related signatures */
+	strbuf_addf(&path, "%s/HEAD", suspect);
+	if (validate_headref(path.buf))
+		goto done;
+
+	strbuf_reset(&path);
+	get_common_dir(&path, suspect);
 	len =3D path.len;
+
+	/* Check non-worktree-related signatures */
 	if (getenv(DB_ENVIRONMENT)) {
 		if (access(getenv(DB_ENVIRONMENT), X_OK))
 			goto done;
 	}
 	else {
+		strbuf_setlen(&path, len);
 		strbuf_addstr(&path, "/objects");
 		if (access(path.buf, X_OK))
 			goto done;
@@ -205,11 +241,6 @@ int is_git_directory(const char *suspect)
 	if (access(path.buf, X_OK))
 		goto done;
=20
-	strbuf_setlen(&path, len);
-	strbuf_addstr(&path, "/HEAD");
-	if (validate_headref(path.buf))
-		goto done;
-
 	ret =3D 1;
 done:
 	strbuf_release(&path);
--=20
1.9.0.40.gaa8c3ea
