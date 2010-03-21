From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 17/19] Allow to undo setup_git_directory_gently() gracefully (and fix alias code)
Date: Sun, 21 Mar 2010 17:30:44 +0700
Message-ID: <1269167446-7799-18-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:36:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIW4-0003nh-1R
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab0CUKgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:36:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33481 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab0CUKgO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:36:14 -0400
Received: by gwaa18 with SMTP id a18so510222gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fzD+ajAOxiEd58mwv9Jsa0QfYYvhnxp/8tE5oorJVnc=;
        b=LSmbNpq+GvbXxFf4WFIb3BKwZV0F6bnzFiTmgp9LKSpAYcwnO5PyJ305x7WH09+5Pd
         nwLvbXjT3olLNQWfuSibPozoyfQywYAcxQl1Uw8b8aFL4ZwNr4AyfjuJKmJpsUUeo1Y5
         IhXpvzbnEtl6nl9uo1+4c6TCFYkqmUqxs/UVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fUleyosatD5U5vYuA7R5enJbGoQpKPa9acQoEn9+Qox3WOk0k4oeJryWdVFNdZxkWH
         0btU8y6eIppUF7mRKflLGVs9KSZXhbKJUeCPFU13NFCkuoaiEsiuFTggwfqdpn05QRKj
         cZWdXEb+8KkWbEUNYH5NfO0Zk342g46+Nq0bU=
Received: by 10.150.128.41 with SMTP id a41mr2537196ybd.245.1269167773383;
        Sun, 21 Mar 2010 03:36:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 21sm2427976iwn.7.2010.03.21.03.36.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:36:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:32:31 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142812>

unset_git_directory() can only clean up things as long as
set_git_dir() has not been called because set_git_dir() sets internal
state itself. Even worse, set_git_dir() may override $GIT_DIR env
variable.

Add unset_git_env() to undo set_git_dir(), allow unset_git_directory()
to undo a succesful setup_git_directory_gently().

While at there, fix alias handling code regarding git_dir {,un-}setup,
use unset_git_directory() instead of just chdir() back.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       |    1 +
 environment.c |   20 ++++++++++++++++++++
 git.c         |   11 +++++------
 setup.c       |    2 ++
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index e397e1d..b1ed150 100644
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
index 7e30498..db5bd95 100644
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
 	int status;
 	struct stat st;
=20
-	memset(&git_startup_info, 0, sizeof(git_startup_info));
-	startup_info =3D &git_startup_info;
 	startup_info->help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
 	if (!startup_info->help) {
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
index 4de7bf0..1808ebe 100644
--- a/setup.c
+++ b/setup.c
@@ -336,6 +336,8 @@ void unset_git_directory(const char *prefix)
 		die("Cannot change to '%s'", prefix);
=20
 	if (startup_info) {
+		if (startup_info->have_repository)
+			unset_git_env();
 		startup_info->prefix =3D NULL;
 		startup_info->have_repository =3D 0;
 	}
--=20
1.7.0.2.425.gb99f1
