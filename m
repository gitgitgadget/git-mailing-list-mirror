From: "Geoffrey Irving" <irving@naml.us>
Subject: [PATCH / RFC] cherry: cache commit to patch-id pairs to avoid repeating work
Date: Sat, 7 Jun 2008 16:36:08 -0700
Message-ID: <7f9d599f0806071636j1df57b6eqb5808f083dafd6a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 01:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K57ye-0006Uq-0a
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 01:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbYFGXgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 19:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbYFGXgM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 19:36:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:29144 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbYFGXgL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 19:36:11 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2044411rvb.1
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 16:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=mDQxoMz7+wIPHJBi56iftB6j43j8goNLYk/GhjkShn0=;
        b=elCIGteBJQdH+f2fk64xog1d7FnP6bQolMS8k9wZa5mTv5rtz6+27qx8UWrfi7hu/7
         A/XsRNv60bM0eqcZKDHnqcH5rMdIwvwpdxMg6MSHAy1IHgslkNWVNsmEaNGvRyIdJcvQ
         m+jCjB4wGnj8SPNwUy0dsRmI9jVuXGkEdml/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=P2/Av/phi/01wbGghz2fY3h/Rc3sX8Ai3XOHA1HdoJxzeFE1swsHXeV0lXuWQp9wOH
         xJHgLZx9sn6XQvmv0I+lqR5fvv95Ei+ZyD3syW+zxE1bSqDPcvdpn2LFhdAjhg6H8ynh
         LxZE+paw+V8t5s0C3oFYsKzGzp2JtnL1tmiys=
Received: by 10.141.176.6 with SMTP id d6mr1059695rvp.118.1212881768877;
        Sat, 07 Jun 2008 16:36:08 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Sat, 7 Jun 2008 16:36:08 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: aadb8f67eee2d4d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84231>

Added cached-sha-map.[hc] implementing a persistent hash map from sha1 to sha1.
The map is read with mmap, and completely rewritten if any entries change.  It
would be good to add incremental update to handle the usual case where only a
few entries change.

This structure is used by patch-ids.c to cache the mapping from commit to
patch-id into $GIT_DIR/patch-id-cache.  In the one case I've tested so far,
this speeds up the second invocation of git-cherry by two orders of magnitude.

Original code cannibalized from Johannes Schindelin's notes-index structure.
---
 Makefile          |    2 +
 cached-sha1-map.c |  182 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 cached-sha1-map.h |   45 +++++++++++++
 patch-ids.c       |   18 +++++-
 4 files changed, 246 insertions(+), 1 deletions(-)
 create mode 100644 cached-sha1-map.c
 create mode 100644 cached-sha1-map.h

diff --git a/Makefile b/Makefile
index cce5a6e..013b5d8 100644
--- a/Makefile
+++ b/Makefile
@@ -357,6 +357,7 @@ LIB_H += pack.h
 LIB_H += pack-revindex.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
+LIB_H += cached-sha1-map.h
 LIB_H += path-list.h
 LIB_H += pkt-line.h
 LIB_H += progress.h
@@ -435,6 +436,7 @@ LIB_OBJS += pager.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
+LIB_OBJS += cached-sha1-map.o
 LIB_OBJS += path-list.o
 LIB_OBJS += path.o
 LIB_OBJS += pkt-line.o
