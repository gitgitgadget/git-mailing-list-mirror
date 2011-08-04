From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] implement generic key/value map
Date: Thu, 4 Aug 2011 16:45:48 -0600
Message-ID: <20110804224547.GA27912@sigill.intra.peff.net>
References: <20110804224354.GA27476@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 00:46:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp6fs-0006nb-QR
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 00:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab1HDWpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 18:45:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32913
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab1HDWpv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 18:45:51 -0400
Received: (qmail 23336 invoked by uid 107); 4 Aug 2011 22:46:25 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 18:46:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 16:45:48 -0600
Content-Disposition: inline
In-Reply-To: <20110804224354.GA27476@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178768>

It is frequently useful to have a fast, generic data
structure mapping keys to values. We already have something
like this in the "decorate" API, but it has two downsides:

  1. The key type must always be a "struct object *".

  2. The value type is a void pointer, which means it is
     inefficient and cumbersome for storing small values.
     One must either encode their value inside the void
     pointer, or allocate additional storage for the pointer
     to point to.

This patch introduces a generic map data structure, mapping
keys of arbitrary type to values of arbitrary type.

One possible strategy for implementation is to have a struct
that points to a sequence of bytes for each of the key and
the value, and to try to treat them as opaque in the code.
However, this code gets complex, has a lot of casts, and
runs afoul of violating alignment and strict aliasing rules.

This patch takes a different approach. We parameterize the
types in each map by putting the declarations and
implementations inside macros, and expand the macros with
the correct types. This lets the compiler see the actual
code, with its real types, and figure out things like struct
packing and alignment itself.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-map.txt |  160 +++++++++++++++++++++++++++++++++++
 Makefile                            |    2 +
 map.c                               |   86 +++++++++++++++++++
 map.h                               |   26 ++++++
 4 files changed, 274 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-map.txt
 create mode 100644 map.c
 create mode 100644 map.h

diff --git a/Documentation/technical/api-map.txt b/Documentation/technical/api-map.txt
new file mode 100644
index 0000000..4153ef1
--- /dev/null
+++ b/Documentation/technical/api-map.txt
@@ -0,0 +1,160 @@
+map API
+=======
+
+The map API is a system for efficiently mapping keys to values in memory. Items
+are stored in a hash table for fast lookup; storage efficiency is achieved
+through macro-based code generation, which lets the compiler store values
+compactly in memory.
+
+Due to the code generation, there are two different facets of this API: macros
+to build new types of mappings (i.e., generate new function and struct
+definitions), and generated functions to store and retrieve values from a
+particular mapping.
+
+
+Related APIs
+------------
+
+The hash API provides a similar key/value store. However, it does not deal with
+hash collisions itself, leaving the caller to handle bucket management (but
+this is a feature if you are interested in using the collisions as part of an
+algorithm).  Furthermore, it can store only void pointers, making storage of
+small values inefficient and cumbersome.
+
+The decorate API provides a similar interface to map, but is restricted to
+using "struct object" as the key, and a void pointer as the value.
+
+
+Defining New Map Types
+----------------------
+
+A map type is uniquely defined by the pair of its key and value types. To
+define a new type, you must use the `DECLARE_MAP` macro in `map.h`, and the
+`IMPLEMENT_MAP` macro in `map.c`. Their usage is described below:
+
+`DECLARE_MAP`::
+
+	Declare a new type of map, including the struct definition and
+	declarations of access functions. The `name` parameter should describe
+	the types (e.g., `object_uint32` to map objects to 32-bit integers).
+	The `ktype` parameter specifies the C type of the key (e.g.,
+	`struct object *`) and the `vtype` parameter specifies the C type of
+	the value (e.g., `uint32_t`).
+
+`IMPLEMENT_MAP`::
+
+	Create function definitions for a map type. The `name` parameter should
+	match one given to `DECLARE_MAP`. The `equal_fun` parameter should
+	specify a function that, when given two items of type `ktype`, will
+	return a non-zero value if they are equal.  The `hash_fun` parameter
+	should specify a function that will convert an object of type `ktype`
+	into an integer hash value.
+
+Several convenience functions are provided to fill in macro parameters:
+
+`hash_obj`::
+
+	Suitable for `hash_fun` when the key type is `struct object *`.
+
+`obj_equal`::
+
+	Suitable for `equal_fun` when the key type is `struct object *`.
+
+
+Data Structures
+---------------
+
+Each defined map type will have its own structure (e.g., `map_object_uint32`).
+
+`struct map_NAME`::
+
+	A single map object. This struct should be initialized to all-zeroes.
+	The `nr` field specifies the number of items stored in the map. The
+	`size` field specifies the number of hash buckets allocated. The `hash`
+	field stores the actual data. Callers should never need to look at
+	these fields unless they are enumerating all elements of the map (see
+	the example below).
+
+`struct map_entry_NAME`::
+
+	A single entry in the hash, which may or may not contain a value. If
+	the `used` field is false, the `key` and `value` fields should not be
+	examined at all. Otherwise, the `key` and `value` fields represent a
+	single mapped pair.  You should never need to use this type directly,
+	unless you are enumerating all elements of a map.
+
+
+Functions
+---------
+
+Each defined map type will have its own set of access function (e.g.,
+`map_get_object_uint32`).
+
+`map_get_NAME(struct map_NAME *, const ktype key, vtype *value)`::
+
+	Retrieve the value corresponding to `key`, returning it via the pointer
+	`value`. Returns 1 if an item was found, zero otherwise (in which case
+	`value` is unchanged).
+
+`map_set_NAME(struct map_NAME *, const ktype key, vtype value, vtype *old)`::
+
+	Insert a mapping from `key` to `value`. If a mapping for `key` already
+	existed, the previous value is copied into `old` (if it is non-NULL)
+	and the function returns 1. Otherwise, the function returns 0.
+
+
+Examples
+--------
+
+Create a new mapping type of objects to integers:
+
+-------------------------------------------------------------------
+/* in map.h */
+DECLARE_MAP(object_int, struct object *, int)
+
+/* in map.c */
+IMPLEMENT_MAP(object_int, struct object *, int, obj_equal, hash_obj)
+-------------------------------------------------------------------
+
+Store and retrieve integers by object key:
+
+-------------------------------------------------------------------
+static struct map_object_int foos;
+
+void store_foo(const struct commit *c, int foo)
+{
+	int old;
+	if (map_set_object_uint32(&foos, &c->object, foo, &old))
+		printf("old value was %d\n", old);
+}
+
+void print_foo(const struct commit *c)
+{
+	int v;
+
+	if (map_get_object_int(&foos, &c->object, &v))
+		printf("foo: %d\n", v);
+	else
+		printf("no such foo\n");
+}
+-------------------------------------------------------------------
+
+Iterate over all map entries:
+
+-------------------------------------------------------------------
+void dump_foos(void)
+{
+	int i;
+
+	printf("there are %u foos:\n", foos.nr);
+
+	for (i = 0; i < foos.size; i++) {
+		struct map_entry_object_int *e = foos.hash[i];
+
+		if (!e->used)
+			continue;
+
+		printf("%s -> %d\n", sha1_to_hex(e->key->sha1), e->value);
+	}
+}
+-------------------------------------------------------------------
diff --git a/Makefile b/Makefile
index 4ed7996..acda5b8 100644
--- a/Makefile
+++ b/Makefile
@@ -533,6 +533,7 @@ LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
+LIB_H += map.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
 LIB_H += notes.h
