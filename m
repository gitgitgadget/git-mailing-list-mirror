From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] map: implement persistent maps
Date: Thu, 4 Aug 2011 16:46:27 -0600
Message-ID: <20110804224627.GD27912@sigill.intra.peff.net>
References: <20110804224354.GA27476@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 00:46:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp6gV-00076j-Ti
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 00:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab1HDWqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 18:46:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32922
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab1HDWqa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 18:46:30 -0400
Received: (qmail 23424 invoked by uid 107); 4 Aug 2011 22:47:04 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 18:47:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 16:46:27 -0600
Content-Disposition: inline
In-Reply-To: <20110804224354.GA27476@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178771>

It's sometimes useful to keep a mapping across program
invocations (e.g., because a space/time tradeoff makes it
worth keeping a cache of calculated metadata for some
objects).

This adds a persistent version of the map API which can be
backed by a flat memory store (like an mmap'd file). By
itself, it's not very pleasant to use, as the caller is
responsible for actually opening and mapping files. But it
provides the building blocks for disk caches, which will
come in the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-map.txt |  132 +++++++++++++++++++++++++++++
 map.c                               |  157 +++++++++++++++++++++++++++++++++++
 map.h                               |   17 ++++
 3 files changed, 306 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-map.txt b/Documentation/technical/api-map.txt
index 97e5a32..8ac0cc0 100644
--- a/Documentation/technical/api-map.txt
+++ b/Documentation/technical/api-map.txt
@@ -25,6 +25,21 @@ The decorate API provides a similar interface to map, but is restricted to
 using "struct object" as the key, and a void pointer as the value.
 
 
+Persistent Maps
+---------------
+
+Maps come in two flavors: persistent and in-core. In-core maps are
+represented by a hash table, and can contain any C type. Persistent maps
+are backed by flat storage, such as an mmap'd file, and store values
+between program runs. Key and value types must be serializable to
+fixed-width byte values.
+
+The flat storage is a sorted array of key/value pairs, with no
+delimiters between pairs or between elements of a pair.  Persistent maps
+uses an in-core map for newly-added values, and then merge the new
+values into the flat storage on request.
+
+
 Defining New Map Types
 ----------------------
 
@@ -50,6 +65,32 @@ define a new type, you must use the `DECLARE_MAP` macro in `map.h`, and the
 	should specify a function that will convert an object of type `ktype`
 	into an integer hash value.
 
+To define a persistent map, use these macros instead:
+
+`DECLARE_MAP_PERSIST`::
+
+	Declare a new persistent map. The `name` parameter must match a
+	map declared already with `DECLARE_MAP`.
+
+`IMPLEMENT_MAP_PERSIST`::
+
+	Create function definitions for a persistent map. The `name`
+	parameter must match one given to `DECLARE_MAP_PERSIST`.  The
+	`ksize` and `vsize` parameters indicate the size, in bytes, of
+	serialized keys and values.
++
+	The `k_to_disk` and `v_to_disk` parameters specify functions to
+	convert keys and values to their serialized formats; they take a
+	key (or value), and a pointer to memory of at least `ksize` (or
+	`vsize`) bytes to write into. The `disk_to_v` parameter
+	specifies a function to convert a pointer to `vsize` bytes of
+	serialized value into a `vtype`.
++
+	The `disk_lookup_fun` parameter should specify a function for
+	performing a search of the sorted flat disk array (it is given
+	the array, the number of elements, the size of the key and
+	value, and the key to lookup).
+
 Several convenience functions are provided to fill in macro parameters:
 
 `hash_obj`::
@@ -60,6 +101,26 @@ Several convenience functions are provided to fill in macro parameters:
 
 	Suitable for `equal_fun` when the key type is `struct object *`.
 
+`obj_to_disk`::
+
+	Suitable for `k_to_disk` when the key type is `struct object *`.
+
+`uint32_to_disk`::
+
+	Suitable for `k_to_disk` or `v_to_disk` when the type is
+	`uint32_t`. Integers are serialized in network byte order for
+	portability.
+
+`disk_to_uint32`::
+
+	Suitable for `disk_to_v` when the value type is `uint32_t`.
+	Integers are converted back to host byte order.
+
+`disk_lookup_sha1`::
+
+	Suitable for disk_lookup_fun when the serialized keys are sha1
+	hashes.
+
 
 Data Structures
 ---------------
@@ -83,6 +144,14 @@ Each defined map type will have its own structure (e.g., `map_object_uint32`).
 	single mapped pair.  You should never need to use this type directly,
 	unless you are enumerating all elements of a map.
 
+`struct map_persist_NAME`::
+
+	A persistent map. This struct should be initialized to
+	all-zeroes. The `map` field contains a complete in-core map. The
+	`disk_entries` and `disk_nr` fields specify the flat storage.
+	These should not be set directly, but rather through the
+	`attach` function.
+
 
 Functions
 ---------
@@ -102,6 +171,27 @@ Each defined map type will have its own set of access function (e.g.,
 	existed, the previous value is copied into `old` (if it is non-NULL)
 	and the function returns 1. Otherwise, the function returns 0.
 
+`map_persist_get_NAME(struct map_persist_NAME *, const ktype key, vtype *value)`::
+
+	Same as `map_get_NAME`, but for a persistent map.
+
+`map_persist_set_NAME(struct map_persist_NAME *, const ktype key, vtype value)`::
+
+	Same as `map_set_name`, but for a persistent map. It also does
+	not provide the "old" value for the key.
+
+`map_persist_attach_NAME`::
+
+	Attach storage from `buf` of size `len` bytes as the flat
+	backing store for the map. The map does not copy the storage;
+	the caller is responsible for making sure it stays around as
+	long as the map does.
+
+`map_persist_flush_NAME`::
+
+	Merge in-core entries with those found in the backing store, and
+	write the result to `fd`. Returns 0 for success, -1 for failure.
+
 
 Examples
 --------
@@ -158,3 +248,45 @@ void dump_foos(void)
 	}
 }
 -------------------------------------------------------------------
