From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 19/19] the end goal of the last dozen or so commits, there's no longer a global cache variable
Date: Thu, 21 Apr 2005 11:39:22 -0700
Message-ID: <200504211839.j3LIdMKB027881@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:44:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgeM-0001Fe-Pa
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVDUSrP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVDUSph
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:45:37 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:25993 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261691AbVDUSjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:39:39 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIdJJr028273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:39:20 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIdMiY027884
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:39:22 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIdMKB027881
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:39:22 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 38adb888a4c1adfe083f24d4ec51018e0b5a8335
parent 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac
author Brad Roberts <braddr@puremagic.com> 1114093024 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114093024 -0700

[PATCH] the end goal of the last dozen or so commits, there's no longer a global cache variable

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 cache.h          |   21 +++++++-------
 check-files.c    |   10 +++---
 checkout-cache.c |   20 ++++++-------
 diff-cache.c     |   20 ++++++-------
 merge-cache.c    |   29 ++++++++++---------
 read-cache.c     |   82 ++++++++++++++++++++++++++++---------------------------
 read-tree.c      |   51 ++++++++++++++++++----------------
 show-diff.c      |    8 ++---
 show-files.c     |   27 +++++++++---------
 update-cache.c   |   35 ++++++++++++-----------
 write-tree.c     |   20 ++++++-------
 11 files changed, 167 insertions(+), 156 deletions(-)

Index: cache.h
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/cache.h  (mode:100644 sha1:c64969602d80a0e9d7137b2716fb808c912b075c)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/cache.h  (mode:100644 sha1:d8ade9f4b9bd9b6045f97b4df5bef8356c767d46)
@@ -72,16 +72,17 @@
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /* Initialize and use the cache information */
-extern int read_cache(void);
-extern int write_cache(int newfd);
-extern void free_cache();
-extern int cache_name_pos(const char *name, int namelen);
-extern int add_cache_entry(struct cache_entry *ce, int ok_to_add);
-extern int remove_file_from_cache(char *path);
-extern int get_num_cache_entries();
-extern struct cache_entry * get_cache_entry(int pos);
-extern void set_cache_entry(struct cache_entry *ce, int pos);
-extern int remove_cache_entry_at(int pos);
+extern struct cache *new_cache(void);
+extern struct cache *read_cache(void);
+extern int write_cache(struct cache *cache, int newfd);
+extern void free_cache(struct cache *cache);
+extern int cache_name_pos(struct cache *cache, const char *name, int namelen);
+extern int add_cache_entry(struct cache *cache, struct cache_entry *ce, int ok_to_add);
+extern int remove_file_from_cache(struct cache *cache, char *path);
+extern int get_num_cache_entries(struct cache *cache);
+extern struct cache_entry * get_cache_entry(struct cache *cache, int pos);
+extern void set_cache_entry(struct cache *cache, struct cache_entry *ce, int pos);
+extern int remove_cache_entry_at(struct cache *cache, int pos);
 
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
Index: check-files.c
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/check-files.c  (mode:100644 sha1:0973e81fbbc0f9f98031fb249254bd89d8088889)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/check-files.c  (mode:100644 sha1:4de6d39e4997d29f13261c21eeb378f74b3f8a8f)
@@ -8,7 +8,7 @@
  */
 #include "cache.h"
 
-static void check_file(const char *path)
+static void check_file(struct cache *cache, const char *path)
 {
 	int fd = open(path, O_RDONLY);
 	struct cache_entry *ce;
@@ -23,10 +23,10 @@
 	}
 
 	/* Exists but is not in the cache is not fine */
-	pos = cache_name_pos(path, strlen(path));
+	pos = cache_name_pos(cache, path, strlen(path));
 	if (pos < 0)
 		die("preparing to update existing file '%s' not in cache", path);
-	ce = get_cache_entry(pos);
+	ce = get_cache_entry(cache, pos);
 
 	if (fstat(fd, &st) < 0)
 		die("fstat(%s): %s", path, strerror(errno));
@@ -39,9 +39,9 @@
 int main(int argc, char **argv)
 {
 	int i;
+	struct cache *cache = read_cache();
 
-	read_cache();
 	for (i = 1; i < argc ; i++)
-		check_file(argv[i]);
+		check_file(cache, argv[i]);
 	return 0;
 }
Index: checkout-cache.c
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/checkout-cache.c  (mode:100644 sha1:27b559d5bcc5831eda441bcd1fd88d687f2567b8)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/checkout-cache.c  (mode:100644 sha1:2e8c61323a72f6052d8c9ef76a4eef05aa5ac0f9)
@@ -120,23 +120,23 @@
 	return write_entry(ce);
 }
 
