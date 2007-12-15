From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] git-help: add "help.format" config variable.
Date: Sat, 15 Dec 2007 05:57:28 +0100
Message-ID: <20071215055728.857b1924.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 05:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Ozw-0000lM-IA
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 05:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbXLOEvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 23:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbXLOEvL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 23:51:11 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:41737 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643AbXLOEvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 23:51:09 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 177FC1AB2B2;
	Sat, 15 Dec 2007 05:51:08 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id C8DD71AB2C0;
	Sat, 15 Dec 2007 05:51:07 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68373>

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

Note that this patch also revert some recent changes in
"git-browse-help" because they prevented to look for config
variables in the global configuration file.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-help.txt |   37 +++++++++++++++++++++++++-
 git-browse-help.sh         |   10 +++---
 help.c                     |   61 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index ac9e15d..31ec403 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -7,7 +7,7 @@ git-help - display help information about git
 
 SYNOPSIS
 --------
-'git help' [-a|--all|-i|--info|-w|--web] [COMMAND]
+'git help' [-a|--all|-i|--info|-m|--man|-w|--web] [COMMAND]
 
 DESCRIPTION
 -----------
@@ -21,7 +21,7 @@ printed on the standard output.
 
 If a git command is named, a manual page for that command is brought
 up. The 'man' program is used by default for this purpose, but this
-can be overriden by other options.
+can be overriden by other options or configuration variables.
 
 Note that 'git --help ...' is identical as 'git help ...' because the
 former is internally converted into the latter.
@@ -36,6 +36,11 @@ OPTIONS
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
@@ -54,6 +59,34 @@ is available in PATH.
 Note that the script tries, as much as possible, to display the HTML
 page in a new tab on an already opened browser.
 
+CONFIGURATION VARIABLES
+-----------------------
+
+If no command line option is passed, the 'help.format' configuration
+variable will be checked. The following values are supported for this
+variable; they make 'git-help' behave as their corresponding command
+line option:
+
+* "man" corresponds to '-m|--man',
+* "info" corresponds to '-i|--info',
+* "web" or "html" correspond to '-w|--web',
+
+The 'help.browser', 'web.browser' and 'browser.<tool>.path' will also
+be checked if the 'web' format is choosen (either by command line
+option or configuration variable). See '-w|--web' in the OPTIONS
+section above.
+
+Note that these configuration variables should probably be set using
+the '--global' flag, for example like this:
+
+------------------------------------------------
+$ git config --global help.format web
+$ git config --global web.browser firefox
+------------------------------------------------
+
+as they are probably more user specific than repository specific.
+See gitlink:git-config[1] for more information about this.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com> and the git-list
diff --git a/git-browse-help.sh b/git-browse-help.sh
index b465911..6fdf041 100755
--- a/git-browse-help.sh
+++ b/git-browse-help.sh
@@ -39,7 +39,7 @@ valid_tool() {
 }
 
 init_browser_path() {
-	test -z "$GIT_DIR" || browser_path=`git config browser.$1.path`
+	browser_path=`git config browser.$1.path`
 	test -z "$browser_path" && browser_path=$1
 }
 
@@ -71,7 +71,7 @@ do
     shift
 done
 
-if test -z "$browser" && test -n "$GIT_DIR"
+if test -z "$browser"
 then
     for opt in "help.browser" "web.browser"
     do
@@ -79,9 +79,9 @@ then
 	test -z "$browser" || break
     done
     if test -n "$browser" && ! valid_tool "$browser"; then
-	    echo >&2 "git config option $opt set to unknown browser: $browser"
-	    echo >&2 "Resetting to default..."
-	    unset browser
+	echo >&2 "git config option $opt set to unknown browser: $browser"
+	echo >&2 "Resetting to default..."
+	unset browser
     fi
 fi
 
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
1.5.4.rc0.1099.ga9f2-dirty
