From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 3/3] builtin-add: simplify (and increase accuracy of) exclude handling
Date: Tue, 12 Jun 2007 23:42:14 +0200
Message-ID: <20070612214214.GA21858@diku.dk>
References: <20070611123045.GA28814@coredump.intra.peff.net> <20070611133956.GC7008@coredump.intra.peff.net> <20070611150122.GA11020@diku.dk> <20070611155425.GA9316@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 23:42:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyE84-0004tL-H6
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 23:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXFLVmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 17:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbXFLVmT
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 17:42:19 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:52458 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbXFLVmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 17:42:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 213F6F0173;
	Tue, 12 Jun 2007 23:42:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQidRtEp3nbx; Tue, 12 Jun 2007 23:42:14 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id AE286F0149;
	Tue, 12 Jun 2007 23:42:14 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1BDD26DF88D; Tue, 12 Jun 2007 23:39:53 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8DC6262A5D; Tue, 12 Jun 2007 23:42:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070611155425.GA9316@coredump.intra.peff.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50002>

From: Jeff King <peff@peff.net>

Previously, the code would always set up the excludes, and then manually
pick through the pathspec we were given, assuming that non-added but
existing paths were just ignored. This was mostly correct, but would
erroneously mark a totally empty directory as 'ignored'.

Instead, we now use the collect_ignored option of dir_struct, which
unambiguously tells us whether a path was ignored. This simplifies the
code, and means empty directories are now just not mentioned at all.

Furthermore, we now conditionally ask dir_struct to respect excludes,
depending on whether the '-f' flag has been set. This means we don't have
to pick through the result, checking for an 'ignored' flag; ignored entries
were either added or not in the first place.

We can safely get rid of the special 'ignored' flags to dir_entry, which
were not used anywhere else.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 builtin-add.c |   69 +++++++++++++++++---------------------------------------
 dir.c         |   16 +++++++++++-
 dir.h         |    4 +--
 3 files changed, 36 insertions(+), 53 deletions(-)

 Jeff King <peff@peff.net> wrote Mon, Jun 11, 2007:
 > On Mon, Jun 11, 2007 at 05:01:23PM +0200, Jonas Fonseca wrote:
 > > I think you could even get rid of has_ignored with something like this.
 > 
 > Nope, I had originally wanted to do that, but the dir_struct.ignored
 > list contains _all_ ignored items, not just those that were originally
 > in the pathspec. The prune_ignored call sets uninteresting ones to
 > NULL.  That function could compact the list and re-set ignored_nr, but
 > it doesn't currently do so.
 > 
 > An even more elegant solution would be for read_directory to mark
 > whether an ignored file comes from a pathspec, or was found through
 > recursion. That would be more efficient, and it would remove the
 > prune_ignored thing, which is IMHO a little hack-ish.

 OK, I tried to do this, however, I got a bit confused with the intended
 behavior. Anyway, it passes the test suite, is silent for empty
 directories and will only show exact matches of the pathspec (this was
 the confusing part) as ignored items.

diff --git a/builtin-add.c b/builtin-add.c
index 1591171..ad6aca8 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -40,42 +40,29 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 	dir->nr = dst - dir->entries;
 
 	for (i = 0; i < specs; i++) {
-		struct stat st;
-		const char *match;
-		if (seen[i])
-			continue;
-
-		match = pathspec[i];
-		if (!match[0])
-			continue;
-
-		/* Existing file? We must have ignored it */
-		if (!lstat(match, &st)) {
-			struct dir_entry *ent;
-
-			ent = dir_add_name(dir, match, strlen(match));
-			ent->ignored = 1;
-			if (S_ISDIR(st.st_mode))
-				ent->ignored_dir = 1;
-			continue;
-		}
-		die("pathspec '%s' did not match any files", match);
+		if(!seen[i] && !file_exists(pathspec[i]))
+			die("pathspec '%s' did not match any files",
+					pathspec[i]);
 	}
 }
 