+
+Open and close a disk-backed persistent map of objects to 32-bit
+integers:
+
+-------------------------------------------------------------------
+static int fd;
+static const unsigned char *buf;
+static unsigned len;
+static struct map_persist_object_uint32 map;
+
+void open_map(const char *path)
+{
+	struct stat sb;
+	const unsigned char *p;
+
+	fd = open(path, O_RDONLY);
+	/* it's ok not to attach any backing store at all */
+	if (fd < 0)
+		return;
+
+	fstat(fd, &sb);
+	len = sb.st_size;
+	buf = xmmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, 0);
+
+	map_persist_attach_object_uint32(&map, buf, len);
+}
+
+/* other functions call "get" and "set" */
+
+void close_map(const char *path, const char *tmp)
+{
+	int tmpfd;
+
+	tmpfd = open(tmp, O_RDONLY);
+	if (map_persist_flush_object_uint32(&map, tmpfd) < 0)
+		die_errno("unable to write new map");
+	close(tmpfd);
+	rename(tmp, path);
+
+	munmap(buf, len);
+	close(fd);
+}
diff --git a/map.c b/map.c
index 73f45e0..bb0d60a 100644
--- a/map.c
+++ b/map.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "map.h"
 #include "object.h"
+#include "sha1-lookup.h"
 
 static unsigned int hash_obj(const struct object *obj, unsigned int n)
 {
@@ -15,6 +16,74 @@ static int obj_equal(const struct object *a, const struct object *b)
 	return a == b;
 }
 
+static void obj_to_disk(const struct object *obj, unsigned char *out)
+{
+	hashcpy(out, obj->sha1);
+}
+
+static void uint32_to_disk(uint32_t v, unsigned char *out)
+{
+	v = htonl(v);
+	memcpy(out, &v, 4);
+}
+
+static void disk_to_uint32(const unsigned char *disk, uint32_t *out)
+{
+	memcpy(out, disk, 4);
+	*out = ntohl(*out);
+}
+
+static const unsigned char *disk_lookup_sha1(const unsigned char *buf,
+					     unsigned nr,
+					     unsigned ksize, unsigned vsize,
+					     const unsigned char *key)
+{
+	int pos;
+
+	pos = sha1_entry_pos(buf, ksize + vsize, 0, 0, nr, nr, key);
+	if (pos < 0)
+		return NULL;
+	return buf + (pos * (ksize + vsize)) + ksize;
+}
+
+static int merge_entries(int fd, int ksize, int vsize,
+			 const unsigned char *left, unsigned nr_left,
+			 const unsigned char *right, unsigned nr_right)
+{
+#define ADVANCE(name) \
+	do { \
+		name += ksize + vsize; \
+		nr_##name--; \
+	} while (0)
+#define WRITE_ENTRY(name) \
+	do { \
+		if (write_in_full(fd, name, ksize + vsize) < 0) \
+			return -1; \
+		ADVANCE(name); \
+	} while (0)
+
+	while (nr_left && nr_right) {
+		int cmp = memcmp(left, right, ksize);
+
+		/* skip duplicates, preferring left to right */
+		if (cmp == 0)
+			ADVANCE(right);
+		else if (cmp < 0)
+			WRITE_ENTRY(left);
+		else
+			WRITE_ENTRY(right);
+	}
+	while (nr_left)
+		WRITE_ENTRY(left);
+	while (nr_right)
+		WRITE_ENTRY(right);
+
+#undef WRITE_ENTRY
+#undef ADVANCE
+
+	return 0;
+}
+
 #define IMPLEMENT_MAP(name, equal_fun, hash_fun) \
 static int map_insert_##name(struct map_##name *m, \
 			     const map_ktype_##name key, \
