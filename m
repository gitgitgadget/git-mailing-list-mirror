From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Fix "t0001: test git init when run via an alias"
Date: Sun,  8 Jun 2014 16:37:10 +0700
Message-ID: <1402220230-799-1-git-send-email-pclouds@gmail.com>
References: <20140606110935.GA14446@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	dturner@twopensource.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 11:37:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtZXq-00076E-Li
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jun 2014 11:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbaFHJhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2014 05:37:36 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:61308 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbaFHJhf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2014 05:37:35 -0400
Received: by mail-ig0-f179.google.com with SMTP id r2so633839igi.6
        for <git@vger.kernel.org>; Sun, 08 Jun 2014 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cweyP3mZCScCPSE1XrGdJrPevaZOjBInqh7O/wXRt0U=;
        b=VWhjEXMxHzzdYd4e5jEIhWf1RHViV6nAG/kn1i6gByILZ8q8NwiSKNMks3y8ypYigd
         oI2YocRwonxMtGc0hjjQxiFYvZxHW2Ar+xQzj4ZUScrrVM42eB3muX3R4eSfu7vD26K/
         QUL3F6jRLupFsf34qIdx6ufMeD401Qi1aaoSyVu+KOliZfjtdco5ZgdzPk1CUVn/1RNY
         xjgE47X7itSH2/tiOnoa/3vBvWVgJWkafYjB9gFanN419CKJTAeHN0YgcW7gHMHA+xXe
         +i97PJ5VyCI9ztfjpI/Jk9MlWOMe16XBxPVC8DiW7l+VzOmPvTuQ3jmgOTazrG/c9g82
         kkRQ==
X-Received: by 10.50.29.9 with SMTP id f9mr18318476igh.39.1402220254331;
        Sun, 08 Jun 2014 02:37:34 -0700 (PDT)
Received: from lanh ([115.73.253.149])
        by mx.google.com with ESMTPSA id dz3sm6943514igb.3.2014.06.08.02.37.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jun 2014 02:37:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Jun 2014 16:37:31 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <20140606110935.GA14446@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251052>

Commit 4ad8332 (t0001: test git init when run via an alias -
2010-11-26) noted breakages when running init via alias. The problem
is for alias to be used, $GIT_DIR must be searched, but 'init' and
'clone' are not happy with that. So we start a new process like an
external command, with clean environment in this case. Env variables
that are set by command line (e.g. "git --git-dir=3D.. ") are kept.

This should also fix autocorrecting a command typo to "init" because
it's the same problem: aliases are read, then "init" is unhappy with
$GIT_DIR already set up because of that.

Reminded-by: David Turner <dturner@twopensource.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c           | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-=
---
 t/t0001-init.sh |  4 ++--
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 7780572..d1e49da 100644
--- a/git.c
+++ b/git.c
@@ -20,6 +20,42 @@ const char git_more_info_string[] =3D
=20
 static struct startup_info git_startup_info;
 static int use_pager =3D -1;
+static char orig_cwd[PATH_MAX];
+static const char *env_names[] =3D {
+	GIT_DIR_ENVIRONMENT,
+	GIT_WORK_TREE_ENVIRONMENT,
+	GIT_IMPLICIT_WORK_TREE_ENVIRONMENT,
+	GIT_PREFIX_ENVIRONMENT
+};
+static char *orig_env[4];
+static int saved_environment;
+
+static void save_env(void)
+{
+	int i;
+	if (saved_environment)
+		return;
+	saved_environment =3D 1;
+	getcwd(orig_cwd, sizeof(orig_cwd));
+	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
+		orig_env[i] =3D getenv(env_names[i]);
+		if (orig_env[i])
+			orig_env[i] =3D xstrdup(orig_env[i]);
+	}
+}
+
+static void restore_env(void)
+{
+	int i;
+	if (*orig_cwd && chdir(orig_cwd))
+		die_errno("could not move to %s", orig_cwd);
+	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
+		if (orig_env[i])
+			setenv(env_names[i], orig_env[i], 1);
+		else
+			unsetenv(env_names[i]);
+	}
+}
=20
 static void commit_pager_choice(void) {
 	switch (use_pager) {
@@ -272,6 +308,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE		(1<<3)
+#define NO_SETUP		(1<<4)
=20
 struct cmd_struct {
 	const char *cmd;
@@ -352,7 +389,7 @@ static struct cmd_struct commands[] =3D {
 	{ "cherry", cmd_cherry, RUN_SETUP },
 	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
-	{ "clone", cmd_clone },
+	{ "clone", cmd_clone, NO_SETUP },
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
@@ -378,8 +415,8 @@ static struct cmd_struct commands[] =3D {
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
-	{ "init", cmd_init_db },
-	{ "init-db", cmd_init_db },
+	{ "init", cmd_init_db, NO_SETUP },
+	{ "init-db", cmd_init_db, NO_SETUP },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
@@ -484,6 +521,10 @@ static void handle_builtin(int argc, const char **=
argv)
 		struct cmd_struct *p =3D commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
+		if (saved_environment && (p->option & NO_SETUP)) {
+			restore_env();
+			break;
+		}
 		exit(run_builtin(p, argc, argv));
 	}
 }
@@ -539,7 +580,10 @@ static int run_argv(int *argcp, const char ***argv=
)
 		 * of overriding "git log" with "git show" by having
 		 * alias.log =3D show
 		 */
-		if (done_alias || !handle_alias(argcp, argv))
+		if (done_alias)
+			break;
+		save_env();
+		if (!handle_alias(argcp, argv))
 			break;
 		done_alias =3D 1;
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 2f30203..e62c0ff 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -56,7 +56,7 @@ test_expect_success 'plain through aliased command, o=
utside any git repo' '
 	check_config plain-aliased/.git false unset
 '
=20
-test_expect_failure 'plain nested through aliased command' '
+test_expect_success 'plain nested through aliased command' '
 	(
 		git init plain-ancestor-aliased &&
 		cd plain-ancestor-aliased &&
@@ -68,7 +68,7 @@ test_expect_failure 'plain nested through aliased com=
mand' '
 	check_config plain-ancestor-aliased/plain-nested/.git false unset
 '
=20
-test_expect_failure 'plain nested in bare through aliased command' '
+test_expect_success 'plain nested in bare through aliased command' '
 	(
 		git init --bare bare-ancestor-aliased.git &&
 		cd bare-ancestor-aliased.git &&
--=20
1.9.1.346.ga2b5940
