From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH 3/3] Check repository format version.
Date: Wed, 23 Nov 2005 19:36:53 -0800
Message-ID: <7v8xvezpgq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 04:37:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef7v0-0004gl-8G
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 04:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVKXDgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 22:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbVKXDgz
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 22:36:55 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41414 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932624AbVKXDgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 22:36:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124033627.KMA3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 22:36:27 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12673>

Add check_repository_format() that is to be called when we know
where the configuration file is and die if the format version
is too new to be understood by us.

Use it in enter_repo(), setup_git_directory(), and git-find-git
to prevent the commands that use them to corrupt future git
repositories.  What this patch does not cover are commands that
implicitly assumes it is always run from the toplevel, or the
user tells us where the git directory is with the GIT_DIR
environment variable.

setup_git_directory() users that could corrupt future repository
without this change are:

	config-set symbolic-ref update-index update-ref

and that could yield incorrect results are:

	cat-file diff-files diff-index diff-stages diff-tree
	ls-files name-rev rev-list rev-parse show-branch

enter_repo() users are:

	daemon receive-pack upload-pack

git-find-git is used by git-sh-setup, which means most of the
barebone Porcelain scripts are covered with this change upfront.
This might be enough for everyday use to futureproof us.

The repository format check code was originally done by Martin
Atukunda.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * The checks in this version is less intrusive compared to
   Martin's version, and tries to check only once when we know
   where the configuration file should be.

 cache.h         |    2 +-
 find-git.c      |    5 +++--
 git-sh-setup.sh |    2 +-
 path.c          |    1 +
 setup.c         |   24 ++++++++++++++++++++++--
 5 files changed, 28 insertions(+), 6 deletions(-)

applies-to: cfcbe85286bb9bfb4f04169269c543640626218d
08279559b1d63107c4e25abb4c882ad21e1ad43b
diff --git a/cache.h b/cache.h
index 7cde341..c3e46f3 100644
--- a/cache.h
+++ b/cache.h
@@ -185,7 +185,7 @@ extern int diff_rename_limit_default;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
-extern int check_repo_format(void);
+extern int check_repository_format(void);
 
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
diff --git a/find-git.c b/find-git.c
index e063425..430ba7c 100644
--- a/find-git.c
+++ b/find-git.c
@@ -14,9 +14,10 @@ int main(int ac, char **av)
 	 */
 	git_config(git_default_config);
 
-	/* Later we check repository version and exit with non-zero
-	 * status after issuing an error message here.
+	/* This would die after issuing an error message if we 
+	 * do not understand the repository format.
 	 */
+	check_repository_format();
 
 	if (!prefix)
 		/* we are at the project toplevel or GIT_DIR is set.
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 8e30bf6..2485bb9 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -37,6 +37,6 @@ case "$?" in
 
 	# (128) git-find-git died -- malformed configuration and that
 	# is really fatal.  We have already given the error message.
-
+	exit $?
 	;;
 esac
diff --git a/path.c b/path.c
index 4d88947..2c077c0 100644
--- a/path.c
+++ b/path.c
@@ -199,6 +199,7 @@ char *enter_repo(char *path, int strict)
 	if(access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
 	   validate_symref("HEAD") == 0) {
 		putenv("GIT_DIR=.");
+		check_repository_format();
 		return current_dir();
 	}
 
diff --git a/setup.c b/setup.c
index f64ca23..48be931 100644
--- a/setup.c
+++ b/setup.c
@@ -73,7 +73,7 @@ const char **get_pathspec(const char *pr
 }
 
 /*
- * Test it it looks like we're at the top
+ * Test if it looks like we're at the top
  * level git directory. We want to see a
  *
  *  - either a .git/objects/ directory _or_ the proper
@@ -135,5 +135,25 @@ const char *setup_git_directory_gently(i
 
 const char *setup_git_directory(void)
 {
-	return setup_git_directory_gently(NULL);
+	const char *retval = setup_git_directory_gently(NULL);
+	check_repository_format();
+	return retval;
+}
+
+static int check_repository_format_version(const char *var, const char *value)
+{
+       if (strcmp(var, "core.repositoryformatversion") == 0) {
+               repository_format_version = git_config_int(var, value);
+       }
+       return 0;
+}
+
+int check_repository_format(void)
+{
+	if (git_config(check_repository_format_version) == -1)
+		return -1;
+	if (GIT_REPO_VERSION < repository_format_version)
+		die("Expected git repo version <= %d, found %d",
+		    GIT_REPO_VERSION, repository_format_version);
+	return 0;
 }
---
0.99.9.GIT
