From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] write-tree --ignore-cache-tree
Date: Wed, 20 May 2009 11:27:00 -0700
Message-ID: <7vws8by6iz.fsf_-_@alter.siamese.dyndns.org>
References: <4A136C40.6020808@workspacewhiz.com>
	<alpine.LFD.2.00.0905192300070.3906@xanadu.home>
	<20090520032139.GB10212@coredump.intra.peff.net>
	<7vfxezzms0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 20:27:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6qVP-00024V-I5
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 20:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336AbZETS1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 14:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757047AbZETS1B
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 14:27:01 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:38064 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284AbZETS1A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 14:27:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090520182700.OGXZ20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 20 May 2009 14:27:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id tuT01b00K4aMwMQ04uT0AG; Wed, 20 May 2009 14:27:00 -0400
X-Authority-Analysis: v=1.0 c=1 a=ItkmbZzr63UA:10 a=ybZZDoGAAAAA:8
 a=TXeMdq_-1xpzmxTPSVYA:9 a=UCCZSQ7IcqfP4DFneg4A:7
 a=34ZOVdVTwg1I9hf5t8aCN9lcb3AA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7vfxezzms0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 20 May 2009 10\:50\:39 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119629>

This allows you to discard the cache-tree information before writing the
tree out of the index (i.e. it always recomputes the tree object names for
all the subtrees).

This is only useful as a debug option, so I did not bother documenting it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-write-tree.c |   12 +++++++++---
 cache-tree.c         |   10 +++++++---
 cache-tree.h         |    7 ++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 9d64050..3a24ce8 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -13,7 +13,7 @@ static const char write_tree_usage[] =
 
 int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 {
-	int missing_ok = 0, ret;
+	int flags = 0, ret;
 	const char *prefix = NULL;
 	unsigned char sha1[20];
 	const char *me = "git-write-tree";
@@ -22,9 +22,15 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--missing-ok"))
-			missing_ok = 1;
+			flags |= WRITE_TREE_MISSING_OK;
 		else if (!prefixcmp(arg, "--prefix="))
 			prefix = arg + 9;
+		else if (!prefixcmp(arg, "--ignore-cache-tree"))
+			/*
+			 * This is only useful for debugging, so I
+			 * do not bother documenting it.
+			 */
+			flags |= WRITE_TREE_IGNORE_CACHE_TREE;
 		else
 			usage(write_tree_usage);
 		argc--; argv++;
@@ -33,7 +39,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	if (argc > 2)
 		die("too many options");
 
-	ret = write_cache_as_tree(sha1, missing_ok, prefix);
+	ret = write_cache_as_tree(sha1, flags, prefix);
 	switch (ret) {
 	case 0:
 		printf("%s\n", sha1_to_hex(sha1));
diff --git a/cache-tree.c b/cache-tree.c
index 37bf35e..6dd8411 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -538,28 +538,32 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 	return it;
 }
 
-int write_cache_as_tree(unsigned char *sha1, int missing_ok, const char *prefix)
+int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 {
 	int entries, was_valid, newfd;
+	struct lock_file *lock_file;
 
 	/*
 	 * We can't free this memory, it becomes part of a linked list
 	 * parsed atexit()
 	 */
-	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	newfd = hold_locked_index(lock_file, 1);
 
 	entries = read_cache();
 	if (entries < 0)
 		return WRITE_TREE_UNREADABLE_INDEX;
+	if (flags & WRITE_TREE_IGNORE_CACHE_TREE)
+		cache_tree_free(&(active_cache_tree));
 
 	if (!active_cache_tree)
 		active_cache_tree = cache_tree();
 
 	was_valid = cache_tree_fully_valid(active_cache_tree);
-
 	if (!was_valid) {
+		int missing_ok = flags & WRITE_TREE_MISSING_OK;
+
 		if (cache_tree_update(active_cache_tree,
 				      active_cache, active_nr,
 				      missing_ok, 0) < 0)
diff --git a/cache-tree.h b/cache-tree.h
index e958835..eadcad8 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -30,11 +30,16 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int, int);
 
+/* bitmasks to write_cache_as_tree flags */
+#define WRITE_TREE_MISSING_OK 1
+#define WRITE_TREE_IGNORE_CACHE_TREE 2
+
+/* error return codes */
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
 #define WRITE_TREE_UNMERGED_INDEX (-2)
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
-int write_cache_as_tree(unsigned char *sha1, int missing_ok, const char *prefix);
+int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix);
 void prime_cache_tree(struct cache_tree **, struct tree *);
 
 #endif
-- 
1.6.3.1.56.gd00e3.dirty
