From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/5] Refactor cache_tree_update idiom from commit
Date: Tue, 6 Dec 2011 18:43:37 +0100
Message-ID: <dc6cfeae970f465492050f190b7b0f93f6658cc1.1323191497.git.trast@student.ethz.ch>
References: <cover.1323191497.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 06 18:43:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXz3X-0000Dz-EE
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 18:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab1LFRns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 12:43:48 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:35844 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915Ab1LFRnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 12:43:45 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:43:39 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:43:41 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323191497.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186359>

We'll need to safely create or update the cache-tree data of the_index
from other places.  While at it, give it an argument that lets us
silence the messages produced by unmerged entries (which prevent it
from working).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin/commit.c       |    5 +----
 cache-tree.c           |   19 +++++++++++++++----
 cache-tree.h           |    4 +++-
 merge-recursive.c      |    2 +-
 test-dump-cache-tree.c |    2 +-
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e36e9ad..0163086 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -862,10 +862,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	discard_cache();
 	read_cache_from(index_file);
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
-	if (cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0) < 0) {
+	if (update_main_cache_tree(0)) {
 		error(_("Error building trees"));
 		return 0;
 	}
diff --git a/cache-tree.c b/cache-tree.c
index f755590..8de3959 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -150,7 +150,7 @@ void cache_tree_invalidate_path(struct cache_tree *it, const char *path)
 }
 
 static int verify_cache(struct cache_entry **cache,
-			int entries)
+			int entries, int silent)
 {
 	int i, funny;
 
@@ -159,6 +159,8 @@ static int verify_cache(struct cache_entry **cache,
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
 		if (ce_stage(ce) || (ce->ce_flags & CE_INTENT_TO_ADD)) {
+			if (silent)
+				return -1;
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
@@ -370,10 +372,11 @@ int cache_tree_update(struct cache_tree *it,
 		      struct cache_entry **cache,
 		      int entries,
 		      int missing_ok,
-		      int dryrun)
+		      int dryrun,
+		      int silent)
 {
 	int i;
-	i = verify_cache(cache, entries);
+	i = verify_cache(cache, entries, silent);
 	if (i)
 		return i;
 	i = update_one(it, cache, entries, "", 0, missing_ok, dryrun);
@@ -573,7 +576,7 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 
 		if (cache_tree_update(active_cache_tree,
 				      active_cache, active_nr,
-				      missing_ok, 0) < 0)
+				      missing_ok, 0, 0) < 0)
 			return WRITE_TREE_UNMERGED_INDEX;
 		if (0 <= newfd) {
 			if (!write_cache(newfd, active_cache, active_nr) &&
@@ -668,3 +671,11 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 		return it->entry_count;
 	return 0;
 }
+
+int update_main_cache_tree (int silent)
+{
+	if (!the_index.cache_tree)
+		the_index.cache_tree = cache_tree();
+	return cache_tree_update(the_index.cache_tree,
+				 the_index.cache, the_index.cache_nr, 0, 0, silent);
+}
diff --git a/cache-tree.h b/cache-tree.h
index 3df641f..0ec0b2a 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -29,7 +29,9 @@ struct cache_tree {
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct cache_tree *);
-int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int, int);
+int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int, int, int);
+
+int update_main_cache_tree(int);
 
 /* bitmasks to write_cache_as_tree flags */
 #define WRITE_TREE_MISSING_OK 1
diff --git a/merge-recursive.c b/merge-recursive.c
index 5a2db29..d83cd6c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -264,7 +264,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
 	    cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0) < 0)
+			      active_cache, active_nr, 0, 0, 0) < 0)
 		die("error building trees");
 
 	result = lookup_tree(active_cache_tree->sha1);
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index 1f73f1e..e6c2923 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -59,6 +59,6 @@ int main(int ac, char **av)
 	struct cache_tree *another = cache_tree();
 	if (read_cache() < 0)
 		die("unable to read index file");
-	cache_tree_update(another, active_cache, active_nr, 0, 1);
+	cache_tree_update(another, active_cache, active_nr, 0, 1, 0);
 	return dump_cache_tree(active_cache_tree, another, "");
 }
-- 
1.7.8.425.ga639d3
