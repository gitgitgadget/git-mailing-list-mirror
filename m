From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 15/25] setup.c: detect $GIT_COMMON_DIR in is_git_directory()
Date: Tue, 18 Feb 2014 20:40:04 +0700
Message-ID: <1392730814-19656-16-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:41:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkvn-0007tj-DT
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723AbaBRNlq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:41:46 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:36147 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbaBRNlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:41:44 -0500
Received: by mail-pb0-f50.google.com with SMTP id rq2so16882487pbb.9
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pg6pDkXOHY5zoGDsBjUlDzIHEpkad1k34xlNq3SiEXk=;
        b=NBXUNX8tyUPtIQhIk1sL9LQyEO/DX81e3+0f0bZPLlMsKjEnSl6R0eTUU9tmuiT5ji
         s7FX77a3oD7UV7fvUX24MqoNZHCuUkrrtRWd0lz1mL8OSQ2qeZ6/D3Nx29IQ8PxkU/dl
         WvNSxcQdljzU9oCzo/NHroJl+dgTQQ5mFHUuBCvudIsOF4hEV+5KRzm1t1QFeIf488sH
         v8ICFvTqfNlxeRD4S8blNOWA3Gm63m17Zr+CYV6ckDY49r+vOeMZn6rFlzwuLu9F+DpY
         PucDNBGw8tARcEek3zFEZ9rM2aWF4QdfZmMlibtEfV75ltHlU7muYjfq/GhV7zxO0unJ
         AOdA==
X-Received: by 10.66.50.105 with SMTP id b9mr33236582pao.9.1392730903473;
        Tue, 18 Feb 2014 05:41:43 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id sy2sm56098875pbc.28.2014.02.18.05.41.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:41:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:41:56 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242314>

If the file "$GIT_DIR/commondir" exists, it contains the value of
$GIT_COMMON_DIR.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitrepository-layout.txt |  4 ++++
 setup.c                                | 38 ++++++++++++++++++++++++++=
++------
 strbuf.c                               |  8 +++++++
 strbuf.h                               |  1 +
 4 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index aa03882..9bfe0f1 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -211,6 +211,10 @@ shallow::
 	and maintained by shallow clone mechanism.  See `--depth`
 	option to linkgit:git-clone[1] and linkgit:git-fetch[1].
=20
+commondir::
+	If this file exists, $GIT_COMMON_DIR will be set to the path
+	specified in this file if it is not set.
+
 modules::
 	Contains the git-repositories of the submodules.
=20
diff --git a/setup.c b/setup.c
index 999225b..4e5711c 100644
--- a/setup.c
+++ b/setup.c
@@ -170,6 +170,30 @@ void verify_non_filename(const char *prefix, const=
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
+		strbuf_chomp(&data);
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
@@ -188,14 +212,20 @@ int is_git_directory(const char *suspect)
 	int ret =3D 0;
 	size_t len;
=20
-	strbuf_addstr(&path, suspect);
+	strbuf_addf(&path, "%s/HEAD", suspect);
+	if (validate_headref(path.buf))
+		goto done;
+
+	strbuf_reset(&path);
+	get_common_dir(&path, suspect);
 	len =3D path.len;
+
 	if (getenv(DB_ENVIRONMENT)) {
 		if (access(getenv(DB_ENVIRONMENT), X_OK))
 			goto done;
 	}
 	else {
-		strbuf_addstr(&path, "/objects");
+		strbuf_addstr_at(&path, len, "/objects");
 		if (access(path.buf, X_OK))
 			goto done;
 	}
@@ -204,10 +234,6 @@ int is_git_directory(const char *suspect)
 	if (access(path.buf, X_OK))
 		goto done;
=20
-	strbuf_addstr_at(&path, len, "/HEAD");
-	if (validate_headref(path.buf))
-		goto done;
-
 	ret =3D 1;
 done:
 	strbuf_release(&path);
diff --git a/strbuf.c b/strbuf.c
index 83caf4a..e17c358 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -588,3 +588,11 @@ int fprintf_ln(FILE *fp, const char *fmt, ...)
 		return -1;
 	return ret + 1;
 }
+
+void strbuf_chomp(struct strbuf *sb)
+{
+	while (sb->len && (sb->buf[sb->len - 1] =3D=3D '\n' ||
+			   sb->buf[sb->len - 1] =3D=3D '\r'))
+		sb->len--;
+	sb->buf[sb->len] =3D '\0';
+}
diff --git a/strbuf.h b/strbuf.h
index aec9fdb..cd9578f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -109,6 +109,7 @@ extern void strbuf_remove(struct strbuf *, size_t p=
os, size_t len);
 /* splice pos..pos+len with given data */
 extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
                           const void *, size_t);
+extern void strbuf_chomp(struct strbuf *sb);
=20
 extern void strbuf_add_commented_lines(struct strbuf *out, const char =
*buf, size_t size);
=20
--=20
1.8.5.2.240.g8478abd
