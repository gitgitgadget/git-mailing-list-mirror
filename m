From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 05/22] read-cache: add index reading api
Date: Sun,  7 Jul 2013 10:11:43 +0200
Message-ID: <1373184720-29767-6-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5f-0005xI-7A
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982Ab3GGIM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:12:58 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:49513 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab3GGIMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:12:41 -0400
Received: by mail-ea0-f170.google.com with SMTP id h10so2332420eaj.1
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0zj108S8NWmGFe25kqA9d65GnV/xW1C+f6kS35n4poY=;
        b=VxEe/eD3+Fxn73uMyQa3uKrpQsTqBc9iBbYnSINUIA8Q/lgXNDibwiY4veBT9JHJ6E
         QtBEfVJCi3lCkxE0tgORd8GjqEk5WM8bqLDvtP2/X5I2rIpADHSQFjm+ACDzfiaIY0P/
         7UbWZWsGdmsLvifaLh9Usyw/K35WjIHzvCTCoy/1zoG36F5Fl38STAD/h1QSVnw/GuMQ
         bNM3F9lmnYr6+ItAWfq5NCangKq+tfs9XgYKucuzvbz7ME/3TnConDkS9+OjQXqRU8gO
         m4xtOFEDo10UqKM+QH42yQYXK/4Q6pkptj3ARTRlTl1UID37RthjQl3OEipUhkmAlH+x
         qrbA==
X-Received: by 10.15.36.72 with SMTP id h48mr13996214eev.33.1373184760032;
        Sun, 07 Jul 2013 01:12:40 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id l42sm30655895eeo.14.2013.07.07.01.12.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:12:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229735>

Add an api for access to the index file.  Currently there is only a very
basic api for accessing the index file, which only allows a full read of
the index, and lets the users of the data filter it.  The new index api
gives the users the possibility to use only part of the index and
provides functions for iterating over and accessing cache entries.

This simplifies future improvements to the in-memory format, as changes
will be concentrated on one file, instead of the whole git source code.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h         |  57 +++++++++++++++++++++++++++++-
 read-cache-v2.c |  96 +++++++++++++++++++++++++++++++++++++++++++++++--
 read-cache.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 read-cache.h    |  12 ++++++-
 4 files changed, 263 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 5082b34..d38dfbd 100644
--- a/cache.h
+++ b/cache.h
@@ -127,7 +127,8 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
-	struct cache_entry *next;
+	struct cache_entry *next; /* used by name_hash */
+	struct cache_entry *next_ce; /* used to keep a list of cache entries */
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -258,6 +259,32 @@ static inline unsigned int canon_mode(unsigned int mode)
 
 #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
 
+/*
+ * Options by which the index should be filtered when read partially.
+ *
+ * pathspec: The pathspec which the index entries have to match
+ * seen: Used to return the seen parameter from match_pathspec()
+ * max_prefix, max_prefix_len: These variables are set to the longest
+ *     common prefix, the length of the longest common prefix of the
+ *     given pathspec
+ *
+ * read_staged: used to indicate if the conflicted entries (entries
+ *     with a stage) should be included
+ * read_cache_tree: used to indicate if the cache-tree should be read
+ * read_resolve_undo: used to indicate if the resolve undo data should
+ *     be read
+ */
+struct filter_opts {
+	const char **pathspec;
+	char *seen;
+	char *max_prefix;
+	int max_prefix_len;
+
+	int read_staged;
+	int read_cache_tree;
+	int read_resolve_undo;
+};
+
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
@@ -270,6 +297,8 @@ struct index_state {
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
 	struct index_ops *ops;
+	struct internal_ops *internal_ops;
+	struct filter_opts *filter_opts;
 };
 
 extern struct index_state the_index;
@@ -311,6 +340,17 @@ extern void free_name_hash(struct index_state *istate);
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
+
+/* index api */
+#define read_cache_filtered(opts) read_index_filtered(&the_index, (opts))
+#define read_cache_filtered_from(path, opts) read_index_filtered_from(&the_index, (path), (opts))
+#define get_cache_entry_by_name(name, namelen, ce) \
+	get_index_entry_by_name(&the_index, (name), (namelen), (ce))
+#define for_each_cache_entry(fn, cb_data) \
+	for_each_index_entry(&the_index, (fn), (cb_data))
+#define next_cache_entry(ce) next_index_entry(ce)
+#define cache_change_filter_opts(opts) index_change_filter_opts(&the_index, (opts))
+#define sort_cache() sort_index(&the_index)
 #endif
 
 enum object_type {
@@ -438,6 +478,21 @@ extern int init_db(const char *template_dir, unsigned int flags);
 		} \
 	} while (0)
 
