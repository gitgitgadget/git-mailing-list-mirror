From: Jeff King <peff@peff.net>
Subject: [PATCH 06/10] git_config_colorbool: refactor stdout_is_tty handling
Date: Wed, 17 Aug 2011 22:03:48 -0700
Message-ID: <20110818050346.GF2889@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:04:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtulr-0007Zg-AT
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab1HRFDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:03:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45192
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab1HRFDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:03:54 -0400
Received: (qmail 18358 invoked by uid 107); 18 Aug 2011 05:04:34 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 01:04:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:03:48 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179563>

Usually this function figures out for itself whether stdout
is a tty. However, it has an extra parameter just to allow
git-config to override the auto-detection for its
--get-colorbool option.

Instead of an extra parameter, let's just use a global
variable. This makes calling easier in the common case, and
will make refactoring the colorbool code much simpler.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c      |    2 +-
 builtin/commit.c      |    2 +-
 builtin/config.c      |   23 +++++++----------------
 builtin/grep.c        |    2 +-
 builtin/show-branch.c |    2 +-
 color.c               |   11 ++++++-----
 color.h               |    8 +++++++-
 diff.c                |    4 ++--
 parse-options.c       |    2 +-
 9 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3142daa..b15fee5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -71,7 +71,7 @@ static int parse_branch_color_slot(const char *var, int ofs)
 static int git_branch_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "color.branch")) {
-		branch_use_color = git_config_colorbool(var, value, -1);
+		branch_use_color = git_config_colorbool(var, value);
 		return 0;
 	}
 	if (!prefixcmp(var, "color.branch.")) {
diff --git a/builtin/commit.c b/builtin/commit.c
index e1af9b1..295803a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1144,7 +1144,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
-		s->use_color = git_config_colorbool(k, v, -1);
+		s->use_color = git_config_colorbool(k, v);
 		return 0;
 	}
 	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
diff --git a/builtin/config.c b/builtin/config.c
index 211e118..5505ced 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -303,24 +303,17 @@ static void get_color(const char *def_color)
 	fputs(parsed_color, stdout);
 }
 
-static int stdout_is_tty;
 static int get_colorbool_found;
 static int get_diff_color_found;
 static int git_get_colorbool_config(const char *var, const char *value,
 		void *cb)
 {
-	if (!strcmp(var, get_colorbool_slot)) {
-		get_colorbool_found =
-			git_config_colorbool(var, value, stdout_is_tty);
-	}
-	if (!strcmp(var, "diff.color")) {
-		get_diff_color_found =
-			git_config_colorbool(var, value, stdout_is_tty);
-	}
-	if (!strcmp(var, "color.ui")) {
-		git_use_color_default = git_config_colorbool(var, value, stdout_is_tty);
-		return 0;
-	}
+	if (!strcmp(var, get_colorbool_slot))
+		get_colorbool_found = git_config_colorbool(var, value);
+	else if (!strcmp(var, "diff.color"))
+		get_diff_color_found = git_config_colorbool(var, value);
+	else if (!strcmp(var, "color.ui"))
+		git_use_color_default = git_config_colorbool(var, value);
 	return 0;
 }
 
@@ -510,9 +503,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_GET_COLORBOOL) {
 		if (argc == 1)
-			stdout_is_tty = git_config_bool("command line", argv[0]);
-		else if (argc == 0)
-			stdout_is_tty = isatty(1);
+			color_stdout_is_tty = git_config_bool("command line", argv[0]);
 		return get_colorbool(argc != 0);
 	}
 
diff --git a/builtin/grep.c b/builtin/grep.c
index cccf8da..d80db22 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -325,7 +325,7 @@ static int grep_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "color.grep"))
-		opt->color = git_config_colorbool(var, value, -1);
+		opt->color = git_config_colorbool(var, value);
 	else if (!strcmp(var, "color.grep.context"))
 		color = opt->color_context;
 	else if (!strcmp(var, "color.grep.filename"))
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index facc63a..e6650b4 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -573,7 +573,7 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "color.showbranch")) {
-		showbranch_use_color = git_config_colorbool(var, value, -1);
+		showbranch_use_color = git_config_colorbool(var, value);
 		return 0;
 	}
 
diff --git a/color.c b/color.c
index 3db214c..67affa4 100644
--- a/color.c
+++ b/color.c
@@ -2,6 +2,7 @@
 #include "color.h"
 
 int git_use_color_default = 0;
+int color_stdout_is_tty = -1;
 
 /*
  * The list of available column colors.
@@ -157,7 +158,7 @@ bad:
 	die("bad color value '%.*s' for variable '%s'", value_len, value, var);
 }
 
-int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
+int git_config_colorbool(const char *var, const char *value)
 {
 	if (value) {
 		if (!strcasecmp(value, "never"))
@@ -177,9 +178,9 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 
 	/* any normal truth value defaults to 'auto' */
  auto_color:
-	if (stdout_is_tty < 0)
-		stdout_is_tty = isatty(1);
-	if (stdout_is_tty || (pager_in_use() && pager_use_color)) {
+	if (color_stdout_is_tty < 0)
+		color_stdout_is_tty = isatty(1);
+	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
 		char *term = getenv("TERM");
 		if (term && strcmp(term, "dumb"))
 			return 1;
@@ -190,7 +191,7 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 int git_color_default_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "color.ui")) {
-		git_use_color_default = git_config_colorbool(var, value, -1);
+		git_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
 
diff --git a/color.h b/color.h
index 68a926a..a190a25 100644
--- a/color.h
+++ b/color.h
@@ -58,11 +58,17 @@ extern const char *column_colors_ansi[];
 extern const int column_colors_ansi_max;
 
 /*
+ * Generally the color code will lazily figure this out itself, but
+ * this provides a mechanism for callers to override autodetection.
+ */
+extern int color_stdout_is_tty;
+
+/*
  * Use this instead of git_default_config if you need the value of color.ui.
  */
 int git_color_default_config(const char *var, const char *value, void *cb);
 
-int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
+int git_config_colorbool(const char *var, const char *value);
 void color_parse(const char *value, const char *var, char *dst);
 void color_parse_mem(const char *value, int len, const char *var, char *dst);
 __attribute__((format (printf, 3, 4)))
diff --git a/diff.c b/diff.c
index 2d86abe..2dfc359 100644
--- a/diff.c
+++ b/diff.c
@@ -137,7 +137,7 @@ static int git_config_rename(const char *var, const char *value)
 int git_diff_ui_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
-		diff_use_color_default = git_config_colorbool(var, value, -1);
+		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "diff.renames")) {
@@ -3409,7 +3409,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--color"))
 		options->use_color = 1;
 	else if (!prefixcmp(arg, "--color=")) {
-		int value = git_config_colorbool(NULL, arg+8, -1);
+		int value = git_config_colorbool(NULL, arg+8);
 		if (value == 0)
 			options->use_color = 0;
 		else if (value > 0)
diff --git a/parse-options.c b/parse-options.c
index 879ea82..be4383e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -621,7 +621,7 @@ int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
 
 	if (!arg)
 		arg = unset ? "never" : (const char *)opt->defval;
-	value = git_config_colorbool(NULL, arg, -1);
+	value = git_config_colorbool(NULL, arg);
 	if (value < 0)
 		return opterror(opt,
 			"expects \"always\", \"auto\", or \"never\"", 0);
-- 
1.7.6.10.g62f04
