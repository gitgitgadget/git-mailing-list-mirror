From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Fix relative built-in paths to be relative to the command invocation
Date: Sun, 13 Jul 2008 22:31:21 +0200
Message-ID: <1215981083-10815-4-git-send-email-johannes.sixt@telecom.at>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org>
 <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-3-git-send-email-johannes.sixt@telecom.at>
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:32:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI8FZ-0005ZO-I7
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbYGMUbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbYGMUbd
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:31:33 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:37017 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295AbYGMUb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:31:28 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id C859634AAF;
	Sun, 13 Jul 2008 22:31:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.300.ga3a9
In-Reply-To: <1215981083-10815-3-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88332>

$(gitexecdir) (as defined in the Makefile) has gained another path
component, but the relative paths in the MINGW section of the Makefile,
which are interpreted relative to it, do not account for it.

Instead of adding another ../ in front of the path, we change the code that
constructs the absolute paths to do it relative to the command's directory,
which is essentially $(bindir). We do it this way because we will also
allow a relative $(gitexecdir) later.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile       |    2 +-
 exec_cmd.c     |   14 ++++++++++----
 exec_cmd.h     |    3 ++-
 git.c          |    5 ++---
 receive-pack.c |    2 +-
 shell.c        |    4 ++--
 upload-pack.c  |    2 +-
 7 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 4796565..2bdb9bf 100644
--- a/Makefile
+++ b/Makefile
@@ -1301,7 +1301,7 @@ remove-dashes:
 ### Installation rules
 
 ifeq ($(firstword $(subst /, ,$(template_dir))),..)
-template_instdir = $(gitexecdir)/$(template_dir)
+template_instdir = $(shell cd '$(bindir_SQ)/$(template_dir_SQ)' && pwd)
 else
 template_instdir = $(template_dir)
 endif
diff --git a/exec_cmd.c b/exec_cmd.c
index 8899e31..45f92eb 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -5,6 +5,7 @@
 
 extern char **environ;
 static const char *argv_exec_path;
+static const char *argv0_path;
 
 static const char *builtin_exec_path(void)
 {
@@ -42,14 +43,19 @@ static const char *builtin_exec_path(void)
 
 const char *system_path(const char *path)
 {
-	if (!is_absolute_path(path)) {
+	if (!is_absolute_path(path) && argv0_path) {
 		struct strbuf d = STRBUF_INIT;
-		strbuf_addf(&d, "%s/%s", git_exec_path(), path);
+		strbuf_addf(&d, "%s/%s", argv0_path, path);
 		path = strbuf_detach(&d, NULL);
 	}
 	return path;
 }
 
+void git_set_argv0_path(const char *path)
+{
+	argv0_path = path;
+}
+
 void git_set_argv_exec_path(const char *exec_path)
 {
 	argv_exec_path = exec_path;
@@ -84,7 +90,7 @@ static void add_path(struct strbuf *out, const char *path)
 	}
 }
 
-void setup_path(const char *cmd_path)
+void setup_path(void)
 {
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path;
@@ -94,7 +100,7 @@ void setup_path(const char *cmd_path)
 	add_path(&new_path, argv_exec_path);
 	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
 	add_path(&new_path, builtin_exec_path());
-	add_path(&new_path, cmd_path);
+	add_path(&new_path, argv0_path);
 
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
diff --git a/exec_cmd.h b/exec_cmd.h
index 7eb94e5..0c46cd5 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -2,8 +2,9 @@
 #define GIT_EXEC_CMD_H
 
 extern void git_set_argv_exec_path(const char *exec_path);
+extern void git_set_argv0_path(const char *path);
 extern const char* git_exec_path(void);
-extern void setup_path(const char *);
+extern void setup_path(void);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
 extern const char *system_path(const char *path);
diff --git a/git.c b/git.c
index 7075533..b90c358 100644
--- a/git.c
+++ b/git.c
@@ -470,7 +470,6 @@ int main(int argc, const char **argv)
 {
 	const char *cmd = argv[0] && *argv[0] ? argv[0] : "git-help";
 	char *slash = (char *)cmd + strlen(cmd);
-	const char *cmd_path = NULL;
 	int done_alias = 0;
 
 	/*
@@ -483,7 +482,7 @@ int main(int argc, const char **argv)
 	while (cmd <= slash && !is_dir_sep(*slash));
 	if (cmd <= slash) {
 		*slash++ = 0;
-		cmd_path = cmd;
+		git_set_argv0_path(cmd);
 		cmd = slash;
 	}
 
@@ -527,7 +526,7 @@ int main(int argc, const char **argv)
 	 * environment, and the $(gitexecdir) from the Makefile at build
 	 * time.
 	 */
-	setup_path(cmd_path);
+	setup_path();
 
 	while (1) {
 		/* See if it's an internal command */
diff --git a/receive-pack.c b/receive-pack.c
index fa653b4..d44c19e 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -482,7 +482,7 @@ int main(int argc, char **argv)
 	if (!dir)
 		usage(receive_pack_usage);
 
-	setup_path(NULL);
+	setup_path();
 
 	if (!enter_repo(dir, 0))
 		die("'%s': unable to chdir or not a git archive", dir);
diff --git a/shell.c b/shell.c
index 91ca7de..6a48de0 100644
--- a/shell.c
+++ b/shell.c
@@ -15,7 +15,7 @@ static int do_generic_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];
 
-	setup_path(NULL);
+	setup_path();
 	if (!arg || !(arg = sq_dequote(arg)))
 		die("bad argument");
 	if (prefixcmp(me, "git-"))
@@ -37,7 +37,7 @@ static int do_cvs_cmd(const char *me, char *arg)
 	if (!arg || strcmp(arg, "server"))
 		die("git-cvsserver only handles server: %s", arg);
 
-	setup_path(NULL);
+	setup_path();
 	return execv_git_cmd(cvsserver_argv);
 }
 
diff --git a/upload-pack.c b/upload-pack.c
index 9f82941..c911e70 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -638,7 +638,7 @@ int main(int argc, char **argv)
 	if (i != argc-1)
 		usage(upload_pack_usage);
 
-	setup_path(NULL);
+	setup_path();
 
 	dir = argv[i];
 
-- 
1.5.6.2.300.ga3a9
