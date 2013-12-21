From: Jeff King <peff@peff.net>
Subject: [PATCH v4 10/23] pack-bitmap: add support for bitmap indexes
Date: Sat, 21 Dec 2013 09:00:01 -0500
Message-ID: <20131221140001.GJ21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:00:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN6E-0005F9-SH
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab3LUOAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:00:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:48484 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755169Ab3LUOAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:00:03 -0500
Received: (qmail 7392 invoked by uid 102); 21 Dec 2013 14:00:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:00:02 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:00:01 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239602>

From: Vicent Marti <tanoku@gmail.com>

A bitmap index is a `.bitmap` file that can be found inside
`$GIT_DIR/objects/pack/`, next to its corresponding packfile, and
contains precalculated reachability information for selected commits.
The full specification of the format for these bitmap indexes can be found
in `Documentation/technical/bitmap-format.txt`.

For a given commit SHA1, if it happens to be available in the bitmap
index, its bitmap will represent every single object that is reachable
from the commit itself. The nth bit in the bitmap is the nth object in
the packfile; if it's set to 1, the object is reachable.

By using the bitmaps available in the index, this commit implements
several new functions:

	- `prepare_bitmap_git`
	- `prepare_bitmap_walk`
	- `traverse_bitmap_commit_list`
	- `reuse_partial_packfile_from_bitmap`

The `prepare_bitmap_walk` function tries to build a bitmap of all the
objects that can be reached from the commit roots of a given `rev_info`
struct by using the following algorithm:

- If all the interesting commits for a revision walk are available in
the index, the resulting reachability bitmap is the bitwise OR of all
the individual bitmaps.

- When the full set of WANTs is not available in the index, we perform a
partial revision walk using the commits that don't have bitmaps as
roots, and limiting the revision walk as soon as we reach a commit that
has a corresponding bitmap. The earlier OR'ed bitmap with all the
indexed commits can now be completed as this walk progresses, so the end
result is the full reachability list.

- For revision walks with a HAVEs set (a set of commits that are deemed
uninteresting), first we perform the same method as for the WANTs, but
using our HAVEs as roots, in order to obtain a full reachability bitmap
of all the uninteresting commits. This bitmap then can be used to:

	a) limit the subsequent walk when building the WANTs bitmap
	b) finding the final set of interesting commits by performing an
	   AND-NOT of the WANTs and the HAVEs.

If `prepare_bitmap_walk` runs successfully, the resulting bitmap is
stored and the equivalent of a `traverse_commit_list` call can be
performed by using `traverse_bitmap_commit_list`; the bitmap version
of this call yields the objects straight from the packfile index
(without having to look them up or parse them) and hence is several
orders of magnitude faster.

As an extra optimization, when `prepare_bitmap_walk` succeeds, the
`reuse_partial_packfile_from_bitmap` call can be attempted: it will find
the amount of objects at the beginning of the on-disk packfile that can
be reused as-is, and return an offset into the packfile. The source
packfile can then be loaded and the bytes up to `offset` can be written
directly to the result without having to consider the entires inside the
packfile individually.

If the `prepare_bitmap_walk` call fails (e.g. because no bitmap files
are available), the `rev_info` struct is left untouched, and can be used
to perform a manual rev-walk using `traverse_commit_list`.

Hence, this new set of functions are a generic API that allows to
perform the equivalent of

	git rev-list --objects [roots...] [^uninteresting...]

for any set of commits, even if they don't have specific bitmaps
generated for them.

In further patches, we'll use this bitmap traversal optimization to
speed up the `pack-objects` and `rev-list` commands.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile      |   2 +
 khash.h       | 338 ++++++++++++++++++++
 pack-bitmap.c | 970 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pack-bitmap.h |  43 +++
 4 files changed, 1353 insertions(+)
 create mode 100644 khash.h
 create mode 100644 pack-bitmap.c
 create mode 100644 pack-bitmap.h

diff --git a/Makefile b/Makefile
index 64a1ed7..b983d78 100644
--- a/Makefile
+++ b/Makefile
@@ -699,6 +699,7 @@ LIB_H += object.h
 LIB_H += pack-objects.h
 LIB_H += pack-revindex.h
 LIB_H += pack.h
+LIB_H += pack-bitmap.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
 LIB_H += pathspec.h
@@ -837,6 +838,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-objects.o
 LIB_OBJS += pack-revindex.o
