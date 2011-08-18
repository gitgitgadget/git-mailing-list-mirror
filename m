From: Jeff King <peff@peff.net>
Subject: [PATCH 10/10] want_color: automatically fallback to color.ui
Date: Wed, 17 Aug 2011 22:05:35 -0700
Message-ID: <20110818050533.GJ2889@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:05:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtuna-0008EW-6W
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366Ab1HRFFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:05:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45213
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab1HRFFl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:05:41 -0400
Received: (qmail 18485 invoked by uid 107); 18 Aug 2011 05:06:21 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 01:06:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:05:35 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179567>

All of the "do we want color" flags default to -1 to
indicate that we don't have any color configured. This value
is handled in one of two ways:

  1. In porcelain, we check early on whether the value is
     still -1 after reading the config, and set it to the
     value of color.ui (which defaults to 0).

  2. In plumbing, it stays untouched as -1, and want_color
     defaults it to off.

This works fine, but means that every porcelain has to check
and reassign its color flag. Now that want_color gives us a
place to put this check in a single spot, we can do that,
simplifying the calling code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c      |    3 ---
 builtin/commit.c      |   11 +----------
 builtin/diff.c        |    3 ---
 builtin/grep.c        |    2 --
 builtin/log.c         |   12 ------------
 builtin/merge.c       |    4 ----
 builtin/show-branch.c |    3 ---
 color.c               |    7 +++++--
 color.h               |    5 -----
 9 files changed, 6 insertions(+), 44 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d6d3c7d..73d4170 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -673,9 +673,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	git_config(git_branch_config, NULL);
 
-	if (branch_use_color == -1)
-		branch_use_color = git_use_color_default;
-
 	track = git_branch_track;
 
 	head = resolve_ref("HEAD", head_sha1, 0, NULL);
diff --git a/builtin/commit.c b/builtin/commit.c
index 295803a..9763146 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1237,10 +1237,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	if (s.relative_paths)
 		s.prefix = prefix;
-	if (s.use_color == -1)
-		s.use_color = git_use_color_default;
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
 
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
@@ -1394,15 +1390,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	git_config(git_commit_config, &s);
 	determine_whence(&s);
 
-	if (s.use_color == -1)
-		s.use_color = git_use_color_default;
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage,
 					  prefix, &s);
-	if (dry_run) {
-		if (diff_use_color_default == -1)
-			diff_use_color_default = git_use_color_default;
+	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, &s);
-	}
 	index_file = prepare_index(argc, argv, prefix, 0);
 
 	/* Set up everything for writing the commit object.  This includes
diff --git a/builtin/diff.c b/builtin/diff.c
index 69cd5ee..1118689 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -277,9 +277,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(git_diff_ui_config, NULL);
 
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	init_revisions(&rev, prefix);
 
 	/* If this is a no-index diff, just run it and exit there. */
diff --git a/builtin/grep.c b/builtin/grep.c
index d80db22..2cbf01f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -896,8 +896,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	strcpy(opt.color_sep, GIT_COLOR_CYAN);
 	opt.color = -1;
 	git_config(grep_config, &opt);
-	if (opt.color == -1)
-		opt.color = git_use_color_default;
 
 	/*
 	 * If there is no -- then the paths must exist in the working
diff --git a/builtin/log.c b/builtin/log.c
index 5c2af59..d760ee0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -359,9 +359,6 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 
 	git_config(git_log_config, NULL);
 
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
@@ -446,9 +443,6 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 
 	git_config(git_log_config, NULL);
 
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	init_pathspec(&match_all, NULL);
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
@@ -524,9 +518,6 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 
 	git_config(git_log_config, NULL);
 
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	init_revisions(&rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
 	rev.verbose_header = 1;
@@ -549,9 +540,6 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 
 	git_config(git_log_config, NULL);
 
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
diff --git a/builtin/merge.c b/builtin/merge.c
index 7209edf..b75ae01 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1031,10 +1031,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	git_config(git_merge_config, NULL);
 
-	/* for color.ui */
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	if (branch_mergeoptions)
 		parse_branch_merge_options(branch_mergeoptions);
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 4b726fa..4b480d7 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -685,9 +685,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 
 	git_config(git_show_branch_config, NULL);
 
-	if (showbranch_use_color == -1)
-		showbranch_use_color = git_use_color_default;
-
 	/* If nothing is specified, try the default first */
 	if (ac == 1 && default_num) {
 		ac = default_num;
diff --git a/color.c b/color.c
index ec96fe1..e8e2681 100644
--- a/color.c
+++ b/color.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "color.h"
 
-int git_use_color_default = 0;
+static int git_use_color_default = 0;
 int color_stdout_is_tty = -1;
 
 /*
@@ -196,12 +196,15 @@ int want_color(int var)
 {
 	static int want_auto = -1;
 
+	if (var < 0)
+		var = git_use_color_default;
+
 	if (var == GIT_COLOR_AUTO) {
 		if (want_auto < 0)
 			want_auto = check_auto_color();
 		return want_auto;
 	}
-	return var > 0;
+	return var;
 }
 
 int git_color_config(const char *var, const char *value, void *cb)
diff --git a/color.h b/color.h
index 5949bcd..3068a99 100644
--- a/color.h
+++ b/color.h
@@ -58,11 +58,6 @@ struct strbuf;
 #define GIT_COLOR_NEVER  1
 #define GIT_COLOR_AUTO   2
 
-/*
- * This variable stores the value of color.ui
- */
-extern int git_use_color_default;
-
 /* A default list of colors to use for commit graphs and show-branch output */
 extern const char *column_colors_ansi[];
 extern const int column_colors_ansi_max;
-- 
1.7.6.10.g62f04
