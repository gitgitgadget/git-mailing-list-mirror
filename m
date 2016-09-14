Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2481FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 23:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764011AbcINX4j (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 19:56:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:43463 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763828AbcINX4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 19:56:38 -0400
Received: (qmail 22799 invoked by uid 109); 14 Sep 2016 23:56:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 23:56:37 +0000
Received: (qmail 5272 invoked by uid 111); 14 Sep 2016 23:56:47 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 19:56:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 16:56:34 -0700
Date:   Wed, 14 Sep 2016 16:56:34 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] obj_hash: convert to a critbit tree
Message-ID: <20160914235633.gofr534hvslkclzm@sigill.intra.peff.net>
References: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For operations that traverse the whole reachability graph,
like "rev-list --objects", the obj_hash in object.c shows up
as a hotspot. We basically have to do "nr_commits *
size_of_tree" hash lookups, because each tree we look at, we
need to say "have we seen this sha1 yet?" (it's a little
more complicated because we avoid digging into sub-trees we
know we've already seen, but it's a reasonable
approximation).  So graph traversal operations like that are
very sensitive to improvements in lookup time.

For keys with length "m", a hash table is generally O(m) to
compute the hash (and verify that you've found the correct
key), and O(1) in finding the correct slot. The latter is
subject to collisions and probing strategy, but we keep the
load factor on the obj_hash table below 50%, which is quite
low. And we have a good hash (we reuse the sha1s themselves,
which are effectively random). So we'd expect relatively few
collisions, and past experiments to tweak the probing
strategy haven't yielded any benefit (we use linear probing;
I tried quadratic probing at one point, and Junio tried
cuckoo hashing).

Another data structure with similar properties is sometimes
known as a "critbit tree" (see http://cr.yp.to/critbit.html
for discussion and history). The basic idea is a binary trie
where each node is either an internal node, representing a
single bit of a stored key, or a leaf node, representing one
or more "remainder" bits. So if you were storing two bit
sequences 1011 and "1100", you'd have three nodes (besides
the root):

        (root)
        /    \
       0      1
      /        \
    NULL    (internal)
             /    \
            0      1
           /        \
        "11"       "00"

So finding "1011" involves traversing the trie: down the "1"
side, then the "0" side, and then check that the rest
matches "11".

Looking up a key is O(m), and there's no issue with
collisions or probing. It can use less memory than a hash
table, because there's no load factor to care about.

That's the good news. The bad news is that big-O analysis
is not the whole story. You'll notice that we have to do a
lot of conditional pointer-jumping to walk the trie. Whereas
a hash table can jump right to a proposed key and do a
memcmp() to see if we got it.

So I wasn't overly optimistic that this would be any faster.
And indeed it's not. It's about three times slower (about
4.5s versus 1.5s running "rev-list --objects --all" on
git.git).

The reason is, I think, a combination of:

  0. We care much more about performance for this hash than
     memory efficiency. So we keep the load factor
     quite low, and thus reduce the number of collisions.

  1. For many hash tables, computing the hash is expensive.
     Not so here, because we are storing sha1s. So it is
     literally just casting the first 4 bytes of the sha1 to
     an int; we don't even look at the other bytes until the
     collision check (and because of point 0, we don't
     generally have to do very many collision checks during
     our probe).

  2. The collision check _does_ have to look at all 20 bytes
     of the sha1. And we may have to do it multiple times as
     we linearly probe the collisions. _But_ it can be done
     with memcmp(), which is optimized to compare 32 or 64
     bits at a time. So we our O(m) has a very nice constant
     factor.

     Whereas in the critbit tree, we pay an instruction for
     _each_ bit we look at.

