From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git-init: set core.workdir when GIT_WORK_DIR is specified
Date: Sat, 17 Mar 2007 02:58:55 +0100
Message-ID: <20070317015855.GB19305@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 02:59:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSOCD-0002ay-Bd
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 02:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933626AbXCQB67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 21:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933647AbXCQB67
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 21:58:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:39047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933626AbXCQB66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 21:58:58 -0400
Received: (qmail invoked by alias); 17 Mar 2007 01:58:56 -0000
X-Provags-ID: V01U2FsdGVkX1/qFmgTv/LqerSynPkNHgAn6H1CL3ZVcxB+Z7mU0B
	hDSm+0avgSF/PM
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42416>

git init will die with an error message before doing anything if the
value of GIT_WORK_DIR is no valid directory.  GIT_WORK_DIR is also
expanded to an absolute path for the config file and is shown to the
user (core.workdir = <path>).

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
This patch is on top of the 'test GIT_WORK_DIR' patch, both are for
the ml/workdir branch which is merged in pu.

The test only tests if core.workdir is set and not if it is the
correct directory.  Is there any nice way to do this?  `pwd` will keep
symlinks in the path but getcwd() wont, perhaps PWD= OLDPWD= sh -c pwd
could do it but I don't really like it.  Comparing stat -c %d.%i for
the two directories would work but this is not portable (e.g. for
freebsd this had to be stat -f %d.%i).
---
 builtin-init-db.c  |   33 ++++++++++++++++++++++++++++++++-
 t/t9998-workdir.sh |   15 +++++++++++++++
 2 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4df9fd0..f0cedb5 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -182,6 +182,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	char repo_version_string[10];
 	int reinit;
 	int filemode;
+	const char *git_work_dir = getenv(GIT_WORKING_DIR_ENVIRONMENT);
 
 	if (len > sizeof(path)-50)
 		die("insane git directory %s", git_dir);
@@ -252,7 +253,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository()) {
+	if (is_bare_repository() && !git_work_dir) {
 		git_config_set("core.bare", "true");
 	}
 	else {
@@ -260,6 +261,10 @@ static int create_default_files(const char *git_dir, const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
+		if (git_work_dir) {
+			git_config_set("core.workdir", git_work_dir);
+			printf("core.workdir = %s\n", git_work_dir);
+		}
 	}
 	return reinit;
 }
@@ -276,6 +281,7 @@ static const char init_db_usage[] =
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *git_work_dir;
 	const char *sha1_dir;
 	const char *template_dir = NULL;
 	char *path;
@@ -294,6 +300,31 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	}
 
 	/*
+	 * check value of $GIT_WORK_DIR
+	 * if it is set it has to be a valid directory
+	 */
+	git_work_dir = getenv(GIT_WORKING_DIR_ENVIRONMENT);
+	if (git_work_dir) {
+		char cwd[PATH_MAX];
+
+		if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+			die("Unable to read current working directory");
+		if (chdir(git_work_dir))
+			die("chdir to specified working directory %s failed",
+				git_work_dir);
+		/* get absolute path */
+		if (git_work_dir[0] != '/') {
+			char workdir[PATH_MAX];
+			if (!getcwd(workdir, sizeof(workdir)) ||
+				workdir[0] != '/')
+				die("Unable to read current working directory");
+			setenv(GIT_WORKING_DIR_ENVIRONMENT, workdir, 1);
+		}
+		if (chdir(cwd))
+			die("Cannot come back to cwd");
+	}
+
+	/*
 	 * Set up the default .git directory contents
 	 */
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
diff --git a/t/t9998-workdir.sh b/t/t9998-workdir.sh
index 57a2235..940ad1d 100755
--- a/t/t9998-workdir.sh
+++ b/t/t9998-workdir.sh
@@ -88,4 +88,19 @@ test_expect_success 'repository/workdir: --is-bare-repository' \
 test_expect_success 'repository/workdir: --is-inside-git-dir' \
 	'test "false" = "$(git rev-parse --is-inside-git-dir)"'
 
+# git init
+cd "$top" || exit 1
+export GIT_DIR=$(pwd)/repository2
+test_expect_failure 'git --work-dir non-existent init' \
+	'git --work-dir non-existent init'
+test_expect_success 'git --work-dir working/directory init' \
+	'git --work-dir working/directory init'
+test_expect_success 'config knows core.workdir' \
+	'git config core.workdir'
+git config --unset core.workdir || exit 1
+test_expect_success 'git --work-dir `pwd`/working init' \
+	'git --work-dir "$(pwd)"/working init'
+test_expect_success 'config knows core.workdir' \
+	'git config core.workdir'
+
 test_done
-- 
1.5.0.4.408.g563e1