-static int checkout_file(const char *name)
+static int checkout_file(struct cache *cache, const char *name)
 {
-	int pos = cache_name_pos(name, strlen(name));
+	int pos = cache_name_pos(cache, name, strlen(name));
 	if (pos < 0) {
 		if (!quiet)
 			fprintf(stderr, "checkout-cache: %s is not in the cache\n", name);
 		return -1;
 	}
-	return checkout_entry(get_cache_entry(pos));
+	return checkout_entry(get_cache_entry(cache, pos));
 }
 
-static int checkout_all(void)
+static int checkout_all(struct cache *cache)
 {
 	int i;
 
-	for (i = 0; i < get_num_cache_entries() ; i++) {
-		struct cache_entry *ce = get_cache_entry(i);
+	for (i = 0; i < get_num_cache_entries(cache) ; i++) {
+		struct cache_entry *ce = get_cache_entry(cache, i);
 		if (ce_stage(ce))
 			continue;
 		if (checkout_entry(ce) < 0)
@@ -149,15 +149,15 @@
 {
 	int i, force_filename = 0;
 
-	if (read_cache() < 0) {
+	struct cache * cache = read_cache();
+	if (!cache)
 		die("invalid cache");
-	}
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!force_filename) {
 			if (!strcmp(arg, "-a")) {
-				checkout_all();
+				checkout_all(cache);
 				continue;
 			}
 			if (!strcmp(arg, "--")) {
@@ -173,7 +173,7 @@
 				continue;
 			}
 		}
-		checkout_file(arg);
+		checkout_file(cache, arg);
 	}
 	return 0;
 }
Index: diff-cache.c
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/diff-cache.c  (mode:100644 sha1:5ae6d5de5ed5ad34f72267904ff8eb6288855fc5)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/diff-cache.c  (mode:100644 sha1:1d39ca1f79d841e363a4be57871a5c1282d441e1)
@@ -4,7 +4,7 @@
 static int recursive = 0;
 static int line_termination = '\n';
 
-static int diff_cache(void *tree, unsigned long size, int pos, const char *base);
+static int diff_cache(void *tree, unsigned long size, struct cache *cache, int pos, const char *base);
 
 static void update_tree_entry(void **bufp, unsigned long *sizep)
 {
@@ -82,10 +82,10 @@
 }
 
 static int compare_tree_entry(const char *path1, unsigned int mode1, const unsigned char *sha1,
-			      int *pos, const char *base)
+			      struct cache *cache, int *pos, const char *base)
 {
 	int baselen = strlen(base);
-	struct cache_entry *ce = get_cache_entry(*pos);
+	struct cache_entry *ce = get_cache_entry(cache, *pos);
 	const char *path2 = ce->name + baselen;
 	unsigned int mode2 = ntohl(ce->ce_mode);
 	const unsigned char *sha2 = ce->sha1;
@@ -107,7 +107,7 @@
 			memcpy(newbase + baselen + pathlen1, "/", 2);
 			if (!tree || strcmp(type, "tree"))
 				die("unable to read tree object %s", sha1_to_hex(sha1));
-			*pos = diff_cache(tree, size, *pos, newbase);
+			*pos = diff_cache(tree, size, cache, *pos, newbase);
 			free(newbase);
 			free(tree);
 			return -1;
@@ -158,7 +158,7 @@
 	return 0;
 }
 
