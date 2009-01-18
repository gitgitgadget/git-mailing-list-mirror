From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/2] handle color.ui at a central place
Date: Sun, 18 Jan 2009 21:37:15 +0100
Message-ID: <200901182137.16562.markus.heidelberg@web.de>
References: <20090117153846.GB27071@coredump.intra.peff.net> <20090118194328.GA31180@coredump.intra.peff.net> <20090118195342.GA612@coredump.intra.peff.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 21:37:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOeP5-0000yS-Ml
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 21:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbZARUgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 15:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbZARUgb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 15:36:31 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:51737 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZARUga (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 15:36:30 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5A5A8FBEC388;
	Sun, 18 Jan 2009 21:36:28 +0100 (CET)
Received: from [89.59.120.98] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LOeNg-0004CN-00; Sun, 18 Jan 2009 21:36:28 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090118195342.GA612@coredump.intra.peff.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/EQCqFDSvL06/G4HFDNm3plYbja1Nij/KUSlo3
	suD0c7dMAEOwr112egGiYIkusZgK4QbjEAmZQPLNyX+T6XB0M/
	deZJd3Vlts2UEvtNNK6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106277>

Jeff King, 18.01.2009:
> On Sun, Jan 18, 2009 at 02:43:28PM -0500, Jeff King wrote:
> 
> > Here is a patch that seems to work. It predicates pretty format colors
> > on diff colors, which is the same way the yellow commit header works in
> > log-tree. I don't know if it makes more sense to introduce yet another
> > color config option.
> > 
> > And I say "seems to work" because I remember there being some trickery
> > with color flags sometimes not getting set properly. However, since this
> > is the same flag as the yellow commit header, and called around the same
> > time, I think it should be fine.
> 
> Hrm. OK, it doesn't actually work always. It does for git-log, but not
> for rev-list, which leaves diff_use_color_default as -1. I don't know if
> there are any other ways you can get to this code path without having
> set diff_use_color_default.
> 
> Maybe it is time to do a cleanup on the color handling, which has
> provided no end of these bugs. I will have to leave that for another
> day, though.

Not sure, if you it has something to do with the following, but I had
this in my tree for some days now, waiting for the 2 commits mentioned
in the log message to graduate to master, which happend just an hour or
so ago.

And a good opportunity to test the 8< scissors :)

-- 8< --
The color.ui variable had to be evaluated in the commands that use
colors. This could lead to missing colors, if it was forgotten for
certain git commands. Centralizing the handling of color.ui for branch,
diff and status color avoids this problem and also reduces code
duplication.

See commit 3f4b609 (git-commit: color status output when color.ui is set,
2009-01-08) and commit 38920dd (git-status -v: color diff output when
color.ui is set, 2009-01-08) for fixes of these bugs.

There is a fourth variable color.interactive, but this is currently only
used in git-add-interactive.perl, so there is no need for handling this
as well, so far.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 builtin-branch.c |    4 ----
 builtin-commit.c |    9 ---------
 builtin-diff.c   |    3 ---
 builtin-log.c    |   12 ------------
 builtin-merge.c  |    4 ----
 color.c          |   16 ++++++++++++++++
 color.h          |    2 ++
 config.c         |    9 +++++++--
 8 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 02fa38f..6aa329b 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -30,7 +30,6 @@ static const char * const builtin_branch_usage[] = {
 static const char *head;
 static unsigned char head_sha1[20];
 
-static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
 	"",		/* PLAIN (normal) */
@@ -553,9 +552,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	git_config(git_branch_config, NULL);
 
-	if (branch_use_color == -1)
-		branch_use_color = git_use_color_default;
-
 	track = git_branch_track;
 
 	head = resolve_ref("HEAD", head_sha1, 0, NULL);
diff --git a/builtin-commit.c b/builtin-commit.c
index 2f0b00a..5cac034 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -862,12 +862,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	git_config(git_status_config, NULL);
 
-	if (wt_status_use_color == -1)
-		wt_status_use_color = git_use_color_default;
-
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	argc = parse_and_validate_options(argc, argv, builtin_status_usage, prefix);
 
 	index_file = prepare_index(argc, argv, prefix);
@@ -947,9 +941,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	git_config(git_commit_config, NULL);
 
-	if (wt_status_use_color == -1)
-		wt_status_use_color = git_use_color_default;
-
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage, prefix);
 
 	index_file = prepare_index(argc, argv, prefix);
