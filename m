From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 2/7] remove unused/unneeded "pattern" argument of list_commands
Date: Sat, 27 Oct 2007 01:36:50 -0700
Message-ID: <1193474215-6728-2-git-send-email-srp@srparish.net>
References: <1193474215-6728-1-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 10:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlhB1-00089y-I2
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 10:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbXJ0IhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 04:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbXJ0IhH
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 04:37:07 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:45257 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbXJ0Ig7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 04:36:59 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtp (MailAnyone extSMTP srp)
	id 1IlhA9-00056T-Qa; Sat, 27 Oct 2007 03:36:57 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 6AF464F21CB; Sat, 27 Oct 2007 01:36:55 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11179.g60ba
In-Reply-To: <1193474215-6728-1-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62475>

list_commands() currently accepts and ignores a "pattern" argument,
and then hard codes a prefix as well as some magic numbers. This
hardcodes the prefix inside of the function and removes the magic
numbers.

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 help.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/help.c b/help.c
index d4b1818..b636774 100644
--- a/help.c
+++ b/help.c
@@ -93,10 +93,12 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 	}
 }
 
-static void list_commands(const char *exec_path, const char *pattern)
+static void list_commands(const char *exec_path)
 {
 	unsigned int longest = 0;
 	char path[PATH_MAX];
+	const char *prefix = "git-";
+	int prefix_len = strlen(prefix);
 	int dirlen;
 	DIR *dir = opendir(exec_path);
 	struct dirent *de;
@@ -120,7 +122,7 @@ static void list_commands(const char *exec_path, const char *pattern)
 		struct stat st;
 		int entlen;
 
-		if (prefixcmp(de->d_name, "git-"))
+		if (prefixcmp(de->d_name, prefix))
 			continue;
 		strcpy(path+dirlen, de->d_name);
 		if (stat(path, &st) || /* stat, not lstat */
@@ -128,14 +130,14 @@ static void list_commands(const char *exec_path, const char *pattern)
 		    !(st.st_mode & S_IXUSR))
 			continue;
 
-		entlen = strlen(de->d_name);
+		entlen = strlen(de->d_name) - prefix_len;
 		if (has_extension(de->d_name, ".exe"))
 			entlen -= 4;
 
 		if (longest < entlen)
 			longest = entlen;
 
-		add_cmdname(de->d_name + 4, entlen-4);
+		add_cmdname(de->d_name + prefix_len, entlen);
 	}
 	closedir(dir);
 
@@ -143,7 +145,7 @@ static void list_commands(const char *exec_path, const char *pattern)
 	printf("----------------------------");
 	mput_char('-', strlen(exec_path));
 	putchar('\n');
-	pretty_print_string_list(cmdname, longest - 4);
+	pretty_print_string_list(cmdname, longest);
 	putchar('\n');
 }
 
@@ -210,7 +212,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
 		if(exec_path)
-			list_commands(exec_path, "git-*");
+			list_commands(exec_path);
 		exit(0);
 	}
 
-- 
gitgui.0.8.4.11178.g9a1bf-dirty
