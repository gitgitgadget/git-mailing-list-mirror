Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE68185B72
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453235; cv=none; b=gOZnS6fZAm3IAO8usBmEWVYBk+djQJvVaiIRIYhLWfgXANl41O/KNo2wp0tGSjbIBvYX5VRJ9oZWl4skEFge4znDbpwlRj7tBJ8Z/ynHOPdMtgIZMtZmS0OvktW7nDJtfLcDNu7havWF7fyStcdSzIf9Q8cmDDOcK+Plp/Zzzj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453235; c=relaxed/simple;
	bh=6OVRRV5hJacNEh3iVoby8LVAWThACnoCmwApPeqpLWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bo5aeEJn1e+UzgPZaHrWt7uVlg8V8oadhGvbFml+AuXLl0lNp4OeTaAsZJt5bzEsUnrgtxeAcxoLFAOCETQPwi8WqMV4vGPNi3od/Mcnyee5bp0EcDFG+DrnhfwlWrYMIi/mnfOtnha7AeFj09iftt46nZQbi+av4Rlv7aNB4Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=P+Vi2X0W; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="P+Vi2X0W"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FF8D1F51B;
	Fri, 23 Aug 2024 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453192;
	bh=6OVRRV5hJacNEh3iVoby8LVAWThACnoCmwApPeqpLWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+Vi2X0WHpgYO/TRd8NIeKfqP1pGabAkh9gcsb1UKDV5Us55H9OTDdddB22B0Bhux
	 ARHuc6OWATAtlv5QcB2U4LbiSzSQnhrh0Su94u4jXUuW1m8SdRuzk98XzFfipm+3EP
	 CaboVW5tUe+xVOQ/eFuUzS5Trah/sAj6vBbxooGM=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 05/10] cat-file: use delta_base_cache entries directly
Date: Fri, 23 Aug 2024 22:46:25 +0000
Message-ID: <20240823224630.1180772-6-e@80x24.org>
In-Reply-To: <20240823224630.1180772-1-e@80x24.org>
References: <20240823224630.1180772-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For objects already in the delta_base_cache, we can safely use
one entry at-a-time directly to avoid the malloc+memcpy+free
overhead.  For a 1MB delta base object, this eliminates the
speed penalty of duplicating large objects into memory and
speeds up those 1MB delta base cached content retrievals by
roughly 30%.

While only 2-7% of objects are delta bases in repos I've looked
at, this avoids up to 96MB of duplicated memory in the worst
case with the default git config.

The new delta_base_cache_lock is a simple single-threaded
assertion to ensure cat-file (and similar) is the exclusive user
of the delta_base_cache.  In other words, we cannot have diff
or similar commands using two or more entries directly from the
delta base cache.  The new lock has nothing to do with parallel
access via multiple threads at the moment.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/cat-file.c | 16 +++++++++++++++-
 object-file.c      |  5 +++++
 object-store-ll.h  |  8 ++++++++
 packfile.c         | 33 ++++++++++++++++++++++++++++++---
 packfile.h         |  4 ++++
 5 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bc4bb89610..8debcdca3e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -386,7 +386,20 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 
 	if (data->content) {
 		batch_write(opt, data->content, data->size);
-		FREE_AND_NULL(data->content);
+		switch (data->info.whence) {
+		case OI_CACHED:
+			/*
+			 * only blame uses OI_CACHED atm, so it's unlikely
+			 * we'll ever hit this path
+			 */
+			BUG("TODO OI_CACHED support not done");
+		case OI_LOOSE:
+		case OI_PACKED:
+			FREE_AND_NULL(data->content);
+			break;
+		case OI_DBCACHED:
+			unlock_delta_base_cache();
+		}
 	} else if (data->type == OBJ_BLOB) {
 		if (opt->buffer_output)
 			fflush(stdout);
@@ -815,6 +828,7 @@ static int batch_objects(struct batch_options *opt)
 			data.info.sizep = &data.size;
 			data.info.contentp = &data.content;
 			data.info.content_limit = big_file_threshold;
+			data.info.direct_cache = 1;
 		}
 	}
 
