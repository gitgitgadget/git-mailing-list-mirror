From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/16] Guard unallowed access to repository when it's not set up
Date: Thu, 11 Mar 2010 20:22:34 +0700
Message-ID: <1268313754-28179-17-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:24:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiNg-0001wN-Hj
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757854Ab0CKNYL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:24:11 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60688 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757752Ab0CKNYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:24:07 -0500
Received: by mail-pw0-f46.google.com with SMTP id 1so9492pwi.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EObYUndKsNEIcDPt+8GaQRZ6mKclpHwcO1/GLFOs7U4=;
        b=KLk/kcT0BsHAnPRH9AaZIai6yJPfr7Rsoo+jU7Bb+xLb+1XQPQo92wdDnVqreJzEE7
         ZbbetYcjycz5Ci96R75VYJ+9YJTCcfAi3UsyCztLRcpXb6oqXyO3nJIi6MU+Rhygipef
         Dd7GGoOQNVAncBDMh/DM9qwNczGQUhxijy9ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JkDjoh4H2D4TAPFsm/ZA/yOsv0JDs/KZDNAUv555bq83tLzywr+hfryUkQZH25UE9r
         tLUdCVCUtsI/mpFK+wjk/bGfijSoQhJhVFF8FtlPucZyCUniUObohzkPNO5gBGTDVAc1
         2UG2q9ZAvc6I+OnjiVJDglMwmdHEIy1rMAZGo=
Received: by 10.115.84.9 with SMTP id m9mr1330382wal.193.1268313845839;
        Thu, 11 Mar 2010 05:24:05 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 21sm8860253pzk.0.2010.03.11.05.24.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:24:05 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:24:01 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141978>

Many code path will skip repo access if startup_info->have_repository
is false. This may be a fault if startup_info->have_repository has not
been properly initialized.

So the rule is one of the following commands must be run before any
repo access. And none of them can be called twice.

 - setup_git_directory*
 - enter_repo
 - init_db

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/init-db.c |    1 +
 cache.h           |    1 +
 config.c          |    2 ++
 environment.c     |   13 +++++++++++--
 setup.c           |   13 +++++++++++++
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 064b919..d4c415c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -302,6 +302,7 @@ int init_db(const char *git_dir, const char *templa=
te_dir, unsigned int flags)
=20
 	set_git_dir(make_absolute_path(git_dir));
 	startup_info->have_repository =3D 1;
+	startup_info->have_run_setup_gitdir =3D 1;
=20
 	safe_create_dir(get_git_dir(), 0);
=20
diff --git a/cache.h b/cache.h
index bd9df24..1a6ae8c 100644
--- a/cache.h
+++ b/cache.h
@@ -1060,6 +1060,7 @@ int split_cmdline(char *cmdline, const char ***ar=
gv);
 /* git.c */
 struct startup_info {
 	const char *prefix;
+	int have_run_setup_gitdir;
 	int have_repository;
 };
 extern struct startup_info *startup_info;
diff --git a/config.c b/config.c
index 07d854a..9981b09 100644
--- a/config.c
+++ b/config.c
@@ -737,6 +737,8 @@ int git_config(config_fn_t fn, void *data)
 	char *repo_config =3D NULL;
 	int ret;
=20
+	if (startup_info && !startup_info->have_run_setup_gitdir)
+		die("internal error: access to .git/config without repo setup");
 	if (!startup_info || startup_info->have_repository)
 		repo_config =3D git_pathdup("config");
 	ret =3D git_config_early(fn, data, repo_config);
diff --git a/environment.c b/environment.c
index 6127025..17f0cbe 100644
--- a/environment.c
+++ b/environment.c
@@ -98,9 +98,18 @@ void unset_git_env(void)
=20
 static void setup_git_env(void)
 {
+	if (startup_info && startup_info->have_run_setup_gitdir)
+		die("internal error: setup_git_env can't be called twice");
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
-	if (!git_dir)
-		git_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+	if (!git_dir) {
+		/*
+		 * Repo detection should be done by setup_git_directory*
+		 * or enter_repo, not by this function
+		 */
+		 if (startup_info)
+			 die("internal error: $GIT_DIR is empty");
+		 git_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+	}
 	if (!git_dir)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
diff --git a/setup.c b/setup.c
index 3264187..96af5e3 100644
--- a/setup.c
+++ b/setup.c
@@ -237,7 +237,17 @@ void setup_work_tree(void)
 		git_dir =3D make_absolute_path(git_dir);
 	if (!work_tree || chdir(work_tree))
 		die("This operation must be run in a work tree");
+
+	/*
+	 * have_run_setup_gitdir is unset in order to avoid die()ing
+	 * inside set_git_env(). We don't actually initialize
+	 * repo twice, we're just relative-izing gitdir
+	 */
+	if (startup_info)
+		startup_info->have_run_setup_gitdir =3D 0;
 	set_git_dir(make_relative_path(git_dir, work_tree));
+	if (startup_info)
+		startup_info->have_run_setup_gitdir =3D 1;
 	initialized =3D 1;
 }
=20
@@ -333,6 +343,7 @@ void unset_git_directory(const char *prefix)
 			unset_git_env();
 		startup_info->prefix =3D NULL;
 		startup_info->have_repository =3D 0;
+		startup_info->have_run_setup_gitdir =3D 0;
 	}
=20
 	/* Initialized in setup_git_directory_gently_1() */
@@ -499,6 +510,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	prefix =3D setup_git_directory_gently_1(nongit_ok);
 	if (startup_info) {
 		startup_info->prefix =3D prefix;
+		startup_info->have_run_setup_gitdir =3D 1;
 		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
 	}
 	return prefix;
@@ -593,6 +605,7 @@ char *enter_repo(char *path, int strict)
 		set_git_dir(".");
 		if (startup_info) {
 			startup_info->prefix =3D NULL;
+			startup_info->have_run_setup_gitdir =3D 1;
 			startup_info->have_repository =3D 1;
 		}
 		return path;
--=20
1.7.0.1.384.g6abcaa