+/* index api */
+extern int read_index_filtered(struct index_state *, struct filter_opts *opts);
+extern int read_index_filtered_from(struct index_state *, const char *path, struct filter_opts *opts);
+extern int get_index_entry_by_name(struct index_state *, const char *name, int namelen,
+				   struct cache_entry **ce);
+extern struct cache_entry *next_index_entry(struct cache_entry *ce);
+void index_change_filter_opts(struct index_state *istate, struct filter_opts *opts);
+void sort_index(struct index_state *istate);
+
+typedef int each_cache_entry_fn(struct cache_entry *ce, void *);
+
+extern int for_each_index_entry(struct index_state *istate,
+				each_cache_entry_fn, void *);
+
+
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const char **pathspec);
diff --git a/read-cache-v2.c b/read-cache-v2.c
index a6883c3..1ed640d 100644
--- a/read-cache-v2.c
+++ b/read-cache-v2.c
@@ -3,6 +3,7 @@
 #include "resolve-undo.h"
 #include "cache-tree.h"
 #include "varint.h"
+#include "dir.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 #define CE_NAMEMASK  (0x0fff)
@@ -117,6 +118,7 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 	hashcpy(ce->sha1, ondisk->sha1);
 	memcpy(ce->name, name, len);
 	ce->name[len] = '\0';
+	ce->next_ce = NULL;
 	return ce;
 }
 
@@ -207,14 +209,21 @@ static int read_index_extension(struct index_state *istate,
 	return 0;
 }
 
+/*
+ * The performance is the same if we read the whole index or only
+ * part of it, therefore we always read the whole index to avoid
+ * having to re-read it later.  The filter_opts will determine
+ * what part of the index is used when retrieving the cache-entries.
+ */
 static int read_index_v2(struct index_state *istate, void *mmap,
-			 unsigned long mmap_size)
+			 unsigned long mmap_size, struct filter_opts *opts)
 {
 	int i;
 	unsigned long src_offset;
 	struct cache_version_header *hdr;
 	struct cache_header *hdr_v2;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	struct cache_entry *prev = NULL;
 
 	hdr = mmap;
 	hdr_v2 = (struct cache_header *)((char *)mmap + sizeof(*hdr));
@@ -237,9 +246,12 @@ static int read_index_v2(struct index_state *istate, void *mmap,
 
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
 		ce = create_from_disk(disk_ce, &consumed, previous_name);
+		if (prev)
+			prev->next_ce = ce;
 		set_index_entry(istate, i, ce);
 
 		src_offset += consumed;
+		prev = ce;
 	}
 	strbuf_release(&previous_name_buf);
 
@@ -267,6 +279,16 @@ unmap:
 	die("index file corrupt");
 }
 
+static void index_change_filter_opts_v2(struct index_state *istate, struct filter_opts *opts)
+{
+	/*
+	 * We don't need to re-read anything, because in index v2 we
+	 * read the whole index up front.  Just change the options by
+	 * which the index is filtered when accessing it.
+	 */
+	istate->filter_opts = opts;
+}
+
 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
@@ -548,9 +570,79 @@ static int write_index_v2(struct index_state *istate, int newfd)
 	return 0;
 }
 
