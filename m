From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] Add 'fill_directory()' helper function for directory
 traversal
Date: Thu, 14 May 2009 13:46:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:47:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4hpq-000730-1S
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 22:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbZENUrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 16:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbZENUrK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 16:47:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34281 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753006AbZENUrJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 16:47:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4EKkec4030966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 May 2009 13:46:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4EKkdOv030560;
	Thu, 14 May 2009 13:46:39 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.962 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119223>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 May 2009 13:22:36 -0700

Most of the users of "read_directory()" actually want a much simpler
interface than the whole complex (but rather powerful) one.

In fact 'git add' had already largely abstracted out the core interface
issues into a private "fill_directory()" function that was largely
applicable almost as-is to a number of callers.  Yes, 'git add' wants to
do some extra work of its own, specific to the add semantics, but we can
easily split that out, and use the core as a generic function.

This function does exactly that, and now that much simplified
'fill_directory()' function can be shared with a number of callers,
while also ensuring that the rather more complex calling conventions of
read_directory() are used by fewer call-sites.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

As you can see from the diffstat, this removes more lines than it adds, 
and generally simplifies some calling conventions.

The return value from "fill_directory()" makes little sense for any other 
user than the builtin-add.c case, and I'm not really proud of it, but it 
basically allows everybody to share the same general infrastructure.

Note: this depends on the previous one, in that we now use the empty 
string ("") as the "path" argument, and now almost all users of 
read_directory() will pass in the same thing as both "path" and "base". 

That will eventually change, though, if we want to have different 
encodings.

 builtin-add.c      |   45 ++++++++++++++-------------------------------
 builtin-clean.c    |   12 +-----------
 builtin-ls-files.c |    7 +------
 dir.c              |   21 +++++++++++++++++++++
 dir.h              |    1 +
 wt-status.c        |    2 +-
 6 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index cb67d2c..ba25893 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -95,35 +95,6 @@ static void treat_gitlinks(const char **pathspec)
 	}
 }
 
-static void fill_directory(struct dir_struct *dir, const char **pathspec,
-		int ignored_too)
-{
-	const char *path, *base;
-	int baselen;
-
-	/* Set up the default git porcelain excludes */
-	memset(dir, 0, sizeof(*dir));
-	if (!ignored_too) {
-		dir->flags |= DIR_COLLECT_IGNORED;
-		setup_standard_excludes(dir);
-	}
-
-	/*
-	 * Calculate common prefix for the pathspec, and
-	 * use that to optimize the directory walk
-	 */
-	baselen = common_prefix(pathspec);
-	path = ".";
-	base = "";
-	if (baselen)
-		path = base = xmemdupz(*pathspec, baselen);
-
-	/* Read the directory and prune it */
-	read_directory(dir, path, base, baselen, pathspec);
-	if (pathspec)
-		prune_directory(dir, pathspec, baselen);
-}
-
 static void refresh(int verbose, const char **pathspec)
 {
 	char *seen;
@@ -290,9 +261,21 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die("index file corrupt");
 	treat_gitlinks(pathspec);
 
-	if (add_new_files)
+	if (add_new_files) {
+		int baselen;
+
+		/* Set up the default git porcelain excludes */
+		memset(&dir, 0, sizeof(dir));
+		if (!ignored_too) {
+			dir.flags |= DIR_COLLECT_IGNORED;
+			setup_standard_excludes(&dir);
+		}
+
 		/* This picks up the paths that are not tracked */
-		fill_directory(&dir, pathspec, ignored_too);
+		baselen = fill_directory(&dir, pathspec);
+		if (pathspec)
+			prune_directory(&dir, pathspec, baselen);
+	}
 
 	if (refresh_only) {
 		refresh(verbose, pathspec);
diff --git a/builtin-clean.c b/builtin-clean.c
index c5ad33d..febd10f 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -33,7 +33,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	int ignored_only = 0, baselen = 0, config_set = 0, errors = 0;
 	struct strbuf directory = STRBUF_INIT;
 	struct dir_struct dir;
-	const char *path, *base;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
 	const char *qname;
@@ -77,16 +76,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	pathspec = get_pathspec(prefix, argv);
 	read_cache();
 
-	/*
-	 * Calculate common prefix for the pathspec, and
-	 * use that to optimize the directory walk
-	 */
-	baselen = common_prefix(pathspec);
-	path = ".";
-	base = "";
-	if (baselen)
-		path = base = xmemdupz(*pathspec, baselen);
-	read_directory(&dir, path, base, baselen, pathspec);
+	fill_directory(&dir, pathspec);
 
 	if (pathspec)
 		seen = xmalloc(argc > 0 ? argc : 1);
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index da2daf4..a011a42 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -161,12 +161,7 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
-		const char *path = ".", *base = "";
-		int baselen = prefix_len;
-
-		if (baselen)
-			path = base = prefix;
-		read_directory(dir, path, base, baselen, pathspec);
+		fill_directory(dir, pathspec);
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
diff --git a/dir.c b/dir.c
index 0e6b752..c667d38 100644
--- a/dir.c
+++ b/dir.c
@@ -9,6 +9,27 @@
 #include "dir.h"
 #include "refs.h"
 
+int fill_directory(struct dir_struct *dir, const char **pathspec)
+{
+	const char *path, *base;
+	int baselen;
+
+	/*
+	 * Calculate common prefix for the pathspec, and
+	 * use that to optimize the directory walk
+	 */
+	baselen = common_prefix(pathspec);
+	path = "";
+	base = "";
+
+	if (baselen)
+		path = base = xmemdupz(*pathspec, baselen);
+
+	/* Read the directory and prune it */
+	read_directory(dir, path, base, baselen, pathspec);
+	return baselen;
+}
+
 struct path_simplify {
 	int len;
 	const char *path;
diff --git a/dir.h b/dir.h
index 541286a..9f7c3ba 100644
--- a/dir.h
+++ b/dir.h
@@ -68,6 +68,7 @@ extern int common_prefix(const char **pathspec);
 #define MATCHED_EXACTLY 3
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 
+extern int fill_directory(struct dir_struct *dir, const char **pathspec);
 extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen, const char **pathspec);
 
 extern int excluded(struct dir_struct *, const char *, int *);
diff --git a/wt-status.c b/wt-status.c
index 1b6df45..24a6abf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -255,7 +255,7 @@ static void wt_status_print_untracked(struct wt_status *s)
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	setup_standard_excludes(&dir);
 
-	read_directory(&dir, ".", "", 0, NULL);
+	fill_directory(&dir, NULL);
 	for(i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (!cache_name_is_other(ent->name, ent->len))
-- 
1.6.3.1.11.g97114
