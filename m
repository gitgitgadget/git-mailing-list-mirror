From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] add object-cache infrastructure
Date: Mon, 11 Jul 2011 12:17:54 -0400
Message-ID: <20110711161754.GB10418@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 18:18:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgJBJ-0007aD-VH
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 18:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758046Ab1GKQR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 12:17:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39505
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754482Ab1GKQR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 12:17:56 -0400
Received: (qmail 2775 invoked by uid 107); 11 Jul 2011 16:18:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jul 2011 12:18:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2011 12:17:54 -0400
Content-Disposition: inline
In-Reply-To: <20110711161332.GA10057@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176863>

There is sometimes a need to cache some information about an
object or set of objects persistently across git
invocations. The notes-cache interface can be used for this,
but it is very heavyweight and slow for storing small
values.

This patch introduces a new API, object-cache, which stores
a mapping of objects to values in a concise and efficient
form. See the added API documentation for details.

Signed-off-by: Jeff King <peff@peff.net>
---
As I mentioned earlier, I wanted this to be generic and size-agnostic,
because I'd also like to try caching patch-ids for git-cherry.

 Documentation/technical/api-decorate.txt     |    3 +
 Documentation/technical/api-object-cache.txt |  101 +++++++++++++
 Makefile                                     |    2 +
 object-cache.c                               |  204 ++++++++++++++++++++++++++
 object-cache.h                               |   32 ++++
 5 files changed, 342 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-object-cache.txt
 create mode 100644 object-cache.c
 create mode 100644 object-cache.h

diff --git a/Documentation/technical/api-decorate.txt b/Documentation/technical/api-decorate.txt
index 8d10b66..c851f59 100644
--- a/Documentation/technical/api-decorate.txt
+++ b/Documentation/technical/api-decorate.txt
@@ -13,6 +13,9 @@ could, for example, map objects into 32-bit integers. For ease of use,
 functions are provided for storing the values of arbitrary pointers,
 which can point to strings or structs.
 
+Note that the decorate API only stores the mapping in memory. See the
+object-cache API for persistent storage.
+
 Data Structures
 ---------------
 
