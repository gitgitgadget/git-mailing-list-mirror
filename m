From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH] Add `[decorate]' configuration section.
Date: Wed, 17 Feb 2010 21:22:46 +1300
Message-ID: <16c38171fc04cee7bdc607bb4c6586925b15278c.1266394059.git.sdrake@xnet.co.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 09:49:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhfbM-0007Ju-BM
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 09:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934091Ab0BQIti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 03:49:38 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:38871 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934032Ab0BQIti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 03:49:38 -0500
Received: from localhost.localdomain (ip-118-90-92-203.xdsl.xnet.co.nz [118.90.92.203])
	by ananke.wxnz.net (Postfix) with ESMTP id C72B641519
	for <git@vger.kernel.org>; Wed, 17 Feb 2010 21:30:34 +1300 (NZDT)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140218>

This can be used to enable the display of ref names of commits that are
shown by log commands.  Each of the log commands (whatchanged, show,
reflog, and log) can be enable separately.

e.g:
	[decorate]
		log
		reflog

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 Documentation/config.txt |   12 ++++++++++++
 builtin-log.c            |   43 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4c36aa9..dc9d6fd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -740,6 +740,18 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
 	specified user's home directory.
 
+decorate.whatchanged::
+decorate.log::
+decorate.reflog::
+decorate.show::
+	Print out the ref names of any commits that are shown by the different
+	log command.  If 'short' is specified, the ref name prefixes
+	'refs/heads/', 'refs/tags/' and 'refs/remotes/' will not be printed.
+	If 'full' is specified, the full ref name (including prefix) will be
+	printed.  May be set as a bool which will be treated as 'short'.
+	This is the same as the log commands '--decorate' option.
+
+
 diff.autorefreshindex::
 	When using 'git diff' to compare with work tree
 	files, do not consider stat-only change as changed.
diff --git a/builtin-log.c b/builtin-log.c
index 8d16832..51b5e10 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -24,6 +24,8 @@
 static const char *default_date_mode = NULL;
 
 static int default_show_root = 1;
+static struct { int whatchanged, show, reflog, log;} decorate = {0,0,0,0};
+static int decoration_style = 0;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -35,7 +37,6 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
 	int i;
-	int decoration_style = 0;
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -58,9 +59,6 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		usage(builtin_log_usage);
 	argc = setup_revisions(argc, argv, rev, "HEAD");
 
-	if (!rev->show_notes_given && !rev->pretty_given)
-		rev->show_notes = 1;
-
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
@@ -244,8 +242,41 @@ static int cmd_log_walk(struct rev_info *rev)
 	return diff_result_code(&rev->diffopt, 0);
 }
 
+static int set_decoration_style(const char *var, const char *value)
+{
+	switch (git_config_maybe_bool(var, value)) {
+	case 0:
+		return 0;
+	case 1:
+		return DECORATE_SHORT_REFS;
+	default:
+		break;
+	}
+	if (!strcmp(value, "full"))
+		return DECORATE_FULL_REFS;
+	else if (!strcmp(value, "short"))
+		return DECORATE_SHORT_REFS;
+	return 0;
+}
+
 static int git_log_config(const char *var, const char *value, void *cb)
 {
+	if (!strcmp(var, "decorate.log")) {
+		decorate.log = set_decoration_style(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "decorate.reflog")) {
+		decorate.reflog = set_decoration_style(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "decorate.show")) {
+		decorate.show = set_decoration_style(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "decorate.whatchanged")) {
+		decorate.whatchanged = set_decoration_style(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
@@ -264,6 +295,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config, NULL);
+	decoration_style = decorate.whatchanged;
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
@@ -331,6 +363,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	int i, count, ret = 0;
 
 	git_config(git_log_config, NULL);
+	decoration_style = decorate.show;
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
@@ -407,6 +440,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config, NULL);
+	decoration_style = decorate.reflog;
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
@@ -440,6 +474,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config, NULL);
+	decoration_style = decorate.log;
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
-- 
1.6.6
