Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FE82877
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408046; cv=none; b=KEeIVqQK/syQKOVMuHpIjE4KEAz/o4lmk0iLG3EX7+K1Qcvqh2opxSdJRIFJbaSCdWGdWfCQM6Zq4C8nQa1vIZqY23JMvUzO/rOGmLdGeS5fd1g31Jyw+TEaFkw+L15ORUFFuAoSMChNGGuL7UxB1wDAL71IEFCY/SD9lYhiJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408046; c=relaxed/simple;
	bh=PW+bfWvuctjvdiHGFyihhQsGOhps/1IsseTO3bhE5t4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBUyHb1uQ00uxEDLdNTqniVEeLeGg/jq1m+rRlH+1YWN9J5fRkBkIE4NdNX0YK2lp2WhBh/Fteqbb7zuTrEmUaYhEfDQzWe3n+OMK1TDrUiQrWoWgycDStd3/K7+37Ck+lLQbGYQDWNwwnuqKQ9rJvKQGADcb4N8Jq6+5b9r+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=ioX08wZ8; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="ioX08wZ8"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCFAB1F51A
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1711408024;
	bh=PW+bfWvuctjvdiHGFyihhQsGOhps/1IsseTO3bhE5t4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ioX08wZ8o9SgtAYXLbkkn06sMvqnsU2lubIHxiQteNzQs3UYAyQaCFNn0iPAZsxhg
	 Rq+l0PwkiE2hCghO1eIdtXQWGoIAXTBvrpT63l/wt3vA50eta7F8dlnWtok8jk2LzJ
	 xQAtA1IfffW3xdBda22JZdn9LacZnzacvJpYQuYo=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH 2/3] treewide: switch to khashl for memory savings
Date: Mon, 25 Mar 2024 23:07:02 +0000
Message-ID: <20240325230704.262272-3-e@80x24.org>
In-Reply-To: <20240325230704.262272-1-e@80x24.org>
References: <20240325230704.262272-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

khashl is an updated version of khash with less memory overhead
(one bit/bucket instead of two) than the original khash and
similar overall performance.  Insertions are simpler (linear
probing) but deletions may be slightly slower[1].  Of course,
the majority of hash tables in git do not delete individual
elements.

Overall memory usage did not decrease much, as the hash tables
and elements we store in them are big and currently dwarf the
overhead of the khash internals.  Only around 10 MB in
allocations (not peak use) is saved when doing a no-op `git gc'
of a Linux kernel object store with thousands of refs and
islands.

A summary of differences I've found from khash to khashl:

* two 32-bit ints (instead of four) in the top-level struct

* 2 heap allocations (instead of 3) for maps
  (though I wonder locality suffers when probing is necessary)

* 1 bit of metadata per-bucket (no tombstones for deleted elements)

* 0.75 load factor.  Lowered slightly from 0.77, but no FP multiply
  and responsible for the aforementioned struct size reduction

* FNV-1A instead of x31 hash for strings

* Fibonacci hashing (__kh_h2b), probably good for FNV-1A, but 
  I'm skeptical of its usefulness for our SHA-* using cases

* linear probing instead of quadratic

* Wang's integer hash functions (currently unused)

* optional hash value caching and ensemble APIs (currently unused)

* some API differences (see below), but not enough to easily
  use both khash and khashl in the same compilation unit

This patch was made with two additional goals to ease review:

1) minimize changes outside of khash*.h files

2) minimize and document all differences from upstream[2] khashl.h

Our khashl.h differences from upstream:

* favor portability constructs from our codebase:
  MAYBE_UNUSED over klib_unused, inline over kh_inline, and
  various integer types

* disable packed attribute to satisfy -Werror=address-of-packed-member,
  AFAIK it doesn't change any of the data structures we use

* port the following commits over from our old khash.h:
  9249ca26aca3 (khash: factor out kh_release_*, 2018-10-04)
  2756ca4347cb (use REALLOC_ARRAY for changing the allocation size of arrays, 2014-09-16)
  5632e838f8fa (khash: clarify that allocations never fail, 2021-07-03)

* use our memory allocation wrappers

* provide wrappers for compatibility with existing callers using the
  khash API.  The khashl function naming convention is: ${NOUN}_${VERB}
  while the khash convention is: kh_${VERB}_${NOUN}.  The kh_${NAME}_t
  typedef and naming convention are preserved via __KHASH_COMPAT macro
  to ease review (despite the `_t' suffix being reserved and typedefs
  being discouraged in the Linux kernel).

* copy relevant API docs over from khash.h for identically named macros

* preserve kh_begin, kh_foreach, kh_foreach_value from khash.h since
  khashl.h doesn't provide them

* flesh out KHASHL_{SET,MAP}_INIT wrappers with *_clear, *_resize,
  and *_release functions

[1] https://attractivechaos.wordpress.com/2019/12/28/deletion-from-hash-tables-without-tombstones/
[2] git clone https://github.com/attractivechaos/klib.git
    2895a16cb55e (support an ensemble of hash tables, 2023-12-18)

khashl.h API differences from khash.h which affected this change:

* KHASHL_MAP_INIT and KHASHL_SET_INIT macros replace KHASH_INIT

* user-supplied hash and equality functions use different names

* object-store-ll.h avoided the kh_*_t convention (since I dislike
  typedef) and was the only place where I had to change a definition.

Signed-off-by: Eric Wong <e@80x24.org>
---
 The git-specific changes are absolutely minimal :>

 builtin/fast-import.c       |   2 +-
 builtin/fsmonitor--daemon.c |   4 +-
 delta-islands.c             |   4 +-
 khash.h                     | 338 -----------------------
 khashl.h                    | 522 ++++++++++++++++++++++++++++++++++++
 object-store-ll.h           |   2 +-
 object-store.h              |   7 +-
 oidset.h                    |   2 +-
 pack-bitmap.h               |   2 +-
 9 files changed, 534 insertions(+), 349 deletions(-)
 delete mode 100644 khash.h
 create mode 100644 khashl.h

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 71a195ca22..29e50fd675 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -24,7 +24,7 @@
 #include "object-store-ll.h"
 #include "mem-pool.h"
 #include "commit-reach.h"
-#include "khash.h"
+#include "khashl.h"
 #include "date.h"
 
 #define PACK_ID_BITS 16
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 1593713f4c..1c71d96c6d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -13,7 +13,7 @@
 #include "fsmonitor--daemon.h"
 #include "repository.h"
 #include "simple-ipc.h"
-#include "khash.h"
+#include "khashl.h"
 #include "run-command.h"
 #include "trace.h"
 #include "trace2.h"