@@ -624,6 +625,7 @@ LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += mailmap.o
+LIB_OBJS += map.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
diff --git a/map.c b/map.c
new file mode 100644
index 0000000..35f300e
--- /dev/null
+++ b/map.c
@@ -0,0 +1,86 @@
+#include "cache.h"
+#include "map.h"
+#include "object.h"
+
+static unsigned int hash_obj(const struct object *obj, unsigned int n)
+{
+	unsigned int hash;
+
+	memcpy(&hash, obj->sha1, sizeof(unsigned int));
+	return hash % n;
+}
+
+static int obj_equal(const struct object *a, const struct object *b)
+{
+	return a == b;
+}
+
+#define IMPLEMENT_MAP(name, equal_fun, hash_fun) \
+static int map_insert_##name(struct map_##name *m, \
+			     const map_ktype_##name key, \
+			     map_vtype_##name value, \
+			     map_vtype_##name *old) \
+{ \
+	unsigned int j; \
+\
+	for (j = hash_fun(key, m->size); m->hash[j].used; j = (j+1) % m->size) { \
+		if (equal_fun(m->hash[j].key, key)) { \
+			if (old) \
+				*old = m->hash[j].value; \
+			m->hash[j].value = value; \
+			return 1; \
+		} \
+	} \
+\
+	m->hash[j].key = key; \
+	m->hash[j].value = value; \
+	m->hash[j].used = 1; \
+	m->nr++; \
+	return 0; \
+} \
+\
+static void map_grow_##name(struct map_##name *m) \
+{ \
+	struct map_entry_##name *old_hash = m->hash; \
+	unsigned int old_size = m->size; \
+	unsigned int i; \
+\
+	m->size = (old_size + 1000) * 3 / 2; \
+	m->hash = xcalloc(m->size, sizeof(*m->hash)); \
+	m->nr = 0; \
+\
+	for (i = 0; i < old_size; i++) { \
+		if (!old_hash[i].used) \
+			continue; \
+		map_insert_##name(m, old_hash[i].key, old_hash[i].value, NULL); \
+	} \
+	free(old_hash); \
+} \
+\
+int map_set_##name(struct map_##name *m, \
+		   const map_ktype_##name key, \
+		   map_vtype_##name value, \
+		   map_vtype_##name *old) \
+{ \
+	if (m->nr >= m->size * 2 / 3) \
+		map_grow_##name(m); \
+	return map_insert_##name(m, key, value, old); \
+} \
+\
+int map_get_##name(struct map_##name *m, \
+		   const map_ktype_##name key, \
+		   map_vtype_##name *value) \
+{ \
+	unsigned int j; \
+\
+	if (!m->size) \
+		return 0; \
+\
+	for (j = hash_fun(key, m->size); m->hash[j].used; j = (j+1) % m->size) { \
+		if (equal_fun(m->hash[j].key, key)) { \
+			*value = m->hash[j].value; \
+			return 1; \
+		} \
+	} \
+	return 0; \
+}
diff --git a/map.h b/map.h
new file mode 100644
index 0000000..cb2d4e2
--- /dev/null
+++ b/map.h
@@ -0,0 +1,26 @@
+#ifndef MAP_H
+#define MAP_H
+
+#define DECLARE_MAP(name, key_type, value_type) \
+typedef key_type map_ktype_##name; \
+typedef value_type map_vtype_##name; \
+struct map_entry_##name { \
+	map_ktype_##name key; \
+	map_vtype_##name value; \
+	unsigned used:1; \
+}; \
+\
+struct map_##name { \
+	unsigned int size, nr; \
+	struct map_entry_##name *hash; \
+}; \
+\
+extern int map_get_##name(struct map_##name *, \
+			  const map_ktype_##name key, \
+			  map_vtype_##name *value); \
+extern int map_set_##name(struct map_##name *, \
+			  const map_ktype_##name key, \
+			  map_vtype_##name value, \
+			  map_vtype_##name *old);
+
+#endif /* MAP_H */
-- 
1.7.6.34.g86521e
