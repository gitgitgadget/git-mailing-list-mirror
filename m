From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/6] builtin-help: make is_git_command() usable outside builtin-help
Date: Mon, 28 Jul 2008 03:21:05 +0200
Message-ID: <fd19583955e9cea5b78a465d23bc127a51940048.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 03:21:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHQu-000771-P3
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbYG1BUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbYG1BUv
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:20:51 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:41572 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYG1BUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:20:46 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 7966A1DDC5E
	for <git@vger.kernel.org>; Mon, 28 Jul 2008 03:20:43 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 641EF1AB590; Mon, 28 Jul 2008 03:21:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <cover.1217207602.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90389>

Other builtins may want to check if a given command is a valid git
command or not as well. Additionally add a new parameter that specifies
a custom prefix, so that the "git-" prefix is no longer hardwired.
Useful for example to limit the search for "git-merge-*".

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Makefile |    1 +
 help.c   |   25 ++++++++++++++-----------
 help.h   |    6 ++++++
 3 files changed, 21 insertions(+), 11 deletions(-)
 create mode 100644 help.h

diff --git a/Makefile b/Makefile
index 798a2f2..351afd7 100644
--- a/Makefile
+++ b/Makefile
@@ -355,6 +355,7 @@ LIB_H += git-compat-util.h
 LIB_H += graph.h
 LIB_H += grep.h
 LIB_H += hash.h
+LIB_H += help.h
 LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
diff --git a/help.c b/help.c
index 3cb1962..08188f5 100644
--- a/help.c
+++ b/help.c
@@ -418,11 +418,11 @@ static int is_executable(const char *name)
 }
 
 static unsigned int list_commands_in_dir(struct cmdnames *cmds,
-					 const char *path)
+					 const char *path,
+					 const char *prefix)
 {
 	unsigned int longest = 0;
-	const char *prefix = "git-";
-	int prefix_len = strlen(prefix);
+	int prefix_len;
 	DIR *dir = opendir(path);
 	struct dirent *de;
 	struct strbuf buf = STRBUF_INIT;
@@ -430,6 +430,9 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 
 	if (!dir)
 		return 0;
+	if (!prefix)
+		prefix = "git-";
+	prefix_len = strlen(prefix);
 
 	strbuf_addf(&buf, "%s/", path);
 	len = buf.len;
@@ -460,7 +463,7 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 	return longest;
 }
 
-static unsigned int load_command_list(void)
+static unsigned int load_command_list(const char *prefix)
 {
 	unsigned int longest = 0;
 	unsigned int len;
@@ -469,7 +472,7 @@ static unsigned int load_command_list(void)
 	const char *exec_path = git_exec_path();
 
 	if (exec_path)
-		longest = list_commands_in_dir(&main_cmds, exec_path);
+		longest = list_commands_in_dir(&main_cmds, exec_path, prefix);
 
 	if (!env_path) {
 		fprintf(stderr, "PATH not set\n");
@@ -481,7 +484,7 @@ static unsigned int load_command_list(void)
 		if ((colon = strchr(path, PATH_SEP)))
 			*colon = 0;
 
-		len = list_commands_in_dir(&other_cmds, path);
+		len = list_commands_in_dir(&other_cmds, path, prefix);
 		if (len > longest)
 			longest = len;
 
@@ -505,7 +508,7 @@ static unsigned int load_command_list(void)
 
 static void list_commands(void)
 {
-	unsigned int longest = load_command_list();
+	unsigned int longest = load_command_list(NULL);
 	const char *exec_path = git_exec_path();
 
 	if (main_cmds.cnt) {
@@ -551,9 +554,9 @@ static int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
-static int is_git_command(const char *s)
+int is_git_command(const char *s, const char *prefix)
 {
-	load_command_list();
+	load_command_list(prefix);
 	return is_in_cmdlist(&main_cmds, s) ||
 		is_in_cmdlist(&other_cmds, s);
 }
@@ -574,7 +577,7 @@ static const char *cmd_to_page(const char *git_cmd)
 		return "git";
 	else if (!prefixcmp(git_cmd, "git"))
 		return git_cmd;
-	else if (is_git_command(git_cmd))
+	else if (is_git_command(git_cmd, NULL))
 		return prepend("git-", git_cmd);
 	else
 		return prepend("git", git_cmd);
@@ -712,7 +715,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	}
 
 	alias = alias_lookup(argv[0]);
-	if (alias && !is_git_command(argv[0])) {
+	if (alias && !is_git_command(argv[0], NULL)) {
 		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
 		return 0;
 	}
diff --git a/help.h b/help.h
new file mode 100644
index 0000000..73da8d6
--- /dev/null
+++ b/help.h
@@ -0,0 +1,6 @@
+#ifndef HELP_H
+#define HELP_H
+
+int is_git_command(const char *s, const char *prefix);
+
+#endif /* HELP_H */
-- 
1.6.0.rc0.14.g95f8.dirty
