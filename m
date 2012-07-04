From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC] Replace ce_namelen() with a ce_namelen field
Date: Wed,  4 Jul 2012 11:18:48 +0200
Message-ID: <1341393528-21037-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, gitster@pobox.com, mhagger@alum.mit.edu,
	pclouds@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 11:19:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmLkB-0005VO-Ve
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 11:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab2GDJT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 05:19:26 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53908 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377Ab2GDJTY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 05:19:24 -0400
Received: by eeit10 with SMTP id t10so2796882eei.19
        for <git@vger.kernel.org>; Wed, 04 Jul 2012 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=idKR/J8z4tZnpLcaJN1gU2zNrzLLUtfl8gYywc9QpN4=;
        b=eAe7UI1N8vd8ZkPOvNCmMxl9k3osMQRFBen8Zpt6VmoSFeKay4NNi7DRV020XgLjx3
         xXJscnW7Ev1xgR0N+XuzcWNP5WWG3xucAF2FIe2LbunKDHd6IGYPcX0FgZu2nT2lGuC3
         vmd+OswCNxDrrGNBSFRSfyzn8QvPyYOMGHuI9OdGDYL2yjSA69t9cNtT0O9rWPEIxhEs
         1NomujqaM8fjFVwiH/KlMaWStDwre7ckqxYtw/AVTrQ95vPEWc0iefWXAxikNpOLx0NY
         4YK6aXhJG/nzfBvA/HCpdzCvjFNVumjh4I60rjtC63KiQXZK1UBVpM+b+YwHys+mAdn7
         rbCg==
Received: by 10.14.96.207 with SMTP id r55mr5332539eef.137.1341393562387;
        Wed, 04 Jul 2012 02:19:22 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id u14sm52147789eem.4.2012.07.04.02.19.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Jul 2012 02:19:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200997>

Replace the ce_namelen() function in cache.h with a ce_namelen
field in struct cache_entry. This will both give us a tiny bit
of a performance enhancement when working with long pathnames
and is part of the refactoring for the index-v5 file format.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/add.c            |    4 ++--
 builtin/apply.c          |    1 +
 builtin/blame.c          |    1 +
 builtin/checkout-index.c |    8 ++++----
 builtin/checkout.c       |    7 ++++---
 builtin/clean.c          |    2 +-
 builtin/commit.c         |    2 +-
 builtin/grep.c           |    2 +-
 builtin/ls-files.c       |    8 ++++----
 builtin/rm.c             |    2 +-
 builtin/update-index.c   |    9 ++++++---
 cache-tree.c             |    4 ++--
 cache.h                  |   11 ++---------
 diff-lib.c               |    6 +++---
 entry.c                  |    2 +-
 merge-recursive.c        |    2 +-
 name-hash.c              |    4 ++--
 preload-index.c          |    2 +-
 read-cache.c             |   43 ++++++++++++++++++++++++-------------------
 rerere.c                 |    2 +-
 resolve-undo.c           |    2 +-
 sha1_name.c              |    6 +++---
 submodule.c              |    2 +-
 tree.c                   |    1 +
 unpack-trees.c           |   31 ++++++++++++++++---------------
 25 files changed, 85 insertions(+), 79 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index b79336d..63ef9c5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -114,7 +114,7 @@ static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
 		return;
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
-		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
+		match_pathspec(pathspec, ce->name, ce->ce_namelen, 0, seen);
 	}
 }
 
