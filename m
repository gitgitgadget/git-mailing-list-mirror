From: Jeff King <peff@peff.net>
Subject: [PATCH 1/8] implement generic key/value map
Date: Sat, 4 Aug 2012 13:10:38 -0400
Message-ID: <20120804171038.GA19378@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:10:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxhsF-0002mr-8q
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 19:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab2HDRKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 13:10:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51672 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537Ab2HDRKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 13:10:40 -0400
Received: (qmail 1951 invoked by uid 107); 4 Aug 2012 17:10:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Aug 2012 13:10:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2012 13:10:38 -0400
Content-Disposition: inline
In-Reply-To: <20120804170905.GA19267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202882>

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
types in each map and putting the declarations and
implementations inside macros. This lets the compiler see
the actual code, with its real types, and figure out things
like struct packing and alignment itself.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the one with the pre-processor grossness. Don't be _too_ scared
off by the ugliness of test-map.c; it's also trying to be polymorphic
with respect to different maps, which makes it even uglier. See patches
2 and 3 for a more reasonable application.

 .gitignore                          |   1 +
 Documentation/technical/api-map.txt | 214 ++++++++++++++++++++++++++++++++++++
 Makefile                            |   5 +
 map-decl.h                          |  22 ++++
 map-done.h                          |  19 ++++
 map-impl.h                          |  94 ++++++++++++++++
 map-init.h                          |  24 ++++
 t/t0007-map.sh                      |  50 +++++++++
 test-map.c                          | 182 ++++++++++++++++++++++++++++++
 9 files changed, 611 insertions(+)
 create mode 100644 Documentation/technical/api-map.txt
 create mode 100644 map-decl.h
 create mode 100644 map-done.h
 create mode 100644 map-impl.h
 create mode 100644 map-init.h
 create mode 100755 t/t0007-map.sh
 create mode 100644 test-map.c

diff --git a/.gitignore b/.gitignore
index bb5c91e..c2bad89 100644
--- a/.gitignore
+++ b/.gitignore
@@ -184,6 +184,7 @@
 /test-genrandom
 /test-index-version
 /test-line-buffer
+/test-map
 /test-match-trees
 /test-mergesort
 /test-mktemp