diff --git a/builtin-diff.c b/builtin-diff.c
index d75d69b..d8645cf 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -279,9 +279,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	prefix = setup_git_directory_gently(&nongit);
 	git_config(git_diff_ui_config, NULL);
 
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	init_revisions(&rev, prefix);
 
 	/* If this is a no-index diff, just run it and exit there. */
diff --git a/builtin-log.c b/builtin-log.c
index c7aa48e..84027d4 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -236,9 +236,6 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 
 	git_config(git_log_config, NULL);
 
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
@@ -303,9 +300,6 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 
 	git_config(git_log_config, NULL);
 
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.combine_merges = 1;
@@ -373,9 +367,6 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 
 	git_config(git_log_config, NULL);
 
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	init_revisions(&rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
 	rev.abbrev_commit = 1;
@@ -406,9 +397,6 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 
 	git_config(git_log_config, NULL);
 
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	cmd_log_init(argc, argv, prefix, &rev);
diff --git a/builtin-merge.c b/builtin-merge.c
index cf86975..8e726da 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -872,10 +872,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	git_config(git_merge_config, NULL);
 
-	/* for color.ui */
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
-
 	argc = parse_options(argc, argv, builtin_merge_options,
 			builtin_merge_usage, 0);
 	if (verbosity < 0)
diff --git a/color.c b/color.c
index fc0b72a..7a8bf6e 100644
--- a/color.c
+++ b/color.c
@@ -1,9 +1,12 @@
 #include "cache.h"
 #include "color.h"
+#include "diff.h"
+#include "wt-status.h"
 
 #define COLOR_RESET "\033[m"
 
 int git_use_color_default = 0;
+int branch_use_color = -1;
 
 static int parse_color(const char *name, int len)
 {
@@ -155,6 +158,19 @@ int git_color_default_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+void git_finish_color_config(void)
+{
+	if (git_use_color_default) {
+		/* Enable colors, if undefined in the config files */
+		if (branch_use_color == -1)
+			branch_use_color = git_use_color_default;
+		if (diff_use_color_default == -1)
+			diff_use_color_default = git_use_color_default;
+		if (wt_status_use_color == -1)
+			wt_status_use_color = git_use_color_default;
+	}
+}
+
 static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 		va_list args, const char *trail)
 {
diff --git a/color.h b/color.h
index 6cf5c88..6924848 100644
--- a/color.h
+++ b/color.h
@@ -9,12 +9,14 @@
  */
 extern int git_use_color_default;
 
+extern int branch_use_color;
 
 /*
  * Use this instead of git_default_config if you need the value of color.ui.
  */
 int git_color_default_config(const char *var, const char *value, void *cb);
 
+void git_finish_color_config(void);
 int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
 void color_parse(const char *var, const char *value, char *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
diff --git a/config.c b/config.c
index 790405a..e35afbc 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "exec_cmd.h"
+#include "color.h"
 
 #define MAXNAME (256)
 
@@ -637,8 +638,10 @@ int git_config(config_fn_t fn, void *data)
 	const char *home = NULL;
 
 	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
-	if (config_exclusive_filename)
-		return git_config_from_file(fn, config_exclusive_filename, data);
+	if (config_exclusive_filename) {
+		ret += git_config_from_file(fn, config_exclusive_filename, data);
+		goto finish;
+	}
 	if (git_config_system() && !access(git_etc_gitconfig(), R_OK))
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
@@ -654,6 +657,8 @@ int git_config(config_fn_t fn, void *data)
 	repo_config = git_pathdup("config");
 	ret += git_config_from_file(fn, repo_config, data);
 	free(repo_config);
+ finish:
+	git_finish_color_config();
 	return ret;
 }
 
-- 
1.6.1.208.g3a5f4