It's possible that (2) would be better if instead of a
critbit tree, we used a "critbyte" tree. That would involve
fewer node traversals, at the cost of making each node
larger (right now the internal nodes store 2 pointer slots;
they'd have to store 256 to handle a full byte). I didn't
try it, but I suspect it would still be slower for the same
reasons.

The code is below for reference. I pulled the critbit
implementation from:

  https://github.com/ennorehling/critbit

but made a few tweaks:

  - the critbit does not store the keys themselves, as we
    already have them in the "struct object", and do not
    want to waste space. As a result, I baked in some
    assumptions about the 20-byte key-length (which is fine
    for our purposes here).

  - rather than malloc() each node, I used a pool allocator
    (to try to keep the nodes closer together in cache)

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile  |   1 +
 critbit.c | 350 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 critbit.h |  60 +++++++++++
 object.c  |  85 ++-------------
 4 files changed, 417 insertions(+), 79 deletions(-)
 create mode 100644 critbit.c
 create mode 100644 critbit.h

diff --git a/Makefile b/Makefile
index 7f18492..99e0eb2 100644
--- a/Makefile
+++ b/Makefile
@@ -720,6 +720,7 @@ LIB_OBJS += connected.o
 LIB_OBJS += convert.o
 LIB_OBJS += copy.o
 LIB_OBJS += credential.o
+LIB_OBJS += critbit.o
 LIB_OBJS += csum-file.o
 LIB_OBJS += ctype.o
 LIB_OBJS += date.o
diff --git a/critbit.c b/critbit.c
new file mode 100644
index 0000000..7354375
--- /dev/null
+++ b/critbit.c
@@ -0,0 +1,350 @@
+/*
+Copyright (c) 2012, Enno Rehling <enno@eressea.de>
+
+Permission to use, copy, modify, and/or distribute this software for any
+purpose with or without fee is hereby granted, provided that the above
+copyright notice and this permission notice appear in all copies.
+
+THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+**/
+
+#include "cache.h"
+#include "critbit.h"
+
+/* see http://cr.yp.to/critbit.html */
+struct critbit_node {
+    void * child[2];
+    size_t byte;
+    unsigned int mask;
+};
+
+#define EXTERNAL_NODE 0
+#define INTERNAL_NODE 1
+
+static int decode_pointer(void ** ptr)
+{
+    ptrdiff_t numvalue = (char*)*ptr - (char*)0;
+    if (numvalue & 1) {
+        *ptr = (void*)(numvalue - 1);
+        return EXTERNAL_NODE;
+    }
+    return INTERNAL_NODE;
+}
+
+static void * make_external_node(const void * key, size_t keylen)
+{
+    return (unsigned char *)key + 1;
+}
+
+static void from_external_node(void * ptr, void **key, size_t *keylen)
+{
+    /* eek */
+    *keylen = 20;
+    *key = ptr;
+}
+
+static struct critbit_node *node_pool;
+static int node_pool_used;
+static int node_pool_alloc;
+
+static struct critbit_node * make_internal_node(void)
+{
+    if (node_pool_used == node_pool_alloc) {
+        node_pool_alloc = 1024;
+        node_pool_used = 0;
+        ALLOC_ARRAY(node_pool, node_pool_alloc);
+    }
+    return &node_pool[node_pool_used++];
+}
+
+static int cb_less(const struct critbit_node * a, const struct critbit_node * b)
+{
+    return a->byte < b->byte || (a->byte == b->byte && a->mask < b->mask);
+}
+
+int cb_insert(critbit_tree * cb, const void * key, size_t keylen)
+{
+    assert(cb);
+    assert(key);
+    if (!cb->root) {
+        cb->root = make_external_node(key, keylen);
+        return CB_SUCCESS;
+    }
+    else {
+        void ** iter = &cb->root;
+        struct critbit_node * prev = 0;
+        for (;;) {
+            void * ptr = *iter;
+            if (decode_pointer(&ptr) == INTERNAL_NODE) {
+                struct critbit_node * node = (struct critbit_node *)ptr;
+                unsigned char * bytes = (unsigned char *)key;
+                int branch = (keylen <= node->byte) ? 0 : ((1 + ((bytes[node->byte] | node->mask) & 0xFF)) >> 8);
+                iter = &node->child[branch];
+                prev = node;
+            }
+            else {
+                unsigned char *iptr, *bytes = (unsigned char *)key, *ikey = bytes;
+                void * vptr;
+                unsigned int mask, byte = 0;
+                int branch;
+                size_t len;
+                struct critbit_node * node;
+
+                from_external_node(ptr, &vptr, &len);
+
+                for (iptr = vptr; byte < keylen && byte < len && *ikey == *iptr;) {
+                    ++ikey;
+                    ++iptr;
+                    ++byte;
+                }
+
+                if (byte == keylen && byte == len) {
+                    return CB_EXISTS; /* duplicate entry */
+                }
+                node = make_internal_node();
+                node->byte = byte;
+                mask = *ikey ^ *iptr; /* these are all the bits that differ */
+                mask |= mask >> 1;
+                mask |= mask >> 2;
+                mask |= mask >> 4; /* now, every bit up to the MSB is set to 1 */
+                mask = (mask&~(mask >> 1)) ^ 0xFF;
+                node->mask = (unsigned char)mask;
+
+                /* find the right place to insert, iff prev's crit-bit is later in the string than new crit-bit */
+                if (prev && cb_less(node, prev)) {
+                    for (iter = &cb->root;;) {
+                        ptr = *iter;
+                        if (decode_pointer(&ptr) == INTERNAL_NODE) {
+                            struct critbit_node * next = (struct critbit_node *)ptr;
+                            if (cb_less(next, node)) {
+                                branch = ((1 + ((bytes[next->byte] | next->mask) & 0xFF)) >> 8);
+                                iter = &next->child[branch];
+                            }
+                            else {
+                                break;
+                            }
+                        }
+                        else {
+                            assert(!"should never get here");
+                        }
+                    }
+                }
+
+                branch = ((1 + ((*ikey | node->mask) & 0xFF)) >> 8);
+                node->child[branch] = make_external_node(key, keylen);
+                node->child[1 - branch] = *iter;
+                *iter = (void *)node;
+
+                return CB_SUCCESS;
+            }
+        }
+    }
+}
+
+static void * cb_find_top_i(const critbit_tree * cb, const void * key, size_t keylen)
+{
+    void *ptr, *top = 0;
+    assert(key);
+
+    if (!cb->root) {
+        return 0;
+    }
+    for (ptr = cb->root, top = cb->root;;) {
+        void * last = ptr;
+        if (decode_pointer(&ptr) == INTERNAL_NODE) {
+            struct critbit_node * node = (struct critbit_node *)ptr;
+            int branch;
+            if (keylen <= node->byte) {
+                break;
+            }
+            else {
+                unsigned char * bytes = (unsigned char *)key;
+                top = last;
+                branch = (1 + ((bytes[node->byte] | node->mask) & 0xFF)) >> 8;
+                ptr = node->child[branch];
+            }
+        }
+        else {
+            /* we reached an external node before exhausting the key length */
+            top = last;
+            break;
+        }
+    }
+    return top;
+}
+
+static int cb_find_prefix_i(void * ptr, const void * key, size_t keylen, void ** results, int numresults, int * offset, int next)
+{
+    assert(next <= numresults);
+    if (next == numresults) {
+        return next;
+    }
+    else if (decode_pointer(&ptr) == INTERNAL_NODE) {
+        struct critbit_node * node = (struct critbit_node *)ptr;
+        next = cb_find_prefix_i(node->child[0], key, keylen, results, numresults, offset, next);
+        if (next < numresults) {
+            next = cb_find_prefix_i(node->child[1], key, keylen, results, numresults, offset, next);
+        }
+    }
+    else {
+        /* reached an external node */
+        char * str;
+        void * vptr;
+        size_t len;
+
+        from_external_node(ptr, &vptr, &len);
+        str = vptr;
+        if (len >= keylen && memcmp(key, str, keylen) == 0) {
+            if (*offset>0) {
+                --*offset;
+            }
+            else {
+                results[next++] = str;
+            }
+        }
+    }
+    return next;
+}
+
+int cb_find_prefix(const critbit_tree * cb, const void * key, size_t keylen, void ** results, int numresults, int offset)
+{
+    if (numresults > 0) {
+        void *top = cb_find_top_i(cb, key, keylen);
+        if (top) {
+            /* recursively add all children except the ones from [0-offset) of top to the results */
+            return cb_find_prefix_i(top, key, keylen, results, numresults, &offset, 0);
+        }
+    }
+    return 0;
+}
+
+static int cb_foreach_i(void * ptr, const void * key, size_t keylen, int(*match_cb)(const void * match, const void * key, size_t keylen, void *), void *data)
+{
+    int result = 0;
+
+    if (decode_pointer(&ptr) == INTERNAL_NODE) {
+        struct critbit_node * node = (struct critbit_node *)ptr;
+        result = cb_foreach_i(node->child[0], key, keylen, match_cb, data);
+        if (!result) {
+            result = cb_foreach_i(node->child[1], key, keylen, match_cb, data);
+        }
+    }
+    else {
+        /* reached an external node */
+        void * match;
+        size_t len;
+
+        from_external_node(ptr, &match, &len);
+        if (len >= keylen && memcmp(key, match, keylen) == 0) {
+            return match_cb(match, key, keylen, data);
+        }
+    }
+    return result;
+}
+
+int cb_foreach(critbit_tree * cb, const void * key, size_t keylen, int(*match_cb)(const void * match, const void * key, size_t keylen, void *), void *data)
+{
+    void *top = cb_find_top_i(cb, key, keylen);
+    if (top) {
+        /* recursively add all children except the ones from [0-offset) of top to the results */
+        return cb_foreach_i(top, key, keylen, match_cb, data);
+    }
+    return 0;
+}
+
+const void * cb_find(critbit_tree * cb, const void * key, size_t keylen)
+{
+    void * str;
+    size_t len;
+    unsigned char * bytes = (unsigned char *)key;
+    void * ptr;
+
+    assert(cb);
+    assert(key);
+    if (!cb->root) return 0;
+    for (ptr = cb->root; decode_pointer(&ptr) == INTERNAL_NODE; ) {
+        struct critbit_node *node = (struct critbit_node *)ptr;
+        uint8_t c = 0;
+        int direction;
+        if (node->byte < keylen)
+            c = bytes[node->byte];
+        direction = (1+(c|node->mask))>>8;
+        ptr = node->child[direction];
+    }
+    from_external_node(ptr, &str, &len);
+    if (len >= keylen && memcmp(key, str, keylen) == 0) {
+        return str;
+    }
+    return 0;
+}
+
+int cb_erase(critbit_tree * cb, const void * key, size_t keylen)
+{
+    void **iter = NULL;
+    void *ptr = cb->root;
+    struct critbit_node *parent = 0;
+    unsigned char * bytes = (unsigned char *)key;
+    int branch;
+
+    if (!cb->root) return CB_NOTFOUND;
+
+    for (;;) {
+        int type;
+
+        type = decode_pointer(&ptr);
+        if (type == INTERNAL_NODE) {
+            iter = parent ? &parent->child[branch] : &cb->root;
+            parent = (struct critbit_node*)ptr;
+            branch = (keylen <= parent->byte) ? 0 : ((1 + ((bytes[parent->byte] | parent->mask) & 0xFF)) >> 8);
+            ptr = parent->child[branch];
+        }
+        else {
+            void * str;
+            size_t len;
+            from_external_node(ptr, &str, &len);
+            if (len == keylen && memcmp(key, str, len) == 0) {
+                free(ptr);
+                if (iter) {
+                    *iter = parent->child[1 - branch];
+                    free(parent);
+                }
+                else {
+                    cb->root = 0;
+                }
+                return CB_SUCCESS;
+            }
+            return CB_NOTFOUND;
+        }
+    }
+}
+
+size_t cb_new_kv(const char *key, size_t keylen, const void * value, size_t len, void * out)
+{
+    char * dst = (char*)out;
+    if (dst != key) {
+        memmove(dst, key, keylen);
+    }
+    dst[keylen] = 0;
+    memmove(dst + keylen + 1, value, len);
+    return len + keylen + 1;
+}
+
+void cb_get_kv(const void *kv, void * value, size_t len)
+{
+    const char * key = (const char *)kv;
+    size_t keylen = strlen(key) + 1;
+    memmove(value, key + keylen, len);
+}
+
+void cb_get_kv_ex(void *kv, void ** value)
+{
+    char * key = (char *)kv;
+    size_t keylen = strlen(key) + 1;
+    *value = key + keylen;
+}
diff --git a/critbit.h b/critbit.h
new file mode 100644
index 0000000..ee774e8
--- /dev/null
+++ b/critbit.h
@@ -0,0 +1,60 @@
+/*
+Copyright (c) 2012, Enno Rehling <enno@eressea.de>
+
+Permission to use, copy, modify, and/or distribute this software for any
+purpose with or without fee is hereby granted, provided that the above
+copyright notice and this permission notice appear in all copies.
+
+THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+**/
+
+#ifndef _CRITBITT_H
+#define _CRITBITT_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <stddef.h>
+
+typedef struct critbit_tree {
+  void * root;
+} critbit_tree;
+
+#define CB_SUCCESS 0
+#define CB_EXISTS 1
+#define CB_NOTFOUND 2
+
+#define CRITBIT_TREE() { 0 }
+
+int cb_insert(critbit_tree * cb, const void * key, size_t keylen);
+const void * cb_find(critbit_tree * cb, const void * key, size_t keylen);
+int cb_erase(critbit_tree * cb, const void * key, size_t keylen);
+int cb_find_prefix(const critbit_tree * cb, const void * key, size_t keylen, void ** results, int numresults, int offset);
+int cb_foreach(critbit_tree * cb, const void * key, size_t keylen, int (*match_cb)(const void * match, const void * key, size_t keylen, void *), void *data);
+void cb_clear(critbit_tree * cb);
+
+#define cb_insert_str(cb, key) \
+  cb_insert(cb, (void *)key, strlen(key)+1)
+#define cb_find_str(cb, key) \
+  (const char *)cb_find(cb, (void *)key, strlen(key)+1)
+#define cb_erase_str(cb, key) \
+  cb_erase(cb, (void *)key, strlen(key)+1)
+#define cb_find_prefix_str(cb, key, results, numresults, offset) \
+  cb_find_prefix(cb, (const void *)key, strlen(key), results, numresults, offset)
+
+#define CB_KV_SIZE(keylen, datalen) (keylen+datalen+1)
+size_t cb_new_kv(const char *key, size_t keylen, const void * value, size_t len, void * out);
+void cb_get_kv(const void *kv, void * value, size_t len);
+void cb_get_kv_ex(void *kv, void ** value);
+
+#ifdef __cplusplus
+}
+#endif
+#endif
diff --git a/object.c b/object.c
index 67d9a9e..24d26a8 100644
--- a/object.c
+++ b/object.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "critbit.h"
 
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
@@ -51,32 +52,8 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 	die("invalid object type \"%s\"", str);
 }
 
