From: "Geoffrey Irving" <irving@naml.us>
Subject: [PATCH 1/3] cherry: cache patch-ids to avoid repeating work
Date: Tue, 8 Jul 2008 20:53:05 -0700
Message-ID: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 05:54:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGQl1-0000Gr-IY
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 05:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbYGIDxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 23:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbYGIDxJ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 23:53:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:33926 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYGIDxH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 23:53:07 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3409692rvb.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 20:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=aGNpQ+pSxXg4EFZEEfcWzL6IprPbUII1N8h6M7yZER0=;
        b=R6ZDCa0Ax3aTSxs1XD/SRgrwT+V7jnpIkyxSrdcSVfgGX88Br9bCbFxRYUowJzn1Ou
         km9n6saN16TuGOhEhWEYXvejE7Vrl/1tSI7U2M3ChcWlegIXFjf8dOWF45v2P4f5KZSB
         3NHd/LkorIcgVnwggfbextvI2qb2TANneLw2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=l68Mt6NgkrEwvza3mdEgtnaG59BJuE8BWBaGEcWFS1ZSB1Jfo+t6K1TX5SCC0pGVZW
         BEAIadfQIWwkuMkJQeoaS4NNXDkrLltStOC1UkgIPS+pqhY7TRAVSMetwLEdoI636Qf8
         QTtfJSqMAUXeNGEBmjUPQvt9xT730oF40Z+v4=
Received: by 10.141.74.18 with SMTP id b18mr3667441rvl.80.1215575585222;
        Tue, 08 Jul 2008 20:53:05 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Tue, 8 Jul 2008 20:53:05 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: cacb2d2bd648cf85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87835>

>From a3afd1455d215a541e1481e0f064df743d9219cc Mon Sep 17 00:00:00 2001
From: Geoffrey Irving <irving@naml.us>
Date: Sat, 7 Jun 2008 16:03:49 -0700
Subject: [PATCH 1/3] cherry: cache patch-ids to avoid repeating work

Added cached-sha-map.[hc] implementing a persistent hash map from sha1 to
sha1.  The map is read with mmap, and completely rewritten if any entries
change.  It would be good to add incremental update to handle the usual case
where only a few entries change.

This structure is used by patch-ids.c to cache the mapping from commit to
patch-id into $GIT_DIR/patch-id-cache.  In the one case I've tested so far,
this speeds up the second invocation of git-cherry by two orders of
magnitude.

Original code cannibalized from Johannes Schindelin's notes-index structure.
---

Here's another (hopefully final) version of the patch-id-cache code,
since I finally got around to updating it with Dscho's suggestions.

 Makefile          |    2 +
 cached-sha1-map.c |  182 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 cached-sha1-map.h |   45 +++++++++++++
 patch-ids.c       |   18 +++++-
 4 files changed, 246 insertions(+), 1 deletions(-)
 create mode 100644 cached-sha1-map.c
 create mode 100644 cached-sha1-map.h

diff --git a/Makefile b/Makefile
index 4796565..f7360e1 100644
--- a/Makefile
+++ b/Makefile
@@ -356,6 +356,7 @@ LIB_H += pack-refs.h
 LIB_H += pack-revindex.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
+LIB_H += cached-sha1-map.h
 LIB_H += path-list.h
 LIB_H += pkt-line.h
 LIB_H += progress.h
@@ -436,6 +437,7 @@ LIB_OBJS += pager.o
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
1.5.6.2.258.g7a51a
