From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 2/7] remove unused/unneeded "pattern" argument of list_commands
Date: Wed, 24 Oct 2007 23:30:02 -0700
Message-ID: <1193293802-3732-1-git-send-email-srp@srparish.net>
References: <7v640v3ix1.fsf@gitster.siamese.dyndns.org>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 08:30:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkwEa-0000Qo-6z
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 08:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbXJYGaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 02:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbXJYGaG
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 02:30:06 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:59645 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbXJYGaF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 02:30:05 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtp (MailAnyone extSMTP quinn@srparish.net)
	id 1IkwEE-0002ny-Ol; Thu, 25 Oct 2007 01:30:03 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 70BD04EDF67; Wed, 24 Oct 2007 23:30:02 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11178.g9a1bf-dirty
In-Reply-To: <7v640v3ix1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62278>

list_commands() currently accepts and ignores a "pattern" argument,
and then hard codes a prefix as well as some magic numbers. This
hardcodes the prefix inside of the function and removes the magic
numbers.

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 help.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/help.c b/help.c
index b0d2dd4..d6dfdff 100644
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
