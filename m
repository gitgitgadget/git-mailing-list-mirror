From: Namhyung Kim <namhyung.kim@lge.com>
Subject: [PATCH 2/3] help: Add '--follow-alias' option
Date: Thu, 15 Mar 2012 11:52:48 +0900
Message-ID: <1331779969-8641-2-git-send-email-namhyung.kim@lge.com>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 03:53:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S80oO-0002EK-Ow
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 03:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab2COCwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 22:52:51 -0400
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:64104 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab2COCws (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 22:52:48 -0400
X-AuditID: 9c93016f-b7cedae00000438b-5e-4f615979f3eb
Received: from MultiCore.156.147.1.1 ( [165.186.175.80])
	by LGEMRELSE1Q.lge.com (Symantec Brightmail Gateway) with SMTP id 9A.29.17291.979516F4; Thu, 15 Mar 2012 11:52:42 +0900 (KST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193172>

The --follow-alias option will look up the alias definitions and
use the first word as a command. For example, if I set my aliases
as follows:

 $ git help br
 `git br' is aliased to `git branch'
 $ git help ru
 `git ru' is aliased to `git remote update'

adding --follow-alias (or -f) option will show man pages of
git-branch and git-remote, respectively.

Signed-off-by: Namhyung Kim <namhyung.kim@lge.com>
---
 Documentation/git-help.txt |    7 ++++++-
 builtin/help.c             |   25 ++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 9e0b3f6..debf293 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - display help information about git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all|-i|--info|-m|--man|-w|--web] [COMMAND]
+'git help' [-a|--all|-f|--follow-alias|-i|--info|-m|--man|-w|--web] [COMMAND]
 
 DESCRIPTION
 -----------
@@ -34,6 +34,11 @@ OPTIONS
 	Prints all the available commands on the standard output. This
 	option supersedes any other option.
 
+-f::
+--follow-alias::
+	Read alias definitions and use its first word as a command name
+	(if any).
+
 -i::
 --info::
 	Display manual page for the command in the 'info' format. The
diff --git a/builtin/help.c b/builtin/help.c
index f85c870..00392ea 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -30,9 +30,12 @@ enum help_format {
 };
 
 static int show_all = 0;
+static int follow_alias = 0;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
 	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
+	OPT_BOOLEAN('f', "follow-alias", &follow_alias,
+			"follow alias to resolve command name"),
 	OPT_SET_INT('m', "man", &help_format, "show man page", HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, "show manual in web browser",
 			HELP_FORMAT_WEB),
@@ -415,6 +418,7 @@ static void show_html_page(const char *git_cmd)
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
+	const char *cmd;
 	const char *alias;
 	enum help_format parsed_help_format;
 	load_command_list("git-", &main_cmds, &other_cmds);
@@ -443,22 +447,33 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (parsed_help_format != HELP_FORMAT_NONE)
 		help_format = parsed_help_format;
 
+	cmd = argv[0];
 	alias = alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
-		printf("`git %s' is aliased to `git %s'\n", argv[0], alias);
-		return 0;
+		char *p;
+
+		if (!follow_alias) {
+			printf("`git %s' is aliased to `git %s'\n",
+			       argv[0], alias);
+			return 0;
+		}
+
+		p = strchr(alias, ' ');
+		if (p)
+			*p = '\0';
+		cmd = alias;
 	}
 
 	switch (help_format) {
 	case HELP_FORMAT_NONE:
 	case HELP_FORMAT_MAN:
-		show_man_page(argv[0]);
+		show_man_page(cmd);
 		break;
 	case HELP_FORMAT_INFO:
-		show_info_page(argv[0]);
+		show_info_page(cmd);
 		break;
 	case HELP_FORMAT_WEB:
-		show_html_page(argv[0]);
+		show_html_page(cmd);
 		break;
 	}
 
-- 
1.7.9
