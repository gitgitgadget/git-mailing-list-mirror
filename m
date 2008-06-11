From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 06/10] Move read_cache_unmerged() to read-cache.c
Date: Wed, 11 Jun 2008 22:50:30 +0200
Message-ID: <50a291213098f6da9869354c5ede54c2695570a8.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
 <4818a0b71b7f6b44ef49621045a5871458ba5c38.1213217187.git.vmiklos@frugalware.org>
 <dedcc8309fed3282df455bec7fbc9d0f8275b74b.1213217187.git.vmiklos@frugalware.org>
 <9a5a141bd92756b529514579818a2c59a1a03899.1213217187.git.vmiklos@frugalware.org>
 <c72207b02d37f3d8c064534264219f4dd38c7559.1213217187.git.vmiklos@frugalware.org>
 <7b7cdd9349feee76ad97243df807f8f360484083.1213217187.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 22:53:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XIr-0000Zk-UQ
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 22:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbYFKUut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 16:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYFKUus
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 16:50:48 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:32881 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbYFKUuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 16:50:37 -0400
Received: from vmobile.example.net (dsl5401C482.pool.t-online.hu [84.1.196.130])
	by yugo.frugalware.org (Postfix) with ESMTP id 8BC8E1DDC61
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 22:50:32 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B4AAE18DFE0; Wed, 11 Jun 2008 22:50:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <7b7cdd9349feee76ad97243df807f8f360484083.1213217187.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84657>

builtin-read-tree has a read_cache_unmerged() which is useful for other
builtins, for example builtin-merge uses it as well. Move it to
read-cache.c to avoid code duplication.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-read-tree.c |   24 ------------------------
 cache.h             |    2 ++
 read-cache.c        |   31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 5a09e17..72a6de3 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -29,30 +29,6 @@ static int list_tree(unsigned char *sha1)
 	return 0;
 }
 
-static int read_cache_unmerged(void)
-{
-	int i;
-	struct cache_entry **dst;
-	struct cache_entry *last = NULL;
-
-	read_cache();
-	dst = active_cache;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce)) {
-			remove_name_hash(ce);
-			if (last && !strcmp(ce->name, last->name))
-				continue;
-			cache_tree_invalidate_path(active_cache_tree, ce->name);
-			last = ce;
-			continue;
-		}
-		*dst++ = ce;
-	}
-	active_nr = dst - active_cache;
-	return !!last;
-}
-
 static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 {
 	struct tree_desc desc;
diff --git a/cache.h b/cache.h
index 18ec38c..54368cc 100644
--- a/cache.h
+++ b/cache.h
@@ -254,6 +254,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 
 #define read_cache() read_index(&the_index)
 #define read_cache_from(path) read_index_from(&the_index, (path))
+#define read_cache_unmerged() read_index_unmerged(&the_index)
 #define write_cache(newfd, cache, entries) write_index(&the_index, (newfd))
 #define discard_cache() discard_index(&the_index)
 #define unmerged_cache() unmerged_index(&the_index)
@@ -357,6 +358,7 @@ extern int init_db(const char *template_dir, unsigned int flags);
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
 extern int read_index_from(struct index_state *, const char *path);
+extern int read_index_unmerged(struct index_state *);
 extern int write_index(const struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
diff --git a/read-cache.c b/read-cache.c
index 8e5fbb6..ea23726 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1394,3 +1394,34 @@ int write_index(const struct index_state *istate, int newfd)
 	}
 	return ce_flush(&c, newfd);
 }
+
+/*
+ * Read the index file that is potentially unmerged into given
+ * index_state, dropping any unmerged entries.  Returns true is
+ * the index is unmerged.  Callers who want to refuse to work
+ * from an unmerged state can call this and check its return value,
+ * instead of calling read_cache().
+ */
+int read_index_unmerged(struct index_state *istate)
+{
+	int i;
+	struct cache_entry **dst;
+	struct cache_entry *last = NULL;
+
+	read_index(istate);
+	dst = istate->cache;
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (ce_stage(ce)) {
+			remove_name_hash(ce);
+			if (last && !strcmp(ce->name, last->name))
+				continue;
+			cache_tree_invalidate_path(istate->cache_tree, ce->name);
+			last = ce;
+			continue;
+		}
+		*dst++ = ce;
+	}
+	istate->cache_nr = dst - istate->cache;
+	return !!last;
+}
-- 
1.5.6.rc2.dirty