-static int diff_cache(void *tree, unsigned long size, int pos, const char *base)
+static int diff_cache(void *tree, unsigned long size, struct cache *cache, int pos, const char *base)
 {
 	int baselen = strlen(base);
 
@@ -172,8 +172,8 @@
 		 * No entries in the cache (with this base)?
 		 * Output the tree contents.
 		 */
-		if ((pos == get_num_cache_entries()) ||
-		    ce_namelen(ce = get_cache_entry(pos)) < baselen ||
+		if ((pos == get_num_cache_entries(cache)) ||
+		    ce_namelen(ce = get_cache_entry(cache, pos)) < baselen ||
 		    memcmp(ce->name, base, baselen)) {
 			if (!size)
 				return pos;
@@ -193,7 +193,7 @@
 		}
 
 		sha1 = extract(tree, size, &path, &mode);
-		switch (compare_tree_entry(path, mode, sha1, &pos, base)) {
+		switch (compare_tree_entry(path, mode, sha1, cache, &pos, base)) {
 		case -1:
 			update_tree_entry(&tree, &size);
 			continue;
@@ -215,8 +215,8 @@
 	void *tree;
 	unsigned long size;
 	char type[20];
+	struct cache *cache = read_cache();
 
-	read_cache();
 	while (argc > 2) {
 		char *arg = argv[1];
 		argv++;
@@ -257,5 +257,5 @@
 	if (strcmp(type, "tree"))
 		die("bad tree object %s (%s)", sha1_to_hex(tree_sha1), type);
 
-	return diff_cache(tree, size, 0, "");
+	return diff_cache(tree, size, cache, 0, "");
 }
Index: merge-cache.c
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/merge-cache.c  (mode:100644 sha1:c2f96e7652a2aea9417c3790bfe9ab14ffcdb12f)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/merge-cache.c  (mode:100644 sha1:440d4d6e98d1387c5055ba5539b829e7557d9d4a)
@@ -26,11 +26,11 @@
 		err = 1;
 }
 
-static int merge_entry(int pos, const char *path)
+static int merge_entry(struct cache *cache, int pos, const char *path)
 {
 	int found;
 	
-	if (pos >= get_num_cache_entries())
+	if (pos >= get_num_cache_entries(cache))
 		die("merge-cache: %s not in the cache", path);
 	arguments[0] = pgm;
 	arguments[1] = "";
@@ -40,7 +40,7 @@
 	found = 0;
 	do {
 		static char hexbuf[4][60];
-		struct cache_entry *ce = get_cache_entry(pos);
+		struct cache_entry *ce = get_cache_entry(cache, pos);
 		int stage = ce_stage(ce);
 
 		if (strcmp(ce->name, path))
@@ -48,44 +48,45 @@
 		found++;
 		strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
 		arguments[stage] = hexbuf[stage];
-	} while (++pos < get_num_cache_entries());
+	} while (++pos < get_num_cache_entries(cache));
 	if (!found)
 		die("merge-cache: %s not in the cache", path);
 	run_program();
 	return found;
 }
 
-static void merge_file(const char *path)
+static void merge_file(struct cache *cache, const char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = cache_name_pos(cache, path, strlen(path));
 
 	/*
 	 * If it already exists in the cache as stage0, it's
 	 * already merged and there is nothing to do.
 	 */
 	if (pos < 0)
-		merge_entry(-pos-1, path);
+		merge_entry(cache, -pos-1, path);
 }
 
-static void merge_all(void)
+static void merge_all(struct cache *cache)
 {
 	int i;
-	for (i = 0; i < get_num_cache_entries(); i++) {
-		struct cache_entry *ce = get_cache_entry(i);
+	for (i = 0; i < get_num_cache_entries(cache); i++) {
+		struct cache_entry *ce = get_cache_entry(cache, i);
 		if (!ce_stage(ce))
 			continue;
-		i += merge_entry(i, ce->name)-1;
+		i += merge_entry(cache, i, ce->name)-1;
 	}
 }
 
 int main(int argc, char **argv)
 {
 	int i, force_file = 0;
+	struct cache *cache;
 
 	if (argc < 3)
 		usage("merge-cache <merge-program> (-a | <filename>*)");
 
-	read_cache();
+	cache = read_cache();
 
 	pgm = argv[1];
 	for (i = 2; i < argc; i++) {
@@ -96,12 +97,12 @@
 				continue;
 			}
 			if (!strcmp(arg, "-a")) {
-				merge_all();
+				merge_all(cache);
 				continue;
 			}
 			die("merge-cache: unknown option %s", arg);
 		}
-		merge_file(arg);
+		merge_file(cache, arg);
 	}
 	if (err)
 		die("merge program failed");
Index: read-cache.c
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/read-cache.c  (mode:100644 sha1:8837d27ab683bf07d38aee33c62a90f5a7221588)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/read-cache.c  (mode:100644 sha1:7084fcdf771ddc5bfac38b8778a5904d779de3a4)
@@ -30,18 +30,15 @@
 	unsigned int allocated_entries;
 };
 
-static struct cache * cache = NULL;
-
 struct cache * new_cache()
 {
 	return (struct cache*)calloc(1, sizeof(struct cache));
 }
 
-void free_cache()
+void free_cache(struct cache *cache)
 {
 	munmap(cache->map.ptr, cache->map.size);
 	free(cache);
-	cache = NULL;
 }
 
 int ce_match_stat(struct cache_entry *ce, struct stat *st)
@@ -100,7 +97,7 @@
 	return 0;
 }
 
-int cache_name_pos(const char *name, int namelen)
+int cache_name_pos(struct cache *cache, const char *name, int namelen)
 {
 	int first, last;
 
@@ -122,7 +119,7 @@
 }
 
 /* Remove entry, return true if there are more entries to go.. */
-int remove_cache_entry_at(int pos)
+int remove_cache_entry_at(struct cache *cache, int pos)
 {
 	cache->num_entries--;
 	if (pos >= cache->num_entries)
@@ -131,11 +128,11 @@
 	return 1;
 }
 
