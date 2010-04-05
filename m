From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 40/43] Guard unallowed access to repository when it's not set up
Date: Mon,  5 Apr 2010 20:41:25 +0200
Message-ID: <1270492888-26589-41-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:44:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrI5-0003NW-9m
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149Ab0DESoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:44:08 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142Ab0DESoF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:44:05 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6egVw5KUfgm3di4y/qy5NtBr5E+27PTN9rnIiezV5vo=;
        b=Y1qzABBCmV2pTdihDOJaYMwqn2ZIBUTUAmSSvCla4ckMpTRx7/ET1Hhr+CnlnOj9x5
         bibUMpyPp0PKmCURx4fgODtclYOc0A31GFGGsPGO9rbUttgzDITAM8VSxCCOSIp8yQgT
         7/J8brHQyr5+CkRAT3wGYQDGisORo/m8PYt+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=S8TKu7DUW6mr9tI5IF0j+LCx3mQDIW9W8VfJVME/x12GyMdgcUnbyPbTyTs+aNq1IV
         OcgpBpP9iGeegg9o4QYudycTracz4bP4MF/UlulQZHSMPsiSuRWIkuQW2Bob2IvxDGEh
         f0EeuiM8f2+vRfPUdoOqkGMQaqfJsZEp9gmJA=
Received: by 10.223.72.156 with SMTP id m28mr1225649faj.26.1270493042343;
        Mon, 05 Apr 2010 11:44:02 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 18sm19918fkq.34.2010.04.05.11.44.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:44:01 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:59 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144038>

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
 git.c             |   16 +++++++++++-----
 setup.c           |   13 +++++++++++++
 6 files changed, 39 insertions(+), 7 deletions(-)

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
index 137edac..1e6fd56 100644
--- a/cache.h
+++ b/cache.h
@@ -1067,6 +1067,7 @@ int checkout_fast_forward(const unsigned char *fr=
om, const unsigned char *to);
 /* git.c */
 struct startup_info {
 	const char *prefix;
+	int have_run_setup_gitdir;
 	int have_repository;
 	int help;
 };
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
diff --git a/git.c b/git.c
index d6513f1..43cebd7 100644
--- a/git.c
+++ b/git.c
@@ -245,11 +245,14 @@ static int run_builtin(struct cmd_struct *p, int =
argc, const char **argv)
 			int nongit_ok;
 			setup_git_directory_gently(&nongit_ok);
 		}
-		else if (startup_info->have_repository) {
-			if (p->option & (RUN_SETUP_GENTLY | RUN_SETUP))
-				; /* done already */
-			else
-				unset_git_directory(startup_info->prefix);
+		else if (startup_info->have_run_setup_gitdir) {
+			if (startup_info->have_repository) {
+				if (p->option & (RUN_SETUP_GENTLY | RUN_SETUP))
+					; /* done already */
+				else
+					unset_git_directory(startup_info->prefix);
+			}
+			startup_info->have_run_setup_gitdir =3D 0;
 		}
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
@@ -260,6 +263,9 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
 			use_pager =3D 1;
 		}
 	}
+	else
+		/* Stop git_config() from complaining that no repository found. */
+		startup_info->have_run_setup_gitdir =3D 1;
 	commit_pager_choice();
=20
 	if (!startup_info->help && p->option & NEED_WORK_TREE)
diff --git a/setup.c b/setup.c
index b0269aa..89757fc 100644
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
@@ -340,6 +350,7 @@ void unset_git_directory(const char *prefix)
 			unset_git_env();
 		startup_info->prefix =3D NULL;
 		startup_info->have_repository =3D 0;
+		startup_info->have_run_setup_gitdir =3D 0;
 	}
=20
 	/* Initialized in setup_git_directory_gently_1() */
@@ -515,6 +526,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	prefix =3D setup_git_directory_gently_1(nongit_ok);
 	if (startup_info) {
 		startup_info->prefix =3D prefix;
+		startup_info->have_run_setup_gitdir =3D 1;
 		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
 	}
 	return prefix;
@@ -609,6 +621,7 @@ char *enter_repo(char *path, int strict)
 		set_git_dir(".");
 		if (startup_info) {
 			startup_info->prefix =3D NULL;
+			startup_info->have_run_setup_gitdir =3D 1;
 			startup_info->have_repository =3D 1;
 		}
 		return path;
--=20
1.7.0.rc1.541.g2da82.dirty
