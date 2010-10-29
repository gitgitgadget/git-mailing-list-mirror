From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 40/42] setup: clean up setup_discovered_git_dir()
Date: Fri, 29 Oct 2010 13:48:52 +0700
Message-ID: <1288334934-17216-41-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:54:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBir0-0007fo-7M
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564Ab0J2GyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:54:20 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab0J2GyS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:54:18 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Gj3c2Ui+GGPH1FEWPQETZ9VD5tiyAJjDspz0dbBZNXs=;
        b=CXEKeapAk2BR/6ovobMi4EziEatczLoJPTvpVNYeZPd6Hqlleh5Ir/VZAidal4nckP
         /mVDzkzVRdlW9dSm9T9pqVqhFV5jq3NOwG1uJ70QkpbBwVATtwTGuzQWuDyT43UhWvoF
         zehpFQrSqW5S8cVpF3odIjSVJCWl++rZ/WCfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ejkBDY4BuZBDezAzj6gfH/iB9oQr9shYaJfH+UsqwLyMqy0x+wslVan17MdVoe/V/+
         QqT01b4cZ1b6g2qfWvIKl8m7k/30819XVEP9ORCyL9FfZ04iPkyyAYnTHirNdeoC1/hs
         cP5VsMaKwuiQfvPtAjhkUXRzIcX4gi4uI+J/o=
Received: by 10.143.14.14 with SMTP id r14mr828734wfi.266.1288335258334;
        Thu, 28 Oct 2010 23:54:18 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e14sm1034034wfg.8.2010.10.28.23.54.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:54:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:54:17 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160308>

If core.bare is true, discard the discovered worktree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |   68 ++++++++++++++++++++++++++++++++++---------------------=
-------
 1 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/setup.c b/setup.c
index cba9bec..dc91e0a 100644
--- a/setup.c
+++ b/setup.c
@@ -360,36 +360,30 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
 	return retval;
 }
=20
-static int cwd_contains_git_dir(const char **gitfile_dirp)
-{
-	const char *gitfile_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIR=
ONMENT);
-	*gitfile_dirp =3D gitfile_dir;
-	if (gitfile_dir) {
-		if (set_git_dir(gitfile_dir))
-			die("Repository setup failed");
-		return 1;
-	}
-	if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT)) {
-		*gitfile_dirp =3D DEFAULT_GIT_DIR_ENVIRONMENT;
-		return 1;
-	}
-	return 0;
-}
-
-static const char *setup_discovered_git_dir(const char *work_tree_env,
-					    const char *gitdir,
-					    int offset, int len,
-					    char *cwd, int *nongit_ok)
+static const char *setup_discovered_git_dir(const char *gitdir,
+					    char *cwd, int offset, int len,
+					    int *nongit_ok)
 {
 	int root_len;
=20
+	if (check_repository_format_gently(gitdir, nongit_ok))
+		return NULL;
+
+	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
+	if (is_bare_repository_cfg > 0) {
+		set_git_dir(offset =3D=3D len ? gitdir : make_absolute_path(gitdir))=
;
+		if (chdir(cwd))
+			die_errno("Could not come back to cwd");
+		return NULL;
+	}
+
+	/* #0, #1, #5, #8, #9, #12, #13 */
+	set_git_work_tree(".");
+	set_git_dir(gitdir);
 	inside_git_dir =3D 0;
-	if (!work_tree_env)
-		inside_work_tree =3D 1;
+	inside_work_tree =3D 1;
 	root_len =3D offset_1st_component(cwd);
 	git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : root=
_len);
-	if (check_repository_format_gently(gitdir, nongit_ok))
-		return NULL;
 	if (offset =3D=3D len)
 		return NULL;
=20
@@ -451,8 +445,8 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
 	static char cwd[PATH_MAX+1];
-	const char *gitdirenv;
-	const char *gitfile_dir;
+	const char *gitdirenv, *ret;
+	char *gitfile;
 	int len, offset, ceil_offset;
 	dev_t current_device =3D 0;
 	int one_filesystem =3D 1;
@@ -497,11 +491,23 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
 	if (one_filesystem)
 		current_device =3D get_device_or_die(".", NULL);
 	for (;;) {
-		if (cwd_contains_git_dir(&gitfile_dir))
-			return setup_discovered_git_dir(work_tree_env,
-							gitfile_dir,
-							offset, len,
-							cwd, nongit_ok);
+		gitfile =3D (char*)read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+		if (gitfile)
+			gitdirenv =3D gitfile =3D xstrdup(gitfile);
+		else {
+			if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
+				gitdirenv =3D DEFAULT_GIT_DIR_ENVIRONMENT;
+		}
+
+		if (gitdirenv) {
+			ret =3D setup_discovered_git_dir(gitdirenv,
+						       cwd, offset, len,
+						       nongit_ok);
+			free(gitfile);
+			return ret;
+		}
+		free(gitfile);
+
 		if (is_git_directory("."))
 			return setup_bare_git_dir(cwd, offset, len, nongit_ok);
=20
--=20
1.7.0.2.445.gcbdb3
