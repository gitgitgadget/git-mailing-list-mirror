From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix 'git add' with .gitignore (Re: git-add ignores .gitignore)
Date: Fri, 29 Dec 2006 10:57:29 -0800
Message-ID: <7vpsa2msx2.fsf@assigned-by-dhcp.cox.net>
References: <033682AF-B324-4049-B331-8A8AF2335E4D@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 19:57:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0Mv9-0003ht-3A
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 19:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWL2S5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 13:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWL2S5b
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 13:57:31 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:60125 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965093AbWL2S5a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 13:57:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229185730.OWMY97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Dec 2006 13:57:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4iwk1W00T1kojtg0000000; Fri, 29 Dec 2006 13:56:45 -0500
To: Brian Gernhardt <benji@silverinsanity.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35601>

Thanks for noticing.

The commit 4888c534 tried to mark the path it returns so that
the caller can tell if it is ignored or not, but botched the
case where a directory is ignored.  It should have marked the
contents as ignored if higher level directory was.

But I think the approach that change makes is more expensive
than the original code and is not necessary.  How about this
patch, after you revert that commit?

-- >8 --
[PATCH] Fix 'git add' with .gitignore

When '*.ig' is ignored, and you have two files f.ig and d.ig/foo
in the working tree,

	$ git add .

correctly ignored f.ig but failed to ignore d.ig/foo.  This was
caused by a thinko in an earlier commit 4888c534, when we tried
to allow adding otherwise ignored files.

After reverting that commit, this takes a much simpler approach.
When we have an unmatched pathspec that talks about an existing
pathname, we know it is an ignored path the user tried to add,
so we include it in the set of paths directory walker returned.

This does not let you say "git add -f D" on an ignored directory
D and add everything under D.  People can submit a patch to
further allow it if they want to, but I think it is a saner
behaviour to require explicit paths to be spelled out in such a
case.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 builtin-add.c  |   52 +++++++++++++++++++++++++++-------------------------
 dir.c          |    8 +++++---
 dir.h          |    5 ++++-
 t/t3700-add.sh |   33 +++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 8ed4a6a..e7a1b4d 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -26,18 +26,9 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 	i = dir->nr;
 	while (--i >= 0) {
 		struct dir_entry *entry = *src++;
-		int how = match_pathspec(pathspec, entry->name, entry->len,
-					 prefix, seen);
-		/*
-		 * ignored entries can be added with exact match,
-		 * but not with glob nor recursive.
-		 */
-		if (!how ||
-		    (entry->ignored_entry && how != MATCHED_EXACTLY)) {
-			free(entry);
-			continue;
-		}
-		*dst++ = entry;
+		if (match_pathspec(pathspec, entry->name, entry->len,
+				   prefix, seen))
+			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
 
@@ -47,10 +38,20 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 		if (seen[i])
 			continue;
 
-		/* Existing file? We must have ignored it */
 		match = pathspec[i];
-		if (!match[0] || !lstat(match, &st))
+		if (!match[0])
 			continue;
+
+		/* Existing file? We must have ignored it */
+		if (!lstat(match, &st)) {
+			struct dir_entry *ent;
+
+			ent = dir_add_name(dir, match, strlen(match));
+			ent->ignored = 1;
+			if (S_ISDIR(st.st_mode))
+				ent->ignored_dir = 1;
+			continue;
+		}
 		die("pathspec '%s' did not match any files", match);
 	}
 }
@@ -62,8 +63,6 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec)
 
 	/* Set up the default git porcelain excludes */
 	memset(dir, 0, sizeof(*dir));
-	if (pathspec)
-		dir->show_both = 1;
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
 	if (!access(path, R_OK))
