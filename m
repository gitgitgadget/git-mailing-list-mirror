From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 01/22] introduce facility to walk through the active cache
Date: Mon, 12 Sep 2005 10:55:45 -0400
Message-ID: <20050912145545.28120.61764.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:00:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjq-0000SG-F3
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVILO4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVILOzy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:55:54 -0400
Received: from citi.umich.edu ([141.211.133.111]:6319 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751289AbVILOzp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:55:45 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 95E061BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:55:45 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8394>

Introduce a mechanism that allows functions to walk through entries
in the active cache in order and execute an function on each entry.

We also introduce the concept of "cache cursor".  A cursor is simply
a type-independent way of referring to a unique position in the cache.
The cache is strongly ordered, so cursors also provide a type-
independent way of exposing the ordering of the cache positions:
ie next, previous, and eof?

This facility makes no changes to struct cache_entry, which also
happens to be the on-disk format of a cache entry.  By mmapping the
file that contains the cache entries, no data copying is required
to read in the cache.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 cache.h |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -130,6 +130,12 @@ static inline unsigned int create_ce_mod
 extern struct cache_entry **active_cache;
 extern unsigned int active_nr, active_alloc, active_cache_changed;
 
+struct cache_cursor {
+	int pos;
+};
+
+typedef int (*cache_iterator_fn_t) (struct cache_cursor *cc, struct cache_entry *ce);
+
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
@@ -273,6 +279,75 @@ static inline void *xcalloc(size_t nmemb
 	return ret;
 }
 
+static inline void init_cc(struct cache_cursor *cc)
+{
+	cc->pos = 0;
+}
+
+static inline void next_cc(struct cache_cursor *cc)
+{
+	cc->pos++;
+}
+
+static inline void prev_cc(struct cache_cursor *cc)
+{
+	cc->pos--;
+}
+
+static inline struct cache_entry *cc_to_ce(struct cache_cursor *cc)
+{
+	return active_cache[cc->pos];
+}
+
+static inline void set_ce_at_cursor(struct cache_cursor *cc, struct cache_entry *new)
+{
+	active_cache[cc->pos] = new;
+	active_cache_changed = 1;
+}
+
+static inline int cache_empty(void)
+{
+	return active_cache == NULL;
+}
+
+static inline int cache_eof(struct cache_cursor *cc)
+{
+	if (cc->pos < active_nr)
+		return 0;
+	return -1;
+}
+
+static inline int read_cache_needed(void)
+{
+	return cache_empty();
+}
+
+static inline void next_name(struct cache_cursor *cc, struct cache_entry *ce)
+{
+	do {
+		next_cc(cc);
+	} while (!cache_eof(cc) && ce_same_name(ce, cc_to_ce(cc)));
+}
+
+/*
+ * Walk the entire active cache, invoking "func" on each entry
+ *
+ * "func" is responsible for updating the cache_cursor.  To break
+ * out of the loop, "func" can return a negative result.
+ */
+static inline int walk_cache(cache_iterator_fn_t func)
+{
+	struct cache_cursor cc;
+
+	init_cc(&cc);
+	while (!cache_eof(&cc)) {
+		int status = func(&cc, cc_to_ce(&cc));
+		if (status < 0)
+			return status;
+	}
+	return 0;
+}
+
 struct checkout {
 	const char *base_dir;
 	int base_dir_len;
