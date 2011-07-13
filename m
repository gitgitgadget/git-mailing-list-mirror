From: Jeff King <peff@peff.net>
Subject: [RFC/PATCHv2 2/6] add metadata-cache infrastructure
Date: Wed, 13 Jul 2011 03:04:05 -0400
Message-ID: <20110713070405.GB18566@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Wed Jul 13 09:05:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgtVd-0005uT-Pn
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758672Ab1GMHEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 03:04:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43212
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab1GMHEI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 03:04:08 -0400
Received: (qmail 21132 invoked by uid 107); 13 Jul 2011 07:04:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 03:04:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 03:04:05 -0400
Content-Disposition: inline
In-Reply-To: <20110713064709.GA18499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177001>

There is sometimes a need to cache some information about an
object or set of objects persistently across git
invocations. The notes-cache interface can be used for this,
but it is very heavyweight and slow for storing small
values.

This patch introduces a new API, metadata-cache, which
stores a mapping of objects to values in a concise and
efficient form. See the added API documentation for details.

Signed-off-by: Jeff King <peff@peff.net>
---
Many changes here:

  - name changed to metadata-cache

  - cache files have an actual header; I doubt they'll need to change
    much, but it's a lot nicer to have an actual version number to make
    sure it's valid

  - cache files have a 20-byte slot for a validity hash. See patch 5/6
    for an example of use.

  - the data width is stored in only one place, and is const; this gives
    us language support for code accidentally tweaking the width at
    run-time

  - initialization is now done by static initializer, and we lazily open
    the disk cache when requested. This is necessary because of the
    previous point, but it also makes client code simpler.

  - cached entries are automatically written out on program exit.
    Together with the above point, this makes client code very simple
    and natural. You just declare a static cache object, and then lookup
    and add to it as appropriate.

 Documentation/technical/api-decorate.txt       |    3 +
 Documentation/technical/api-metadata-cache.txt |  130 +++++++++
 Makefile                                       |    2 +
 metadata-cache.c                               |  337 ++++++++++++++++++++++++
 metadata-cache.h                               |   40 +++
 5 files changed, 512 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-metadata-cache.txt
 create mode 100644 metadata-cache.c
 create mode 100644 metadata-cache.h

diff --git a/Documentation/technical/api-decorate.txt b/Documentation/technical/api-decorate.txt
index b048b28..c761b45 100644
--- a/Documentation/technical/api-decorate.txt
+++ b/Documentation/technical/api-decorate.txt
@@ -13,6 +13,9 @@ could, for example, map objects into 32-bit integers. For ease of use,
 functions are provided for storing the values of arbitrary pointers,
 which can point to strings or structs.
 
+Note that the decorate API only stores the mapping in memory. See the
+metadata-cache API for persistent storage.
+
 Data Structures
 ---------------
 