+int for_each_index_entry_v2(struct index_state *istate, each_cache_entry_fn fn, void *cb_data)
+{
+	int i, ret = 0;
+	struct filter_opts *opts= istate->filter_opts;
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+
+		if (opts && !opts->read_staged && ce_stage(ce))
+			continue;
+
+		if (opts && !match_pathspec(opts->pathspec, ce->name, ce_namelen(ce),
+					    opts->max_prefix_len, opts->seen))
+			continue;
+
+		if ((ret = fn(istate->cache[i], cb_data)))
+			break;
+	}
+	if (opts && !opts->max_prefix) {
+		opts->max_prefix = common_prefix(opts->pathspec);
+		opts->max_prefix_len = opts->max_prefix ? strlen(opts->max_prefix) : 0;
+	}
+
+	return ret;
+}
+
+int get_index_entry_by_name_v2(struct index_state *istate, const char *name, int namelen,
+			       struct cache_entry **ce)
+{
+	int pos = index_name_pos(istate, name, namelen);
+
+	*ce = NULL;
+	if (0 <= pos) {
+		*ce = istate->cache[pos];
+		return 1;
+	}
+	pos = -pos - 1;
+
+	if (pos < istate->cache_nr)
+		*ce = istate->cache[pos];
+	return 0;
+}
+
+static int cmp_cache_name_compare(const void *a_, const void *b_)
+{
+	const struct cache_entry *ce1, *ce2;
+
+	ce1 = *((const struct cache_entry **)a_);
+	ce2 = *((const struct cache_entry **)b_);
+	return cache_name_stage_compare(ce1->name, ce1->ce_namelen, ce_stage(ce1),
+					ce2->name, ce2->ce_namelen, ce_stage(ce2));
+}
+
+void sort_index_v2(struct index_state *istate)
+{
+	/*
+	 * Nuke the cache-tree first, as it will no longer be up to date
+	 */
+	cache_tree_free(&istate->cache_tree);
+	qsort(istate->cache, istate->cache_nr, sizeof(istate->cache[0]),
+	      cmp_cache_name_compare);
+}
+
 struct index_ops v2_ops = {
 	match_stat_basic,
 	verify_hdr,
 	read_index_v2,
-	write_index_v2
+	write_index_v2,
+	index_change_filter_opts_v2
+};
+
+struct internal_ops v2_internal_ops = {
+	for_each_index_entry_v2,
+	get_index_entry_by_name_v2,
+	sort_index_v2
 };
diff --git a/read-cache.c b/read-cache.c
index 3e3a0e2..b30ee75 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -471,6 +471,8 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 	remove_name_hash(istate, ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
+	if (pos > 0)
+		istate->cache[pos - 1]->next_ce = ce->next_ce;
 	if (pos >= istate->cache_nr)
 		return 0;
 	memmove(istate->cache + pos,
@@ -490,10 +492,13 @@ void remove_marked_cache_entries(struct index_state *istate)
 	unsigned int i, j;
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
-		if (ce_array[i]->ce_flags & CE_REMOVE)
+		if (ce_array[i]->ce_flags & CE_REMOVE) {
 			remove_name_hash(istate, ce_array[i]);
-		else
+		} else {
+			if (j > 0)
+				ce_array[j - 1]->next_ce = ce_array[i]->next_ce;
 			ce_array[j++] = ce_array[i];
+		}
 	}
 	istate->cache_changed = 1;
 	istate->cache_nr = j;
@@ -996,6 +1001,13 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 		memmove(istate->cache + pos + 1,
 			istate->cache + pos,
 			(istate->cache_nr - pos - 1) * sizeof(ce));
+
+	if (pos + 1 >= istate->cache_nr)
+		ce->next_ce = NULL;
+	else
+		ce->next_ce = istate->cache[pos]->next_ce;
+	if (pos > 0)
+		istate->cache[pos - 1]->next_ce = ce;
 	set_index_entry(istate, pos, ce);
 	istate->cache_changed = 1;
 	return 0;
@@ -1272,7 +1284,82 @@ static int verify_hdr_version(struct index_state *istate,
 
 int read_index(struct index_state *istate)
 {
-	return read_index_from(istate, get_index_file());
+	return read_index_filtered_from(istate, get_index_file(), NULL);
+}
+
+int read_index_filtered(struct index_state *istate, struct filter_opts *opts)
+{
+	return read_index_filtered_from(istate, get_index_file(), opts);
+}
+
+int set_internal_ops(struct index_state *istate)
+{
+	if (!istate->internal_ops && istate->cache)
+		istate->internal_ops = &v2_internal_ops;
+	if (!istate->internal_ops)
+		return 0;
+	return 1;
+}
+
+/*
+ * Execute fn for each index entry which is currently in istate.  Data
+ * can be given to the function using the cb_data parameter.
+ */
+int for_each_index_entry(struct index_state *istate, each_cache_entry_fn fn, void *cb_data)
+{
+	if (!set_internal_ops(istate))
+		return 0;
+	return istate->internal_ops->for_each_index_entry(istate, fn, cb_data);
+}
+
+/*
+ * Search for an index entry by its name.
+ * The cache entry is returned using the the ce parameter.
+ * Returns: 1 if a cache-entry was an exact match
+ *          0 if the name of a cache-entry was partially matched.  The
+ *            first cache-entry that matches is returned using the ce
+ *            parameter.  Finding the cache-entry that is needed is left
+ *            to the caller.
+ */
+int get_index_entry_by_name(struct index_state *istate, const char *name, int namelen,
+			    struct cache_entry **ce)
+{
+	if (!set_internal_ops(istate)) {
+		*ce = NULL;
+		return 0;
+	}
+	return istate->internal_ops->get_index_entry_by_name(istate, name, namelen, ce);
+}
+
+/*
+ * Return the next index entry, using the given index entry.  Use this
+ * if there is the need to iterate from a given cache-entry.
+ */
+struct cache_entry *next_index_entry(struct cache_entry *ce)
+{
+	return ce->next_ce;
+}
+
+/*
+ * Sorts the index from an unordered list
+ */
+void sort_index(struct index_state *istate)
+{
+	if (!set_internal_ops(istate))
+		return;
+	istate->internal_ops->sort_index(istate);
+}
+/*
+ * Change the filter_opts, and re-read the index if necessary
+ */
+void index_change_filter_opts(struct index_state *istate, struct filter_opts *opts)
+{
+	if (!istate->ops) {
+		/* Just re-read the index, we haven't read it before */
+		read_index_filtered(istate, opts);
+		return;
+	}
+	istate->ops->index_change_filter_opts(istate, opts);
 }
 
 static int index_changed(struct stat *st_old, struct stat *st_new)
@@ -1295,8 +1382,9 @@ static int index_changed(struct stat *st_old, struct stat *st_new)
 	return 0;
 }
 
-/* remember to discard_cache() before reading a different cache! */
-int read_index_from(struct index_state *istate, const char *path)
+
+int read_index_filtered_from(struct index_state *istate, const char *path,
+			     struct filter_opts *opts)
 {
 	int fd, err, i;
 	struct stat st_old, st_new;
@@ -1337,7 +1425,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
 			err = 1;
 
-		if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
+		if (istate->ops->read_index(istate, mmap, mmap_size, opts) < 0)
 			err = 1;
 		istate->timestamp.sec = st_old.st_mtime;
 		istate->timestamp.nsec = ST_MTIME_NSEC(st_old);
@@ -1345,6 +1433,7 @@ int read_index_from(struct index_state *istate, const char *path)
 			die_errno("cannot stat the open index");
 
 		munmap(mmap, mmap_size);
+		istate->filter_opts = opts;
 		if (!index_changed(&st_old, &st_new) && !err)
 			return istate->cache_nr;
 	}
@@ -1352,6 +1441,13 @@ int read_index_from(struct index_state *istate, const char *path)
 	die("index file corrupt");
 }
 
