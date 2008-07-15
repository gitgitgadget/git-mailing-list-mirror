From: "Geoffrey Irving" <irving@naml.us>
Subject: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Tue, 15 Jul 2008 09:57:14 -0700
Message-ID: <7f9d599f0807150957o78d46204x280668c763fba2bf@mail.gmail.com>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
	 <alpine.DEB.1.00.0807101526380.18205@racer>
	 <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>
	 <7v3amglxmb.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807110758y6c4ea7bepd726daf4fe5f074c@mail.gmail.com>
	 <alpine.DEB.1.00.0807111635400.8950@racer>
	 <7f9d599f0807110841r329dfb95g786a576bd981dd1b@mail.gmail.com>
	 <alpine.DEB.1.00.0807111647080.8950@racer>
	 <7vej60jln6.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807122014y5190463j62d106a01bf31c86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 18:58:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KInqz-0007gp-SI
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 18:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbYGOQ5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 12:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbYGOQ5R
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 12:57:17 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:59466 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbYGOQ5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 12:57:16 -0400
Received: by py-out-1112.google.com with SMTP id p76so3115354pyb.10
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=/BKtyCThSiLv/3aZrCwTpN0d5vnBgP/E/AWH/Eh6Cr0=;
        b=wUdszneU9H6lPdvlK4D8r0GzqV+Se+8AOrnwsHP/kduonv4QAvfsc2HLStd/ux77lA
         nnj4D6HE0hlV1VwUMgMi/ZMu8Plnu1+13oUfWbJAM5VbOhSN/AszcZmuSjugo1XUgkyt
         kwzAJ5GzcBFj0Y3wljbKx554UePUvHoBbFW9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=XtM4asQa5MiiZIF0qxC1W9LaZVkeiSV86yk7KcavgRflMq+HNOB6G5v1DmhwB8wtVk
         DFY18gEZuUfMmBA/sJAYdUWDWESxJReTsIa7FwByEnJXfg9Ygyt52gX8+MTFq4T19NK1
         RWuu3BKZeYljGEFgZ8z4VU/t4BK9/ILV2PHoI=
Received: by 10.140.200.16 with SMTP id x16mr7587834rvf.120.1216141034614;
        Tue, 15 Jul 2008 09:57:14 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Tue, 15 Jul 2008 09:57:14 -0700 (PDT)
In-Reply-To: <7f9d599f0807122014y5190463j62d106a01bf31c86@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: aa7df3f54a0a312d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88580>

Add cached-sha-map.[ch] implementing a persistent hash map from sha1 to
sha1.  The map is read with mmap, and completely rewritten if any entries
change.  It would be good to add incremental update to handle the usual case
where only a few entries change.

This structure is used by patch-ids.c to cache the mapping from commit to
patch-id into $GIT_DIR/patch-id-cache.  In the one case I've tested so far,
this speeds up the second invocation of git-cherry by two orders of
magnitude.  The caching can be disabled by setting cherry.cachepatchids to
false.  Only patch-ids with default diff options are cached.

Original code cannibalized from Johannes Schindelin's notes-index structure.

Signed-off-by: Geoffrey Irving <irving@naml.us>
---

Here's a version of the patch fixing the test breakage.  Only
patch-ids.c differs from the previous version.

 Documentation/config.txt |    5 +
 Makefile                 |    2 +
 builtin-log.c            |   12 ++
 cached-sha1-map.c        |  293 ++++++++++++++++++++++++++++++++++++++++++++++
 cached-sha1-map.h        |   45 +++++++
 patch-ids.c              |   40 ++++++-
 patch-ids.h              |    2 +
 7 files changed, 398 insertions(+), 1 deletions(-)
 create mode 100644 cached-sha1-map.c
 create mode 100644 cached-sha1-map.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 838794d..02b8113 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -468,6 +468,11 @@ browser.<tool>.path::
 	browse HTML help (see '-w' option in linkgit:git-help[1]) or a
 	working repository in gitweb (see linkgit:git-instaweb[1]).

+cherry.cachepatchids::
+	If true, linkgit:git-cherry will store a cache of computed patch-ids
+	in $GIT_DIR/patch-id-cache in order to make repeated invocations faster.
+	Defaults to true.
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f
 	or -n.   Defaults to true.
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
diff --git a/builtin-log.c b/builtin-log.c
index 430d876..fbfefbd 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1081,6 +1081,16 @@ static int add_pending_commit(const char *arg,
struct rev_info *revs, int flags)
 	return -1;
 }