diff --git a/object-file.c b/object-file.c
index 1cc29c3c58..19100e823d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1586,6 +1586,11 @@ static int do_oid_object_info_extended(struct repository *r,
 			oidclr(oi->delta_base_oid, the_repository->hash_algo);
 		if (oi->type_name)
 			strbuf_addstr(oi->type_name, type_name(co->type));
+		/*
+		 * Currently `blame' is the only command which creates
+		 * OI_CACHED, and direct_cache is only used by `cat-file'.
+		 */
+		assert(!oi->direct_cache);
 		if (oi->contentp)
 			*oi->contentp = xmemdupz(co->buf, co->size);
 		oi->whence = OI_CACHED;
diff --git a/object-store-ll.h b/object-store-ll.h
index b71a15f590..669bb93784 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -298,6 +298,14 @@ struct object_info {
 		OI_PACKED,
 		OI_DBCACHED
 	} whence;
+
+	/*
+	 * Set if caller is able to use OI_DBCACHED entries without copying.
+	 * This only applies to OI_DBCACHED entries at the moment,
+	 * not OI_CACHED or any other type of entry.
+	 */
+	unsigned direct_cache:1;
+
 	union {
 		/*
 		 * struct {
diff --git a/packfile.c b/packfile.c
index 0a90a5ed67..40c6c2e387 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1362,6 +1362,14 @@ static enum object_type packed_to_object_type(struct repository *r,
 static struct hashmap delta_base_cache;
 static size_t delta_base_cached;
 
+/*
+ * Ensures only a single object is used at-a-time via oi->direct_cache.
+ * Using two objects directly at once (e.g. diff) would cause corruption
+ * since populating the cache may invalidate existing entries.
+ * This lock has nothing to do with parallelism at the moment.
+ */
+static int delta_base_cache_lock;
+
 static LIST_HEAD(delta_base_cache_lru);
 
 struct delta_base_cache_key {
@@ -1444,6 +1452,18 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 	free(ent);
 }
 
+static void lock_delta_base_cache(void)
+{
+	delta_base_cache_lock++;
+	assert(delta_base_cache_lock == 1);
+}
+
+void unlock_delta_base_cache(void)
+{
+	delta_base_cache_lock--;
+	assert(delta_base_cache_lock == 0);
+}
+
 static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 {
 	free(ent->data);
@@ -1453,6 +1473,7 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 void clear_delta_base_cache(void)
 {
 	struct list_head *lru, *tmp;
+	assert(!delta_base_cache_lock);
 	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
 		struct delta_base_cache_entry *entry =
 			list_entry(lru, struct delta_base_cache_entry, lru);
@@ -1466,6 +1487,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	struct delta_base_cache_entry *ent;
 	struct list_head *lru, *tmp;
 
+	assert(!delta_base_cache_lock);
 	/*
 	 * Check required to avoid redundant entries when more than one thread
 	 * is unpacking the same object, in unpack_entry() (since its phases I
@@ -1520,11 +1542,16 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		if (oi->sizep)
 			*oi->sizep = ent->size;
 		if (oi->contentp) {
-			if (!oi->content_limit ||
-					ent->size <= oi->content_limit)
+			/* ignore content_limit if avoiding copy from cache */
+			if (oi->direct_cache) {
+				lock_delta_base_cache();
+				*oi->contentp = ent->data;
+			} else if (!oi->content_limit ||
+					ent->size <= oi->content_limit) {
 				*oi->contentp = xmemdupz(ent->data, ent->size);
-			else
+			} else {
 				*oi->contentp = NULL; /* caller must stream */
+			}
 		}
 	} else if (oi->contentp && !oi->content_limit) {
 		*oi->contentp = unpack_entry(r, p, obj_offset, &type,
diff --git a/packfile.h b/packfile.h
index eb18ec15db..94941bbe80 100644
--- a/packfile.h
+++ b/packfile.h
@@ -210,4 +210,8 @@ int is_promisor_object(const struct object_id *oid);
 int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	     size_t idx_size, struct packed_git *p);
 
+/*
+ * release lock acquired via oi->direct_cache
+ */
+void unlock_delta_base_cache(void);
 #endif
