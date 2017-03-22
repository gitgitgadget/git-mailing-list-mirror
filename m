Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C842095D
	for <e@80x24.org>; Wed, 22 Mar 2017 17:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965070AbdCVRPY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:15:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:47947 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964938AbdCVRPM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:15:12 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6121E846BA;
        Wed, 22 Mar 2017 13:14:50 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 4/6] name-hash: perf improvement for lazy_init_name_hash
Date:   Wed, 22 Mar 2017 17:14:23 +0000
Message-Id: <1490202865-31325-5-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
References: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Improve performance of lazy_init_name_hash() when
ignore_case is set.  Teach name-hash to build the
istate.name_hash and istate.dir_hash simultaneously
using a forward-diving technique on the pathname
of the index_entry, rather than adding name_hash
entries and then searching backwards in the pathname
for parent directories.

This borrows algorithm ideas from clear_ce_flags_{1,dir}.

Multiple threads are used with the new algorithm to
speed hashmap construction.

This new code path is only used when threads are present
(a compiler settings) and when the index is large enough
to warrant the pthread complexity.

The code in clear_ce_flags_dir() uses a linear search to
find the adjacent index entries with the same prefix; a
binary search is used here handle_range_dir() to further
speed things up.

The size of LAZY_THREAD_COST was determined from rough
analysis using:
    t/helper/test-lazy-init-name-hash --analyze

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 name-hash.c | 487 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 480 insertions(+), 7 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 3f7722a..a582650 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -23,15 +23,21 @@ static int dir_entry_cmp(const struct dir_entry *e1,
 			name ? name : e2->name, e1->namelen);
 }
 
-static struct dir_entry *find_dir_entry(struct index_state *istate,
-		const char *name, unsigned int namelen)
+static struct dir_entry *find_dir_entry__hash(struct index_state *istate,
+		const char *name, unsigned int namelen, unsigned int hash)
 {
 	struct dir_entry key;
-	hashmap_entry_init(&key, memihash(name, namelen));
+	hashmap_entry_init(&key, hash);
 	key.namelen = namelen;
 	return hashmap_get(&istate->dir_hash, &key, name);
 }
 
