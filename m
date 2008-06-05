From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 06/10] Move read_cache_unmerged() to read-cache.c
Date: Thu,  5 Jun 2008 22:44:32 +0200
Message-ID: <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org>
 <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
 <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org>
 <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org>
 <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 22:45:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MKt-000606-B3
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbYFEUoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbYFEUod
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:44:33 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:60242 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbYFEUoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:44:32 -0400
Received: from vmobile.example.net (dsl5401CC68.pool.t-online.hu [84.1.204.104])
	by yugo.frugalware.org (Postfix) with ESMTP id 524EE1DDC5C
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 22:44:29 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B367918E2A7; Thu,  5 Jun 2008 22:44:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83968>

builtin-read-tree has a read_cache_unmerged() which is useful for other
builtins, for example builtin-merge uses it as well. Move it to
read-cache.c to avoid code duplication.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-read-tree.c |   24 ------------------------
 cache.h             |    2 ++
 read-cache.c        |   24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 24 deletions(-)

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
index e342ad3..df0ac56 100644
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
index 8e5fbb6..197160c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1394,3 +1394,27 @@ int write_index(const struct index_state *istate, int newfd)
 	}
 	return ce_flush(&c, newfd);
 }
+
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
1.5.6.rc0.dirty