diff --git a/Documentation/technical/api-object-cache.txt b/Documentation/technical/api-object-cache.txt
new file mode 100644
index 0000000..ecead4c
--- /dev/null
+++ b/Documentation/technical/api-object-cache.txt
@@ -0,0 +1,101 @@
+Object Cache API
+================
+
+The object cache API is meant to store a cache of per-object values. The
+aim is for robustness, speed, and simplicity. The stored data must be of
+a fixed size, and the only operations allowed are insertion and
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
+initially stored in a hash table in memory, and written to disk only
+when `object_cache_write` is called.
+
+The disk storage consists of a single file per cache, located in the
+`$GIT_DIR/cache` directory. Each file contains a list of rows ordered by
+sha1. Each row contains a binary sha1, followed by the fixed-size data
+mapped to that sha1.
+
+When the cache is written to disk, the contents of the in-memory data
+and the disk data are merged, with in-memory values taking precedence
+over disk values. The data is written to a temporary file and atomically
+renamed into the new cache file. Thus there is no lock contention
+between competing processes on either reading or writing (though one
+process's updates may be lost).
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
+`struct object_cache`::
+
+	This structure represents a single object cache. Its contents
+	should be considered opaque by calling code.
++
+	The `fd`, `disk_entries`, `disk_nr`, and `record_size` fields
+	represent the mmap'd on-disk data. The `mem` field represents
+	the in-memory data (see the decorate API for details).
+
+
+Functions
+---------
+
+`object_cache_init`::
+
+	Initialize a new object cache; this must be called before any
+	other functions are called on the cache. The `name` parameter
+	specifies a human-readable name which will be used for storage
+	in `$GIT_DIR/cache/$name`. The `width` parameter specifies the
+	size, in units of `char`, of the data to be stored (e.g., pass
+	in `sizeof(uint32_t)` to store 32-bit integers).
+
+`object_cache_lookup`::
+
+	Retrieve a value from the object cache. A void pointer to the
+	stored value will be returned, or `NULL` if there is no value.
+
+`object_cache_add`::
+
+	Store a value in the object cache. The value pointer should
+	point to exactly `width` bytes of data.
+
+`object_cache_write`::
+
+	Merge the in-memory and existing disk entries, and write the
+	resulting cache to disk, under the name `$GIT_DIR/cache/$name`.
+	If no in-memory entries exist, the on-disk cache will be left
+	unchanged.
+
+`object_cache_lookup_uint32`::
+
+	Convenience wrapper for retrieving unsigned 32-bit integers. The
+	value will be returned via the `value` pointer. The return value
+	is `0` if a value was found, or negative otherwise (in which
+	case the contents of `value` will be unchanged).
+
+`object_cache_add_uint32`::
+
+	Convenience wrapper for storing unsigned 32-bit integers. Note
+	that integers are stored on disk in network-byte order, so it is
+	safe to access caches from any architecture.
diff --git a/Makefile b/Makefile
index f8c72e1..dd05579 100644
--- a/Makefile
+++ b/Makefile
@@ -535,6 +535,7 @@ LIB_H += merge-recursive.h
 LIB_H += notes.h
 LIB_H += notes-cache.h
 LIB_H += notes-merge.h
+LIB_H += object-cache.h
 LIB_H += object.h
 LIB_H += pack.h
 LIB_H += pack-refs.h
@@ -628,6 +629,7 @@ LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
+LIB_OBJS += object-cache.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-refs.o
diff --git a/object-cache.c b/object-cache.c
new file mode 100644
index 0000000..d019f0a
--- /dev/null
+++ b/object-cache.c
@@ -0,0 +1,204 @@
+#include "cache.h"
+#include "object-cache.h"
+#include "sha1-lookup.h"
+#include "object.h"
+
+static const char *object_cache_path(const char *name)
+{
+	return git_path("cache/%s", name);
+}
+
+static void open_disk_cache(struct object_cache *c, const char *path)
+{
+	struct stat sb;
+
+	c->fd = open(path, O_RDONLY);
+	if (c->fd < 0)
+		return;
+
+	if (fstat(c->fd, &sb) < 0) {
+		close(c->fd);
+		c->fd = -1;
+		return;
+	}
+
+	c->disk_entries = xmmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE,
+				c->fd, 0);
+	c->disk_nr = sb.st_size / c->record_size;
+}
+
+void object_cache_init(struct object_cache *c, const char *name, int width)
+{
+	memset(c, 0, sizeof(*c));
+	c->record_size = 20 + width;
+	c->mem.width = width;
+	open_disk_cache(c, object_cache_path(name));
+}
+
+static void *lookup_disk(const struct object_cache *c,
+			 const struct object *obj)
+{
+	int pos;
+
+	pos = sha1_entry_pos(c->disk_entries, c->record_size, 0,
+			     0, c->disk_nr, c->disk_nr, obj->sha1);
+	if (pos < 0)
+		return NULL;
+
+	return c->disk_entries + (pos * c->record_size) + 20;
+}
+
+const void *object_cache_lookup(const struct object_cache *c,
+					 const struct object *obj)
+{
+	void *r;
+
+	r = lookup_decoration_value(&c->mem, obj);
+	if (!r)
+		r = lookup_disk(c, obj);
+	return r;
+}
+
+void object_cache_add(struct object_cache *c, const struct object *obj,
+		      const void *value)
+{
+	add_decoration_value(&c->mem, obj, value, NULL);
+}
+
+static unsigned char *flatten_mem_entries(struct object_cache *c)
+{
+	unsigned char *p;
+	unsigned char *ret;
+	int nr;
+
+	ret = xmalloc(c->mem.nr * c->record_size);
+	nr = 0;
+	for (p = c->mem.hash; p < c->mem.end; p += c->mem.stride) {
+		struct object_decoration *e = (struct object_decoration *)p;
+		unsigned char *out;
+
+		if (!e->base)
+			continue;
+
+		if (nr == c->mem.nr)
+			die("BUG: decorate hash contained extra values");
+
+		out = ret + (nr * c->record_size);
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
+int object_cache_write(struct object_cache *c, const char *name)
+{
+	const char *path = object_cache_path(name);
+	struct strbuf tempfile = STRBUF_INIT;
+	int fd;
+	unsigned char *mem_entries;
+	int i, j;
+	int r;
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
+	mem_entries = flatten_mem_entries(c);
+	qsort(mem_entries, c->mem.nr, c->record_size, void_hashcmp);
+
+#define WRITE_ENTRY(e) \
+do { \
+	if (write_in_full(fd, e, c->record_size) < 0) { \
+		close(fd); \
+		unlink(tempfile.buf); \
+		strbuf_release(&tempfile); \
+		free(mem_entries); \
+		return -1; \
+	} \
+} while (0)
+
+	i = j = 0;
+	while (i < c->mem.nr && j < c->disk_nr) {
+		unsigned char *mem = mem_entries + (i * c->record_size);
+		unsigned char *disk = c->disk_entries + (j * c->record_size);
+		int cmp = hashcmp(mem, disk);
+
+		/* replace disk entries with in-memory ones */
+		if (cmp == 0)
+			j++;
+		else if (cmp < 0) {
+			WRITE_ENTRY(mem);
+			i++;
+		}
+		else {
+			WRITE_ENTRY(disk);
+			j++;
+		}
+	}
+	while (i < c->mem.nr) {
+		unsigned char *mem = mem_entries + (i * c->record_size);
+		WRITE_ENTRY(mem);
+		i++;
+	}
+	while (j < c->disk_nr) {
+		unsigned char *disk = c->disk_entries + (j * c->record_size);
+		WRITE_ENTRY(disk);
+		j++;
+	}
+#undef WRITE_ENTRY
+
+	free(mem_entries);
+
+	if (close(fd) < 0 || rename(tempfile.buf, path) < 0)
+		r = -1;
+	else
+		r = 0;
+
+	unlink(tempfile.buf);
+	strbuf_release(&tempfile);
+	return r;
+}
+
+int object_cache_lookup_uint32(const struct object_cache *c,
+			       const struct object *obj,
+			       uint32_t *value)
+{
+	const uint32_t *out;
+
+	if (c->record_size != 24)
+		die("BUG: size mismatch in object cache lookup (%d != 24)",
+		    c->record_size);
+
+	out = object_cache_lookup(c, obj);
+	if (!out)
+		return -1;
+
+	*value = ntohl(*out);
+	return 0;
+}
+
+void object_cache_add_uint32(struct object_cache *c,
+			     const struct object *obj,
+			     uint32_t value)
+{
+	if (c->record_size != 24)
+		die("BUG: size mismatch in object cache add (%d != 24)",
+		    c->record_size);
+
+	value = htonl(value);
+	object_cache_add(c, obj, &value);
+}
diff --git a/object-cache.h b/object-cache.h
new file mode 100644
index 0000000..b869f1e
--- /dev/null
+++ b/object-cache.h
@@ -0,0 +1,32 @@
+#ifndef OBJECT_CACHE_H
+#define OBJECT_CACHE_H
+
+#include "decorate.h"
+
+struct object_cache {
+	/* mmap'd disk entries */
+	int fd;
+	unsigned char *disk_entries;
+	int disk_nr;
+	int record_size;
+
+	/* in memory entries */
+	struct decoration mem;
+};
+
+void object_cache_init(struct object_cache *, const char *name, int width);
+const void *object_cache_lookup(const struct object_cache *,
+				const struct object *);
+void object_cache_add(struct object_cache *, const struct object *,
+		      const void *value);
+int object_cache_write(struct object_cache *, const char *name);
+
+/* Convenience wrappers around object_cache_{lookup,add} */
+int object_cache_lookup_uint32(const struct object_cache *,
+			       const struct object *,
+			       uint32_t *value);
+void object_cache_add_uint32(struct object_cache *,
+			     const struct object *,
+			     uint32_t value);
+
+#endif /* OBJECT_CACHE_H */
-- 
1.7.6.37.g989c6
