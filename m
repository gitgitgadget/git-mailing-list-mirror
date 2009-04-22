From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH v2] show-branch: color the commit status signs
Date: Wed, 22 Apr 2009 23:41:25 +0200
Message-ID: <1240436485-30518-1-git-send-email-markus.heidelberg@web.de>
References: <7vskk01j9y.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 23:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwkDF-0007V2-DL
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbZDVVk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbZDVVk4
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:40:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49025 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbZDVVkz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:40:55 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5B61BFAF41F8;
	Wed, 22 Apr 2009 23:40:54 +0200 (CEST)
Received: from [89.59.119.90] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LwkBa-00007O-00; Wed, 22 Apr 2009 23:40:54 +0200
X-Mailer: git-send-email 1.6.3.rc1.61.ge6ab3
In-Reply-To: <7vskk01j9y.fsf@gitster.siamese.dyndns.org>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/O6LAMvhq20Fxw7UOPHbhiutD7wrWc8w5DDnRw
	GziiP4CmZUhYpFneU8m/1Qzgli6KHThKnF8d4RdJe9hUyxHJFz
	20bntKqCh56I2mVokJ7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117272>

Make it possible to color the status character ('*' '!' '+' '-') of each
commit corresponding to the branch it's in. This makes it easier to
follow a particular branch, especially if there are larger gaps in the
output.

Add the config option color.showbranch and the command line options
 --color and --no-color to control the colored output.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

    Clarify the --color description based on the suggestion from
    Stephen Boyd.

 Documentation/config.txt          |    6 ++++
 Documentation/git-show-branch.txt |    9 ++++++
 builtin-show-branch.c             |   51 ++++++++++++++++++++++++++++++++++---
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 35056e1..1383a29 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -595,6 +595,12 @@ color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
 
+color.showbranch::
+	A boolean to enable/disable color in the output of
+	linkgit:git-show-branch[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are used
+	only when the output is to a terminal. Defaults to false.
+
 color.status::
 	A boolean to enable/disable color in the output of
 	linkgit:git-status[1]. May be set to `always`,
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 7e9ff37..05868b6 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git show-branch' [--all] [--remotes] [--topo-order] [--current]
 		[--more=<n> | --list | --independent | --merge-base]
+		[--color | --no-color]
 		[--no-name | --sha1-name] [--topics] [<rev> | <glob>]...
 'git show-branch' (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
 
@@ -107,6 +108,14 @@ OPTIONS
 	When no explicit <ref> parameter is given, it defaults to the
 	current branch (or `HEAD` if it is detached).
 
+--color::
+	Color the status sign (one of these: `*` `!` `+` `-`) of each commit
+	corresponding to the branch it's in.
+
+--no-color::
+	Turn off colored output, even when the configuration file gives the
+	default to color output.
+
 Note that --more, --list, --independent and --merge-base options
 are mutually exclusive.
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 828e6f8..fc38f5e 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -2,12 +2,25 @@
 #include "commit.h"
 #include "refs.h"
 #include "builtin.h"
+#include "color.h"
 
 static const char show_branch_usage[] =
 "git show-branch [--sparse] [--current] [--all] [--remotes] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...] | --reflog[=n[,b]] <branch>";
 static const char show_branch_usage_reflog[] =
 "--reflog is incompatible with --all, --remotes, --independent or --merge-base";
 
+static int showbranch_use_color = -1;
+static char column_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RED,
+	GIT_COLOR_GREEN,
+	GIT_COLOR_YELLOW,
+	GIT_COLOR_BLUE,
+	GIT_COLOR_MAGENTA,
+	GIT_COLOR_CYAN,
+};
+
+#define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors))
+
 static int default_num;
 static int default_alloc;
 static const char **default_arg;
@@ -19,6 +32,20 @@ static const char **default_arg;
 
 #define DEFAULT_REFLOG	4
 
+static const char *get_color_code(int idx)
+{
+	if (showbranch_use_color)
+		return column_colors[idx];
+	return "";
+}
+
+static const char *get_color_reset_code(void)
+{
+	if (showbranch_use_color)
+		return GIT_COLOR_RESET;
+	return "";
+}
+
 static struct commit *interesting(struct commit_list *list)
 {
 	while (list) {
@@ -545,7 +572,12 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	if (!strcmp(var, "color.showbranch")) {
+		showbranch_use_color = git_config_colorbool(var, value, -1);
+		return 0;
+	}
+
+	return git_color_default_config(var, value, cb);
 }
 
 static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
@@ -611,6 +643,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 
 	git_config(git_show_branch_config, NULL);
 
+	if (showbranch_use_color == -1)
+		showbranch_use_color = git_use_color_default;
+
 	/* If nothing is specified, try the default first */
 	if (ac == 1 && default_num) {
 		ac = default_num + 1;
@@ -658,6 +693,10 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			parse_reflog_param(arg + 9, &reflog, &reflog_base);
 		else if (!prefixcmp(arg, "-g="))
 			parse_reflog_param(arg + 3, &reflog, &reflog_base);
+		else if (!strcmp(arg, "--color"))
+			showbranch_use_color = 1;
+		else if (!strcmp(arg, "--no-color"))
+			showbranch_use_color = 0;
 		else
 			usage(show_branch_usage);
 		ac--; av++;
@@ -843,8 +882,10 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			else {
 				for (j = 0; j < i; j++)
 					putchar(' ');
-				printf("%c [%s] ",
-				       is_head ? '*' : '!', ref_name[i]);
+				printf("%s%c%s [%s] ",
+				       get_color_code(i % COLUMN_COLORS_MAX),
+				       is_head ? '*' : '!',
+				       get_color_reset_code(), ref_name[i]);
 			}
 
 			if (!reflog) {
@@ -903,7 +944,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 					mark = '*';
 				else
 					mark = '+';
-				putchar(mark);
+				printf("%s%c%s",
+				       get_color_code(i % COLUMN_COLORS_MAX),
+				       mark, get_color_reset_code());
 			}
 			putchar(' ');
 		}
-- 
1.6.3.rc1.61.ge6ab3
