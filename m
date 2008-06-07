From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Move read_cache_unmerged() to read-cache.c
Date: Sat,  7 Jun 2008 03:00:45 +0200
Message-ID: <1212800445-4365-1-git-send-email-vmiklos@frugalware.org>
References: <7vhcc7zdm5.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 03:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4mop-00082R-RG
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 03:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbYFGBAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 21:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbYFGBAo
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 21:00:44 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36313 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbYFGBAo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 21:00:44 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 57BE31DDC5B
	for <git@vger.kernel.org>; Sat,  7 Jun 2008 03:00:42 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7AD0318E2A7; Sat,  7 Jun 2008 03:00:45 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <7vhcc7zdm5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84161>

builtin-read-tree has a read_cache_unmerged() which is useful for other
builtins, for example builtin-merge uses it as well. Move it to
read-cache.c to avoid code duplication.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Jun 05, 2008 at 04:05:54PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Looks good, but as a public interface probably it needs a few lines of
> comment in front of the function's definition to describe what it is
> used
> for.  Perhaps like...
>
> /*
>  * Read the index file that is potentially unmerged into given
>  * index_state, dropping any unmerged entries.  Returns true is
>  * the index is unmerged.  Callers who want to refuse to work
>  * from an unmerged state can call this and check its return value,
>  * instead of calling read_cache().
>  */

Added. I'm sending the patch I just pushed to my working branch.

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
1.5.6.rc0.dirty