diff --git a/Documentation/technical/api-metadata-cache.txt b/Documentation/technical/api-metadata-cache.txt
new file mode 100644
index 0000000..192a868
--- /dev/null
+++ b/Documentation/technical/api-metadata-cache.txt
@@ -0,0 +1,130 @@
+Metadata Cache API
+================
+
+The metadata cache API is meant to store a cache of per-object values.
+The aim is for robustness, speed, and simplicity. The stored data must
+be of a fixed size, and the only operations allowed are insertion and
+retrieval with a struct object as the key.
+
+This API is similar to the decorate API, but provides persistence of
+values across multiple invocations. It is also similar to the
+notes-cache API, but is much lighter weight and suitable for storing
+small values. If you are storing large, arbitrary data, consider using
+notes-cache.
+
+
+Storage
+-------
+
+Values are stored both on-disk and in-memory. Newly added values are
+initially stored in a hash table in memory, and written to disk
+automatically on program exit.
+
+The disk storage consists of a single file per cache, located in the
+`$GIT_DIR/cache` directory. See "File Format" below.
+
+When the cache is written to disk, the contents of the in-memory data
+and the disk data are merged, with in-memory values taking precedence
+over disk values. The data is written to a temporary file and atomically
+renamed into the new cache file. Thus there is no lock contention
+between competing processes on either reading or writing (though one
+process's updates may be lost).
+
+
+File Format
+-----------
+
+Cache files begin with a 32-byte header, consisting of:
+
+  - a 4-byte magic token, {'M', 'T', 'A', 'C' }.
+
+  - a 32-bit unsigned integer in network byte-order, indicating the
+    file format version; this document describes version 1.
+
+  - a 32-bit unsigned integer in network byte-order, indicating the
+    width in bytes of single stored data value.
+
+  - a 20-byte sequence indicating the "validity" of the cache; the
+    exact meaning of this value is specific to the type of cache. See
+    the section on "Validity" below.
+
+After the header, the file contains a sequence of key-value pairs, with
+no delimiters. The "key" of each pair is a 20-byte binary sha1. The
+value is a sequence of bytes of length `W`, where `W` is the width
+specified in the header.
+
+
+Cache Validity
+--------------
+
+The contents of a cache file may be valid only under a specific set of
+circumstances. The file header contains a 20-byte validity token which
+can be checked to ensure that the cache data is still valid. The data
+that goes into each token is specific to the type of cache. For example,
+a cache that summarizes information on the history graph would be valid
+only under a specific set of grafts and replace refs.
+
+
+Speed
+-----
+
+Lookup in the cache requires `O(lg(n))` hash comparisons (via binary
+search of the disk contents, or the in-memory hash table).
+
+Insertion into the cache is amortized `O(1)` via the hash table. Writing
+the cache to disk entails `O(n*lg(n) + m)` hash comparisons, where `m`
+is the number of existing disk entries and `n` is the number of newly
+added entries.
+
+
+Data Structures
+---------------
+
+`struct metadata_cache`::
+
+	This structure represents a single metadata cache (i.e., mapping
+	each object to a single fixed-size value). The cache should be
+	allocated in static storage and initialized using the
+	`METADATA_CACHE_INIT` macro. The lookup code will lazily open the
+	on-disk cache as necessary, and any values written by
+	`metadata_cache_add` will be automatically written to disk at
+	program exit.
++
+	The structure should be considered opaque by calling code.
+
+
+Functions
+---------
+
+`METADATA_CACHE_INIT`::
+
+	Static initializer for a metadata cache. The `name` parameter
+	specifies a human-readable name which will be used for storage
+	in `$GIT_DIR/cache/$name`. The `width` parameter specifies the
+	size, in units of `char`, of the data to be stored (e.g., use
+	`sizeof(uint32_t)` to store 32-bit integers). The `validity`
+	parameter is either NULL or a pointer to a function providing a
+	20-byte validity sha1.
+
+`metadata_cache_lookup`::
+
+	Retrieve a value from the object cache. A void pointer to the
+	stored value will be returned, or `NULL` if there is no value.
+
+`metadata_cache_add`::
+
+	Store a value in the object cache. The value pointer should
+	point to exactly `width` bytes of data.
+
+`metadata_cache_lookup_uint32`::
+
+	Convenience wrapper for retrieving unsigned 32-bit integers. The
+	value will be returned via the `value` pointer. The return value
+	is `0` if a value was found, or negative otherwise (in which
+	case the contents of `value` will be unchanged).
+
+`metadata_cache_add_uint32`::
+
+	Convenience wrapper for storing unsigned 32-bit integers. Note
+	that integers are stored on disk in network-byte order, so it is
+	safe to access caches from any architecture.
diff --git a/Makefile b/Makefile
index f8c72e1..d0b1376 100644
--- a/Makefile
+++ b/Makefile
@@ -532,6 +532,7 @@ LIB_H += log-tree.h
 LIB_H += mailmap.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
+LIB_H += metadata-cache.h
 LIB_H += notes.h
 LIB_H += notes-cache.h
 LIB_H += notes-merge.h
@@ -624,6 +625,7 @@ LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += metadata-cache.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
diff --git a/metadata-cache.c b/metadata-cache.c
new file mode 100644
index 0000000..e2e5ff8
--- /dev/null
+++ b/metadata-cache.c
@@ -0,0 +1,337 @@
+#include "cache.h"
+#include "metadata-cache.h"
+#include "sha1-lookup.h"
+#include "object.h"
+
+static struct metadata_cache **autowrite;
+static int autowrite_nr;
+static int autowrite_alloc;
+
+static int installed_atexit_autowriter;
+
+static int record_size(const struct metadata_cache *c)
+{
+	/* a record is a 20-byte sha1 plus the width of the value */
+	return c->mem.width + 20;
+}
+
+static const char *metadata_cache_path(const char *name)
+{
+	return git_path("cache/%s", name);
+}
+
+static void close_disk_cache(struct metadata_cache *c)
+{
+	if (c->map) {
+		munmap(c->map, c->maplen);
+		c->map = NULL;
+		c->maplen = 0;
+		c->disk_entries = 0;
+		c->disk_nr = 0;
+	}
+
+	if (c->fd >= 0) {
+		close(c->fd);
+		c->fd = -1;
+	}
+}
+
+static unsigned char *check_cache_header(struct metadata_cache *c,
+					 const char *path)
+{
+	unsigned char *p = c->map;
+	unsigned char validity[20];
+	uint32_t version;
+	uint32_t width;
+
+	if (c->maplen < 32) {
+		warning("cache file '%s' is short (%lu bytes)",
+			path, c->maplen);
+		return NULL;
+	}
+
+	if (memcmp(p, "MTAC", 4)) {
+		warning("cache file '%s' has invalid magic: %c%c%c%c",
+			path, p[0], p[1], p[2], p[3]);
+		return NULL;
+	}
+	p += 4;
+
+	version = ntohl(*(uint32_t *)p);
+	if (version != 1) {
+		warning("cache file '%s' has unknown version: %"PRIu32,
+			path, version);
+		return NULL;
+	}
+	p += 4;
+
+	width = ntohl(*(uint32_t *)p);
+	if (width != c->mem.width) {
+		warning("cache file '%s' does not have desired width: "
+			"(%"PRIu32" != %u", path, width, c->mem.width);
+		return NULL;
+	}
+	p += 4;
+
+	if (c->validity_fun) {
+		c->validity_fun(validity);
+		if (hashcmp(validity, p))
+			return NULL;
+	}
+	else {
+		if (!is_null_sha1(p))
+			return NULL;
+	}
+	p += 20;
+
+	return p;
+}
+
+static void open_disk_cache(struct metadata_cache *c, const char *path)
+{
+	struct stat sb;
+
+	c->fd = open(path, O_RDONLY);
+	if (c->fd < 0)
+		return;
+
+	if (fstat(c->fd, &sb) < 0) {
+		close_disk_cache(c);
+		return;
+	}
+
+	c->maplen = sb.st_size;
+	c->map = xmmap(NULL, c->maplen, PROT_READ, MAP_PRIVATE, c->fd, 0);
+
+	c->disk_entries = check_cache_header(c, path);
+	if (!c->disk_entries) {
+		close_disk_cache(c);
+		return;
+	}
+	c->disk_nr = (sb.st_size - (c->disk_entries - c->map)) / record_size(c);
+}
+
+static unsigned char *flatten_mem_entries(struct metadata_cache *c)
+{
+	int i;
+	unsigned char *ret;
+	int nr;
+
+	ret = xmalloc(c->mem.nr * record_size(c));
+	nr = 0;
+	for (i = 0; i < c->mem.size; i++) {
+		struct object_decoration *e = decoration_slot(&c->mem, i);
+		unsigned char *out;
+
+		if (!e->base)
+			continue;
+
+		if (nr == c->mem.nr)
+			die("BUG: decorate hash contained extra values");
+
+		out = ret + (nr * record_size(c));
+		hashcpy(out, e->base->sha1);
+		out += 20;
+		memcpy(out, e->decoration, c->mem.width);
+		nr++;
+	}
+
+	return ret;
+}
+
+static int void_hashcmp(const void *a, const void *b)
+{
+	return hashcmp(a, b);
+}
+
+static int write_header(int fd, struct metadata_cache *c)
+{
+	uint32_t width;
+	unsigned char validity[20];
+
+	if (write_in_full(fd, "MTAC\x00\x00\x00\x01", 8) < 0)
+		return -1;
+
+	width = htonl(c->mem.width);
+	if (write_in_full(fd, &width, 4) < 0)
+		return -1;
+
+	if (c->validity_fun)
+		c->validity_fun(validity);
+	else
+		hashcpy(validity, null_sha1);
+	if (write_in_full(fd, validity, 20) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int merge_entries(int fd, int size,
+			 const unsigned char *left, unsigned nr_left,
+			 const unsigned char *right, unsigned nr_right)
+{
+#define ADVANCE(name) \
+	do { \
+		name += size; \
+		nr_##name--; \
+	} while(0)
+#define WRITE_ENTRY(name) \
+	do { \
+		if (write_in_full(fd, name, size) < 0) \
+			return -1; \
+		ADVANCE(name); \
+	} while(0)
+
+	while (nr_left && nr_right) {
+		int cmp = hashcmp(left, right);
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
+static int metadata_cache_write(struct metadata_cache *c, const char *name)
+{
+	const char *path = metadata_cache_path(name);
+	struct strbuf tempfile = STRBUF_INIT;
+	int fd;
+	unsigned char *mem_entries;
+
+	if (!c->mem.nr)
+		return 0;
+
+	strbuf_addf(&tempfile, "%s.XXXXXX", path);
+	if (safe_create_leading_directories(tempfile.buf) < 0 ||
+	    (fd = git_mkstemp_mode(tempfile.buf, 0755)) < 0) {
+		strbuf_release(&tempfile);
+		return -1;
+	}
+
+	if (write_header(fd, c) < 0)
+		goto fail;
+
+	mem_entries = flatten_mem_entries(c);
+	qsort(mem_entries, c->mem.nr, record_size(c), void_hashcmp);
+
+	if (merge_entries(fd, record_size(c),
+			  mem_entries, c->mem.nr,
+			  c->disk_entries, c->disk_nr) < 0) {
+		free(mem_entries);
+		goto fail;
+	}
+	free(mem_entries);
+
+	if (close(fd) < 0)
+		goto fail;
+	if (rename(tempfile.buf, path) < 0)
+		goto fail;
+
+	strbuf_release(&tempfile);
+	return 0;
+
+fail:
+	close(fd);
+	unlink(tempfile.buf);
+	strbuf_release(&tempfile);
+	return -1;
+}
+static void autowrite_metadata_caches(void)
+{
+	int i;
+	for (i = 0; i < autowrite_nr; i++)
+		metadata_cache_write(autowrite[i], autowrite[i]->mem.name);
+}
+
+static void metadata_cache_init(struct metadata_cache *c)
+{
+	if (c->initialized)
+		return;
+
+	open_disk_cache(c, metadata_cache_path(c->mem.name));
+
+	ALLOC_GROW(autowrite, autowrite_nr+1, autowrite_alloc);
+	autowrite[autowrite_nr++] = c;
+	if (!installed_atexit_autowriter) {
+		atexit(autowrite_metadata_caches);
+		installed_atexit_autowriter = 1;
+	}
+
+	c->initialized = 1;
+}
+
+static void *lookup_disk(struct metadata_cache *c,
+			 const struct object *obj)
+{
+	int pos;
+
+	pos = sha1_entry_pos(c->disk_entries, record_size(c), 0,
+			     0, c->disk_nr, c->disk_nr, obj->sha1);
+	if (pos < 0)
+		return NULL;
+
+	return c->disk_entries + (pos * record_size(c)) + 20;
+}
+
+const void *metadata_cache_lookup(struct metadata_cache *c,
+				  const struct object *obj)
+{
+	void *r;
+
+	metadata_cache_init(c);
+
+	r = lookup_decoration_value(&c->mem, obj);
+	if (!r)
+		r = lookup_disk(c, obj);
+	return r;
+}
+
+void metadata_cache_add(struct metadata_cache *c, const struct object *obj,
+			const void *value)
+{
+	metadata_cache_init(c);
+	add_decoration_value(&c->mem, obj, value, NULL);
+}
+
+int metadata_cache_lookup_uint32(struct metadata_cache *c,
+				 const struct object *obj,
+				 uint32_t *value)
+{
+	const uint32_t *out;
+
+	if (record_size(c) != 24)
+		die("BUG: size mismatch in object cache lookup (%d != 24)",
+		    record_size(c));
+
+	out = metadata_cache_lookup(c, obj);
+	if (!out)
+		return -1;
+
+	*value = ntohl(*out);
+	return 0;
+}
+
+void metadata_cache_add_uint32(struct metadata_cache *c,
+			       const struct object *obj,
+			       uint32_t value)
+{
+	if (record_size(c) != 24)
+		die("BUG: size mismatch in object cache add (%d != 24)",
+		    record_size(c));
+
+	value = htonl(value);
+	metadata_cache_add(c, obj, &value);
+}
diff --git a/metadata-cache.h b/metadata-cache.h
new file mode 100644
index 0000000..5b761e1
--- /dev/null
+++ b/metadata-cache.h
@@ -0,0 +1,40 @@
+#ifndef METADATA_CACHE_H
+#define METADATA_CACHE_H
+
+#include "decorate.h"
+
+typedef void (*metadata_cache_validity_fun)(unsigned char out[20]);
+
+struct metadata_cache {
+	metadata_cache_validity_fun validity_fun;
+
+	/* in memory entries */
+	struct decoration mem;
+
+	/* mmap'd disk entries */
+	int fd;
+	unsigned char *map;
+	unsigned long maplen;
+	unsigned char *disk_entries;
+	int disk_nr;
+
+	int initialized;
+};
+
+#define METADATA_CACHE_INIT(name, width, validity) \
+	{ validity, { (name), (width) } }
+
+const void *metadata_cache_lookup(struct metadata_cache *,
+				  const struct object *);
+void metadata_cache_add(struct metadata_cache *, const struct object *,
+			const void *value);
+
+/* Convenience wrappers around metadata_cache_{lookup,add} */
+int metadata_cache_lookup_uint32(struct metadata_cache *,
+				 const struct object *,
+				 uint32_t *value);
+void metadata_cache_add_uint32(struct metadata_cache *,
+			       const struct object *,
+			       uint32_t value);
+
+#endif /* METADATA_CACHE_H */
-- 
1.7.6.37.g989c6
