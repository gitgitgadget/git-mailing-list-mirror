From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] cache-tree: update API to take abitrary flags
Date: Wed, 11 Jan 2012 16:59:41 +0700
Message-ID: <1326275982-29866-2-git-send-email-pclouds@gmail.com>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 11:00:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkuyi-0007Kj-2o
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 11:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353Ab2AKKAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 05:00:04 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42218 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834Ab2AKKAA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 05:00:00 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so884554iab.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 01:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=a2S1Q2O7kaa6t6rZWxL5DBNb4Yu7jSKMygXVG17jdyI=;
        b=NQTRSN2DeMveaTQZ2BBR7X+UtOff7uUwZPhc2HoszAiH+i1UTn+91HJZA3pzTteLjU
         hRduGnvFiLWUrHmEtcmvuB1uXiiPHnNGATfkMKClynDayU5VGtydLPoQUYyOK7o/oWGj
         D0mWZoYlO0hbAFNGkcm+spIGmWouQH+u/yfmE=
Received: by 10.43.117.194 with SMTP id fn2mr25235459icc.53.1326275999834;
        Wed, 11 Jan 2012 01:59:59 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id g34sm3521259ibk.10.2012.01.11.01.59.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 01:59:59 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Jan 2012 16:59:51 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188351>

---
 builtin/commit.c       |    4 ++--
 cache-tree.c           |   27 ++++++++++++---------------
 cache-tree.h           |    4 +++-
 merge-recursive.c      |    2 +-
 test-dump-cache-tree.c |    2 +-
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index eba1377..bf42bb3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -400,7 +400,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
-		update_main_cache_tree(1);
+		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
 			die(_("unable to write new_index file"));
@@ -421,7 +421,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
-			update_main_cache_tree(1);
+			update_main_cache_tree(WRITE_TREE_SILENT);
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
 				die(_("unable to write new_index file"));
diff --git a/cache-tree.c b/cache-tree.c
index 8de3959..16355d6 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -150,9 +150,10 @@ void cache_tree_invalidate_path(struct cache_tree *it, const char *path)
 }
 
 static int verify_cache(struct cache_entry **cache,
-			int entries, int silent)
+			int entries, int flags)
 {
 	int i, funny;
+	int silent = flags & WRITE_TREE_SILENT;
 
 	/* Verify that the tree is merged */
 	funny = 0;
@@ -241,10 +242,11 @@ static int update_one(struct cache_tree *it,
 		      int entries,
 		      const char *base,
 		      int baselen,
-		      int missing_ok,
-		      int dryrun)
+		      int flags)
 {
 	struct strbuf buffer;
+	int missing_ok = flags & WRITE_TREE_MISSING_OK;
+	int dryrun = flags & WRITE_TREE_DRY_RUN;
 	int i;
 
 	if (0 <= it->entry_count && has_sha1_file(it->sha1))
@@ -288,8 +290,7 @@ static int update_one(struct cache_tree *it,
 				    cache + i, entries - i,
 				    path,
 				    baselen + sublen + 1,
-				    missing_ok,
-				    dryrun);
+				    flags);
 		if (subcnt < 0)
 			return subcnt;
 		i += subcnt - 1;
@@ -371,15 +372,13 @@ static int update_one(struct cache_tree *it,
 int cache_tree_update(struct cache_tree *it,
 		      struct cache_entry **cache,
 		      int entries,
-		      int missing_ok,
-		      int dryrun,
-		      int silent)
+		      int flags)
 {
 	int i;
-	i = verify_cache(cache, entries, silent);
+	i = verify_cache(cache, entries, flags);
 	if (i)
 		return i;
-	i = update_one(it, cache, entries, "", 0, missing_ok, dryrun);
+	i = update_one(it, cache, entries, "", 0, flags);
 	if (i < 0)
 		return i;
 	return 0;
@@ -572,11 +571,9 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 
 	was_valid = cache_tree_fully_valid(active_cache_tree);
 	if (!was_valid) {
-		int missing_ok = flags & WRITE_TREE_MISSING_OK;
-
 		if (cache_tree_update(active_cache_tree,
 				      active_cache, active_nr,
-				      missing_ok, 0, 0) < 0)
+				      flags) < 0)
 			return WRITE_TREE_UNMERGED_INDEX;
 		if (0 <= newfd) {
 			if (!write_cache(newfd, active_cache, active_nr) &&
@@ -672,10 +669,10 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 	return 0;
 }
 
-int update_main_cache_tree (int silent)
+int update_main_cache_tree (int flags)
 {
 	if (!the_index.cache_tree)
 		the_index.cache_tree = cache_tree();
 	return cache_tree_update(the_index.cache_tree,
-				 the_index.cache, the_index.cache_nr, 0, 0, silent);
+				 the_index.cache, the_index.cache_nr, flags);
 }
diff --git a/cache-tree.h b/cache-tree.h
index 0ec0b2a..d8cb2e9 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -29,13 +29,15 @@ void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct cache_tree *);
-int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int, int, int);
+int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int);
 
 int update_main_cache_tree(int);
 
 /* bitmasks to write_cache_as_tree flags */
 #define WRITE_TREE_MISSING_OK 1
 #define WRITE_TREE_IGNORE_CACHE_TREE 2
+#define WRITE_TREE_DRY_RUN 4
+#define WRITE_TREE_SILENT 8
 
 /* error return codes */
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
diff --git a/merge-recursive.c b/merge-recursive.c
index d83cd6c..6479a60 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -264,7 +264,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
 	    cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0, 0) < 0)
+			      active_cache, active_nr, 0) < 0)
 		die("error building trees");
 
 	result = lookup_tree(active_cache_tree->sha1);
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index e6c2923..a6ffdf3 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -59,6 +59,6 @@ int main(int ac, char **av)
 	struct cache_tree *another = cache_tree();
 	if (read_cache() < 0)
 		die("unable to read index file");
-	cache_tree_update(another, active_cache, active_nr, 0, 1, 0);
+	cache_tree_update(another, active_cache, active_nr, WRITE_TREE_DRY_RUN);
 	return dump_cache_tree(active_cache_tree, another, "");
 }
-- 
1.7.3.1.256.g2539c.dirty
