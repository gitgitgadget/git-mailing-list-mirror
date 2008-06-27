From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 05/15] Move read_cache_unmerged() to read-cache.c
Date: Fri, 27 Jun 2008 18:21:58 +0200
Message-ID: <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
 <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGk7-0004E3-7v
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758181AbYF0QWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761142AbYF0QWg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:36 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45342 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760173AbYF0QWL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:11 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id A9F6E1DDC61;
	Fri, 27 Jun 2008 18:22:06 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 3604118E82D; Fri, 27 Jun 2008 18:22:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86583>

builtin-read-tree has a read_cache_unmerged() which is useful for other
builtins, for example builtin-merge uses it as well. Move it to
read-cache.c to avoid code duplication.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index d5463d8..7fb6c70 100644
--- a/cache.h
+++ b/cache.h
@@ -254,6 +254,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 
 #define read_cache() read_index(&the_index)
 #define read_cache_from(path) read_index_from(&the_index, (path))
+#define read_cache_unmerged() read_index_unmerged(&the_index)
 #define write_cache(newfd, cache, entries) write_index(&the_index, (newfd))
 #define discard_cache() discard_index(&the_index)
 #define unmerged_cache() unmerged_index(&the_index)
@@ -356,6 +357,7 @@ extern int init_db(const char *template_dir, unsigned int flags);
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
 extern int read_index_from(struct index_state *, const char *path);
+extern int read_index_unmerged(struct index_state *);
 extern int write_index(const struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
diff --git a/read-cache.c b/read-cache.c
index f83de8c..d801f9d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1410,3 +1410,34 @@ int write_index(const struct index_state *istate, int newfd)
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
1.5.6
