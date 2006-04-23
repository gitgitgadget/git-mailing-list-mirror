From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] Update write-tree to use cache-tree.
Date: Sun, 23 Apr 2006 16:52:35 -0700
Message-ID: <7vacabetoc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 01:52:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXoNd-0006Hx-6z
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 01:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWDWXwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 19:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWDWXwi
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 19:52:38 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8351 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751463AbWDWXwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 19:52:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060423235236.CAAF8660.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Apr 2006 19:52:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19076>

The updated write-tree reads from $GIT_DIR/index.aux to pick up
subtree objects information, updates the cache-tree with the
index, and updates index.aux file after writing a tree out of
the index file.

Until update-index and other programs that modify the index are
updated to maintain index.aux file, the index.aux file written
by the last write-tree will become stale immediately after they
update the index, which will result in the whole tree
recomputation just like the original write-tree.

The idea is to convert those commands to invalidate cache-tree
whenever they touch the index entries, and write updated
index.aux out.  After the index is updated with them, write-tree
will be able to reuse the parts of the cache-tree that have not
been touched.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * And this is the "Willie the Coyote waiting for the big rock
   to fail" patch.  Right now nobody uses the cache but...

 write-tree.c |  135 +++++-----------------------------------------------------
 1 files changed, 11 insertions(+), 124 deletions(-)

ff283e7fafdd0740f74dfa65d8efaaaf9a5a0bbf
diff --git a/write-tree.c b/write-tree.c
index dcad6e6..dbcfe8c 100644
--- a/write-tree.c
+++ b/write-tree.c
@@ -5,96 +5,23 @@
  */
 #include "cache.h"
 #include "tree.h"
+#include "cache-tree.h"
 
-static int missing_ok = 0;
-
-static int check_valid_sha1(unsigned char *sha1)
-{
-	int ret;
-
-	/* If we were anal, we'd check that the sha1 of the contents actually matches */
-	ret = has_sha1_file(sha1);
-	if (ret == 0)
-		perror(sha1_file_name(sha1));
-	return ret ? 0 : -1;
-}
-
-static int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1)
-{
-	unsigned char subdir_sha1[20];
-	unsigned long size, offset;
-	char *buffer;
-	int nr;
-
-	/* Guess at some random initial size */
-	size = 8192;
-	buffer = xmalloc(size);
-	offset = 0;
-
-	nr = 0;
-	while (nr < maxentries) {
-		struct cache_entry *ce = cachep[nr];
-		const char *pathname = ce->name, *filename, *dirname;
-		int pathlen = ce_namelen(ce), entrylen;
-		unsigned char *sha1;
-		unsigned int mode;
-
-		/* Did we hit the end of the directory? Return how many we wrote */
-		if (baselen >= pathlen || memcmp(base, pathname, baselen))
-			break;
-
-		sha1 = ce->sha1;
-		mode = ntohl(ce->ce_mode);
-
-		/* Do we have _further_ subdirectories? */
-		filename = pathname + baselen;
-		dirname = strchr(filename, '/');
-		if (dirname) {
-			int subdir_written;
+static unsigned char active_cache_sha1[20];
+static struct cache_tree *active_cache_tree;
 
-			subdir_written = write_tree(cachep + nr, maxentries - nr, pathname, dirname-pathname+1, subdir_sha1);
-			nr += subdir_written;
-
-			/* Now we need to write out the directory entry into this tree.. */
-			mode = S_IFDIR;
-			pathlen = dirname - pathname;
-
-			/* ..but the directory entry doesn't count towards the total count */
-			nr--;
-			sha1 = subdir_sha1;
-		}
-
-		if (!missing_ok && check_valid_sha1(sha1) < 0)
-			exit(1);
-
-		entrylen = pathlen - baselen;
-		if (offset + entrylen + 100 > size) {
-			size = alloc_nr(offset + entrylen + 100);
-			buffer = xrealloc(buffer, size);
-		}
-		offset += sprintf(buffer + offset, "%o %.*s", mode, entrylen, filename);
-		buffer[offset++] = 0;
-		memcpy(buffer + offset, sha1, 20);
-		offset += 20;
-		nr++;
-	}
-
-	write_sha1_file(buffer, offset, tree_type, returnsha1);
-	free(buffer);
-	return nr;
-}
+static int missing_ok = 0;
 
 static const char write_tree_usage[] = "git-write-tree [--missing-ok]";
 
 int main(int argc, char **argv)
 {
-	int i, funny;
 	int entries;
-	unsigned char sha1[20];
 	
 	setup_git_directory();
 
-	entries = read_cache();
+	entries = read_cache_1(active_cache_sha1);
+	active_cache_tree = read_cache_tree(active_cache_sha1);
 	if (argc == 2) {
 		if (!strcmp(argv[1], "--missing-ok"))
 			missing_ok = 1;
@@ -108,51 +35,11 @@ int main(int argc, char **argv)
 	if (entries < 0)
 		die("git-write-tree: error reading cache");
 
-	/* Verify that the tree is merged */
-	funny = 0;
-	for (i = 0; i < entries; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce)) {
-			if (10 < ++funny) {
-				fprintf(stderr, "...\n");
-				break;
-			}
-			fprintf(stderr, "%s: unmerged (%s)\n", ce->name, sha1_to_hex(ce->sha1));
-		}
-	}
-	if (funny)
-		die("git-write-tree: not able to write tree");
-
-	/* Also verify that the cache does not have path and path/file
-	 * at the same time.  At this point we know the cache has only
-	 * stage 0 entries.
-	 */
-	funny = 0;
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
-	if (funny)
-		die("git-write-tree: not able to write tree");
+	if (cache_tree_update(active_cache_tree, active_cache, active_nr,
+			      missing_ok))
+		die("git-write-tree: error building trees");
+	write_cache_tree(active_cache_sha1, active_cache_tree);
 
-	/* Ok, write it out */
-	if (write_tree(active_cache, entries, "", 0, sha1) != entries)
-		die("git-write-tree: internal error");
-	printf("%s\n", sha1_to_hex(sha1));
+	printf("%s\n", sha1_to_hex(active_cache_tree->sha1));
 	return 0;
 }
-- 
1.3.0.g623a
