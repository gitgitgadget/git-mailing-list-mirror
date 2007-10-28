From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 6/7] include $PATH in generating list of commands for "help -a"
Date: Sun, 28 Oct 2007 07:44:14 -0700
Message-ID: <1193582654-12100-1-git-send-email-srp@srparish.net>
References: <1193474215-6728-6-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 15:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im9NO-0002BV-87
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 15:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXJ1OoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 10:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbXJ1OoQ
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 10:44:16 -0400
Received: from smtp-gw8.mailanyone.net ([208.70.128.73]:51872 "EHLO
	smtp-gw8.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbXJ1OoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 10:44:15 -0400
Received: from mailanyone.net
	by smtp-gw8.mailanyone.net with esmtp (MailAnyone extSMTP srp)
	id 1Im9N8-0000px-Hr; Sun, 28 Oct 2007 09:44:14 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id AC9324F277C; Sun, 28 Oct 2007 07:44:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.401.g19778-dirty
In-Reply-To: <1193474215-6728-6-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62563>

Git had previously been using the $PATH for scripts--a previous
patch moved exec'ed commands to also use the $PATH. For consistency
"help -a" should also list commands in the $PATH.

The main commands are still listed from the git_exec_path(), but
the $PATH is walked and other git commands (probably extensions) are
listed.

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 help.c |  163 +++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 125 insertions(+), 38 deletions(-)

diff --git a/help.c b/help.c
index 34ac5db..07cf67a 100644
--- a/help.c
+++ b/help.c
@@ -37,24 +37,28 @@ static inline void mput_char(char c, unsigned int num)
 		putchar(c);
 }
 
-static struct cmdname {
-	size_t len;
-	char name[1];
-} **cmdname;
-static int cmdname_alloc, cmdname_cnt;
-
-static void add_cmdname(const char *name, int len)
+static struct cmdnames {
+	int alloc;
+	int cnt;
+	struct cmdname {
+		size_t len;
+		char name[1];
+	} **names;
+} main_cmds, other_cmds;
+
+static void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
 	struct cmdname *ent;
-	if (cmdname_alloc <= cmdname_cnt) {
-		cmdname_alloc = cmdname_alloc + 200;
-		cmdname = xrealloc(cmdname, cmdname_alloc * sizeof(*cmdname));
+	if (cmds->alloc <= cmds->cnt) {
+		cmds->alloc = cmds->alloc + 200;
+		cmds->names = xrealloc(cmds->names,
+				       cmds->alloc * sizeof(*cmds->names));
 	}
 	ent = xmalloc(sizeof(*ent) + len);
 	ent->len = len;
 	memcpy(ent->name, name, len);
 	ent->name[len] = 0;
-	cmdname[cmdname_cnt++] = ent;
+	cmds->names[cmds->cnt++] = ent;
 }
 
 static int cmdname_compare(const void *a_, const void *b_)
@@ -64,7 +68,44 @@ static int cmdname_compare(const void *a_, const void *b_)
 	return strcmp(a->name, b->name);
 }
 
-static void pretty_print_string_list(struct cmdname **cmdname, int longest)
+static void uniq(struct cmdnames *cmds)
+{
+	int i, j;
+
+	if (!cmds->cnt)
+		return;
+
+	for (i = j = 1; i < cmds->cnt; i++) {
+		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name)) {
+			cmds->names[j++] = cmds->names[i];
+		}
+	}
+
+	cmds->cnt = j;
+}
+
+static void subtract_cmds(struct cmdnames *a, struct cmdnames *b) {
+	int ai, aj, bi;
+	int cmp;
+
+	ai = aj = bi = 0;
+	while (ai < a->cnt && bi < b->cnt) {
+		cmp = strcmp(a->names[ai]->name, b->names[bi]->name);
+		if (cmp < 0)
+			a->names[aj++] = a->names[ai++];
+		else if (cmp == 0)
+			ai++, bi++;
+		else if (cmp > 0)
+			bi++;
+	}
+
+	while (ai < a->cnt)
+		a->names[aj++] = a->names[ai++];
+
+	a->cnt = aj;
+}
+
+static void pretty_print_string_list(struct cmdnames *cmds, int longest)
 {
 	int cols = 1, rows;
 	int space = longest + 1; /* min 1 SP between words */
@@ -73,9 +114,7 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 
 	if (space < max_cols)
 		cols = max_cols / space;
-	rows = (cmdname_cnt + cols - 1) / cols;
-
-	qsort(cmdname, cmdname_cnt, sizeof(*cmdname), cmdname_compare);
+	rows = (cmds->cnt + cols - 1) / cols;
 
 	for (i = 0; i < rows; i++) {
 		printf("  ");
@@ -83,31 +122,29 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 		for (j = 0; j < cols; j++) {
 			int n = j * rows + i;
 			int size = space;
-			if (n >= cmdname_cnt)
+			if (n >= cmds->cnt)
 				break;
-			if (j == cols-1 || n + rows >= cmdname_cnt)
+			if (j == cols-1 || n + rows >= cmds->cnt)
 				size = 1;
-			printf("%-*s", size, cmdname[n]->name);
+			printf("%-*s", size, cmds->names[n]->name);
 		}
 		putchar('\n');
 	}
 }
 
