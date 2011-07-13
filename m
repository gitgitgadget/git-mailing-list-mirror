From: Jeff King <peff@peff.net>
Subject: [RFC/PATCHv2 1/6] decorate: allow storing values instead of pointers
Date: Wed, 13 Jul 2011 02:57:00 -0400
Message-ID: <20110713065700.GA18566@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 08:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgtNe-0003FP-GI
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 08:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930Ab1GMG5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 02:57:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57389
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab1GMG5D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 02:57:03 -0400
Received: (qmail 21054 invoked by uid 107); 13 Jul 2011 06:57:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 02:57:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 02:57:00 -0400
Content-Disposition: inline
In-Reply-To: <20110713064709.GA18499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176998>

The decorate API provides a mapping of objects to arbitrary
values. Until now, it did this by allowing you to store a
void pointer, which could point to other storage. This has
two problems:

  1. It's inefficient. To store even a small value, you have
     to allocate persistent storage. So we end up storing
     both the value and a pointer to it.

  2. It's a pain to use. To avoid heap overhead for small
     values, you have to either use a custom allocater, or
     you have to shoe-horn the value into the void pointer
     (if it's small enough to fit).

This patch lets you store fixed-size values directly in the
hash table without allocating them elsewhere. This is a
definite win for any value smaller than or equal to a
pointer. It's probably a win for slightly larger values, but
may eventually be slower for storing large structs (because
the values are copied when the hash grows).

It also provides a more natural interface for storing small
values; see the changes in fast-export.c, which can now drop
its pointer arithmetic magic.

The original "store and retrieve a void pointer" API is easy
to implement on top of this (the values we store are the
pointers). The add_decoration and lookup_decoration
functions are kept for compatibility.

Signed-off-by: Jeff King <peff@peff.net>
---
The "width" field is now const; you must either use a static
initializer or overwrite a struct decoration via memset. This gives us a
little more language-enforced safety.

The "stride" and "end" fields were removed in favor of run-time
calculation. The calculations are wrapped in inline functions to give
the optimizer a chance to remove them.

Since we're translating sizes to pointers in our loops via these
functions now anyway, I made the iteration interface a bit more sane.
It used to be:

  unsigned char *p;
  for (p = n->hash; p < n->end; p += n->stride) {
    struct object_decoration *e = (struct object_decoration *)p;
    ...
  }

which really leaks ugly implementation details. You can now do:

  int i;
  for (i = 0; i < n->size; i++) {
    struct object_decoration *e = decoration_slot(n, i);
    ...
  }

which is a bit more natural.

I peeked at the output of "gcc -O3"; it doesn't actually hoist much of
the decoration_slot calculation out of the loop. But I measured the code
from the previous series with this one, and wasn't able to detect a
difference. So I think using pointers was just a silly premature
micro-optimization.

 Documentation/technical/api-decorate.txt |  164 +++++++++++++++++++++++++++++-
 builtin/fast-export.c                    |   29 ++----
 decorate.c                               |   70 +++++++++----
 decorate.h                               |   37 ++++++-
 4 files changed, 251 insertions(+), 49 deletions(-)

diff --git a/Documentation/technical/api-decorate.txt b/Documentation/technical/api-decorate.txt
index 1d52a6c..b048b28 100644
--- a/Documentation/technical/api-decorate.txt
+++ b/Documentation/technical/api-decorate.txt
@@ -1,6 +1,166 @@
 decorate API
 ============
 
-Talk about <decorate.h>
+The decorate API is a system for efficiently mapping objects to values
+in memory. It is slightly slower than an actual member of an object
+struct (because it incurs a hash lookup), but it uses less memory when
+the mapping is not in use, or when the number of decorated objects is
+small compared to the total number of objects.
 
-(Linus)
+For efficiency, the mapping is capable of storing actual byte values, as
+long as the byte values for each element are of a fixed size. So one
+could, for example, map objects into 32-bit integers. For ease of use,
+functions are provided for storing the values of arbitrary pointers,
+which can point to strings or structs.
+
+Data Structures
+---------------
+
+`struct decoration`::
+
+	This structure represents a single mapping of objects to
+	values. Its fields are:
+
+	`name`:::
+		This field is not used by the decorate API itself, but
+		may be used by calling code.
+
+	`width`:::
+		This field specifies the width (in units of `char`) of
+		the values to be stored. This field must be set to its
+		final value when the decoration struct is initialized.
+		A width of `0` is equivalent to `sizeof(void *)`.
+
+	`nr`:::
+		The number of objects currently mapped by the
+		decoration.
+
+	`size`:::
+		The number of hash slots allocated; this is kept to at
+		least 3/2 of the number of actual slots used, to keep
+		the hash sparse.
+
+	`hash`:::
+		A pointer to an array of actual `object_decoration`
+		structs. Note that because the width of `struct
+		object_decoration` is not known until runtime, this
+		array is stored with type `unsigned char *`. To access
+		individual items, one must perform pointer arithmetic;
+		see the `decoration_by_offset` function below.
+
+`struct object_decoration`::
+
+	A structure representing the decoration of a single object.
+	Callers will not normally need to use this object unless they
+	are iterating all elements in the decoration hash. The `base`
+	field points to the object being mapped (or `NULL` if it is
+	an empty hash slot). The `decoration` field stores the mapped
+	value as a sequence of bytes; use the `width` field in `struct
+	decoration` to know the exact size.
+
+
+Functions
+---------
+
+`add_decoration_value`::
+
+	Add a mapping from an object to a sequence of bytes. The number
+	of bytes pointed to by `decoration` should be equal to the
+	`width` field of the `struct decoration`. If the `old` parameter
+	is not NULL and a there was already a value for the object, the
+	bytes of the old value are copied into `old`.  The return value
+	is `1` if there was a previous value, or `0` otherwise. Note
+	that if there is no previous value, then `old` is left
+	untouched; it is the responsibility of the caller to either
+	check the return value or to set a sentinel value in `old`.
+
+`lookup_decoration_value`::
+
+	Retrieve a decoration from the mapping. The return value is a
+	pointer to the sequence of bytes representing the value (of
+	length `width`), or `NULL` if no value is found.
+
+`add_decoration`::
+
+	Add a mapping from an object to a void pointer. If a previous
+	pointer exists for the object, it is returned; otherwise, `NULL`
+	is returned.
+
+`lookup_decoration`::
+
+	Retrieve a void pointer from the mapping. The return value is
+	the stored pointer, or `NULL` if there is no stored pointer.
+
+`decoration_slot`::
+
+	Retrieve the decoration stored at slot `i` in the hash table.
+	If the `base` field of the returned `struct object_decoration`
+	is `NULL`, then no value is stored at that slot. This function
+	is useful when iterating over the entire contents of the hash
+	table. See the iteration example below.
+
+
+Examples
+--------
+
+Store and retrieve pointers to structs:
+
+-------------------------------------------------------------------
+/* no need to set width parameter; it defaults to sizeof(void *) */
+static struct decoration commit_foos;
+
+void store_foo(const struct commit *c, const char *name)
+{
+	struct foo *value = alloc_foo(name);
+	struct foo *old;
+
+	old = add_decoration(&commit_foos, c->object, value);
+	free(old);
+}
+
+const struct foo *get_foo(const struct commit *c)
+{
+	return lookup_decoration(&commit_foos, c->object);
+}
+-------------------------------------------------------------------
+
+Store and retrieve `unsigned long` integers:
+
+-------------------------------------------------------------------
+static struct decoration longs = { "my longs", sizeof(unsigned long) };
+
+void store_long(const struct object *obj, unsigned long value)
+{
+	unsigned long old;
+	if (add_decoration_value(&longs, obj, &value, &old)
+		printf("old value was %lu\n", old);
+}
+
+void print_long(const struct object *obj)
+{
+	unsigned long *value = lookup_decoration_value(&longs, obj);
+	if (!value)
+		printf("no value\n");
+	else
+		printf("value is %lu\n", *value);
+}
+-------------------------------------------------------------------
+
+Iterate over all stored decorations:
+
+-------------------------------------------------------------------
+void dump_longs(void)
+{
+	int i;
+	for (i = 0; i < longs.size; i++) {
+		struct object_decoration *e = decoration_slot(&longs, i);
+		unsigned long *value = (unsigned long *)e->decoration;
+
+		/* empty hash slot */
+		if (!e->base)
+			continue;
+
+		printf("%s -> %lu\n", sha1_to_hex(e->base->sha1), *value);
+	}
+}
+-------------------------------------------------------------------
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index daf1945..82b458d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -59,7 +59,7 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 	return 0;
 }
 
-static struct decoration idnums;
+static struct decoration idnums = { NULL, sizeof(uint32_t) };
 static uint32_t last_idnum;
 
 static int has_unshown_parent(struct commit *commit)
@@ -73,20 +73,9 @@ static int has_unshown_parent(struct commit *commit)
 	return 0;
 }
 
