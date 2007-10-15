From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] Let users override name of per-directory ignore file
Date: Mon, 15 Oct 2007 14:30:35 +0200
Message-ID: <47135D6B.5070308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 14:31:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhP60-0006LI-2n
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 14:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758651AbXJOMal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 08:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758913AbXJOMak
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 08:30:40 -0400
Received: from mail.op5.se ([193.201.96.20]:57923 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758391AbXJOMaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 08:30:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 420A1173070B
	for <git@vger.kernel.org>; Mon, 15 Oct 2007 14:30:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.442
X-Spam-Level: 
X-Spam-Status: No, score=-2.442 tagged_above=-10 required=6.6
	tests=[AWL=0.057, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LqPqFhTe4bDl for <git@vger.kernel.org>;
	Mon, 15 Oct 2007 14:30:37 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 5A26017305A5
	for <git@vger.kernel.org>; Mon, 15 Oct 2007 14:30:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60987>

When collaborating with projects managed by some other
scm, it often makes sense to have git read that other
scm's ignore-files. This patch lets git do just that, if
the user only tells it the name of the per-directory
ignore file by specifying the newly introduced git config
option 'core.ignorefile'.

Theoretically, this could cause problems when projects get
ported from some other scm to git, but in practice that
is a moot point, as such changes are always followed by a
flagday anyway.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---

I'm in the unfortunate position of being forced to work on a large
amount of projects where the upstream repo is in either CVS or SVN,
and fiddling with exclude-files gets more than just a little tedious.
I've tested this patch lightly. git-status and git-add pick up the
option. "make test" passes as well, and the patch is small enough to
seem obviously correct, so I left it at that.

git-svn should probably set this option by default after a successful
clone, and it has the smell of fruit so low-hanging it's practically
already dropped from the tree, but unfortunately my perl-fu is so weak
I can't even find where to add it. Volunteers?


 Documentation/config.txt    |   10 ++++++++++
 Documentation/gitignore.txt |    5 +++++
 builtin-add.c               |   11 +++++++++--
 wt-status.c                 |    9 ++++++++-
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b2fc82..267f93c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -275,6 +275,16 @@ You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.ignorefile::
+	Tells git to use a different file for per-directory ignores.
+	This is useful when one wishes to use git for a project
+	when the upstream repository is managed by some other SCM
+	whose ignore-file formats are the same as that of git.
+	For example, setting core.ignorefile to .svnignore in
+	repos where one interacts with the upstream project repo
+	using gitlink:git-svn[1] will make a both SVN users and
+	your own repo ignore the same files.
+
 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index e8b8581..f82eac6 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -32,6 +32,11 @@ precedence, the last matching pattern decides the outcome):
    `.gitignore` file.  A project normally includes such
    `.gitignore` files in its repository, containing patterns for
    files generated as part of the project build.
+   The name of the `.gitignore` file can be changed by setting
+   the configuration variable 'core.ignorefile'. This is useful
+   when using git for projects where upstream is using some other
+   SCM. For example, setting 'core.ignorefile' to `.cvsignore`
+   will make git ignore the same files CVS would.
 
  * Patterns read from `$GIT_DIR/info/exclude`.
 
diff --git a/builtin-add.c b/builtin-add.c
index 966e145..c785d99 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -19,6 +19,7 @@ static const char builtin_add_usage[] =
 
 static int take_worktree_changes;
 static const char *excludes_file;
+static const char *ignore_file = ".gitignore";
 
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
@@ -57,7 +58,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 	memset(dir, 0, sizeof(*dir));
 	if (!ignored_too) {
 		dir->collect_ignored = 1;
-		dir->exclude_per_dir = ".gitignore";
+		dir->exclude_per_dir = ignore_file;
 		path = git_path("info/exclude");
 		if (!access(path, R_OK))
 			add_excludes_from_file(dir, path);
@@ -144,6 +145,12 @@ static int git_add_config(const char *var, const char *value)
 		excludes_file = xstrdup(value);
 		return 0;
 	}
+	if (!strcmp(var, "core.ignorefile")) {
+		if (!value)
+			die("core.ignorefile without value");
+		ignore_file = xstrdup(value);
+		return 0;
+	}
 
 	return git_default_config(var, value);
 }
@@ -158,7 +165,7 @@ int interactive_add(void)
 static struct lock_file lock_file;
 
 static const char ignore_error[] =
-"The following paths are ignored by one of your .gitignore files:\n";
+"The following paths are ignored:\n";
 
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
diff --git a/wt-status.c b/wt-status.c
index 03b5ec4..103aefe 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -23,6 +23,7 @@ static const char use_add_rm_msg[] =
 static const char use_add_to_include_msg[] =
 "use \"git add <file>...\" to include in what will be committed";
 static const char *excludes_file;
+static const char *ignore_file = ".gitignore";
 
 static int parse_status_slot(const char *var, int offset)
 {
@@ -257,7 +258,7 @@ static void wt_status_print_untracked(struct wt_status *s)
 
 	memset(&dir, 0, sizeof(dir));
 
-	dir.exclude_per_dir = ".gitignore";
+	dir.exclude_per_dir = ignore_file;
 	if (!s->untracked) {
 		dir.show_other_directories = 1;
 		dir.hide_empty_directories = 1;
@@ -370,5 +371,11 @@ int git_status_config(const char *k, const char *v)
 		excludes_file = xstrdup(v);
 		return 0;
 	}
+	if (!strcmp(k, "core.ignorefile")) {
+		if (!v)
+			die("core.ignorefile without value");
+		ignore_file = xstrdup(v);
+		return 0;
+	}
 	return git_default_config(k, v);
 }
-- 
1.5.3.4.1155.gfe96ee-dirty
