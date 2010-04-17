From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [BUG] Git add <device file> silently fails
Date: Sat, 17 Apr 2010 19:57:00 +0200
Organization: SUSE Labs
Message-ID: <201004171957.00944.agruen@suse.de>
References: <201004171624.17797.agruen@suse.de> <u2s81b0412b1004170744u4cc3c0e1z6d7019fe405a67ec@mail.gmail.com> <7v4oja3uh7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 19:57:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3CGW-0001lX-DB
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 19:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab0DQR5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 13:57:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:52860 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809Ab0DQR5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 13:57:04 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 617D587567;
	Sat, 17 Apr 2010 19:57:02 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7v4oja3uh7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145165>

On Saturday 17 April 2010 18:38:12 Junio C Hamano wrote:
> The early skippage done in dir.c (read-directory-recursive) should treat
> these as ignored just like paths that are ignored with .gitignore
> mechanism, and if we do so, we shouldn't need this patch to add another
> codepath to give notification to the user (we would however still need
> to reword "'add -f' if you really want to add it", though).

I see, but dumbing down the error message until it fits both cases doesn'
seem all that useful, either.  Here is a shot, maybe it's acceptable in
your eyes.

Andreas


Subject: [PATCH] Complain when trying to "git add" decive special files

This is done by adding a list of files to struct dir_struct which were
ignored because of their file type.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin/add.c |   26 +++++++++++++++++---------
 dir.c         |   19 +++++++++++++------
 dir.h         |   14 ++++++++++++--
 3 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 87d2980..a3d7839 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -304,9 +304,6 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 
 static struct lock_file lock_file;
 
-static const char ignore_error[] =
-"The following paths are ignored by one of your .gitignore files:\n";
-
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
 static int ignore_add_errors, addremove, intent_to_add;
 
@@ -339,14 +336,25 @@ static int add_files(struct dir_struct *dir, int flags)
 {
 	int i, exit_status = 0;
 
-	if (dir->ignored_nr) {
-		fprintf(stderr, ignore_error);
-		for (i = 0; i < dir->ignored_nr; i++)
-			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		fprintf(stderr, "Use -f if you really want to add them.\n");
-		die("no files added");
+	if (dir->ignored[DIR_IGNORED_FILETYPE].nr) {
+		fprintf(stderr, "The following paths are ignored "
+				"because their file types are not supported:\n");
+		for (i = 0; i < dir->ignored[DIR_IGNORED_FILETYPE].nr; i++)
+			fprintf(stderr, "%s\n",
+				dir->ignored[DIR_IGNORED_FILETYPE].entries[i]->name);
 	}
 
+	if (dir->ignored[DIR_IGNORED_EXCLUDED].nr) {
+		fprintf(stderr, "The following paths are ignored "
+				"by one of your .gitignore files; "
+				"use -f if you really want to add them:\n");
+		for (i = 0; i < dir->ignored[DIR_IGNORED_EXCLUDED].nr; i++)
+			fprintf(stderr, "%s\n",
+				dir->ignored[DIR_IGNORED_EXCLUDED].entries[i]->name);
+	}
+	if (dir->ignored[DIR_IGNORED_FILETYPE].nr || dir->ignored[DIR_IGNORED_EXCLUDED].nr)
+		die("no files added");
+
 	for (i = 0; i < dir->nr; i++)
 		if (add_file_to_cache(dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
diff --git a/dir.c b/dir.c
index cb83332..87e7fca 100644
--- a/dir.c
+++ b/dir.c
@@ -453,13 +453,16 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir, const char 
*pathna
 	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
 }
 
-static struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
+static struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len,
+					 enum ignore_reason reason)
 {
+	struct dir_vector *vector = &dir->ignored[reason];
+
 	if (!cache_name_is_other(pathname, len))
 		return NULL;
 
-	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
-	return dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
+	ALLOC_GROW(vector->entries, vector->nr+1, vector->alloc);
+	return vector->entries[vector->nr++] = dir_entry_new(pathname, len);
 }
 
 enum exist_status {
@@ -695,7 +698,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	int exclude = excluded(dir, path, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path, *len, simplify))
-		dir_add_ignored(dir, path, *len);
+		dir_add_ignored(dir, path, *len, DIR_IGNORED_EXCLUDED);
 
 	/*
 	 * Excluded? If we don't explicitly want to show
@@ -720,7 +723,8 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 
 	switch (dtype) {
 	default:
-		return path_ignored;
+		dir_add_ignored(dir, path, *len, DIR_IGNORED_FILETYPE);
+		break;
 	case DT_DIR:
 		memcpy(path + *len, "/", 2);
 		(*len)++;
@@ -907,6 +911,7 @@ static int treat_leading_path(struct dir_struct *dir,
 int read_directory(struct dir_struct *dir, const char *path, int len, const char **pathspec)
 {
 	struct path_simplify *simplify;
+	enum ignore_reason reason;
 
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
@@ -916,7 +921,9 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const 
char
 		read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
-	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
+	for (reason = 0; reason < ARRAY_SIZE(dir->ignored); reason++)
+		qsort(dir->ignored[reason].entries, dir->ignored[reason].nr,
+		      sizeof(struct dir_entry *), cmp_name);
 	return dir->nr;
 }
 
diff --git a/dir.h b/dir.h
index 3bead5f..b7d1a21 100644
--- a/dir.h
+++ b/dir.h
@@ -31,9 +31,18 @@ struct exclude_stack {
 	int exclude_ix;
 };
 
+enum ignore_reason {
+	DIR_IGNORED_EXCLUDED,
+	DIR_IGNORED_FILETYPE,
+};
+
+struct dir_vector {
+	int nr, alloc;
+	struct dir_entry **entries;
+};
+
 struct dir_struct {
 	int nr, alloc;
-	int ignored_nr, ignored_alloc;
 	enum {
 		DIR_SHOW_IGNORED = 1<<0,
 		DIR_SHOW_OTHER_DIRECTORIES = 1<<1,
@@ -42,7 +51,8 @@ struct dir_struct {
 		DIR_COLLECT_IGNORED = 1<<4
 	} flags;
 	struct dir_entry **entries;
-	struct dir_entry **ignored;
+	struct dir_vector ignored[2];
+
 
 	/* Exclude info */
 	const char *exclude_per_dir;
-- 
1.7.1.rc1.12.ga601
