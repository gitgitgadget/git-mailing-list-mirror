From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 13/22] move purge_cache() to read-cache.c
Date: Mon, 12 Sep 2005 10:56:11 -0400
Message-ID: <20050912145611.28120.45845.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:00:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjm-0000SG-72
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVILO4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVILO4e
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:34 -0400
Received: from citi.umich.edu ([141.211.133.111]:37421 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751299AbVILO4M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:12 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id D5F5E1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:11 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8388>

Functions that manipulate active_cache and active_nr should be in one place.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 cache.h      |    1 +
 ls-files.c   |   28 +---------------------------
 read-cache.c |   26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -165,6 +165,7 @@ extern int cache_name_pos(const char *na
 extern int add_cache_entry(struct cache_entry *ce, int option);
 extern int remove_cache_entry_at(int pos);
 extern int remove_file_from_cache(char *path);
+extern void prune_cache(const char *prefix, int prefix_len);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 extern int ce_match_stat(struct cache_entry *ce, struct stat *st);
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -463,32 +463,6 @@ static void show_files(void)
 		walk_cache(show_one_deleted);
 }
 
-/*
- * Prune the index to only contain stuff starting with "prefix"
- */
-static void prune_cache(void)
-{
-	int pos = cache_name_pos(prefix, prefix_len);
-	unsigned int first, last;
-
-	if (pos < 0)
-		pos = -pos-1;
-	active_cache += pos;
-	active_nr -= pos;
-	first = 0;
-	last = active_nr;
-	while (last > first) {
-		int next = (last + first) >> 1;
-		struct cache_entry *ce = active_cache[next];
-		if (!strncmp(ce->name, prefix, prefix_len)) {
-			first = next+1;
-			continue;
-		}
-		last = next;
-	}
-	active_nr = last;
-}
-
 static void verify_pathspec(void)
 {
 	const char **p, *n, *prev;
@@ -643,7 +617,7 @@ int main(int argc, char **argv)
 	if (read_cache() < 0)
 		die("unable to read index file");
 	if (prefix)
-		prune_cache();
+		prune_cache(prefix, prefix_len);
 	show_files();
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -165,6 +165,32 @@ int remove_file_from_cache(char *path)
 	return 0;
 }
 
+/*
+ * Prune the index to only contain stuff starting with "prefix"
+ */
+void prune_cache(const char *prefix, int prefix_len)
+{
+	int pos = cache_name_pos(prefix, prefix_len);
+	unsigned int first, last;
+
+	if (pos < 0)
+		pos = -pos-1;
+	active_cache += pos;
+	active_nr -= pos;
+	first = 0;
+	last = active_nr;
+	while (last > first) {
+		int next = (last + first) >> 1;
+		struct cache_entry *ce = active_cache[next];
+		if (!strncmp(ce->name, prefix, prefix_len)) {
+			first = next+1;
+			continue;
+		}
+		last = next;
+	}
+	active_nr = last;
+}
+
 int ce_same_name(struct cache_entry *a, struct cache_entry *b)
 {
 	int len = ce_namelen(a);
