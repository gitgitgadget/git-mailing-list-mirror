From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 38/43] Allow to undo setup_git_directory_gently() gracefully (and fix alias code)
Date: Mon,  5 Apr 2010 20:41:23 +0200
Message-ID: <1270492888-26589-39-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:44:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrI3-0003NW-SD
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab0DESn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:59 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:18702 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab0DESn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:57 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1460397qwh.37
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JKe8i6h2QlQ7Wb5VOCFKtDYfWP3k972ctjDRvQWNW8Y=;
        b=FMSsIpgZlBb8Wi5zTcK3P4Fe8pFKWJR80LasMeE3yaAE2S1mxH42yBqpNPhQvQHTID
         /7maoUwlR+hViXt65SB4/sv7+VLMXkKe2nfM9At2Emll2tRYczdWBRMOxycCoTUr2ZCr
         RWQb0RLg9BImXLw+cheEBfyOdFKKiN72M7fwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HJy0j8+JTLhtx0B7F4bBWeZ/9PTjntQQSVArYe+lo3vl8WvYkSk4wKl2yfyYmgBrm8
         aDJy6LejbibIbw8ZsqtAD71OIwvYwdfcNoG3LTSWjR0VAwkglu08KUZIWo081It11dCO
         aAcFTSQEPxi5v40z3Cv1Lo1bgj1cAAeBGdb2Q=
Received: by 10.224.107.203 with SMTP id c11mr2151297qap.262.1270493036200;
        Mon, 05 Apr 2010 11:43:56 -0700 (PDT)
Received: from dektop ([72.14.241.39])
        by mx.google.com with ESMTPS id 2sm509959qwi.59.2010.04.05.11.43.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:55 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:50 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144040>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h       |    1 +
 environment.c |   20 ++++++++++++++++++++
 git.c         |   11 +++++------
 setup.c       |    2 ++
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index bdcd1ec..137edac 100644
--- a/cache.h
+++ b/cache.h
@@ -422,6 +422,7 @@ extern void setup_work_tree(void);
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
index d60f792..17482dd 100644
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
index 858cf6b..b0269aa 100644
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
1.7.0.rc1.541.g2da82.dirty
