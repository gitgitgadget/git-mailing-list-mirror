From: Simon Hausmann <simon@lst.de>
Subject: [PATCH 2/3] Introduce core.showUntrackedFiles to make it possible to disable showing of untracked files.
Date: Fri, 30 May 2008 10:54:35 +0200
Message-ID: <3088e5a9507aa55ee55f512fb3bd554f1658d2e3.1212152269.git.marius@trolltech.com>
References: <043361f81946d5657217e6be0f22f4df350fd13f.1212152269.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 30 15:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K24MJ-0007vn-51
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 15:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbYE3NIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 09:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbYE3NIe
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 09:08:34 -0400
Received: from hoat.troll.no ([62.70.27.150]:46282 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbYE3NId convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 09:08:33 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 2D64420C2E;
	Fri, 30 May 2008 15:08:32 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 22F1F20C0C;
	Fri, 30 May 2008 15:08:32 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83295>

Determining untracked files can be a very slow operation on large trees. This commit introduces
a configuration variable that makes it possible to disable showing of untracked files by default
as well as a -U commandline option to override this.

Signed-off-by: Simon Hausmann <simon@lst.de>
Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/config.txt     |    5 +++++
 Documentation/git-commit.txt |   11 ++++++++---
 builtin-commit.c             |    1 +
 config.c                     |    7 +++++++
 environment.c                |    1 +
 wt-status.c                  |    7 ++++++-
 wt-status.h                  |    1 +
 7 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5331b45..e42ead0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -214,6 +214,11 @@ core.ignoreStat::
 	See linkgit:git-update-index[1].
 	False by default.
 
+core.showUntrackedFiles::
+	A boolean to enable/disable displaying untracked files in the output
+	of linkgit:git-status[1] and linkgit:git-commit[1].
+	Defaults to true.
+
 core.preferSymlinkRefs::
 	Instead of the default "symref" format for HEAD
 	and other symbolic reference files, use symbolic links.
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c3c9f5b..a3174e4 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -150,12 +150,17 @@ but can be used to amend a merge commit.
 	the last commit without committing changes that have
 	already been staged.
 
+-U|--untracked::
+	Show untracked files, in the "Untracked files:" section of commit
+	message template.
+	This option overrides the core.showUntrackedFiles
+	configuration option, and is normally not needed.
+
 -u|--untracked-files::
 	Show all untracked files, also those in uninteresting
-	directories, in the "Untracked files:" section of commit
-	message template.  Without this option only its name and
+	directories.  Without this option only its name and
 	a trailing slash are displayed for each untracked
-	directory.
+	directory. This option implies --untracked.
 
 -v|--verbose::
 	Show unified diff between the HEAD commit and what
diff --git a/builtin-commit.c b/builtin-commit.c
index b294c1f..28cc170 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -103,6 +103,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN('u', "untracked-files", &untracked_files, "show all untracked files"),
+	OPT_BOOLEAN('U', "untracked", &show_untracked_files, "show untracked files"),
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 
diff --git a/config.c b/config.c
index c2f2bbb..ba3efd1 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "exec_cmd.h"
+#include "wt-status.h"
 
 #define MAXNAME (256)
 
@@ -511,6 +512,12 @@ int git_default_config(const char *var, const char *value, void *dummy)
 			return error("Malformed value for %s", var);
 		return 0;
 	}
+	if (!strcmp(var, "core.showuntrackedfiles")) {
+		if (!value)
+			return config_error_nonbool(var);
+		show_untracked_files = git_config_bool(var, value);
+		return 0;
+	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/environment.c b/environment.c
index 73feb2d..210ae17 100644
--- a/environment.c
+++ b/environment.c
@@ -41,6 +41,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
+int show_untracked_files = 1;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
diff --git a/wt-status.c b/wt-status.c
index 5b4d74c..819fe2d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -347,7 +347,10 @@ void wt_status_print(struct wt_status *s)
 	wt_status_print_changed(s);
 	if (wt_status_submodule_summary)
 		wt_status_print_submodule_summary(s);
-	wt_status_print_untracked(s);
+	if (show_untracked_files)
+		wt_status_print_untracked(s);
+	else if (s->commitable)
+		fprintf(s->fp, "# Untracked files not listed (use -U option to show untracked files)\n");
 
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
@@ -362,6 +365,8 @@ void wt_status_print(struct wt_status *s)
 			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
 		else if (s->is_initial)
 			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
+		else if (!show_untracked_files)
+			printf("nothing to commit (use -U to show untracked files)\n");
 		else
 			printf("nothing to commit (working directory clean)\n");
 	}
diff --git a/wt-status.h b/wt-status.h
index 597c7ea..4b643b4 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -33,5 +33,6 @@ extern int wt_status_use_color;
 extern int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
+extern int show_untracked_files;
 
 #endif /* STATUS_H */
-- 
1.5.5.GIT
