From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..
Date: Sun, 20 Dec 2015 14:50:18 +0700
Message-ID: <1450597819-26278-3-git-send-email-pclouds@gmail.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	asottile@umich.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 08:50:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAYlc-0002M6-4V
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 08:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbbLTHuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2015 02:50:51 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36350 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbbLTHuu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 02:50:50 -0500
Received: by mail-pf0-f177.google.com with SMTP id o64so71852765pfb.3
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 23:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XGdY2iQXXlVpjHq9+H/0sG+siQ9Byb2/SGlANgiJolc=;
        b=XQTfe/O9Bw3l0lPVDIzEywSW29Tqt/kSteDEIq8Ljjlvi9wgx9KNl+gT1IQwT+TV11
         NBg7++lQ58JLVF9IOVkFh4AUZfkrdHYmI3R6XGMqS4l4K2/5q+7AlijG+zn5hzQxBvaN
         ofVviTqwwOFCF9sqRIQvdxJs9rguPq/7GzgZkpol0Dwq0eZ+KfeNT4q67+2Y3EtVCYYM
         FbRiyBTn7gBwmX6QJ1J5K4rTgZfjJ4HFeu6toS67KVqMO5F2JcYM7/auN7LX4OqguS6Y
         ywl7CBwNN+Zrr1jxQe+EVGLLuBK1RiKMtyLrTc2vuXwDJ18uQy28S6M4iuQmbSfwFP4P
         SboA==
X-Received: by 10.98.64.92 with SMTP id n89mr17992039pfa.159.1450597847917;
        Sat, 19 Dec 2015 23:50:47 -0800 (PST)
Received: from lanh ([171.233.236.127])
        by smtp.gmail.com with ESMTPSA id w62sm27216623pfi.48.2015.12.19.23.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Dec 2015 23:50:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 20 Dec 2015 14:50:46 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1450597819-26278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282766>

Commit d95138e [1] fixes a .git file problem by setting GIT_WORK_TREE
whenever GIT_DIR is set. It sounded harmless because we handle
GIT_DIR and GIT_WORK_TREE side by side for most commands, with two
exceptions: git-init and git-clone.

"git clone" is not happy with d95138e. This command ignores GIT_DIR
but respects GIT_WORK_TREE [2] [3] which means it used to run fine
from a hook, where GIT_DIR was set but GIT_WORK_TREE was not (*). With
d95138e, GIT_WORK_TREE is set all the time and git-clone interprets
that as "I give you order to put the worktree here", usually against
the user's intention.

The solution in d95138e is reverted in this commit. Instead we reuse
the solution from c056261 [4]. c056261 fixes another setup-messed-
up-by-alias by saving and restoring env and spawning a new process,
but for git-clone and git-init only. Now I conclude that setup-messed-
up-by-alias is always evil. So the env restoration is done for _all_
commands, including external ones, whenever aliases are involved. It
fixes what d95138e tries to fix. And it does not upset git-clone-
inside-hooks.

The test from d95138e remains to verify it's not broken by this. A new
test is added to make sure git-clone-inside-hooks remains happy.

(*) GIT_WORK_TREE was not set _most of the time_. In some cases
    GIT_WORK_TREE is set and git-clone will behave differently. The
    use of GIT_WORK_TREE to direct git-clone to put work tree
    elsewhere looks like a mistake because it causes surprises this
    way. But that's a separate story.

[1] d95138e (setup: set env $GIT_WORK_TREE when work tree is set, like
             $GIT_DIR - 2015-06-26)
[2] 2beebd2 (clone: create intermediate directories of destination
             repo - 2008-06-25)
[3] 20ccef4 (make git-clone GIT_WORK_TREE aware - 2007-07-06)
[4] c056261 (git potty: restore environments after alias expansion -
             2014-06-08)

Reported-by: Anthony Sottile <asottile@umich.edu>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 environment.c    |  2 --
 git.c            | 23 ++++++++++++-----------
 t/t5601-clone.sh | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/environment.c b/environment.c
