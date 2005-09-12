From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 22/22] teach read-cache.c to use cache_find_name()
Date: Mon, 12 Sep 2005 10:56:31 -0400
Message-ID: <20050912145631.28120.70807.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:02:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpln-0001hk-9a
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVILO4x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVILO4w
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:52 -0400
Received: from citi.umich.edu ([141.211.133.111]:25125 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751061AbVILO4c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:32 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 90C151BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:31 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8397>

Fix up the functions in read-cache.c to use cache cursors and
cache_find_name().  As a bonus, cache_name_pos() is no longer
needed.

We've now replaced all logic that depends on a negative result
from cache_name_pos to detect cache insertion points.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 cache.h      |    3 -
 read-cache.c |  118 ++++++++++++++++++++++++----------------------------------
 read-tree.c  |    2 -
 3 files changed, 51 insertions(+), 72 deletions(-)

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -159,14 +159,13 @@ extern char *prefix_path(const char *pre
 extern int read_cache(void);
 extern int read_cache_unmerged(void);
 extern int write_cache(int newfd);
-extern int cache_name_pos(const char *name, int namelen);
 extern int cache_find_name(const char *name, int namelen, struct cache_cursor *cc);
 
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
 extern int add_cache_entry(struct cache_entry *ce, int option);
-extern int remove_cache_entry_at(int pos);
+extern int remove_cache_entry_at(struct cache_cursor *cc);
 extern int remove_file_from_cache(char *path);
 extern void prune_cache(const char *prefix, int prefix_len);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -123,27 +123,6 @@ int cache_name_compare(const char *name1
 	return 0;
 }
 
-int cache_name_pos(const char *name, int namelen)
-{
-	int first, last;
-
-	first = 0;
-	last = active_nr;
-	while (last > first) {
-		int next = (last + first) >> 1;
-		struct cache_entry *ce = active_cache[next];
-		int cmp = cache_name_compare(name, namelen, ce->name, ntohs(ce->ce_flags));
-		if (!cmp)
-			return next;
-		if (cmp < 0) {
-			last = next;
-			continue;
-		}
-		first = next+1;
-	}
-	return -first-1;
-}
-
 /*
  * Given a name, find the first cache entry that matches.  Returning 1
  * means the cursor points to the cache entry with a matching name.
@@ -189,11 +168,13 @@ int cache_find_name(const char *name, in
 }
 
 /* Remove entry, return true if there are more entries to go.. */
-int remove_cache_entry_at(int pos)
+int remove_cache_entry_at(struct cache_cursor *cc)
 {
+	int pos = cc->pos;
+
 	active_cache_changed = 1;
 	active_nr--;
-	if (pos >= active_nr)
+	if (cache_eof(cc))
 		return 0;
 	memmove(active_cache + pos, active_cache + pos + 1, (active_nr - pos) * sizeof(struct cache_entry *));
 	return 1;
@@ -201,11 +182,11 @@ int remove_cache_entry_at(int pos)
 
 int remove_file_from_cache(char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
-	if (pos < 0)
-		pos = -pos-1;
-	while (pos < active_nr && !strcmp(active_cache[pos]->name, path))
-		remove_cache_entry_at(pos);
+	struct cache_cursor cc;
+
+	cache_find_name(path, strlen(path), &cc);
+	while (!cache_eof(&cc) && !strcmp(cc_to_ce(&cc)->name, path))
+		remove_cache_entry_at(&cc);
 	return 0;
 }
 
@@ -214,13 +195,12 @@ int remove_file_from_cache(char *path)
  */
 void prune_cache(const char *prefix, int prefix_len)
 {
-	int pos = cache_name_pos(prefix, prefix_len);
+	struct cache_cursor cc;
 	unsigned int first, last;
 
-	if (pos < 0)
-		pos = -pos-1;
-	active_cache += pos;
-	active_nr -= pos;
+	cache_find_name(prefix, prefix_len, &cc);
+	active_cache += cc.pos;
+	active_nr -= cc.pos;
 	first = 0;
 	last = active_nr;
 	while (last > first) {
@@ -237,7 +217,8 @@ void prune_cache(const char *prefix, int
 
 int ce_same_name(struct cache_entry *a, struct cache_entry *b)
 {
-	int len = ce_namelen(a);
+	int len;
+	len = ce_namelen(a);
 	return ce_namelen(b) == len && !memcmp(a->name, b->name, len);
 }
 
@@ -271,28 +252,30 @@ int ce_path_match(const struct cache_ent
  * Do we have another file that has the beginning components being a
  * proper superset of the name we're trying to add?
  */
-static int has_file_name(const struct cache_entry *ce, int pos, int ok_to_replace)
+static int has_file_name(const struct cache_entry *ce, struct cache_cursor *cc, int ok_to_replace)
 {
 	int retval = 0;
 	int len = ce_namelen(ce);
 	int stage = ce_stage(ce);
 	const char *name = ce->name;
 
-	while (pos < active_nr) {
-		struct cache_entry *p = active_cache[pos++];
+	while (!cache_eof(cc)) {
+		struct cache_entry *p = cc_to_ce(cc);
 
 		if (len >= ce_namelen(p))
 			break;
 		if (memcmp(name, p->name, len))
 			break;
 		if (ce_stage(p) != stage)
-			continue;
+			goto next;
 		if (p->name[len] != '/')
-			continue;
+			goto next;
 		retval = -1;
 		if (!ok_to_replace)
 			break;
-		remove_cache_entry_at(--pos);
+		remove_cache_entry_at(cc);
+next:
+		next_cc(cc);
 	}
 	return retval;
 }
@@ -301,8 +284,9 @@ static int has_file_name(const struct ca
  * Do we have another file with a pathname that is a proper
  * subset of the name we're trying to add?
  */
-static int has_dir_name(const struct cache_entry *ce, int pos, int ok_to_replace)
+static int has_dir_name(const struct cache_entry *ce, int ok_to_replace)
 {
+	struct cache_cursor cc;
 	int retval = 0;
 	int stage = ce_stage(ce);
 	const char *name = ce->name;
@@ -319,12 +303,11 @@ static int has_dir_name(const struct cac
 		}
 		len = slash - name;
 
-		pos = cache_name_pos(name, ntohs(create_ce_flags(len, stage)));
-		if (pos >= 0) {
+		if (cache_find_name(name, ntohs(create_ce_flags(len, stage)), &cc)) {
 			retval = -1;
 			if (ok_to_replace)
 				break;
-			remove_cache_entry_at(pos);
+			remove_cache_entry_at(&cc);
 			continue;
 		}
 
@@ -333,9 +316,8 @@ static int has_dir_name(const struct cac
 		 * already matches the sub-directory, then we know
 		 * we're ok, and we can exit.
 		 */
-		pos = -pos-1;
-		while (pos < active_nr) {
-			struct cache_entry *p = active_cache[pos];
+		while (!cache_eof(&cc)) {
+			struct cache_entry *p = cc_to_ce(&cc);
 			if ((ce_namelen(p) <= len) ||
 			    (p->name[len] != '/') ||
 			    memcmp(p->name, name, len))
@@ -347,7 +329,7 @@ static int has_dir_name(const struct cac
 				 * level or anything shorter.
 				 */
 				return retval;
-			pos++;
+			next_cc(&cc);
 		}
 	}
 	return retval;
@@ -362,45 +344,41 @@ static int has_dir_name(const struct cac
  * from the cache so the caller should recompute the insert position.
  * When this happens, we return non-zero.
  */
-static int check_file_directory_conflict(const struct cache_entry *ce, int pos, int ok_to_replace)
+static int check_file_directory_conflict(const struct cache_entry *ce, struct cache_cursor *cc, int ok_to_replace)
 {
+	struct cache_cursor cd = *cc;
 	/*
 	 * We check if the path is a sub-path of a subsequent pathname
 	 * first, since removing those will not change the position
 	 * in the array
 	 */
-	int retval = has_file_name(ce, pos, ok_to_replace);
+	int retval = has_file_name(ce, &cd, ok_to_replace);
 	/*
 	 * Then check if the path might have a clashing sub-directory
 	 * before it.
 	 */
-	return retval + has_dir_name(ce, pos, ok_to_replace);
+	return retval + has_dir_name(ce, ok_to_replace);
 }
 
 int add_cache_entry(struct cache_entry *ce, int option)
 {
-	int pos;
+	struct cache_cursor cc;
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
-	pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
 
 	/* existing match? Just replace it */
-	if (pos >= 0) {
-		active_cache_changed = 1;
-		active_cache[pos] = ce;
-		return 0;
-	}
-	pos = -pos-1;
+	if (cache_find_name(ce->name, ntohs(ce->ce_flags), &cc))
+		goto out;
 
 	/*
 	 * Inserting a merged entry ("stage 0") into the index
 	 * will always replace all non-merged entries..
 	 */
-	if (pos < active_nr && ce_stage(ce) == 0) {
-		while (ce_same_name(active_cache[pos], ce)) {
+	if (!cache_eof(&cc) && ce_stage(ce) == 0) {
+		while (ce_same_name(cc_to_ce(&cc), ce)) {
 			ok_to_add = 1;
-			if (!remove_cache_entry_at(pos))
+			if (!remove_cache_entry_at(&cc))
 				break;
 		}
 	}
@@ -408,11 +386,10 @@ int add_cache_entry(struct cache_entry *
 	if (!ok_to_add)
 		return -1;
 
-	if (!skip_df_check && check_file_directory_conflict(ce, pos, ok_to_replace)) {
+	if (!skip_df_check && check_file_directory_conflict(ce, &cc, ok_to_replace)) {
 		if (!ok_to_replace)
 			return -1;
-		pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
-		pos = -pos-1;
+		cache_find_name(ce->name, ntohs(ce->ce_flags), &cc);
 	}
 
 	/* Make sure the array is big enough .. */
@@ -423,10 +400,13 @@ int add_cache_entry(struct cache_entry *
 
 	/* Add it in.. */
 	active_nr++;
-	if (active_nr > pos)
+	if (!cache_eof(&cc)) {
+		int pos = cc.pos;
 		memmove(active_cache + pos + 1, active_cache + pos, (active_nr - pos - 1) * sizeof(ce));
-	active_cache[pos] = ce;
-	active_cache_changed = 1;
+	}
+
+out:
+	set_ce_at_cursor(&cc, ce);
 	return 0;
 }
 
@@ -456,7 +436,7 @@ int read_cache(void)
 	struct cache_header *hdr;
 
 	errno = EBUSY;
-	if (active_cache)
+	if (!read_cache_needed())
 		return error("more than one cachefile");
 	errno = ENOENT;
 	fd = open(get_index_file(), O_RDONLY);
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -135,7 +135,7 @@ static int unpack_trees_rec(struct tree_
 		if (cache_name && !strcmp(cache_name, first)) {
 			any_files = 1;
 			src[0] = cc_to_ce(cc);
-			remove_cache_entry_at(cc->pos);
+			remove_cache_entry_at(cc);
 		}
 
 		for (i = 0; i < len; i++) {
