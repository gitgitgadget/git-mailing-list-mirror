From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 13:16:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191310430.14781@racer.site>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
 <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
 <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
 <20070719105105.GA4929@moonlight.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Tomash Brechko <tomash.brechko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 14:16:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBUw8-0006lO-R1
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759620AbXGSMQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 08:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755911AbXGSMQc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:16:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:37097 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758840AbXGSMQb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:16:31 -0400
Received: (qmail invoked by alias); 19 Jul 2007 12:16:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 19 Jul 2007 14:16:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SdSVYYFYSJUOapHuA9k3wV9BB9CIFgVloeW35ih
	9Z24UF3QZo76GV
X-X-Sender: gene099@racer.site
In-Reply-To: <20070719105105.GA4929@moonlight.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52978>

Hi,

On Thu, 19 Jul 2007, Tomash Brechko wrote:

> A year or so ago I too would strongly advocate the need of tracking 
> empty directories, permissions et al., it seemed so "natural" and "plain 
> obvious" to me back then.  But since that time I learned to appreciate 
> the "contents tracking" approach, and now view directories (paths in 
> general) only as the means for Git to know where to put the contents on 
> checkout.  This, BTW, is consistent with how Git figures container 
> copies/renames.

Thank you.  It is my impression, too, that after a while it becomes 
obvious what is good and what is not.

FWIW I just whipped up a proof-of-concept patch (so at least _I_ cannot be 
accused of chickening out of writing code):

This adds the command line option "--add-empty-dirs" to "git add", which 
does the only sane thing: putting a placeholder into that directory, and 
adding that.  Since ".gitignore" is already a reserved file name in git, 
it is used as the name of this place holder.

---

	It is probably not fool-proof yet, needs documentation and a test 
	case.  But I am really sick and tired of this discussion.

 builtin-add.c |   25 +++++++++++++++++++++----
 dir.c         |   16 +++++++++++++++-
 dir.h         |    3 ++-
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 7345479..1294840 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -47,7 +47,7 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 }
 
 static void fill_directory(struct dir_struct *dir, const char **pathspec,
-		int ignored_too)
+		int ignored_too, int substitute_empty_dirs)
 {
 	const char *path, *base;
 	int baselen;
@@ -63,6 +63,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 		if (!access(excludes_file, R_OK))
 			add_excludes_from_file(dir, excludes_file);
 	}
+	dir->substitute_empty_directories = substitute_empty_dirs;
 
 	/*
 	 * Calculate common prefix for the pathspec, and
@@ -143,7 +144,8 @@ static const char ignore_warning[] =
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	int verbose = 0, show_only = 0, ignored_too = 0;
+	int verbose = 0, show_only = 0, ignored_too = 0,
+		substitute_empty_dirs = 0;
 	const char **pathspec;
 	struct dir_struct dir;
 	int add_interactive = 0;
@@ -191,6 +193,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			take_worktree_changes = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--add-empty-dirs")) {
+			substitute_empty_dirs = 1;
+			continue;
+		}
 		usage(builtin_add_usage);
 	}
 
@@ -206,7 +212,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 	pathspec = get_pathspec(prefix, argv + i);
 
-	fill_directory(&dir, pathspec, ignored_too);
+	fill_directory(&dir, pathspec, ignored_too, substitute_empty_dirs);
 
 	if (show_only) {
 		const char *sep = "", *eof = "";
@@ -231,8 +237,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
-	for (i = 0; i < dir.nr; i++)
+	for (i = 0; i < dir.nr; i++) {
+		const char *name = dir.entries[i]->name;
+		const char *slash;
+		if (substitute_empty_dirs && (slash = strrchr(name, '/')) &&
+				!strcmp(slash, "/.gitignore") &&
+				access(name, R_OK)) {
+			int fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
+			if (fd < 0)
+				return error("Could not create %s", name);
+			close(fd);
+		}
 		add_file_to_cache(dir.entries[i]->name, verbose);
+	}
 
  finish:
 	if (active_cache_changed) {
diff --git a/dir.c b/dir.c
index 8d8faf5..b0b4628 100644
--- a/dir.c
+++ b/dir.c
@@ -456,11 +456,11 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 {
 	DIR *fdir = opendir(path);
 	int contents = 0;
+	char fullname[PATH_MAX + 1];
 
 	if (fdir) {
 		int exclude_stk;
 		struct dirent *de;
-		char fullname[PATH_MAX + 1];
 		memcpy(fullname, base, baselen);
 
 		exclude_stk = push_exclude_per_directory(dir, base, baselen);
@@ -536,6 +536,20 @@ exit_early:
 		pop_exclude_per_directory(dir, exclude_stk);
 	}
 
+	if (!contents && dir->substitute_empty_directories) {
+		const char *name = ".gitignore";
+		int len = strlen(name);
+		/* Ignore overly long pathnames! */
+		if (len + baselen + 8 > sizeof(fullname))
+			return 0;
+		memcpy(fullname + baselen, name, len+1);
+		if (simplify_away(fullname, baselen + len, simplify)
+				|| excluded(dir, fullname))
+			return 0;
+		dir_add_name(dir, fullname, baselen + len);
+		return 1;
+	}
+
 	return contents;
 }
 
diff --git a/dir.h b/dir.h
index ec0e8ab..0099718 100644
--- a/dir.h
+++ b/dir.h
@@ -34,7 +34,8 @@ struct dir_struct {
 		     show_other_directories:1,
 		     hide_empty_directories:1,
 		     no_gitlinks:1,
-		     collect_ignored:1;
+		     collect_ignored:1,
+		     substitute_empty_directories:1;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
 
