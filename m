From: "Geoffrey Irving" <irving@naml.us>
Subject: [PATCH] Adding a cache of commit to patch-id pairs to speed up git-cherry
Date: Sun, 1 Jun 2008 20:54:02 -0700
Message-ID: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 02 05:55:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K318d-0004br-Kr
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 05:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbYFBDyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 23:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757332AbYFBDyF
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 23:54:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:49081 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711AbYFBDyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 23:54:03 -0400
Received: by rv-out-0506.google.com with SMTP id l9so852415rvb.1
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 20:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=/F+NVKdXYmg93e1JvWDVrZ66tuB1ToZ/IhdUVSKK8VQ=;
        b=nqR99EruPkXOTVS+e3+KKkki3Wbq2TPINCQp7UckNryZkGTTn6OWchQLykpO7IZElXU0XwkMVZqD70rrey5fMozWlYY5Tp/IKbaS8yfMMm7lYHGBHu84PXVOm1ZUqsh9shBYkEIchMqMfZ4Aw0M0bYJYIh6qHzN3F1D/5F7LIY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Ybgope3xTiIoarU4BHclVS00Qv8Y9bOOQBa/ezKUiDwMIkByCqGDPQW4n2R7C7TV+QpLEh+eIkKB79/6qfq9axIIbSKjoD+Q+roSI4uRiRDLpJlOtmJ8tO04VUBye+y2tzbGnxi2fptt4YBQdSrZDoPPEXDdZJm06ny0fmuyqZY=
Received: by 10.141.212.5 with SMTP id o5mr4652043rvq.20.1212378842081;
        Sun, 01 Jun 2008 20:54:02 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Sun, 1 Jun 2008 20:54:02 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: fc63d24601c3940f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83484>

The dominant cost of git-cherry is the computation of patch-ids for each
relevant commit.  Once computed, these pairs are now stored in a hash table
in $GIT_DIR/patch-id-cache to speed up repeated invocations.

The basic structure of patch-id-cache.c was cannibalized from Johannes
Schindelin's notes-index structure, though most of the code was rewritten.
The hash table is still kept strictly sorted by commit, but the entire table
is now read into memory.  See commit d56dbe8cb56ce9b4697d1f1c2425e2e133a932a5
for the original code.
---
 Makefile         |    1 +
 patch-id-cache.c |  180 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 patch-ids.c      |   18 +++++-
 3 files changed, 198 insertions(+), 1 deletions(-)
 create mode 100644 patch-id-cache.c

diff --git a/Makefile b/Makefile
index cce5a6e..3a5396d 100644
--- a/Makefile
+++ b/Makefile
@@ -435,6 +435,7 @@ LIB_OBJS += pager.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
+LIB_OBJS += patch-id-cache.o
 LIB_OBJS += path-list.o
 LIB_OBJS += path.o
 LIB_OBJS += pkt-line.o
