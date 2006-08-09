From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] merge-recur: do not call git-write-tree
Date: Wed, 9 Aug 2006 15:04:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608091503170.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 09 15:04:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAnjS-0003bZ-Du
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 15:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWHINET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 09:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWHINET
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 09:04:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:52392 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750740AbWHINES (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 09:04:18 -0400
Received: (qmail invoked by alias); 09 Aug 2006 13:04:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 09 Aug 2006 15:04:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25118>


Since merge-recur is in C, and uses libgit, it can call the relevant
functions directly, without writing the index file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |   44 ++++++++++++++++++++------------------------
 1 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f5c0080..b8b0951 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -248,38 +248,34 @@ static int git_merge_trees(int index_onl
 	return rc;
 }
 
-/*
- * TODO: this can be streamlined by refactoring builtin-write-tree.c
- */
 static struct tree *git_write_tree(void)
 {
-	FILE *fp;
-	int rc;
-	char buf[41];
-	unsigned char sha1[20];
-	int ch;
-	unsigned i = 0;
+	struct tree *result = NULL;
+
 	if (cache_dirty) {
+		unsigned i;
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
 			if (ce_stage(ce))
 				return NULL;
 		}
-		flush_cache();
-	}
-	fp = popen("git-write-tree 2>/dev/null", "r");
-	while ((ch = fgetc(fp)) != EOF)
-		if (i < sizeof(buf)-1 && ch >= '0' && ch <= 'f')
-			buf[i++] = ch;
-		else
-			break;
-	rc = pclose(fp);
-	if (rc == -1 || WEXITSTATUS(rc))
-		return NULL;
-	buf[i] = '\0';
-	if (get_sha1(buf, sha1) != 0)
-		return NULL;
-	return lookup_tree(sha1);
+	} else
+		read_cache_from(getenv("GIT_INDEX_FILE"));
+
+	if (!active_cache_tree)
+		active_cache_tree = cache_tree();
+
+	if (!cache_tree_fully_valid(active_cache_tree) &&
+			cache_tree_update(active_cache_tree,
+				active_cache, active_nr, 0, 0) < 0)
+		die("error building trees");
+
+	result = lookup_tree(active_cache_tree->sha1);
+
+	flush_cache();
+	cache_dirty = 0;
+
+	return result;
 }
 
 static int save_files_dirs(const unsigned char *sha1,
-- 
1.4.2.rc3.g55597-dirty