@@ -154,7 +153,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (show_only) {
 		const char *sep = "", *eof = "";
 		for (i = 0; i < dir.nr; i++) {
-			if (!ignored_too && dir.entries[i]->ignored_entry)
+			if (!ignored_too && dir.entries[i]->ignored)
 				continue;
 			printf("%s%s", sep, dir.entries[i]->name);
 			sep = " ";
@@ -168,16 +167,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die("index file corrupt");
 
 	if (!ignored_too) {
-		int has_ignored = -1;
-		for (i = 0; has_ignored < 0 && i < dir.nr; i++)
-			if (dir.entries[i]->ignored_entry)
-				has_ignored = i;
-		if (0 <= has_ignored) {
+		int has_ignored = 0;
+		for (i = 0; i < dir.nr; i++)
+			if (dir.entries[i]->ignored)
+				has_ignored = 1;
+		if (has_ignored) {
 			fprintf(stderr, ignore_warning);
-			for (i = has_ignored; i < dir.nr; i++) {
-				if (!dir.entries[i]->ignored_entry)
+			for (i = 0; i < dir.nr; i++) {
+				if (!dir.entries[i]->ignored)
 					continue;
-				fprintf(stderr, "%s\n", dir.entries[i]->name);
+				fprintf(stderr, "%s", dir.entries[i]->name);
+				if (dir.entries[i]->ignored_dir)
+					fprintf(stderr, " (directory)");
+				fputc('\n', stderr);
 			}
 			fprintf(stderr,
 				"Use -f if you really want to add them.\n");
diff --git a/dir.c b/dir.c
index 8477472..0338d6c 100644
--- a/dir.c
+++ b/dir.c
@@ -260,12 +260,12 @@ int excluded(struct dir_struct *dir, const char *pathname)
 	return 0;
 }
 
-static void add_name(struct dir_struct *dir, const char *pathname, int len)
+struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
 	struct dir_entry *ent;
 
 	if (cache_name_pos(pathname, len) >= 0)
-		return;
+		return NULL;
 
 	if (dir->nr == dir->alloc) {
 		int alloc = alloc_nr(dir->alloc);
@@ -273,10 +273,12 @@ static void add_name(struct dir_struct *dir, const char *pathname, int len)
 		dir->entries = xrealloc(dir->entries, alloc*sizeof(ent));
 	}
 	ent = xmalloc(sizeof(*ent) + len + 1);
+	ent->ignored = ent->ignored_dir = 0;
 	ent->len = len;
 	memcpy(ent->name, pathname, len);
 	ent->name[len] = 0;
 	dir->entries[dir->nr++] = ent;
+	return ent;
 }
 
 static int dir_exists(const char *dirname, int len)
@@ -364,7 +366,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			if (check_only)
 				goto exit_early;
 			else
-				add_name(dir, fullname, baselen + len);
+				dir_add_name(dir, fullname, baselen + len);
 		}
 exit_early:
 		closedir(fdir);
diff --git a/dir.h b/dir.h
index c919727..7233d65 100644
--- a/dir.h
+++ b/dir.h
@@ -13,7 +13,9 @@
 
 
 struct dir_entry {
-	int len;
+	unsigned int ignored : 1;
+	unsigned int ignored_dir : 1;
+	unsigned int len : 30;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -55,5 +57,6 @@ extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
 extern int file_exists(const char *);
+extern struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len);
 
 #endif
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index c09c53f..e98786d 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -51,4 +51,37 @@ test_expect_success \
 	 *) echo fail; git-ls-files --stage xfoo3; (exit 1);;
 	 esac'
 
+test_expect_success '.gitignore test setup' '
+	echo "*.ig" >.gitignore &&
+	mkdir c.if d.ig &&
+	>a.ig && >b.if &&
+	>c.if/c.if && >c.if/c.ig &&
+	>d.ig/d.if && >d.ig/d.ig
+'
+
+test_expect_success '.gitignore is honored' '
+	git-add . &&
+	! git-ls-files | grep "\\.ig"
+'
+
+test_expect_success 'error out when attempting to add ignored ones without -f' '
+	! git-add a.?? &&
+	! git-ls-files | grep "\\.ig"
+'
+
+test_expect_success 'error out when attempting to add ignored ones without -f' '
+	! git-add d.?? &&
+	! git-ls-files | grep "\\.ig"
+'
+
+test_expect_success 'add ignored ones with -f' '
+	git-add -f a.?? &&
+	git-ls-files --error-unmatch a.ig
+'
+
+test_expect_success 'add ignored ones with -f' '
+	git-add -f d.??/* &&
+	git-ls-files --error-unmatch d.ig/d.if d.ig/d.ig
+'
+
 test_done
