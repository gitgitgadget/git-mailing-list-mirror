From: Martin Waitz <tali@admingilde.org>
Subject: [RFC] move --show-cdup, --show-prefix, and --show-git-dir out of git-rev-parse.
Date: Sat, 7 Oct 2006 23:04:29 +0200
Message-ID: <20061007210429.GA2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 07 23:04:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWJLW-0003Me-0S
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 23:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbWJGVEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 17:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932862AbWJGVEb
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 17:04:31 -0400
Received: from agent.admingilde.org ([213.95.21.5]:51617 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932861AbWJGVEa
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 17:04:30 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GWJLR-00079B-Ay
	for git@vger.kernel.org; Sat, 07 Oct 2006 23:04:29 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28506>

They don't really have anything to do with refs.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 Makefile              |    1 +
 builtin-show-prefix.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h             |    3 +++
 git.c                 |    3 +++
 4 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 2c7c338..c072162 100644
--- a/Makefile
+++ b/Makefile
@@ -298,6 +298,7 @@ BUILTIN_OBJS = \
 	builtin-rm.o \
 	builtin-runstatus.o \
 	builtin-show-branch.o \
+	builtin-show-prefix.o \
 	builtin-stripspace.o \
 	builtin-symbolic-ref.o \
 	builtin-tar-tree.o \
diff --git a/builtin-show-prefix.c b/builtin-show-prefix.c
new file mode 100644
index 0000000..ed46434
--- /dev/null
+++ b/builtin-show-prefix.c
@@ -0,0 +1,50 @@
+/*
+ * Show some information about the GIT repository
+ */
+
+#include "builtin.h"
+#include "cache.h"
+
+int cmd_show_prefix(int argc, const char **argv, const char *prefix)
+{
+	if (prefix)
+		puts(prefix);
+
+	return 0;
+}
+
+int cmd_show_cdup(int argc, const char **argv, const char *prefix)
+{
+	const char *pfx = prefix;
+
+	while (pfx) {
+		pfx = strchr(pfx, '/');
+		if (pfx) {
+			pfx++;
+			printf("../");
+		}
+	}
+	putchar('\n');
+	
+	return 0;
+}
+
+int cmd_show_git_dir(int argc, const char **argv, const char *prefix)
+{
+	const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
+	static char cwd[PATH_MAX];
+
+	if (gitdir) {
+		puts(gitdir);
+		return 0;
+	}
+	if (!prefix) {
+		puts(".git");
+		return 0;
+	}
+	if (!getcwd(cwd, PATH_MAX))
+		die("unable to get current working directory");
+	printf("%s/.git\n", cwd);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index f9fa9ff..fb313d8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -49,6 +49,9 @@ extern int cmd_rev_parse(int argc, const
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_runstatus(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_show_cdup(int argc, const char **argv, const char *prefix);
+extern int cmd_show_git_dir(int argc, const char **argv, const char *prefix);
+extern int cmd_show_prefix(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index b8e8622..3f2eada 100644
--- a/git.c
+++ b/git.c
@@ -255,6 +255,9 @@ static void handle_internal_command(int 
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "runstatus", cmd_runstatus, RUN_SETUP },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
+		{ "show-cdup", cmd_show_cdup, RUN_SETUP },
+		{ "show-git-dir", cmd_show_git_dir, RUN_SETUP },
+		{ "show-prefix", cmd_show_prefix, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-- 
1.4.2.3

-- 
Martin Waitz