+static int git_cherry_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "cherry.cachepatchids")) {
+		cache_patch_ids = git_config_bool(var, value);
+		return 0;
+	}
+
+	return 0;
+}
+
 static const char cherry_usage[] =
 "git-cherry [-v] <upstream> [<head>] [<limit>]";
 int cmd_cherry(int argc, const char **argv, const char *prefix)
@@ -1094,6 +1104,8 @@ int cmd_cherry(int argc, const char **argv,
const char *prefix)
 	const char *limit = NULL;
 	int verbose = 0;

+	git_config(git_cherry_config, NULL);
+
 	if (argc > 1 && !strcmp(argv[1], "-v")) {
 		verbose = 1;
 		argc--;
diff --git a/cached-sha1-map.c b/cached-sha1-map.c
new file mode 100644
index 0000000..9cf7252
--- /dev/null
+++ b/cached-sha1-map.c
@@ -0,0 +1,293 @@
+#include "cached-sha1-map.h"
+
+union cached_sha1_map_header {
+	struct {
+		char signature[4]; /* CS1M */
+		uint32_t version;
+		uint32_t count;
+		uint32_t size;
+		uint32_t pad; /* pad to 20 bytes */
+	} u;
+	/* pad header out to 40 bytes.  As a consistency
+	 * check, pad.value stores the sha1 of pad.key. */
+	struct cached_sha1_entry pad;
+};
+
+static const char *signature = "CS1M";
+static const uint32_t version = 1;
+
+static int init_empty_map(struct cached_sha1_map *cache, uint32_t size)
+{
+	cache->count = 0;
+	cache->size = size;
+	cache->initialized = 1;
+	cache->mmapped = 0;
+	cache->dirty = 1;
+
+	cache->entries = calloc(size, sizeof(struct cached_sha1_entry));
+	if (!cache->entries) {
+		warning("failed to allocate empty map of size %"PRIu32" for %s",
+			size, git_path(cache->filename));
+		cache->size = 0;
+		cache->dirty = 0;
+		return -1;
+	}
+	return 0;
+}
+
+static int grow_map(struct cached_sha1_map *cache)
+{
+	struct cached_sha1_map new_cache;
+	uint32_t i;
+
+	if (cache->size * 2 == 0) {
+		warning("%s overflowed, so resetting to empty",
+			git_path(cache->filename));
+		return init_empty_map(cache, 64);
+	}
+
+	/* allocate cache with twice the size */
+	new_cache.filename = cache->filename;
+	if (init_empty_map(&new_cache, cache->size * 2)) {
+		warning("failed to grow %s to size %"PRIu32,
+			git_path(cache->filename), cache->size * 2);
+		return init_empty_map(cache, 64);
+	}
+
+	/* reinsert all entries */
+ 	for (i = 0; i < cache->size; i++)
+		if (!is_null_sha1(cache->entries[i].key))
+			set_cached_sha1_entry(&new_cache,
+				cache->entries[i].key, cache->entries[i].value);
+	/* finish */
+	free_cached_sha1_map(cache);
+	*cache = new_cache;
+	return 0;
+}
+
+/* Any errors that occur result in the cache being initialized to empty */
+static int init_cached_sha1_map(struct cached_sha1_map *cache)
+{
+	int fd;
+	union cached_sha1_map_header header;
+	const char *filename;
+	size_t map_size;
+	SHA_CTX ctx;
+
+	if (cache->initialized)
+		return cache->size ? 0 : -1;
+
+	filename = git_path(cache->filename);
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		if (errno != ENOENT)
+			warning("failed to read '%s': %s", filename,
+				strerror(errno));
+		goto empty;
+	}
+
+	if (read_in_full(fd, &header, sizeof(header)) != sizeof(header)) {
+		warning("cannot read %s header", filename);
+		goto empty;
+	}
+
+	if (memcmp(header.u.signature, signature, 4)) {
+		warning("%s has invalid header", filename);
+		goto empty;
+	}
+
+	if (ntohl(header.u.version) != version) {
+		warning("%s has unrecognized version %"PRIu32, filename,
+			ntohl(header.u.version));
+		goto empty;
+	}
+
+	cache->count = ntohl(header.u.count);
+	cache->size = ntohl(header.u.size);
+
+	if (cache->size & (cache->size-1)) {
+		warning("%s is corrupt: size %"PRIu32" is not a power of two",
+			filename, cache->size);
+		goto empty;
+	}
+
+	if (cache->count >= cache->size) {
+		warning("%s is corrupt: count %"PRIu32" >= size %"PRIu32,
+			filename, cache->count, cache->size);
+		goto empty;
+	}
+
+	SHA1_Init(&ctx);
+	SHA1_Update(&ctx, header.pad.key, 20);
+	SHA1_Final(header.pad.key, &ctx); /* reuse pad.key to store its sha1 */
+	if (hashcmp(header.pad.key, header.pad.value)) {
+		warning("%s header has invalid sha1", filename);
+		goto empty;
+	}
+
+	cache->dirty = 0;
+	cache->initialized = 1;
+	cache->mmapped = 1;
+
+	/* mmap entire file so that file / memory blocks are aligned */
+	map_size = sizeof(struct cached_sha1_entry) * (cache->size + 1);
+	cache->entries = mmap(NULL, map_size,
+		PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (cache->entries == MAP_FAILED) {
+		/* this is just a cache, so don't free pack memory and retry */
+		warning("%s mmap failed: %s", filename, strerror(errno));
+		goto empty;
+	}
+	cache->entries += 1; /* skip header */
+	return 0;
+
+empty:
+	if (fd >= 0)
+		close(fd);
+	return init_empty_map(cache, 64);
+}
+
+int write_cached_sha1_map(struct cached_sha1_map *cache)
+{
+	union cached_sha1_map_header header;
+	struct lock_file update_lock;
+	int fd;
+	size_t map_size;
+	const char *filename;
+	SHA_CTX ctx;
+
+	if (!cache->initialized || !cache->dirty)
+		return 0;
+
+	filename = git_path(cache->filename);
+	fd = hold_lock_file_for_update(&update_lock, filename, 0);
+
+	if (fd < 0)
+	{
+		warning("could not construct %s", filename);
+		return -1;
+	}
+
+	/* initialize header */
+	memcpy(header.u.signature, signature, 4);
+	header.u.version = htonl(version);
+	header.u.count = htonl(cache->count);
+	header.u.size = htonl(cache->size);
+	header.u.pad = 0; /* make header deterministic */
+
+	/* compute header sha1 */
+	SHA1_Init(&ctx);
+	SHA1_Update(&ctx, header.pad.key, 20);
+	SHA1_Final(header.pad.value, &ctx);
+
+	map_size = sizeof(struct cached_sha1_entry) * cache->size;
+	if (write_in_full(fd, &header, sizeof(header)) != sizeof(header)
+		|| write_in_full(fd, cache->entries, map_size) != map_size)
+	{
+		warning("could not write %s", filename);
+		return -1;
+	}
+
+	if (commit_lock_file(&update_lock) < 0)
+	{
+		warning("could not write %s", filename);
+		return -1;
+	}
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
+/* The fact that size is a power of two means count-1 <= INT32_MAX, so it
+ * is safe to return signed integers here. */
+static int32_t get_hash_index(const unsigned char *sha1)
+{
+	/* this is alignment safe since 40 is a multiple of 4 */
+	return ntohl(*(uint32_t*)sha1);
+}
+
+/*
+ * Returns the index if the entry exists, and the complemented index of
+ * the next free entry otherwise.  If the hash is full, returns the
+ * complement of a nonfree entry and sets count = size (this happens
+ * only if the file is corrupt).
+ */
+static int32_t find_helper(struct cached_sha1_map *cache,
+	const unsigned char *key)
+{
+	int32_t i, mask, full;
+
+	mask = cache->size - 1;
+	i = get_hash_index(key) & mask;
+	full = (i-1) & mask;
+
+	for (; ; i = (i+1) & mask) {
+		if (!hashcmp(key, cache->entries[i].key))
+			return i;
+		else if (is_null_sha1(cache->entries[i].key) || i == full)
+			return ~i;
+		if (i == full) {
+			cache->count = cache->size; /* fix count */
+			return ~1;
+		}
+	}
+}
+
+int get_cached_sha1_entry(struct cached_sha1_map *cache,
+	const unsigned char *key, unsigned char *value)
+{
+	int32_t i;
+
+	if (init_cached_sha1_map(cache))
+		return -1;
+
+	i = find_helper(cache, key);
+	if(i < 0)
+		return -1;
+
+	/* entry found, return value */
+	hashcpy(value, cache->entries[i].value);
+	return 0;
+}
+
+int set_cached_sha1_entry(struct cached_sha1_map *cache,
+	const unsigned char *key, const unsigned char *value)
+{
+	int32_t i;
+	struct cached_sha1_entry *entry;
+
+	if (init_cached_sha1_map(cache))
+		return -1;
+
+	i = find_helper(cache, key);
+
+	if (i < 0) { /* write new entry */
+		entry = cache->entries + ~i;
+		hashcpy(entry->key, key);
+		hashcpy(entry->value, value);
+		cache->count++;
+		cache->dirty = 1;
+	} else { /* overwrite existing entry */
+		entry = cache->entries + i;
+		if (hashcmp(value, entry->value)) {
+			hashcpy(entry->value, value);
+			cache->dirty = 1;
+		}
+	}
+
+	if (cache->count >= cache->size/4*3)
+		return grow_map(cache);
+	return 0;
+}
diff --git a/cached-sha1-map.h b/cached-sha1-map.h
new file mode 100644
index 0000000..296c17c
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
+	uint32_t count, size;
+	unsigned int initialized : 1;
+	unsigned int dirty : 1;
+	unsigned int mmapped : 1;
+	struct cached_sha1_entry *entries; /* pointer to mmap'ed memory + 1 */
+};
+
+extern int get_cached_sha1_entry(struct cached_sha1_map *cache,
+	const unsigned char *key,unsigned char *value);
+
+extern int set_cached_sha1_entry(struct cached_sha1_map *cache,
+	const unsigned char *key, const unsigned char *value);
+
+extern int write_cached_sha1_map(struct cached_sha1_map *cache);
+
+extern void free_cached_sha1_map(struct cached_sha1_map *cache);
+
+#endif
diff --git a/patch-ids.c b/patch-ids.c
index 3be5d31..5ba12fb 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -2,17 +2,49 @@
 #include "diff.h"
 #include "commit.h"
 #include "patch-ids.h"
+#include "cached-sha1-map.h"
+
+int cache_patch_ids = 1;
+static struct cached_sha1_map patch_id_cache;
+
+static struct diff_options default_options;
+#define IGNORED_DIFF_OPTS (DIFF_OPT_HAS_CHANGES | DIFF_OPT_CHECK_FAILED)

 static int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1)
 {
+	int use_cache = 0;
+	int ret;
+
+	/* only cache if diff options are defaults */
+	if (cache_patch_ids) {
+		default_options.found_changes = options->found_changes;
+		default_options.flags = (options->flags & IGNORED_DIFF_OPTS)
+			| (default_options.flags & ~IGNORED_DIFF_OPTS);
+		use_cache = !memcmp(options, &default_options,
+				    sizeof(struct diff_options));
+	}
+
+	/* pull patch-id out of the cache if possible */
+	patch_id_cache.filename = "patch-id-cache";
+	if (use_cache && !get_cached_sha1_entry(&patch_id_cache,
+			commit->object.sha1, sha1))
+		return 0;
+
 	if (commit->parents)
 		diff_tree_sha1(commit->parents->item->object.sha1,
 		               commit->object.sha1, "", options);
 	else
 		diff_root_tree_sha1(commit->object.sha1, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1);
+	ret = diff_flush_patch_id(options, sha1);
+	if (ret)
+		return ret;
+
+	/* record commit, patch-id pair in cache */
+	if (use_cache)
+		set_cached_sha1_entry(&patch_id_cache, commit->object.sha1, sha1);
+	return 0;
 }

 static uint32_t take2(const unsigned char *id)
@@ -124,6 +156,7 @@ int init_patch_ids(struct patch_ids *ids)
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	if (diff_setup_done(&ids->diffopts) < 0)
 		return error("diff_setup_done failed");
+	default_options = ids->diffopts; /* remember defaults */
 	return 0;
 }

@@ -136,6 +169,11 @@ int free_patch_ids(struct patch_ids *ids)
 		next = patches->next;
 		free(patches);
 	}
+
+	/* write cached patch-ids and ignore any errors that arise
+	 * (e.g. if the repository is write protected) */
+	if (cache_patch_ids)
+		write_cached_sha1_map(&patch_id_cache);
 	return 0;
 }

diff --git a/patch-ids.h b/patch-ids.h
index c8c7ca1..c0ebdc1 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -18,4 +18,6 @@ int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
 struct patch_id *has_commit_patch_id(struct commit *, struct patch_ids *);

+extern int cache_patch_ids;
+
 #endif /* PATCH_IDS_H */
-- 
1.5.6.2.256.g3ef05.dirty