diff --git a/Documentation/technical/api-map.txt b/Documentation/technical/api-map.txt
new file mode 100644
index 0000000..f86b785
--- /dev/null
+++ b/Documentation/technical/api-map.txt
@@ -0,0 +1,214 @@
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
+define a new type, you must set up some preprocessor defines to specify
+the key and values types, along with any special options for the
+implementation. Then to instantiate the declaration of a map (i.e., the
+bits that would go in a header file), include "map-decl.h". To
+instantiate the implementation, include "map-impl.h". To clean up your
+preprocessor options, include "map-done.h".
+
+The following map defines are available:
+
+`NAME`::
+
+	Required. The name of the map. This should syntactically be a C
+	identifier (alphanumeric and underscore), and should describe
+	the types involved in the map (e.g., `object_uint32` to map
+	objects to 32-bit integers).
+
+`KEY_TYPE`::
+
+	Required. The C type of the key, as it will be stored in the
+	hash (e.g., `struct object *` to store an object pointer).
+
+`PASS_KEY_BY_REF`::
+
+	Optional. If defined, indicates that keys are a complex type
+	that should be passed between functions using pointers.
+	Otherwise, keys are passed by value.
+
+`HASH`::
+
+	Required. A function that will convert an object of type
+	`KEY_TYPE` into an integer hash value.
+
+`KEY_EQUAL`::
+
+	Required. A function that will compare two keys, and return
+	non-zero if and only if they are equal.
+
+`VALUE_TYPE`::
+
+	Required. The C type of the value, as it will be stored in the
+	hash (e.g., `uint32_t` to store a 32-bit integer).
+
+`SENTINEL_NULL`::
+
+	Optional. If defined, indicates that keys can store an all-zero
+	sentinel value (e.g., if the key is a pointer). This enables an
+	optimization to shrink the size of each map entry, at the cost
+	of not being able to store `NULL` key pointers in the map.
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
+	A single key/value entry in the hash, which may or may not
+	contain valid data. If `SENTINEL_NULL` is defined, then an empty
+	entry will have a NULL key; otherwise, there is a `used` field
+	which will be zero in an empty entry (in which case the contents
+	of the `key` field are undefined). If the entry is empty, the
+	contents of the `value` field is undefined.  You should never
+	need to use this type directly, unless you are enumerating all
+	elements of a map.
+
+
+Functions
+---------
+
+Each defined map type will have its own set of access functions (e.g.,
+`map_get_object_uint32`).
+
+`map_get_NAME(struct map_NAME *, KEY_TYPE key, VALUE_TYPE *value)`::
+
+	Retrieve the value corresponding to `key`, returning it via the
+	pointer `value`. Returns 1 if an item was found, zero otherwise
+	(in which case `value` is unchanged). If `PASS_KEY_BY_REF` is
+	defined, the key is passed in as a `const KEY_TYPE *`.
+
+`map_set_NAME(struct map_NAME *, KEY_TYPE key, VALUE_TYPE value, VALUE_TYPE *old)`::
+
+	Insert a mapping from `key` to `value`. If a mapping for `key`
+	already existed, the previous value is copied into `old` (if it
+	is non-NULL) and the function returns 1. Otherwise, the function
+	returns 0.  If `PASS_KEY_BY_REF` or `PASS_VALUE_BY_REF` is
+	defined, the key and value are passed in as `const KEY_TYPE *`
+	and `const VALUE_TYPE *`, respectively.
+
+
+Examples
+--------
+
+Declare a new mapping type of strings to integers:
+
+-------------------------------------------------------------------
+/* in map-string-int.h */
+#define NAME string_int
+#define KEY_TYPE const char *
+#define VALUE_TYPE int
+#include "map-decl.h"
+#include "map-done.h"
+-------------------------------------------------------------------
+
+Implement the mapping:
+
+-------------------------------------------------------------------
+/* in map-string-int.c */
+
+static unsigned int hash_string(const char * const *strp, unsigned int n)
+{
+	unsigned long hash = 0;
+	const char *p;
+
+	for (p = *strp; *p; p++)
+		hash = (hash << 5) + *p;
+	return hash % n;
+}
+
+static unsigned int string_equal(const char * const *a, const char * const *b)
+{
+	return !strcmp(*a, *b);
+}
+
+#define NAME string_int
+#define KEY_TYPE const char *
+#define VALUE_TYPE int
+#include "map-impl.h"
+#include "map-done.h"
+-------------------------------------------------------------------
+
+Store and retrieve integers by string (note that the map will not
+duplicate the strings; the type is defined to merely store the
+pointer values).
+
+-------------------------------------------------------------------
+#include "map-string-int.h"
+
+static struct map_string_int foos;
+
+void store_foo(const char *s, int foo)
+{
+	int old;
+	if (map_set_object_int(&foos, xstrdup(s), foo, &old))
+		printf("old value was %d\n", old);
+}
+
+void print_foo(const char *s)
+{
+	int v;
+
+	if (map_get_object_int(&foos, s, &v))
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
+		struct map_entry_string_int *e = foos.hash + i;
+		if (e->used)
+			printf("%s -> %d\n", e->key, e->value);
+	}
+}
+-------------------------------------------------------------------
diff --git a/Makefile b/Makefile
index 4b58b91..d512f27 100644
--- a/Makefile
+++ b/Makefile
@@ -491,6 +491,7 @@ TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
+TEST_PROGRAMS_NEED_X += test-map
 TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
@@ -628,6 +629,10 @@ LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
+LIB_H += map-decl.h
+LIB_H += map-done.h
+LIB_H += map-impl.h
+LIB_H += map-init.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
 LIB_H += mergesort.h
