From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 7/7] More strbuf uses in cache-tree.c.
Date: Thu,  6 Sep 2007 13:20:11 +0200
Message-ID: <11890776111167-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
 <11890776114037-git-send-email-madcoder@debian.org>
 <118907761140-git-send-email-madcoder@debian.org>
 <11890776111843-git-send-email-madcoder@debian.org>
 <11890776112292-git-send-email-madcoder@debian.org>
 <11890776111670-git-send-email-madcoder@debian.org>
 <11890776112309-git-send-email-madcoder@debian.org>
 <11890776112641-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 13:20:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITFPo-0008PZ-8S
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 13:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbXIFLUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 07:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXIFLUb
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 07:20:31 -0400
Received: from pan.madism.org ([88.191.52.104]:52617 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbXIFLUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 07:20:19 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6F4311E406;
	Thu,  6 Sep 2007 13:20:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id EAAC31A3C4; Thu,  6 Sep 2007 13:20:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11890776112641-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Should even be marginally faster.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 cache-tree.c |   59 +++++++++++++++++++++------------------------------------
 1 files changed, 22 insertions(+), 37 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 077f034..76af6f5 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "strbuf.h"
 #include "tree.h"
 #include "cache-tree.h"
 
@@ -235,8 +236,7 @@ static int update_one(struct cache_tree *it,
 		      int missing_ok,
 		      int dryrun)
 {
-	unsigned long size, offset;
-	char *buffer;
+	struct strbuf buffer;
 	int i;
 
 	if (0 <= it->entry_count && has_sha1_file(it->sha1))
@@ -293,9 +293,8 @@ static int update_one(struct cache_tree *it,
 	/*
 	 * Then write out the tree object for this level.
 	 */
-	size = 8192;
-	buffer = xmalloc(size);
-	offset = 0;
+	strbuf_init(&buffer);
+	strbuf_grow(&buffer, 8192);
 
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
@@ -332,15 +331,9 @@ static int update_one(struct cache_tree *it,
 		if (!ce->ce_mode)
 			continue; /* entry being removed */
 
-		if (size < offset + entlen + 100) {
-			size = alloc_nr(offset + entlen + 100);
-			buffer = xrealloc(buffer, size);
-		}
-		offset += sprintf(buffer + offset,
-				  "%o %.*s", mode, entlen, path + baselen);
-		buffer[offset++] = 0;
-		hashcpy((unsigned char*)buffer + offset, sha1);
-		offset += 20;
+		strbuf_grow(&buffer, entlen + 100);
+		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
+		strbuf_add(&buffer, sha1, 20);
 
 #if DEBUG
 		fprintf(stderr, "cache-tree update-one %o %.*s\n",
@@ -349,10 +342,10 @@ static int update_one(struct cache_tree *it,
 	}
 
 	if (dryrun)
-		hash_sha1_file(buffer, offset, tree_type, it->sha1);
+		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
 	else
-		write_sha1_file(buffer, offset, tree_type, it->sha1);
-	free(buffer);
+		write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
+	strbuf_release(&buffer);
 	it->entry_count = i;
 #if DEBUG
 	fprintf(stderr, "cache-tree update-one (%d ent, %d subtree) %s\n",
@@ -378,12 +371,10 @@ int cache_tree_update(struct cache_tree *it,
 	return 0;
 }
 
-static void *write_one(struct cache_tree *it,
+static void write_one(struct cache_tree *it,
 		       char *path,
 		       int pathlen,
-		       char *buffer,
-		       unsigned long *size,
-		       unsigned long *offset)
+			   struct strbuf *buffer)
 {
 	int i;
 
@@ -393,13 +384,9 @@ static void *write_one(struct cache_tree *it,
 	 * tree-sha1 (missing if invalid)
 	 * subtree_nr "cache-tree" entries for subtrees.
 	 */
-	if (*size < *offset + pathlen + 100) {
-		*size = alloc_nr(*offset + pathlen + 100);
-		buffer = xrealloc(buffer, *size);
-	}
-	*offset += sprintf(buffer + *offset, "%.*s%c%d %d\n",
-			   pathlen, path, 0,
-			   it->entry_count, it->subtree_nr);
+	strbuf_grow(buffer, pathlen + 100);
+	strbuf_add(buffer, path, pathlen);
+	strbuf_addf(buffer, "%c%d %d\n", 0, it->entry_count, it->subtree_nr);
 
 #if DEBUG
 	if (0 <= it->entry_count)
@@ -412,8 +399,7 @@ static void *write_one(struct cache_tree *it,
 #endif
 
 	if (0 <= it->entry_count) {
-		hashcpy((unsigned char*)buffer + *offset, it->sha1);
-		*offset += 20;
+		strbuf_add(buffer, it->sha1, 20);
 	}
 	for (i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *down = it->down[i];
@@ -423,21 +409,20 @@ static void *write_one(struct cache_tree *it,
 					     prev->name, prev->namelen) <= 0)
 				die("fatal - unsorted cache subtree");
 		}
-		buffer = write_one(down->cache_tree, down->name, down->namelen,
-				   buffer, size, offset);
+		write_one(down->cache_tree, down->name, down->namelen, buffer);
 	}
-	return buffer;
 }
 
 void *cache_tree_write(struct cache_tree *root, unsigned long *size_p)
 {
 	char path[PATH_MAX];
-	unsigned long size = 8192;
-	char *buffer = xmalloc(size);
+	struct strbuf buffer;
 
-	*size_p = 0;
 	path[0] = 0;
-	return write_one(root, path, 0, buffer, &size, size_p);
+	strbuf_init(&buffer);
+	write_one(root, path, 0, &buffer);
+	*size_p = buffer.len;
+	return strbuf_detach(&buffer);
 }
 
 static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
-- 
1.5.3.1
