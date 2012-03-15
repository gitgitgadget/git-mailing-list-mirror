From: Namhyung Kim <namhyung.kim@lge.com>
Subject: [PATCH 3/3] help: Add 'help.follow-alias' config item
Date: Thu, 15 Mar 2012 11:52:49 +0900
Message-ID: <1331779969-8641-3-git-send-email-namhyung.kim@lge.com>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 03:53:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S80oO-0002EK-7K
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 03:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab2COCwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 22:52:50 -0400
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:64104 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab2COCwt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 22:52:49 -0400
X-AuditID: 9c93016f-b7cedae00000438b-61-4f61597a76b4
Received: from MultiCore.156.147.1.1 ( [165.186.175.80])
	by LGEMRELSE1Q.lge.com (Symantec Brightmail Gateway) with SMTP id 2B.29.17291.A79516F4; Thu, 15 Mar 2012 11:52:42 +0900 (KST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193173>

The 'help.follow-alias' config option is used to determine the
default value of '--follow-alias' option. To do this, move some
codes to honor the priority of command line options.

Signed-off-by: Namhyung Kim <namhyung.kim@lge.com>
---
 Documentation/git-help.txt |    8 ++++++++
 builtin/help.c             |   16 ++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index debf293..9725e9f 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -80,6 +80,14 @@ line option:
 * "info" corresponds to '-i|--info',
 * "web" or "html" correspond to '-w|--web'.
 
+help.follow-alias
+~~~~~~~~~~~~~~~~~
+
+If --[no-]follow-alias command line option is not passed, the
+'help.follow-alias' configuration variable will be checked. If it's
+set to true, alias name will be resolved to its original command and
+then will be displayed.
+
 help.browser, web.browser and browser.<tool>.path
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/help.c b/builtin/help.c
index 00392ea..bf782ee 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -260,6 +260,10 @@ static int git_help_config(const char *var, const char *value, void *cb)
 		help_format = parse_help_format(value);
 		return 0;
 	}
+	if (!strcmp(var, "help.follow-alias")) {
+		follow_alias = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "man.viewer")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -420,12 +424,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	int nongit;
 	const char *cmd;
 	const char *alias;
-	enum help_format parsed_help_format;
+
 	load_command_list("git-", &main_cmds, &other_cmds);
 
+	setup_git_directory_gently(&nongit);
+	git_config(git_help_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
-	parsed_help_format = help_format;
 
 	if (show_all) {
 		printf("usage: %s\n\n", git_usage_string);
@@ -441,12 +447,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	setup_git_directory_gently(&nongit);
-	git_config(git_help_config, NULL);
-
-	if (parsed_help_format != HELP_FORMAT_NONE)
-		help_format = parsed_help_format;
-
 	cmd = argv[0];
 	alias = alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
-- 
1.7.9
