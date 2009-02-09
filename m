From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v4 4/9] unlink_entry(): introduce schedule_dir_for_removal()
Date: Mon, 09 Feb 2009 21:54:07 +0100
Message-ID: <9ccf4c748ea527b8645770c290d53e9f061b1810.1234211595.git.barvik@broadpark.no>
References: <cover.1234211594.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 21:56:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdAt-0002PW-25
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 21:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbZBIUy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 15:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbZBIUy1
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 15:54:27 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:36104 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbZBIUyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 15:54:24 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KET00IEAGQMPR80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:22 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.166])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KET007FSGQC8090@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:22 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1234211594.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109124>

Currently inside unlink_entry() if we get a successful removal of one
file with unlink(), we try to remove the leading directories each and
every time.  So if one directory containing 200 files is moved to an
other location we get 199 failed calls to rmdir() and 1 successful
call.

To fix this and avoid some unnecessary calls to rmdir(), we schedule
each directory for removal and wait much longer before we do the real
call to rmdir().

Since the unlink_entry() function is called with alphabetically sorted
names, this new function end up being very effective to avoid
unnecessary calls to rmdir().  In some cases over 95% of all calls to
rmdir() is removed with this patch.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 cache.h        |    2 +
 symlinks.c     |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c |   30 +++++----------------------
 3 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/cache.h b/cache.h
index 80eeeb7..1bf2d4b 100644
--- a/cache.h
+++ b/cache.h
@@ -729,6 +729,8 @@ extern int has_symlink_or_noent_leading_path(const char *name, int len);
 extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void invalidate_lstat_cache(const char *name, int len);
 extern void clear_lstat_cache(void);
+extern void schedule_dir_for_removal(const char *name, int len);
+extern void remove_scheduled_dirs(void);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
index 5167286..1d6b35b 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -245,3 +245,62 @@ int has_dirs_only_path(const char *name, int len, int prefix_len)
 			   FL_DIR|FL_FULLPATH, prefix_len) &
 		FL_DIR;
 }
+
+static struct removal_def {
+	char path[PATH_MAX];
+	int len;
+} removal;
+
+static void do_remove_scheduled_dirs(int new_len)
+{
+	while (removal.len > new_len) {
+		removal.path[removal.len] = '\0';
+		if (rmdir(removal.path))
+			break;
+		do {
+			removal.len--;
+		} while (removal.len > new_len &&
+			 removal.path[removal.len] != '/');
+	}
+	removal.len = new_len;
+	return;
+}
+
+void schedule_dir_for_removal(const char *name, int len)
+{
+	int match_len, last_slash, i, previous_slash;
+
+	match_len = last_slash = i =
+		longest_path_match(name, len, removal.path, removal.len,
+				   &previous_slash);
+	/* Find last slash inside 'name' */
+	while (i < len) {
+		if (name[i] == '/')
+			last_slash = i;
+		i++;
+	}
+
+	/*
+	 * If we are about to go down the directory tree, we check if
+	 * we must first go upwards the tree, such that we then can
+	 * remove possible empty directories as we go upwards.
+	 */
+	if (match_len < last_slash && match_len < removal.len)
+		do_remove_scheduled_dirs(match_len);
+	/*
+	 * If we go deeper down the directory tree, we only need to
+	 * save the new path components as we go down.
+	 */
+	if (match_len < last_slash) {
+		memcpy(&removal.path[match_len], &name[match_len],
+		       last_slash - match_len);
+		removal.len = last_slash;
+	}
+	return;
+}
+
+void remove_scheduled_dirs(void)
+{
+	do_remove_scheduled_dirs(0);
+	return;
+}
diff --git a/unpack-trees.c b/unpack-trees.c
index 2293158..e3c3fa1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -52,36 +52,17 @@ static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	add_index_entry(&o->result, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|ADD_CACHE_SKIP_DFCHECK);
 }
 
-/* Unlink the last component and attempt to remove leading
- * directories, in case this unlink is the removal of the
- * last entry in the directory -- empty directories are removed.
+/*
+ * Unlink the last component and schedule the leading directories for
+ * removal, such that empty directories get removed.
  */
 static void unlink_entry(struct cache_entry *ce)
 {
-	char *cp, *prev;
-	char *name = ce->name;
-
 	if (has_symlink_or_noent_leading_path(ce->name, ce_namelen(ce)))
 		return;
-	if (unlink(name))
+	if (unlink(ce->name))
 		return;
-	prev = NULL;
-	while (1) {
-		int status;
-		cp = strrchr(name, '/');
-		if (prev)
-			*prev = '/';
-		if (!cp)
-			break;
-
-		*cp = 0;
-		status = rmdir(name);
-		if (status) {
-			*cp = '/';
-			break;
-		}
-		prev = cp;
-	}
+	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
 static struct checkout state;
@@ -117,6 +98,7 @@ static int check_updates(struct unpack_trees_options *o)
 			continue;
 		}
 	}
+	remove_scheduled_dirs();
 
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
-- 
1.6.1.349.g99fa5
