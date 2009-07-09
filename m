From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] Add 'fill_directory()' helper function for directory
 traversal
Date: Wed, 8 Jul 2009 19:40:15 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 04:40:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOjZC-0004uq-De
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 04:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149AbZGICkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 22:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756963AbZGICkv
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 22:40:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36513 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756233AbZGICkv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 22:40:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n692eGpJ024292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Jul 2009 19:40:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n692eFTE005371;
	Wed, 8 Jul 2009 19:40:15 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122931>



From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 May 2009 13:22:36 -0700
Subject: [PATCH 1/3] Add 'fill_directory()' helper function for directory traversal

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

This also makes the 'common_prefix()' helper function private to dir.c,
since all callers are now in that file.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is a cleaned-up version of a patch that I had done earlier for the 
pathname character set conversion series. It's basically a cleanup of 
b99acc690de27aaf437676c9e3077493a885b642 in 'pu'.

 builtin-add.c      |   45 ++++++++++++++-------------------------------
 builtin-clean.c    |   12 +-----------
 builtin-ls-files.c |    7 +------
 dir.c              |   23 ++++++++++++++++++++++-
 dir.h              |    3 +--
 wt-status.c        |    2 +-
 6 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 78989da..581a2a1 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -97,35 +97,6 @@ static void treat_gitlinks(const char **pathspec)
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
@@ -343,9 +314,21 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
index 1c1b6d2..2d8c735 100644
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
@@ -78,16 +77,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
index 2312866..f473220 100644
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
index 74b3bbf..0c8553b 100644
--- a/dir.c
+++ b/dir.c
@@ -19,7 +19,7 @@ static int read_directory_recursive(struct dir_struct *dir,
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path);
 
-int common_prefix(const char **pathspec)
+static int common_prefix(const char **pathspec)
 {
 	const char *path, *slash, *next;
 	int prefix;
@@ -52,6 +52,27 @@ int common_prefix(const char **pathspec)
 	return prefix;
 }
 
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
 /*
  * Does 'match' match the given name?
  * A match is found if
diff --git a/dir.h b/dir.h
index 541286a..f9d69dd 100644
--- a/dir.h
+++ b/dir.h
@@ -61,13 +61,12 @@ struct dir_struct {
 	char basebuf[PATH_MAX];
 };
 
-extern int common_prefix(const char **pathspec);
-
 #define MATCHED_RECURSIVELY 1
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 
+extern int fill_directory(struct dir_struct *dir, const char **pathspec);
 extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen, const char **pathspec);
 
 extern int excluded(struct dir_struct *, const char *, int *);
diff --git a/wt-status.c b/wt-status.c
index 0ca4b13..47735d8 100644
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
1.6.3.3.412.gf581d
