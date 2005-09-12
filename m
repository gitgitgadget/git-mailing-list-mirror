From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 11/22] teach write-tree.c to use cache iterators
Date: Mon, 12 Sep 2005 10:56:07 -0400
Message-ID: <20050912145607.28120.80487.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:03:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpll-0001hk-JM
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVILO5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVILO4k
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:40 -0400
Received: from citi.umich.edu ([141.211.133.111]:33164 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751298AbVILO4H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:07 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 652741BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:07 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8402>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 write-tree.c |  110 ++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 69 insertions(+), 41 deletions(-)

diff --git a/write-tree.c b/write-tree.c
--- a/write-tree.c
+++ b/write-tree.c
@@ -5,7 +5,7 @@
  */
 #include "cache.h"
 
-static int missing_ok = 0;
+static int funny, missing_ok = 0;
 
 static int check_valid_sha1(unsigned char *sha1)
 {
@@ -18,8 +18,9 @@ static int check_valid_sha1(unsigned cha
 	return ret ? 0 : -1;
 }
 
-static int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1)
+static int write_tree(struct cache_cursor *cc, int maxentries, const char *base, int baselen, unsigned char *returnsha1)
 {
+	struct cache_cursor next = *cc;
 	unsigned char subdir_sha1[20];
 	unsigned long size, offset;
 	char *buffer;
@@ -32,7 +33,7 @@ static int write_tree(struct cache_entry
 
 	nr = 0;
 	while (nr < maxentries) {
-		struct cache_entry *ce = cachep[nr];
+		struct cache_entry *ce = cc_to_ce(&next);
 		const char *pathname = ce->name, *filename, *dirname;
 		int pathlen = ce_namelen(ce), entrylen;
 		unsigned char *sha1;
@@ -51,15 +52,20 @@ static int write_tree(struct cache_entry
 		if (dirname) {
 			int subdir_written;
 
-			subdir_written = write_tree(cachep + nr, maxentries - nr, pathname, dirname-pathname+1, subdir_sha1);
-			nr += subdir_written;
-
+			subdir_written = write_tree(&next,
+						    maxentries - nr,
+						    pathname,
+						    dirname - pathname + 1,
+						    subdir_sha1);
+			
 			/* Now we need to write out the directory entry into this tree.. */
 			mode = S_IFDIR;
 			pathlen = dirname - pathname;
 
 			/* ..but the directory entry doesn't count towards the total count */
-			nr--;
+			nr += subdir_written - 1;
+			while (--subdir_written)
+				next_cc(&next);
 			sha1 = subdir_sha1;
 		}
 
@@ -76,6 +82,7 @@ static int write_tree(struct cache_entry
 		memcpy(buffer + offset, sha1, 20);
 		offset += 20;
 		nr++;
+		next_cc(&next);
 	}
 
 	write_sha1_file(buffer, offset, "tree", returnsha1);
@@ -83,11 +90,57 @@ static int write_tree(struct cache_entry
 	return nr;
 }
 
+static int verify_merged(struct cache_cursor *cc, struct cache_entry *ce)
+{
+	if (ntohs(ce->ce_flags) & ~CE_NAMEMASK) {
+		if (10 < ++funny) {
+			fprintf(stderr, "...\n");
+			return -1;
+		}
+		fprintf(stderr, "%s: unmerged (%s)\n", ce->name, sha1_to_hex(ce->sha1));
+	}
+
+	next_cc(cc);
+	return 0;
+}
+
+/*
+ * path/file always comes after path because of the way
+ * the cache is sorted.  Also path can appear only once,
+ * which means conflicting one would immediately follow.
+ */
+static int verify_path(struct cache_cursor *cc, struct cache_entry *ce)
+{
+	struct cache_entry *next;
+	const char *next_name, *this_name = ce->name;
+	int this_len = strlen(this_name);
+
+	/* don't check the last cache entry */
+	next_cc(cc);
+	if (cache_eof(cc))
+		return -1;
+	next = cc_to_ce(cc);
+	next_name = next->name;
+
+	if (this_len < strlen(next_name) &&
+	    strncmp(this_name, next_name, this_len) == 0 &&
+	    next_name[this_len] == '/') {
+		if (10 < ++funny) {
+			fprintf(stderr, "...\n");
+			return -1;
+		}
+		fprintf(stderr, "You have both %s and %s\n",
+			this_name, next_name);
+	}
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
-	int i, funny;
-	int entries = read_cache();
+	struct cache_cursor cc;
 	unsigned char sha1[20];
+	int entries;
 	
 	if (argc == 2) {
 		if (!strcmp(argv[1], "--missing-ok"))
@@ -99,53 +152,28 @@ int main(int argc, char **argv)
 	if (argc > 2)
 		die("too many options");
 
+	entries = read_cache();
 	if (entries < 0)
 		die("git-write-tree: error reading cache");
 
 	/* Verify that the tree is merged */
 	funny = 0;
-	for (i = 0; i < entries; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ntohs(ce->ce_flags) & ~CE_NAMEMASK) {
-			if (10 < ++funny) {
-				fprintf(stderr, "...\n");
-				break;
-			}
-			fprintf(stderr, "%s: unmerged (%s)\n", ce->name, sha1_to_hex(ce->sha1));
-		}
-	}
+	walk_cache(verify_merged);
 	if (funny)
-		die("git-write-tree: not able to write tree");
+		die("git-write-tree: verify_merged: not able to write tree");
 
 	/* Also verify that the cache does not have path and path/file
 	 * at the same time.  At this point we know the cache has only
 	 * stage 0 entries.
 	 */
 	funny = 0;
-	for (i = 0; i < entries - 1; i++) {
-		/* path/file always comes after path because of the way
-		 * the cache is sorted.  Also path can appear only once,
-		 * which means conflicting one would immediately follow.
-		 */
-		const char *this_name = active_cache[i]->name;
-		const char *next_name = active_cache[i+1]->name;
-		int this_len = strlen(this_name);
-		if (this_len < strlen(next_name) &&
-		    strncmp(this_name, next_name, this_len) == 0 &&
-		    next_name[this_len] == '/') {
-			if (10 < ++funny) {
-				fprintf(stderr, "...\n");
-				break;
-			}
-			fprintf(stderr, "You have both %s and %s\n",
-				this_name, next_name);
-		}
-	}
+	walk_cache(verify_path);
 	if (funny)
-		die("git-write-tree: not able to write tree");
+		die("git-write-tree: verify_path: not able to write tree");
 
 	/* Ok, write it out */
-	if (write_tree(active_cache, entries, "", 0, sha1) != entries)
+	init_cc(&cc);
+	if (write_tree(&cc, entries, "", 0, sha1) != entries)
 		die("git-write-tree: internal error");
 	printf("%s\n", sha1_to_hex(sha1));
 	return 0;
