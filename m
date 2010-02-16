From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 04/26] Add GIT_HARDENED_SETUP to detect gitdir/worktree related mis-setup errors
Date: Tue, 16 Feb 2010 23:04:55 +0700
Message-ID: <1266336317-607-5-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPyX-0006Wm-BN
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947Ab0BPQI2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:08:28 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684Ab0BPQI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:08:27 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LKRjG8giZlRzDTibOHXUkYByn+YOMro9c3547HPF06U=;
        b=pFD1MMQoz/2CD4VMQ5MFeZDJMeBPqyVjFsK61iEVGZkZ04nXeKksWuJfdNOTDYMvTK
         0aYmJ0mqcYRvqujKVFVD6Lj/uVk8ap3PE1GElPvTuMQE++ApYUktZTYZikQycJXkYUbX
         7f80vLKktwvD76S61FzmaklTh2gAq5GjQq4WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=t1xuEqdZXA59ZbC/8dGbW+XXm8XvYpnv6iKvB8po1V//JktqjbSaGfE9QxHjzc6IMo
         kdgXJEm7234Gk+51yWTz/Q6RIU849WAqFUrvaRxzVkXPHEzJKZsBJ+9x+Rjhf3ykDuN/
         smPwPLcNZPKdZrNa/eKbi4A5v29fn6VuK8B5U=
Received: by 10.151.89.33 with SMTP id r33mr10092943ybl.290.1266336507001;
        Tue, 16 Feb 2010 08:08:27 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 20sm868124ywh.17.2010.02.16.08.08.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:08:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:05:44 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140107>

When GIT_DIR environment variable is not specified, .git will be
searched if a repository is needed. Currently this can be done in two
places: setup_git_directory_gently() and setup_git_env().

The one in setup_git_env() is no longer correct and should IMHO have
been removed since the introduction of setup_git_directory_gently() in
d288a70. Having two ways of auto detection may lead to obscure errors
because .git may be misdetected by setup_git_env(),
automatically called via git_path(), which is all over the place.

This patch makes setup_git_env() die if GIT_DIR is not explictly
set. That's setup_git_directory_gently()'s job. If you ever want to
touch things inside $GIT_DIR, you should have already called
setup_git_directory_gently().

However, doing that will break Git the hard way. So the die()ing
behavior will be only triggered if environment variable
GIT_HARDENED_SETUP is set. Otherwise old behavior remains. Once all
Git commands have been adapted to stay away from the old behavior, the
old code can be removed.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.c      |   17 ++++++++++++-----
 environment.c |   42 ++++++++++++++++++++++++++++++++----------
 setup.c       |    4 +++-
 3 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/config.c b/config.c
index 6963fbe..eee12b4 100644
--- a/config.c
+++ b/config.c
@@ -704,6 +704,7 @@ int git_config(config_fn_t fn, void *data)
 	int ret =3D 0, found =3D 0;
 	char *repo_config =3D NULL;
 	const char *home =3D NULL;
+	const char *hardened_setup =3D getenv("GIT_HARDENED_SETUP");
=20
 	/* Setting $GIT_CONFIG makes git read _only_ the given config file. *=
/
 	if (config_exclusive_filename)
@@ -724,12 +725,18 @@ int git_config(config_fn_t fn, void *data)
 		free(user_config);
 	}
=20
-	repo_config =3D git_pathdup("config");
-	if (!access(repo_config, R_OK)) {
-		ret +=3D git_config_from_file(fn, repo_config, data);
-		found +=3D 1;
+	if (hardened_setup && !*hardened_setup)
+		hardened_setup =3D NULL;
+	if (hardened_setup && startup_info && !startup_info->have_set_gitdir)
+		die("Try to access a repository before properly setting it up");
+	if (!hardened_setup || !startup_info || startup_info->have_repository=
) {
+		repo_config =3D git_pathdup("config");
+		if (!access(repo_config, R_OK)) {
+			ret +=3D git_config_from_file(fn, repo_config, data);
+			found +=3D 1;
+		}
+		free(repo_config);
 	}
-	free(repo_config);
 	if (found =3D=3D 0)
 		return -1;
 	return ret;
diff --git a/environment.c b/environment.c
index 1ab8815..4795441 100644
--- a/environment.c
+++ b/environment.c
@@ -66,9 +66,19 @@ static char *git_object_dir, *git_index_file, *git_r=
efs_dir, *git_graft_file;
=20
 static void setup_git_env(void)
 {
+	const char *harden_setup =3D getenv("GIT_HARDENED_SETUP");
+
+	if (harden_setup && !*harden_setup)
+		harden_setup =3D NULL;
+
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
-	if (!git_dir)
-		git_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+	if (!git_dir) {
+		if (harden_setup)
+			die("GIT_DIR not properly set");
+		 git_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+	}
+	if (harden_setup && startup_info && startup_info->have_set_gitdir)
+			die("internal error: setup_git_env can't be called twice");
 	if (!git_dir)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
@@ -103,8 +113,11 @@ int have_git_dir(void)
=20
 const char *get_git_dir(void)
 {
-	if (!git_dir)
-		setup_git_env();
+	if (!git_dir) {
+		const char *harden_setup =3D getenv("GIT_HARDENED_SETUP");
+		if (!harden_setup || !*harden_setup)
+			setup_git_env();
+	}
 	return git_dir;
 }
=20
@@ -146,22 +159,31 @@ const char *get_git_work_tree(void)
=20
 char *get_object_directory(void)
 {
-	if (!git_object_dir)
-		setup_git_env();
+	if (!git_object_dir) {
+		const char *harden_setup =3D getenv("GIT_HARDENED_SETUP");
+		if (!harden_setup || !*harden_setup)
+			setup_git_env();
+	}
 	return git_object_dir;
 }
=20
 char *get_index_file(void)
 {
-	if (!git_index_file)
-		setup_git_env();
+	if (!git_index_file) {
+		const char *harden_setup =3D getenv("GIT_HARDENED_SETUP");
+		if (!harden_setup || !*harden_setup)
+			setup_git_env();
+	}
 	return git_index_file;
 }
=20
 char *get_graft_file(void)
 {
-	if (!git_graft_file)
-		setup_git_env();
+	if (!git_graft_file) {
+		const char *harden_setup =3D getenv("GIT_HARDENED_SETUP");
+		if (!harden_setup || !*harden_setup)
+			setup_git_env();
+	}
 	return git_graft_file;
 }
=20
diff --git a/setup.c b/setup.c
index 0c05d36..5c8777a 100644
--- a/setup.c
+++ b/setup.c
@@ -453,8 +453,10 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	const char *prefix;
=20
 	prefix =3D setup_git_directory_gently_1(nongit_ok);
-	if (startup_info)
+	if (startup_info) {
 		startup_info->have_set_gitdir =3D 1;
+		startup_info->have_repository =3D get_git_dir() !=3D NULL;
+	}
 	if ((!nongit_ok || !*nongit_ok) && check_repository_format_gently(non=
git_ok))
 		prefix =3D NULL;
 	if (startup_info) {
--=20
1.7.0.195.g637a2
