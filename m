From: Matthias Kestenholz <mk@spinlock.ch>
Subject: [PATCH/resend] Add color.ui variable which globally enables
	colorization if set
Date: Thu, 10 Jan 2008 10:03:16 +0100
Message-ID: <1199955796.6831.5.camel@futex>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 10:24:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCteV-0001JM-7H
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 10:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268AbYAJJXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 04:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757175AbYAJJXQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 04:23:16 -0500
Received: from mail21.bluewin.ch ([195.186.18.66]:36792 "EHLO
	mail21.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821AbYAJJXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 04:23:11 -0500
X-Greylist: delayed 1137 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2008 04:23:10 EST
Received: from futex.feinheit.ch (213.3.44.95) by mail21.bluewin.ch (Bluewin 7.3.121)
        id 476BDFDB0047D332; Thu, 10 Jan 2008 09:03:17 +0000
Received: (nullmailer pid 17499 invoked by uid 1000);
	Thu, 10 Jan 2008 09:03:17 -0000
X-Mailer: Evolution 2.21.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70055>

This patch introduces the color.ui variable which globally enables colorization.
More specific colorization variables like color.branch, color.diff etc. take
precedence.

color.ui is not respected by git add --interactive and git svn yet.

Signed-off-by: Matthias Kestenholz <mk@spinlock.ch>
---
 Documentation/config.txt |    7 +++++++
 builtin-branch.c         |   10 +++++++---
 builtin-commit.c         |    4 ++++
 builtin-diff.c           |    5 +++++
 builtin-log.c            |   17 +++++++++++++++++
 color.c                  |   12 ++++++++++++
 color.h                  |   11 +++++++++++
 diff.c                   |    6 +++---
 diff.h                   |    1 +
 wt-status.c              |    6 +++---
 10 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1b6d6d6..b55f3b4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -439,6 +439,13 @@ color.status.<slot>::
 commit.template::
 	Specify a file to use as the template for new commit messages.
 
+color.ui::
+	When set to `always`, always use colors in all git commands which
+	are capable of colored output. When false (or `never`), never. When
+	set to `true` or `auto`, use colors only when the output is to the
+	terminal. When more specific variables of color.* are set, they always
+	take precedence over this setting. Defaults to false.
+
 diff.autorefreshindex::
 	When using `git diff` to compare with work tree
 	files, do not consider stat-only change as changed.
diff --git a/builtin-branch.c b/builtin-branch.c
index 089cae5..9a1eb21 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -31,7 +31,7 @@ static unsigned char head_sha1[20];
 
 static int branch_track = 1;
 
-static int branch_use_color;
+static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
 	"",		/* PLAIN (normal) */
@@ -76,12 +76,12 @@ static int git_branch_config(const char *var, const char *value)
 	if (!strcmp(var, "branch.autosetupmerge"))
 			branch_track = git_config_bool(var, value);
 
-	return git_default_config(var, value);
+	return git_color_default_config(var, value);
 }
 
 static const char *branch_get_color(enum color_branch ix)
 {
-	if (branch_use_color)
+	if (branch_use_color > 0)
 		return branch_colors[ix];
 	return "";
 }
@@ -585,6 +585,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_branch_config);
+
+	if (branch_use_color == -1)
+		branch_use_color = git_use_color_default;
+
 	track = branch_track;
 	argc = parse_options(argc, argv, options, builtin_branch_usage, 0);
 	if (!!delete + !!rename + !!force_create > 1)
diff --git a/builtin-commit.c b/builtin-commit.c
index 73f1e35..ba60cfa 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -7,6 +7,7 @@
 
 #include "cache.h"
 #include "cache-tree.h"
+#include "color.h"
 #include "dir.h"
 #include "builtin.h"
 #include "diff.h"
@@ -640,6 +641,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	git_config(git_status_config);
 
+	if (wt_status_use_color == -1)
+		wt_status_use_color = git_use_color_default;
+
 	argc = parse_and_validate_options(argc, argv, builtin_status_usage);
 
 	index_file = prepare_index(argc, argv, prefix);
diff --git a/builtin-diff.c b/builtin-diff.c
index 29365a0..77a9c9a 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "cache.h"
+#include "color.h"
 #include "commit.h"
 #include "blob.h"
 #include "tag.h"