diff --git a/khash.h b/khash.h
new file mode 100644
index 0000000..57ff603
--- /dev/null
+++ b/khash.h
@@ -0,0 +1,338 @@
+/* The MIT License
+
+   Copyright (c) 2008, 2009, 2011 by Attractive Chaos <attractor@live.co.uk>
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
+#ifndef __AC_KHASH_H
+#define __AC_KHASH_H
+
+#define AC_VERSION_KHASH_H "0.2.8"
+
+typedef uint32_t khint32_t;
+typedef uint64_t khint64_t;
+
+typedef khint32_t khint_t;
+typedef khint_t khiter_t;
+
+#define __ac_isempty(flag, i) ((flag[i>>4]>>((i&0xfU)<<1))&2)
+#define __ac_isdel(flag, i) ((flag[i>>4]>>((i&0xfU)<<1))&1)
+#define __ac_iseither(flag, i) ((flag[i>>4]>>((i&0xfU)<<1))&3)
+#define __ac_set_isdel_false(flag, i) (flag[i>>4]&=~(1ul<<((i&0xfU)<<1)))
+#define __ac_set_isempty_false(flag, i) (flag[i>>4]&=~(2ul<<((i&0xfU)<<1)))
+#define __ac_set_isboth_false(flag, i) (flag[i>>4]&=~(3ul<<((i&0xfU)<<1)))
+#define __ac_set_isdel_true(flag, i) (flag[i>>4]|=1ul<<((i&0xfU)<<1))
+
+#define __ac_fsize(m) ((m) < 16? 1 : (m)>>4)
+
+#define kroundup32(x) (--(x), (x)|=(x)>>1, (x)|=(x)>>2, (x)|=(x)>>4, (x)|=(x)>>8, (x)|=(x)>>16, ++(x))
+
+static inline khint_t __ac_X31_hash_string(const char *s)
+{
+	khint_t h = (khint_t)*s;
+	if (h) for (++s ; *s; ++s) h = (h << 5) - h + (khint_t)*s;
+	return h;
+}
+
+#define kh_str_hash_func(key) __ac_X31_hash_string(key)
+#define kh_str_hash_equal(a, b) (strcmp(a, b) == 0)
+
+static const double __ac_HASH_UPPER = 0.77;
+
+#define __KHASH_TYPE(name, khkey_t, khval_t) \
+	typedef struct { \
+		khint_t n_buckets, size, n_occupied, upper_bound; \
+		khint32_t *flags; \
+		khkey_t *keys; \
+		khval_t *vals; \
+	} kh_##name##_t;
+
+#define __KHASH_PROTOTYPES(name, khkey_t, khval_t)	 					\
+	extern kh_##name##_t *kh_init_##name(void);							\
+	extern void kh_destroy_##name(kh_##name##_t *h);					\
+	extern void kh_clear_##name(kh_##name##_t *h);						\
+	extern khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); 	\
+	extern int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
+	extern khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret); \
+	extern void kh_del_##name(kh_##name##_t *h, khint_t x);
+
+#define __KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
+	SCOPE kh_##name##_t *kh_init_##name(void) {							\
+		return (kh_##name##_t*)xcalloc(1, sizeof(kh_##name##_t));		\
+	}																	\
+	SCOPE void kh_destroy_##name(kh_##name##_t *h)						\
+	{																	\
+		if (h) {														\
+			free((void *)h->keys); free(h->flags);					\
+			free((void *)h->vals);										\
+			free(h);													\
+		}																\
+	}																	\
+	SCOPE void kh_clear_##name(kh_##name##_t *h)						\
+	{																	\
+		if (h && h->flags) {											\
+			memset(h->flags, 0xaa, __ac_fsize(h->n_buckets) * sizeof(khint32_t)); \
+			h->size = h->n_occupied = 0;								\
+		}																\
+	}																	\
+	SCOPE khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key) 	\
+	{																	\
+		if (h->n_buckets) {												\
+			khint_t k, i, last, mask, step = 0; \
+			mask = h->n_buckets - 1;									\
+			k = __hash_func(key); i = k & mask;							\
+			last = i; \
+			while (!__ac_isempty(h->flags, i) && (__ac_isdel(h->flags, i) || !__hash_equal(h->keys[i], key))) { \
+				i = (i + (++step)) & mask; \
+				if (i == last) return h->n_buckets;						\
+			}															\
+			return __ac_iseither(h->flags, i)? h->n_buckets : i;		\
+		} else return 0;												\
+	}																	\
+	SCOPE int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets) \
+	{ /* This function uses 0.25*n_buckets bytes of working space instead of [sizeof(key_t+val_t)+.25]*n_buckets. */ \
+		khint32_t *new_flags = NULL;										\
+		khint_t j = 1;													\
+		{																\
+			kroundup32(new_n_buckets); 									\
+			if (new_n_buckets < 4) new_n_buckets = 4;					\
+			if (h->size >= (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5)) j = 0;	/* requested size is too small */ \
+			else { /* hash table size to be changed (shrink or expand); rehash */ \
+				new_flags = (khint32_t*)xmalloc(__ac_fsize(new_n_buckets) * sizeof(khint32_t));	\
+				if (!new_flags) return -1;								\
+				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint32_t)); \
+				if (h->n_buckets < new_n_buckets) {	/* expand */		\
+					khkey_t *new_keys = (khkey_t*)xrealloc((void *)h->keys, new_n_buckets * sizeof(khkey_t)); \
+					if (!new_keys) return -1;							\
+					h->keys = new_keys;									\
+					if (kh_is_map) {									\
+						khval_t *new_vals = (khval_t*)xrealloc((void *)h->vals, new_n_buckets * sizeof(khval_t)); \
+						if (!new_vals) return -1;						\
+						h->vals = new_vals;								\
+					}													\
+				} /* otherwise shrink */								\
+			}															\
+		}																\
+		if (j) { /* rehashing is needed */								\
+			for (j = 0; j != h->n_buckets; ++j) {						\
+				if (__ac_iseither(h->flags, j) == 0) {					\
+					khkey_t key = h->keys[j];							\
+					khval_t val;										\
+					khint_t new_mask;									\
+					new_mask = new_n_buckets - 1; 						\
+					if (kh_is_map) val = h->vals[j];					\
+					__ac_set_isdel_true(h->flags, j);					\
+					while (1) { /* kick-out process; sort of like in Cuckoo hashing */ \
+						khint_t k, i, step = 0; \
+						k = __hash_func(key);							\
+						i = k & new_mask;								\
+						while (!__ac_isempty(new_flags, i)) i = (i + (++step)) & new_mask; \
+						__ac_set_isempty_false(new_flags, i);			\
+						if (i < h->n_buckets && __ac_iseither(h->flags, i) == 0) { /* kick out the existing element */ \
+							{ khkey_t tmp = h->keys[i]; h->keys[i] = key; key = tmp; } \
+							if (kh_is_map) { khval_t tmp = h->vals[i]; h->vals[i] = val; val = tmp; } \
+							__ac_set_isdel_true(h->flags, i); /* mark it as deleted in the old hash table */ \
+						} else { /* write the element and jump out of the loop */ \
+							h->keys[i] = key;							\
+							if (kh_is_map) h->vals[i] = val;			\
+							break;										\
+						}												\
+					}													\
+				}														\
+			}															\
+			if (h->n_buckets > new_n_buckets) { /* shrink the hash table */ \
+				h->keys = (khkey_t*)xrealloc((void *)h->keys, new_n_buckets * sizeof(khkey_t)); \
+				if (kh_is_map) h->vals = (khval_t*)xrealloc((void *)h->vals, new_n_buckets * sizeof(khval_t)); \
+			}															\
+			free(h->flags); /* free the working space */				\
+			h->flags = new_flags;										\
+			h->n_buckets = new_n_buckets;								\
+			h->n_occupied = h->size;									\
+			h->upper_bound = (khint_t)(h->n_buckets * __ac_HASH_UPPER + 0.5); \
+		}																\
+		return 0;														\
+	}																	\
+	SCOPE khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret) \
+	{																	\
+		khint_t x;														\
+		if (h->n_occupied >= h->upper_bound) { /* update the hash table */ \
+			if (h->n_buckets > (h->size<<1)) {							\
+				if (kh_resize_##name(h, h->n_buckets - 1) < 0) { /* clear "deleted" elements */ \
+					*ret = -1; return h->n_buckets;						\
+				}														\
+			} else if (kh_resize_##name(h, h->n_buckets + 1) < 0) { /* expand the hash table */ \
+				*ret = -1; return h->n_buckets;							\
+			}															\
+		} /* TODO: to implement automatically shrinking; resize() already support shrinking */ \
+		{																\
+			khint_t k, i, site, last, mask = h->n_buckets - 1, step = 0; \
+			x = site = h->n_buckets; k = __hash_func(key); i = k & mask; \
+			if (__ac_isempty(h->flags, i)) x = i; /* for speed up */	\
+			else {														\
+				last = i; \
+				while (!__ac_isempty(h->flags, i) && (__ac_isdel(h->flags, i) || !__hash_equal(h->keys[i], key))) { \
+					if (__ac_isdel(h->flags, i)) site = i;				\
+					i = (i + (++step)) & mask; \
+					if (i == last) { x = site; break; }					\
+				}														\
+				if (x == h->n_buckets) {								\
+					if (__ac_isempty(h->flags, i) && site != h->n_buckets) x = site; \
+					else x = i;											\
+				}														\
+			}															\
+		}																\
+		if (__ac_isempty(h->flags, x)) { /* not present at all */		\
+			h->keys[x] = key;											\
+			__ac_set_isboth_false(h->flags, x);							\
+			++h->size; ++h->n_occupied;									\
+			*ret = 1;													\
+		} else if (__ac_isdel(h->flags, x)) { /* deleted */				\
+			h->keys[x] = key;											\
+			__ac_set_isboth_false(h->flags, x);							\
+			++h->size;													\
+			*ret = 2;													\
+		} else *ret = 0; /* Don't touch h->keys[x] if present and not deleted */ \
+		return x;														\
+	}																	\
+	SCOPE void kh_del_##name(kh_##name##_t *h, khint_t x)				\
+	{																	\
+		if (x != h->n_buckets && !__ac_iseither(h->flags, x)) {			\
+			__ac_set_isdel_true(h->flags, x);							\
+			--h->size;													\
+		}																\
+	}
+
+#define KHASH_DECLARE(name, khkey_t, khval_t)		 					\
+	__KHASH_TYPE(name, khkey_t, khval_t) 								\
+	__KHASH_PROTOTYPES(name, khkey_t, khval_t)
+
+#define KHASH_INIT2(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
+	__KHASH_TYPE(name, khkey_t, khval_t) 								\
+	__KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
+
+#define KHASH_INIT(name, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
+	KHASH_INIT2(name, static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
+
+/* Other convenient macros... */
+
+/*! @function
+  @abstract     Test whether a bucket contains data.
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @param  x     Iterator to the bucket [khint_t]
+  @return       1 if containing data; 0 otherwise [int]
+ */
+#define kh_exist(h, x) (!__ac_iseither((h)->flags, (x)))
+
+/*! @function
+  @abstract     Get key given an iterator
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @param  x     Iterator to the bucket [khint_t]
+  @return       Key [type of keys]
+ */
+#define kh_key(h, x) ((h)->keys[x])
+
+/*! @function
+  @abstract     Get value given an iterator
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @param  x     Iterator to the bucket [khint_t]
+  @return       Value [type of values]
+  @discussion   For hash sets, calling this results in segfault.
+ */
+#define kh_val(h, x) ((h)->vals[x])
+
+/*! @function
+  @abstract     Alias of kh_val()
+ */
+#define kh_value(h, x) ((h)->vals[x])
+
+/*! @function
+  @abstract     Get the start iterator
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @return       The start iterator [khint_t]
+ */
+#define kh_begin(h) (khint_t)(0)
+
+/*! @function
+  @abstract     Get the end iterator
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @return       The end iterator [khint_t]
+ */
+#define kh_end(h) ((h)->n_buckets)
+
+/*! @function
+  @abstract     Get the number of elements in the hash table
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @return       Number of elements in the hash table [khint_t]
+ */
+#define kh_size(h) ((h)->size)
+
+/*! @function
+  @abstract     Get the number of buckets in the hash table
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @return       Number of buckets in the hash table [khint_t]
+ */
+#define kh_n_buckets(h) ((h)->n_buckets)
+
+/*! @function
+  @abstract     Iterate over the entries in the hash table
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @param  kvar  Variable to which key will be assigned
+  @param  vvar  Variable to which value will be assigned
+  @param  code  Block of code to execute
+ */
+#define kh_foreach(h, kvar, vvar, code) { khint_t __i;		\
+	for (__i = kh_begin(h); __i != kh_end(h); ++__i) {		\
+		if (!kh_exist(h,__i)) continue;						\
+		(kvar) = kh_key(h,__i);								\
+		(vvar) = kh_val(h,__i);								\
+		code;												\
+	} }
+
+/*! @function
+  @abstract     Iterate over the values in the hash table
+  @param  h     Pointer to the hash table [khash_t(name)*]
+  @param  vvar  Variable to which value will be assigned
+  @param  code  Block of code to execute
+ */
+#define kh_foreach_value(h, vvar, code) { khint_t __i;		\
+	for (__i = kh_begin(h); __i != kh_end(h); ++__i) {		\
+		if (!kh_exist(h,__i)) continue;						\
+		(vvar) = kh_val(h,__i);								\
+		code;												\
+	} }
+
+static inline khint_t __kh_oid_hash(const unsigned char *oid)
+{
+	khint_t hash;
+	memcpy(&hash, oid, sizeof(hash));
+	return hash;
+}
+
+#define __kh_oid_cmp(a, b) (hashcmp(a, b) == 0)
+
+KHASH_INIT(sha1, const unsigned char *, void *, 1, __kh_oid_hash, __kh_oid_cmp)
+typedef kh_sha1_t khash_sha1;
+
+KHASH_INIT(sha1_pos, const unsigned char *, int, 1, __kh_oid_hash, __kh_oid_cmp)
+typedef kh_sha1_pos_t khash_sha1_pos;
+
+#endif /* __AC_KHASH_H */
diff --git a/pack-bitmap.c b/pack-bitmap.c
new file mode 100644
index 0000000..33e7482
--- /dev/null
+++ b/pack-bitmap.c
@@ -0,0 +1,970 @@
+#include "cache.h"
+#include "commit.h"
+#include "tag.h"
+#include "diff.h"
+#include "revision.h"
+#include "progress.h"
+#include "list-objects.h"
+#include "pack.h"
+#include "pack-bitmap.h"
+#include "pack-revindex.h"
+#include "pack-objects.h"
+
+/*
+ * An entry on the bitmap index, representing the bitmap for a given
+ * commit.
+ */
+struct stored_bitmap {
+	unsigned char sha1[20];
+	struct ewah_bitmap *root;
+	struct stored_bitmap *xor;
+	int flags;
+};
+
+/*
+ * The currently active bitmap index. By design, repositories only have
+ * a single bitmap index available (the index for the biggest packfile in
+ * the repository), since bitmap indexes need full closure.
+ *
+ * If there is more than one bitmap index available (e.g. because of alternates),
+ * the active bitmap index is the largest one.
+ */
+static struct bitmap_index {
+	/* Packfile to which this bitmap index belongs to */
+	struct packed_git *pack;
+
+	/* reverse index for the packfile */
+	struct pack_revindex *reverse_index;
+
+	/*
+	 * Mark the first `reuse_objects` in the packfile as reused:
+	 * they will be sent as-is without using them for repacking
+	 * calculations
+	 */
+	uint32_t reuse_objects;
+
+	/* mmapped buffer of the whole bitmap index */
+	unsigned char *map;
+	size_t map_size; /* size of the mmaped buffer */
+	size_t map_pos; /* current position when loading the index */
+
+	/*
+	 * Type indexes.
+	 *
+	 * Each bitmap marks which objects in the packfile  are of the given
+	 * type. This provides type information when yielding the objects from
+	 * the packfile during a walk, which allows for better delta bases.
+	 */
+	struct ewah_bitmap *commits;
+	struct ewah_bitmap *trees;
+	struct ewah_bitmap *blobs;
+	struct ewah_bitmap *tags;
+
+	/* Map from SHA1 -> `stored_bitmap` for all the bitmapped comits */
+	khash_sha1 *bitmaps;
+
+	/* Number of bitmapped commits */
+	uint32_t entry_count;
+
+	/*
+	 * Extended index.
+	 *
+	 * When trying to perform bitmap operations with objects that are not
+	 * packed in `pack`, these objects are added to this "fake index" and
+	 * are assumed to appear at the end of the packfile for all operations
+	 */
+	struct eindex {
+		struct object **objects;
+		uint32_t *hashes;
+		uint32_t count, alloc;
+		khash_sha1_pos *positions;
+	} ext_index;
+
+	/* Bitmap result of the last performed walk */
+	struct bitmap *result;
+
+	/* Version of the bitmap index */
+	unsigned int version;
+
+	unsigned loaded : 1;
+
+} bitmap_git;
+
+static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
+{
+	struct ewah_bitmap *parent;
+	struct ewah_bitmap *composed;
+
+	if (st->xor == NULL)
+		return st->root;
+
+	composed = ewah_pool_new();
+	parent = lookup_stored_bitmap(st->xor);
+	ewah_xor(st->root, parent, composed);
+
+	ewah_pool_free(st->root);
+	st->root = composed;
+	st->xor = NULL;
+
+	return composed;
+}
+
+/*
+ * Read a bitmap from the current read position on the mmaped
+ * index, and increase the read position accordingly
+ */
+static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
+{
+	struct ewah_bitmap *b = ewah_pool_new();
+
+	int bitmap_size = ewah_read_mmap(b,
+		index->map + index->map_pos,
+		index->map_size - index->map_pos);
+
+	if (bitmap_size < 0) {
+		error("Failed to load bitmap index (corrupted?)");
+		ewah_pool_free(b);
+		return NULL;
+	}
+
+	index->map_pos += bitmap_size;
+	return b;
+}
+
+static int load_bitmap_header(struct bitmap_index *index)
+{
+	struct bitmap_disk_header *header = (void *)index->map;
+
+	if (index->map_size < sizeof(*header) + 20)
+		return error("Corrupted bitmap index (missing header data)");
+
+	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
+		return error("Corrupted bitmap index file (wrong header)");
+
+	index->version = ntohs(header->version);
+	if (index->version != 1)
+		return error("Unsupported version for bitmap index file (%d)", index->version);
+
+	/* Parse known bitmap format options */
+	{
+		uint32_t flags = ntohs(header->options);
+
+		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
+			return error("Unsupported options for bitmap index file "
+				"(Git requires BITMAP_OPT_FULL_DAG)");
+	}
+
+	index->entry_count = ntohl(header->entry_count);
+	index->map_pos += sizeof(*header);
+	return 0;
+}
+
+static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
+					  struct ewah_bitmap *root,
+					  const unsigned char *sha1,
+					  struct stored_bitmap *xor_with,
+					  int flags)
+{
+	struct stored_bitmap *stored;
+	khiter_t hash_pos;
+	int ret;
+
+	stored = xmalloc(sizeof(struct stored_bitmap));
+	stored->root = root;
+	stored->xor = xor_with;
+	stored->flags = flags;
+	hashcpy(stored->sha1, sha1);
+
+	hash_pos = kh_put_sha1(index->bitmaps, stored->sha1, &ret);
+
+	/* a 0 return code means the insertion succeeded with no changes,
+	 * because the SHA1 already existed on the map. this is bad, there
+	 * shouldn't be duplicated commits in the index */
+	if (ret == 0) {
+		error("Duplicate entry in bitmap index: %s", sha1_to_hex(sha1));
+		return NULL;
+	}
+
+	kh_value(index->bitmaps, hash_pos) = stored;
+	return stored;
+}
+
+static int load_bitmap_entries_v1(struct bitmap_index *index)
+{
+	static const size_t MAX_XOR_OFFSET = 160;
+
+	uint32_t i;
+	struct stored_bitmap **recent_bitmaps;
+	struct bitmap_disk_entry *entry;
+
+	recent_bitmaps = xcalloc(MAX_XOR_OFFSET, sizeof(struct stored_bitmap));
+
+	for (i = 0; i < index->entry_count; ++i) {
+		int xor_offset, flags;
+		struct ewah_bitmap *bitmap = NULL;
+		struct stored_bitmap *xor_bitmap = NULL;
+		uint32_t commit_idx_pos;
+		const unsigned char *sha1;
+
+		entry = (struct bitmap_disk_entry *)(index->map + index->map_pos);
+		index->map_pos += sizeof(struct bitmap_disk_entry);
+
+		commit_idx_pos = ntohl(entry->object_pos);
+		sha1 = nth_packed_object_sha1(index->pack, commit_idx_pos);
+
+		xor_offset = (int)entry->xor_offset;
+		flags = (int)entry->flags;
+
+		bitmap = read_bitmap_1(index);
+		if (!bitmap)
+			return -1;
+
+		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
+			return error("Corrupted bitmap pack index");
+
+		if (xor_offset > 0) {
+			xor_bitmap = recent_bitmaps[(i - xor_offset) % MAX_XOR_OFFSET];
+
+			if (xor_bitmap == NULL)
+				return error("Invalid XOR offset in bitmap pack index");
+		}
+
+		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
+			index, bitmap, sha1, xor_bitmap, flags);
+	}
+
+	return 0;
+}
+
+static int open_pack_bitmap_1(struct packed_git *packfile)
+{
+	int fd;
+	struct stat st;
+	char *idx_name;
+
+	if (open_pack_index(packfile))
+		return -1;
+
+	idx_name = pack_bitmap_filename(packfile);
+	fd = git_open_noatime(idx_name);
+	free(idx_name);
+
+	if (fd < 0)
+		return -1;
+
+	if (fstat(fd, &st)) {
+		close(fd);
+		return -1;
+	}
+
+	if (bitmap_git.pack) {
+		warning("ignoring extra bitmap file: %s", packfile->pack_name);
+		close(fd);
+		return -1;
+	}
+
+	bitmap_git.pack = packfile;
+	bitmap_git.map_size = xsize_t(st.st_size);
+	bitmap_git.map = xmmap(NULL, bitmap_git.map_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	bitmap_git.map_pos = 0;
+	close(fd);
+
+	if (load_bitmap_header(&bitmap_git) < 0) {
+		munmap(bitmap_git.map, bitmap_git.map_size);
+		bitmap_git.map = NULL;
+		bitmap_git.map_size = 0;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int load_pack_bitmap(void)
+{
+	assert(bitmap_git.map && !bitmap_git.loaded);
+
+	bitmap_git.bitmaps = kh_init_sha1();
+	bitmap_git.ext_index.positions = kh_init_sha1_pos();
+	bitmap_git.reverse_index = revindex_for_pack(bitmap_git.pack);
+
+	if (!(bitmap_git.commits = read_bitmap_1(&bitmap_git)) ||
+		!(bitmap_git.trees = read_bitmap_1(&bitmap_git)) ||
+		!(bitmap_git.blobs = read_bitmap_1(&bitmap_git)) ||
+		!(bitmap_git.tags = read_bitmap_1(&bitmap_git)))
+		goto failed;
+
+	if (load_bitmap_entries_v1(&bitmap_git) < 0)
+		goto failed;
+
+	bitmap_git.loaded = 1;
+	return 0;
+
+failed:
+	munmap(bitmap_git.map, bitmap_git.map_size);
+	bitmap_git.map = NULL;
+	bitmap_git.map_size = 0;
+	return -1;
+}
+
+char *pack_bitmap_filename(struct packed_git *p)
+{
+	char *idx_name;
+	int len;
+
+	len = strlen(p->pack_name) - strlen(".pack");
+	idx_name = xmalloc(len + strlen(".bitmap") + 1);
+
+	memcpy(idx_name, p->pack_name, len);
+	memcpy(idx_name + len, ".bitmap", strlen(".bitmap") + 1);
+
+	return idx_name;
+}
+
+static int open_pack_bitmap(void)
+{
+	struct packed_git *p;
+	int ret = -1;
+
+	assert(!bitmap_git.map && !bitmap_git.loaded);
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		if (open_pack_bitmap_1(p) == 0)
+			ret = 0;
+	}
+
+	return ret;
+}
+
+int prepare_bitmap_git(void)
+{
+	if (bitmap_git.loaded)
+		return 0;
+
+	if (!open_pack_bitmap())
+		return load_pack_bitmap();
+
+	return -1;
+}
+
+struct include_data {
+	struct bitmap *base;
+	struct bitmap *seen;
+};
+
+static inline int bitmap_position_extended(const unsigned char *sha1)
+{
+	khash_sha1_pos *positions = bitmap_git.ext_index.positions;
+	khiter_t pos = kh_get_sha1_pos(positions, sha1);
+
+	if (pos < kh_end(positions)) {
+		int bitmap_pos = kh_value(positions, pos);
+		return bitmap_pos + bitmap_git.pack->num_objects;
+	}
+
+	return -1;
+}
+
+static inline int bitmap_position_packfile(const unsigned char *sha1)
+{
+	off_t offset = find_pack_entry_one(sha1, bitmap_git.pack);
+	if (!offset)
+		return -1;
+
+	return find_revindex_position(bitmap_git.reverse_index, offset);
+}
+
+static int bitmap_position(const unsigned char *sha1)
+{
+	int pos = bitmap_position_packfile(sha1);
+	return (pos >= 0) ? pos : bitmap_position_extended(sha1);
+}
+
+static int ext_index_add_object(struct object *object, const char *name)
+{
+	struct eindex *eindex = &bitmap_git.ext_index;
+
+	khiter_t hash_pos;
+	int hash_ret;
+	int bitmap_pos;
+
+	hash_pos = kh_put_sha1_pos(eindex->positions, object->sha1, &hash_ret);
+	if (hash_ret > 0) {
+		if (eindex->count >= eindex->alloc) {
+			eindex->alloc = (eindex->alloc + 16) * 3 / 2;
+			eindex->objects = xrealloc(eindex->objects,
+				eindex->alloc * sizeof(struct object *));
+			eindex->hashes = xrealloc(eindex->hashes,
+				eindex->alloc * sizeof(uint32_t));
+		}
+
+		bitmap_pos = eindex->count;
+		eindex->objects[eindex->count] = object;
+		eindex->hashes[eindex->count] = pack_name_hash(name);
+		kh_value(eindex->positions, hash_pos) = bitmap_pos;
+		eindex->count++;
+	} else {
+		bitmap_pos = kh_value(eindex->positions, hash_pos);
+	}
+
+	return bitmap_pos + bitmap_git.pack->num_objects;
+}
+
+static void show_object(struct object *object, const struct name_path *path,
+			const char *last, void *data)
+{
+	struct bitmap *base = data;
+	int bitmap_pos;
+
+	bitmap_pos = bitmap_position(object->sha1);
+
+	if (bitmap_pos < 0) {
+		char *name = path_name(path, last);
+		bitmap_pos = ext_index_add_object(object, name);
+		free(name);
+	}
+
+	bitmap_set(base, bitmap_pos);
+}
+
+static void show_commit(struct commit *commit, void *data)
+{
+}
+
+static int add_to_include_set(struct include_data *data,
+			      const unsigned char *sha1,
+			      int bitmap_pos)
+{
+	khiter_t hash_pos;
+
+	if (data->seen && bitmap_get(data->seen, bitmap_pos))
+		return 0;
+
+	if (bitmap_get(data->base, bitmap_pos))
+		return 0;
+
+	hash_pos = kh_get_sha1(bitmap_git.bitmaps, sha1);
+	if (hash_pos < kh_end(bitmap_git.bitmaps)) {
+		struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, hash_pos);
+		bitmap_or_ewah(data->base, lookup_stored_bitmap(st));
+		return 0;
+	}
+
+	bitmap_set(data->base, bitmap_pos);
+	return 1;
+}
+
+static int should_include(struct commit *commit, void *_data)
+{
+	struct include_data *data = _data;
+	int bitmap_pos;
+
+	bitmap_pos = bitmap_position(commit->object.sha1);
+	if (bitmap_pos < 0)
+		bitmap_pos = ext_index_add_object((struct object *)commit, NULL);
+
+	if (!add_to_include_set(data, commit->object.sha1, bitmap_pos)) {
+		struct commit_list *parent = commit->parents;
+
+		while (parent) {
+			parent->item->object.flags |= SEEN;
+			parent = parent->next;
+		}
+
+		return 0;
+	}
+
+	return 1;
+}
+
+static struct bitmap *find_objects(struct rev_info *revs,
+				   struct object_list *roots,
+				   struct bitmap *seen)
+{
+	struct bitmap *base = NULL;
+	int needs_walk = 0;
+
+	struct object_list *not_mapped = NULL;
+
+	/*
+	 * Go through all the roots for the walk. The ones that have bitmaps
+	 * on the bitmap index will be `or`ed together to form an initial
+	 * global reachability analysis.
+	 *
+	 * The ones without bitmaps in the index will be stored in the
+	 * `not_mapped_list` for further processing.
+	 */
+	while (roots) {
+		struct object *object = roots->item;
+		roots = roots->next;
+
+		if (object->type == OBJ_COMMIT) {
+			khiter_t pos = kh_get_sha1(bitmap_git.bitmaps, object->sha1);
+
+			if (pos < kh_end(bitmap_git.bitmaps)) {
+				struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, pos);
+				struct ewah_bitmap *or_with = lookup_stored_bitmap(st);
+
+				if (base == NULL)
+					base = ewah_to_bitmap(or_with);
+				else
+					bitmap_or_ewah(base, or_with);
+
+				object->flags |= SEEN;
+				continue;
+			}
+		}
+
+		object_list_insert(object, &not_mapped);
+	}
+
+	/*
+	 * Best case scenario: We found bitmaps for all the roots,
+	 * so the resulting `or` bitmap has the full reachability analysis
+	 */
+	if (not_mapped == NULL)
+		return base;
+
+	roots = not_mapped;
+
+	/*
+	 * Let's iterate through all the roots that don't have bitmaps to
+	 * check if we can determine them to be reachable from the existing
+	 * global bitmap.
+	 *
+	 * If we cannot find them in the existing global bitmap, we'll need
+	 * to push them to an actual walk and run it until we can confirm
+	 * they are reachable
+	 */
+	while (roots) {
+		struct object *object = roots->item;
+		int pos;
+
+		roots = roots->next;
+		pos = bitmap_position(object->sha1);
+
+		if (pos < 0 || base == NULL || !bitmap_get(base, pos)) {
+			object->flags &= ~UNINTERESTING;
+			add_pending_object(revs, object, "");
+			needs_walk = 1;
+		} else {
+			object->flags |= SEEN;
+		}
+	}
+
+	if (needs_walk) {
+		struct include_data incdata;
+
+		if (base == NULL)
+			base = bitmap_new();
+
+		incdata.base = base;
+		incdata.seen = seen;
+
+		revs->include_check = should_include;
+		revs->include_check_data = &incdata;
+
+		if (prepare_revision_walk(revs))
+			die("revision walk setup failed");
+
+		traverse_commit_list(revs, show_commit, show_object, base);
+	}
+
+	return base;
+}
+
+static void show_extended_objects(struct bitmap *objects,
+				  show_reachable_fn show_reach)
+{
+	struct eindex *eindex = &bitmap_git.ext_index;
+	uint32_t i;
+
+	for (i = 0; i < eindex->count; ++i) {
+		struct object *obj;
+
+		if (!bitmap_get(objects, bitmap_git.pack->num_objects + i))
+			continue;
+
+		obj = eindex->objects[i];
+		show_reach(obj->sha1, obj->type, 0, eindex->hashes[i], NULL, 0);
+	}
+}
+
+static void show_objects_for_type(
+	struct bitmap *objects,
+	struct ewah_bitmap *type_filter,
+	enum object_type object_type,
+	show_reachable_fn show_reach)
+{
+	size_t pos = 0, i = 0;
+	uint32_t offset;
+
+	struct ewah_iterator it;
+	eword_t filter;
+
+	if (bitmap_git.reuse_objects == bitmap_git.pack->num_objects)
+		return;
+
+	ewah_iterator_init(&it, type_filter);
+
+	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+		eword_t word = objects->words[i] & filter;
+
+		for (offset = 0; offset < BITS_IN_WORD; ++offset) {
+			const unsigned char *sha1;
+			struct revindex_entry *entry;
+			uint32_t hash = 0;
+
+			if ((word >> offset) == 0)
+				break;
+
+			offset += ewah_bit_ctz64(word >> offset);
+
+			if (pos + offset < bitmap_git.reuse_objects)
+				continue;
+
+			entry = &bitmap_git.reverse_index->revindex[pos + offset];
+			sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
+
+			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->offset);
+		}
+
+		pos += BITS_IN_WORD;
+		i++;
+	}
+}
+
+static int in_bitmapped_pack(struct object_list *roots)
+{
+	while (roots) {
+		struct object *object = roots->item;
+		roots = roots->next;
+
+		if (find_pack_entry_one(object->sha1, bitmap_git.pack) > 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+int prepare_bitmap_walk(struct rev_info *revs)
+{
+	unsigned int i;
+	unsigned int pending_nr = revs->pending.nr;
+	struct object_array_entry *pending_e = revs->pending.objects;
+
+	struct object_list *wants = NULL;
+	struct object_list *haves = NULL;
+
+	struct bitmap *wants_bitmap = NULL;
+	struct bitmap *haves_bitmap = NULL;
+
+	if (!bitmap_git.loaded) {
+		/* try to open a bitmapped pack, but don't parse it yet
+		 * because we may not need to use it */
+		if (open_pack_bitmap() < 0)
+			return -1;
+	}
+
+	for (i = 0; i < pending_nr; ++i) {
+		struct object *object = pending_e[i].item;
+
+		if (object->type == OBJ_NONE)
+			parse_object_or_die(object->sha1, NULL);
+
+		while (object->type == OBJ_TAG) {
+			struct tag *tag = (struct tag *) object;
+
+			if (object->flags & UNINTERESTING)
+				object_list_insert(object, &haves);
+			else
+				object_list_insert(object, &wants);
+
+			if (!tag->tagged)
+				die("bad tag");
+			object = parse_object_or_die(tag->tagged->sha1, NULL);
+		}
+
+		if (object->flags & UNINTERESTING)
+			object_list_insert(object, &haves);
+		else
+			object_list_insert(object, &wants);
+	}
+
+	/*
+	 * if we have a HAVES list, but none of those haves is contained
+	 * in the packfile that has a bitmap, we don't have anything to
+	 * optimize here
+	 */
+	if (haves && !in_bitmapped_pack(haves))
+		return -1;
+
+	/* if we don't want anything, we're done here */
+	if (!wants)
+		return -1;
+
+	/*
+	 * now we're going to use bitmaps, so load the actual bitmap entries
+	 * from disk. this is the point of no return; after this the rev_list
+	 * becomes invalidated and we must perform the revwalk through bitmaps
+	 */
+	if (!bitmap_git.loaded && load_pack_bitmap() < 0)
+		return -1;
+
+	revs->pending.nr = 0;
+	revs->pending.alloc = 0;
+	revs->pending.objects = NULL;
+
+	if (haves) {
+		haves_bitmap = find_objects(revs, haves, NULL);
+		reset_revision_walk();
+
+		if (haves_bitmap == NULL)
+			die("BUG: failed to perform bitmap walk");
+	}
+
+	wants_bitmap = find_objects(revs, wants, haves_bitmap);
+
+	if (!wants_bitmap)
+		die("BUG: failed to perform bitmap walk");
+
+	if (haves_bitmap)
+		bitmap_and_not(wants_bitmap, haves_bitmap);
+
+	bitmap_git.result = wants_bitmap;
+
+	bitmap_free(haves_bitmap);
+	return 0;
+}
+
+int reuse_partial_packfile_from_bitmap(struct packed_git **packfile,
+				       uint32_t *entries,
+				       off_t *up_to)
+{
+	/*
+	 * Reuse the packfile content if we need more than
+	 * 90% of its objects
+	 */
+	static const double REUSE_PERCENT = 0.9;
+
+	struct bitmap *result = bitmap_git.result;
+	uint32_t reuse_threshold;
+	uint32_t i, reuse_objects = 0;
+
+	assert(result);
+
+	for (i = 0; i < result->word_alloc; ++i) {
+		if (result->words[i] != (eword_t)~0) {
+			reuse_objects += ewah_bit_ctz64(~result->words[i]);
+			break;
+		}
+
+		reuse_objects += BITS_IN_WORD;
+	}
+
+#ifdef GIT_BITMAP_DEBUG
+	{
+		const unsigned char *sha1;
+		struct revindex_entry *entry;
+
+		entry = &bitmap_git.reverse_index->revindex[reuse_objects];
+		sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
+
+		fprintf(stderr, "Failed to reuse at %d (%016llx)\n",
+			reuse_objects, result->words[i]);
+		fprintf(stderr, " %s\n", sha1_to_hex(sha1));
+	}
+#endif
+
+	if (!reuse_objects)
+		return -1;
+
+	if (reuse_objects >= bitmap_git.pack->num_objects) {
+		bitmap_git.reuse_objects = *entries = bitmap_git.pack->num_objects;
+		*up_to = -1; /* reuse the full pack */
+		*packfile = bitmap_git.pack;
+		return 0;
+	}
+
+	reuse_threshold = bitmap_popcount(bitmap_git.result) * REUSE_PERCENT;
+
+	if (reuse_objects < reuse_threshold)
+		return -1;
+
+	bitmap_git.reuse_objects = *entries = reuse_objects;
+	*up_to = bitmap_git.reverse_index->revindex[reuse_objects].offset;
+	*packfile = bitmap_git.pack;
+
+	return 0;
+}
+
+void traverse_bitmap_commit_list(show_reachable_fn show_reachable)
+{
+	assert(bitmap_git.result);
+
+	show_objects_for_type(bitmap_git.result, bitmap_git.commits,
+		OBJ_COMMIT, show_reachable);
+	show_objects_for_type(bitmap_git.result, bitmap_git.trees,
+		OBJ_TREE, show_reachable);
+	show_objects_for_type(bitmap_git.result, bitmap_git.blobs,
+		OBJ_BLOB, show_reachable);
+	show_objects_for_type(bitmap_git.result, bitmap_git.tags,
+		OBJ_TAG, show_reachable);
+
+	show_extended_objects(bitmap_git.result, show_reachable);
+
+	bitmap_free(bitmap_git.result);
+	bitmap_git.result = NULL;
+}
+
+static uint32_t count_object_type(struct bitmap *objects,
+				  enum object_type type)
+{
+	struct eindex *eindex = &bitmap_git.ext_index;
+
+	uint32_t i = 0, count = 0;
+	struct ewah_iterator it;
+	eword_t filter;
+
+	switch (type) {
+	case OBJ_COMMIT:
+		ewah_iterator_init(&it, bitmap_git.commits);
+		break;
+
+	case OBJ_TREE:
+		ewah_iterator_init(&it, bitmap_git.trees);
+		break;
+
+	case OBJ_BLOB:
+		ewah_iterator_init(&it, bitmap_git.blobs);
+		break;
+
+	case OBJ_TAG:
+		ewah_iterator_init(&it, bitmap_git.tags);
+		break;
+
+	default:
+		return 0;
+	}
+
+	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+		eword_t word = objects->words[i++] & filter;
+		count += ewah_bit_popcount64(word);
+	}
+
+	for (i = 0; i < eindex->count; ++i) {
+		if (eindex->objects[i]->type == type &&
+			bitmap_get(objects, bitmap_git.pack->num_objects + i))
+			count++;
+	}
+
+	return count;
+}
+
+void count_bitmap_commit_list(uint32_t *commits, uint32_t *trees,
+			      uint32_t *blobs, uint32_t *tags)
+{
+	assert(bitmap_git.result);
+
+	if (commits)
+		*commits = count_object_type(bitmap_git.result, OBJ_COMMIT);
+
+	if (trees)
+		*trees = count_object_type(bitmap_git.result, OBJ_TREE);
+
+	if (blobs)
+		*blobs = count_object_type(bitmap_git.result, OBJ_BLOB);
+
+	if (tags)
+		*tags = count_object_type(bitmap_git.result, OBJ_TAG);
+}
+
+struct bitmap_test_data {
+	struct bitmap *base;
+	struct progress *prg;
+	size_t seen;
+};
+
+static void test_show_object(struct object *object,
+			     const struct name_path *path,
+			     const char *last, void *data)
+{
+	struct bitmap_test_data *tdata = data;
+	int bitmap_pos;
+
+	bitmap_pos = bitmap_position(object->sha1);
+	if (bitmap_pos < 0)
+		die("Object not in bitmap: %s\n", sha1_to_hex(object->sha1));
+
+	bitmap_set(tdata->base, bitmap_pos);
+	display_progress(tdata->prg, ++tdata->seen);
+}
+
+static void test_show_commit(struct commit *commit, void *data)
+{
+	struct bitmap_test_data *tdata = data;
+	int bitmap_pos;
+
+	bitmap_pos = bitmap_position(commit->object.sha1);
+	if (bitmap_pos < 0)
+		die("Object not in bitmap: %s\n", sha1_to_hex(commit->object.sha1));
+
+	bitmap_set(tdata->base, bitmap_pos);
+	display_progress(tdata->prg, ++tdata->seen);
+}
+
+void test_bitmap_walk(struct rev_info *revs)
+{
+	struct object *root;
+	struct bitmap *result = NULL;
+	khiter_t pos;
+	size_t result_popcnt;
+	struct bitmap_test_data tdata;
+
+	if (prepare_bitmap_git())
+		die("failed to load bitmap indexes");
+
+	if (revs->pending.nr != 1)
+		die("you must specify exactly one commit to test");
+
+	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
+		bitmap_git.version, bitmap_git.entry_count);
+
+	root = revs->pending.objects[0].item;
+	pos = kh_get_sha1(bitmap_git.bitmaps, root->sha1);
+
+	if (pos < kh_end(bitmap_git.bitmaps)) {
+		struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, pos);
+		struct ewah_bitmap *bm = lookup_stored_bitmap(st);
+
+		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
+			sha1_to_hex(root->sha1), (int)bm->bit_size, ewah_checksum(bm));
+
+		result = ewah_to_bitmap(bm);
+	}
+
+	if (result == NULL)
+		die("Commit %s doesn't have an indexed bitmap", sha1_to_hex(root->sha1));
+
+	revs->tag_objects = 1;
+	revs->tree_objects = 1;
+	revs->blob_objects = 1;
+
+	result_popcnt = bitmap_popcount(result);
+
+	if (prepare_revision_walk(revs))
+		die("revision walk setup failed");
+
+	tdata.base = bitmap_new();
+	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
+	tdata.seen = 0;
+
+	traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);
+
+	stop_progress(&tdata.prg);
+
+	if (bitmap_equals(result, tdata.base))
+		fprintf(stderr, "OK!\n");
+	else
+		fprintf(stderr, "Mismatch!\n");
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
new file mode 100644
index 0000000..b4510d5
--- /dev/null
+++ b/pack-bitmap.h
@@ -0,0 +1,43 @@
+#ifndef PACK_BITMAP_H
+#define PACK_BITMAP_H
+
+#include "ewah/ewok.h"
+#include "khash.h"
+
+struct bitmap_disk_entry {
+	uint32_t object_pos;
+	uint8_t xor_offset;
+	uint8_t flags;
+} __attribute__((packed));
+
+struct bitmap_disk_header {
+	char magic[4];
+	uint16_t version;
+	uint16_t options;
+	uint32_t entry_count;
+	unsigned char checksum[20];
+};
+
+static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
+
+enum pack_bitmap_opts {
+	BITMAP_OPT_FULL_DAG = 1
+};
+
+typedef int (*show_reachable_fn)(
+	const unsigned char *sha1,
+	enum object_type type,
+	int flags,
+	uint32_t hash,
+	struct packed_git *found_pack,
+	off_t found_offset);
+
+int prepare_bitmap_git(void);
+void count_bitmap_commit_list(uint32_t *commits, uint32_t *trees, uint32_t *blobs, uint32_t *tags);
+void traverse_bitmap_commit_list(show_reachable_fn show_reachable);
+void test_bitmap_walk(struct rev_info *revs);
+char *pack_bitmap_filename(struct packed_git *p);
+int prepare_bitmap_walk(struct rev_info *revs);
+int reuse_partial_packfile_from_bitmap(struct packed_git **packfile, uint32_t *entries, off_t *up_to);
+
+#endif
-- 
1.8.5.1.399.g900e7cd