-static void list_commands(const char *exec_path)
+static unsigned int list_commands_in_dir(struct cmdnames *cmds, const char *dir)
 {
 	unsigned int longest = 0;
 	const char *prefix = "git-";
 	int prefix_len = strlen(prefix);
-	DIR *dir = opendir(exec_path);
+	DIR *dirp = opendir(dir);
 	struct dirent *de;
+	struct stat st;
 
-	if (!dir || chdir(exec_path)) {
-		fprintf(stderr, "git: '%s': %s\n", exec_path, strerror(errno));
-		exit(1);
-	}
+	if (!dirp || chdir(dir))
+		return 0;
 
-	while ((de = readdir(dir)) != NULL) {
-		struct stat st;
+	while ((de = readdir(dirp)) != NULL) {
 		int entlen;
 
 		if (prefixcmp(de->d_name, prefix))
@@ -125,16 +162,68 @@ static void list_commands(const char *exec_path)
 		if (longest < entlen)
 			longest = entlen;
 
-		add_cmdname(de->d_name + prefix_len, entlen);
+		add_cmdname(cmds, de->d_name + prefix_len, entlen);
+	}
+	closedir(dirp);
+
+	return longest;
+}
+
+static void list_commands(void)
+{
+	unsigned int longest = 0;
+	unsigned int len;
+	const char *env_path = getenv("PATH");
+	char *paths, *path, *colon;
+	const char *exec_path = git_exec_path();
+
+	if (exec_path)
+		longest = list_commands_in_dir(&main_cmds, exec_path);
+
+	if (!env_path) {
+		fprintf(stderr, "PATH not set\n");
+		exit(1);
+	}
+
+	path = paths = xstrdup(env_path);
+	while (1) {
+		if ((colon = strchr(path, ':')))
+			*colon = 0;
+
+		len = list_commands_in_dir(&other_cmds, path);
+		if (len > longest)
+			longest = len;
+
+		if (!colon)
+			break;
+		path = colon + 1;
+	}
+	free(paths);
+
+	qsort(main_cmds.names, main_cmds.cnt,
+	      sizeof(*main_cmds.names), cmdname_compare);
+	uniq(&main_cmds);
+
+	qsort(other_cmds.names, other_cmds.cnt,
+	      sizeof(*other_cmds.names), cmdname_compare);
+	uniq(&other_cmds);
+	subtract_cmds(&other_cmds, &main_cmds);
+
+	if (main_cmds.cnt) {
+		printf("available git commands in '%s'\n", exec_path);
+		printf("----------------------------");
+		mput_char('-', strlen(exec_path));
+		putchar('\n');
+		pretty_print_string_list(&main_cmds, longest);
+		putchar('\n');
+	}
+
+	if (other_cmds.cnt) {
+		printf("git commands available from elsewhere on your $PATH\n");
+		printf("---------------------------------------------------\n");
+		pretty_print_string_list(&other_cmds, longest);
+		putchar('\n');
 	}
-	closedir(dir);
-
-	printf("git commands available in '%s'\n", exec_path);
-	printf("----------------------------");
-	mput_char('-', strlen(exec_path));
-	putchar('\n');
-	pretty_print_string_list(cmdname, longest);
-	putchar('\n');
 }
 
 void list_common_cmds_help(void)
@@ -188,7 +277,6 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	const char *help_cmd = argc > 1 ? argv[1] : NULL;
-	const char *exec_path = git_exec_path();
 
 	if (!help_cmd) {
 		printf("usage: %s\n\n", git_usage_string);
@@ -198,8 +286,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
-		if(exec_path)
-			list_commands(exec_path);
+		list_commands();
 		exit(0);
 	}
 
-- 
1.5.3.4.401.g19778-dirty
