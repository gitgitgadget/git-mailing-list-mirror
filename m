Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586412ED148
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372414; cv=none; b=nzvDNqNYZGPfb/dYaz/0uPpCGjkGnSse16y0GTaxMD5tzZK6Oh/giy8W+EpiN1xSS4piceBx8tE8Pr8DiSzEgJs+naqwA7282uL8hkXjkzTkPxWFj1Va6ROKsM8JgCkICfHc92xYPuvijmSAUnRyQSctEmaKT5kcHxdhGAjT6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372414; c=relaxed/simple;
	bh=u+32Sv1/8/liKPZfdNZsov3+zyQ2v2bKVNjgPR0nuDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWb46EbtVekCNK48tLKDuyTkfEMzqmMIv2LPj3b44/LY9YziLNqXgZm0NMVr+movayWJuqmKFkQ62823+NwoJYX0jVvIQKbrXWCLtYNFhFEUhUTyhDs1S46n7hOi5An7Mbs3cygVDC3LeVzs1RqpBglZuJaADEnj36jWSr6p1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gjNss7bh; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gjNss7bh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1765372409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69E0tqJDYXqTbwWjyHEJ9Fi/15fehAK+o/uR03KTCQ8=;
	b=gjNss7bhz3h0G6BGPMySt2KMZZlWIFj6O74QlBtKfDTPVHb29n0ePW6jpPcimdO8ArkBjm
	Ad5OGfc4eJjDb2jcSkusQY8mbDw1KTNRClHFV77JFrWf3iKflWYZORn69L/LZVA6pOMSxO
	wu4MFxTQvSmHno2LixV6xdPpoagnl4U=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 10 Dec 2025 14:13:01 +0100
Subject: [PATCH 1/2] git-compat-util: introduce MEMZERO_ARRAY() macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-toon-cocci-memzero-v1-1-ae916a79065b@iotcl.com>
References: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
In-Reply-To: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Introduce a new macro MEMZERO_ARRAY() that zeroes the memory allocated
by ALLOC_ARRAY() and friends. And add coccinelle rule to enforce the use
of this macro.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c        |  2 +-
 compat/simple-ipc/ipc-win32.c  |  2 +-
 contrib/coccinelle/array.cocci | 20 ++++++++++++++++++++
 diff-delta.c                   |  2 +-
 ewah/bitmap.c                  |  7 +++----
 git-compat-util.h              |  1 +
 hashmap.c                      |  2 +-
 pack-revindex.c                |  2 +-
 8 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index cc5fd2e795..ac5387e861 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -327,7 +327,7 @@ static void process_parent(struct last_modified *lm,
 	if (!(parent->object.flags & PARENT1))
 		active_paths_free(lm, parent);
 
-	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc * sizeof(eword_t));
+	MEMZERO_ARRAY(lm->scratch->words, lm->scratch->word_alloc);
 	diff_queue_clear(&diff_queued_diff);
 }
 
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index a8fc812adf..4a3e7df9c7 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -686,7 +686,7 @@ static LPSECURITY_ATTRIBUTES get_sa(struct my_sa_data *d)
 		goto fail;
 	}
 
-	memset(ea, 0, NR_EA * sizeof(EXPLICIT_ACCESS));
+	MEMZERO_ARRAY(ea, NR_EA);
 
 	ea[0].grfAccessPermissions = GENERIC_READ | GENERIC_WRITE;
 	ea[0].grfAccessMode = SET_ACCESS;
diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.cocci
index 27a3b479c9..d306f6a21e 100644
--- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -101,3 +101,23 @@ expression dst, src, n;
 -ALLOC_ARRAY(dst, n);
 -COPY_ARRAY(dst, src, n);
 +DUP_ARRAY(dst, src, n);
+
+@@
+type T;
+T *ptr;
+expression n;
+@@
+- memset(ptr, \( 0x0 \| 0 \), n * \( sizeof(T)
+-                                 \| sizeof(*ptr)
+-                                 \) )
++ MEMZERO_ARRAY(ptr, n)
+
+@@
+type T;
+T[] ptr;
+expression n;
+@@
+- memset(ptr, \( 0x0 \| 0 \), n * \( sizeof(T)
+-                                 \| sizeof(*ptr)
+-                                 \) )
++ MEMZERO_ARRAY(ptr, n)
diff --git a/diff-delta.c b/diff-delta.c
index 71d37368d6..43c339f010 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -171,7 +171,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	mem = hash + hsize;
 	entry = mem;
 
-	memset(hash, 0, hsize * sizeof(*hash));
+	MEMZERO_ARRAY(hash, hsize);
 
 	/* allocate an array to count hash entries */
 	hash_count = calloc(hsize, sizeof(*hash_count));
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 55928dada8..bf878bf876 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -46,8 +46,7 @@ static void bitmap_grow(struct bitmap *self, size_t word_alloc)
 {
 	size_t old_size = self->word_alloc;
 	ALLOC_GROW(self->words, word_alloc, self->word_alloc);
-	memset(self->words + old_size, 0x0,
-	       (self->word_alloc - old_size) * sizeof(eword_t));
+	MEMZERO_ARRAY(self->words + old_size, (self->word_alloc - old_size));
 }
 
 void bitmap_set(struct bitmap *self, size_t pos)
@@ -192,8 +191,8 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 	if (self->word_alloc < other_final) {
 		self->word_alloc = other_final;
 		REALLOC_ARRAY(self->words, self->word_alloc);
-		memset(self->words + original_size, 0x0,
-			(self->word_alloc - original_size) * sizeof(eword_t));
+		MEMZERO_ARRAY(self->words + original_size,
+		              (self->word_alloc - original_size));
 	}
 
 	ewah_iterator_init(&it, other);
diff --git a/git-compat-util.h b/git-compat-util.h
index 398e0fac4f..2b8192fd2e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -726,6 +726,7 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
+#define MEMZERO_ARRAY(x, alloc) memset((x), 0x0, st_mult(sizeof(*(x)), (alloc)))
 
 #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
 	BARF_UNLESS_COPYABLE((dst), (src)))
diff --git a/hashmap.c b/hashmap.c
index a711377853..3b5d6f14bc 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -194,7 +194,7 @@ void hashmap_partial_clear_(struct hashmap *map, ssize_t entry_offset)
 		return;
 	if (entry_offset >= 0)  /* called by hashmap_clear_entries */
 		free_individual_entries(map, entry_offset);
-	memset(map->table, 0, map->tablesize * sizeof(struct hashmap_entry *));
+	MEMZERO_ARRAY(map->table, map->tablesize);
 	map->shrink_at = 0;
 	map->private_size = 0;
 }
diff --git a/pack-revindex.c b/pack-revindex.c
index d0791cc493..8598b941c8 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -75,7 +75,7 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 	for (bits = 0; max >> bits; bits += DIGIT_SIZE) {
 		unsigned i;
 
-		memset(pos, 0, BUCKETS * sizeof(*pos));
+		MEMZERO_ARRAY(pos, BUCKETS);
 
 		/*
 		 * We want pos[i] to store the index of the last element that

-- 
2.52.0