@@ -229,6 +230,10 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	prefix = setup_git_directory_gently(&nongit);
 	git_config(git_diff_ui_config);
+
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+
 	init_revisions(&rev, prefix);
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
 
diff --git a/builtin-log.c b/builtin-log.c
index dcc9f81..880da94 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -5,6 +5,7 @@
  *		 2006 Junio Hamano
  */
 #include "cache.h"
+#include "color.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
@@ -235,6 +236,10 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config);
+
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
@@ -307,6 +312,10 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	int i, count, ret = 0;
 
 	git_config(git_log_config);
+
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.combine_merges = 1;
@@ -367,6 +376,10 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config);
+
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+
 	init_revisions(&rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
 	rev.abbrev_commit = 1;
@@ -395,6 +408,10 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config);
+
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	cmd_log_init(argc, argv, prefix, &rev);
diff --git a/color.c b/color.c
index 7f66c29..09b81fe 100644
--- a/color.c
+++ b/color.c
@@ -3,6 +3,8 @@
 
 #define COLOR_RESET "\033[m"
 
+int git_use_color_default = 0;
+
 static int parse_color(const char *name, int len)
 {
 	static const char * const color_names[] = {
@@ -143,6 +145,16 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 	return 0;
 }
 
+int git_color_default_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "color.ui")) {
+		git_use_color_default = git_config_colorbool(var, value, -1);
+		return 0;
+	}
+
+	return git_default_config(var, value);
+}
+
 static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 		va_list args, const char *trail)
 {
diff --git a/color.h b/color.h
index ff63513..ecda556 100644
--- a/color.h
+++ b/color.h
@@ -4,6 +4,17 @@
 /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
 #define COLOR_MAXLEN 24
 
+/*
+ * This variable stores the value of color.ui
+ */
+extern int git_use_color_default;
+
+
+/*
+ * Use this instead of git_default_config if you need the value of color.ui.
+ */
+int git_color_default_config(const char *var, const char *value);
+
 int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
 void color_parse(const char *var, const char *value, char *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
diff --git a/diff.c b/diff.c
index b18c140..d6f23c7 100644
--- a/diff.c
+++ b/diff.c
@@ -20,7 +20,7 @@
 
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = 100;
-static int diff_use_color_default;
+int diff_use_color_default = -1;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 
@@ -189,7 +189,7 @@ int git_diff_basic_config(const char *var, const char *value)
 		}
 	}
 
-	return git_default_config(var, value);
+	return git_color_default_config(var, value);
 }
 
 static char *quote_two(const char *one, const char *two)
@@ -2048,7 +2048,7 @@ void diff_setup(struct diff_options *options)
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
-	if (diff_use_color_default)
+	if (diff_use_color_default > 0)
 		DIFF_OPT_SET(options, COLOR_DIFF);
 	else
 		DIFF_OPT_CLR(options, COLOR_DIFF);
diff --git a/diff.h b/diff.h
index 073d5cb..8e73f07 100644
--- a/diff.h
+++ b/diff.h
@@ -174,6 +174,7 @@ extern void diff_unmerge(struct diff_options *,
 
 extern int git_diff_basic_config(const char *var, const char *value);
 extern int git_diff_ui_config(const char *var, const char *value);
+extern int diff_use_color_default;
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
 extern int diff_setup_done(struct diff_options *);
diff --git a/wt-status.c b/wt-status.c
index c0c2472..0dfc909 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,7 +9,7 @@
 #include "diffcore.h"
 
 int wt_status_relative_paths = 1;
-int wt_status_use_color = 0;
+int wt_status_use_color = -1;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
 	"\033[32m", /* WT_STATUS_UPDATED: green */
@@ -40,7 +40,7 @@ static int parse_status_slot(const char *var, int offset)
 
 static const char* color(int slot)
 {
-	return wt_status_use_color ? wt_status_colors[slot] : "";
+	return wt_status_use_color > 0 ? wt_status_colors[slot] : "";
 }
 
 void wt_status_prepare(struct wt_status *s)
@@ -409,5 +409,5 @@ int git_status_config(const char *k, const char *v)
 		wt_status_relative_paths = git_config_bool(k, v);
 		return 0;
 	}
-	return git_default_config(k, v);
+	return git_color_default_config(k, v);
 }
-- 
1.5.4.rc2.68.ge708a-dirty
