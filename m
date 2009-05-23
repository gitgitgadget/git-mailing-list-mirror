From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] write-tree --ignore-cache-tree
Date: Sat, 23 May 2009 12:24:34 -0700
Message-ID: <1243106678-6343-2-git-send-email-gitster@pobox.com>
References: <1243106678-6343-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wpv-0001xr-6W
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbZEWTYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbZEWTYn
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:24:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbZEWTYm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B59FC1914A
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:24:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2D58D19149 for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:42 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243106678-6343-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5DED405A-47CF-11DE-8A39-B4FDD46C8AFF-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119790>

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
1.6.3.1.145.gb74d77
