From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 15/19] introduce a cache struct and move the various cache globals into it.
Date: Thu, 21 Apr 2005 11:38:20 -0700
Message-ID: <200504211838.j3LIcKph027789@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:35:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgVq-0008KS-RC
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVDUSjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVDUSjT
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:39:19 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:5257 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261680AbVDUSi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:38:26 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIcImD028145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:38:18 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIcKjk027791
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:38:20 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIcKph027789
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:38:20 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree c806c7328a6c9297df108ab00ebe1c4014496cb0
parent b7d4fa53d4ee449b4b9b4f3c9dd40d6c99db4bc1
author Brad Roberts <braddr@puremagic.com> 1114086327 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114086327 -0700

[PATCH] introduce a cache struct and move the various cache globals into it.

New elements in the cache struct that previously were discarded:
  - the cache headers
  - the mmap info so we can cleanup later

For this stage, the cache itself is still a global variable.  That will change.

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 cache.h      |    1 
 read-cache.c |  127 ++++++++++++++++++++++++++++++++++-------------------------
 2 files changed, 76 insertions(+), 52 deletions(-)

Index: cache.h
===================================================================
--- b7d4fa53d4ee449b4b9b4f3c9dd40d6c99db4bc1:1/cache.h  (mode:100644 sha1:74d6c4d25c564e08eadc04aaef31a711d0645a43)
+++ f07f7073f45a7f81e5b6cf26f5181e14fd051d81:1/cache.h  (mode:100644 sha1:a3018f9e12bfdd1a5273b20fcab5062667c6caec)
@@ -72,6 +72,7 @@
 /* Initialize and use the cache information */
 extern int read_cache(void);
 extern int write_cache(int newfd);
+extern void free_cache();
 extern int cache_name_pos(const char *name, int namelen);
 extern int add_cache_entry(struct cache_entry *ce, int ok_to_add);
 extern int remove_file_from_cache(char *path);
Index: read-cache.c
===================================================================
--- b7d4fa53d4ee449b4b9b4f3c9dd40d6c99db4bc1:1/read-cache.c  (mode:100644 sha1:b16a72dc4e4525a7df060b3a43722217db7869c2)
+++ f07f7073f45a7f81e5b6cf26f5181e14fd051d81:1/read-cache.c  (mode:100644 sha1:c399f8e497441147afe630ca080558a8c6c79c78)
@@ -17,8 +17,20 @@
 	unsigned int hdr_entries;
 };
 