diff --git a/patch-id-cache.c b/patch-id-cache.c
new file mode 100644
index 0000000..a2b32c8
--- /dev/null
+++ b/patch-id-cache.c
@@ -0,0 +1,180 @@
+#include "cache.h"
+
+/*
+ * The patch-id-cache is a file consisting of a header, and a hash map
+ * containing commit hash -> patch-id hash pairs.
+ *
+ * Currently the entire hash table is read into memory.  Entries are
+ * kept strictly sorted rather than wrapping around, so the actual
+ * size of the table is slightly larger than the size of the key space.
+ *
+ * The disadvantages of a hash is its loose packing.  In order to operate
+ * reasonably well, it needs a size roughly double the number of entries.
+ * It also has a worst runtime linear in the number of entries.
+ *
+ * The advantage is an expected constant lookup time.
+ *
+ * The performance of a hash map depends highly on a good hashing
+ * algorithm, to avoid collisions.  Lucky us!  SHA-1 is a pretty good
+ * hashing algorithm.
+ *
+ * There is another advantage to hash maps: with not much effort, an
+ * incremental update can be performed in place, relying on O_TRUNC to
+ * detect interruptions.  This operation has an expected constant runtime.
+ * Incremental update is not yet implemented.
+ */
+
+struct patch_id_entry {
+	unsigned char commit_sha1[20];
+	unsigned char patch_id_sha1[20];
+};
+
+struct patch_id_cache {
+	char signature[4]; /* HASH */
+
+	off_t count, key_size, actual_size; /* for hash */
+	struct patch_id_entry entries[0];
+};
+
+static struct patch_id_cache *cache = 0;
+static size_t written_count = 0;
+
+const char *signature = "HASH";
+
+static size_t get_hash_size(size_t actual_size)
+{
+	return sizeof(struct patch_id_cache) + actual_size * sizeof(struct
patch_id_entry);
+}
+
+static void read_patch_id_cache()
+{
+	int fd = open(git_path("patch-id-cache"), O_RDONLY);
+
+	if (fd < 0) { // allocate a new cache
+		size_t size = 64;
+		cache = xcalloc(get_hash_size(size), 1);
+		cache->key_size = cache->actual_size = size;
+		return;
+	}
+
+	struct patch_id_cache header;
+	size_t len = read_in_full(fd, &header, sizeof(header));
+	if (len != sizeof(header))
+		die("cannot read patch-id-cache header");
+	if (header.key_size & (header.key_size-1))
+		die("patch-id-cache key size %lld is not a power of two", (long
long)header.key_size);
+
+	free(cache);
+	cache = xmalloc(get_hash_size(header.actual_size));
+	*cache = header;
+	size_t entry_size = header.actual_size * sizeof(struct patch_id_entry);
+	len = read_in_full(fd, cache->entries, entry_size);
+	if (len != entry_size)
+		die("cannot read patch-id-cache entries");
+	written_count = cache->count;
+
+	// It's impossible to check whether the cache is actually accurate,
+	// so assume it's correct if we get to this point.
+}
+
+void write_patch_id_cache()
+{
+	if (!cache || cache->count == written_count)
+		return;
+
+	struct lock_file update_lock;
+	int fd = hold_lock_file_for_update(&update_lock,
+			git_path("patch-id-cache"), 0);
+
+	if (fd < 0) {
+		error("could not construct patch-id-cache");
+		return;
+	}
+
+	memcpy(cache->signature, signature, 4);
+	if (write_in_full(fd, cache, get_hash_size(cache->actual_size)) < 0) {
+		error("could not write patch-id-cache");
+		return;
+	}
+
+	if (commit_lock_file(&update_lock))
+		error("could not finalize patch-id-cache");
+	else {
+		written_count = cache->count;
+		printf("patch-id-cache count %lld\n", (long long)written_count);
+	}
+}
+
+static unsigned long get_hash_index(const unsigned char *sha1)
+{
+	return (ntohl(*(unsigned long *)sha1) & (cache->key_size-1));
+}
+
+int get_cached_commit_patch_id(const unsigned char *commit_sha1,
+		unsigned char *patch_id_sha1)
+{
+	if (!cache)
+		read_patch_id_cache();
+
+	size_t i = get_hash_index(commit_sha1);
+	for (; i < cache->actual_size; i++) {
+		int cmp = hashcmp(commit_sha1, cache->entries[i].commit_sha1);
+		if (!cmp) {
+			hashcpy(patch_id_sha1, cache->entries[i].patch_id_sha1);
+			return 0;
+		} else if (cmp > 0 || is_null_sha1(cache->entries[i].commit_sha1))
+			break;
+	}
+	return -1;
+}
+
+void cache_commit_patch_id(const unsigned char *commit_sha1,
+		const unsigned char *patch_id_sha1)
+{
+	if (4*cache->count > 3*cache->key_size) { // resize
+		// allocate cache with twice the size
+		struct patch_id_cache *old_cache = cache;
+		size_t new_key_size = 2*cache->key_size,
+			new_actual_size = cache->key_size + cache->actual_size;
+		cache = xcalloc(get_hash_size(new_actual_size), 1);
+		cache->key_size = new_key_size;
+		cache->actual_size = new_actual_size;
+
+		// reinsert all entries
+		size_t i;
+	 	for (i = 0; i < old_cache->actual_size; i++)
+			cache_commit_patch_id(old_cache->entries[i].commit_sha1,
+				old_cache->entries[i].patch_id_sha1);
+	}
+
+	struct patch_id_entry entry;
+	hashcpy(entry.commit_sha1, commit_sha1);
+	hashcpy(entry.patch_id_sha1, patch_id_sha1);
+
+	size_t i = get_hash_index(commit_sha1);
+	for (;;) {
+		if (i == cache->actual_size) {
+			cache->actual_size++; // adding one suffices for expected O(1)
+			cache = xrealloc(cache, get_hash_size(cache->actual_size));
+			cache->entries[cache->actual_size-1] = entry;
+			return;
+		}
+		int cmp = hashcmp(entry.commit_sha1, cache->entries[i].commit_sha1);
+		if (!cmp) {
+			if (hashcmp(entry.patch_id_sha1, cache->entries[i].patch_id_sha1))
+				die("found mismatched entry in patch-id-cache");
+			return;
+		} else if (cmp < 0) {
+			i++;
+		} else if (is_null_sha1(cache->entries[i].commit_sha1)) {
+			cache->entries[i] = entry;
+			cache->count++;
+			return;
+		} else {
+			struct patch_id_entry tmp = cache->entries[i];
+			cache->entries[i] = entry;
+			entry = tmp;
+			i++;
+		}
+	}
+}
diff --git a/patch-ids.c b/patch-ids.c
index 3be5d31..91fabeb 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -3,16 +3,30 @@
 #include "commit.h"
 #include "patch-ids.h"

+extern void write_patch_id_cache();
+extern int get_cached_commit_patch_id(const unsigned char
*commit_sha1, unsigned char *patch_id_sha1);
+extern void cache_commit_patch_id(const unsigned char *commit_sha1,
const unsigned char *patch_id_sha1);
+
 static int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1)
 {
+	// pull patch-id out of the cache if possible
+	if (!get_cached_commit_patch_id(commit->object.sha1, sha1))
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
+	// record commit, patch-id pair in cache
+	cache_commit_patch_id(commit->object.sha1, sha1);
+	return 0;
 }

 static uint32_t take2(const unsigned char *id)
@@ -136,6 +150,8 @@ int free_patch_ids(struct patch_ids *ids)
 		next = patches->next;
 		free(patches);
 	}
+
+	write_patch_id_cache();
 	return 0;
 }

-- 
1.5.4.5
