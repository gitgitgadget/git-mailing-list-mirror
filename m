From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/4] builtin-help: make some internal functions available to other builtins
Date: Wed, 30 Jul 2008 01:16:58 +0200
Message-ID: <a2d2bc675801bb03e3035ec0102eb27f08f27f1b.1217372486.git.vmiklos@frugalware.org>
References: <cover.1217372486.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 01:17:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNyRu-0007ys-0t
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbYG2XQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYG2XQo
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:16:44 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55577 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbYG2XQg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 19:16:36 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 985E61DDC5B;
	Wed, 30 Jul 2008 01:16:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 25F021AA739; Wed, 30 Jul 2008 01:17:01 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <cover.1217372486.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217372486.git.vmiklos@frugalware.org>
References: <cover.1217372486.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90706>

Make load_command_list() capable of filtering for a given prefix and
loading into a pair of "struct cmdnames" supplied by the caller.

Make the static add_cmdname(), exclude_cmds() and is_in_cmdlist()
functions non-static.

Make list_commands() accept a custom title, and work from a pair of
"struct cmdnames" supplied by the caller.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Makefile |    1 +
 help.c   |   77 +++++++++++++++++++++++++++++++------------------------------
 help.h   |   23 ++++++++++++++++++
 3 files changed, 63 insertions(+), 38 deletions(-)
 create mode 100644 help.h

diff --git a/Makefile b/Makefile
index 52c67c1..83d79af 100644
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
index 3cb1962..88c0d5b 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,7 @@
 #include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "help.h"
 
 static struct man_viewer_list {
 	struct man_viewer_list *next;
@@ -300,18 +301,11 @@ static inline void mput_char(char c, unsigned int num)
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
-	struct cmdname *ent = xmalloc(sizeof(*ent) + len);
+	struct cmdname *ent = xmalloc(sizeof(*ent) + len + 1);
 
 	ent->len = len;
 	memcpy(ent->name, name, len);
@@ -342,7 +336,7 @@ static void uniq(struct cmdnames *cmds)
 	cmds->cnt = j;
 }
 
-static void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
+void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 {
 	int ci, cj, ei;
 	int cmp;
@@ -418,11 +412,11 @@ static int is_executable(const char *name)
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
@@ -430,6 +424,9 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 
 	if (!dir)
 		return 0;
+	if (!prefix)
+		prefix = "git-";
+	prefix_len = strlen(prefix);
 
 	strbuf_addf(&buf, "%s/", path);
 	len = buf.len;
@@ -460,7 +457,9 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 	return longest;
 }
 
-static unsigned int load_command_list(void)
+unsigned int load_command_list(const char *prefix,
+		struct cmdnames *main_cmds,
+		struct cmdnames *other_cmds)
 {
 	unsigned int longest = 0;
 	unsigned int len;
@@ -469,7 +468,7 @@ static unsigned int load_command_list(void)
 	const char *exec_path = git_exec_path();
 
 	if (exec_path)
-		longest = list_commands_in_dir(&main_cmds, exec_path);
+		longest = list_commands_in_dir(main_cmds, exec_path, prefix);
 
 	if (!env_path) {
 		fprintf(stderr, "PATH not set\n");
@@ -481,7 +480,7 @@ static unsigned int load_command_list(void)
 		if ((colon = strchr(path, PATH_SEP)))
 			*colon = 0;
 
-		len = list_commands_in_dir(&other_cmds, path);
+		len = list_commands_in_dir(other_cmds, path, prefix);
 		if (len > longest)
 			longest = len;
 
@@ -491,36 +490,38 @@ static unsigned int load_command_list(void)
 	}
 	free(paths);
 
-	qsort(main_cmds.names, main_cmds.cnt,
-	      sizeof(*main_cmds.names), cmdname_compare);
-	uniq(&main_cmds);
+	qsort(main_cmds->names, main_cmds->cnt,
+	      sizeof(*main_cmds->names), cmdname_compare);
+	uniq(main_cmds);
 
-	qsort(other_cmds.names, other_cmds.cnt,
-	      sizeof(*other_cmds.names), cmdname_compare);
-	uniq(&other_cmds);
-	exclude_cmds(&other_cmds, &main_cmds);
+	qsort(other_cmds->names, other_cmds->cnt,
+	      sizeof(*other_cmds->names), cmdname_compare);
+	uniq(other_cmds);
+	exclude_cmds(other_cmds, main_cmds);
 
 	return longest;
 }
 
-static void list_commands(void)
+void list_commands(const char *title, unsigned int longest,
+		struct cmdnames *main_cmds, struct cmdnames *other_cmds)
 {
-	unsigned int longest = load_command_list();
 	const char *exec_path = git_exec_path();
 
-	if (main_cmds.cnt) {
-		printf("available git commands in '%s'\n", exec_path);
-		printf("----------------------------");
-		mput_char('-', strlen(exec_path));
+	if (main_cmds->cnt) {
+		printf("available %s in '%s'\n", title, exec_path);
+		printf("----------------");
+		mput_char('-', strlen(title) + strlen(exec_path));
 		putchar('\n');
-		pretty_print_string_list(&main_cmds, longest);
+		pretty_print_string_list(main_cmds, longest);
 		putchar('\n');
 	}
 
-	if (other_cmds.cnt) {
-		printf("git commands available from elsewhere on your $PATH\n");
-		printf("---------------------------------------------------\n");
-		pretty_print_string_list(&other_cmds, longest);
+	if (other_cmds->cnt) {
+		printf("%s available from elsewhere on your $PATH\n", title);
+		printf("---------------------------------------");
+		mput_char('-', strlen(title));
+		putchar('\n');
+		pretty_print_string_list(other_cmds, longest);
 		putchar('\n');
 	}
 }
@@ -542,7 +543,7 @@ void list_common_cmds_help(void)
 	}
 }
 
-static int is_in_cmdlist(struct cmdnames *c, const char *s)
+int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
 	for (i = 0; i < c->cnt; i++)
@@ -553,7 +554,6 @@ static int is_in_cmdlist(struct cmdnames *c, const char *s)
 
 static int is_git_command(const char *s)
 {
-	load_command_list();
 	return is_in_cmdlist(&main_cmds, s) ||
 		is_in_cmdlist(&other_cmds, s);
 }
@@ -698,8 +698,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 			builtin_help_usage, 0);
 
 	if (show_all) {
+		unsigned int longest = load_command_list("git-", &main_cmds, &other_cmds);
 		printf("usage: %s\n\n", git_usage_string);
-		list_commands();
+		list_commands("git commands", longest, &main_cmds, &other_cmds);
 		printf("%s\n", git_more_info_string);
 		return 0;
 	}
diff --git a/help.h b/help.h
new file mode 100644
index 0000000..d614e54
--- /dev/null
+++ b/help.h
@@ -0,0 +1,23 @@
+#ifndef HELP_H
+#define HELP_H
+
+struct cmdnames {
+	int alloc;
+	int cnt;
+	struct cmdname {
+		size_t len;
+		char name[FLEX_ARRAY];
+	} **names;
+};
+
+unsigned int load_command_list(const char *prefix,
+		struct cmdnames *main_cmds,
+		struct cmdnames *other_cmds);
+void add_cmdname(struct cmdnames *cmds, const char *name, int len);
+/* Here we require that excludes is a sorted list. */
+void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
+int is_in_cmdlist(struct cmdnames *c, const char *s);
+void list_commands(const char *title, unsigned int longest,
+		struct cmdnames *main_cmds, struct cmdnames *other_cmds);
+
+#endif /* HELP_H */
-- 
1.6.0.rc0.14.g95f8.dirty