-static struct cache_entry **active_cache = NULL;
-static unsigned int active_nr = 0, active_alloc = 0;
+struct mmap_holder {
+	void * ptr;
+	size_t size;
+};
+
+struct cache {
+	struct mmap_holder   map;
+	struct cache_header *header;
+	struct cache_entry **entries;
+	unsigned int num_entries;
+	unsigned int allocated_entries;
+};
+
+static struct cache * cache = NULL;
 
 int cache_match_stat(struct cache_entry *ce, struct stat *st)
 {
@@ -81,10 +93,10 @@
 	int first, last;
 
 	first = 0;
-	last = active_nr;
+	last = cache->num_entries;
 	while (last > first) {
 		int next = (last + first) >> 1;
-		struct cache_entry *ce = active_cache[next];
+		struct cache_entry *ce = cache->entries[next];
 		int cmp = cache_name_compare(name, namelen, ce->name, htons(ce->ce_flags));
 		if (!cmp)
 			return next;
@@ -100,10 +112,10 @@
 /* Remove entry, return true if there are more entries to go.. */
 int remove_cache_entry_at(int pos)
 {
-	active_nr--;
-	if (pos >= active_nr)
+	cache->num_entries--;
+	if (pos >= cache->num_entries)
 		return 0;
-	memmove(active_cache + pos, active_cache + pos + 1, (active_nr - pos) * sizeof(struct cache_entry *));
+	memmove(cache->entries + pos, cache->entries + pos + 1, (cache->num_entries - pos) * sizeof(struct cache_entry *));
 	return 1;
 }
 
@@ -123,20 +135,20 @@
 
 int get_num_cache_entries()
 {
-	return active_nr;
+	return cache->num_entries;
 }
 
 struct cache_entry * get_cache_entry(int pos)
 {
-	return active_cache[pos];
+	return cache->entries[pos];
 }
 
 void set_cache_entry(struct cache_entry *ce, int pos)
 {
-	/* You can NOT just free active_cache[i] here, since it
+	/* You can NOT just free cache->entries[i] here, since it
 	 * might not be necessarily malloc()ed but can also come
 	 * from mmap(). */
-	active_cache[pos] = ce;
+	cache->entries[pos] = ce;
 }
 
 int add_cache_entry(struct cache_entry *ce, int ok_to_add)
@@ -147,7 +159,7 @@
 
 	/* existing match? Just replace it */
 	if (pos >= 0) {
-		active_cache[pos] = ce;
+		cache->entries[pos] = ce;
 		return 0;
 	}
 	pos = -pos-1;
@@ -156,8 +168,8 @@
 	 * Inserting a merged entry ("stage 0") into the index
 	 * will always replace all non-merged entries..
 	 */
-	if (pos < active_nr && ce_stage(ce) == 0) {
-		while (same_name(active_cache[pos], ce)) {
+	if (pos < cache->num_entries && ce_stage(ce) == 0) {
+		while (same_name(cache->entries[pos], ce)) {
 			ok_to_add = 1;
 			if (!remove_cache_entry_at(pos))
 				break;
@@ -168,16 +180,16 @@
 		return -1;
 
 	/* Make sure the array is big enough .. */
-	if (active_nr == active_alloc) {
-		active_alloc = alloc_nr(active_alloc);
-		active_cache = realloc(active_cache, active_alloc * sizeof(struct cache_entry *));
+	if (cache->num_entries == cache->allocated_entries) {
+		cache->allocated_entries = alloc_nr(cache->allocated_entries);
+		cache->entries = realloc(cache->entries, cache->allocated_entries * sizeof(struct cache_entry *));
 	}
 
 	/* Add it in.. */
-	active_nr++;
-	if (active_nr > pos)
-		memmove(active_cache + pos + 1, active_cache + pos, (active_nr - pos - 1) * sizeof(ce));
-	active_cache[pos] = ce;
+	cache->num_entries++;
+	if (cache->num_entries > pos)
+		memmove(cache->entries + pos + 1, cache->entries + pos, (cache->num_entries - pos - 1) * sizeof(ce));
+	cache->entries[pos] = ce;
 	return 0;
 }
 
@@ -202,12 +214,10 @@
 {
 	int fd, i;
 	struct stat st;
-	unsigned long size, offset;
-	void *map;
-	struct cache_header *hdr;
+	unsigned long offset;
 
 	errno = EBUSY;
-	if (active_cache)
+	if (cache)
 		return error("more than one cachefile");
 	errno = ENOENT;
 	sha1_file_directory = getenv(DB_ENVIRONMENT);
@@ -219,38 +229,44 @@
 	if (fd < 0)
 		return (errno == ENOENT) ? 0 : error("open failed");
 
-	size = 0; /* avoid gcc warning */
-	map = (void *)-1;
+	errno = ENOMEM;
+	cache = (struct cache*)malloc(sizeof(struct cache));
+	if (!cache)
+		return error("unable to allocate cache");
+
+	cache->map.size = 0; /* avoid gcc warning */
+	cache->map.ptr = (void *)-1;
 	if (!fstat(fd, &st)) {
-		size = st.st_size;
+		cache->map.size = st.st_size;
 		errno = EINVAL;
-		if (size >= sizeof(struct cache_header) + 20)
-			map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (cache->map.size >= sizeof(struct cache_header) + 20)
+			cache->map.ptr = mmap(NULL, cache->map.size, PROT_READ, MAP_PRIVATE, fd, 0);
 	}
 	close(fd);
-	if (-1 == (int)(long)map)
+	if (-1 == (int)(long)cache->map.ptr) {
+		free(cache);
+		cache = NULL;
 		return error("mmap failed");
+	}
 
-	hdr = map;
-	if (verify_hdr(hdr, size) < 0)
-		goto unmap;
-
-	active_nr = ntohl(hdr->hdr_entries);
-	active_alloc = alloc_nr(active_nr);
-	active_cache = calloc(active_alloc, sizeof(struct cache_entry *));
-
-	offset = sizeof(*hdr);
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = map + offset;
-		offset = offset + ce_size(ce);
-		active_cache[i] = ce;
+	cache->header = cache->map.ptr;
+	if (verify_hdr(cache->header, cache->map.size) < 0) {
+		free_cache();
+		errno = EINVAL;
+		return error("verify header failed");
 	}
-	return active_nr;
 
-unmap:
-	munmap(map, size);
-	errno = EINVAL;
-	return error("verify header failed");
+	cache->num_entries = ntohl(cache->header->hdr_entries);
+	cache->allocated_entries = alloc_nr(cache->num_entries);
+	cache->entries = calloc(cache->allocated_entries, sizeof(struct cache_entry *));
+
+	offset = sizeof(*cache->header);
+	for (i = 0; i < cache->num_entries; i++) {
+		struct cache_entry *ce = cache->map.ptr + offset;
+		offset = offset + ce_size(ce);
+		cache->entries[i] = ce;
+	}
+	return cache->num_entries;
 }
 
 #define WRITE_BUFFER_SIZE 8192
@@ -304,16 +320,23 @@
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
 	hdr.hdr_version = htonl(2);
-	hdr.hdr_entries = htonl(active_nr);
+	hdr.hdr_entries = htonl(cache->num_entries);
 
 	SHA1_Init(&c);
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < cache->num_entries; i++) {
+		struct cache_entry *ce = cache->entries[i];
 		if (ce_write(&c, newfd, ce, ce_size(ce)) < 0)
 			return -1;
 	}
 	return ce_flush(&c, newfd);
 }
+
+void free_cache()
+{
+	munmap(cache->map.ptr, cache->map.size);
+	free(cache);
+	cache = NULL;
+}