-/*
- * Return a numerical hash value between 0 and n-1 for the object with
- * the specified sha1.  n must be a power of 2.  Please note that the
- * return value is *not* consistent across computer architectures.
- */
-static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
-{
-	return sha1hash(sha1) & (n - 1);
-}
-
-/*
- * Insert obj into the hash table hash, which has length size (which
- * must be a power of 2).  On collisions, simply overflow to the next
- * empty bucket.
- */
-static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
-{
-	unsigned int j = hash_obj(obj->oid.hash, size);
 
-	while (hash[j]) {
-		j++;
-		if (j >= size)
-			j = 0;
-	}
-	hash[j] = obj;
-}
+struct critbit_tree objects;
 
 /*
  * Look up the record for the given sha1 in the hash map stored in
@@ -84,58 +61,10 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
  */
 struct object *lookup_object(const unsigned char *sha1)
 {
-	unsigned int i, first;
-	struct object *obj;
-
-	if (!obj_hash)
+	const unsigned char *ret = cb_find(&objects, sha1, 20);
+	if (!ret)
 		return NULL;
-
-	first = i = hash_obj(sha1, obj_hash_size);
-	while ((obj = obj_hash[i]) != NULL) {
-		if (!hashcmp(sha1, obj->oid.hash))
-			break;
-		i++;
-		if (i == obj_hash_size)
-			i = 0;
-	}
-	if (obj && i != first) {
-		/*
-		 * Move object to where we started to look for it so
-		 * that we do not need to walk the hash table the next
-		 * time we look for it.
-		 */
-		struct object *tmp = obj_hash[i];
-		obj_hash[i] = obj_hash[first];
-		obj_hash[first] = tmp;
-	}
-	return obj;
-}
-
-/*
- * Increase the size of the hash map stored in obj_hash to the next
- * power of 2 (but at least 32).  Copy the existing values to the new
- * hash map.
- */
-static void grow_object_hash(void)
-{
-	int i;
-	/*
-	 * Note that this size must always be power-of-2 to match hash_obj
-	 * above.
-	 */
-	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
-	struct object **new_hash;
-
-	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
-	for (i = 0; i < obj_hash_size; i++) {
-		struct object *obj = obj_hash[i];
-		if (!obj)
-			continue;
-		insert_obj_hash(obj, new_hash, new_hash_size);
-	}
-	free(obj_hash);
-	obj_hash = new_hash;
-	obj_hash_size = new_hash_size;
+	return (struct object *)(ret - offsetof(struct object, oid));
 }
 
 void *create_object(const unsigned char *sha1, void *o)
@@ -147,10 +76,8 @@ void *create_object(const unsigned char *sha1, void *o)
 	obj->flags = 0;
 	hashcpy(obj->oid.hash, sha1);
 
-	if (obj_hash_size - 1 <= nr_objs * 2)
-		grow_object_hash();
+	cb_insert(&objects, &obj->oid, 20);
 
-	insert_obj_hash(obj, obj_hash, obj_hash_size);
 	nr_objs++;
 	return obj;
 }
-- 
2.10.0.271.ge3ee153