+
+/* remember to discard_cache() before reading a different cache! */
+int read_index_from(struct index_state *istate, const char *path)
+{
+	return read_index_filtered_from(istate, path, NULL);
+}
+
 int is_index_unborn(struct index_state *istate)
 {
 	return (!istate->cache_nr && !istate->timestamp.sec);
diff --git a/read-cache.h b/read-cache.h
index f31a38b..ce9b79c 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -24,11 +24,21 @@ struct cache_version_header {
 struct index_ops {
 	int (*match_stat_basic)(const struct cache_entry *ce, struct stat *st, int changed);
 	int (*verify_hdr)(void *mmap, unsigned long size);
-	int (*read_index)(struct index_state *istate, void *mmap, unsigned long mmap_size);
+	int (*read_index)(struct index_state *istate, void *mmap, unsigned long mmap_size,
+			  struct filter_opts *opts);
 	int (*write_index)(struct index_state *istate, int newfd);
+	void (*index_change_filter_opts)(struct index_state *istate, struct filter_opts *opts);
+};
+
+struct internal_ops {
+	int (*for_each_index_entry)(struct index_state *istate, each_cache_entry_fn fn, void *cb_data);
+	int (*get_index_entry_by_name)(struct index_state *istate, const char *name, int namelen,
+				       struct cache_entry **ce);
+	void (*sort_index)(struct index_state *istate);
 };
 
 extern struct index_ops v2_ops;
+extern struct internal_ops v2_internal_ops;
 
 #ifndef NEEDS_ALIGNED_ACCESS
 #define ntoh_s(var) ntohs(var)
-- 
1.8.3.453.g1dfc63d