index 2da7fe2..1cc4aab 100644
--- a/environment.c
+++ b/environment.c
@@ -235,8 +235,6 @@ void set_git_work_tree(const char *new_work_tree)
 	}
 	git_work_tree_initialized =3D 1;
 	work_tree =3D xstrdup(real_path(new_work_tree));
-	if (setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1))
-		die("could not set GIT_WORK_TREE to '%s'", work_tree);
 }
=20
 const char *get_git_work_tree(void)
diff --git a/git.c b/git.c
index 6ce7043..1a7d399 100644
--- a/git.c
+++ b/git.c
@@ -226,7 +226,6 @@ static int handle_options(const char ***argv, int *=
argc, int *envchanged)
 static int handle_alias(int *argcp, const char ***argv)
 {
 	int envchanged =3D 0, ret =3D 0, saved_errno =3D errno;
-	const char *subdir;
 	int count, option_count;
 	const char **new_argv;
 	const char *alias_command;
@@ -234,7 +233,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 	int unused_nongit;
=20
 	save_env_before_alias();
-	subdir =3D setup_git_directory_gently(&unused_nongit);
+	setup_git_directory_gently(&unused_nongit);
=20
 	alias_command =3D (*argv)[0];
 	alias_string =3D alias_lookup(alias_command);
@@ -292,8 +291,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 		ret =3D 1;
 	}
=20
-	if (subdir && chdir(subdir))
-		die_errno("Cannot change to '%s'", subdir);
+	restore_env();
=20
 	errno =3D saved_errno;
=20
@@ -308,7 +306,6 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE		(1<<3)
-#define NO_SETUP		(1<<4)
=20
 struct cmd_struct {
 	const char *cmd;
@@ -390,7 +387,7 @@ static struct cmd_struct commands[] =3D {
 	{ "cherry", cmd_cherry, RUN_SETUP },
 	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
-	{ "clone", cmd_clone, NO_SETUP },
+	{ "clone", cmd_clone },
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
@@ -416,8 +413,8 @@ static struct cmd_struct commands[] =3D {
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
-	{ "init", cmd_init_db, NO_SETUP },
-	{ "init-db", cmd_init_db, NO_SETUP },
+	{ "init", cmd_init_db },
+	{ "init-db", cmd_init_db },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
@@ -531,9 +528,13 @@ static void handle_builtin(int argc, const char **=
argv)
=20
 	builtin =3D get_builtin(cmd);
 	if (builtin) {
-		if (saved_env_before_alias && (builtin->option & NO_SETUP))
-			restore_env();
-		else
+		/*
+		 * XXX: if we can figure out cases where it is _safe_
+		 * to do, we can avoid spawning a new process when
+		 * saved_env_before_alias is true
+		 * (i.e. setup_git_dir* has been run once)
+		 */
+		if (!saved_env_before_alias)
 			exit(run_builtin(builtin, argc, argv));
 	}
 }
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9b34f3c..31b4658 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -65,6 +65,29 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
=20
 '
=20
+test_expect_success 'clone from hooks' '
+
+	test_create_repo r0 &&
+	cd r0 &&
+	test_commit initial &&
+	cd .. &&
+	git init r1 &&
+	cd r1 &&
+	cat >.git/hooks/pre-commit <<-\EOF &&
+	#!/bin/sh
+	git clone ../r0 ../r2
+	exit 1
+	EOF
+	chmod u+x .git/hooks/pre-commit &&
+	: >file &&
+	git add file &&
+	test_must_fail git commit -m invoke-hook &&
+	cd .. &&
+	test_cmp r0/.git/HEAD r2/.git/HEAD &&
+	test_cmp r0/initial.t r2/initial.t
+
+'
+
 test_expect_success 'clone creates intermediate directories' '
=20
 	git clone src long/path/to/dst &&
--=20
2.3.0.rc1.137.g477eb31
