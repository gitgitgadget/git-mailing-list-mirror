From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 15/22] replace cache_name_pos
Date: Mon, 12 Sep 2005 10:56:16 -0400
Message-ID: <20050912145616.28120.30912.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 16:59:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjo-0000SG-LN
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVILO4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVILO4X
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:23 -0400
Received: from citi.umich.edu ([141.211.133.111]:37900 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751303AbVILO4Q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:16 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 42C2E1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:16 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8387>

Clean up: Introduce an interface to return a cache_cursor instead of
an integer.  Note we can also eliminate the need to overload the
return value of cache_name_pos to return a negative "pos" value to
signal an insertion point rather than a found entry.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 cache.h      |   13 +++++++++++++
 read-cache.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -160,6 +160,8 @@ extern int read_cache(void);
 extern int read_cache_unmerged(void);
 extern int write_cache(int newfd);
 extern int cache_name_pos(const char *name, int namelen);
+extern int cache_find_name(const char *name, int namelen, struct cache_cursor *cc);
+
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
@@ -350,6 +352,17 @@ static inline int walk_cache(cache_itera
 	return 0;
 }
 
+static inline int cache_find_entry(const char *name, int namelen, struct cache_entry **ce)
+{
+	struct cache_cursor cc;
+	int result;
+
+	result = cache_find_name(name, namelen, &cc);
+	if (ce)
+		*ce = active_cache[cc.pos];
+	return result;
+}
+
 struct checkout {
 	const char *base_dir;
 	int base_dir_len;
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -144,6 +144,50 @@ int cache_name_pos(const char *name, int
 	return -first-1;
 }
 
+/*
+ * Given a name, find the first cache entry that matches.  Returning 1
+ * means the cursor points to the cache entry with a matching name.
+ * Returning 0 means the name wasn't found, but the cursor points to an
+ * appropriate insertion point.
+ */
+int cache_find_name(const char *name, int namelen, struct cache_cursor *cc)
+{
+	int first, last;
+
+	/*
+	 * Look for the right name
+	 */
+	cc->pos = first = 0;
+	last = active_nr;
+	while (last > first) {
+		struct cache_entry *ce;
+		int cmp;
+		cc->pos = (last + first) >> 1;
+		ce = active_cache[cc->pos];
+		cmp = cache_name_compare(name, namelen, ce->name, ntohs(ce->ce_flags));
+		if (!cmp) {
+			/* found it */
+			return 1;
+		}
+		if (cmp < 0) {
+			/* next: search [first, cc->pos] */
+			last = cc->pos;
+			continue;
+		}
+		/* next: search [cc->pos + 1, last] */
+		first = cc->pos + 1;
+	}
+
+	/*
+	 * Name not found, so return an insertion point.
+	 *
+	 * On return, callers insert *before* the insertion point,
+	 * not after it, to maintain proper list order.
+	 */
+	cc->pos = first;
+	return 0;
+}
+
 /* Remove entry, return true if there are more entries to go.. */
 int remove_cache_entry_at(int pos)
 {
