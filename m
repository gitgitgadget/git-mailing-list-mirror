From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/34] setup.c: detect $GIT_COMMON_DIR in is_git_directory()
Date: Sun, 30 Nov 2014 15:24:41 +0700
Message-ID: <1417335899-27307-17-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:28:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzrm-0008Go-D0
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbaK3I2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:28:20 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38442 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbaK3I2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:28:17 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so9001065pab.26
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FxBlriKgOkOiZbdSGbNLAH+Oy4u6IALjP3kSfsbR+84=;
        b=o9l+q4VWpWzTfDb67T2Yrt6BesGsvgW0DLUFpZrn40O1dVkbsukZH85o8XLFqYM0N1
         /kN8KLqaSwmfoVJjhQV9vKqU7xyehlfnHkknBIFgUOVuK6jbt2NAUt3ZvwVRjuZs4XCy
         giIBDE/IuTh34eXj2D73E8KRCzw+MauTgkLl4aEAg0WSOdiyYQcUKwkyhYj37Fv1Za+7
         YOD7+KXZDf1EhCkOuegXTm/rN9K8+fcqS2Lj/balR3MzMYGaN6kCYamI/dKwIl2oTnz9
         FNm2Q80ZN2AG3bYcMrxVD6xITit9qhjtArSk09GzoMa1z4/TtX8aTRRSiKeITqrmHMOb
         eX/Q==
X-Received: by 10.66.221.168 with SMTP id qf8mr78067143pac.102.1417336097376;
        Sun, 30 Nov 2014 00:28:17 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id l6sm14355774pdr.39.2014.11.30.00.28.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:28:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:28:14 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260403>

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
index 2b5966a..2dc5667 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -240,6 +240,13 @@ shallow::
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
index afd6742..6c52f75 100644
--- a/setup.c
+++ b/setup.c
@@ -224,6 +224,33 @@ void verify_non_filename(const char *prefix, const=
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
@@ -242,13 +269,22 @@ int is_git_directory(const char *suspect)
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
@@ -259,11 +295,6 @@ int is_git_directory(const char *suspect)
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
2.1.0.rc0.78.gc0d8480
