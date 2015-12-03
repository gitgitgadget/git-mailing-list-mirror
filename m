From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..
Date: Thu,  3 Dec 2015 19:17:56 +0100
Message-ID: <1449166676-30845-2-git-send-email-pclouds@gmail.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
 <1449166676-30845-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	asottile@umich.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 03 19:18:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4YSd-0001fd-Pd
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 19:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbbLCSS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Dec 2015 13:18:28 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35052 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbbLCSSY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 13:18:24 -0500
Received: by wmuu63 with SMTP id u63so32681849wmu.0
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 10:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RPBvR4V868uni1XUZP/hov59ecoHZpESz2yVIBt+z18=;
        b=fOA7HEcWvJYti4yQWFzhOgQmJcaPwmUvTjthkcSIF6x1CX5xkP8jgJspvsfFq04+22
         qyWNbXj1srPlU3PaAr/2+fc7tvK+LAdJrkbqEZ0ri5U+SKTXr/GUq3s0X3WJhjmAbK1r
         s/k4dXTAtz15PX2E1uWH8oRIs/jdfdOV0CU5eXHGQ4zHVbCLPTPW1c2+Xd8V1cgs2i0b
         GJGHv+Fu0qFMoQIEMJtsTMel4lqNdcI0GvwRL52UFUebd8QqslNLXCTZH5Og9Ve+JO7L
         DacM3VGkz6xg4dNm6tLvshrSGTN9xGXKr697UWSZHL8rcms+gWjvAe1dxJh8mMBRqScu
         rhYA==
X-Received: by 10.194.87.99 with SMTP id w3mr12893509wjz.76.1449166703304;
        Thu, 03 Dec 2015 10:18:23 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id e83sm52672wmc.23.2015.12.03.10.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Dec 2015 10:18:21 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281960>

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

The solution in d95138e is reverted in this commit. Instead we reuse th=
e
solution from c056261 [4]. c056261 fixes another setup-messed-up-by-ali=
as
by saving and restoring env for git-clone and git-init. Now I conclude
that setup-messed-by-alias is always evil. So the env restoration is
done for _all_ commands  whenever aliases are involved. It fixes what
d95138e tries to fix. And it does not upset git-clone-inside-hooks.

The test from d95138e remains to verify it's not broken by this. A new
test is added to make sure git-clone-inside-hooks remains happy.

In future, perhaps we should look up aliases in a separate process
(provided that Windows folks are happy with one extra process). It'll b=
e
cleanest.

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
 This may be a brilliant fix, or another invitation for regressions.

 environment.c    |  2 --
 git.c            |  9 ++++-----
 t/t5601-clone.sh | 23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)

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
index 6ce7043..e2f187d 100644
--- a/git.c
+++ b/git.c
@@ -308,7 +308,6 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE		(1<<3)
-#define NO_SETUP		(1<<4)
=20
 struct cmd_struct {
 	const char *cmd;
@@ -390,7 +389,7 @@ static struct cmd_struct commands[] =3D {
 	{ "cherry", cmd_cherry, RUN_SETUP },
 	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
-	{ "clone", cmd_clone, NO_SETUP },
+	{ "clone", cmd_clone },
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
@@ -416,8 +415,8 @@ static struct cmd_struct commands[] =3D {
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
@@ -531,7 +530,7 @@ static void handle_builtin(int argc, const char **a=
rgv)
=20
 	builtin =3D get_builtin(cmd);
 	if (builtin) {
-		if (saved_env_before_alias && (builtin->option & NO_SETUP))
+		if (saved_env_before_alias)
 			restore_env();
 		else
 			exit(run_builtin(builtin, argc, argv));
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
2.2.0.513.g477eb31
