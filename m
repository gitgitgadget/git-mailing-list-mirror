From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Small cache_tree_write refactor.
Date: Tue, 25 Sep 2007 10:22:44 +0200
Message-ID: <20070925082341.DF412BDBCF@madism.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 10:23:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia5hx-000449-13
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 10:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbXIYIXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 04:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754421AbXIYIXp
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 04:23:45 -0400
Received: from pan.madism.org ([88.191.52.104]:47891 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330AbXIYIXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 04:23:44 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BC49320DF9;
	Tue, 25 Sep 2007 10:23:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DF412BDBCF; Tue, 25 Sep 2007 10:23:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59101>

This function cannot fail, make it void. Also make write_one act on a
const char* instead of a char*.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 cache-tree.c |   19 +++++--------------
 cache-tree.h |    2 +-
 read-cache.c |   19 +++++++++----------
 3 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 5471844..50b3526 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -369,10 +369,8 @@ int cache_tree_update(struct cache_tree *it,
 	return 0;
 }
 
-static void write_one(struct cache_tree *it,
-		       char *path,
-		       int pathlen,
-			   struct strbuf *buffer)
+static void write_one(struct strbuf *buffer, struct cache_tree *it,
+                      const char *path, int pathlen)
 {
 	int i;
 
@@ -407,20 +405,13 @@ static void write_one(struct cache_tree *it,
 					     prev->name, prev->namelen) <= 0)
 				die("fatal - unsorted cache subtree");
 		}
-		write_one(down->cache_tree, down->name, down->namelen, buffer);
+		write_one(buffer, down->cache_tree, down->name, down->namelen);
 	}
 }
 
-void *cache_tree_write(struct cache_tree *root, unsigned long *size_p)
+void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
 {
-	char path[PATH_MAX];
-	struct strbuf buffer;
-
-	path[0] = 0;
-	strbuf_init(&buffer, 0);
-	write_one(root, path, 0, &buffer);
-	*size_p = buffer.len;
-	return strbuf_detach(&buffer);
+	write_one(sb, root, "", 0);
 }
 
 static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
diff --git a/cache-tree.h b/cache-tree.h
index 119407e..8243228 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -22,7 +22,7 @@ void cache_tree_free(struct cache_tree **);
 void cache_tree_invalidate_path(struct cache_tree *, const char *);
 struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
-void *cache_tree_write(struct cache_tree *root, unsigned long *size_p);
+void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct cache_tree *);
diff --git a/read-cache.c b/read-cache.c
index 2e40a34..56202d1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1136,7 +1136,7 @@ int write_index(struct index_state *istate, int newfd)
 {
 	SHA_CTX c;
 	struct cache_header hdr;
-	int i, removed;
+	int i, err, removed;
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
 
@@ -1165,16 +1165,15 @@ int write_index(struct index_state *istate, int newfd)
 
 	/* Write extension data here */
 	if (istate->cache_tree) {
-		unsigned long sz;
-		void *data = cache_tree_write(istate->cache_tree, &sz);
-		if (data &&
-		    !write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sz) &&
-		    !ce_write(&c, newfd, data, sz))
-			free(data);
-		else {
-			free(data);
+		struct strbuf sb;
+
+		strbuf_init(&sb, 0);
+		cache_tree_write(&sb, istate->cache_tree);
+		err = write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
 			return -1;
-		}
 	}
 	return ce_flush(&c, newfd);
 }
-- 
1.5.3.2.1067.g96579-dirty
