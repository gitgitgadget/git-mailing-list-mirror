From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Support for configurable git command aliases (v3)
Date: Wed, 07 Jun 2006 02:16:38 +0200
Message-ID: <20060607001638.5175.77792.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 07 02:16:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnlir-0004Um-Lt
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 02:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWFGAQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 20:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWFGAQa
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 20:16:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29349 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751397AbWFGAQa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 20:16:30 -0400
Received: (qmail 5189 invoked from network); 7 Jun 2006 02:16:38 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 7 Jun 2006 02:16:38 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21420>

This patch adds support for configurable aliases for git commands -
"alias.WHATEVER = which ever" will kick in when you do "git WHATEVER"
and substitute WHATEVER with "which ever" (splitted to arguments at
whitespaces).

The second version does all the work in handle_aliases() which was
inspired by Johannes Schindelin's patch.

The third version does not expand aliases when called as 'git-something'
or when the $GIT_NO_ALIASES environment variable is set; that is now
done in git-sh-setup.sh. The documentation has been slightly expanded.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/config.txt |   12 +++++++++
 Documentation/git.txt    |    3 ++
 git-sh-setup.sh          |    2 +
 git.c                    |   64 ++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c861c6c..071ff4e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -91,6 +91,18 @@ core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
 	and might match multiple refs in the .git/refs/ tree. True by default.
 
+alias.*::
+	Command aliases for the gitlink:git[1] command wrapper - e.g.
+	after defining "alias.last = cat-file commit HEAD", the invocation
+	"git last" is equivalent to "git cat-file commit HEAD". You can
+	override even existing command names with aliases (you can use that
+	to define some default set of parameters for some command). However,
+	there is only a single level of alias expansion - the alias definition
+	is not searched for aliases anymore. Alias checking is disabled when
+	the "$GIT_NO_ALIASES" environment variable is set - you should
+	definitely do that if you call commands by the 'git' wrapper in your
+	scripts.
+
 apply.whitespace::
 	Tells `git-apply` how to handle whitespaces, in the same way
 	as the '--whitespace' option. See gitlink:git-apply[1].
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 24ca55d..e474bdf 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -21,6 +21,9 @@ link:everyday.html[Everyday Git] for a u
 "man git-commandname" for documentation of each command.  CVS users may
 also want to read link:cvs-migration.html[CVS migration].
 
+The COMMAND is either a name of a Git command (see below) or an alias
+as defined in the configuration file (see gitlink:git-repo-config[1]).
+
 OPTIONS
 -------
 --version::
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d15747f..c56ae8c 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -49,3 +49,5 @@ then
 else
 	GIT_DIR=$(git-rev-parse --git-dir) || exit
 fi
+
+export GIT_NO_ALIASES=1
diff --git a/git.c b/git.c
index bc463c9..b85dafa 100644
--- a/git.c
+++ b/git.c
@@ -10,6 +10,7 @@ #include <limits.h>
 #include <stdarg.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
+#include "cache.h" /* setup_git_directory_gently() */
 
 #include "builtin.h"
 
@@ -88,13 +89,66 @@ static void handle_internal_command(int 
 	}
 }
 
+static const char *cmd;
+static char *cmdalias;
+
+int git_alias_config(const char *var, const char *value)
+{
+	if (strncmp(var, "alias.", 6))
+		return 0;
+	var += /* strlen("alias.") */ 6;
+	if (!strcmp(var, cmd))
+		cmdalias = strdup(value);
+	return 0;
+}
+
+void handle_alias(int *argc, const char ***argv)
+{
+	/* XXX: We do a redundant git directory detection. */
+	int nongit = 0;
+	const char *subdir;
+	char *env = getenv("GIT_NO_ALIASES");
+
+	if (!env || !*env)
+		return;
+
+	subdir = setup_git_directory_gently(&nongit);
+	if (!nongit) {
+		git_config(git_alias_config);
+		if (cmdalias) {
+			/* More than the worst case: */
+			const char **argv2 = malloc((strlen(cmdalias) + *argc) * sizeof(char*));
+			int argc2 = 0, i = 1;
+
+			while (cmdalias && *cmdalias) {
+				argv2[argc2++] = strsep(&cmdalias, " \t");
+				if (cmdalias)
+					while (*cmdalias == ' ' || *cmdalias == '\t')
+						cmdalias++;
+			}
+			while (i < *argc) {
+				argv2[argc2++] = (*argv)[i++];
+			}
+			argv2[argc2] = NULL;
+			*argv = argv2;
+			*argc = argc2;
+		}
+	}
+
+	/* Go back so that the commands start with clean table */
+	if (subdir)
+		chdir(subdir);
+}
+
+
 int main(int argc, const char **argv, char **envp)
 {
-	const char *cmd = argv[0];
-	char *slash = strrchr(cmd, '/');
+	char *slash = strrchr(argv[0], '/');
 	char git_command[PATH_MAX + 1];
 	const char *exec_path = NULL;
 
+	cmd = argv[0];
+
 	/*
 	 * Take the basename of argv[0] as the command
 	 * name, and the dirname as the default exec_path
@@ -117,6 +171,10 @@ int main(int argc, const char **argv, ch
 	 *
 	 * So we just directly call the internal command handler, and
 	 * die if that one cannot handle it.
+	 *
+	 * We also do not evaluate aliases in this case since git-log
+	 * should never expand to something unpredictable (that is
+	 * important e.g. for scripts).
 	 */
 	if (!strncmp(cmd, "git-", 4)) {
 		cmd += 4;
@@ -178,7 +236,7 @@ int main(int argc, const char **argv, ch
 	exec_path = git_exec_path();
 	prepend_to_path(exec_path, strlen(exec_path));
 
-	/* See if it's an internal command */
+	handle_alias(&argc, &argv);
 	handle_internal_command(argc, argv, envp);
 
 	/* .. then try the external ones */
