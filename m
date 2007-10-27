From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 6/7] walk $PATH to generate list of commands for "help -a"
Date: Sat, 27 Oct 2007 01:36:54 -0700
Message-ID: <1193474215-6728-6-git-send-email-srp@srparish.net>
References: <1193474215-6728-1-git-send-email-srp@srparish.net>
 <1193474215-6728-2-git-send-email-srp@srparish.net>
 <1193474215-6728-3-git-send-email-srp@srparish.net>
 <1193474215-6728-4-git-send-email-srp@srparish.net>
 <1193474215-6728-5-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 10:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlhB0-00089y-Tf
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 10:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbXJ0IhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 04:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbXJ0IhJ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 04:37:09 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:45311 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbXJ0Ig7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 04:36:59 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtp (MailAnyone extSMTP srp)
	id 1IlhAA-00056r-E1; Sat, 27 Oct 2007 03:36:58 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id B384E4F21D0; Sat, 27 Oct 2007 01:36:56 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11179.g60ba
In-Reply-To: <1193474215-6728-5-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62476>

Git had previously been using the $PATH for scripts--a previous
patch moved exec'ed commands to also use the $PATH. For consistancy
"help -a" should also use the $PATH.

We walk all the paths in $PATH collecting the names of "git-*"
commands. To help distinguish between the main git commands
and commands picked up elsewhere (probably extensions) we
print them seperately. The main commands are the ones that
are found in the first directory in $PATH that contains the
"git" binary.

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 help.c |  158 ++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 125 insertions(+), 33 deletions(-)

diff --git a/help.c b/help.c
index ce3d795..ee4fce0 100644
--- a/help.c
+++ b/help.c
@@ -37,24 +37,29 @@ static inline void mput_char(char c, unsigned int num)
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
+	char *dir;
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
@@ -64,7 +69,42 @@ static int cmdname_compare(const void *a_, const void *b_)
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
+
+	ai = aj = bi = 0;
+	while (ai < a->cnt && bi < b->cnt) {
+		if (0 > strcmp(a->names[ai]->name, b->names[bi]->name))
+			a->names[aj++] = a->names[ai++];
+		else if (0 > strcmp(a->names[ai]->name, b->names[bi]->name))
+			bi++;
+		else
+			ai++, bi++;
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
@@ -73,9 +113,7 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 
 	if (space < max_cols)
 		cols = max_cols / space;
-	rows = (cmdname_cnt + cols - 1) / cols;
-
-	qsort(cmdname, cmdname_cnt, sizeof(*cmdname), cmdname_compare);
+	rows = (cmds->cnt + cols - 1) / cols;
 
 	for (i = 0; i < rows; i++) {
 		printf("  ");
@@ -83,31 +121,39 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
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
+static unsigned int list_commands_in_dir(const char *dir)
 {
 	unsigned int longest = 0;
 	const char *prefix = "git-";
 	int prefix_len = strlen(prefix);
-	DIR *dir = opendir(exec_path);
+	DIR *dirp = opendir(dir);
+	struct cmdnames *cmds;
 	struct dirent *de;
+	struct stat st;
 
-	if (!dir || chdir(exec_path)) {
-		fprintf(stderr, "git: '%s': %s\n", exec_path, strerror(errno));
-		exit(1);
+	if (!dirp || chdir(dir))
+		return 0;
+
+	if (!main_cmds.cnt &&
+	    !stat("git", &st) &&
+	    S_ISREG(st.st_mode) && (st.st_mode & S_IXUSR)) {
+		cmds = &main_cmds;
+		cmds->dir = xstrdup(dir);
 	}
+	else
+		cmds = &other_cmds;
 
-	while ((de = readdir(dir)) != NULL) {
-		struct stat st;
+	while ((de = readdir(dirp)) != NULL) {
 		int entlen;
 
 		if (prefixcmp(de->d_name, prefix))
@@ -122,18 +168,66 @@ static void list_commands(const char *exec_path)
 		if (has_extension(de->d_name, ".exe"))
 			entlen -= 4;
 
+		if (has_extension(de->d_name, ".perl") ||
+		    has_extension(de->d_name, ".sh"))
+			continue;
+
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
+static void list_commands()
+{
+	unsigned int longest = 0;
+	unsigned int len;
+	const char *env_path = getenv("PATH");
+	char *paths, *path, *colon;
+
+	if (!env_path) {
+		fprintf(stderr, "PATH not set\n");
+		exit(1);
 	}
-	closedir(dir);
 
-	printf("git commands available in '%s'\n", exec_path);
+	path = paths = xstrdup(env_path);
+	while ((char *)1 != path) {
+		if ((colon = strchr(path, ':')))
+			*colon = 0;
+
+		len = list_commands_in_dir(path);
+		longest = MAX(longest, len);
+
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
+	printf("available git commands in '%s'\n", main_cmds.dir);
 	printf("----------------------------");
-	mput_char('-', strlen(exec_path));
+	mput_char('-', strlen(main_cmds.dir));
+	putchar('\n');
+	pretty_print_string_list(&main_cmds, longest);
 	putchar('\n');
-	pretty_print_string_list(cmdname, longest);
+
+	if (!other_cmds.cnt)
+		return;
+
+	printf("git commands available from elsewhere on your $PATH\n");
+	printf("---------------------------------------------------\n");
+	pretty_print_string_list(&other_cmds, longest);
 	putchar('\n');
 }
 
@@ -189,7 +283,6 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	const char *help_cmd = argc > 1 ? argv[1] : NULL;
-	const char *exec_path = git_exec_path();
 
 	if (!help_cmd) {
 		printf("usage: %s\n\n", git_usage_string);
@@ -199,8 +292,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
-		if(exec_path)
-			list_commands(exec_path);
+		list_commands();
 		exit(0);
 	}
 
-- 
gitgui.0.8.4.11178.g9a1bf-dirty