diff --git a/cached-sha1-map.c b/cached-sha1-map.c
new file mode 100644
index 0000000..e363745
--- /dev/null
+++ b/cached-sha1-map.c
@@ -0,0 +1,182 @@
+#include "cached-sha1-map.h"
+
+union cached_sha1_map_header {
+	struct {
+		char signature[4]; /* HASH */
+		off_t count, size;
+	};
+	struct cached_sha1_entry padding; /* pad header out to 40 bytes */
+};
+
+static const char *signature = "HASH";
+
+static void init_empty_map(struct cached_sha1_map *cache, size_t size)
+{
+	cache->count = 0;
+	cache->size = size;
+	cache->initialized = 1;
+	cache->dirty = 1;
+	cache->mmapped = 0;
+	cache->entries = xcalloc(size, sizeof(struct cached_sha1_entry));
+}
+
+static void grow_map(struct cached_sha1_map *cache)
+{
+	struct cached_sha1_map new_cache;
+	size_t i;
+
+	/* allocate cache with twice the size */
+	new_cache.filename = cache->filename;
+	init_empty_map(&new_cache, cache->size * 2);
+
+	/* reinsert all entries */
+ 	for (i = 0; i < cache->size; i++)
+		if (!is_null_sha1(cache->entries[i].key))
+			set_cached_sha1_entry(&new_cache,
+				cache->entries[i].key, cache->entries[i].value);
+	/* finish */
+	free_cached_sha1_map(cache);
+	*cache = new_cache;
+}
+
+static void init_cached_sha1_map(struct cached_sha1_map *cache)
+{
+	int fd;
+	union cached_sha1_map_header header;
+
+	if (cache->initialized)
+		return;
+
+	fd = open(git_path(cache->filename), O_RDONLY);
+	if (fd < 0) {
+		init_empty_map(cache, 64);
+		return;
+	}
+
+	if (read_in_full(fd, &header, sizeof(header)) != sizeof(header))
+		die("cannot read %s header", cache->filename);
+
+	if (memcmp(header.signature, signature, 4))
+		die("%s has invalid header", cache->filename);
+
+	if (header.size & (header.size-1))
+		die("%s size %lld is not a power of two", cache->filename,
+			(long long)header.size);
+
+	cache->count = header.count;
+	cache->size = header.size;
+	cache->dirty = 0;
+	cache->initialized = 1;
+	cache->mmapped = 1;
+
+	/* check off_t to size_t conversion */
+	if (cache->count != header.count || cache->size != header.size)
+		die("%s is too large to hold in memory", cache->filename);
+
+	/* mmap entire file so that file / memory blocks are aligned */
+	cache->entries = xmmap(NULL,
+		sizeof(struct cached_sha1_entry) * (header.size + 1),
+		PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	cache->entries += 1; /* skip header */
+	close(fd);
+}
+
+int write_cached_sha1_map(struct cached_sha1_map *cache)
+{
+	union cached_sha1_map_header header;
+	struct lock_file update_lock;
+	int fd;
+	size_t entry_size;
+
+	if (!cache->initialized || !cache->dirty)
+		return 0;
+
+	fd = hold_lock_file_for_update(&update_lock,
+			git_path(cache->filename), 0);
+
+	if (fd < 0)
+		return error("could not construct %s", cache->filename);
+
+	memcpy(header.signature, signature, 4);
+	header.count = cache->count;
+	header.size = cache->size;
+	entry_size = sizeof(struct cached_sha1_entry) * cache->size;
+	if (write_in_full(fd, &header, sizeof(header)) != sizeof(header)
+		|| write_in_full(fd, cache->entries, entry_size) != entry_size)
+		return error("could not write %s", cache->filename);
+
+	if (commit_lock_file(&update_lock) < 0)
+		return error("could not write %s", cache->filename);
+
+	cache->dirty = 0;
+	return 0;
+}
+
+void free_cached_sha1_map(struct cached_sha1_map *cache)
+{
+	if (!cache->initialized)
+		return;
+
+	if (cache->mmapped)
+		munmap(cache->entries - 1,
+			sizeof(struct cached_sha1_entry) * (cache->size + 1));
+	else
+		free(cache->entries);
+}
+
+static size_t get_hash_index(const unsigned char *sha1)
+{
+	return ntohl(*(size_t*)sha1);
+}
+
+int get_cached_sha1_entry(struct cached_sha1_map *cache,
+	const unsigned char *key, unsigned char *value)
+{
+	size_t i, mask;
+
+	if (!cache->initialized)
+		init_cached_sha1_map(cache);
+
+	mask = cache->size - 1;
+
+	for (i = get_hash_index(key) & mask; ; i = (i+1) & mask) {
+		if (!hashcmp(key, cache->entries[i].key)) {
+			hashcpy(value, cache->entries[i].value);
+			return 0;
+		} else if (is_null_sha1(cache->entries[i].key))
+			return -1;
+	}
+}
+
+void set_cached_sha1_entry(struct cached_sha1_map *cache,
+	const unsigned char *key, const unsigned char *value)
+{
+	size_t i, mask;
+	struct cached_sha1_entry *entry;
+
+	if (!cache->initialized)
+		init_cached_sha1_map(cache);
+
+	if (4*cache->count >= 3*cache->size)
+		grow_map(cache);
+
+	mask = cache->size - 1;
+
+	for (i = get_hash_index(key) & mask; ; i = (i+1) & mask) {
+		entry = cache->entries+i;
+
+		if (is_null_sha1(entry->key)) {
+			hashcpy(entry->key, key);
+			hashcpy(entry->value, value);
+			cache->count++;
+			cache->dirty = 1;
+			return;
+		} else if(!hashcmp(key, entry->key)) {
+			if (hashcmp(value, entry->value)) {
+				hashcpy(entry->value, value);
+				cache->dirty = 1;
+			}
+			return;
+		}
+	}
+}
diff --git a/cached-sha1-map.h b/cached-sha1-map.h
new file mode 100644
index 0000000..f592d07
--- /dev/null
+++ b/cached-sha1-map.h
@@ -0,0 +1,45 @@
+#ifndef CACHED_SHA1_MAP_H
+#define CACHED_SHA1_MAP_H
+
+#include "cache.h"
+
+/*
+ * A cached-sha1-map is a file storing a hash map from sha1 to sha1.
+ *
+ * The file is mmap'ed, updated in memory during operation, and flushed
+ * back to disk when freed.  Currently the entire file is rewritten for
+ * any change.  This could be a significant bottleneck for common uses,
+ * so it would be good to fix this later if possible.
+ *
+ * The performance of a hash map depends highly on a good hashing
+ * algorithm, to avoid collisions.  Lucky us!  SHA-1 is a pretty good
+ * hashing algorithm.
+ */
+
+struct cached_sha1_entry {
+	unsigned char key[20];
+	unsigned char value[20];
+};
+
+struct cached_sha1_map {
+	const char *filename; /* relative to GIT_DIR */
+
+	/* rest is for internal use */
+	size_t count, size;
+	unsigned int initialized : 1;
+	unsigned int dirty : 1;
+	unsigned int mmapped : 1;
+	struct cached_sha1_entry *entries; /* pointer to mmap'ed memory + 1 */
+};
+
+extern int get_cached_sha1_entry(struct cached_sha1_map *cache,
+	const unsigned char *key,unsigned char *value);
+
+extern void set_cached_sha1_entry(struct cached_sha1_map *cache,
+	const unsigned char *key, const unsigned char *value);
+
+extern int write_cached_sha1_map(struct cached_sha1_map *cache);
+
+extern void free_cached_sha1_map(struct cached_sha1_map *cache);
+
+#endif
diff --git a/patch-ids.c b/patch-ids.c
index 3be5d31..36332f3 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -2,17 +2,31 @@
 #include "diff.h"
 #include "commit.h"
 #include "patch-ids.h"
+#include "cached-sha1-map.h"
+
+struct cached_sha1_map patch_id_cache;

 static int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1)
 {
+	/* pull patch-id out of the cache if possible */
+	patch_id_cache.filename = "patch-id-cache";
+	if (!get_cached_sha1_entry(&patch_id_cache, commit->object.sha1, sha1))
+		return 0;
+
 	if (commit->parents)
 		diff_tree_sha1(commit->parents->item->object.sha1,
 		               commit->object.sha1, "", options);
 	else
 		diff_root_tree_sha1(commit->object.sha1, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1);
+	int ret = diff_flush_patch_id(options, sha1);
+	if (ret)
+		return ret;
+
+	/* record commit, patch-id pair in cache */
+	set_cached_sha1_entry(&patch_id_cache, commit->object.sha1, sha1);
+	return 0;
 }

 static uint32_t take2(const unsigned char *id)
@@ -136,6 +150,8 @@ int free_patch_ids(struct patch_ids *ids)
 		next = patches->next;
 		free(patches);
 	}
+
+	write_cached_sha1_map(&patch_id_cache);
 	return 0;
 }

-- 
1.5.4.5