@@ -85,5 +154,93 @@ int map_get_##name(struct map_##name *m, \
 	return 0; \
 }
 
+#define IMPLEMENT_MAP_PERSIST(name, \
+			      ksize, k_to_disk, \
+			      vsize, v_to_disk, disk_to_v, \
+			      disk_lookup_fun) \
+int map_persist_get_##name(struct map_persist_##name *m, \
+			   const map_ktype_##name key, \
+			   map_vtype_##name *value) \
+{ \
+	unsigned char disk_key[ksize]; \
+	const unsigned char *disk_value; \
+\
+	if (map_get_##name(&m->mem, key, value)) \
+		return 1; \
+\
+	if (!m->disk_entries) \
+		return 0; \
+\
+	k_to_disk(key, disk_key); \
+	disk_value = disk_lookup_fun(m->disk_entries, m->disk_nr, \
+				     ksize, vsize, disk_key); \
+	if (disk_value) { \
+		disk_to_v(disk_value, value); \
+		return 1; \
+	} \
+\
+	return 0; \
+} \
+\
+int map_persist_set_##name(struct map_persist_##name *m, \
+			   const map_ktype_##name key, \
+			   map_vtype_##name value) \
+{ \
+	return map_set_##name(&m->mem, key, value, NULL); \
+} \
+\
+static unsigned char *flatten_mem_entries_##name(struct map_persist_##name *m) \
+{ \
+	unsigned char *ret, *out; \
+	int i, nr; \
+\
+	out = ret = xmalloc(m->mem.nr * (ksize + vsize)); \
+	nr = 0; \
+	for (i = 0; i < m->mem.size; i++) { \
+		struct map_entry_##name *e = m->mem.hash + i; \
+\
+		if (!e->used) \
+			continue; \
+\
+		if (nr == m->mem.nr) \
+			die("BUG: map hash contained extra values"); \
+\
+		k_to_disk(e->key, out); \
+		out += ksize; \
+		v_to_disk(e->value, out); \
+		out += vsize; \
+	} \
+\
+	return ret; \
+} \
+\
+void map_persist_attach_##name(struct map_persist_##name *m, \
+			       const unsigned char *buf, \
+			       unsigned int len) \
+{ \
+	m->disk_entries = buf; \
+	m->disk_nr = len / (ksize + vsize); \
+} \
+\
+static int keycmp_##name(const void *a, const void *b) \
+{ \
+	return memcmp(a, b, ksize); \
+} \
+\
+int map_persist_flush_##name(struct map_persist_##name *m, int fd) \
+{ \
+	unsigned char *mem_entries; \
+	int r; \
+\
+	mem_entries = flatten_mem_entries_##name(m); \
+	qsort(mem_entries, m->mem.nr, ksize + vsize, keycmp_##name); \
+\
+	r = merge_entries(fd, ksize, vsize, \
+			  mem_entries, m->mem.nr, \
+			  m->disk_entries, m->disk_nr); \
+	free(mem_entries); \
+	return r; \
+}
+
 IMPLEMENT_MAP(object_uint32, obj_equal, hash_obj)
 IMPLEMENT_MAP(object_void, obj_equal, hash_obj)
diff --git a/map.h b/map.h
index cb9aea6..ceddc14 100644
--- a/map.h
+++ b/map.h
@@ -23,6 +23,23 @@ extern int map_set_##name(struct map_##name *, \
 			  map_vtype_##name value, \
 			  map_vtype_##name *old);
 
+#define DECLARE_MAP_PERSIST(name) \
+struct map_persist_##name { \
+	struct map_##name mem; \
+	const unsigned char *disk_entries; \
+	unsigned int disk_nr; \
+}; \
+extern int map_persist_get_##name(struct map_persist_##name *, \
+			  const map_ktype_##name key, \
+			  map_vtype_##name *value); \
+extern int map_persist_set_##name(struct map_persist_##name *, \
+			  const map_ktype_##name key, \
+			  map_vtype_##name value); \
+extern void map_persist_attach_##name(struct map_persist_##name *, \
+				      const unsigned char *buf, \
+				      unsigned int len); \
+extern int map_persist_flush_##name(struct map_persist_##name *, int fd);
+
 DECLARE_MAP(object_uint32, const struct object *, uint32_t)
 DECLARE_MAP(object_void, const struct object *, void *)
 
-- 
1.7.6.34.g86521e
