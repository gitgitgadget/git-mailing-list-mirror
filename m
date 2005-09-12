From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 09/22] teach read-tree.c to use cache iterators
Date: Mon, 12 Sep 2005 10:56:03 -0400
Message-ID: <20050912145602.28120.31547.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 16:59:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjr-0000SG-1D
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVILO4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVILO4o
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:44 -0400
Received: from citi.umich.edu ([141.211.133.111]:62619 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751295AbVILO4D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:03 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 089021BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:03 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8384>

Merging will wait for another patch.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 read-tree.c |   66 +++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -233,7 +233,7 @@ static void reject_merge(struct cache_en
 	    ce->name);
 }
 
-static void check_updates(struct cache_entry **src, int nr)
+static int check_one_out(struct cache_cursor *cc, struct cache_entry *ce)
 {
 	static struct checkout state = {
 		.base_dir = "",
@@ -242,19 +242,21 @@ static void check_updates(struct cache_e
 		.refresh_cache = 1,
 	};
 	unsigned short mask = htons(CE_UPDATE);
-	while (nr--) {
-		struct cache_entry *ce = *src++;
-		if (!ce->ce_mode) {
-			if (update)
-				unlink(ce->name);
-			continue;
-		}
-		if (ce->ce_flags & mask) {
-			ce->ce_flags &= ~mask;
-			if (update)
-				checkout_entry(ce, &state);
-		}
+
+	if (!ce->ce_mode) {
+		if (update)
+			unlink(ce->name);
+		goto out;
 	}
+
+	if (ce->ce_flags & mask) {
+		ce->ce_flags &= ~mask;
+		if (update)
+			checkout_entry(ce, &state);
+	}
+out:
+	next_cc(cc);
+	return 0;
 }
 
 static int unpack_trees(merge_fn_t fn)
@@ -273,7 +275,7 @@ static int unpack_trees(merge_fn_t fn)
 	if (unpack_trees_rec(posns, len, "", fn, &indpos))
 		return -1;
 
-	check_updates(active_cache, active_nr);
+	walk_cache(check_one_out);
 	return 0;
 }
 
@@ -553,24 +555,30 @@ static int oneway_merge(struct cache_ent
 	return merged_entry(a, NULL);
 }
 
-static int read_cache_unmerged(void)
+static int deleted = 0;
+static struct cache_cursor dst;
+
+static int read_one_unmerged(struct cache_cursor *cc, struct cache_entry *ce)
 {
-	int i, deleted;
-	struct cache_entry **dst;
+	if (ce_stage(ce)) {
+		deleted++;
+		goto out;
+	}
+	if (deleted)
+		set_ce_at_cursor(&dst, ce);
+	next_cc(&dst);
+out:
+	next_cc(cc);
+	return 0;
+}
 
-	read_cache();
-	dst = active_cache;
-	deleted = 0;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce)) {
-			deleted++;
-			continue;
-		}
-		if (deleted)
-			*dst = ce;
-		dst++;
+static int read_cache_unmerged(void)
+{
+	if (read_cache() > 0) {
+		init_cc(&dst);
+		walk_cache(read_one_unmerged);
 	}
+
 	active_nr -= deleted;
 	return deleted;
 }
