From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] git-help: add "help.format" config variable.
Date: Wed, 12 Dec 2007 06:33:20 +0100
Message-ID: <20071212063320.3cbb1698.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 06:27:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2K7y-0007S0-8X
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 06:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbXLLF1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 00:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbXLLF1E
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 00:27:04 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:49194 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390AbXLLF1C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 00:27:02 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4A66A1AB2B7;
	Wed, 12 Dec 2007 06:26:59 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 0CAD41AB2A8;
	Wed, 12 Dec 2007 06:26:59 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67995>

This config variable makes it possible to choose the default format
used to display help. This format will be used only if no option
like -a|--all|-i|--info|-m|--man|-w|--web is passed to "git-help".

The following values are possible for this variable:

	- "man"  --> "man" program is used
	- "info" --> "info" program is used
	- "web"  --> "git-browse-help" is used

By default we still show help using "man".

By the way, this patch also adds -m|--man command line option to
use "man" even if something else is set in the "help.format"
config variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-help.txt |   13 ++++++++-
 git.c                      |    2 +-
 help.c                     |   61 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index ac9e15d..af5e5cb 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -7,7 +7,7 @@ git-help - display help information about git
 
 SYNOPSIS
 --------
-'git help' [-a|--all|-i|--info|-w|--web] [COMMAND]
+'git help' [-a|--all|-i|--info|-m|--man|-w|--web] [COMMAND]
 
 DESCRIPTION
 -----------
@@ -23,6 +23,12 @@ If a git command is named, a manual page for that command is brought
 up. The 'man' program is used by default for this purpose, but this
 can be overriden by other options.
 
+If no command line option is passed, the 'help.format' configuration
+variable will be checked. Supported values for this variable are
+"man", "info" and "web" (or "html" as a synonym to the latter). This
+makes git-help behave as if a command line option with the same long
+name as been passed to it.
+
 Note that 'git --help ...' is identical as 'git help ...' because the
 former is internally converted into the latter.
 
@@ -36,6 +42,11 @@ OPTIONS
 	Use the 'info' program to display the manual page, instead of
 	the 'man' program that is used by default.
 
+-m|--man::
+	Use the 'man' program to display the manual page. This may be
+	used to override a value set in the 'help.format'
+	configuration variable.
+
 -w|--web::
 	Use a web browser to display the HTML manual page, instead of
 	the 'man' program that is used by default.
diff --git a/git.c b/git.c
index 4f9876e..d46b63d 100644
--- a/git.c
+++ b/git.c
@@ -324,7 +324,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
-		{ "help", cmd_help },
+		{ "help", cmd_help, RUN_SETUP },
 #ifndef NO_CURL
 		{ "http-fetch", cmd_http_fetch, RUN_SETUP },
 #endif
diff --git a/help.c b/help.c
index c96b167..af0a433 100644
--- a/help.c
+++ b/help.c
@@ -8,6 +8,44 @@
 #include "exec_cmd.h"
 #include "common-cmds.h"
 
+static const char *help_default_format;
+
+static enum help_format {
+	man_format,
+	info_format,
+	web_format,
+} help_format = man_format;
+
+static void parse_help_format(const char *format)
+{
+	if (!format) {
+		help_format = man_format;
+		return;
+	}
+	if (!strcmp(format, "man")) {
+		help_format = man_format;
+		return;
+	}
+	if (!strcmp(format, "info")) {
+		help_format = info_format;
+		return;
+	}
+	if (!strcmp(format, "web") || !strcmp(format, "html")) {
+		help_format = web_format;
+		return;
+	}
+	die("unrecognized help format '%s'", format);
+}
+
+static int git_help_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "help.format")) {
+		help_default_format = xstrdup(value);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
@@ -331,8 +369,27 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		show_info_page(argc > 2 ? argv[2] : NULL);
 	}
 
-	else
-		show_man_page(help_cmd);
+	else if (!strcmp(help_cmd, "--man") || !strcmp(help_cmd, "-m")) {
+		show_man_page(argc > 2 ? argv[2] : NULL);
+	}
+
+	else {
+		git_config(git_help_config);
+		if (help_default_format)
+			parse_help_format(help_default_format);
+
+		switch (help_format) {
+		case man_format:
+			show_man_page(help_cmd);
+			break;
+		case info_format:
+			show_info_page(help_cmd);
+			break;
+		case web_format:
+			show_html_page(help_cmd);
+			break;
+		}
+	}
 
 	return 0;
 }
-- 
1.5.3.7.2270.g786cf-dirty
