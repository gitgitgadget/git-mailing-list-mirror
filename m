From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/6] builtin-help: make it possible to exclude some commands in list_commands()
Date: Mon, 28 Jul 2008 03:21:07 +0200
Message-ID: <9cc2813166c8b20ffb411c3a28ad86665e60033b.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
 <fd19583955e9cea5b78a465d23bc127a51940048.1217207602.git.vmiklos@frugalware.org>
 <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217207602.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 03:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHQt-000771-6v
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbYG1BUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbYG1BUs
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:20:48 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:41573 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYG1BUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:20:46 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 7D0B01DDC5F
	for <git@vger.kernel.org>; Mon, 28 Jul 2008 03:20:43 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id A05741AB592; Mon, 28 Jul 2008 03:21:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217207602.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90387>

The supposed method is to build a list of commands to be excluded using
add_cmdname(), then pass the list as the new exclude parameter. If no
exclude is needed, NULL should be used.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 help.c |   24 ++++++++++--------------
 help.h |   14 +++++++++++++-
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/help.c b/help.c
index 7a42517..318d6d6 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,7 @@
 #include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "help.h"
 
 static struct man_viewer_list {
 	struct man_viewer_list *next;
@@ -300,16 +301,9 @@ static inline void mput_char(char c, unsigned int num)
 		putchar(c);
 }
 
-static struct cmdnames {
-	int alloc;
-	int cnt;
-	struct cmdname {
-		size_t len;
-		char name[1];
-	} **names;
-} main_cmds, other_cmds;
+struct cmdnames main_cmds, other_cmds;
 
-static void add_cmdname(struct cmdnames *cmds, const char *name, int len)
+void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
 	struct cmdname *ent = xmalloc(sizeof(*ent) + len);
 
@@ -463,7 +457,7 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 	return longest;
 }
 
-static unsigned int load_command_list(const char *prefix)
+static unsigned int load_command_list(const char *prefix, struct cmdnames *exclude)
 {
 	unsigned int longest = 0;
 	unsigned int len;
@@ -502,13 +496,15 @@ static unsigned int load_command_list(const char *prefix)
 	      sizeof(*other_cmds.names), cmdname_compare);
 	uniq(&other_cmds);
 	exclude_cmds(&other_cmds, &main_cmds);
+	if (exclude)
+		exclude_cmds(&main_cmds, exclude);
 
 	return longest;
 }
 
-void list_commands(const char *prefix, const char *title)
+void list_commands(const char *prefix, const char *title, struct cmdnames *exclude)
 {
-	unsigned int longest = load_command_list(prefix);
+	unsigned int longest = load_command_list(prefix, exclude);
 	const char *exec_path = git_exec_path();
 
 	if (main_cmds.cnt) {
@@ -558,7 +554,7 @@ static int is_in_cmdlist(struct cmdnames *c, const char *s)
 
 int is_git_command(const char *s, const char *prefix)
 {
-	load_command_list(prefix);
+	load_command_list(prefix, NULL);
 	return is_in_cmdlist(&main_cmds, s) ||
 		is_in_cmdlist(&other_cmds, s);
 }
@@ -704,7 +700,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all) {
 		printf("usage: %s\n\n", git_usage_string);
-		list_commands("git-", "git commands");
+		list_commands("git-", "git commands", NULL);
 		printf("%s\n", git_more_info_string);
 		return 0;
 	}
diff --git a/help.h b/help.h
index 0741662..85d3b74 100644
--- a/help.h
+++ b/help.h
@@ -1,7 +1,19 @@
 #ifndef HELP_H
 #define HELP_H
 
+struct cmdnames {
+	int alloc;
+	int cnt;
+	struct cmdname {
+		size_t len;
+		char name[1];
+	} **names;
+};
+
 int is_git_command(const char *s, const char *prefix);
-void list_commands(const char *prefix, const char *title);
+void list_commands(const char *prefix, const char *title, struct cmdnames *exclude);
+void add_cmdname(struct cmdnames *cmds, const char *name, int len);
+
+extern struct cmdnames main_cmds, other_cmds;
 
 #endif /* HELP_H */
-- 
1.6.0.rc0.14.g95f8.dirty
