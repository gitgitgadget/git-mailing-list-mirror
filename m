From: "James P. Howard, II" <jh@jameshoward.us>
Subject: [PATCH] Add commit.status, --status, and --no-status
Date: Mon,  7 Dec 2009 17:45:27 -0500
Message-ID: <1260225927-33612-1-git-send-email-jh@jameshoward.us>
References: <20091206131217.GA12851@sigill.intra.peff.net>
Cc: "James P. Howard, II" <jh@jameshoward.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 23:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHmKu-0004qG-Jg
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 23:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935673AbZLGWpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 17:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934201AbZLGWpb
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 17:45:31 -0500
Received: from byzantine.jameshoward.us ([204.109.63.101]:18521 "EHLO
	byzantine.jameshoward.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933131AbZLGWpa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 17:45:30 -0500
Received: from byzantine.jameshoward.us (localhost [127.0.0.1])
	by byzantine.jameshoward.us (8.14.3/8.14.3) with ESMTP id nB7MjZoc033649;
	Mon, 7 Dec 2009 22:45:35 GMT
	(envelope-from howardjp@byzantine.jameshoward.us)
Received: (from howardjp@localhost)
	by byzantine.jameshoward.us (8.14.3/8.14.3/Submit) id nB7MjZUt033648;
	Mon, 7 Dec 2009 17:45:35 -0500 (EST)
	(envelope-from howardjp)
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <20091206131217.GA12851@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134791>

This commit provides support for commit.status, --status, and
--no-status, which control whether or not the git status information
is included in the commit message template when using an editor to
prepare the commit message.  It does not affect the effects of a
user's commit.template settings.

Signed-off-by: James P. Howard, II <jh@jameshoward.us>
---
 Documentation/config.txt     |    5 +++++
 Documentation/git-commit.txt |   14 +++++++++++++-
 builtin-commit.c             |    9 +++++++--
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a1e36d7..5561560 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -705,6 +705,11 @@ color.ui::
 	terminal. When more specific variables of color.* are set, they always
 	take precedence over this setting. Defaults to false.
 
+commit.status
+	A boolean to enable/disable inclusion of status information in the
+	commit message template when using an editor to prepare the commit
+	message.  Defaults to true.
+
 commit.template::
 	Specify a file to use as the template for new commit messages.
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d227cec..0e53518 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
 	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
-	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
+	   [--cleanup=<mode>] [--status | --no-status] [--]
+	   [[-i | -o ]<file>...]
 
 DESCRIPTION
 -----------
@@ -207,6 +208,17 @@ specified.
 	to be committed, paths with local changes that will be left
 	uncommitted and paths that are untracked.
 
+--status::
+	Include the output of linkgit:git-status[1] in the commit
+	message template when using an editor to prepare the commit
+	message.  Defaults to on, but can be used to override
+	configuration variable commit.status.
+
+--no-status::
+	Do not include the output of linkgit:git-status[1] in the
+	commit message template when using an editor to prepare the
+	default commit message.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin-commit.c b/builtin-commit.c
index e93a647..095c186 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -67,7 +67,7 @@ static enum {
 } cleanup_mode;
 static char *cleanup_arg;
 
-static int use_editor = 1, initial_commit, in_merge;
+static int use_editor = 1, initial_commit, in_merge, include_status = 1;
 static const char *only_include_assumed;
 static struct strbuf message;
 
@@ -97,6 +97,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
+	OPT_BOOLEAN(0, "status", &include_status, "include status in commit message template"),
 
 	OPT_GROUP("Commit contents options"),
 	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
@@ -547,7 +548,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	/* This checks if committer ident is explicitly given */
 	git_committer_info(0);
-	if (use_editor) {
+	if (use_editor && include_status) {
 		char *author_ident;
 		const char *committer_ident;
 
@@ -1006,6 +1007,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 
 	if (!strcmp(k, "commit.template"))
 		return git_config_pathname(&template_file, k, v);
+	if (!strcmp(k, "commit.status")) {
+		include_status = git_config_bool(k, v);
+		return 0;
+	}
 
 	return git_status_config(k, v, s);
 }
-- 
1.6.5.3
