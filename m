From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Support for configurable git command aliases
Date: Sun, 28 May 2006 23:59:45 +0200
Message-ID: <20060528215945.GD10488@pasky.or.cz>
References: <torvalds@osdl.org> <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org> <200605271252.k4RCqZhR003192@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Roskin <proski@gnu.org>,
	Timo Hirvonen <tihirvon@gmail.com>,
	Anand Kumria <wildfire@progsoc.uts.edu.au>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 28 23:59:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkTIY-0003zV-NP
	for gcvg-git@gmane.org; Sun, 28 May 2006 23:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWE1V7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 17:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWE1V7n
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 17:59:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1427 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750969AbWE1V7n (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 17:59:43 -0400
Received: (qmail 23026 invoked by uid 2001); 28 May 2006 23:59:45 +0200
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200605271252.k4RCqZhR003192@laptop11.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20898>

Dear diary, on Sat, May 27, 2006 at 02:52:35PM CEST, I got a letter
where Horst von Brand <vonbrand@inf.utfsm.cl> said that...
> > So they would do "alias cvs git" in a desperate attempt to save themselves 
> > from CVS, and then add
> > 
> > 	[alias "co"]
> > 		cmd = commit -a
> 
> I don't like this syntax. What other stuff (beside "cmd") would be under
> "[alias "co"]? Why not simply:
> 
>         [alias]
> 		co = commit -a
> 		publish = push public.site.com:/pub/scm/my-public-repo

Nice, I like this.

Well, the following isn't exactly the nicest code I have ever written...
But it seems to work. ;-)

---

This patch adds support for configurable aliases for git commands -
"alias.WHATEVER = which ever" will kick in when you do "git WHATEVER"
and substitute WHATEVER with "which ever" (splitted to arguments at
whitespaces).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/config.txt |    5 ++++
 Documentation/git.txt    |    3 +++
 git.c                    |   52 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1a4bec..ce616e3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -83,6 +83,11 @@ core.warnAmbiguousRefs::
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
index 10ea934..0d9cd0e 100644
--- a/git.c
+++ b/git.c
@@ -10,6 +10,7 @@ #include <limits.h>
 #include <stdarg.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
+#include "cache.h" /* setup_git_directory_gently() */
 
 #include "builtin.h"
 
@@ -87,13 +88,27 @@ static void handle_internal_command(int 
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
@@ -165,6 +180,39 @@ int main(int argc, const char **argv, ch
 	}
 	argv[0] = cmd;
 
+	/* Is this an alias? */
+	{
+		/* XXX: We do a redundant git directory detection. */
+		int nongit = 0;
+		const char *subdir = setup_git_directory_gently(&nongit);
+
+		if (!nongit) {
+			git_config(git_alias_config);
+			if (cmdalias) {
+				/* More than the worst case: */
+				const char **argv2 = malloc((strlen(cmdalias) + argc) * sizeof(char*));
+				int argc2 = 0, i = 1;
+
+				while (cmdalias && *cmdalias) {
+					argv2[argc2++] = strsep(&cmdalias, " \t");
+					if (cmdalias)
+						while (*cmdalias == ' ' || *cmdalias == '\t')
+							cmdalias++;
+				}
+				while (i < argc) {
+					argv2[argc2++] = argv[i++];
+				}
+				argv2[argc2] = NULL;
+				argv = argv2;
+				argc = argc2;
+			}
+		}
+
+		/* Go back so that the commands start with clean table */
+		if (subdir)
+			chdir(subdir);
+	}
+
 	/*
 	 * We search for git commands in the following order:
 	 *  - git_exec_path()


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
