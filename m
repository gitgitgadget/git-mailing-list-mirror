Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103A4C62
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721003762; cv=none; b=u7x/mhENn4Jat33tAuSddl+UVj7pZpOp+i6NuhjD85pv0khya5y76JG+af4l8LghRzUO+o7pxN6mfmRg+JaL9JP56MWD2u4Ylfv32ivIOwheeCkvKyuj1j/4FQh0uyCeD2r/QRNOlEdEqgp9ztHrBxOWbOEbMLY7syrPDpi8GpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721003762; c=relaxed/simple;
	bh=6yiKnYC0VYfUAp1XQEs77kquAENxw9r4poLIMaZwh04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GO1sKvwxylTOnCHlJNjrgs4gOE0G+0y60wrfamWGicJLW9dEtDzNeapYz2JRXvE8ZjsnnBIPO1Y8NApbITkIG58gLlQMDUWQXo7IeLGIVgTb4RQEdqVW7NJIAVXAvXJb694I6ycZ/YLEvbT4LWeHNzXOCxWPnPRD3afkLM2zjWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=BF+4yOvv; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="BF+4yOvv"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D5A1F5B7;
	Mon, 15 Jul 2024 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721003720;
	bh=6yiKnYC0VYfUAp1XQEs77kquAENxw9r4poLIMaZwh04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BF+4yOvvujZ3BA44F1x3cYdKUKFKGa9uIdlXbQsnDGFJkpNnsjvzZI6oZW99VLr1s
	 DgnUHCpqQBTa1uRZpG+jxBcr5NCJC/KNc7J3gU9N9Sr67bC/oBoe6s8bD4uj5fO54D
	 +Pi9TMOUXzkzPxwExr6DY33bXAm29tec+Km1uIxQ=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v1 05/10] cat-file: use delta_base_cache entries directly
Date: Mon, 15 Jul 2024 00:35:14 +0000
Message-ID: <20240715003519.2671385-6-e@80x24.org>
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>
References: <20240715003519.2671385-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For objects already in the delta_base_cache, we can safely use
them directly to avoid the malloc+memcpy+free overhead.

While only 2-7% of objects are delta bases in repos I've looked
at, this avoids up to 96MB of duplicated memory in the worst
case with the default git config.  For a more reasonable 1MB
delta base object, this eliminates the speed penalty of
duplicating large objects into memory and speeds up those 1MB
delta base cached content retrievals by roughly 30%.

The new delta_base_cache_lock is a simple single-threaded
assertion to ensure cat-file is the exclusive user of the
delta_base_cache.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/cat-file.c | 15 ++++++++++++++-
 object-file.c      |  5 +++++
 object-store-ll.h  |  7 +++++++
 packfile.c         | 28 +++++++++++++++++++++++++---
 packfile.h         |  4 ++++
 5 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bc4bb89610..769c8b48d2 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -24,6 +24,7 @@
 #include "promisor-remote.h"
 #include "mailmap.h"
 #include "write-or-die.h"
+#define USE_DIRECT_CACHE 1
 
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
@@ -386,7 +387,18 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 
 	if (data->content) {
 		batch_write(opt, data->content, data->size);
-		FREE_AND_NULL(data->content);
+		switch (data->info.whence) {
+		case OI_CACHED: BUG("FIXME OI_CACHED support not done");
+		case OI_LOOSE:
+		case OI_PACKED:
+			FREE_AND_NULL(data->content);
+			break;
+		case OI_DBCACHED:
+			if (USE_DIRECT_CACHE)
+				unlock_delta_base_cache();
+			else
+				FREE_AND_NULL(data->content);
+		}
 	} else if (data->type == OBJ_BLOB) {
 		if (opt->buffer_output)
 			fflush(stdout);
@@ -815,6 +827,7 @@ static int batch_objects(struct batch_options *opt)
 			data.info.sizep = &data.size;
 			data.info.contentp = &data.content;
 			data.info.content_limit = big_file_threshold;
+			data.info.direct_cache = USE_DIRECT_CACHE;
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
index b71a15f590..50c5219308 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -298,6 +298,13 @@ struct object_info {
 		OI_PACKED,
 		OI_DBCACHED
 	} whence;
+
+	/*
+	 * set if caller is able to use OI_DBCACHED entries without copying
+	 * TODO OI_CACHED if its use goes beyond blame
+	 */
+	unsigned direct_cache:1;
+
 	union {
 		/*
 		 * struct {
diff --git a/packfile.c b/packfile.c
index 1a409ec142..b2660e14f9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1362,6 +1362,9 @@ static enum object_type packed_to_object_type(struct repository *r,
 static struct hashmap delta_base_cache;
 static size_t delta_base_cached;
 
+/* ensures oi->direct_cache is used properly */
+static int delta_base_cache_lock;
+
 static LIST_HEAD(delta_base_cache_lru);
 
 struct delta_base_cache_key {
@@ -1444,6 +1447,18 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
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
@@ -1453,6 +1468,7 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 void clear_delta_base_cache(void)
 {
 	struct list_head *lru, *tmp;
+	assert(!delta_base_cache_lock);
 	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
 		struct delta_base_cache_entry *entry =
 			list_entry(lru, struct delta_base_cache_entry, lru);
@@ -1466,6 +1482,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	struct delta_base_cache_entry *ent;
 	struct list_head *lru, *tmp;
 
+	assert(!delta_base_cache_lock);
 	/*
 	 * Check required to avoid redundant entries when more than one thread
 	 * is unpacking the same object, in unpack_entry() (since its phases I
@@ -1521,11 +1538,16 @@ int packed_object_info(struct repository *r, struct packed_git *p,
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
