From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2 09/11] Library function to check for unmerged index
 entries
Date: Thu, 7 Feb 2008 11:40:13 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802071134400.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 17:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9oj-0007U1-SG
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 17:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823AbYBGQkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 11:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755847AbYBGQkW
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 11:40:22 -0500
Received: from iabervon.org ([66.92.72.58]:39492 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755757AbYBGQkS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 11:40:18 -0500
Received: (qmail 29812 invoked by uid 1000); 7 Feb 2008 16:40:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Feb 2008 16:40:13 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72974>

It's small, but it was in three places already, so it should be in the
library.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-merge-recursive.c |   15 ++-------------
 builtin-reset.c           |   14 +-------------
 cache.h                   |    2 ++
 read-cache.c              |   10 ++++++++++
 4 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 45d4601..558a58e 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -223,22 +223,11 @@ static int git_merge_trees(int index_only,
 	return rc;
 }
 
-static int unmerged_index(void)
-{
-	int i;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce))
-			return 1;
-	}
-	return 0;
-}
-
 struct tree *write_tree_from_memory(void)
 {
 	struct tree *result = NULL;
 
-	if (unmerged_index()) {
+	if (unmerged_cache()) {
 		int i;
 		output(0, "There are unmerged index entries:");
 		for (i = 0; i < active_nr; i++) {
@@ -1524,7 +1513,7 @@ int merge_trees(struct tree *head,
 		    sha1_to_hex(head->object.sha1),
 		    sha1_to_hex(merge->object.sha1));
 
-	if (unmerged_index()) {
+	if (unmerged_cache()) {
 		struct path_list *entries, *re_head, *re_merge;
 		int i;
 		path_list_clear(&current_file_set, 1);
diff --git a/builtin-reset.c b/builtin-reset.c
index 7ee811f..3bec06b 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -44,18 +44,6 @@ static inline int is_merge(void)
 	return !access(git_path("MERGE_HEAD"), F_OK);
 }
 
-static int unmerged_files(void)
-{
-	int i;
-	read_cache();
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce))
-			return 1;
-	}
-	return 0;
-}
-
 static int reset_index_file(const unsigned char *sha1, int is_hard_reset)
 {
 	int i = 0;
@@ -250,7 +238,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
 	if (reset_type == SOFT) {
-		if (is_merge() || unmerged_files())
+		if (is_merge() || read_cache() < 0 || unmerged_cache())
 			die("Cannot do a soft reset in the middle of a merge.");
 	}
 	else if (reset_index_file(sha1, (reset_type == HARD)))
diff --git a/cache.h b/cache.h
index 570297d..a9b807a 100644
--- a/cache.h
+++ b/cache.h
@@ -220,6 +220,7 @@ extern struct index_state the_index;
 #define read_cache_from(path) read_index_from(&the_index, (path))
 #define write_cache(newfd, cache, entries) write_index(&the_index, (newfd))
 #define discard_cache() discard_index(&the_index)
+#define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
@@ -314,6 +315,7 @@ extern int read_index(struct index_state *);
 extern int read_index_from(struct index_state *, const char *path);
 extern int write_index(struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
+extern int unmerged_index(struct index_state *);
 extern int verify_path(const char *path);
 extern int index_name_exists(struct index_state *istate, const char *name, int namelen);
 extern int index_name_pos(struct index_state *, const char *name, int namelen);
diff --git a/read-cache.c b/read-cache.c
index e45f4b3..22d7b46 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1176,6 +1176,16 @@ int discard_index(struct index_state *istate)
 	return 0;
 }
 
+int unmerged_index(struct index_state *istate)
+{
+	int i;
+	for (i = 0; i < istate->cache_nr; i++) {
+		if (ce_stage(istate->cache[i]))
+			return 1;
+	}
+	return 0;
+}
+
 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
-- 
1.5.4
