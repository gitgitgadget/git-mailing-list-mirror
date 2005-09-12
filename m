From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 20/22] teach merge-index.c to use cache_find_name()
Date: Mon, 12 Sep 2005 10:56:27 -0400
Message-ID: <20050912145627.28120.80905.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:03:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEplu-0001hk-Lp
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVILO5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVILO4q
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:46 -0400
Received: from citi.umich.edu ([141.211.133.111]:53254 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751301AbVILO41 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:27 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 2DDB31BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:27 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8401>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 merge-index.c |   44 +++++++++++++++++++++-----------------------
 1 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/merge-index.c b/merge-index.c
--- a/merge-index.c
+++ b/merge-index.c
@@ -37,11 +37,11 @@ static void run_program(void)
 	}
 }
 
-static int merge_entry(int pos, const char *path)
+static void merge_entry(struct cache_cursor *cc, const char *path)
 {
 	int found;
 	
-	if (pos >= active_nr)
+	if (cache_eof(cc))
 		die("git-merge-index: %s not in the cache", path);
 	arguments[0] = pgm;
 	arguments[1] = "";
@@ -55,7 +55,7 @@ static int merge_entry(int pos, const ch
 	do {
 		static char hexbuf[4][60];
 		static char ownbuf[4][60];
-		struct cache_entry *ce = active_cache[pos];
+		struct cache_entry *ce = cc_to_ce(cc);
 		int stage = ce_stage(ce);
 
 		if (strcmp(ce->name, path))
@@ -65,34 +65,31 @@ static int merge_entry(int pos, const ch
 		sprintf(ownbuf[stage], "%o", ntohl(ce->ce_mode) & (~S_IFMT));
 		arguments[stage] = hexbuf[stage];
 		arguments[stage + 4] = ownbuf[stage];
-	} while (++pos < active_nr);
+		next_cc(cc);
+	} while (!cache_eof(cc));
 	if (!found)
 		die("git-merge-index: %s not in the cache", path);
 	run_program();
-	return found;
 }
 
+/*
+ * If it already exists in the cache as stage0, it's
+ * already merged and there is nothing to do.
+ */
 static void merge_file(const char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
-
-	/*
-	 * If it already exists in the cache as stage0, it's
-	 * already merged and there is nothing to do.
-	 */
-	if (pos < 0)
-		merge_entry(-pos-1, path);
+	struct cache_cursor cc;
+	if (!cache_find_name(path, strlen(path), &cc))
+		merge_entry(&cc, path);
 }
 
-static void merge_all(void)
+static int merge_one(struct cache_cursor *cc, struct cache_entry *ce)
 {
-	int i;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (!ce_stage(ce))
-			continue;
-		i += merge_entry(i, ce->name)-1;
-	}
+	if (ce_stage(ce))
+		merge_entry(cc, ce->name);
+	else
+		next_cc(cc);
+	return 0;
 }
 
 int main(int argc, char **argv)
@@ -102,7 +99,8 @@ int main(int argc, char **argv)
 	if (argc < 3)
 		usage("git-merge-index [-o] [-q] <merge-program> (-a | <filename>*)");
 
-	read_cache();
+	if (read_cache() < 0)
+		die("unable to read index file");
 
 	i = 1;
 	if (!strcmp(argv[i], "-o")) {
@@ -122,7 +120,7 @@ int main(int argc, char **argv)
 				continue;
 			}
 			if (!strcmp(arg, "-a")) {
-				merge_all();
+				walk_cache(merge_one);
 				continue;
 			}
 			die("git-merge-index: unknown option %s", arg);
