From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-clean won't read global ignore
Date: Wed, 14 Nov 2007 00:05:00 -0800
Message-ID: <7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
	<20071113225057.GB22836@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: shunichi fuji <palglowr@gmail.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 09:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsDFe-0003dl-2K
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 09:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbXKNIFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 03:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbXKNIFJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 03:05:09 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39177 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbXKNIFH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 03:05:07 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3618A2F0;
	Wed, 14 Nov 2007 03:05:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FAF9938FA;
	Wed, 14 Nov 2007 03:05:23 -0500 (EST)
In-Reply-To: <20071113225057.GB22836@artemis.corp> (Pierre Habouzit's message
	of "Tue, 13 Nov 2007 23:50:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64958>

I think the problem is core.excludesfile is too new to be
noticed by anything other than git-add and git-status.

 * git-add and git-status know about it because they call
   add_excludes_from_file() directly with their own notion of
   which standard set of ignore files to use.  This is just a
   stupid duplication of code that need to be updated every time
   the definition of the standard set of ignore files is
   changed.

 * git-ls-files does not notice any of the "ignore" files by
   default, as it predates the standardized set of ignore
   files.  The calling scripts established the convention to use
   .git/info/exclude, .gitignore in each file, and later
   core.excludesfile.

 * git-read-tree takes --exclude-per-directory=<gitignore>,
   not because the flexibility was needed.  Again, this was
   because the option predates the standardization of the ignore
   files.

 * git-merge-recursive uses hardcoded per-directory .gitignore
   and nothing else.  git-clean (scripted version) does not
   honor core.* because its call to underlying ls-files does not
   know about it.  git-clean in C (parked in 'pu') doesn't either.

We probably could change git-ls-files to use the standard set
when no excludes are specified from the command line, or
something like that, but this will be a change in semantics that
would affect the scripts in a subtle way.  I am somewhat
reluctant to make such a change.

On the other hand, I think it makes perfect sense to fix
git-read-tree, git-merge-recursive and git-clean to follow the
same rule as other commands.  I do not think of a valid use case
to give an exclude-per-directory that is nonstandard to
read-tree command, outside a "negative" test in the t1004 test
script.

To untangle this mess, I think the first step would be something
like this (this is against 'maint', as I was in the middle of
something else that is based on 'maint' when I started reading
this thread).

The next step would be to teach read-tree, merge-recursive and
clean (in C) to use setup_standard_excludes().

---

 builtin-add.c |   22 ++--------------------
 cache.h       |    1 +
 config.c      |    7 +++++++
 dir.c         |   12 ++++++++++++
 dir.h         |    1 +
 environment.c |    1 +
 wt-status.c   |   15 +--------------
 7 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 373f87f..850e1c2 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -17,7 +17,6 @@ static const char builtin_add_usage[] =
 "git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh] [--] <filepattern>...";
 
 static int take_worktree_changes;
-static const char *excludes_file;
 
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
@@ -57,12 +56,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 	memset(dir, 0, sizeof(*dir));
 	if (!ignored_too) {
 		dir->collect_ignored = 1;
-		dir->exclude_per_dir = ".gitignore";
-		path = git_path("info/exclude");
-		if (!access(path, R_OK))
-			add_excludes_from_file(dir, path);
-		if (excludes_file != NULL && !access(excludes_file, R_OK))
-			add_excludes_from_file(dir, excludes_file);
+		setup_standard_excludes(dir);
 	}
 
 	/*
@@ -144,18 +138,6 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-static int git_add_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "core.excludesfile")) {
-		if (!value)
-			die("core.excludesfile without value");
-		excludes_file = xstrdup(value);
-		return 0;
-	}
-
-	return git_default_config(var, value);
-}
-
 static struct lock_file lock_file;
 
 static const char ignore_error[] =
@@ -183,7 +165,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
-	git_config(git_add_config);
+	git_config(git_default_config);
 
 	newfd = hold_locked_index(&lock_file, 1);
 
diff --git a/cache.h b/cache.h
index fc195bc..ecd809d 100644
--- a/cache.h
+++ b/cache.h
@@ -571,6 +571,7 @@ extern int pager_in_use;
 extern int pager_use_color;
 
 extern char *editor_program;
+extern char *excludes_file;
 
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
diff --git a/config.c b/config.c
index dc3148d..56e99fc 100644
--- a/config.c
+++ b/config.c
@@ -431,6 +431,13 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.excludesfile")) {
+		if (!value)
+			die("core.excludesfile without value");
+		excludes_file = xstrdup(value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/dir.c b/dir.c
index f843c4d..73a39ed 100644
--- a/dir.c
+++ b/dir.c
@@ -709,3 +709,15 @@ int is_inside_dir(const char *dir)
 	char buffer[PATH_MAX];
 	return get_relative_cwd(buffer, sizeof(buffer), dir) != NULL;
 }
+
+void setup_standard_excludes(struct dir_struct *dir)
+{
+	const char *path;
+
+	dir->exclude_per_dir = ".gitignore";
+	path = git_path("info/exclude");
+	if (!access(path, R_OK))
+		add_excludes_from_file(dir, path);
+	if (excludes_file && !access(excludes_file, R_OK))
+		add_excludes_from_file(dir, excludes_file);
+}
diff --git a/dir.h b/dir.h
index f55a87b..a5f4237 100644
--- a/dir.h
+++ b/dir.h
@@ -63,5 +63,6 @@ extern struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathna
 
 extern char *get_relative_cwd(char *buffer, int size, const char *dir);
 extern int is_inside_dir(const char *dir);
+extern void setup_standard_excludes(struct dir_struct *dir);
 
 #endif
diff --git a/environment.c b/environment.c
index b5a6c69..1dab72e 100644
--- a/environment.c
+++ b/environment.c
@@ -34,6 +34,7 @@ char *pager_program;
 int pager_in_use;
 int pager_use_color = 1;
 char *editor_program;
+char *excludes_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
diff --git a/wt-status.c b/wt-status.c
index 10ce6ee..58dd716 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -22,7 +22,6 @@ static const char use_add_rm_msg[] =
 "use \"git add/rm <file>...\" to update what will be committed";
 static const char use_add_to_include_msg[] =
 "use \"git add <file>...\" to include in what will be committed";
-static const char *excludes_file;
 
 static int parse_status_slot(const char *var, int offset)
 {
@@ -247,22 +246,16 @@ static void wt_status_print_changed(struct wt_status *s)
 static void wt_status_print_untracked(struct wt_status *s)
 {
 	struct dir_struct dir;
-	const char *x;
 	int i;
 	int shown_header = 0;
 
 	memset(&dir, 0, sizeof(dir));
 
-	dir.exclude_per_dir = ".gitignore";
 	if (!s->untracked) {
 		dir.show_other_directories = 1;
 		dir.hide_empty_directories = 1;
 	}
-	x = git_path("info/exclude");
-	if (file_exists(x))
-		add_excludes_from_file(&dir, x);
-	if (excludes_file && file_exists(excludes_file))
-		add_excludes_from_file(&dir, excludes_file);
+	setup_standard_excludes(&dir);
 
 	read_directory(&dir, ".", "", 0, NULL);
 	for(i = 0; i < dir.nr; i++) {
@@ -360,11 +353,5 @@ int git_status_config(const char *k, const char *v)
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
 	}
-	if (!strcmp(k, "core.excludesfile")) {
-		if (!v)
-			die("core.excludesfile without value");
-		excludes_file = xstrdup(v);
-		return 0;
-	}
 	return git_default_config(k, v);
 }