+static struct dir_entry *find_dir_entry(struct index_state *istate,
+		const char *name, unsigned int namelen)
+{
+	return find_dir_entry__hash(istate, name, namelen, memihash(name,namelen));
+}
+
 static struct dir_entry *hash_dir_entry(struct index_state *istate,
 		struct cache_entry *ce, int namelen)
 {
@@ -112,21 +118,488 @@ static int cache_entry_cmp(const struct cache_entry *ce1,
 	return remove ? !(ce1 == ce2) : 0;
 }
 
-static void lazy_init_name_hash(struct index_state *istate)
+
+#ifdef NO_PTHREADS
+
+static int lookup_lazy_params(struct index_state *istate)
 {
-	int nr;
+	return 0;
+}
+
+#else
+
+#include "thread-utils.h"
+
+/*
+ * Set a minimum number of cache_entries that we will handle per
+ * thread and use that to decide how many threads to run (upto
+ * the number on the system).
+ *
+ * For guidance setting the lower per-thread bound, see:
+ *     t/helper/test-lazy-init-name-hash --analyze
+ */
+#define LAZY_THREAD_COST (2000)
+
+/*
+ * We use n mutexes to guard n partitions of the "istate->dir_hash"
+ * hashtable.  Since "find" and "insert" operations will hash to a
+ * particular bucket and modify/search a single chain, we can say
+ * that "all chains mod n" are guarded by the same mutex -- rather
+ * than having a single mutex to guard the entire table.  (This does
+ * require that we disable "rehashing" on the hashtable.)
+ *
+ * So, a larger value here decreases the probability of a collision
+ * and the time that each thread must wait for the mutex.
+ */
+#define LAZY_MAX_MUTEX   (32)
+
+static int lazy_try_threaded = 1;
+static int lazy_nr_dir_threads = 0;
+static pthread_mutex_t *lazy_dir_mutex_array;
+
+/*
+ * An array of lazy_entry items is used by the n threads in
+ * the directory parse (first) phase to (lock-free) store the
+ * intermediate results.  These values are then referenced by
+ * the 2 threads in the second phase.
+ */
+struct lazy_entry {
+	struct dir_entry *dir;
+	unsigned int hash_dir;
+	unsigned int hash_name;
+};
+
+/*
+ * Decide if we want to use threads (if available) to load
+ * the hash tables.  We set "lazy_nr_dir_threads" to zero when
+ * it is not worth it.
+ */
+static int lookup_lazy_params(struct index_state *istate)
+{
+	int nr_cpus;
+
+	lazy_nr_dir_threads = 0;
+
+	if (!lazy_try_threaded)
+		return 0;
+
+	/*
+	 * If we are respecting case, just use the original
+	 * code to build the "istate->name_hash".  We don't
+	 * need the complexity here.
+	 */
+	if (!ignore_case)
+		return 0;
+
+	nr_cpus = online_cpus();
+	if (nr_cpus < 2)
+		return 0;
+
+	if (istate->cache_nr < 2 * LAZY_THREAD_COST)
+		return 0;
+
+	if (istate->cache_nr < nr_cpus * LAZY_THREAD_COST)
+		nr_cpus = istate->cache_nr / LAZY_THREAD_COST;
+	lazy_nr_dir_threads = nr_cpus;
+	return lazy_nr_dir_threads;
+}
+
+/*
+ * Initialize n mutexes for use when searching and inserting
+ * into "istate->dir_hash".  All "dir" threads are trying
+ * to insert partial pathnames into the hash as they iterate
+ * over their portions of the index, so lock contention is
+ * high.
+ *
+ * However, the hashmap is going to put items into bucket
+ * chains based on their hash values.  Use that to create n
+ * mutexes and lock on mutex[bucket(hash) % n].  This will
+ * decrease the collision rate by (hopefully) by a factor of n.
+ */
+static void init_dir_mutex(void)
+{
+	int j;
+
+	lazy_dir_mutex_array = xcalloc(LAZY_MAX_MUTEX, sizeof(pthread_mutex_t));
+
+	for (j = 0; j < LAZY_MAX_MUTEX; j++)
+		init_recursive_mutex(&lazy_dir_mutex_array[j]);
+}
+
+static void cleanup_dir_mutex(void)
+{
+	int j;
+
+	for (j = 0; j < LAZY_MAX_MUTEX; j++)
+		pthread_mutex_destroy(&lazy_dir_mutex_array[j]);
+
+	free(lazy_dir_mutex_array);
+}
+
+static void lock_dir_mutex(int j)
+{
+	pthread_mutex_lock(&lazy_dir_mutex_array[j]);
+}
+
+static void unlock_dir_mutex(int j)
+{
+	pthread_mutex_unlock(&lazy_dir_mutex_array[j]);
+}
+
+static inline int compute_dir_lock_nr(
+	const struct hashmap *map,
+	unsigned int hash)
+{
+	return hashmap_bucket(map, hash) % LAZY_MAX_MUTEX;
+}
+
+static struct dir_entry *hash_dir_entry_with_parent_and_prefix(
+	struct index_state *istate,
+	struct dir_entry *parent,
+	struct strbuf *prefix)
+{
+	struct dir_entry *dir;
+	unsigned int hash;
+	int lock_nr;
+
+	/*
+	 * Either we have a parent directory and path with slash(es)
+	 * or the directory is an immediate child of the root directory.
+	 */
+	assert((parent != NULL) ^ (strchr(prefix->buf, '/') == 0));
+
+	if (parent)
+		hash = memihash_cont(parent->ent.hash,
+			prefix->buf + parent->namelen,
+			prefix->len - parent->namelen);
+	else
+		hash = memihash(prefix->buf, prefix->len);
 
+	lock_nr = compute_dir_lock_nr(&istate->dir_hash, hash);
+	lock_dir_mutex(lock_nr);
+
+	dir = find_dir_entry__hash(istate, prefix->buf, prefix->len, hash);
+	if (!dir) {
+		FLEX_ALLOC_MEM(dir, name, prefix->buf, prefix->len);
+		hashmap_entry_init(dir, hash);
+		dir->namelen = prefix->len;
+		dir->parent = parent;
+		hashmap_add(&istate->dir_hash, dir);
+
+		if (parent) {
+			unlock_dir_mutex(lock_nr);
+
+			/* All I really need here is an InterlockedIncrement(&(parent->nr)) */
+			lock_nr = compute_dir_lock_nr(&istate->dir_hash, parent->ent.hash);
+			lock_dir_mutex(lock_nr);
+			parent->nr++;
+		}
+	}
+
+	unlock_dir_mutex(lock_nr);
+
+	return dir;
+}
+
+/*
+ * handle_range_1() and handle_range_dir() are derived from
+ * clear_ce_flags_1() and clear_ce_flags_dir() in unpack-trees.c
+ * and handle the iteration over the entire array of index entries.
+ * They use recursion for adjacent entries in the same parent
+ * directory.
+ */
+static int handle_range_1(
+	struct index_state *istate,
+	int k_start,
+	int k_end,
+	struct dir_entry *parent,
+	struct strbuf *prefix,
+	struct lazy_entry *lazy_entries);
+
+static int handle_range_dir(
+	struct index_state *istate,
+	int k_start,
+	int k_end,
+	struct dir_entry *parent,
+	struct strbuf *prefix,
+	struct lazy_entry *lazy_entries,
+	struct dir_entry **dir_new_out)
+{
+	int rc, k;
+	int input_prefix_len = prefix->len;
+	struct dir_entry *dir_new;
+
+	dir_new = hash_dir_entry_with_parent_and_prefix(istate, parent, prefix);
+
+	strbuf_addch(prefix, '/');
+
+	/*
+	 * Scan forward in the index array for index entries having the same
+	 * path prefix (that are also in this directory).
+	 */
+	if (strncmp(istate->cache[k_start + 1]->name, prefix->buf, prefix->len) > 0)
+		k = k_start + 1;
+	else if (strncmp(istate->cache[k_end - 1]->name, prefix->buf, prefix->len) == 0)
+		k = k_end;
+	else {
+		int begin = k_start;
+		int end = k_end;
+		while (begin < end) {
+			int mid = (begin + end) >> 1;
+			int cmp = strncmp(istate->cache[mid]->name, prefix->buf, prefix->len);
+			if (cmp == 0) /* mid has same prefix; look in second part */
+				begin = mid + 1;
+			else if (cmp > 0) /* mid is past group; look in first part */
+				end = mid;
+			else
+				die("cache entry out of order");
+		}
+		k = begin;
+	}
+
+	/*
+	 * Recurse and process what we can of this subset [k_start, k).
+	 */
+	rc = handle_range_1(istate, k_start, k, dir_new, prefix, lazy_entries);
+
+	strbuf_setlen(prefix, input_prefix_len);
+
+	*dir_new_out = dir_new;
+	return rc;
+}
+
+static int handle_range_1(
+	struct index_state *istate,
+	int k_start,
+	int k_end,
+	struct dir_entry *parent,
+	struct strbuf *prefix,
+	struct lazy_entry *lazy_entries)
+{
+	int input_prefix_len = prefix->len;
+	int k = k_start;
+
+	while (k < k_end) {
+		struct cache_entry *ce_k = istate->cache[k];
+		const char *name, *slash;
+
+		if (prefix->len && strncmp(ce_k->name, prefix->buf, prefix->len))
+			break;
+
+		name = ce_k->name + prefix->len;
+		slash = strchr(name, '/');
+
+		if (slash) {
+			int len = slash - name;
+			int processed;
+			struct dir_entry *dir_new;
+
+			strbuf_add(prefix, name, len);
+			processed = handle_range_dir(istate, k, k_end, parent, prefix, lazy_entries, &dir_new);
+			if (processed) {
+				k += processed;
+				strbuf_setlen(prefix, input_prefix_len);
+				continue;
+			}
+
+			strbuf_addch(prefix, '/');
+			processed = handle_range_1(istate, k, k_end, dir_new, prefix, lazy_entries);
+			k += processed;
+			strbuf_setlen(prefix, input_prefix_len);
+			continue;
+		}
+
+		/*
+		 * It is too expensive to take a lock to insert "ce_k"
+		 * into "istate->name_hash" and increment the ref-count
+		 * on the "parent" dir.  So we defer actually updating
+		 * permanent data structures until phase 2 (where we
+		 * can change the locking requirements) and simply
+		 * accumulate our current results into the lazy_entries
+		 * data array).
+		 *
+		 * We do not need to lock the lazy_entries array because
+		 * we have exclusive access to the cells in the range
+		 * [k_start,k_end) that this thread was given.
+		 */
+		lazy_entries[k].dir = parent;
+		if (parent) {
+			lazy_entries[k].hash_name = memihash_cont(
+				parent->ent.hash,
+				ce_k->name + parent->namelen,
+				ce_namelen(ce_k) - parent->namelen);
+			lazy_entries[k].hash_dir = parent->ent.hash;
+		} else {
+			lazy_entries[k].hash_name = memihash(ce_k->name, ce_namelen(ce_k));
+		}
+
+		k++;
+	}
+
+	return k - k_start;
+}
+
+struct lazy_dir_thread_data {
+	pthread_t pthread;
+	struct index_state *istate;
+	struct lazy_entry *lazy_entries;
+	int k_start;
+	int k_end;
+};
+
+static void *lazy_dir_thread_proc(void *_data)
+{
+	struct lazy_dir_thread_data *d = _data;
+	struct strbuf prefix = STRBUF_INIT;
+	handle_range_1(d->istate, d->k_start, d->k_end, NULL, &prefix, d->lazy_entries);
+	strbuf_release(&prefix);
+	return NULL;
+}
+
+struct lazy_name_thread_data {
+	pthread_t pthread;
+	struct index_state *istate;
+	struct lazy_entry *lazy_entries;
+};
+
+static void *lazy_name_thread_proc(void *_data)
+{
+	struct lazy_name_thread_data *d = _data;
+	int k;
+
+	for (k = 0; k < d->istate->cache_nr; k++) {
+		struct cache_entry *ce_k = d->istate->cache[k];
+		ce_k->ce_flags |= CE_HASHED;
+		hashmap_entry_init(ce_k, d->lazy_entries[k].hash_name);
+		hashmap_add(&d->istate->name_hash, ce_k);
+	}
+
+	return NULL;
+}
+
+static inline void lazy_update_dir_ref_counts(
+	struct index_state *istate,
+	struct lazy_entry *lazy_entries)
+{
+	int k;
+
+	for (k = 0; k < istate->cache_nr; k++) {
+		if (lazy_entries[k].dir)
+			lazy_entries[k].dir->nr++;
+	}
+}
+
+static void threaded_lazy_init_name_hash(
+	struct index_state *istate)
+{
+	int nr_each;
+	int k_start;
+	int t;
+	struct lazy_entry *lazy_entries;
+	struct lazy_dir_thread_data *td_dir;
+	struct lazy_name_thread_data *td_name;
+
+	k_start = 0;
+	nr_each = DIV_ROUND_UP(istate->cache_nr, lazy_nr_dir_threads);
+
+	lazy_entries = xcalloc(istate->cache_nr, sizeof(struct lazy_entry));
+	td_dir = xcalloc(lazy_nr_dir_threads, sizeof(struct lazy_dir_thread_data));
+	td_name = xcalloc(1, sizeof(struct lazy_name_thread_data));
+
+	init_dir_mutex();
+
+	/*
+	 * Phase 1:
+	 * Build "istate->dir_hash" using n "dir" threads (and a read-only index).
+	 */
+	for (t = 0; t < lazy_nr_dir_threads; t++) {
+		struct lazy_dir_thread_data *td_dir_t = td_dir + t;
+		td_dir_t->istate = istate;
+		td_dir_t->lazy_entries = lazy_entries;
+		td_dir_t->k_start = k_start;
+		k_start += nr_each;
+		if (k_start > istate->cache_nr)
+			k_start = istate->cache_nr;
+		td_dir_t->k_end = k_start;
+		if (pthread_create(&td_dir_t->pthread, NULL, lazy_dir_thread_proc, td_dir_t))
+			die("unable to create lazy_dir_thread");
+	}
+	for (t = 0; t < lazy_nr_dir_threads; t++) {
+		struct lazy_dir_thread_data *td_dir_t = td_dir + t;
+		if (pthread_join(td_dir_t->pthread, NULL))
+			die("unable to join lazy_dir_thread");
+	}
+
+	/*
+	 * Phase 2:
+	 * Iterate over all index entries and add them to the "istate->name_hash"
+	 * using a single "name" background thread.
+	 * (Testing showed it wasn't worth running more than 1 thread for this.)
+	 *
+	 * Meanwhile, finish updating the parent directory ref-counts for each
+	 * index entry using the current thread.  (This step is very fast and
+	 * doesn't need threading.)
+	 */
+	td_name->istate = istate;
+	td_name->lazy_entries = lazy_entries;
+	if (pthread_create(&td_name->pthread, NULL, lazy_name_thread_proc, td_name))
+		die("unable to create lazy_name_thread");
+
+	lazy_update_dir_ref_counts(istate, lazy_entries);
+
+	if (pthread_join(td_name->pthread, NULL))
+		die("unable to join lazy_name_thread");
+
+	cleanup_dir_mutex();
+
+	free(td_name);
+	free(td_dir);
+	free(lazy_entries);
+}
+
+#endif
+
+static void lazy_init_name_hash(struct index_state *istate)
+{
 	if (istate->name_hash_initialized)
 		return;
 	hashmap_init(&istate->name_hash, (hashmap_cmp_fn) cache_entry_cmp,
 			istate->cache_nr);
 	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp,
 			istate->cache_nr);
-	for (nr = 0; nr < istate->cache_nr; nr++)
-		hash_index_entry(istate, istate->cache[nr]);
+
+	if (lookup_lazy_params(istate)) {
+		hashmap_disallow_rehash(&istate->dir_hash, 1);
+		threaded_lazy_init_name_hash(istate);
+		hashmap_disallow_rehash(&istate->dir_hash, 0);
+	} else {
+		int nr;
+		for (nr = 0; nr < istate->cache_nr; nr++)
+			hash_index_entry(istate, istate->cache[nr]);
+	}
+
 	istate->name_hash_initialized = 1;
 }
 
+/*
+ * A test routine for t/helper/ sources.
+ *
+ * Returns the number of threads used or 0 when
+ * the non-threaded code path was used.
+ *
+ * Requesting threading WILL NOT override guards
+ * in lookup_lazy_params().
+ */
+int test_lazy_init_name_hash(struct index_state *istate, int try_threaded)
+{
+	lazy_nr_dir_threads = 0;
+	lazy_try_threaded = try_threaded;
+
+	lazy_init_name_hash(istate);
+
+	return lazy_nr_dir_threads;
+}
+
 void add_name_hash(struct index_state *istate, struct cache_entry *ce)
 {
 	if (istate->name_hash_initialized)
-- 
2.7.4

