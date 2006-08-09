From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] merge-recur: do not setenv("GIT_INDEX_FILE")
Date: Wed, 9 Aug 2006 15:07:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608091507200.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 09 15:08:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAnmp-0004M4-Ee
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 15:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWHINHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 09:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWHINHe
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 09:07:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:34529 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750728AbWHINHd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 09:07:33 -0400
Received: (qmail invoked by alias); 09 Aug 2006 13:07:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 09 Aug 2006 15:07:31 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25119>


Since there are no external calls left in merge-recur, we do not need
to set the environment variable GIT_INDEX_FILE all the time.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b8b0951..7a93dd9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -116,6 +116,7 @@ static void output_commit_title(struct c
 	}
 }
 
+static const char *current_index_file = NULL;
 static const char *original_index_file;
 static const char *temporary_index_file;
 static int cache_dirty = 0;
@@ -124,12 +125,12 @@ static int flush_cache(void)
 {
 	/* flush temporary index */
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int fd = hold_lock_file_for_update(lock, getenv("GIT_INDEX_FILE"));
+	int fd = hold_lock_file_for_update(lock, current_index_file);
 	if (fd < 0)
 		die("could not lock %s", lock->filename);
 	if (write_cache(fd, active_cache, active_nr) ||
 			close(fd) || commit_lock_file(lock))
-		die ("unable to write %s", getenv("GIT_INDEX_FILE"));
+		die ("unable to write %s", current_index_file);
 	discard_cache();
 	cache_dirty = 0;
 	return 0;
@@ -137,11 +138,10 @@ static int flush_cache(void)
 
 static void setup_index(int temp)
 {
-	const char *idx = temp ? temporary_index_file: original_index_file;
+	current_index_file = temp ? temporary_index_file: original_index_file;
 	if (cache_dirty)
 		die("fatal: cache changed flush_cache();");
 	unlink(temporary_index_file);
-	setenv("GIT_INDEX_FILE", idx, 1);
 	discard_cache();
 }
 
@@ -174,7 +174,7 @@ static int add_cacheinfo(unsigned int mo
 {
 	struct cache_entry *ce;
 	if (!cache_dirty)
-		read_cache_from(getenv("GIT_INDEX_FILE"));
+		read_cache_from(current_index_file);
 	cache_dirty++;
 	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, refresh);
 	if (!ce)
@@ -223,7 +223,7 @@ static int git_merge_trees(int index_onl
 	struct unpack_trees_options opts;
 
 	if (!cache_dirty) {
-		read_cache_from(getenv("GIT_INDEX_FILE"));
+		read_cache_from(current_index_file);
 		cache_dirty = 1;
 	}
 
@@ -260,7 +260,7 @@ static struct tree *git_write_tree(void)
 				return NULL;
 		}
 	} else
-		read_cache_from(getenv("GIT_INDEX_FILE"));
+		read_cache_from(current_index_file);
 
 	if (!active_cache_tree)
 		active_cache_tree = cache_tree();
@@ -338,7 +338,7 @@ static struct path_list *get_unmerged(vo
 
 	unmerged->strdup_paths = 1;
 	if (!cache_dirty) {
-		read_cache_from(getenv("GIT_INDEX_FILE"));
+		read_cache_from(current_index_file);
 		cache_dirty++;
 	}
 	for (i = 0; i < active_nr; i++) {
@@ -468,10 +468,6 @@ static int remove_path(const char *name)
 	return ret;
 }
 
-/*
- * TODO: once we no longer call external programs, we'd probably be better off
- * not setting / getting the environment variable GIT_INDEX_FILE all the time.
- */
 int remove_file(int clean, const char *path)
 {
 	int update_cache = index_only || clean;
@@ -479,7 +475,7 @@ int remove_file(int clean, const char *p
 
 	if (update_cache) {
 		if (!cache_dirty)
-			read_cache_from(getenv("GIT_INDEX_FILE"));
+			read_cache_from(current_index_file);
 		cache_dirty++;
 		if (remove_file_from_cache(path))
 			return -1;
-- 
1.4.2.rc3.g55597-dirty
