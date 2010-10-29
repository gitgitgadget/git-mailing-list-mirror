From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 37/42] Use git_config_early() instead of git_config() during repo setup
Date: Fri, 29 Oct 2010 13:48:49 +0700
Message-ID: <1288334934-17216-38-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:54:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiql-0007ZV-SN
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933515Ab0J2Gx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:53:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57125 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab0J2Gx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:53:57 -0400
Received: by mail-iw0-f174.google.com with SMTP id 10so3313568iwn.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sz637rtF+LeB2aLWpScGiqeLfAm7xVzbuGWSUCtR4jE=;
        b=YSniISoicuMXVB/wkuYEVouyG5eE9kvwCaCzNiQzbYqhXzdW3WYbSylHUTfe4/uKDk
         YAIYHjw2erpnYbLEpn5Zv8QhJ8Kc46N6LHKEquV7QX8KdYc8wq8mYaQ6FLEN4vMizIou
         sIxWms9v4hZcN8XxFOsJWE8T7BLTMcyewNjZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pzKeY9PhC3slx5V1L+OpG0kFuwP+ZEQtymkSWYsjBSJ7XfyNEk6SZ2KK/lsMYNyfZJ
         L7B4Hrd8BFs8Q1srKgbMoWFC4mhtKmMscnu9zIMpMarUq+qx73MhaPx9zeOCSgen+xxt
         DCUOt9MIppOxfymmCs0FytncnY/LdJiwfgDsA=
Received: by 10.42.41.5 with SMTP id n5mr4104157ice.248.1288335236720;
        Thu, 28 Oct 2010 23:53:56 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w9sm3335197ibc.1.2010.10.28.23.53.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:53:55 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:53:55 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160305>

When git_config() is called, either git_dir has already been set (by
$GIT_DIR env or set_git_dir()), or it will default git_dir to ".git".

git_config_early() gives setup functions more freedom because it does
not require git_dir. Give it a config path, it will happily examine
it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |   47 +++++++++++++++++++++++++++++++++++------------
 1 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/setup.c b/setup.c
index a3b76de..49a1a25 100644
--- a/setup.c
+++ b/setup.c
@@ -243,9 +243,21 @@ void setup_work_tree(void)
 	initialized =3D 1;
 }
=20
-static int check_repository_format_gently(int *nongit_ok)
+static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
 {
-	git_config(check_repository_format_version, NULL);
+	char repo_config[PATH_MAX+1];
+
+	/*
+	 * git_config() can't be used here because it calls git_pathdup()
+	 * to get $GIT_CONFIG/config. That call will make setup_git_env()
+	 * set git_dir to ".git".
+	 *
+	 * We are in gitdir setup, no git dir has been found useable yet.
+	 * Use a gentler version of git_config() to check if this repo
+	 * is a good one.
+	 */
+	snprintf(repo_config, PATH_MAX, "%s/config", gitdir);
+	git_config_early(check_repository_format_version, NULL, repo_config);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <=3D %d, found %d",
@@ -331,11 +343,11 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
 	if (!work_tree_env) {
 		retval =3D set_work_tree(gitdirenv);
 		/* config may override worktree */
-		if (check_repository_format_gently(nongit_ok))
+		if (check_repository_format_gently(gitdirenv, nongit_ok))
 			return NULL;
 		return retval;
 	}
-	if (check_repository_format_gently(nongit_ok))
+	if (check_repository_format_gently(gitdirenv, nongit_ok))
 		return NULL;
 	retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
 			get_git_work_tree());
@@ -357,11 +369,17 @@ static int cwd_contains_git_dir(const char **gitf=
ile_dirp)
 			die("Repository setup failed");
 		return 1;
 	}
-	return is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT);
+	if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT)) {
+		*gitfile_dirp =3D DEFAULT_GIT_DIR_ENVIRONMENT;
+		return 1;
+	}
+	return 0;
 }
=20
 static const char *setup_discovered_git_dir(const char *work_tree_env,
-		int offset, int len, char *cwd, int *nongit_ok)
+					    const char *gitdir,
+					    int offset, int len,
+					    char *cwd, int *nongit_ok)
 {
 	int root_len;
=20
@@ -370,7 +388,7 @@ static const char *setup_discovered_git_dir(const c=
har *work_tree_env,
 		inside_work_tree =3D 1;
 	root_len =3D offset_1st_component(cwd);
 	git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : root=
_len);
-	if (check_repository_format_gently(nongit_ok))
+	if (check_repository_format_gently(gitdir, nongit_ok))
 		return NULL;
 	if (offset =3D=3D len)
 		return NULL;
@@ -396,9 +414,12 @@ static const char *setup_bare_git_dir(const char *=
work_tree_env,
 		root_len =3D offset_1st_component(cwd);
 		cwd[offset > root_len ? offset : root_len] =3D '\0';
 		set_git_dir(cwd);
-	} else
+		check_repository_format_gently(cwd, nongit_ok);
+	}
+	else {
 		set_git_dir(".");
-	check_repository_format_gently(nongit_ok);
+		check_repository_format_gently(".", nongit_ok);
+	}
 	return NULL;
 }
=20
@@ -478,8 +499,10 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 		current_device =3D get_device_or_die(".", NULL);
 	for (;;) {
 		if (cwd_contains_git_dir(&gitfile_dir))
-			return setup_discovered_git_dir(work_tree_env, offset,
-							len, cwd, nongit_ok);
+			return setup_discovered_git_dir(work_tree_env,
+							gitfile_dir,
+							offset, len,
+							cwd, nongit_ok);
 		if (is_git_directory("."))
 			return setup_bare_git_dir(work_tree_env, offset,
 							len, cwd, nongit_ok);
@@ -590,7 +613,7 @@ int check_repository_format_version(const char *var=
, const char *value, void *cb
=20
 int check_repository_format(void)
 {
-	return check_repository_format_gently(NULL);
+	return check_repository_format_gently(get_git_dir(), NULL);
 }
=20
 /*
--=20
1.7.0.2.445.gcbdb3