-/* Since intptr_t is C99, we do not use it here */
-static inline uint32_t *mark_to_ptr(uint32_t mark)
-{
-	return ((uint32_t *)NULL) + mark;
-}
-
-static inline uint32_t ptr_to_mark(void * mark)
-{
-	return (uint32_t *)mark - (uint32_t *)NULL;
-}
-
 static inline void mark_object(struct object *object, uint32_t mark)
 {
-	add_decoration(&idnums, object, mark_to_ptr(mark));
+	add_decoration_value(&idnums, object, &mark, NULL);
 }
 
 static inline void mark_next_object(struct object *object)
@@ -96,10 +85,10 @@ static inline void mark_next_object(struct object *object)
 
 static int get_object_mark(struct object *object)
 {
-	void *decoration = lookup_decoration(&idnums, object);
-	if (!decoration)
+	uint32_t *mark = lookup_decoration_value(&idnums, object);
+	if (!mark)
 		return 0;
-	return ptr_to_mark(decoration);
+	return *mark;
 }
 
 static void show_progress(void)
@@ -537,8 +526,6 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 static void export_marks(char *file)
 {
 	unsigned int i;
-	uint32_t mark;
-	struct object_decoration *deco = idnums.hash;
 	FILE *f;
 	int e = 0;
 
@@ -547,15 +534,15 @@ static void export_marks(char *file)
 		die_errno("Unable to open marks file %s for writing.", file);
 
 	for (i = 0; i < idnums.size; i++) {
+		struct object_decoration *deco = decoration_slot(&idnums, i);
 		if (deco->base && deco->base->type == 1) {
-			mark = ptr_to_mark(deco->decoration);
-			if (fprintf(f, ":%"PRIu32" %s\n", mark,
+			uint32_t *mark = (uint32_t *)deco->decoration;
+			if (fprintf(f, ":%"PRIu32" %s\n", *mark,
 				sha1_to_hex(deco->base->sha1)) < 0) {
 			    e = 1;
 			    break;
 			}
 		}
-		deco++;
 	}
 
 	e |= ferror(f);
diff --git a/decorate.c b/decorate.c
index 2f8a63e..5a0747e 100644
--- a/decorate.c
+++ b/decorate.c
@@ -14,44 +14,48 @@ static unsigned int hash_obj(const struct object *obj, unsigned int n)
 	return hash % n;
 }
 
-static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
+static int insert_decoration(struct decoration *n, const struct object *base,
+			     const void *decoration, void *old)
 {
 	int size = n->size;
-	struct object_decoration *hash = n->hash;
+	unsigned long width = decoration_width(n);
 	unsigned int j = hash_obj(base, size);
 
-	while (hash[j].base) {
-		if (hash[j].base == base) {
-			void *old = hash[j].decoration;
-			hash[j].decoration = decoration;
-			return old;
+	while (1) {
+		struct object_decoration *e = decoration_slot(n, j);
+		if (!e->base) {
+			e->base = base;
+			memcpy(e->decoration, decoration, width);
+			n->nr++;
+			return 0;
+		}
+		if (e->base == base) {
+			if (old)
+				memcpy(old, e->decoration, width);
+			memcpy(e->decoration, decoration, width);
+			return 1;
 		}
 		if (++j >= size)
 			j = 0;
 	}
-	hash[j].base = base;
-	hash[j].decoration = decoration;
-	n->nr++;
-	return NULL;
 }
 
 static void grow_decoration(struct decoration *n)
 {
 	int i;
 	int old_size = n->size;
-	struct object_decoration *old_hash = n->hash;
+	unsigned char *old_hash = n->hash;
 
 	n->size = (old_size + 1000) * 3 / 2;
-	n->hash = xcalloc(n->size, sizeof(struct object_decoration));
+	n->hash = xcalloc(n->size, decoration_stride(n));
 	n->nr = 0;
 
 	for (i = 0; i < old_size; i++) {
-		const struct object *base = old_hash[i].base;
-		void *decoration = old_hash[i].decoration;
-
-		if (!base)
-			continue;
-		insert_decoration(n, base, decoration);
+		struct object_decoration *e =
+			(struct object_decoration *)
+			(old_hash + i * decoration_stride(n));
+		if (e->base)
+			insert_decoration(n, e->base, e->decoration, NULL);
 	}
 	free(old_hash);
 }
@@ -60,15 +64,35 @@ static void grow_decoration(struct decoration *n)
 void *add_decoration(struct decoration *n, const struct object *obj,
 		void *decoration)
 {
-	int nr = n->nr + 1;
+	void *old = NULL;
+	add_decoration_value(n, obj, &decoration, &old);
+	return old;
+}
 
+int add_decoration_value(struct decoration *n,
+			 const struct object *obj,
+			 const void *decoration,
+			 void *old)
+{
+	int nr = n->nr + 1;
 	if (nr > n->size * 2 / 3)
 		grow_decoration(n);
-	return insert_decoration(n, obj, decoration);
+	return insert_decoration(n, obj, decoration, old);
 }
 
 /* Lookup a decoration pointer */
-void *lookup_decoration(struct decoration *n, const struct object *obj)
+void *lookup_decoration(const struct decoration *n, const struct object *obj)
+{
+	void **v;
+
+	v = lookup_decoration_value(n, obj);
+	if (!v)
+		return NULL;
+	return *v;
+}
+
+void *lookup_decoration_value(const struct decoration *n,
+			      const struct object *obj)
 {
 	unsigned int j;
 
@@ -77,7 +101,7 @@ void *lookup_decoration(struct decoration *n, const struct object *obj)
 		return NULL;
 	j = hash_obj(obj, n->size);
 	for (;;) {
-		struct object_decoration *ref = n->hash + j;
+		struct object_decoration *ref = decoration_slot(n, j);
 		if (ref->base == obj)
 			return ref->decoration;
 		if (!ref->base)
diff --git a/decorate.h b/decorate.h
index e732804..c0e8e3f 100644
--- a/decorate.h
+++ b/decorate.h
@@ -3,16 +3,47 @@
 
 struct object_decoration {
 	const struct object *base;
-	void *decoration;
+	unsigned char decoration[FLEX_ARRAY];
 };
 
 struct decoration {
 	const char *name;
+	/* width of data we're holding; must be set before adding */
+	const unsigned int width;
 	unsigned int size, nr;
-	struct object_decoration *hash;
+	/*
+	 * The hash contains object_decoration structs, but we don't know their
+	 * size until runtime. So we store is as a pointer to characters to
+	 * make pointer arithmetic easier.
+	 */
+	unsigned char *hash;
 };
 
 extern void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
-extern void *lookup_decoration(struct decoration *n, const struct object *obj);
+extern void *lookup_decoration(const struct decoration *n, const struct object *obj);
+
+extern int add_decoration_value(struct decoration *n,
+				const struct object *obj,
+				const void *decoration,
+				void *old);
+extern void *lookup_decoration_value(const struct decoration *n,
+				     const struct object *obj);
+
+static inline unsigned long decoration_width(const struct decoration *n)
+{
+	return n->width ? n->width : sizeof(void *);
+}
+
+static inline unsigned long decoration_stride(const struct decoration *n)
+{
+	return sizeof(struct object_decoration) + decoration_width(n);
+}
+
+static inline struct object_decoration *decoration_slot(const struct decoration *n,
+							unsigned i)
+{
+	return (struct object_decoration *)
+		(n->hash + (i * decoration_stride(n)));
+}
 
 #endif
-- 
1.7.6.37.g989c6
