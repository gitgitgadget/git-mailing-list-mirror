From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] git config --get-colorbool
Date: Wed,  5 Dec 2007 18:05:04 -0800
Message-ID: <1196906706-11170-2-git-send-email-gitster@pobox.com>
References: <475697BC.2090701@viscovery.net>
 <1196906706-11170-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 03:23:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J06OS-00012B-MO
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 03:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416AbXLFCWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 21:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756407AbXLFCWh
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 21:22:37 -0500
Received: from fed1rmmtai113.cox.net ([68.230.241.47]:48794 "EHLO
	fed1rmmtai113.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917AbXLFCWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 21:22:36 -0500
X-Greylist: delayed 1048 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2007 21:22:36 EST
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20071206020508.VMOU27415.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>
          for <git@vger.kernel.org>; Wed, 5 Dec 2007 21:05:08 -0500
Received: from localhost ([68.225.240.77])
	by fed1rmimpo03.cox.net with bizsmtp
	id ME561Y00D1gtr5g0000000; Wed, 05 Dec 2007 21:05:06 -0500
X-Mailer: git-send-email 1.5.3.7-2132-gbd1cf
In-Reply-To: <1196906706-11170-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67221>

This adds an option to help scripts find out color settings from
the configuration file.

    git config --get-colorbool color.diff

inspects color.diff variable, and exits with status 0 (i.e. success) if
color is to be used.  It exits with status 1 otherwise.

If a script wants "true"/"false" answer to the standard output of the
command, it can pass an additional boolean parameter to its command
line, telling if its standard output is a terminal, like this:

    git config --get-colorbool color.diff true

When called like this, the command outputs "true" to its standard output
if color is to be used (i.e. "color.diff" says "always", "auto", or
"true"), and "false" otherwise.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-config.txt |   10 ++++++++++
 builtin-branch.c             |    2 +-
 builtin-config.c             |   41 ++++++++++++++++++++++++++++++++++++++++-
 color.c                      |    6 ++++--
 color.h                      |    2 +-
 diff.c                       |    2 +-
 wt-status.c                  |    2 +-
 7 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7640450..98509b4 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -21,6 +21,7 @@ SYNOPSIS
 'git-config' [<file-option>] --remove-section name
 'git-config' [<file-option>] [-z|--null] -l | --list
 'git-config' [<file-option>] --get-color name [default]
+'git-config' [<file-option>] --get-colorbool name [stdout-is-tty]
 
 DESCRIPTION
 -----------
@@ -135,6 +136,15 @@ See also <<FILES>>.
 	output without getting confused e.g. by values that
 	contain line breaks.
 
+--get-colorbool name [stdout-is-tty]::
+
+	Find the color setting for `name` (e.g. `color.diff`) and output
+	"true" or "false".  `stdout-is-tty` should be either "true" or
+	"false", and is taken into account when configuration says
+	"auto".  If `stdout-is-tty` is missing, then checks the standard
+	output of the command itself, and exits with status 0 if color
+	is to be used, or exits with status 1 otherwise.
+
 --get-color name default::
 
 	Find the color configured for `name` (e.g. `color.diff.new`) and
diff --git a/builtin-branch.c b/builtin-branch.c
index c64768b..089cae5 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -65,7 +65,7 @@ static int parse_branch_color_slot(const char *var, int ofs)
 static int git_branch_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "color.branch")) {
-		branch_use_color = git_config_colorbool(var, value);
+		branch_use_color = git_config_colorbool(var, value, -1);
 		return 0;
 	}
 	if (!prefixcmp(var, "color.branch.")) {
diff --git a/builtin-config.c b/builtin-config.c
index 6175dc3..d10b03f 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -3,7 +3,7 @@
 #include "color.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default]";
+"git-config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
 
 static char *key;
 static regex_t *key_regexp;
@@ -208,6 +208,43 @@ static int get_color(int argc, const char **argv)
 	return 0;
 }
 
+static int stdout_is_tty;
+static int get_colorbool_found;
+static int git_get_colorbool_config(const char *var, const char *value)
+{
+	if (!strcmp(var, get_color_slot))
+		get_colorbool_found =
+			git_config_colorbool(var, value, stdout_is_tty);
+	return 0;
+}
+
+static int get_colorbool(int argc, const char **argv)
+{
+	/*
+	 * git config --get-colorbool <slot> [<stdout-is-tty>]
+	 *
+	 * returns "true" or "false" depending on how <slot>
+	 * is configured.
+	 */
+
+	if (argc == 2)
+		stdout_is_tty = git_config_bool("command line", argv[1]);
+	else if (argc == 1)
+		stdout_is_tty = isatty(1);
+	else
+		usage(git_config_set_usage);
+	get_colorbool_found = 0;
+	get_color_slot = argv[0];
+	git_config(git_get_colorbool_config);
+
+	if (argc == 1) {
+		return get_colorbool_found ? 0 : 1;
+	} else {
+		printf("%s\n", get_colorbool_found ? "true" : "false");
+		return 0;
+	}
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = 0;
@@ -283,6 +320,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return 0;
 		} else if (!strcmp(argv[1], "--get-color")) {
 			return get_color(argc-2, argv+2);
+		} else if (!strcmp(argv[1], "--get-colorbool")) {
+			return get_colorbool(argc-2, argv+2);
 		} else
 			break;
 		argc--;
diff --git a/color.c b/color.c
index 97cfbda..7bd424a 100644
--- a/color.c
+++ b/color.c
@@ -116,7 +116,7 @@ bad:
 	die("bad config value '%s' for variable '%s'", value, var);
 }
 
-int git_config_colorbool(const char *var, const char *value)
+int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 {
 	if (value) {
 		if (!strcasecmp(value, "never"))
@@ -133,7 +133,9 @@ int git_config_colorbool(const char *var, const char *value)
 
 	/* any normal truth value defaults to 'auto' */
  auto_color:
-	if (isatty(1) || (pager_in_use && pager_use_color)) {
+	if (stdout_is_tty < 0)
+		stdout_is_tty = isatty(1);
+	if (stdout_is_tty || (pager_in_use && pager_use_color)) {
 		char *term = getenv("TERM");
 		if (term && strcmp(term, "dumb"))
 			return 1;
diff --git a/color.h b/color.h
index 6809800..ff63513 100644
--- a/color.h
+++ b/color.h
@@ -4,7 +4,7 @@
 /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
 #define COLOR_MAXLEN 24
 
-int git_config_colorbool(const char *var, const char *value);
+int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
 void color_parse(const char *var, const char *value, char *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
diff --git a/diff.c b/diff.c
index 6b54959..be6cf68 100644
--- a/diff.c
+++ b/diff.c
@@ -146,7 +146,7 @@ int git_diff_ui_config(const char *var, const char *value)
 		return 0;
 	}
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
-		diff_use_color_default = git_config_colorbool(var, value);
+		diff_use_color_default = git_config_colorbool(var, value, -1);
 		return 0;
 	}
 	if (!strcmp(var, "diff.renames")) {
diff --git a/wt-status.c b/wt-status.c
index d35386d..02dbb75 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -391,7 +391,7 @@ void wt_status_print(struct wt_status *s)
 int git_status_config(const char *k, const char *v)
 {
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
-		wt_status_use_color = git_config_colorbool(k, v);
+		wt_status_use_color = git_config_colorbool(k, v, -1);
 		return 0;
 	}
 	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
-- 
1.5.3.7-2132-gbd1cf
