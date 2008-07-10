From: "Geoffrey Irving" <irving@naml.us>
Subject: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Wed, 9 Jul 2008 20:34:14 -0700
Message-ID: <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
	 <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>
	 <7vprpnlglh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 05:35:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGmwP-0006WK-Hq
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 05:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbYGJDeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 23:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753712AbYGJDeR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 23:34:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:61364 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbYGJDeO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 23:34:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3820165rvb.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 20:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=P1Sx7BrGh9MqHWv+um6I+O9VwrXKzhBU1g5rWzGL1Y0=;
        b=SzJfYAFCT6iLiKG0A1C8i1CJDMfhkYQKCbH/3FSYEdQ4w5nK5Plr+i86EgV3eavEIS
         DTQ2kK+PJzcMoNbUXdQw3HQNaH/7vM9kZqfD5ULPpWdztfQqVHZLHdY5T7pKBGv63GHp
         AnTDyWnX4Ayxum+AY2RiJ+KXr9AparBqRGwBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=nNSoNH/N6SVUjKCbS71/65NjpIHMQ1eIrK2a3x+0ovgXGMBol9scAPtUyYhKYYgiS9
         lK/UXmuwm1SU6JDJuOwNEuJyvTChL3Lp8Cs/Dl6qHlmkhF+dfXU92jC8bGvS0vxFAbIs
         uI8jAmrl8Aon4TsznXeip+1++YC8FjNOpLgrk=
Received: by 10.141.161.6 with SMTP id n6mr4485369rvo.201.1215660854303;
        Wed, 09 Jul 2008 20:34:14 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Wed, 9 Jul 2008 20:34:14 -0700 (PDT)
In-Reply-To: <7vprpnlglh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: a7829528bba7e175
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87936>

Add cached-sha-map.[ch] implementing a persistent hash map from sha1 to
sha1.  The map is read with mmap, and completely rewritten if any entries
change.  It would be good to add incremental update to handle the usual case
where only a few entries change.

This structure is used by patch-ids.c to cache the mapping from commit to
patch-id into $GIT_DIR/patch-id-cache.  In the one case I've tested so far,
this speeds up the second invocation of git-cherry by two orders of
magnitude.  The caching can be disabled by setting cherry.cachepatchids to
false.

Original code cannibalized from Johannes Schindelin's notes-index structure.

Signed-off-by: Geoffrey Irving <irving@naml.us>
---

Note: there are at least two "holes" in this code.  First, it is impossible
to verify the validity of the entries (this is impossible to fix).  Second,
it is possible to write a malicious patch-id-cache file that causes git-cherry
to go into an infinite loop.  Fixing the loop requires either traversing every
entry on load (bad) or adding a second loop termination condition to
find_helper.  Since looping forever is better than returning incorrect
results, I figured fixing the weaker hole would just result in a false sense
of security.

I'll await the next round of comments. :)

 Documentation/config.txt |    5 +
 Makefile                 |    2 +
 builtin-log.c            |   12 ++
 cached-sha1-map.c        |  269 ++++++++++++++++++++++++++++++++++++++++++++++
 cached-sha1-map.h        |   45 ++++++++
 patch-ids.c              |   26 +++++-
 patch-ids.h              |    2 +
 7 files changed, 360 insertions(+), 1 deletions(-)
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
index 0000000..3ac5474
--- /dev/null
+++ b/cached-sha1-map.c
@@ -0,0 +1,269 @@
+#include "cached-sha1-map.h"
+
+union cached_sha1_map_header {
+	struct {
+		char signature[4]; /* CS1M */
+		uint32_t version;
+		uint32_t count;
+		uint32_t size;
+	} u;
+	struct cached_sha1_entry pad; /* pad header out to 40 bytes */
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
+	if (read_in_full(fd, &header, sizeof(header)) != sizeof(header))
+	{
+		warning("cannot read %s header", filename);
+		goto empty;
+	}
+
+	if (memcmp(header.u.signature, signature, 4))
+	{
+		warning("%s has invalid header", filename);
+		goto empty;
+	}
+
+	if (ntohl(header.u.version) != version)
+	{
+		warning("%s has unrecognized version %"PRIu32, filename,
+			ntohl(header.u.version));
+		goto empty;
+	}
+
+	cache->count = ntohl(header.u.count);
+	cache->size = ntohl(header.u.size);
+
+	if (cache->size & (cache->size-1))
+	{
+		warning("%s is corrupt: size %"PRIu32" is not a power of two",
+			filename, cache->size);
+		goto empty;
+	}
+
+	if (cache->count >= cache->size)
+	{
+		warning("%s is corrupt: count %"PRIu32" >= size %"PRIu32,
+			filename, cache->count, cache->size);
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
+	memcpy(header.u.signature, signature, 4);
+	header.u.version = htonl(version);
+	header.u.count = htonl(cache->count);
+	header.u.size = htonl(cache->size);
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
+ * the next free entry otherwise.
+ */
+static int32_t find_helper(struct cached_sha1_map *cache,
+	const unsigned char *key)
+{
+	int32_t i, mask;
+
+	mask = cache->size - 1;
+
+	for (i = get_hash_index(key) & mask; ; i = (i+1) & mask) {
+		if (!hashcmp(key, cache->entries[i].key))
+			return i;
+		else if (is_null_sha1(cache->entries[i].key))
+			return ~i;
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
+	if (4*cache->count >= 3*cache->size)
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
index 3be5d31..663ffee 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -2,17 +2,36 @@
 #include "diff.h"
 #include "commit.h"
 #include "patch-ids.h"
+#include "cached-sha1-map.h"
+
+int cache_patch_ids = 1;
+static struct cached_sha1_map patch_id_cache;

 static int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1)
 {
+	int ret;
+
+	/* pull patch-id out of the cache if possible */
+	patch_id_cache.filename = "patch-id-cache";
+	if (cache_patch_ids && !get_cached_sha1_entry(&patch_id_cache,
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
+	if (cache_patch_ids)
+		set_cached_sha1_entry(&patch_id_cache, commit->object.sha1, sha1);
+	return 0;
 }

 static uint32_t take2(const unsigned char *id)
@@ -136,6 +155,11 @@ int free_patch_ids(struct patch_ids *ids)
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
1.5.6.2.256.g47cb9.dirty
