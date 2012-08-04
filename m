From: Jeff King <peff@peff.net>
Subject: [PATCH 5/8] map: implement persistent maps
Date: Sat, 4 Aug 2012 13:11:30 -0400
Message-ID: <20120804171130.GE19378@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:11:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxht8-0003f3-3t
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 19:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab2HDRLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 13:11:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51688 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612Ab2HDRLc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 13:11:32 -0400
Received: (qmail 2070 invoked by uid 107); 4 Aug 2012 17:11:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Aug 2012 13:11:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2012 13:11:30 -0400
Content-Disposition: inline
In-Reply-To: <20120804170905.GA19267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202886>

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
 .gitignore                          |   1 +
 Documentation/technical/api-map.txt |  77 +++++++++++++++++++
 Makefile                            |   1 +
 map-decl.h                          |  18 +++++
 map-impl.h                          | 148 ++++++++++++++++++++++++++++++++++++
 t/t0007-map.sh                      |  24 ++++++
 test-map-persist.c                  | 125 ++++++++++++++++++++++++++++++
 7 files changed, 394 insertions(+)
 create mode 100644 test-map-persist.c

diff --git a/.gitignore b/.gitignore
index c2bad89..14350f4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -185,6 +185,7 @@
 /test-index-version
 /test-line-buffer
 /test-map
+/test-map-persist
 /test-match-trees
 /test-mergesort
 /test-mktemp
diff --git a/Documentation/technical/api-map.txt b/Documentation/technical/api-map.txt
index f86b785..256bddf 100644
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
+use an in-core map for newly-added values, and then merge the new
+values into the flat storage on request.
+
+
 Defining New Map Types
 ----------------------
 
@@ -78,6 +93,39 @@ The following map defines are available:
 	optimization to shrink the size of each map entry, at the cost
 	of not being able to store `NULL` key pointers in the map.
 
+`PERSIST`::
+
+	Optional. If defined, functions for storing the map to disk are
+	also created.
+
+`KEY_SIZE`::
+
+	Required by `PERSIST`. The fixed-width size of the on-disk
+	representation of a key, in bytes.
+
+`VALUE_SIZE`::
+
+	Required by `PERSIST`. The fixed-width size of the on-disk
+	representation of a value, in bytes.
+
+`KEY_TO_DISK(KEY_ARG key, unsigned char *out)`::
+
+	Required by `PERSIST`. A function that will convert the
+	in-memory representation of a key into its on-disk
+	representation. Note that the reverse transformation does not
+	have to be possible.
+
+`VALUE_TO_DISK(VALUE_ARG value, unsigned char *out)`::
+
+	Required by `PERSIST`. A function that will convert the
+	in-memory representation of a value into its on-disk
+	representation.
+
+`DISK_TO_VALUE(unsigned char *in, VALUE_TYPE *value)`::
+
+	Required by `PERSIST`. A function that will convert the on-disk
+	representation of a value into its in-memory representation.
+
 
 Data Structures
 ---------------
@@ -104,6 +152,14 @@ Each defined map type will have its own structure (e.g., `map_object_uint32`).
 	need to use this type directly, unless you are enumerating all
 	elements of a map.
 
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
@@ -127,6 +183,27 @@ Each defined map type will have its own set of access functions (e.g.,
 	defined, the key and value are passed in as `const KEY_TYPE *`
 	and `const VALUE_TYPE *`, respectively.
 
+`map_persist_get_NAME(struct map_persist_NAME *, KEY_TYPE key, VALUE_TYPE *value)`::
+
+	Same as `map_get_NAME`, but for a persistent map.
+
+`map_persist_set_NAME(struct map_persist_NAME *, KEY_TYPE key, VALUE_TYPE value)`::
+
+	Same as `map_set_name`, but for a persistent map. It does
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
diff --git a/Makefile b/Makefile
index 7684a76..e38ae9e 100644
--- a/Makefile
+++ b/Makefile
@@ -492,6 +492,7 @@ TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-map
+TEST_PROGRAMS_NEED_X += test-map-persist
 TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
diff --git a/map-decl.h b/map-decl.h
index 7d4daaf..1ba7157 100644
--- a/map-decl.h
+++ b/map-decl.h
@@ -20,3 +20,21 @@ extern int THIS(map_set)(struct THIS(map) *,
 			 KEY_ARG key,
 			 VALUE_ARG value,
 			 VALUE_TYPE *old);
+
+#ifdef PERSIST
+struct THIS(map_persist) {
+	const unsigned char *disk_entries;
+	unsigned int disk_nr;
+	struct THIS(map) mem;
+};
+extern int THIS(map_persist_get)(struct THIS(map_persist) *,
+				 KEY_ARG key,
+				 VALUE_TYPE *value);
+extern int THIS(map_persist_set)(struct THIS(map_persist) *,
+				 KEY_ARG key,
+				 VALUE_ARG value);
+extern void THIS(map_persist_attach)(struct THIS(map_persist) *,
+				     const unsigned char *buf,
+				     unsigned int len);
+extern int THIS(map_persist_flush)(struct THIS(map_persist) *, int fd);
+#endif
diff --git a/map-impl.h b/map-impl.h
index 844b7f1..c44d0a0 100644
--- a/map-impl.h
+++ b/map-impl.h
@@ -92,3 +92,151 @@ int THIS(map_get)(struct THIS(map) *m,
 	}
 	return 0;
 }
