From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 6/7] walk PATH to generate list of commands for "help -a"
Date: Wed, 24 Oct 2007 20:37:16 -0700
Message-ID: <1193283437-1706-6-git-send-email-srp@srparish.net>
References: <1193283437-1706-1-git-send-email-srp@srparish.net>
 <1193283437-1706-2-git-send-email-srp@srparish.net>
 <1193283437-1706-3-git-send-email-srp@srparish.net>
 <1193283437-1706-4-git-send-email-srp@srparish.net>
 <1193283437-1706-5-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 05:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IktXK-0003WC-4t
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 05:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658AbXJYDhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 23:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756820AbXJYDhV
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 23:37:21 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:51533 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658AbXJYDhS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 23:37:18 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtp (MailAnyone extSMTP quinn@srparish.net)
	id 1IktX3-0003Su-9j; Wed, 24 Oct 2007 22:37:17 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 24A674EA8C0; Wed, 24 Oct 2007 20:37:18 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11178.g9a1bf-dirty
In-Reply-To: <1193283437-1706-5-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62261>

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 help.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/help.c b/help.c
index 906f8f6..3f8b4aa 100644
--- a/help.c
+++ b/help.c
@@ -64,6 +64,19 @@ static int cmdname_compare(const void *a_, const void *b_)
 	return strcmp(a->name, b->name);
 }
 
+static void uniq(struct cmdname **cmdname)
+{
+	int i, j;
+
+	for (i = j = 1; i < cmdname_cnt; i++) {
+		if (strcmp(cmdname[i]->name, cmdname[i-1]->name)) {
+			cmdname[j++] = cmdname[i];
+		}
+	}
+
+	cmdname_cnt = j;
+}
+
 static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 {
 	int cols = 1, rows;
@@ -71,12 +84,13 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 	int max_cols = term_columns() - 1; /* don't print *on* the edge */
 	int i, j;
 
+	qsort(cmdname, cmdname_cnt, sizeof(*cmdname), cmdname_compare);
+	uniq(cmdname);
+
 	if (space < max_cols)
 		cols = max_cols / space;
 	rows = (cmdname_cnt + cols - 1) / cols;
 
-	qsort(cmdname, cmdname_cnt, sizeof(*cmdname), cmdname_compare);
-
 	for (i = 0; i < rows; i++) {
 		printf("  ");
 
@@ -93,19 +107,17 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 	}
 }
 
-static void list_commands(const char *exec_path, const char *prefix)
+static unsigned int list_commands_in_dir(const char *dir, const char *prefix)
 {
 	unsigned int longest = 0;
 	int prefix_len = strlen(prefix);
-	DIR *dir = opendir(exec_path);
+	DIR *dirp = opendir(dir);
 	struct dirent *de;
 
-	if (!dir || chdir(exec_path)) {
-		fprintf(stderr, "git: '%s': %s\n", exec_path, strerror(errno));
-		exit(1);
-	}
+	if (!dirp || chdir(dir))
+		return 0;
 
-	while ((de = readdir(dir)) != NULL) {
+	while ((de = readdir(dirp)) != NULL) {
 		struct stat st;
 		int entlen;
 
@@ -126,12 +138,37 @@ static void list_commands(const char *exec_path, const char *prefix)
 
 		add_cmdname(de->d_name + prefix_len, entlen);
 	}
-	closedir(dir);
+	closedir(dirp);
 
-	printf("git commands available in '%s'\n", exec_path);
-	printf("----------------------------");
-	mput_char('-', strlen(exec_path));
-	putchar('\n');
+	return longest;
+}
+
+static void list_commands(const char *prefix)
+{
+	unsigned int longest = 0;
+	unsigned int len;
+	const char *env_path = getenv("PATH");
+	char *paths, *path, *colon;
+
+	if (!env_path) {
+		fprintf(stderr, "PATH not set\n");
+		exit(1);
+	}
+
+	path = paths = xstrdup(env_path);
+	while ((char *)1 != path) {
+		if ((colon = strchr(path, ':')))
+			*colon = 0;
+
+		len = list_commands_in_dir(path, prefix);
+		longest = MAX(longest, len);
+
+		path = colon + 1;
+	}
+	free(paths);
+
+	printf("available git commands\n");
+	printf("----------------------\n");
 	pretty_print_string_list(cmdname, longest);
 	putchar('\n');
 }
@@ -188,7 +225,6 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	const char *help_cmd = argc > 1 ? argv[1] : NULL;
-	const char *exec_path = git_exec_path();
 
 	if (!help_cmd) {
 		printf("usage: %s\n\n", git_usage_string);
@@ -198,8 +234,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
-		if(exec_path)
-			list_commands(exec_path, "git-");
+		list_commands("git-");
 		exit(0);
 	}
 
-- 
gitgui.0.8.4.11176.gd9205-dirty
