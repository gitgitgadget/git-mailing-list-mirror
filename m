From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 10/22] teach update-index.c about cache cursors
Date: Mon, 12 Sep 2005 10:56:05 -0400
Message-ID: <20050912145605.28120.174.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:03:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEplt-0001hk-0G
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVILO4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVILO4n
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:43 -0400
Received: from citi.umich.edu ([141.211.133.111]:56 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751297AbVILO4F (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:05 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 3A4BF1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:05 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8400>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 update-index.c |   62 +++++++++++++++++++++++++-------------------------------
 1 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/update-index.c b/update-index.c
--- a/update-index.c
+++ b/update-index.c
@@ -13,7 +13,7 @@
  * files be revision controlled.
  */
 static int allow_add = 0, allow_remove = 0, allow_replace = 0, not_new = 0, quiet = 0, info_only = 0;
-static int force_remove;
+static int force_remove, has_errors = 0;
 
 /* Three functions to allow overloaded pointer return; see linux/err.h */
 static inline void *ERR_PTR(long error)
@@ -190,41 +190,35 @@ static struct cache_entry *refresh_entry
 	return updated;
 }
 
-static int refresh_cache(void)
+static int refresh_one(struct cache_cursor *cc, struct cache_entry *ce)
 {
-	int i;
-	int has_errors = 0;
+	struct cache_entry *new;
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce, *new;
-		ce = active_cache[i];
-		if (ce_stage(ce)) {
-			printf("%s: needs merge\n", ce->name);
-			has_errors = 1;
-			while ((i < active_nr) &&
-			       ! strcmp(active_cache[i]->name, ce->name))
-				i++;
-			i--;
-			continue;
-		}
+	if (ce_stage(ce)) {
+		printf("%s: needs merge\n", ce->name);
+		has_errors = 1;
+		next_name(cc, ce);
+		return 0;
+	}
 
-		new = refresh_entry(ce);
-		if (IS_ERR(new)) {
-			if (not_new && PTR_ERR(new) == -ENOENT)
-				continue;
-			if (quiet)
-				continue;
-			printf("%s: needs update\n", ce->name);
-			has_errors = 1;
-			continue;
-		}
-		active_cache_changed = 1;
-		/* You can NOT just free active_cache[i] here, since it
-		 * might not be necessarily malloc()ed but can also come
-		 * from mmap(). */
-		active_cache[i] = new;
+	new = refresh_entry(ce);
+	if (IS_ERR(new)) {
+		if (not_new && PTR_ERR(new) == -ENOENT)
+			return 0;
+		if (quiet)
+			return 0;
+		printf("%s: needs update\n", ce->name);
+		has_errors = 1;
+		next_cc(cc);
+		return 0;
 	}
-	return has_errors;
+
+	/* You can NOT just free active_cache[i] here, since it
+	 * might not be necessarily malloc()ed but can also come
+	 * from mmap(). */
+	set_ce_at_cursor(cc, new);
+	next_cc(cc);
+	return 0;
 }
 
 /*
@@ -323,7 +317,7 @@ static struct cache_file cache_file;
 
 int main(int argc, char **argv)
 {
-	int i, newfd, entries, has_errors = 0;
+	int i, newfd, entries;
 	int allow_options = 1;
 	const char *prefix = setup_git_directory();
 
@@ -360,7 +354,7 @@ int main(int argc, char **argv)
 				continue;
 			}
 			if (!strcmp(path, "--refresh")) {
-				has_errors |= refresh_cache();
+				walk_cache(refresh_one);
 				continue;
 			}
 			if (!strcmp(path, "--cacheinfo")) {