-int remove_file_from_cache(char *path)
+int remove_file_from_cache(struct cache *cache, char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = cache_name_pos(cache, path, strlen(path));
 	if (pos >= 0)
-		remove_cache_entry_at(pos);
+		remove_cache_entry_at(cache, pos);
 	return 0;
 }
 
@@ -145,17 +142,17 @@
 	return ce_namelen(b) == len && !memcmp(a->name, b->name, len);
 }
 
-int get_num_cache_entries()
+int get_num_cache_entries(struct cache *cache)
 {
 	return cache->num_entries;
 }
 
-struct cache_entry * get_cache_entry(int pos)
+struct cache_entry * get_cache_entry(struct cache *cache, int pos)
 {
 	return cache->entries[pos];
 }
 
-void set_cache_entry(struct cache_entry *ce, int pos)
+void set_cache_entry(struct cache *cache, struct cache_entry *ce, int pos)
 {
 	/* You can NOT just free cache->entries[i] here, since it
 	 * might not be necessarily malloc()ed but can also come
@@ -163,16 +160,11 @@
 	cache->entries[pos] = ce;
 }
 
-int add_cache_entry(struct cache_entry *ce, int ok_to_add)
+int add_cache_entry(struct cache *cache, struct cache_entry *ce, int ok_to_add)
 {
 	int pos;
 
-	/* temporary, read-tree.c expects the cache to always exist, even
-	 * without a read_cache being called */
-	if (!cache)
-		cache = new_cache();
-
-	pos = cache_name_pos(ce->name, htons(ce->ce_flags));
+	pos = cache_name_pos(cache, ce->name, htons(ce->ce_flags));
 
 	/* existing match? Just replace it */
 	if (pos >= 0) {
@@ -188,7 +180,7 @@
 	if (pos < cache->num_entries && ce_stage(ce) == 0) {
 		while (same_name(cache->entries[pos], ce)) {
 			ok_to_add = 1;
-			if (!remove_cache_entry_at(pos))
+			if (!remove_cache_entry_at(cache, pos))
 				break;
 		}
 	}
@@ -227,29 +219,40 @@
 	return 0;
 }
 
-int read_cache(void)
+struct cache *read_cache(void)
 {
 	int fd, i;
 	struct stat st;
 	unsigned long offset;
+	struct cache *cache;
+
+	cache = new_cache();
+	if (!cache) {
+		errno = ENOMEM;
+		error("unable to allocate cache");
+		return NULL;
+	}
 
-	errno = EBUSY;
-	if (cache)
-		return error("more than one cachefile");
 	errno = ENOENT;
 	sha1_file_directory = getenv(DB_ENVIRONMENT);
 	if (!sha1_file_directory)
 		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
-	if (access(sha1_file_directory, X_OK) < 0)
-		return error("no access to SHA1 file directory");
+	if (access(sha1_file_directory, X_OK) < 0) {
+		error("no access to SHA1 file directory");
+		free(cache);
+		return NULL;
+	}
 	fd = open(".git/index", O_RDONLY);
-	if (fd < 0)
-		return (errno == ENOENT) ? 0 : error("open failed");
-
-	errno = ENOMEM;
-	cache = new_cache();
-	if (!cache)
-		return error("unable to allocate cache");
+	if (fd < 0) {
+		/* TODO: Why special case this?  If we can't get to the data, what's the point? */
+		if (errno == ENOENT)
+			return cache;
+		else {
+			error("open failed");
+			free(cache);
+			return NULL;
+		}
+	}
 
 	cache->map.size = 0; /* avoid gcc warning */
 	cache->map.ptr = (void *)-1;
@@ -261,16 +264,17 @@
 	}
 	close(fd);
 	if (-1 == (int)(long)cache->map.ptr) {
+		error("mmap failed");
 		free(cache);
-		cache = NULL;
-		return error("mmap failed");
+		return NULL;
 	}
 
 	cache->header = cache->map.ptr;
 	if (verify_hdr(cache->header, cache->map.size) < 0) {
-		free_cache();
+		free_cache(cache);
 		errno = EINVAL;
-		return error("verify header failed");
+		error("verify header failed");
+		return NULL;
 	}
 
 	cache->num_entries = ntohl(cache->header->hdr_entries);
@@ -283,7 +287,7 @@
 		offset = offset + ce_size(ce);
 		cache->entries[i] = ce;
 	}
-	return cache->num_entries;
+	return cache;
 }
 
 #define WRITE_BUFFER_SIZE 8192
@@ -329,7 +333,7 @@
 	return 0;
 }
 
