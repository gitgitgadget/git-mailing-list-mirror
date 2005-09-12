From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 08/22] teach ls-files.c to use cache iterators
Date: Mon, 12 Sep 2005 10:56:00 -0400
Message-ID: <20050912145600.28120.86261.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 16:58:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjr-0000SG-JI
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVILO4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVILO4r
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:47 -0400
Received: from citi.umich.edu ([141.211.133.111]:5458 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751296AbVILO4B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:01 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id D12A71BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:00 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8383>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 ls-files.c |   58 +++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -414,14 +414,38 @@ static void show_ce_entry(const char *ta
 		       ce->name + offset, line_terminator); 
 }
 
-static void show_files(void)
+static int show_one_cached(struct cache_cursor *cc, struct cache_entry *ce)
 {
-	int i;
+	if (excluded(ce->name) != show_ignored)
+		goto out;
+	if (show_unmerged && !ce_stage(ce))
+		goto out;
+	show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
+out:
+	next_cc(cc);
+	return 0;
+}
 
+static int show_one_deleted(struct cache_cursor *cc, struct cache_entry *ce)
+{
+	struct stat st;
+
+	if (excluded(ce->name) != show_ignored)
+		goto out;
+	if (!lstat(ce->name, &st))
+		goto out;
+	show_ce_entry(tag_removed, ce);
+out:
+	next_cc(cc);
+	return 0;
+}
+
+static void show_files(void)
+{
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
 		const char *path = ".", *base = "";
-		int baselen = prefix_len;
+		int i, baselen = prefix_len;
 
 		if (baselen)
 			path = base = prefix;
@@ -433,27 +457,10 @@ static void show_files(void)
 		if (show_killed)
 			show_killed_files();
 	}
-	if (show_cached | show_stage) {
-		for (i = 0; i < active_nr; i++) {
-			struct cache_entry *ce = active_cache[i];
-			if (excluded(ce->name) != show_ignored)
-				continue;
-			if (show_unmerged && !ce_stage(ce))
-				continue;
-			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
-		}
-	}
-	if (show_deleted) {
-		for (i = 0; i < active_nr; i++) {
-			struct cache_entry *ce = active_cache[i];
-			struct stat st;
-			if (excluded(ce->name) != show_ignored)
-				continue;
-			if (!lstat(ce->name, &st))
-				continue;
-			show_ce_entry(tag_removed, ce);
-		}
-	}
+	if (show_cached | show_stage)
+		walk_cache(show_one_cached);
+	if (show_deleted)
+		walk_cache(show_one_deleted);
 }
 
 /*
@@ -633,7 +640,8 @@ int main(int argc, char **argv)
 	if (!(show_stage | show_deleted | show_others | show_unmerged | show_killed))
 		show_cached = 1;
 
-	read_cache();
+	if (read_cache() < 0)
+		die("unable to read index file");
 	if (prefix)
 		prune_cache();
 	show_files();
