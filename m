From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v2 7/7] unpack-trees.c: introduce schedule_dir_for_removal()
Date: Sun, 01 Feb 2009 21:23:39 +0100
Message-ID: <02194022d0e7bfaef7eb9d98be30292954090a2a.1233499703.git.barvik@broadpark.no>
References: <cover.1233499703.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 21:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTisc-0001tK-Mw
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 21:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbZBAUXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 15:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbZBAUXp
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 15:23:45 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:55738 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbZBAUXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 15:23:42 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEE0059FLZICP80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 01 Feb 2009 21:23:42 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.229])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KEE00HXTLZFE140@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 01 Feb 2009 21:23:42 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1233499703.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107998>

Currently inside unlink_entry() if we get a successful removal of one
file with unlink(), we try to remove the leading directories each and
every time.  So if one directory containing 200 files is moved to an
other location we get 199 failed calls to rmdir() and 1 successful
call.

To fix this and to avoid some unnecessary calls to rmdir(), we only
schedule each directory for removal and we wait much longer before we
do the actually call to rmdir().

Since the unlink_entry() function is called with alphabetically sorted
names, this new function end up being very effective to avoid
unnecessary calls to rmdir().  In some cases over 95% of all calls to
rmdir() is removed with this patch.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---

  I noticed that I had to copy-and-paste almost all lines from the
  longest_match_lstat_cache() in symlinks.c into this new function, so
  maybe I should do the following:

  Move the 3 new functions below inside the same file (dir.c?) as the
  lstat_cache() functions, rename longest_match_lstat_cache() to
  longest_dir_match(), do some cleanup/fix'es, and let it be called
  from the 3 functions which currently need it.

  Good idea?


 unpack-trees.c |   97 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index e547282..5c12eca 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -52,36 +52,84 @@ static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	add_index_entry(&o->result, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|ADD_CACHE_SKIP_DFCHECK);
 }
 
-/* Unlink the last component and attempt to remove leading
- * directories, in case this unlink is the removal of the
- * last entry in the directory -- empty directories are removed.
+static char path_buf[PATH_MAX];
+static unsigned int path_len;
+
+static void do_remove_scheduled_dirs(unsigned int new_len)
+{
+	while (path_len > new_len) {
+		path_buf[path_len] = '\0';
+		if (rmdir(path_buf))
+			break;
+		do {
+			path_len--;
+		} while (path_len > new_len && path_buf[path_len] != '/');
+	}
+	path_len = new_len;
+	return;
+}
+
+static void schedule_dir_for_removal(const char *name, unsigned int len)
+{
+	unsigned int i = 0, match_len = 0, max_len, last_slash;
+
+	/* Find longest dir-match between 'name' and 'path' */
+	max_len = len < path_len ? len : path_len;
+	while (i < max_len && name[i] == path_buf[i]) {
+		if (name[i] == '/')
+			match_len = i;
+		i++;
+	}
+	if (i >= max_len && ((len > path_len && name[path_len] == '/') ||
+			     (len < path_len && path_buf[len] == '/') ||
+			     (len == path_len)))
+		match_len = i;
+
+	/* Find the last slash inside 'name' */
+	last_slash = match_len;
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
+	if (match_len < last_slash && match_len < path_len)
+		do_remove_scheduled_dirs(match_len);
+	/*
+	 * If we go deeper down the directory tree, we only need to
+	 * save the new path components as we go down.
+	 */
+	if (match_len < last_slash) {
+		memmove(&path_buf[match_len], &name[match_len],
+			last_slash - match_len);
+		path_len = last_slash;
+	}
+	return;
+}
+
+#define ALL_DIRS 0
+static void remove_scheduled_dirs(void)
+{
+	do_remove_scheduled_dirs(ALL_DIRS);
+	return;
+}
+
+/*
+ * Unlink the last component and schedule the leading directories for
+ * removal, such that empty directories get removed.
  */
 static void unlink_entry(struct cache_entry *ce)
 {
-	char *cp, *prev;
-	char *name = ce->name;
-
 	if (has_symlink_or_noent_leading_path(ce_namelen(ce), ce->name))
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
@@ -117,6 +165,7 @@ static int check_updates(struct unpack_trees_options *o)
 			continue;
 		}
 	}
+	remove_scheduled_dirs();
 
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
-- 
1.6.1.349.g99fa5