-int write_cache(int newfd)
+int write_cache(struct cache *cache, int newfd)
 {
 	SHA_CTX c;
 	struct cache_header hdr;
Index: read-tree.c
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/read-tree.c  (mode:100644 sha1:ad9128f26613a82361475516dd0f2b470f4ce4b3)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/read-tree.c  (mode:100644 sha1:a683b7f60e58514d36218a7b2c2ace2d3ec9f984)
@@ -7,7 +7,7 @@
 
 static int stage = 0;
 
-static int read_one_entry(unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode)
+static int read_one_entry(struct cache *cache, unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode)
 {
 	int len = strlen(pathname);
 	unsigned int size = cache_entry_size(baselen + len);
@@ -20,10 +20,10 @@
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	memcpy(ce->sha1, sha1, 20);
-	return add_cache_entry(ce, 1);
+	return add_cache_entry(cache, ce, 1);
 }
 
-static int read_tree(unsigned char *sha1, const char *base, int baselen)
+static int read_tree(struct cache *cache, unsigned char *sha1, const char *base, int baselen)
 {
 	void *buffer, *bufptr;
 	unsigned long size;
@@ -57,7 +57,7 @@
 			memcpy(newbase, base, baselen);
 			memcpy(newbase + baselen, path, pathlen);
 			newbase[baselen + pathlen] = '/';
-			retval = read_tree(sha1, newbase, baselen + pathlen + 1);
+			retval = read_tree(cache, sha1, newbase, baselen + pathlen + 1);
 			free(newbase);
 			if (retval) {
 				free(buffer);
@@ -65,7 +65,7 @@
 			}
 			continue;
 		}
-		if (read_one_entry(sha1, base, baselen, path, mode) < 0) {
+		if (read_one_entry(cache, sha1, base, baselen, path, mode) < 0) {
 			free(buffer);
 			return -1;
 		}
@@ -149,16 +149,16 @@
 /* rather than doing the 'right' thing of deleting entries as we merge,
  * walk dst through the cache, overwriting entries as we go and at the
  * end truncate the size of the cache */
-static void trivially_merge_cache()
+static void trivially_merge_cache(struct cache *cache)
 {
 	static struct cache_entry null_entry;
 	struct cache_entry *old = &null_entry;
-	int src = 0, dst = 0, nr = get_num_cache_entries();
+	int src = 0, dst = 0, nr = get_num_cache_entries(cache);
 
 	while (src < nr) {
 		struct cache_entry *ce, *result;
 
-		ce = get_cache_entry(src);
+		ce = get_cache_entry(cache, src);
 
 		/* We throw away original cache entries except for the stat information */
 		if (!ce_stage(ce)) {
@@ -168,8 +168,8 @@
 		}
 		if ((src < (nr - 2)) &&
 		    (result = merge_entries(ce,
-					    get_cache_entry(src + 1),
-					    get_cache_entry(src + 2))) != NULL) {
+					    get_cache_entry(cache, src + 1),
+					    get_cache_entry(cache, src + 2))) != NULL) {
 			/*
 			 * See if we can re-use the old CE directly?
 			 * That way we get the uptodate stat info.
@@ -180,27 +180,27 @@
 			ce->ce_flags &= ~htons(CE_STAGEMASK);
 			src += 2;
 		}
-		set_cache_entry(ce, dst);
+		set_cache_entry(cache, ce, dst);
 		dst++;
 		src++;
 	}
 	/* this could be replaced by a truncate api */
 	while (nr > dst) {
 		nr--;
-		remove_cache_entry_at(nr);
+		remove_cache_entry_at(cache, nr);
 	}
 }
 
-static void merge_stat_info()
+static void merge_stat_info(struct cache *cache)
 {
 	static struct cache_entry null_entry;
 	struct cache_entry *old = &null_entry;
-	int src = 0, dst = 0, nr = get_num_cache_entries();
+	int src = 0, dst = 0, nr = get_num_cache_entries(cache);
 
 	while (src < nr) {
 		struct cache_entry *ce;
 
-		ce = get_cache_entry(src);
+		ce = get_cache_entry(cache, src);
 
 		/* We throw away original cache entries except for the stat information */
 		if (!ce_stage(ce)) {
@@ -211,14 +211,14 @@
 		if (path_matches(ce, old) && same(ce, old))
 			*ce = *old;
 		ce->ce_flags &= ~htons(CE_STAGEMASK);
-		set_cache_entry(ce, dst);
+		set_cache_entry(cache, ce, dst);
 		dst++;
 		src++;
 	}
 	/* this could be replaced by a truncate api */
 	while (nr > dst) {
 		nr--;
-		remove_cache_entry_at(nr);
+		remove_cache_entry_at(cache, nr);
 	}
 }
 
@@ -226,6 +226,7 @@
 {
 	int i, newfd, merge;
 	unsigned char sha1[20];
+	struct cache *cache = NULL;
 
 	newfd = open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (newfd < 0)
@@ -242,9 +243,9 @@
 			int i;
 			if (stage)
 				usage("-m needs to come first");
-			read_cache();
-			for (i = 0; i < get_num_cache_entries(); i++) {
-				if (ce_stage(get_cache_entry(i)))
+			cache = read_cache();
+			for (i = 0; i < get_num_cache_entries(cache); i++) {
+				if (ce_stage(get_cache_entry(cache, i)))
 					usage("you need to resolve your current index first");
 			}
 			stage = 1;
@@ -255,23 +256,25 @@
 			usage("read-tree [-m] <sha1>");
 		if (stage > 3)
 			usage("can't merge more than two trees");
-		if (read_tree(sha1, "", 0) < 0)
+		if (!cache)
+			cache = new_cache();
+		if (read_tree(cache, sha1, "", 0) < 0)
 			die("failed to unpack tree object %s", arg);
 		stage++;
 	}
 	if (merge) {
 		switch (stage) {
 		case 4:	/* Three-way merge */
-			trivially_merge_cache();
+			trivially_merge_cache(cache);
 			break;
 		case 2:	/* Just read a tree, merge with old cache contents */
-			merge_stat_info();
+			merge_stat_info(cache);
 			break;
 		default:
 			die("just how do you expect me to merge %d trees?", stage-1);
 		}
 	}
-	if (write_cache(newfd) ||
+	if (write_cache(cache, newfd) ||
 	    rename(".git/index.lock", ".git/index"))
 		die("unable to write new index file");
 	remove_lock = 0;
Index: show-diff.c
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/show-diff.c  (mode:100644 sha1:4a0902f50b3120b7791a4d4627a9a4f729afdcf7)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/show-diff.c  (mode:100644 sha1:d61bf6dea8106599c25ac5071743b351f6e000ce)
@@ -129,9 +129,9 @@
 	int entries;
 	int matched = 0;
 	int i;
+	struct cache *cache = read_cache();
 
-	read_cache();
-	entries = get_num_cache_entries();
+	entries = get_num_cache_entries(cache);
 	if (entries < 0) {
 		perror("read_cache");
 		exit(1);
@@ -157,7 +157,7 @@
 	prepare_diff_cmd();
 	for (i = 0; i < entries; i++) {
 		struct stat st;
-		struct cache_entry *ce = get_cache_entry(i);
+		struct cache_entry *ce = get_cache_entry(cache, i);
 		int changed;
 		unsigned long size;
 		char type[20];
@@ -175,7 +175,7 @@
 				printf("%s: Unmerged\n",
 				       ce->name);
 			while (i < entries &&
-			       !strcmp(ce->name, get_cache_entry(i)->name))
+			       !strcmp(ce->name, get_cache_entry(cache, i)->name))
 				i++;
 			i--; /* compensate for loop control increments */
 			continue;
Index: show-files.c
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/show-files.c  (mode:100644 sha1:11fbbccef2df50d528105ceb48b15275f2a5693e)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/show-files.c  (mode:100644 sha1:c8dc21d0dd3f5db3f7016323859c58449968d800)
@@ -27,11 +27,11 @@
 static int nr_dir;
 static int dir_alloc;
 
-static void add_name(const char *pathname, int len)
+static void add_name(struct cache *cache, const char *pathname, int len)
 {
 	char *name;
 
-	if (cache_name_pos(pathname, len) >= 0)
+	if (cache_name_pos(cache, pathname, len) >= 0)
 		return;
 
 	if (nr_dir == dir_alloc) {
@@ -51,7 +51,7 @@
  * Also, we currently ignore all names starting with a dot.
  * That likely will not change.
  */
-static void read_directory(const char *path, const char *base, int baselen)
+static void read_directory(struct cache *cache, const char *path, const char *base, int baselen)
 {
 	DIR *dir = opendir(path);
 
@@ -82,12 +82,12 @@
 				/* fallthrough */
 			case DT_DIR:
 				memcpy(fullname + baselen + len, "/", 2);
-				read_directory(fullname, fullname, baselen + len + 1);
+				read_directory(cache, fullname, fullname, baselen + len + 1);
 				continue;
 			case DT_REG:
 				break;
 			}
-			add_name(fullname, baselen + len);
+			add_name(cache, fullname, baselen + len);
 		}
 		closedir(dir);
 	}
@@ -102,13 +102,13 @@
 	return cache_name_compare(n1, l1, n2, l2);
 }
 
-static void show_files(void)
+static void show_files(struct cache *cache)
 {
 	int i;
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others | show_ignored) {
-		read_directory(".", "", 0);
+		read_directory(cache, ".", "", 0);
 		qsort(dir, nr_dir, sizeof(char *), cmp_name);
 	}
 	if (show_others) {
@@ -116,8 +116,8 @@
 			printf("%s%s%c", tag_other, dir[i], line_terminator);
 	}
 	if (show_cached | show_stage) {
-		for (i = 0; i < get_num_cache_entries(); i++) {
-			struct cache_entry *ce = get_cache_entry(i);
+		for (i = 0; i < get_num_cache_entries(cache); i++) {
+			struct cache_entry *ce = get_cache_entry(cache, i);
 			if (show_unmerged && !ce_stage(ce))
 				continue;
 			if (!show_stage)
@@ -136,8 +136,8 @@
 		}
 	}
 	if (show_deleted) {
-		for (i = 0; i < get_num_cache_entries(); i++) {
-			struct cache_entry *ce = get_cache_entry(i);
+		for (i = 0; i < get_num_cache_entries(cache); i++) {
+			struct cache_entry *ce = get_cache_entry(cache, i);
 			struct stat st;
 			if (!stat(ce->name, &st))
 				continue;
@@ -152,6 +152,7 @@
 int main(int argc, char **argv)
 {
 	int i;
+	struct cache *cache;
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -202,7 +203,7 @@
 	if (!(show_stage | show_deleted | show_others | show_ignored | show_unmerged))
 		show_cached = 1;
 
-	read_cache();
-	show_files();
+	cache = read_cache();
+	show_files(cache);
 	return 0;
 }
Index: update-cache.c
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/update-cache.c  (mode:100644 sha1:3f251552283667c42797835088a4922ef865fe4a)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/update-cache.c  (mode:100644 sha1:565638acd2380023ea69e82316a7ab77d95d8ee7)
@@ -85,7 +85,7 @@
 	ce->ce_size = htonl(st->st_size);
 }
 
-static int add_file_to_cache(char *path)
+static int add_file_to_cache(struct cache *cache, char *path)
 {
 	int size, namelen;
 	struct cache_entry *ce;
@@ -96,7 +96,7 @@
 	if (fd < 0) {
 		if (errno == ENOENT) {
 			if (allow_remove)
-				return remove_file_from_cache(path);
+				return remove_file_from_cache(cache, path);
 		}
 		return -1;
 	}
@@ -117,7 +117,7 @@
 		free(ce);
 		return -1;
 	}
-	if (add_cache_entry(ce, allow_add)) {
+	if (add_cache_entry(cache, ce, allow_add)) {
 		free(ce);
 		return -1;
 	}
@@ -200,17 +200,17 @@
 	return updated;
 }
 
-static void refresh_cache(void)
+static void refresh_cache(struct cache *cache)
 {
 	int i;
 
-	for (i = 0; i < get_num_cache_entries(); i++) {
+	for (i = 0; i < get_num_cache_entries(cache); i++) {
 		struct cache_entry *ce, *new;
-		ce = get_cache_entry(i);
+		ce = get_cache_entry(cache, i);
 		if (ce_stage(ce)) {
 			printf("%s: needs merge\n", ce->name);
-			while ((i < get_num_cache_entries()) &&
-			       ! strcmp(get_cache_entry(i)->name, ce->name))
+			while ((i < get_num_cache_entries(cache)) &&
+			       ! strcmp(get_cache_entry(cache, i)->name, ce->name))
 				i++;
 			i--;
 			continue;
@@ -221,7 +221,7 @@
 			printf("%s: needs update\n", ce->name);
 			continue;
 		}
-		set_cache_entry(new, i);
+		set_cache_entry(cache, new, i);
 	}
 }
 
@@ -253,7 +253,7 @@
 	}
 }
 
-static int add_cacheinfo(char *arg1, char *arg2, char *arg3)
+static int add_cacheinfo(struct cache *cache, char *arg1, char *arg2, char *arg3)
 {
 	int size, len;
 	unsigned int mode;
@@ -276,7 +276,7 @@
 	memcpy(ce->name, arg3, len);
 	ce->ce_flags = htons(len);
 	ce->ce_mode = create_ce_mode(mode);
-	return add_cache_entry(ce, allow_add);
+	return add_cache_entry(cache, ce, allow_add);
 }
 
 static int remove_lock = 0;
@@ -291,6 +291,7 @@
 {
 	int i, newfd, entries;
 	int allow_options = 1;
+	struct cache *cache = NULL;
 
 	newfd = open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (newfd < 0)
@@ -299,8 +300,8 @@
 	atexit(remove_lock_file);
 	remove_lock = 1;
 
-	read_cache();
-	entries = get_num_cache_entries();
+	cache = read_cache();
+	entries = get_num_cache_entries(cache);
 	if (entries < 0)
 		die("cache corrupted");
 
@@ -321,11 +322,11 @@
 				continue;
 			}
 			if (!strcmp(path, "--refresh")) {
-				refresh_cache();
+				refresh_cache(cache);
 				continue;
 			}
 			if (!strcmp(path, "--cacheinfo")) {
-				if (i+3 >= argc || add_cacheinfo(argv[i+1], argv[i+2], argv[i+3]))
+				if (i+3 >= argc || add_cacheinfo(cache, argv[i+1], argv[i+2], argv[i+3]))
 					die("update-cache: --cacheinfo <mode> <sha1> <path>");
 				i += 3;
 				continue;
@@ -336,10 +337,10 @@
 			fprintf(stderr, "Ignoring path %s\n", argv[i]);
 			continue;
 		}
-		if (add_file_to_cache(path))
+		if (add_file_to_cache(cache, path))
 			die("Unable to add %s to database", path);
 	}
-	if (write_cache(newfd) ||
+	if (write_cache(cache, newfd) ||
 	    rename(".git/index.lock", ".git/index"))
 		die("Unable to write new cachefile");
 
Index: write-tree.c
===================================================================
--- 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/write-tree.c  (mode:100644 sha1:92e707fd4780805da160ce6fa282e75111ea67b9)
+++ 7e396358c12c0129bcb4945e3e35a4fa76890a0c:1/write-tree.c  (mode:100644 sha1:ad148b422ffa85d7ecf515e55538c1afa13f17d6)
@@ -29,7 +29,7 @@
 
 #define ORIG_OFFSET (40)	/* Enough space to add the header of "tree <size>\0" */
 
-static int write_tree(int start_pos, const char *base, int baselen, unsigned char *returnsha1)
+static int write_tree(struct cache *cache, int start_pos, const char *base, int baselen, unsigned char *returnsha1)
 {
 	unsigned char subdir_sha1[20];
 	unsigned long size, offset;
@@ -43,7 +43,7 @@
 
 	nr = 0;
 	do {
-		struct cache_entry *ce = get_cache_entry(start_pos + nr);
+		struct cache_entry *ce = get_cache_entry(cache, start_pos + nr);
 		const char *pathname = ce->name, *filename, *dirname;
 		int pathlen = ce_namelen(ce), entrylen;
 		unsigned char *sha1;
@@ -59,7 +59,7 @@
 		if (dirname) {
 			int subdir_written;
 
-			subdir_written = write_tree(start_pos + nr, pathname, dirname-pathname+1, subdir_sha1);
+			subdir_written = write_tree(cache, start_pos + nr, pathname, dirname-pathname+1, subdir_sha1);
 			nr += subdir_written;
 
 			/* Now we need to write out the directory entry into this tree.. */
@@ -87,7 +87,7 @@
 		memcpy(buffer + offset, sha1, 20);
 		offset += 20;
 		nr++;
-	} while ((start_pos + nr) < get_num_cache_entries());
+	} while ((start_pos + nr) < get_num_cache_entries(cache));
 
 	i = prepend_integer(buffer, offset - ORIG_OFFSET, ORIG_OFFSET);
 	i -= 5;
@@ -101,18 +101,18 @@
 int main(int argc, char **argv)
 {
 	int i, unmerged;
-	int entries;
 	unsigned char sha1[20];
+	struct cache *cache = read_cache();
+	int entries;
 
-	read_cache();
-	entries = get_num_cache_entries();
-	if (entries <= 0)
+	if (!cache)
 		die("write-tree: no cache contents to write");
+	entries = get_num_cache_entries(cache);
 
 	/* Verify that the tree is merged */
 	unmerged = 0;
 	for (i = 0; i < entries; i++) {
-		struct cache_entry *ce = get_cache_entry(i);
+		struct cache_entry *ce = get_cache_entry(cache, i);
 		if (ntohs(ce->ce_flags) & ~CE_NAMEMASK) {
 			if (++unmerged > 10) {
 				fprintf(stderr, "...\n");
@@ -125,7 +125,7 @@
 		die("write-tree: not able to write tree");
 
 	/* Ok, write it out */
-	if (write_tree(0, "", 0, sha1) != entries)
+	if (write_tree(cache, 0, "", 0, sha1) != entries)
 		die("write-tree: internal error");
 	printf("%s\n", sha1_to_hex(sha1));
 	return 0;

