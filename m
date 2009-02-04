From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v3 4/9] unlink_entry(): introduce schedule_dir_for_removal()
Date: Wed, 04 Feb 2009 13:52:49 +0100
Message-ID: <5e00462034e14b628ad6744edc1fad7daee78c5c.1233751281.git.barvik@broadpark.no>
References: <cover.1233751281.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 13:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUhHR-0006OR-Ll
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 13:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358AbZBDMxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756460AbZBDMxN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:53:13 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:45423 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660AbZBDMxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:53:09 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEJ003J6L4HHW70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 13:53:05 +0100 (CET)
Received: from localhost.localdomain ([80.203.29.216])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KEJ004C6L47S210@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 13:53:05 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1233751281.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108349>

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
 symlinks.c     |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c |   30 +++++----------------------
 3 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/cache.h b/cache.h
index 30039ac..717dd84 100644
--- a/cache.h
+++ b/cache.h
@@ -726,6 +726,8 @@ extern int has_symlink_or_noent_leading_path(const char *name, int len);
 extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void invalidate_lstat_cache(const char *name, int len);
 extern void clear_lstat_cache(void);
+extern void schedule_dir_for_removal(const char *name, int len);
+extern void remove_scheduled_dirs(void);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
index 5167286..215d049 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -245,3 +245,63 @@ int has_dirs_only_path(const char *name, int len, int prefix_len)
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
+		memmove(&removal.path[match_len], &name[match_len],
+			last_slash - match_len);
+		removal.len = last_slash;
+	}
+	return;
+}
+
+#define ALL_DIRS 0
+void remove_scheduled_dirs(void)
+{
+	do_remove_scheduled_dirs(ALL_DIRS);
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