diff --git a/map-decl.h b/map-decl.h
new file mode 100644
index 0000000..7d4daaf
--- /dev/null
+++ b/map-decl.h
@@ -0,0 +1,22 @@
+#include "map-init.h"
+
+struct THIS(map_entry) {
+	KEY_TYPE key;
+	VALUE_TYPE value;
+#ifndef SENTINEL_NULL
+	unsigned used:1;
+#endif
+};
+
+struct THIS(map) {
+	unsigned int size, nr;
+	struct THIS(map_entry) *hash;
+};
+
+extern int THIS(map_get)(struct THIS(map) *,
+			 KEY_ARG key,
+			 VALUE_TYPE *value);
+extern int THIS(map_set)(struct THIS(map) *,
+			 KEY_ARG key,
+			 VALUE_ARG value,
+			 VALUE_TYPE *old);
diff --git a/map-done.h b/map-done.h
new file mode 100644
index 0000000..65983d3
--- /dev/null
+++ b/map-done.h
@@ -0,0 +1,19 @@
+#undef NAME
+#undef KEY_TYPE
+#undef KEY_ARG
+#undef PASS_KEY_BY_REF
+#undef key_ref
+#undef key_deref
+#undef VALUE_TYPE
+#undef VALUE_ARG
+#undef PASS_VALUE_BY_REF
+#undef value_ref
+#undef value_deref
+#undef HASH
+#undef KEY_EQUAL
+#undef SENTINEL_NULL
+#undef hash_used
+#undef PASTE2
+#undef PASTE
+#undef THIS
+#undef MAP_UTIL_INITIALIZED
diff --git a/map-impl.h b/map-impl.h
new file mode 100644
index 0000000..844b7f1
--- /dev/null
+++ b/map-impl.h
@@ -0,0 +1,94 @@
+#include "map-init.h"
+
+#ifdef PASS_KEY_BY_REF
+#define key_ref(x) (&(x))
+#define key_deref(x) (*(x))
+#else
+#define key_ref(x) (x)
+#define key_deref(x) (x)
+#endif
+
+#ifdef PASS_VALUE_BY_REF
+#define value_ref(x) (&(x))
+#define value_deref(x) (*(x))
+#else
+#define value_ref(x) (x)
+#define value_deref(x) (x)
+#endif
+
+#ifdef SENTINEL_NULL
+#define hash_used(x) (x)->key
+#else
+#define hash_used(x) (x)->used
+#endif
+
+static int THIS(map_insert)(struct THIS(map) *m,
+			    KEY_ARG key,
+			    VALUE_ARG value,
+			    VALUE_TYPE *old)
+{
+	unsigned int j;
+
+	for (j = HASH(key, m->size); hash_used(&m->hash[j]); j = (j+1) % m->size) {
+		if (KEY_EQUAL(key_ref(m->hash[j].key), key)) {
+			if (old)
+				*old = m->hash[j].value;
+			m->hash[j].value = value_deref(value);
+			return 1;
+		}
+	}
+
+	m->hash[j].key = key_deref(key);
+	m->hash[j].value = value_deref(value);
+#ifndef SENTINEL_NULL
+	m->hash[j].used = 1;
+#endif
+	m->nr++;
+	return 0;
+}
+
+static void THIS(map_grow)(struct THIS(map) *m)
+{
+	struct THIS(map_entry) *old_hash = m->hash;
+	unsigned int old_size = m->size;
+	unsigned int i;
+
+	m->size = (old_size + 1000) * 3 / 2;
+	m->hash = xcalloc(m->size, sizeof(*m->hash));
+	m->nr = 0;
+
+	for (i = 0; i < old_size; i++) {
+		if (!hash_used(&old_hash[i]))
+			continue;
+		THIS(map_insert)(m, key_ref(old_hash[i].key), value_ref(old_hash[i].value), NULL);
+	}
+	free(old_hash);
+}
+
+int THIS(map_set)(struct THIS(map) *m,
+		   KEY_ARG key,
+		   VALUE_ARG value,
+		   VALUE_TYPE *old)
+{
+	if (m->nr >= m->size * 2 / 3)
+		THIS(map_grow)(m);
+	return THIS(map_insert)(m, key, value, old);
+}
+
+int THIS(map_get)(struct THIS(map) *m,
+		  KEY_ARG key,
+		  VALUE_TYPE *value)
+{
+	unsigned int j;
+
+	if (!m->size)
+		return 0;
+
+	for (j = HASH(key, m->size); hash_used(&m->hash[j]); j = (j+1) % m->size) {
+		if (KEY_EQUAL(key_ref(m->hash[j].key), key)) {
+			*value = m->hash[j].value;
+			return 1;
+		}
+	}
+	return 0;
+}
diff --git a/map-init.h b/map-init.h
new file mode 100644
index 0000000..1d2c4b3
--- /dev/null
+++ b/map-init.h
@@ -0,0 +1,24 @@
+#ifndef MAP_UTIL_INITIALIZED
+#define MAP_UTIL_INITIALIZED
+
+/*
+ * C preprocessor recursion hackery. Macros are not expanded next
+ * to ## tokens, so we have to add an extra level of indirection.
+ */
+#define PASTE2(x,y) x ## _ ## y
+#define PASTE(x,y) PASTE2(x,y)
+#define THIS(x) PASTE(x, NAME)
+
+#ifdef PASS_KEY_BY_REF
+#define KEY_ARG const KEY_TYPE *
+#else
+#define KEY_ARG KEY_TYPE
+#endif
+
+#ifdef PASS_VALUE_BY_REF
+#define VALUE_ARG const VALUE_TYPE *
+#else
+#define VALUE_ARG VALUE_TYPE
+#endif
+
+#endif
diff --git a/t/t0007-map.sh b/t/t0007-map.sh
new file mode 100755
index 0000000..b5845f4
--- /dev/null
+++ b/t/t0007-map.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='basic tests for the map implementation'
+. ./test-lib.sh
+
+test_expect_success 'setup input' '
+	cat >input <<-\EOF
+	f 6
+	b 2
+	a 1
+	e 5
+	i 9
+	g 7
+	d 4
+	h 8
+	c 3
+	EOF
+'
+
+for type in pointer struct; do
+	test_expect_success "look up elements ($type)" "
+		cat >expect <<-\EOF &&
+		a: 1
+		i: 9
+		d: 4
+		EOF
+		test-map $type find a i d <input >actual &&
+		test_cmp expect actual
+	"
+
+	test_expect_success "iterate over elements ($type)" "
+		cat >expect <<-\EOF &&
+		a: 1
+		b: 2
+		c: 3
+		d: 4
+		e: 5
+		f: 6
+		g: 7
+		h: 8
+		i: 9
+		EOF
+		test-map $type print <input >actual &&
+		# iteration order is hash-dependent, so we must sort
+		sort <actual >actual.sorted &&
+		test_cmp expect actual.sorted
+	"
+done
+
+test_done
diff --git a/test-map.c b/test-map.c
new file mode 100644
index 0000000..b5f74a1
--- /dev/null
+++ b/test-map.c
@@ -0,0 +1,182 @@
+#include "git-compat-util.h"
+
+static const char usage_msg[] =
+"test-map <pointer|struct> <find|print> [args]";
+
+static inline unsigned int hash_string(const char *str, unsigned int n)
+{
+	unsigned long hash = 0;
+
+	for (; *str; str++)
+		hash = (hash << 5) + *str;
+	return hash % n;
+}
+
+static inline unsigned int string_equal(const char *a, const char *b)
+{
+	return !strcmp(a, b);
+}
+
+#define NAME string_int
+#define KEY_TYPE const char *
+#define VALUE_TYPE int
+#define HASH hash_string
+#define KEY_EQUAL string_equal
+#define SENTINEL_NULL
+#include "map-decl.h"
+#include "map-impl.h"
+#include "map-done.h"
+
+struct foo {
+	char buf[10];
+};
+
+static inline unsigned int hash_foo(const struct foo *f, unsigned int n)
+{
+	return hash_string(f->buf, n);
+}
+
+static inline unsigned int foo_equal(const struct foo *a, const struct foo *b)
+{
+	return string_equal(a->buf, b->buf);
+}
+
+#define NAME foo_foo
+#define KEY_TYPE struct foo
+#define VALUE_TYPE struct foo
+#define HASH hash_foo
+#define KEY_EQUAL foo_equal
+#define PASS_KEY_BY_REF
+#define PASS_VALUE_BY_REF
+#include "map-decl.h"
+#include "map-impl.h"
+#include "map-done.h"
+
+static void read_map(void *vm,
+		     void (*store)(void *, const char *, const char *))
+{
+	char buf[1024];
+
+	while (fgets(buf, sizeof(buf), stdin)) {
+		char *delim;
+
+		if (strlen(buf) > 0 && buf[strlen(buf)-1] == '\n')
+			buf[strlen(buf)-1] = '\0';
+
+		delim = strchr(buf, ' ');
+		if (!delim)
+			die("invalid input: %s", buf);
+		*delim++ = '\0';
+
+		store(vm, buf, delim);
+	}
+}
+
+static void store_string_int(void *vm, const char *k, const char *v)
+{
+	struct map_string_int *m = vm;
+	map_set_string_int(m, xstrdup(k), atoi(v), NULL);
+}
+
+static void store_foo_foo(void *vm, const char *k, const char *v)
+{
+	struct map_foo_foo *m = vm;
+	struct foo kf, vf;
+	snprintf(kf.buf, sizeof(kf.buf), "%s", k);
+	snprintf(vf.buf, sizeof(vf.buf), "%s", v);
+	map_set_foo_foo(m, &kf, &vf, NULL);
+}
+
+static int fetch_string_int(void *vm, const char *k)
+{
+	struct map_string_int *m = vm;
+	int value;
+	if (map_get_string_int(m, k, &value))
+		return value;
+	return 0;
+}
+
+static int fetch_foo_foo(void *vm, const char *k)
+{
+	struct map_foo_foo *m = vm;
+	struct foo key, value;
+	snprintf(key.buf, sizeof(key.buf), "%s", k);
+	if (map_get_foo_foo(m, &key, &value))
+		return atoi(value.buf);
+	return 0;
+}
+
+static void print_string_int(void *vm)
+{
+	struct map_string_int *m = vm;
+	int i;
+	for (i = 0; i < m->size; i++) {
+		struct map_entry_string_int *e = m->hash + i;
+
+		if (e->key)
+			printf("%s: %d\n", e->key, e->value);
+	}
+}
+
+static void print_foo_foo(void *vm)
+{
+	struct map_foo_foo *m = vm;
+	int i;
+	for (i = 0; i < m->size; i++) {
+		struct map_entry_foo_foo *e = m->hash + i;
+
+		if (e->used)
+			printf("%s: %s\n", e->key.buf, e->value.buf);
+	}
+}
+
+static void do_op(void *vm,
+		  void (*print)(void *),
+		  int (*fetch)(void *, const char *),
+		  const char **argv)
+{
+	const char *op = *argv++;
+	if (!op)
+		usage(usage_msg);
+
+	if (!strcmp(op, "print"))
+		print(vm);
+	else if (!strcmp(op, "find")) {
+		for (; *argv; argv++) {
+			const char *key = *argv;
+			int value = fetch(vm, key);
+
+			if (value)
+				printf("%s: %d\n", key, value);
+			else
+				printf("%s: not found\n", key);
+		}
+	}
+	else
+		usage(usage_msg);
+}
+
+int main(int argc, const char **argv)
+{
+	const char *type;
+
+	argv++;
+	type = *argv++;
+	if (!type)
+	       usage(usage_msg);
+
+	if (!strcmp(type, "pointer")) {
+		struct map_string_int m = {0};
+		read_map(&m, store_string_int);
+		do_op(&m, print_string_int, fetch_string_int, argv);
+	}
+	else if (!strcmp(type, "struct")) {
+		struct map_foo_foo m = {0};
+		read_map(&m, store_foo_foo);
+		do_op(&m, print_foo_foo, fetch_foo_foo, argv);
+	}
+	else
+		usage(usage_msg);
+
+	return 0;
+}
-- 
1.7.12.rc1.7.g7a223a6