@@ -650,7 +650,7 @@ static int fsmonitor_parse_client_token(const char *buf_token,
 	return 0;
 }
 
-KHASH_INIT(str, const char *, int, 0, kh_str_hash_func, kh_str_hash_equal)
+KHASHL_SET_INIT(KH_LOCAL, kh_str, str, const char *, kh_hash_str, kh_eq_str)
 
 static int do_handle_client(struct fsmonitor_daemon_state *state,
 			    const char *command,
diff --git a/delta-islands.c b/delta-islands.c
index ee2318d45a..aa35839f15 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -10,14 +10,14 @@
 #include "diff.h"
 #include "progress.h"
 #include "refs.h"
-#include "khash.h"
+#include "khashl.h"
 #include "pack-bitmap.h"
 #include "pack-objects.h"
 #include "delta-islands.h"
 #include "oid-array.h"
 #include "config.h"
 
-KHASH_INIT(str, const char *, void *, 1, kh_str_hash_func, kh_str_hash_equal)
+KHASHL_MAP_INIT(KH_LOCAL, kh_str, str, const char *, void *, kh_hash_str, kh_eq_str)
 
 static kh_oid_map_t *island_marks;
 static unsigned island_counter;
diff --git a/khash.h b/khash.h
deleted file mode 100644
index ff88163177..0000000000
--- a/khash.h
+++ /dev/null
@@ -1,338 +0,0 @@
-/* The MIT License
-
-   Copyright (c) 2008, 2009, 2011 by Attractive Chaos <attractor@live.co.uk>
-
-   Permission is hereby granted, free of charge, to any person obtaining
-   a copy of this software and associated documentation files (the
-   "Software"), to deal in the Software without restriction, including
-   without limitation the rights to use, copy, modify, merge, publish,
-   distribute, sublicense, and/or sell copies of the Software, and to
-   permit persons to whom the Software is furnished to do so, subject to
-   the following conditions:
-
-   The above copyright notice and this permission notice shall be
-   included in all copies or substantial portions of the Software.
-
-   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
-   BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
-   ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
-   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-   SOFTWARE.
-*/
-
-#ifndef __AC_KHASH_H
-#define __AC_KHASH_H
-
-#include "hash.h"
-
-#define AC_VERSION_KHASH_H "0.2.8"
-
-typedef uint32_t khint32_t;
-typedef uint64_t khint64_t;
-
-typedef khint32_t khint_t;
-typedef khint_t khiter_t;
-
-#define __ac_isempty(flag, i) ((flag[i>>4]>>((i&0xfU)<<1))&2)
-#define __ac_isdel(flag, i) ((flag[i>>4]>>((i&0xfU)<<1))&1)
-#define __ac_iseither(flag, i) ((flag[i>>4]>>((i&0xfU)<<1))&3)
-#define __ac_set_isdel_false(flag, i) (flag[i>>4]&=~(1ul<<((i&0xfU)<<1)))
-#define __ac_set_isempty_false(flag, i) (flag[i>>4]&=~(2ul<<((i&0xfU)<<1)))
-#define __ac_set_isboth_false(flag, i) (flag[i>>4]&=~(3ul<<((i&0xfU)<<1)))
-#define __ac_set_isdel_true(flag, i) (flag[i>>4]|=1ul<<((i&0xfU)<<1))
-
-#define __ac_fsize(m) ((m) < 16? 1 : (m)>>4)
-
-#define kroundup32(x) (--(x), (x)|=(x)>>1, (x)|=(x)>>2, (x)|=(x)>>4, (x)|=(x)>>8, (x)|=(x)>>16, ++(x))
-
-static inline khint_t __ac_X31_hash_string(const char *s)
-{
-	khint_t h = (khint_t)*s;
-	if (h) for (++s ; *s; ++s) h = (h << 5) - h + (khint_t)*s;
-	return h;
-}
-
-#define kh_str_hash_func(key) __ac_X31_hash_string(key)
-#define kh_str_hash_equal(a, b) (strcmp(a, b) == 0)
-
-static const double __ac_HASH_UPPER = 0.77;
-
-#define __KHASH_TYPE(name, khkey_t, khval_t) \
-	typedef struct kh_##name { \
-		khint_t n_buckets, size, n_occupied, upper_bound; \
-		khint32_t *flags; \
-		khkey_t *keys; \
-		khval_t *vals; \
-	} kh_##name##_t;
-
-#define __KHASH_PROTOTYPES(name, khkey_t, khval_t)	 			\
-	kh_##name##_t *kh_init_##name(void);						\
-	void kh_destroy_##name(kh_##name##_t *h);					\
-	void kh_clear_##name(kh_##name##_t *h);						\
-	khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); \
-	void kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
-	khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret); \
-	void kh_del_##name(kh_##name##_t *h, khint_t x);
-
-#define __KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
-	SCOPE kh_##name##_t *kh_init_##name(void) {							\
-		return (kh_##name##_t*)xcalloc(1, sizeof(kh_##name##_t));		\
-	}																	\
-	SCOPE void kh_release_##name(kh_##name##_t *h)						\
-	{																	\
-		free(h->flags);													\
-		free((void *)h->keys);											\
-		free((void *)h->vals);											\
-	}																	\
-	SCOPE void kh_destroy_##name(kh_##name##_t *h)						\
-	{																	\
-		if (h) {														\
-			kh_release_##name(h);										\
-			free(h);													\
-		}																\
-	}																	\
-	SCOPE void kh_clear_##name(kh_##name##_t *h)						\
-	{																	\
-		if (h && h->flags) {											\
-			memset(h->flags, 0xaa, __ac_fsize(h->n_buckets) * sizeof(khint32_t)); \
-			h->size = h->n_occupied = 0;								\
-		}																\
-	}																	\
-	SCOPE khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key) 	\
-	{																	\
-		if (h->n_buckets) {												\
-			khint_t k, i, last, mask, step = 0; \
-			mask = h->n_buckets - 1;									\
-			k = __hash_func(key); i = k & mask;							\
-			last = i; \
-			while (!__ac_isempty(h->flags, i) && (__ac_isdel(h->flags, i) || !__hash_equal(h->keys[i], key))) { \
-				i = (i + (++step)) & mask; \
-				if (i == last) return h->n_buckets;						\
-			}															\
-			return __ac_iseither(h->flags, i)? h->n_buckets : i;		\
-		} else return 0;												\
-	}																	\
-	SCOPE void kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets) \
-	{ /* This function uses 0.25*n_buckets bytes of working space instead of [sizeof(key_t+val_t)+.25]*n_buckets. */ \
-		khint32_t *new_flags = NULL;										\
-		khint_t j = 1;													\
-		{																\
-			kroundup32(new_n_buckets); 									\
-			if (new_n_buckets < 4) new_n_buckets = 4;					\
-			if (h->size >= (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5)) j = 0;	/* requested size is too small */ \
-			else { /* hash table size to be changed (shrink or expand); rehash */ \
-				ALLOC_ARRAY(new_flags, __ac_fsize(new_n_buckets)); \
-				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint32_t)); \
-				if (h->n_buckets < new_n_buckets) {	/* expand */		\
-					REALLOC_ARRAY(h->keys, new_n_buckets); \
-					if (kh_is_map) {									\
-						REALLOC_ARRAY(h->vals, new_n_buckets); \
-					}													\
-				} /* otherwise shrink */								\
-			}															\
-		}																\
-		if (j) { /* rehashing is needed */								\
-			for (j = 0; j != h->n_buckets; ++j) {						\
-				if (__ac_iseither(h->flags, j) == 0) {					\
-					khkey_t key = h->keys[j];							\
-					khval_t val;										\
-					khint_t new_mask;									\
-					new_mask = new_n_buckets - 1; 						\
-					if (kh_is_map) val = h->vals[j];					\
-					__ac_set_isdel_true(h->flags, j);					\
-					while (1) { /* kick-out process; sort of like in Cuckoo hashing */ \
-						khint_t k, i, step = 0; \
-						k = __hash_func(key);							\
-						i = k & new_mask;								\
-						while (!__ac_isempty(new_flags, i)) i = (i + (++step)) & new_mask; \
-						__ac_set_isempty_false(new_flags, i);			\
-						if (i < h->n_buckets && __ac_iseither(h->flags, i) == 0) { /* kick out the existing element */ \
-							{ khkey_t tmp = h->keys[i]; h->keys[i] = key; key = tmp; } \
-							if (kh_is_map) { khval_t tmp = h->vals[i]; h->vals[i] = val; val = tmp; } \
-							__ac_set_isdel_true(h->flags, i); /* mark it as deleted in the old hash table */ \
-						} else { /* write the element and jump out of the loop */ \
-							h->keys[i] = key;							\
-							if (kh_is_map) h->vals[i] = val;			\
-							break;										\
-						}												\
-					}													\
-				}														\
-			}															\
-			if (h->n_buckets > new_n_buckets) { /* shrink the hash table */ \
-				REALLOC_ARRAY(h->keys, new_n_buckets); \
-				if (kh_is_map) REALLOC_ARRAY(h->vals, new_n_buckets); \
-			}															\
-			free(h->flags); /* free the working space */				\
-			h->flags = new_flags;										\
-			h->n_buckets = new_n_buckets;								\
-			h->n_occupied = h->size;									\
-			h->upper_bound = (khint_t)(h->n_buckets * __ac_HASH_UPPER + 0.5); \
-		}																\
-	}																	\
-	SCOPE khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret) \
-	{																	\
-		khint_t x;														\
-		if (h->n_occupied >= h->upper_bound) { /* update the hash table */ \
-			if (h->n_buckets > (h->size<<1)) {							\
-				kh_resize_##name(h, h->n_buckets - 1); /* clear "deleted" elements */ \
-			} else { \
-				kh_resize_##name(h, h->n_buckets + 1); /* expand the hash table */ \
-			}															\
-		} /* TODO: to implement automatically shrinking; resize() already support shrinking */ \
-		{																\
-			khint_t k, i, site, last, mask = h->n_buckets - 1, step = 0; \
-			x = site = h->n_buckets; k = __hash_func(key); i = k & mask; \
-			if (__ac_isempty(h->flags, i)) x = i; /* for speed up */	\
-			else {														\
-				last = i; \
-				while (!__ac_isempty(h->flags, i) && (__ac_isdel(h->flags, i) || !__hash_equal(h->keys[i], key))) { \
-					if (__ac_isdel(h->flags, i)) site = i;				\
-					i = (i + (++step)) & mask; \
-					if (i == last) { x = site; break; }					\
-				}														\
-				if (x == h->n_buckets) {								\
-					if (__ac_isempty(h->flags, i) && site != h->n_buckets) x = site; \
-					else x = i;											\
-				}														\
-			}															\
-		}																\
-		if (__ac_isempty(h->flags, x)) { /* not present at all */		\
-			h->keys[x] = key;											\
-			__ac_set_isboth_false(h->flags, x);							\
-			++h->size; ++h->n_occupied;									\
-			*ret = 1;													\
-		} else if (__ac_isdel(h->flags, x)) { /* deleted */				\
-			h->keys[x] = key;											\
-			__ac_set_isboth_false(h->flags, x);							\
-			++h->size;													\
-			*ret = 2;													\
-		} else *ret = 0; /* Don't touch h->keys[x] if present and not deleted */ \
-		return x;														\
-	}																	\
-	SCOPE void kh_del_##name(kh_##name##_t *h, khint_t x)				\
-	{																	\
-		if (x != h->n_buckets && !__ac_iseither(h->flags, x)) {			\
-			__ac_set_isdel_true(h->flags, x);							\
-			--h->size;													\
-		}																\
-	}
-
-#define KHASH_DECLARE(name, khkey_t, khval_t)		 					\
-	__KHASH_TYPE(name, khkey_t, khval_t) 								\
-	__KHASH_PROTOTYPES(name, khkey_t, khval_t)
-
-#define KHASH_INIT2(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
-	__KHASH_TYPE(name, khkey_t, khval_t) 								\
-	__KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
-
-#define KHASH_INIT(name, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
-	KHASH_INIT2(name, MAYBE_UNUSED static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
-
-/* Other convenient macros... */
-
-/*! @function
-  @abstract     Test whether a bucket contains data.
-  @param  h     Pointer to the hash table [khash_t(name)*]
-  @param  x     Iterator to the bucket [khint_t]
-  @return       1 if containing data; 0 otherwise [int]
- */
-#define kh_exist(h, x) (!__ac_iseither((h)->flags, (x)))
-
-/*! @function
-  @abstract     Get key given an iterator
-  @param  h     Pointer to the hash table [khash_t(name)*]
-  @param  x     Iterator to the bucket [khint_t]
-  @return       Key [type of keys]
- */
-#define kh_key(h, x) ((h)->keys[x])
-
-/*! @function
-  @abstract     Get value given an iterator
-  @param  h     Pointer to the hash table [khash_t(name)*]
-  @param  x     Iterator to the bucket [khint_t]
-  @return       Value [type of values]
-  @discussion   For hash sets, calling this results in segfault.
- */
-#define kh_val(h, x) ((h)->vals[x])
-
-/*! @function
-  @abstract     Alias of kh_val()
- */
-#define kh_value(h, x) ((h)->vals[x])
-
-/*! @function
-  @abstract     Get the start iterator
-  @param  h     Pointer to the hash table [khash_t(name)*]
-  @return       The start iterator [khint_t]
- */
-#define kh_begin(h) (khint_t)(0)
-
-/*! @function
-  @abstract     Get the end iterator
-  @param  h     Pointer to the hash table [khash_t(name)*]
-  @return       The end iterator [khint_t]
- */
-#define kh_end(h) ((h)->n_buckets)
-
-/*! @function
-  @abstract     Get the number of elements in the hash table
-  @param  h     Pointer to the hash table [khash_t(name)*]
-  @return       Number of elements in the hash table [khint_t]
- */
-#define kh_size(h) ((h)->size)
-
-/*! @function
-  @abstract     Get the number of buckets in the hash table
-  @param  h     Pointer to the hash table [khash_t(name)*]
-  @return       Number of buckets in the hash table [khint_t]
- */
-#define kh_n_buckets(h) ((h)->n_buckets)
-
-/*! @function
-  @abstract     Iterate over the entries in the hash table
-  @param  h     Pointer to the hash table [khash_t(name)*]
-  @param  kvar  Variable to which key will be assigned
-  @param  vvar  Variable to which value will be assigned
-  @param  code  Block of code to execute
- */
-#define kh_foreach(h, kvar, vvar, code) { khint_t __i;		\
-	for (__i = kh_begin(h); __i != kh_end(h); ++__i) {		\
-		if (!kh_exist(h,__i)) continue;						\
-		(kvar) = kh_key(h,__i);								\
-		(vvar) = kh_val(h,__i);								\
-		code;												\
-	} }
-
-/*! @function
-  @abstract     Iterate over the values in the hash table
-  @param  h     Pointer to the hash table [khash_t(name)*]
-  @param  vvar  Variable to which value will be assigned
-  @param  code  Block of code to execute
- */
-#define kh_foreach_value(h, vvar, code) { khint_t __i;		\
-	for (__i = kh_begin(h); __i != kh_end(h); ++__i) {		\
-		if (!kh_exist(h,__i)) continue;						\
-		(vvar) = kh_val(h,__i);								\
-		code;												\
-	} }
-
-static inline unsigned int oidhash_by_value(struct object_id oid)
-{
-	return oidhash(&oid);
-}
-
-static inline int oideq_by_value(struct object_id a, struct object_id b)
-{
-	return oideq(&a, &b);
-}
-
-KHASH_INIT(oid_set, struct object_id, int, 0, oidhash_by_value, oideq_by_value)
-
-KHASH_INIT(oid_map, struct object_id, void *, 1, oidhash_by_value, oideq_by_value)
-
-KHASH_INIT(oid_pos, struct object_id, int, 1, oidhash_by_value, oideq_by_value)
-
-#endif /* __AC_KHASH_H */
diff --git a/khashl.h b/khashl.h
new file mode 100644
index 0000000000..3660fd2ce4
--- /dev/null
+++ b/khashl.h
@@ -0,0 +1,522 @@
+/* The MIT License
+
+   Copyright (c) 2019-2023 by Attractive Chaos <attractor@live.co.uk>
+
+   Permission is hereby granted, free of charge, to any person obtaining
+   a copy of this software and associated documentation files (the
+   "Software"), to deal in the Software without restriction, including
+   without limitation the rights to use, copy, modify, merge, publish,
+   distribute, sublicense, and/or sell copies of the Software, and to
+   permit persons to whom the Software is furnished to do so, subject to
+   the following conditions:
+
+   The above copyright notice and this permission notice shall be
+   included in all copies or substantial portions of the Software.
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+   BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+   ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+   SOFTWARE.
+*/
+
+#ifndef __AC_KHASHL_H
+#define __AC_KHASHL_H
+
+#include "hash.h"
+
+#define AC_VERSION_KHASHL_H "0.2"
+
+typedef uint32_t khint32_t;
+typedef uint64_t khint64_t;
+
+typedef khint32_t khint_t;
+typedef khint_t khiter_t;
+
+#define kh_inline inline /* portably handled elsewhere */
+#define KH_LOCAL static kh_inline MAYBE_UNUSED
+
+#ifndef kcalloc
+#define kcalloc(N,Z) xcalloc(N,Z)
+#endif
+#ifndef kfree
+#define kfree(P) free(P)
+#endif
+
+/****************************
+ * Simple private functions *
+ ****************************/
+
+#define __kh_used(flag, i)       (flag[i>>5] >> (i&0x1fU) & 1U)
+#define __kh_set_used(flag, i)   (flag[i>>5] |= 1U<<(i&0x1fU))
+#define __kh_set_unused(flag, i) (flag[i>>5] &= ~(1U<<(i&0x1fU)))
+
+#define __kh_fsize(m) ((m) < 32? 1 : (m)>>5)
+
+static kh_inline khint_t __kh_h2b(khint_t hash, khint_t bits) { return hash * 2654435769U >> (32 - bits); }
+
+/*******************
+ * Hash table base *
+ *******************/
+
+#define __KHASHL_TYPE(HType, khkey_t) \
+	typedef struct HType { \
+		khint_t bits, count; \
+		khint32_t *used; \
+		khkey_t *keys; \
+	} HType;
+
+#define __KHASHL_PROTOTYPES(HType, prefix, khkey_t) \
+	extern HType *prefix##_init(void); \
+	extern void prefix##_destroy(HType *h); \
+	extern void prefix##_clear(HType *h); \
+	extern khint_t prefix##_getp(const HType *h, const khkey_t *key); \
+	extern void prefix##_resize(HType *h, khint_t new_n_buckets); \
+	extern khint_t prefix##_putp(HType *h, const khkey_t *key, int *absent); \
+	extern void prefix##_del(HType *h, khint_t k);
+
+#define __KHASHL_IMPL_BASIC(SCOPE, HType, prefix) \
+	SCOPE HType *prefix##_init(void) { \
+		return (HType*)kcalloc(1, sizeof(HType)); \
+	} \
+	SCOPE void prefix##_release(HType *h) { \
+		kfree((void *)h->keys); kfree(h->used); \
+	} \
+	SCOPE void prefix##_destroy(HType *h) { \
+		if (!h) return; \
+		prefix##_release(h); \
+		kfree(h); \
+	} \
+	SCOPE void prefix##_clear(HType *h) { \
+		if (h && h->used) { \
+			khint_t n_buckets = (khint_t)1U << h->bits; \
+			memset(h->used, 0, __kh_fsize(n_buckets) * sizeof(khint32_t)); \
+			h->count = 0; \
+		} \
+	}
+
+#define __KHASHL_IMPL_GET(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
+	SCOPE khint_t prefix##_getp_core(const HType *h, const khkey_t *key, khint_t hash) { \
+		khint_t i, last, n_buckets, mask; \
+		if (h->keys == 0) return 0; \
+		n_buckets = (khint_t)1U << h->bits; \
+		mask = n_buckets - 1U; \
+		i = last = __kh_h2b(hash, h->bits); \
+		while (__kh_used(h->used, i) && !__hash_eq(h->keys[i], *key)) { \
+			i = (i + 1U) & mask; \
+			if (i == last) return n_buckets; \
+		} \
+		return !__kh_used(h->used, i)? n_buckets : i; \
+	} \
+	SCOPE khint_t prefix##_getp(const HType *h, const khkey_t *key) { return prefix##_getp_core(h, key, __hash_fn(*key)); } \
+	SCOPE khint_t prefix##_get(const HType *h, khkey_t key) { return prefix##_getp_core(h, &key, __hash_fn(key)); }
+
+#define __KHASHL_IMPL_RESIZE(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
+	SCOPE void prefix##_resize(HType *h, khint_t new_n_buckets) { \
+		khint32_t *new_used = 0; \
+		khint_t j = 0, x = new_n_buckets, n_buckets, new_bits, new_mask; \
+		while ((x >>= 1) != 0) ++j; \
+		if (new_n_buckets & (new_n_buckets - 1)) ++j; \
+		new_bits = j > 2? j : 2; \
+		new_n_buckets = (khint_t)1U << new_bits; \
+		if (h->count > (new_n_buckets>>1) + (new_n_buckets>>2)) return; /* noop, requested size is too small */ \
+		new_used = (khint32_t*)kcalloc(__kh_fsize(new_n_buckets), sizeof(khint32_t)); \
+		n_buckets = h->keys? (khint_t)1U<<h->bits : 0U; \
+		if (n_buckets < new_n_buckets) { /* expand */ \
+			REALLOC_ARRAY(h->keys, new_n_buckets); \
+		} /* otherwise shrink */ \
+		new_mask = new_n_buckets - 1; \
+		for (j = 0; j != n_buckets; ++j) { \
+			khkey_t key; \
+			if (!__kh_used(h->used, j)) continue; \
+			key = h->keys[j]; \
+			__kh_set_unused(h->used, j); \
+			while (1) { /* kick-out process; sort of like in Cuckoo hashing */ \
+				khint_t i; \
+				i = __kh_h2b(__hash_fn(key), new_bits); \
+				while (__kh_used(new_used, i)) i = (i + 1) & new_mask; \
+				__kh_set_used(new_used, i); \
+				if (i < n_buckets && __kh_used(h->used, i)) { /* kick out the existing element */ \
+					{ khkey_t tmp = h->keys[i]; h->keys[i] = key; key = tmp; } \
+					__kh_set_unused(h->used, i); /* mark it as deleted in the old hash table */ \
+				} else { /* write the element and jump out of the loop */ \
+					h->keys[i] = key; \
+					break; \
+				} \
+			} \
+		} \
+		if (n_buckets > new_n_buckets) /* shrink the hash table */ \
+			REALLOC_ARRAY(h->keys, new_n_buckets); \
+		kfree(h->used); /* free the working space */ \
+		h->used = new_used, h->bits = new_bits; \
+	}
+
+#define __KHASHL_IMPL_PUT(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
+	SCOPE khint_t prefix##_putp_core(HType *h, const khkey_t *key, khint_t hash, int *absent) { \
+		khint_t n_buckets, i, last, mask; \
+		n_buckets = h->keys? (khint_t)1U<<h->bits : 0U; \
+		*absent = -1; \
+		if (h->count >= (n_buckets>>1) + (n_buckets>>2)) { /* rehashing */ \
+			prefix##_resize(h, n_buckets + 1U); \
+			n_buckets = (khint_t)1U<<h->bits; \
+		} /* TODO: to implement automatically shrinking; resize() already support shrinking */ \
+		mask = n_buckets - 1; \
+		i = last = __kh_h2b(hash, h->bits); \
+		while (__kh_used(h->used, i) && !__hash_eq(h->keys[i], *key)) { \
+			i = (i + 1U) & mask; \
+			if (i == last) break; \
+		} \
+		if (!__kh_used(h->used, i)) { /* not present at all */ \
+			h->keys[i] = *key; \
+			__kh_set_used(h->used, i); \
+			++h->count; \
+			*absent = 1; \
+		} else *absent = 0; /* Don't touch h->keys[i] if present */ \
+		return i; \
+	} \
+	SCOPE khint_t prefix##_putp(HType *h, const khkey_t *key, int *absent) { return prefix##_putp_core(h, key, __hash_fn(*key), absent); } \
+	SCOPE khint_t prefix##_put(HType *h, khkey_t key, int *absent) { return prefix##_putp_core(h, &key, __hash_fn(key), absent); }
+
+#define __KHASHL_IMPL_DEL(SCOPE, HType, prefix, khkey_t, __hash_fn) \
+	SCOPE int prefix##_del(HType *h, khint_t i) { \
+		khint_t j = i, k, mask, n_buckets; \
+		if (h->keys == 0) return 0; \
+		n_buckets = (khint_t)1U<<h->bits; \
+		mask = n_buckets - 1U; \
+		while (1) { \
+			j = (j + 1U) & mask; \
+			if (j == i || !__kh_used(h->used, j)) break; /* j==i only when the table is completely full */ \
+			k = __kh_h2b(__hash_fn(h->keys[j]), h->bits); \
+			if ((j > i && (k <= i || k > j)) || (j < i && (k <= i && k > j))) \
+				h->keys[i] = h->keys[j], i = j; \
+		} \
+		__kh_set_unused(h->used, i); \
+		--h->count; \
+		return 1; \
+	}
+
+#define KHASHL_DECLARE(HType, prefix, khkey_t) \
+	__KHASHL_TYPE(HType, khkey_t) \
+	__KHASHL_PROTOTYPES(HType, prefix, khkey_t)
+
+/* compatibility wrappers to make khash -> khashl migration easier */
+#define __KHASH_COMPAT(SCOPE, HType, prefix, khkey_t) \
+	typedef HType HType##_t; \
+	SCOPE HType *kh_init_##prefix(void) { return prefix##_init(); } \
+	SCOPE void kh_release_##prefix(HType *h) { prefix##_release(h); } \
+	SCOPE void kh_destroy_##prefix(HType *h) { prefix##_destroy(h); } \
+	SCOPE void kh_clear_##prefix(HType *h) { prefix##_clear(h); } \
+	SCOPE khint_t kh_get_##prefix(const HType *h, khkey_t key) { \
+		return prefix##_get(h, key); \
+	} \
+	SCOPE void kh_resize_##prefix(HType *h, khint_t new_n_buckets) { \
+		prefix##_resize(h, new_n_buckets); \
+	} \
+	SCOPE khint_t kh_put_##prefix(HType *h, khkey_t key, int *absent) { \
+		return prefix##_put(h, key, absent); \
+	} \
+	SCOPE int kh_del_##prefix(HType *h, khint_t i) { \
+		return prefix##_del(h, i); \
+	}
+
+#define KHASHL_INIT(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
+	__KHASHL_TYPE(HType, khkey_t) \
+	__KHASHL_IMPL_BASIC(SCOPE, HType, prefix) \
+	__KHASHL_IMPL_GET(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
+	__KHASHL_IMPL_RESIZE(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
+	__KHASHL_IMPL_PUT(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
+	__KHASHL_IMPL_DEL(SCOPE, HType, prefix, khkey_t, __hash_fn)
+
+/***************************
+ * Ensemble of hash tables *
+ ***************************/
+
+typedef struct {
+	khint_t sub, pos;
+} kh_ensitr_t;
+
+#define KHASHE_INIT(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
+	KHASHL_INIT(KH_LOCAL, HType##_sub, prefix##_sub, khkey_t, __hash_fn, __hash_eq) \
+	typedef struct HType { \
+		khint64_t count:54, bits:8; \
+		HType##_sub *sub; \
+	} HType; \
+	SCOPE HType *prefix##_init(int bits) { \
+		HType *g; \
+		g = (HType*)kcalloc(1, sizeof(*g)); \
+		g->bits = bits; \
+		g->sub = (HType##_sub*)kcalloc(1U<<bits, sizeof(*g->sub)); \
+		return g; \
+	} \
+	SCOPE void prefix##_destroy(HType *g) { \
+		int t; \
+		if (!g) return; \
+		for (t = 0; t < 1<<g->bits; ++t) { kfree((void*)g->sub[t].keys); kfree(g->sub[t].used); } \
+		kfree(g->sub); kfree(g); \
+	} \
+	SCOPE kh_ensitr_t prefix##_getp(const HType *g, const khkey_t *key) { \
+		khint_t hash, low, ret; \
+		kh_ensitr_t r; \
+		HType##_sub *h; \
+		hash = __hash_fn(*key); \
+		low = hash & ((1U<<g->bits) - 1); \
+		h = &g->sub[low]; \
+		ret = prefix##_sub_getp_core(h, key, hash); \
+		if (ret == 1U<<h->bits) r.sub = low, r.pos = (khint_t)-1; \
+		else r.sub = low, r.pos = ret; \
+		return r; \
+	} \
+	SCOPE kh_ensitr_t prefix##_get(const HType *g, const khkey_t key) { return prefix##_getp(g, &key); } \
+	SCOPE kh_ensitr_t prefix##_putp(HType *g, const khkey_t *key, int *absent) { \
+		khint_t hash, low, ret; \
+		kh_ensitr_t r; \
+		HType##_sub *h; \
+		hash = __hash_fn(*key); \
+		low = hash & ((1U<<g->bits) - 1); \
+		h = &g->sub[low]; \
+		ret = prefix##_sub_putp_core(h, key, hash, absent); \
+		if (*absent) ++g->count; \
+		if (ret == 1U<<h->bits) r.sub = low, r.pos = (khint_t)-1; \
+		else r.sub = low, r.pos = ret; \
+		return r; \
+	} \
+	SCOPE kh_ensitr_t prefix##_put(HType *g, const khkey_t key, int *absent) { return prefix##_putp(g, &key, absent); } \
+	SCOPE int prefix##_del(HType *g, kh_ensitr_t itr) { \
+		HType##_sub *h = &g->sub[itr.sub]; \
+		int ret; \
+		ret = prefix##_sub_del(h, itr.pos); \
+		if (ret) --g->count; \
+		return ret; \
+	}
+
+/*****************************
+ * More convenient interface *
+ *****************************/
+
+#define __kh_packed /* noop, we use -Werror=address-of-packed-member */
+#define __kh_cached_hash(x) ((x).hash)
+
+#define KHASHL_SET_INIT(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
+	typedef struct { khkey_t key; } __kh_packed HType##_s_bucket_t; \
+	static kh_inline khint_t prefix##_s_hash(HType##_s_bucket_t x) { return __hash_fn(x.key); } \
+	static kh_inline int prefix##_s_eq(HType##_s_bucket_t x, HType##_s_bucket_t y) { return __hash_eq(x.key, y.key); } \
+	KHASHL_INIT(KH_LOCAL, HType, prefix##_s, HType##_s_bucket_t, prefix##_s_hash, prefix##_s_eq) \
+	SCOPE HType *prefix##_init(void) { return prefix##_s_init(); } \
+	SCOPE void prefix##_release(HType *h) { prefix##_s_release(h); } \
+	SCOPE void prefix##_destroy(HType *h) { prefix##_s_destroy(h); } \
+	SCOPE void prefix##_clear(HType *h) { prefix##_s_clear(h); } \
+	SCOPE void prefix##_resize(HType *h, khint_t new_n_buckets) { prefix##_s_resize(h, new_n_buckets); } \
+	SCOPE khint_t prefix##_get(const HType *h, khkey_t key) { HType##_s_bucket_t t; t.key = key; return prefix##_s_getp(h, &t); } \
+	SCOPE int prefix##_del(HType *h, khint_t k) { return prefix##_s_del(h, k); } \
+	SCOPE khint_t prefix##_put(HType *h, khkey_t key, int *absent) { HType##_s_bucket_t t; t.key = key; return prefix##_s_putp(h, &t, absent); } \
+	__KHASH_COMPAT(SCOPE, HType, prefix, khkey_t)
+
+#define KHASHL_MAP_INIT(SCOPE, HType, prefix, khkey_t, kh_val_t, __hash_fn, __hash_eq) \
+	typedef struct { khkey_t key; kh_val_t val; } __kh_packed HType##_m_bucket_t; \
+	static kh_inline khint_t prefix##_m_hash(HType##_m_bucket_t x) { return __hash_fn(x.key); } \
+	static kh_inline int prefix##_m_eq(HType##_m_bucket_t x, HType##_m_bucket_t y) { return __hash_eq(x.key, y.key); } \
+	KHASHL_INIT(KH_LOCAL, HType, prefix##_m, HType##_m_bucket_t, prefix##_m_hash, prefix##_m_eq) \
+	SCOPE HType *prefix##_init(void) { return prefix##_m_init(); } \
+	SCOPE void prefix##_release(HType *h) { prefix##_m_release(h); } \
+	SCOPE void prefix##_destroy(HType *h) { prefix##_m_destroy(h); } \
+	SCOPE void prefix##_clear(HType *h) { prefix##_m_clear(h); } \
+	SCOPE void prefix##_resize(HType *h, khint_t new_n_buckets) { prefix##_m_resize(h, new_n_buckets); } \
+	SCOPE khint_t prefix##_get(const HType *h, khkey_t key) { HType##_m_bucket_t t; t.key = key; return prefix##_m_getp(h, &t); } \
+	SCOPE int prefix##_del(HType *h, khint_t k) { return prefix##_m_del(h, k); } \
+	SCOPE khint_t prefix##_put(HType *h, khkey_t key, int *absent) { HType##_m_bucket_t t; t.key = key; return prefix##_m_putp(h, &t, absent); } \
+	__KHASH_COMPAT(SCOPE, HType, prefix, khkey_t)
+
+#define KHASHL_CSET_INIT(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
+	typedef struct { khkey_t key; khint_t hash; } __kh_packed HType##_cs_bucket_t; \
+	static kh_inline int prefix##_cs_eq(HType##_cs_bucket_t x, HType##_cs_bucket_t y) { return x.hash == y.hash && __hash_eq(x.key, y.key); } \
+	KHASHL_INIT(KH_LOCAL, HType, prefix##_cs, HType##_cs_bucket_t, __kh_cached_hash, prefix##_cs_eq) \
+	SCOPE HType *prefix##_init(void) { return prefix##_cs_init(); } \
+	SCOPE void prefix##_destroy(HType *h) { prefix##_cs_destroy(h); } \
+	SCOPE khint_t prefix##_get(const HType *h, khkey_t key) { HType##_cs_bucket_t t; t.key = key; t.hash = __hash_fn(key); return prefix##_cs_getp(h, &t); } \
+	SCOPE int prefix##_del(HType *h, khint_t k) { return prefix##_cs_del(h, k); } \
+	SCOPE khint_t prefix##_put(HType *h, khkey_t key, int *absent) { HType##_cs_bucket_t t; t.key = key, t.hash = __hash_fn(key); return prefix##_cs_putp(h, &t, absent); }
+
+#define KHASHL_CMAP_INIT(SCOPE, HType, prefix, khkey_t, kh_val_t, __hash_fn, __hash_eq) \
+	typedef struct { khkey_t key; kh_val_t val; khint_t hash; } __kh_packed HType##_cm_bucket_t; \
+	static kh_inline int prefix##_cm_eq(HType##_cm_bucket_t x, HType##_cm_bucket_t y) { return x.hash == y.hash && __hash_eq(x.key, y.key); } \
+	KHASHL_INIT(KH_LOCAL, HType, prefix##_cm, HType##_cm_bucket_t, __kh_cached_hash, prefix##_cm_eq) \
+	SCOPE HType *prefix##_init(void) { return prefix##_cm_init(); } \
+	SCOPE void prefix##_destroy(HType *h) { prefix##_cm_destroy(h); } \
+	SCOPE khint_t prefix##_get(const HType *h, khkey_t key) { HType##_cm_bucket_t t; t.key = key; t.hash = __hash_fn(key); return prefix##_cm_getp(h, &t); } \
+	SCOPE int prefix##_del(HType *h, khint_t k) { return prefix##_cm_del(h, k); } \
+	SCOPE khint_t prefix##_put(HType *h, khkey_t key, int *absent) { HType##_cm_bucket_t t; t.key = key, t.hash = __hash_fn(key); return prefix##_cm_putp(h, &t, absent); }
+
+#define KHASHE_MAP_INIT(SCOPE, HType, prefix, khkey_t, kh_val_t, __hash_fn, __hash_eq) \
+	typedef struct { khkey_t key; kh_val_t val; } __kh_packed HType##_m_bucket_t; \
+	static kh_inline khint_t prefix##_m_hash(HType##_m_bucket_t x) { return __hash_fn(x.key); } \
+	static kh_inline int prefix##_m_eq(HType##_m_bucket_t x, HType##_m_bucket_t y) { return __hash_eq(x.key, y.key); } \
+	KHASHE_INIT(KH_LOCAL, HType, prefix##_m, HType##_m_bucket_t, prefix##_m_hash, prefix##_m_eq) \
+	SCOPE HType *prefix##_init(int bits) { return prefix##_m_init(bits); } \
+	SCOPE void prefix##_destroy(HType *h) { prefix##_m_destroy(h); } \
+	SCOPE kh_ensitr_t prefix##_get(const HType *h, khkey_t key) { HType##_m_bucket_t t; t.key = key; return prefix##_m_getp(h, &t); } \
+	SCOPE int prefix##_del(HType *h, kh_ensitr_t k) { return prefix##_m_del(h, k); } \
+	SCOPE kh_ensitr_t prefix##_put(HType *h, khkey_t key, int *absent) { HType##_m_bucket_t t; t.key = key; return prefix##_m_putp(h, &t, absent); }
+
+/**************************
+ * Public macro functions *
+ **************************/
+
+#define kh_bucket(h, x) ((h)->keys[x])
+
+/*! @function
+  @abstract     Get the number of elements in the hash table
+  @param  h     Pointer to the hash table
+  @return       Number of elements in the hash table [khint_t]
+ */
+#define kh_size(h) ((h)->count)
+
+#define kh_capacity(h) ((h)->keys? 1U<<(h)->bits : 0U)
+
+/*! @function
+  @abstract     Get the end iterator
+  @param  h     Pointer to the hash table
+  @return       The end iterator [khint_t]
+ */
+#define kh_end(h) kh_capacity(h)
+
+/*! @function
+  @abstract     Get key given an iterator
+  @param  h     Pointer to the hash table
+  @param  x     Iterator to the bucket [khint_t]
+  @return       Key [type of keys]
+ */
+#define kh_key(h, x) ((h)->keys[x].key)
+
+/*! @function
+  @abstract     Get value given an iterator
+  @param  h     Pointer to the hash table
+  @param  x     Iterator to the bucket [khint_t]
+  @return       Value [type of values]
+  @discussion   For hash sets, calling this results in segfault.
+ */
+#define kh_val(h, x) ((h)->keys[x].val)
+
+/*! @function
+  @abstract     Alias of kh_val()
+ */
+#define kh_value(h, x) kh_val(h, x)
+
+/*! @function
+  @abstract     Test whether a bucket contains data.
+  @param  h     Pointer to the hash table
+  @param  x     Iterator to the bucket [khint_t]
+  @return       1 if containing data; 0 otherwise [int]
+ */
+#define kh_exist(h, x) __kh_used((h)->used, (x))
+
+#define kh_ens_key(g, x) kh_key(&(g)->sub[(x).sub], (x).pos)
+#define kh_ens_val(g, x) kh_val(&(g)->sub[(x).sub], (x).pos)
+#define kh_ens_exist(g, x) kh_exist(&(g)->sub[(x).sub], (x).pos)
+#define kh_ens_is_end(x) ((x).pos == (khint_t)-1)
+#define kh_ens_size(g) ((g)->count)
+
+/**************************************
+ * Common hash and equality functions *
+ **************************************/
+
+#define kh_eq_generic(a, b) ((a) == (b))
+#define kh_eq_str(a, b) (strcmp((a), (b)) == 0)
+#define kh_hash_dummy(x) ((khint_t)(x))
+
+static kh_inline khint_t kh_hash_uint32(khint_t key) {
+	key += ~(key << 15);
+	key ^=  (key >> 10);
+	key +=  (key << 3);
+	key ^=  (key >> 6);
+	key += ~(key << 11);
+	key ^=  (key >> 16);
+	return key;
+}
+
+static kh_inline khint_t kh_hash_uint64(khint64_t key) {
+	key = ~key + (key << 21);
+	key = key ^ key >> 24;
+	key = (key + (key << 3)) + (key << 8);
+	key = key ^ key >> 14;
+	key = (key + (key << 2)) + (key << 4);
+	key = key ^ key >> 28;
+	key = key + (key << 31);
+	return (khint_t)key;
+}
+
+#define KH_FNV_SEED 11
+
+static kh_inline khint_t kh_hash_str(const char *s) { /* FNV1a */
+	khint_t h = KH_FNV_SEED ^ 2166136261U;
+	const unsigned char *t = (const unsigned char*)s;
+	for (; *t; ++t)
+		h ^= *t, h *= 16777619;
+	return h;
+}
+
+static kh_inline khint_t kh_hash_bytes(int len, const unsigned char *s) {
+	khint_t h = KH_FNV_SEED ^ 2166136261U;
+	int i;
+	for (i = 0; i < len; ++i)
+		h ^= s[i], h *= 16777619;
+	return h;
+}
+
+/*! @function
+  @abstract     Get the start iterator
+  @param  h     Pointer to the hash table
+  @return       The start iterator [khint_t]
+ */
+#define kh_begin(h) (khint_t)(0)
+
+/*! @function
+  @abstract     Iterate over the entries in the hash table
+  @param  h     Pointer to the hash table
+  @param  kvar  Variable to which key will be assigned
+  @param  vvar  Variable to which value will be assigned
+  @param  code  Block of code to execute
+ */
+#define kh_foreach(h, kvar, vvar, code) { khint_t __i;		\
+	for (__i = kh_begin(h); __i != kh_end(h); ++__i) {	\
+		if (!kh_exist(h,__i)) continue;			\
+		(kvar) = kh_key(h,__i);				\
+		(vvar) = kh_val(h,__i);				\
+		code;						\
+	} }
+
+/*! @function
+  @abstract     Iterate over the values in the hash table
+  @param  h     Pointer to the hash table
+  @param  vvar  Variable to which value will be assigned
+  @param  code  Block of code to execute
+ */
+#define kh_foreach_value(h, vvar, code) { khint_t __i;		\
+	for (__i = kh_begin(h); __i != kh_end(h); ++__i) {	\
+		if (!kh_exist(h,__i)) continue;			\
+		(vvar) = kh_val(h,__i);				\
+		code;						\
+	} }
+
+static inline unsigned int oidhash_by_value(struct object_id oid)
+{
+	return oidhash(&oid);
+}
+
+static inline int oideq_by_value(struct object_id a, struct object_id b)
+{
+	return oideq(&a, &b);
+}
+
+KHASHL_SET_INIT(KH_LOCAL, kh_oid_set, oid_set, struct object_id,
+		oidhash_by_value, oideq_by_value)
+
+KHASHL_MAP_INIT(KH_LOCAL, kh_oid_map, oid_map, struct object_id, void *,
+		oidhash_by_value, oideq_by_value)
+
+KHASHL_MAP_INIT(KH_LOCAL, kh_oid_pos, oid_pos, struct object_id, int,
+		oidhash_by_value, oideq_by_value)
+
+#endif /* __AC_KHASHL_H */
diff --git a/object-store-ll.h b/object-store-ll.h
index 26a3895c82..401c4beff5 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -160,7 +160,7 @@ struct raw_object_store {
 	 */
 	struct object_directory *odb;
 	struct object_directory **odb_tail;
-	struct kh_odb_path_map *odb_by_path;
+	struct odb_path_map *odb_by_path;
 
 	int loaded_alternates;
 
diff --git a/object-store.h b/object-store.h
index 1b3e3d7d01..3db4802e86 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,11 +1,12 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
-#include "khash.h"
+#include "khashl.h"
 #include "dir.h"
 #include "object-store-ll.h"
 
-KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
-	struct object_directory *, 1, fspathhash, fspatheq)
+KHASHL_MAP_INIT(KH_LOCAL, odb_path_map, odb_path_map,
+	const char * /* key: odb_path */, struct object_directory *,
+	fspathhash, fspatheq)
 
 #endif /* OBJECT_STORE_H */
diff --git a/oidset.h b/oidset.h
index 262f4256d6..17af1b6708 100644
--- a/oidset.h
+++ b/oidset.h
@@ -1,7 +1,7 @@
 #ifndef OIDSET_H
 #define OIDSET_H
 
-#include "khash.h"
+#include "khashl.h"
 
 /**
  * This API is similar to oid-array, in that it maintains a set of object ids
diff --git a/pack-bitmap.h b/pack-bitmap.h
index c7dea13217..d018365f24 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -2,7 +2,7 @@
 #define PACK_BITMAP_H
 
 #include "ewah/ewok.h"
-#include "khash.h"
+#include "khashl.h"
 #include "pack.h"
 #include "pack-objects.h"
 #include "string-list.h"