+
+#ifdef PERSIST
+static const unsigned char *THIS(disk_lookup)(const unsigned char *buf, int nr,
+					      int ksize, int vsize,
+					      const unsigned char *key)
+{
+	unsigned lo = 0, hi = nr;
+
+	do {
+		unsigned mi = (lo + hi) / 2;
+		const unsigned char *e = buf + mi * (ksize + vsize);
+		int cmp = memcmp(key, e, ksize);
+
+		if (!cmp)
+			return e + ksize;
+		if (cmp < 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	} while (lo < hi);
+
+	return NULL;
+}
+
+int THIS(map_persist_get)(struct THIS(map_persist) *m,
+			  KEY_ARG key,
+			  VALUE_TYPE *value)
+{
+	unsigned char disk_key[KEY_SIZE];
+	const unsigned char *disk_value;
+
+	if (THIS(map_get)(&m->mem, key, value))
+		return 1;
+
+	if (!m->disk_entries)
+		return 0;
+
+	KEY_TO_DISK(key, disk_key);
+	disk_value = THIS(disk_lookup)(m->disk_entries, m->disk_nr,
+				       KEY_SIZE, VALUE_SIZE, disk_key);
+	if (disk_value) {
+		DISK_TO_VALUE(disk_value, value);
+		return 1;
+	}
+
+	return 0;
+}
+
+int THIS(map_persist_set)(struct THIS(map_persist) *m,
+			  KEY_ARG key,
+			  VALUE_ARG value)
+{
+	return THIS(map_set)(&m->mem, key, value, NULL);
+}
+
+void THIS(map_persist_attach)(struct THIS(map_persist) *m,
+			      const unsigned char *buf,
+			      unsigned int len)
+{
+	m->disk_entries = buf;
+	m->disk_nr = len / (KEY_SIZE + VALUE_SIZE);
+}
+
+static unsigned char *THIS(flatten_mem)(struct THIS(map_persist) *m)
+{
+	unsigned char *ret, *out;
+	int i, nr;
+
+	out = ret = xmalloc(m->mem.nr * (KEY_SIZE + VALUE_SIZE));
+	nr = 0;
+	for (i = 0; i < m->mem.size; i++) {
+		struct THIS(map_entry) *e = m->mem.hash + i;
+
+		if (!hash_used(e))
+			continue;
+
+		if (nr++ == m->mem.nr)
+			die("BUG: map hash contained extra values");
+
+		KEY_TO_DISK(key_ref(e->key), out);
+		out += KEY_SIZE;
+		VALUE_TO_DISK(value_ref(e->value), out);
+		out += VALUE_SIZE;
+	}
+
+	if (nr != m->mem.nr)
+		die("BUG: map hash had fewer values than claimed");
+
+	return ret;
+}
+
+static int THIS(keycmp)(const void *a, const void *b)
+{
+	return memcmp(a, b, KEY_SIZE);
+}
+
+static int THIS(merge_entries)(int fd,
+			       const unsigned char *left, unsigned nr_left,
+			       const unsigned char *right, unsigned nr_right)
+{
+#define ADVANCE(name) \
+	do { \
+		name += KEY_SIZE + VALUE_SIZE; \
+		nr_##name--; \
+	} while (0)
+#define WRITE_ENTRY(name) \
+	do { \
+		if (write_in_full(fd, name, KEY_SIZE + VALUE_SIZE) < 0) \
+			return -1; \
+		ADVANCE(name); \
+	} while (0)
+
+	while (nr_left && nr_right) {
+		int cmp = THIS(keycmp)(left, right);
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
+int THIS(map_persist_flush)(struct THIS(map_persist) *m, int fd)
+{
+	unsigned char *mem_entries;
+	int r;
+
+	mem_entries = THIS(flatten_mem)(m);
+	qsort(mem_entries, m->mem.nr, KEY_SIZE + VALUE_SIZE, THIS(keycmp));
+
+	r = THIS(merge_entries)(fd, mem_entries, m->mem.nr,
+				m->disk_entries, m->disk_nr);
+	free(mem_entries);
+	return r;
+}
+#endif
diff --git a/t/t0007-map.sh b/t/t0007-map.sh
index b5845f4..14187d6 100755
--- a/t/t0007-map.sh
+++ b/t/t0007-map.sh
@@ -47,4 +47,28 @@ for type in pointer struct; do
 	"
 done
 
+test_expect_success 'put some items in a persistent map' '
+	test-map-persist foo d:4 a:1 c:3 b:2
+'
+
+test_expect_success 'retrieve persistent items' '
+	cat >expect <<-\EOF &&
+	c: 3
+	a: 1
+	e: not found
+	EOF
+	test-map-persist foo c a e >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'new entries override disk entries' '
+	cat >expect <<-\EOF &&
+	c: 3
+	a: 5
+	e: not found
+	EOF
+	test-map-persist foo a:5 c a e >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/test-map-persist.c b/test-map-persist.c
new file mode 100644
index 0000000..1334cdd
--- /dev/null
+++ b/test-map-persist.c
@@ -0,0 +1,125 @@
+#include "cache.h"
+
+static const char usage_msg[] =
+"test-map-persist <file> [keys]";
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
+static inline void string_to_disk(const char *s, unsigned char *out)
+{
+	/*
+	 * we need a fixed-width representation, so let's just store 10 bytes,
+	 * padded with zeroes
+	 */
+	int len = strlen(s);
+	if (len > 10)
+		len = 10;
+	memcpy(out, s, len);
+	memset(out + len, 0, 10 - len);
+}
+
+static inline void uint32_to_disk(uint32_t v, unsigned char *out)
+{
+	v = htonl(v);
+	memcpy(out, &v, 4);
+}
+
+static inline void disk_to_uint32(const unsigned char *in, uint32_t *v)
+{
+	memcpy(v, in, 4);
+	*v = ntohl(*v);
+}
+
+#define NAME string_uint32
+#define PERSIST
+#define KEY_TYPE const char *
+#define KEY_SIZE 10
+#define KEY_TO_DISK string_to_disk
+#define KEY_EQUAL string_equal
+#define HASH hash_string
+#define DISK_LOOKUP_FUN lookup_string
+#define SENTINEL_NULL
+#define VALUE_TYPE uint32_t
+#define VALUE_SIZE 4
+#define VALUE_TO_DISK uint32_to_disk
+#define DISK_TO_VALUE disk_to_uint32
+#include "map-decl.h"
+#include "map-impl.h"
+#include "map-done.h"
+
+static void open_map(const char *path, struct map_persist_string_uint32 *m)
+{
+	int fd;
+	struct stat sb;
+	const unsigned char *buf;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return;
+
+	fstat(fd, &sb);
+	buf = xmmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	map_persist_attach_string_uint32(m, buf, sb.st_size);
+}
+
+static void flush_map(const char *path, struct map_persist_string_uint32 *m)
+{
+	char tmp[1024];
+	int fd;
+
+	snprintf(tmp, sizeof(tmp), "%s.tmp", path);
+	fd = open(tmp, O_WRONLY|O_CREAT, 0666);
+	if (fd < 0)
+		die_errno("unable to open '%s' for writing", tmp);
+	if (map_persist_flush_string_uint32(m, fd) < 0 || close(fd) < 0)
+		die_errno("unable to write new map");
+	if (rename(tmp, path) < 0)
+		die_errno("unable to rename new map into place");
+}
+
+int main(int argc, const char **argv)
+{
+	struct map_persist_string_uint32 m = {0};
+	const char *path;
+	const char *spec;
+
+	argv++;
+	path = *argv++;
+	if (!path)
+		usage(usage_msg);
+
+	open_map(path, &m);
+
+	while ((spec = *argv++)) {
+		char *colon = strchr(spec, ':');
+		if (colon) {
+			*colon++ = '\0';
+			map_persist_set_string_uint32(&m, spec, atoi(colon));
+		}
+		else {
+			uint32_t value;
+			if (map_persist_get_string_uint32(&m, spec, &value))
+				printf("%s: %d\n", spec, value);
+			else
+				printf("%s: not found\n", spec);
+		}
+	}
+
+	flush_map(path, &m);
+
+	return 0;
+}
-- 
1.7.12.rc1.7.g7a223a6
