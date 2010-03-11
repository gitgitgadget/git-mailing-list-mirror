From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/16] Allow to undo setup_git_directory_gently() gracefully (and fix alias code)
Date: Thu, 11 Mar 2010 20:22:32 +0700
Message-ID: <1268313754-28179-15-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:24:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiNf-0001wN-FI
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab0CKNX5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:57 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60688 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab0CKNX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:56 -0500
Received: by mail-pw0-f46.google.com with SMTP id 1so9492pwi.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gd2mxOLIvB5P7SOJ1Xey/nHHeBVQIih4eccDAnBVZN4=;
        b=uu4f8nZdy7tUfBlzrcBtRDggqmc5SpykzJxakysi9AMq02DTpwLZLsbugpdJ6B1kaM
         p/MzKHvbRwOcJsWbZm2ZUGNxQXp/pXdpmlzJ2hZkMaFTJPx1BDIpSMlxZbNPX23mkCNJ
         feRhBhdIrSOfknGDZmtYuzHUT/fZTWtDKeUSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=o307MZHouCtv1gao9loDeZT8LTNLUO2iii8ygDyG1hWuw/+2wi+9uhuX2b5cjMlMW2
         6YL/axDOPlrmiZJbxCWGJ6WEvkBwyi9+qIgWFwpwq4QMkT2+nTLlbIhsHz8V0Duqhp8u
         0RLkQDD8pVuZMRxQGscWE4P3WJrcbPolt4OUQ=
Received: by 10.141.108.17 with SMTP id k17mr729870rvm.38.1268313835950;
        Thu, 11 Mar 2010 05:23:55 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 23sm8863787pzk.14.2010.03.11.05.23.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:51 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141976>

unset_git_directory() can only clean up things as long as
set_git_dir() has not been called because set_git_dir() keeps internal
state itself. Even worse, set_git_dir() may override $GIT_DIR env
variable. All those are now handled by unset_git_env().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       |    1 +
 environment.c |   20 ++++++++++++++++++++
 git.c         |   11 +++++------
 setup.c       |    2 ++
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index dd27e11..bd9df24 100644
--- a/cache.h
+++ b/cache.h
@@ -419,6 +419,7 @@ extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern void unset_git_directory(const char *prefix);
+extern void unset_git_env();
 extern const char *prefix_path(const char *prefix, int len, const char=
 *path);
 extern const char *prefix_filename(const char *prefix, int len, const =
char *path);
 extern int check_filename(const char *prefix, const char *name);
diff --git a/environment.c b/environment.c
index c36c902..6127025 100644
--- a/environment.c
+++ b/environment.c
@@ -62,6 +62,7 @@ char *git_work_tree_cfg;
 static char *work_tree;
=20
 static const char *git_dir;
+static const char *original_git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graf=
t_file;
=20
 /*
@@ -81,6 +82,20 @@ const char * const local_repo_env[LOCAL_REPO_ENV_SIZ=
E + 1] =3D {
 	NULL
 };
=20
+void unset_git_env(void)
+{
+	git_dir =3D NULL;
+	if (original_git_dir)
+		setenv(GIT_DIR_ENVIRONMENT, original_git_dir, 1);
+	else
+		unsetenv(GIT_DIR_ENVIRONMENT);
+	git_object_dir =3D NULL;
+	git_refs_dir =3D NULL;
+	git_index_file =3D NULL;
+	git_graft_file =3D NULL;
+	read_replace_refs =3D 1;
+}
+
 static void setup_git_env(void)
 {
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
@@ -184,6 +199,11 @@ char *get_graft_file(void)
=20
 int set_git_dir(const char *path)
 {
+	static int original_git_dir_set =3D 0;
+	if (!original_git_dir_set) {
+		original_git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
+		original_git_dir_set =3D 1;
+	}
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
 		return error("Could not set GIT_DIR to '%s'", path);
 	setup_git_env();
diff --git a/git.c b/git.c
index 746470f..6a40304 100644
--- a/git.c
+++ b/git.c
@@ -146,14 +146,13 @@ static int handle_options(const char ***argv, int=
 *argc, int *envchanged)
 static int handle_alias(int *argcp, const char ***argv)
 {
 	int envchanged =3D 0, ret =3D 0, saved_errno =3D errno;
-	const char *subdir;
 	int count, option_count;
 	const char **new_argv;
 	const char *alias_command;
 	char *alias_string;
 	int unused_nongit;
=20
-	subdir =3D setup_git_directory_gently(&unused_nongit);
+	setup_git_directory_gently(&unused_nongit);
=20
 	alias_command =3D (*argv)[0];
 	alias_string =3D alias_lookup(alias_command);
@@ -210,8 +209,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 		ret =3D 1;
 	}
=20
-	if (subdir && chdir(subdir))
-		die_errno("Cannot change to '%s'", subdir);
+	unset_git_directory(startup_info->prefix);
=20
 	errno =3D saved_errno;
=20
@@ -240,8 +238,6 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
 	int status, help;
 	struct stat st;
=20
-	memset(&git_startup_info, 0, sizeof(git_startup_info));
-	startup_info =3D &git_startup_info;
 	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
 	if (!help) {
 		if (p->option & RUN_SETUP)
@@ -486,6 +482,9 @@ int main(int argc, const char **argv)
 {
 	const char *cmd;
=20
+	memset(&git_startup_info, 0, sizeof(git_startup_info));
+	startup_info =3D &git_startup_info;
+
 	cmd =3D git_extract_argv0_path(argv[0]);
 	if (!cmd)
 		cmd =3D "git-help";
diff --git a/setup.c b/setup.c
index 2f850ab..3264187 100644
--- a/setup.c
+++ b/setup.c
@@ -329,6 +329,8 @@ void unset_git_directory(const char *prefix)
 		die("Cannot change to '%s'", prefix);
=20
 	if (startup_info) {
+		if (startup_info->have_repository)
+			unset_git_env();
 		startup_info->prefix =3D NULL;
 		startup_info->have_repository =3D 0;
 	}
--=20
1.7.0.1.384.g6abcaa
