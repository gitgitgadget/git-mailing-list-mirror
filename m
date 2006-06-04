From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Support for configurable git command aliases (v2)
Date: Sun, 04 Jun 2006 23:19:31 +0200
Message-ID: <20060604211931.10117.82695.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 04 23:19:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn000-0005U8-1Y
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 23:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWFDVS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 17:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWFDVS7
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 17:18:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58752 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932242AbWFDVS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 17:18:59 -0400
Received: (qmail 10131 invoked from network); 4 Jun 2006 23:19:31 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 4 Jun 2006 23:19:31 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21284>

This patch adds support for configurable aliases for git commands -
"alias.WHATEVER = which ever" will kick in when you do "git WHATEVER"
and substitute WHATEVER with "which ever" (splitted to arguments at
whitespaces).

The second version does all the work in handle_aliases() which was
inspired by Johannes Schindelin's patch.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/config.txt |    5 ++++
 Documentation/git.txt    |    3 ++
 git.c                    |   60 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c861c6c..aaaa33d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -91,6 +91,11 @@ core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
 	and might match multiple refs in the .git/refs/ tree. True by default.
 
+alias.*::
+	Command aliases for the gitlink:git[1] command wrapper - e.g.
+	after defining "alias.last = cat-file commit HEAD", the invocation
+	"git last" is equivalent to "git cat-file commit HEAD".
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
diff --git a/git.c b/git.c
index bc463c9..50850fb 100644
--- a/git.c
+++ b/git.c
@@ -10,6 +10,7 @@ #include <limits.h>
 #include <stdarg.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
+#include "cache.h" /* setup_git_directory_gently() */
 
 #include "builtin.h"
 
@@ -88,13 +89,65 @@ static void handle_internal_command(int 
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
+
+	if (!isatty(1))
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
@@ -121,6 +174,7 @@ int main(int argc, const char **argv, ch
 	if (!strncmp(cmd, "git-", 4)) {
 		cmd += 4;
 		argv[0] = cmd;
+		handle_alias(&argc, &argv);
 		handle_internal_command(argc, argv, envp);
 		die("cannot handle %s internally", cmd);
 	}
@@ -178,7 +232,7 @@ int main(int argc, const char **argv, ch
 	exec_path = git_exec_path();
 	prepend_to_path(exec_path, strlen(exec_path));
 
-	/* See if it's an internal command */
+	handle_alias(&argc, &argv);
 	handle_internal_command(argc, argv, envp);
 
 	/* .. then try the external ones */
