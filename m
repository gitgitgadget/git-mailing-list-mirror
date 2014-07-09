From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 18/32] setup.c: detect $GIT_COMMON_DIR in is_git_directory()
Date: Wed,  9 Jul 2014 14:33:03 +0700
Message-ID: <1404891197-18067-19-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:35:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mPI-0003uU-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbaGIHfG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:35:06 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33196 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802AbaGIHfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:35:05 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so8558165pdb.21
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pEASNeHea+ivuXEYvw+p9p3AmS2B9USFE24dYYcGgz0=;
        b=1HY4H8NOsy/8JbiSixDqKVX8gn+bunLi6hPhM3eItsq5QvTSqm/LrqwDgI+j7AidEa
         xhHOmg2/zPrJa8Hlpqr7L1nSVsDkhxbLs7NlglacnKb+agyBF7edor13zAY5CdkkhYde
         HR8sNvxBafQtuuVJzPcqNqRtQu9s8ui1sLAZ0MD6UMy6zBxlOPY1UWH1O+O03av0Tu0e
         N12FvR2i09GGr4gvI6ioy0GrLW19MbgEJoA20+VswHeNGNJVjNwd3nTsirVTa7EMnD3I
         wmZRnUOpLffsEtoii4/rELmEdBUXbSyM3JHQitur1o3Jd3entkJO7bV80gWggwJOzOlr
         lSjg==
X-Received: by 10.70.98.167 with SMTP id ej7mr9884579pdb.70.1404891304673;
        Wed, 09 Jul 2014 00:35:04 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id w16sm27276907pdl.36.2014.07.09.00.35.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:35:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:35:01 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253093>

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
index 7629e38..0f341fc 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -237,6 +237,13 @@ shallow::
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
index 425fd79..176d505 100644
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
1.9.1.346.ga2b5940
