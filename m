From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] builtin-add: simplify (and increase accuracy of) exclude handling
Date: Mon, 11 Jun 2007 09:39:56 -0400
Message-ID: <20070611133956.GC7008@coredump.intra.peff.net>
References: <20070611123045.GA28814@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 15:40:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxk7l-0006x6-RL
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 15:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbXFKNj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 09:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbXFKNj7
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 09:39:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2596 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715AbXFKNj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 09:39:58 -0400
Received: (qmail 2554 invoked from network); 11 Jun 2007 13:40:10 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Jun 2007 13:40:10 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2007 09:39:56 -0400
Content-Disposition: inline
In-Reply-To: <20070611123045.GA28814@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49851>

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
---
 builtin-add.c |   89 ++++++++++++++++++++++++++++++--------------------------
 dir.c         |    1 -
 dir.h         |    4 +--
 3 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 1591171..8988930 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -19,6 +19,23 @@ static const char builtin_add_usage[] =
 static int take_worktree_changes;
 static const char *excludes_file;
 
+static int in_pathspec(const char *k, const char **pathspec) {
+	while(*pathspec) {
+		if (!strcmp(k, *pathspec))
+			return 1;
+		pathspec++;
+	}
+	return 0;
+}
+
+static void prune_ignored(struct dir_struct *dir, const char **pathspec) {
+	int i;
+	for (i = 0; i < dir->ignored_nr; i++) {
+		if (!in_pathspec(dir->ignored[i]->name, pathspec))
+			dir->ignored[i] = NULL;
+	}
+}
+
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
 	char *seen;
@@ -40,42 +57,29 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
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
@@ -93,8 +97,10 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec)
 
 	/* Read the directory and prune it */
 	read_directory(dir, path, base, baselen, pathspec);
-	if (pathspec)
+	if (pathspec) {
+		prune_ignored(dir, pathspec);
 		prune_directory(dir, pathspec, baselen);
+	}
 }
 
 static void update_callback(struct diff_queue_struct *q,
@@ -160,6 +166,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	const char **pathspec;
 	struct dir_struct dir;
 	int add_interactive = 0;
+	int has_ignored;
 
 	for (i = 1; i < argc; i++) {
 		if (!strcmp("--interactive", argv[i]) ||
@@ -219,13 +226,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
@@ -237,25 +242,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
+	has_ignored = 0;
+	for (i = 0; i < dir.ignored_nr; i++) {
+		if (dir.ignored[i])
+			has_ignored = 1;
+	}
+	if (has_ignored) {
+		fprintf(stderr, ignore_warning);
+		for (i = 0; i < dir.ignored_nr; i++) {
+			if (dir.ignored[i])
+				fprintf(stderr, "%s\n", dir.ignored[i]->name);
 		}
+		fprintf(stderr, "Use -f if you really want to add them.\n");
+		exit(1);
 	}
 
 	for (i = 0; i < dir.nr; i++)
diff --git a/dir.c b/dir.c
index 1ffc1e5..d903a49 100644
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
 
