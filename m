From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 09/19] migrate read-tree.c to the new cache api's
Date: Thu, 21 Apr 2005 11:36:44 -0700
Message-ID: <200504211836.j3LIaiXh027569@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:34:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgU5-00084h-WB
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVDUShZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVDUShY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:37:24 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:33672 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261670AbVDUSgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:36:47 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIagFm027944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:36:43 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIaiGR027571
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:36:44 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIaiXh027569
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:36:44 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 7a3cab4437a849857cc899017b97eea1787a6ce1
parent 099367f98cc063c33733d15c7a2d9737bea853d9
author Brad Roberts <braddr@puremagic.com> 1114077044 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114077044 -0700

[PATCH] migrate read-tree.c to the new cache api's

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 read-tree.c |   52 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 31 insertions(+), 21 deletions(-)

Index: read-tree.c
===================================================================
--- 099367f98cc063c33733d15c7a2d9737bea853d9:1/read-tree.c  (mode:100644 sha1:4ad48f5c409ead69407d2b5feab4466cdcb499f8)
+++ 50a6596bf7f51ecd598cd02d9c44379a9b92044a:1/read-tree.c  (mode:100644 sha1:ad9128f26613a82361475516dd0f2b470f4ce4b3)
@@ -146,26 +146,30 @@
 	return NULL;
 }
 
-static void trivially_merge_cache(struct cache_entry **src, int nr)
+/* rather than doing the 'right' thing of deleting entries as we merge,
+ * walk dst through the cache, overwriting entries as we go and at the
+ * end truncate the size of the cache */
+static void trivially_merge_cache()
 {
 	static struct cache_entry null_entry;
-	struct cache_entry **dst = src;
 	struct cache_entry *old = &null_entry;
+	int src = 0, dst = 0, nr = get_num_cache_entries();
 
-	while (nr) {
+	while (src < nr) {
 		struct cache_entry *ce, *result;
 
-		ce = src[0];
+		ce = get_cache_entry(src);
 
 		/* We throw away original cache entries except for the stat information */
 		if (!ce_stage(ce)) {
 			old = ce;
 			src++;
-			nr--;
-			active_nr--;
 			continue;
 		}
-		if (nr > 2 && (result = merge_entries(ce, src[1], src[2])) != NULL) {
+		if ((src < (nr - 2)) &&
+		    (result = merge_entries(ce,
+					    get_cache_entry(src + 1),
+					    get_cache_entry(src + 2))) != NULL) {
 			/*
 			 * See if we can re-use the old CE directly?
 			 * That way we get the uptodate stat info.
@@ -175,40 +179,46 @@
 			ce = result;
 			ce->ce_flags &= ~htons(CE_STAGEMASK);
 			src += 2;
-			nr -= 2;
-			active_nr -= 2;
 		}
-		*dst++ = ce;
+		set_cache_entry(ce, dst);
+		dst++;
 		src++;
+	}
+	/* this could be replaced by a truncate api */
+	while (nr > dst) {
 		nr--;
+		remove_cache_entry_at(nr);
 	}
 }
 
-static void merge_stat_info(struct cache_entry **src, int nr)
+static void merge_stat_info()
 {
 	static struct cache_entry null_entry;
-	struct cache_entry **dst = src;
 	struct cache_entry *old = &null_entry;
+	int src = 0, dst = 0, nr = get_num_cache_entries();
 
-	while (nr) {
+	while (src < nr) {
 		struct cache_entry *ce;
 
-		ce = src[0];
+		ce = get_cache_entry(src);
 
 		/* We throw away original cache entries except for the stat information */
 		if (!ce_stage(ce)) {
 			old = ce;
 			src++;
-			nr--;
-			active_nr--;
 			continue;
 		}
 		if (path_matches(ce, old) && same(ce, old))
 			*ce = *old;
 		ce->ce_flags &= ~htons(CE_STAGEMASK);
-		*dst++ = ce;
+		set_cache_entry(ce, dst);
+		dst++;
 		src++;
+	}
+	/* this could be replaced by a truncate api */
+	while (nr > dst) {
 		nr--;
+		remove_cache_entry_at(nr);
 	}
 }
 
@@ -233,8 +243,8 @@
 			if (stage)
 				usage("-m needs to come first");
 			read_cache();
-			for (i = 0; i < active_nr; i++) {
-				if (ce_stage(active_cache[i]))
+			for (i = 0; i < get_num_cache_entries(); i++) {
+				if (ce_stage(get_cache_entry(i)))
 					usage("you need to resolve your current index first");
 			}
 			stage = 1;
@@ -252,10 +262,10 @@
 	if (merge) {
 		switch (stage) {
 		case 4:	/* Three-way merge */
-			trivially_merge_cache(active_cache, active_nr);
+			trivially_merge_cache();
 			break;
 		case 2:	/* Just read a tree, merge with old cache contents */
-			merge_stat_info(active_cache, active_nr);
+			merge_stat_info();
 			break;
 		default:
 			die("just how do you expect me to merge %d trees?", stage-1);