-static void fill_directory(struct dir_struct *dir, const char **pathspec)
+static void fill_directory(struct dir_struct *dir, const char **pathspec,
+		int ignored_too)
 {
 	const char *path, *base;
 	int baselen;
 
 	/* Set up the default git porcelain excludes */
 	memset(dir, 0, sizeof(*dir));
-	dir->exclude_per_dir = ".gitignore";
-	path = git_path("info/exclude");
-	if (!access(path, R_OK))
-		add_excludes_from_file(dir, path);
-	if (!access(excludes_file, R_OK))
-		add_excludes_from_file(dir, excludes_file);
+	if (!ignored_too) {
+		dir->collect_ignored = 1;
+		dir->exclude_per_dir = ".gitignore";
+		path = git_path("info/exclude");
+		if (!access(path, R_OK))
+			add_excludes_from_file(dir, path);
+		if (!access(excludes_file, R_OK))
+			add_excludes_from_file(dir, excludes_file);
+	}
 
 	/*
 	 * Calculate common prefix for the pathspec, and
@@ -219,13 +206,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 	pathspec = get_pathspec(prefix, argv + i);
 
-	fill_directory(&dir, pathspec);
+	fill_directory(&dir, pathspec, ignored_too);
 
 	if (show_only) {
 		const char *sep = "", *eof = "";
 		for (i = 0; i < dir.nr; i++) {
-			if (!ignored_too && dir.entries[i]->ignored)
-				continue;
 			printf("%s%s", sep, dir.entries[i]->name);
 			sep = " ";
 			eof = "\n";
@@ -237,25 +222,13 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	if (!ignored_too) {
-		int has_ignored = 0;
-		for (i = 0; i < dir.nr; i++)
-			if (dir.entries[i]->ignored)
-				has_ignored = 1;
-		if (has_ignored) {
-			fprintf(stderr, ignore_warning);
-			for (i = 0; i < dir.nr; i++) {
-				if (!dir.entries[i]->ignored)
-					continue;
-				fprintf(stderr, "%s", dir.entries[i]->name);
-				if (dir.entries[i]->ignored_dir)
-					fprintf(stderr, " (directory)");
-				fputc('\n', stderr);
-			}
-			fprintf(stderr,
-				"Use -f if you really want to add them.\n");
-			exit(1);
+	if (dir.ignored_nr) {
+		fprintf(stderr, ignore_warning);
+		for (i = 0; i < dir.ignored_nr; i++) {
+			fprintf(stderr, "%s\n", dir.ignored[i]->name);
 		}
+		fprintf(stderr, "Use -f if you really want to add them.\n");
+		exit(1);
 	}
 
 	for (i = 0; i < dir.nr; i++)
diff --git a/dir.c b/dir.c
index 1ffc1e5..f3a6757 100644
--- a/dir.c
+++ b/dir.c
@@ -275,7 +275,6 @@ static
 struct dir_entry *dir_entry_new(const char *pathname, int len) {
 	struct dir_entry *ent;
 	ent = xmalloc(sizeof(*ent) + len + 1);
-	ent->ignored = ent->ignored_dir = 0;
 	ent->len = len;
 	memcpy(ent->name, pathname, len);
 	ent->name[len] = 0;
@@ -432,6 +431,18 @@ static int simplify_away(const char *path, int pathlen, const struct path_simpli
 	return 0;
 }
 
+static int in_pathspec(const char *path, int len, const struct path_simplify *simplify)
+{
+	if (simplify) {
+		for (; simplify->path; simplify++) {
+			if (len == simplify->len
+			    && !memcmp(path, simplify->path, len))
+				return 1;
+		}
+	}
+	return 0;
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -472,7 +483,8 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				continue;
 
 			exclude = excluded(dir, fullname);
-			if (exclude && dir->collect_ignored)
+			if (exclude && dir->collect_ignored
+			    && in_pathspec(fullname, baselen + len, simplify))
 				dir_add_ignored(dir, fullname, baselen + len);
 			if (exclude != dir->show_ignored) {
 				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
diff --git a/dir.h b/dir.h
index c94f3cb..ec0e8ab 100644
--- a/dir.h
+++ b/dir.h
@@ -13,9 +13,7 @@
 
 
 struct dir_entry {
-	unsigned int ignored : 1;
-	unsigned int ignored_dir : 1;
-	unsigned int len : 30;
+	unsigned int len;
 	char name[FLEX_ARRAY]; /* more */
 };
 
-- 
1.5.2.1.958.g264c-dirty

-- 
Jonas Fonseca