@@ -163,7 +163,7 @@ static void treat_gitlinks(const char **pathspec)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (S_ISGITLINK(ce->ce_mode)) {
-			int len = ce_namelen(ce), j;
+			int len = ce->ce_namelen, j;
 			for (j = 0; pathspec[j]; j++) {
 				int len2 = strlen(pathspec[j]);
 				if (len2 <= len || pathspec[j][len] != '/' ||
diff --git a/builtin/apply.c b/builtin/apply.c
index dda9ea0..c9fae60 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3503,6 +3503,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = namelen;
+	ce->ce_namelen = namelen;
 	if (S_ISGITLINK(mode)) {
 		const char *s = buf;
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 24d3dd5..72b2ed4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2154,6 +2154,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	hashcpy(ce->sha1, origin->blob_sha1);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(len, 0);
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index c16d82b..ecabe1a 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -55,7 +55,7 @@ static int checkout_file(const char *name, int prefix_length)
 
 	while (pos < active_nr) {
 		struct cache_entry *ce = active_cache[pos];
-		if (ce_namelen(ce) != namelen ||
+		if (ce->ce_namelen != namelen ||
 		    memcmp(ce->name, name, namelen))
 			break;
 		has_same_name = 1;
@@ -100,12 +100,12 @@ static void checkout_all(const char *prefix, int prefix_length)
 		    && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
 			continue;
 		if (prefix && *prefix &&
-		    (ce_namelen(ce) <= prefix_length ||
+		    (ce->ce_namelen <= prefix_length ||
 		     memcmp(prefix, ce->name, prefix_length)))
 			continue;
 		if (last_ce && to_tempfile) {
-			if (ce_namelen(last_ce) != ce_namelen(ce)
-			    || memcmp(last_ce->name, ce->name, ce_namelen(ce)))
+			if (last_ce->ce_namelen != ce->ce_namelen
+			    || memcmp(last_ce->name, ce->name, ce->ce_namelen))
 				write_tempfile_record(last_ce->name, prefix_length);
 		}
 		if (checkout_entry(ce, &state,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3ddda34..e05f89c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -74,6 +74,7 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len - baselen);
 	ce->ce_flags = create_ce_flags(len, 0) | CE_UPDATE;
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	return 0;
@@ -244,7 +245,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 		struct cache_entry *ce = active_cache[pos];
 		if (source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
-		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, ps_matched);
+		match_pathspec(pathspec, ce->name, ce->ce_namelen, 0, ps_matched);
 	}
 
 	if (report_path_error(ps_matched, pathspec, prefix))
@@ -257,7 +258,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	/* Any unmerged paths? */
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
-		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
+		if (match_pathspec(pathspec, ce->name, ce->ce_namelen, 0, NULL)) {
 			if (!ce_stage(ce))
 				continue;
 			if (opts->force) {
@@ -284,7 +285,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 		struct cache_entry *ce = active_cache[pos];
 		if (source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
-		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
+		if (match_pathspec(pathspec, ce->name, ce->ce_namelen, 0, NULL)) {
 			if (!ce_stage(ce)) {
 				errs |= checkout_entry(ce, &state, NULL);
 				continue;
diff --git a/builtin/clean.c b/builtin/clean.c
index 0c7b3d0..512d31c 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -128,7 +128,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		pos = -pos - 1;
 		if (pos < active_nr) {
 			ce = active_cache[pos];
-			if (ce_namelen(ce) == len &&
+			if (ce->ce_namelen == len &&
 			    !memcmp(ce->name, ent->name, len))
 				continue; /* Yup, this one exists unmerged */
 		}
diff --git a/builtin/commit.c b/builtin/commit.c
index a2ec73d..e08b87e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -200,7 +200,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
-		if (!match_pathspec(pattern, ce->name, ce_namelen(ce), 0, m))
+		if (!match_pathspec(pattern, ce->name, ce->ce_namelen, 0, m))
 			continue;
 		item = string_list_insert(list, ce->name);
 		if (ce_skip_worktree(ce))
diff --git a/builtin/grep.c b/builtin/grep.c
index 643938d..dd3b1cc 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -416,7 +416,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 		struct cache_entry *ce = active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL))
+		if (!match_pathspec_depth(pathspec, ce->name, ce->ce_namelen, 0, NULL))
 			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7cff175..64a3e6e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -104,7 +104,7 @@ static void show_killed_files(struct dir_struct *dir)
 				 * ent->name in the cache.  Does it expect
 				 * ent->name to be a directory?
 				 */
-				len = ce_namelen(active_cache[pos]);
+				len = active_cache[pos]->ce_namelen;
 				if ((ent->len < len) &&
 				    !strncmp(active_cache[pos]->name,
 					     ent->name, ent->len) &&
@@ -130,10 +130,10 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 {
 	int len = max_prefix_len;
 
-	if (len >= ce_namelen(ce))
+	if (len >= ce->ce_namelen)
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
-	if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), len, ps_matched))
+	if (!match_pathspec(pathspec, ce->name, ce->ce_namelen, len, ps_matched))
 		return;
 
 	if (tag && *tag && show_valid_bit &&
@@ -162,7 +162,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
-	write_name(ce->name, ce_namelen(ce));
+	write_name(ce->name, ce->ce_namelen);
 	if (debug_mode) {
 		printf("  ctime: %d:%d\n", ce->ce_ctime.sec, ce->ce_ctime.nsec);
 		printf("  mtime: %d:%d\n", ce->ce_mtime.sec, ce->ce_mtime.nsec);
diff --git a/builtin/rm.c b/builtin/rm.c
index 90c8a50..9a636b7 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -171,7 +171,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
+		if (!match_pathspec(pathspec, ce->name, ce->ce_namelen, 0, seen))
 			continue;
 		ALLOC_GROW(list.name, list.nr + 1, list.alloc);
 		list.name[list.nr++] = ce->name;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5f038d6..784b52b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -96,6 +96,7 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = len;
+	ce->ce_namelen = len;
 	fill_stat_cache_info(ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
@@ -236,6 +237,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(len, stage);
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 	if (assume_unchanged)
 		ce->ce_flags |= CE_VALID;
@@ -434,6 +436,7 @@ static struct cache_entry *read_one_ent(const char *which,
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, path, namelen);
 	ce->ce_flags = create_ce_flags(namelen, stage);
+	ce->ce_namelen = namelen;
 	ce->ce_mode = create_ce_mode(mode);
 	return ce;
 }
@@ -453,7 +456,7 @@ static int unresolve_one(const char *path)
 		if (pos < active_nr) {
 			struct cache_entry *ce = active_cache[pos];
 			if (ce_stage(ce) &&
-			    ce_namelen(ce) == namelen &&
+			    ce->ce_namelen == namelen &&
 			    !memcmp(ce->name, path, namelen))
 				return 0;
 		}
@@ -466,7 +469,7 @@ static int unresolve_one(const char *path)
 		pos = -pos-1;
 		if (pos < active_nr) {
 			struct cache_entry *ce = active_cache[pos];
-			if (ce_namelen(ce) == namelen &&
+			if (ce->ce_namelen == namelen &&
 			    !memcmp(ce->name, path, namelen)) {
 				fprintf(stderr,
 					"%s: skipping still unmerged path.\n",
@@ -569,7 +572,7 @@ static int do_reupdate(int ac, const char **av,
 			continue;
 		if (has_head)
 			old = read_one_ent(NULL, head_sha1,
-					   ce->name, ce_namelen(ce), 0);
+					   ce->name, ce->ce_namelen, 0);
 		if (old && ce->ce_mode == old->ce_mode &&
 		    !hashcmp(ce->sha1, old->sha1)) {
 			free(old);
diff --git a/cache-tree.c b/cache-tree.c
index 28ed657..b5f5cd0 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -270,7 +270,7 @@ static int update_one(struct cache_tree *it,
 		int pathlen, sublen, subcnt;
 
 		path = ce->name;
-		pathlen = ce_namelen(ce);
+		pathlen = ce->ce_namelen;
 		if (pathlen <= baselen || memcmp(base, path, baselen))
 			break; /* at the end of this level */
 
@@ -313,7 +313,7 @@ static int update_one(struct cache_tree *it,
 		unsigned mode;
 
 		path = ce->name;
-		pathlen = ce_namelen(ce);
+		pathlen = ce->ce_namelen;
 		if (pathlen <= baselen || memcmp(base, path, baselen))
 			break; /* at the end of this level */
 
diff --git a/cache.h b/cache.h
index cc5048c..5f93f22 100644
--- a/cache.h
+++ b/cache.h
@@ -128,6 +128,7 @@ struct cache_entry {
 	unsigned int ce_gid;
 	unsigned int ce_size;
 	unsigned int ce_flags;
+	unsigned int ce_namelen;
 	unsigned char sha1[20];
 	struct cache_entry *next;
 	struct cache_entry *dir_next;
@@ -205,15 +206,7 @@ static inline unsigned create_ce_flags(size_t len, unsigned stage)
 	return (len | (stage << CE_STAGESHIFT));
 }
 
-static inline size_t ce_namelen(const struct cache_entry *ce)
-{
-	size_t len = ce->ce_flags & CE_NAMEMASK;
-	if (len < CE_NAMEMASK)
-		return len;
-	return strlen(ce->name + CE_NAMEMASK) + CE_NAMEMASK;
-}
-
-#define ce_size(ce) cache_entry_size(ce_namelen(ce))
+#define ce_size(ce) cache_entry_size(ce->ce_namelen)
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT)
 #define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
diff --git a/diff-lib.c b/diff-lib.c
index fc0dff3..720391b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -32,7 +32,7 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 			return -1;
 		return 1;
 	}
-	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
+	if (has_symlink_leading_path(ce->name, ce->ce_namelen))
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
 		unsigned char sub[20];
@@ -115,7 +115,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			int num_compare_stages = 0;
 			size_t path_len;
 
-			path_len = ce_namelen(ce);
+			path_len = ce->ce_namelen;
 
 			dpath = xmalloc(combine_diff_path_size(5, path_len));
 			dpath->path = (char *) &(dpath->parent[5]);
@@ -319,7 +319,7 @@ static int show_modified(struct rev_info *revs,
 	if (revs->combine_merges && !cached &&
 	    (hashcmp(sha1, old->sha1) || hashcmp(old->sha1, new->sha1))) {
 		struct combine_diff_path *p;
-		int pathlen = ce_namelen(new);
+		int pathlen = new->ce_namelen;
 
 		p = xmalloc(combine_diff_path_size(2, pathlen));
 		p->path = (char *) &p->parent[2];
diff --git a/entry.c b/entry.c
index 17a6bcc..57ee28a 100644
--- a/entry.c
+++ b/entry.c
@@ -242,7 +242,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 
 	memcpy(path, state->base_dir, len);
 	strcpy(path + len, ce->name);
-	len += ce_namelen(ce);
+	len += ce->ce_namelen;
 
 	if (!check_path(path, len, &st, state->base_dir_len)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
diff --git a/merge-recursive.c b/merge-recursive.c
index 680937c..9beed5d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -254,7 +254,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 			struct cache_entry *ce = active_cache[i];
 			if (ce_stage(ce))
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
-					(int)ce_namelen(ce), ce->name);
+					(int)ce->ce_namelen, ce->name);
 		}
 		die("Bug in merge-recursive.c");
 	}
diff --git a/name-hash.c b/name-hash.c
index d8d25c2..5f0c998 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -75,7 +75,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		return;
 	ce->ce_flags |= CE_HASHED;
 	ce->next = ce->dir_next = NULL;
-	hash = hash_name(ce->name, ce_namelen(ce));
+	hash = hash_name(ce->name, ce->ce_namelen);
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
 		ce->next = *pos;
@@ -125,7 +125,7 @@ static int slow_same_name(const char *name1, int len1, const char *name2, int le
 
 static int same_name(const struct cache_entry *ce, const char *name, int namelen, int icase)
 {
-	int len = ce_namelen(ce);
+	int len = ce->ce_namelen;
 
 	/*
 	 * Always do exact compare, even if we want a case-ignoring comparison;
diff --git a/preload-index.c b/preload-index.c
index 49cb08d..95ca421 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -55,7 +55,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (!ce_path_match(ce, &pathspec))
 			continue;
-		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
+		if (threaded_has_symlink_leading_path(&cache, ce->name, ce->ce_namelen))
 			continue;
 		if (lstat(ce->name, &st))
 			continue;
diff --git a/read-cache.c b/read-cache.c
index ef355cc..01281ab 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -56,6 +56,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 	copy_cache_entry(new, old);
 	new->ce_flags &= ~(CE_STATE_MASK | CE_NAMEMASK);
 	new->ce_flags |= (namelen >= CE_NAMEMASK ? CE_NAMEMASK : namelen);
+	new->ce_namelen = namelen;
 	memcpy(new->name, new_name, namelen + 1);
 
 	cache_tree_invalidate_path(istate->cache_tree, old->name);
@@ -492,7 +493,7 @@ int remove_file_from_index(struct index_state *istate, const char *path)
 
 static int compare_name(struct cache_entry *ce, const char *path, int namelen)
 {
-	return namelen != ce_namelen(ce) || memcmp(path, ce->name, namelen);
+	return namelen != ce->ce_namelen || memcmp(path, ce->name, namelen);
 }
 
 static int index_name_pos_also_unmerged(struct index_state *istate,
@@ -520,8 +521,8 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 
 static int different_name(struct cache_entry *ce, struct cache_entry *alias)
 {
-	int len = ce_namelen(ce);
-	return ce_namelen(alias) != len || memcmp(ce->name, alias->name, len);
+	int len = ce->ce_namelen;
+	return alias->ce_namelen != len || memcmp(ce->name, alias->name, len);
 }
 
 /*
@@ -542,7 +543,7 @@ static struct cache_entry *create_alias_ce(struct cache_entry *ce, struct cache_
 		die("Will not add file alias '%s' ('%s' already exists in index)", ce->name, alias->name);
 
 	/* Ok, create the new entry using the name of the existing alias */
-	len = ce_namelen(alias);
+	len = alias->ce_namelen;
 	new = xcalloc(1, cache_entry_size(len));
 	memcpy(new->name, alias->name, len);
 	copy_cache_entry(new, ce);
@@ -582,6 +583,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_flags = namelen;
+	ce->ce_namelen = namelen;
 	if (!intent_only)
 		fill_stat_cache_info(ce, st);
 	else
@@ -623,7 +625,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		}
 	}
 
-	alias = index_name_exists(istate, ce->name, ce_namelen(ce), ignore_case);
+	alias = index_name_exists(istate, ce->name, ce->ce_namelen, ignore_case);
 	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce_option)) {
 		/* Nothing changed, really */
 		free(ce);
@@ -684,6 +686,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(len, stage);
+	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
 	if (refresh)
@@ -694,13 +697,13 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 
 int ce_same_name(struct cache_entry *a, struct cache_entry *b)
 {
-	int len = ce_namelen(a);
-	return ce_namelen(b) == len && !memcmp(a->name, b->name, len);
+	int len = a->ce_namelen;
+	return b->ce_namelen == len && !memcmp(a->name, b->name, len);
 }
 
 int ce_path_match(const struct cache_entry *ce, const struct pathspec *pathspec)
 {
-	return match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL);
+	return match_pathspec_depth(pathspec, ce->name, ce->ce_namelen, 0, NULL);
 }
 
 /*
@@ -772,14 +775,14 @@ static int has_file_name(struct index_state *istate,
 			 const struct cache_entry *ce, int pos, int ok_to_replace)
 {
 	int retval = 0;
-	int len = ce_namelen(ce);
+	int len = ce->ce_namelen;
 	int stage = ce_stage(ce);
 	const char *name = ce->name;
 
 	while (pos < istate->cache_nr) {
 		struct cache_entry *p = istate->cache[pos++];
 
-		if (len >= ce_namelen(p))
+		if (len >= p->ce_namelen)
 			break;
 		if (memcmp(name, p->name, len))
 			break;
@@ -807,7 +810,7 @@ static int has_dir_name(struct index_state *istate,
 	int retval = 0;
 	int stage = ce_stage(ce);
 	const char *name = ce->name;
-	const char *slash = name + ce_namelen(ce);
+	const char *slash = name + ce->ce_namelen;
 
 	for (;;) {
 		int len;
@@ -848,7 +851,7 @@ static int has_dir_name(struct index_state *istate,
 		 */
 		while (pos < istate->cache_nr) {
 			struct cache_entry *p = istate->cache[pos];
-			if ((ce_namelen(p) <= len) ||
+			if ((p->ce_namelen <= len) ||
 			    (p->name[len] != '/') ||
 			    memcmp(p->name, name, len))
 				break; /* not our subdirectory */
@@ -1235,8 +1238,8 @@ struct ondisk_cache_entry_extended {
 #define ondisk_cache_entry_size(len) align_flex_name(ondisk_cache_entry,len)
 #define ondisk_cache_entry_extended_size(len) align_flex_name(ondisk_cache_entry_extended,len)
 #define ondisk_ce_size(ce) (((ce)->ce_flags & CE_EXTENDED) ? \
-			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
-			    ondisk_cache_entry_size(ce_namelen(ce)))
+			    ondisk_cache_entry_extended_size(ce->ce_namelen) : \
+			    ondisk_cache_entry_size(ce->ce_namelen))
 
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
@@ -1320,6 +1323,7 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 	ce->ce_gid   = ntoh_l(ondisk->gid);
 	ce->ce_size  = ntoh_l(ondisk->size);
 	ce->ce_flags = flags;
+	ce->ce_namelen = len;
 	hashcpy(ce->sha1, ondisk->sha1);
 	memcpy(ce->name, name, len);
 	ce->name[len] = '\0';
@@ -1681,7 +1685,7 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 		size = ondisk_ce_size(ce);
 		ondisk = xcalloc(1, size);
 		name = copy_cache_entry_to_ondisk(ondisk, ce);
-		memcpy(name, ce->name, ce_namelen(ce));
+		memcpy(name, ce->name, ce->ce_namelen);
 	} else {
 		int common, to_remove, prefix_size;
 		unsigned char to_remove_vi[16];
@@ -1698,15 +1702,15 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 			size = offsetof(struct ondisk_cache_entry_extended, name);
 		else
 			size = offsetof(struct ondisk_cache_entry, name);
-		size += prefix_size + (ce_namelen(ce) - common + 1);
+		size += prefix_size + (ce->ce_namelen - common + 1);
 
 		ondisk = xcalloc(1, size);
 		name = copy_cache_entry_to_ondisk(ondisk, ce);
 		memcpy(name, to_remove_vi, prefix_size);
-		memcpy(name + prefix_size, ce->name + common, ce_namelen(ce) - common);
+		memcpy(name + prefix_size, ce->name + common, ce->ce_namelen - common);
 
 		strbuf_splice(previous_name, common, to_remove,
-			      ce->name + common, ce_namelen(ce) - common);
+			      ce->name + common, ce->ce_namelen - common);
 	}
 
 	result = ce_write(c, fd, ondisk, size);
@@ -1846,6 +1850,7 @@ int read_index_unmerged(struct index_state *istate)
 		new_ce = xcalloc(1, size);
 		memcpy(new_ce->name, ce->name, len);
 		new_ce->ce_flags = create_ce_flags(len, 0) | CE_CONFLICTED;
+		new_ce->ce_namelen = len;
 		new_ce->ce_mode = ce->ce_mode;
 		if (add_index_entry(istate, new_ce, 0))
 			return error("%s: cannot drop to stage #0",
@@ -1876,7 +1881,7 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 	pos = -pos - 1;
 	if (pos < istate->cache_nr) {
 		struct cache_entry *ce = istate->cache[pos];
-		if (ce_namelen(ce) == namelen &&
+		if (ce->ce_namelen == namelen &&
 		    !memcmp(ce->name, name, namelen))
 			return 0; /* Yup, this one exists unmerged */
 	}
diff --git a/rerere.c b/rerere.c
index dcb525a..044190d 100644
--- a/rerere.c
+++ b/rerere.c
@@ -320,7 +320,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 		if (active_nr <= pos)
 			break;
 		ce = active_cache[pos++];
-		if (ce_namelen(ce) != len || memcmp(ce->name, path, len)
+		if (ce->ce_namelen != len || memcmp(ce->name, path, len)
 		    || ce_stage(ce) != i + 1)
 			break;
 		mmfile[i].ptr = read_sha1_file(ce->sha1, &type, &size);
diff --git a/resolve-undo.c b/resolve-undo.c
index 72b4612..6fdee85 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -165,7 +165,7 @@ void unmerge_index(struct index_state *istate, const char **pathspec)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL))
+		if (!match_pathspec(pathspec, ce->name, ce->ce_namelen, 0, NULL))
 			continue;
 		i = unmerge_index_entry_at(istate, i);
 	}
diff --git a/sha1_name.c b/sha1_name.c
index c633113..2c4af98 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -967,7 +967,7 @@ static void diagnose_invalid_index_path(int stage,
 		pos = -pos - 1;
 	if (pos < active_nr) {
 		ce = active_cache[pos];
-		if (ce_namelen(ce) == namelen &&
+		if (ce->ce_namelen == namelen &&
 		    !memcmp(ce->name, filename, namelen))
 			die("Path '%s' is in the index, but not at stage %d.\n"
 			    "Did you mean ':%d:%s'?",
@@ -985,7 +985,7 @@ static void diagnose_invalid_index_path(int stage,
 		pos = -pos - 1;
 	if (pos < active_nr) {
 		ce = active_cache[pos];
-		if (ce_namelen(ce) == fullnamelen &&
+		if (ce->ce_namelen == fullnamelen &&
 		    !memcmp(ce->name, fullname, fullnamelen))
 			die("Path '%s' is in the index, but not '%s'.\n"
 			    "Did you mean ':%d:%s' aka ':%d:./%s'?",
@@ -1087,7 +1087,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			pos = -pos - 1;
 		while (pos < active_nr) {
 			ce = active_cache[pos];
-			if (ce_namelen(ce) != namelen ||
+			if (ce->ce_namelen != namelen ||
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
diff --git a/submodule.c b/submodule.c
index 959d349..c5f5f15 100644
--- a/submodule.c
+++ b/submodule.c
@@ -112,7 +112,7 @@ void gitmodules_config(void)
 			pos = -1 - pos;
 			if (active_nr > pos) {  /* there is a .gitmodules */
 				const struct cache_entry *ce = active_cache[pos];
-				if (ce_namelen(ce) == 11 &&
+				if (ce->ce_namelen == 11 &&
 				    !memcmp(ce->name, ".gitmodules", 11))
 					gitmodules_is_unmerged = 1;
 			}
diff --git a/tree.c b/tree.c
index 676e9f7..f2a66be 100644
--- a/tree.c
+++ b/tree.c
@@ -23,6 +23,7 @@ static int read_one_entry_opt(const unsigned char *sha1, const char *base, int b
 
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(baselen + len, stage);
+	ce->ce_namelen = baselen + len;
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	hashcpy(ce->sha1, sha1);
diff --git a/unpack-trees.c b/unpack-trees.c
index ad40109..e5e6fc5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -175,11 +175,11 @@ static void display_error_msgs(struct unpack_trees_options *o)
  */
 static void unlink_entry(struct cache_entry *ce)
 {
-	if (!check_leading_path(ce->name, ce_namelen(ce)))
+	if (!check_leading_path(ce->name, ce->ce_namelen))
 		return;
 	if (remove_or_warn(ce->ce_mode, ce->name))
 		return;
-	schedule_dir_for_removal(ce->name, ce_namelen(ce));
+	schedule_dir_for_removal(ce->name, ce->ce_namelen);
 }
 
 static struct checkout state;
@@ -324,7 +324,7 @@ static int locate_in_src_index(struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
 	struct index_state *index = o->src_index;
-	int len = ce_namelen(ce);
+	int len = ce->ce_namelen;
 	int pos = index_name_pos(index, ce->name, len);
 	if (pos < 0)
 		pos = -1 - pos;
@@ -340,12 +340,12 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 				   struct unpack_trees_options *o)
 {
 	struct index_state *index = o->src_index;
-	int len = ce_namelen(ce);
+	int len = ce->ce_namelen;
 	int pos;
 
 	for (pos = locate_in_src_index(ce, o); pos < index->cache_nr; pos++) {
 		struct cache_entry *next = index->cache[pos];
-		if (len != ce_namelen(next) ||
+		if (len != next->ce_namelen ||
 		    memcmp(ce->name, next->name, len))
 			break;
 		mark_ce_used(next, o);
@@ -370,14 +370,14 @@ static void add_same_unmerged(struct cache_entry *ce,
 			      struct unpack_trees_options *o)
 {
 	struct index_state *index = o->src_index;
-	int len = ce_namelen(ce);
+	int len = ce->ce_namelen;
 	int pos = index_name_pos(index, ce->name, len);
 
 	if (0 <= pos)
 		die("programming error in a caller of mark_ce_used_same_name");
 	for (pos = -pos - 1; pos < index->cache_nr; pos++) {
 		struct cache_entry *next = index->cache[pos];
-		if (len != ce_namelen(next) ||
+		if (len != next->ce_namelen ||
 		    memcmp(ce->name, next->name, len))
 			break;
 		add_entry(o, next, 0, 0);
@@ -493,7 +493,7 @@ static int do_compare_entry(const struct cache_entry *ce, const struct traverse_
 			return cmp;
 	}
 	pathlen = info->pathlen;
-	ce_len = ce_namelen(ce);
+	ce_len = ce->ce_namelen;
 
 	/* If ce_len < pathlen then we must have previously hit "name == directory" entry */
 	if (ce_len < pathlen)
@@ -516,7 +516,7 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
 	 * Even if the beginning compared identically, the ce should
 	 * compare as bigger than a directory leading up to it!
 	 */
-	return ce_namelen(ce) > traverse_path_len(info, n);
+	return ce->ce_namelen > traverse_path_len(info, n);
 }
 
 static int ce_in_traverse_path(const struct cache_entry *ce,
@@ -530,7 +530,7 @@ static int ce_in_traverse_path(const struct cache_entry *ce,
 	 * If ce (blob) is the same name as the path (which is a tree
 	 * we will be descending into), it won't be inside it.
 	 */
-	return (info->pathlen < ce_namelen(ce));
+	return (info->pathlen < ce->ce_namelen);
 }
 
 static struct cache_entry *create_ce_entry(const struct traverse_info *info, const struct name_entry *n, int stage)
@@ -540,6 +540,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info, con
 
 	ce->ce_mode = create_ce_mode(n->mode);
 	ce->ce_flags = create_ce_flags(len, stage);
+	ce->ce_namelen = len;
 	hashcpy(ce->sha1, n->sha1);
 	make_traverse_path(ce->name, info, n);
 
@@ -657,7 +658,7 @@ static int find_cache_pos(struct traverse_info *info,
 		if (ce_slash)
 			ce_len = ce_slash - ce_name;
 		else
-			ce_len = ce_namelen(ce) - pfxlen;
+			ce_len = ce->ce_namelen - pfxlen;
 		cmp = name_compare(p->path, p_len, ce_name, ce_len);
 		/*
 		 * Exact match; if we have a directory we need to
@@ -938,7 +939,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 
 		/* Non-directory */
 		dtype = ce_to_dtype(ce);
-		ret = excluded_from_list(ce->name, ce_namelen(ce), name, &dtype, el);
+		ret = excluded_from_list(ce->name, ce->ce_namelen, name, &dtype, el);
 		if (ret < 0)
 			ret = defval;
 		if (ret > 0)
@@ -1293,7 +1294,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce,
 	     i < o->src_index->cache_nr;
 	     i++) {
 		struct cache_entry *ce2 = o->src_index->cache[i];
-		int len = ce_namelen(ce2);
+		int len = ce2->ce_namelen;
 		if (len < namelen ||
 		    strncmp(ce->name, ce2->name, namelen) ||
 		    ce2->name[namelen] != '/')
@@ -1411,7 +1412,7 @@ static int verify_absent_1(struct cache_entry *ce,
 	if (o->index_only || o->reset || !o->update)
 		return 0;
 
-	len = check_leading_path(ce->name, ce_namelen(ce));
+	len = check_leading_path(ce->name, ce->ce_namelen);
 	if (!len)
 		return 0;
 	else if (len > 0) {
@@ -1430,7 +1431,7 @@ static int verify_absent_1(struct cache_entry *ce,
 				     strerror(errno));
 		return 0;
 	} else {
-		return check_ok_to_remove(ce->name, ce_namelen(ce),
+		return check_ok_to_remove(ce->name, ce->ce_namelen,
 					  ce_to_dtype(ce), ce, &st,
 					  error_type, o);
 	}
-- 
1.7.10.GIT
