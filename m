From: Jeff King <peff@peff.net>
Subject: [PATCH 6/8] implement metadata cache subsystem
Date: Sat, 4 Aug 2012 13:11:46 -0400
Message-ID: <20120804171146.GF19378@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:11:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxhtK-0003sE-U4
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 19:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab2HDRLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 13:11:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51696 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612Ab2HDRLs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 13:11:48 -0400
Received: (qmail 2102 invoked by uid 107); 4 Aug 2012 17:11:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Aug 2012 13:11:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2012 13:11:46 -0400
Content-Disposition: inline
In-Reply-To: <20120804170905.GA19267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202887>

There are some calculations that git makes repeatedly, even
though the results are invariant for a certain input (e.g.,
the patch-id of a certain commit). We can make a space/time
tradeoff by caching these on disk between runs.

Even though these may be immutable for a certain commit, we
don't want to directly store the results in the commit
objects themselves, for a few reasons:

  1. They are not necessarily used by all algorithms, so
     bloating the commit object might slow down other
     algorithms.

  2. Because they can be calculated from the existing
     commits, they are redundant with the existing
     information. Thus they are an implementation detail of
     our current algorithms, and should not be cast in stone
     by including them in the commit sha1.

  3. They may only be immutable under a certain set of
     conditions (e.g., which grafts or replace refs we are
     using). Keeping the storage external means we can
     invalidate and regenerate the cache whenever those
     conditions change.

The persistent map API already provides the storage we need.
This new API takes care of the details of opening and
closing the cache files automatically. Callers need only get
and set values as they see fit.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-metadata-cache.txt |  67 ++++++++++
 Makefile                                       |   2 +
 metadata-cache.c                               | 169 +++++++++++++++++++++++++
 metadata-cache.h                               |   8 ++
 4 files changed, 246 insertions(+)
 create mode 100644 Documentation/technical/api-metadata-cache.txt
 create mode 100644 metadata-cache.c
 create mode 100644 metadata-cache.h

diff --git a/Documentation/technical/api-metadata-cache.txt b/Documentation/technical/api-metadata-cache.txt
new file mode 100644
index 0000000..5f4422d
--- /dev/null
+++ b/Documentation/technical/api-metadata-cache.txt
@@ -0,0 +1,67 @@
+metadata cache API
+==================
+
+The metadata cache API provides simple-to-use, persistent key/value
+storage. It is built on the link:api-map.html[map API], so keys and
+values can have any serializable type.
+
+Caches are statically allocated, and no explicit initialization is
+required.  Callers can simply call the "get" and "set" functions for a
+given cache.  At program exit, any new entries in the cache are flushed
+to disk.
+
+
+Defining a New Cache
+--------------------
+
+You need to provide three pieces of information to define a new cache:
+
+name::
+	This name will be used both as part of the C identifier and as
+	part of the filename under which the cache is stored. Restrict
+	the characters used to alphanumerics and underscore.
+
+map::
+	The type of map (declared by `DECLARE_MAP`) that this cache will
+	store.
+
+validity::
+	A function that will generate a 20-byte "validity token"
+	representing the conditions under which the cache is valid.
+	For example, a cache that depended on the structure of the
+	history graph would be valid only under a given set of grafts
+	and replace refs. That set could be stirred into a sha1 and used
+	as a validity token.
+
+You must declare the cache in metadata-cache.h using
+`DECLARE_METADATA_CACHE`, and then implement it in metadata-cache.c
+using `IMPLEMENT_METADATA_CACHE`.
+
+
+Using a Cache
+-------------
+
+Interaction with a cache consists entirely of getting and setting
+values. No initialization or cleanup is required. The get and set
+functions mirror their "map" counterparts; see the
+link:api-map.html[map API] for details.
+
+
+File Format
+-----------
+
+Cache files are stored in the $GIT_DIR/cache directory. Each cache gets
+its own directory, named after the `name` parameter in the cache
+definition. Within each directory is a set of files, one cache per file,
+named after their validity tokens. Caches for multiple sets of
+conditions can simultaneously exist, and git will use whichever is
+appropriate.
+
+The files themselves consist of an 8-byte header. The first four bytes
+are the magic sequence "MTAC" (for "MeTA Cache"), followed by a 4-byte
+version number, in network byte order. This document describes version
+1.
+
+The rest of the file consists of the persistent map data. This is a
+compact, sorted list of keys and values; see the link:api-map.html[map
+API] for details.
diff --git a/Makefile b/Makefile
index e38ae9e..08ddfa7 100644
--- a/Makefile
+++ b/Makefile
@@ -640,6 +640,7 @@ LIB_H += map-object.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
 LIB_H += mergesort.h
+LIB_H += metadata-cache.h
 LIB_H += notes-cache.h
 LIB_H += notes-merge.h
 LIB_H += notes.h
@@ -755,6 +756,7 @@ LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
+LIB_OBJS += metadata-cache.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
diff --git a/metadata-cache.c b/metadata-cache.c
new file mode 100644
index 0000000..94eabfb
--- /dev/null
+++ b/metadata-cache.c
@@ -0,0 +1,169 @@
+#include "cache.h"
+#include "metadata-cache.h"
+
+struct metadata_cache {
+	const char *name;
+	void (*attach)(unsigned char *buf, unsigned long len);
+	int (*flush)(int fd);
+	int (*empty)(void);
+	void (*validity)(unsigned char[20]);
+	int fd;
+	unsigned char *buf;
+	unsigned long len;
+	struct metadata_cache *next;
+	int initialized;
+};
+
+struct metadata_cache *caches;
+
+static const char *metadata_cache_path(struct metadata_cache *mc)
+{
+	unsigned char token[20];
+
+	if (mc->validity)
+		mc->validity(token);
+	else
+		hashcpy(token, null_sha1);
+	return git_path("cache/%s/%s", mc->name, sha1_to_hex(token));
+}
+
+static void write_one_cache(struct metadata_cache *mc)
+{
+	const char *path;
+	struct strbuf tempfile = STRBUF_INIT;
+	int fd = -1;
+
+	if (mc->empty())
+		return;
+
+	path = metadata_cache_path(mc);
+	strbuf_addf(&tempfile, "%s.XXXXXX", path);
+
+	if (safe_create_leading_directories(tempfile.buf) < 0)
+		goto fail;
+	fd = git_mkstemp_mode(tempfile.buf, 0444);
+	if (fd < 0)
+		goto fail;
+
+	if (write_in_full(fd, "MTAC\x00\x00\x00\x01", 8) < 0)
+		goto fail;
+	if (mc->flush(fd) < 0)
+		goto fail;
+	if (close(fd) < 0)
+		goto fail;
+	if (rename(tempfile.buf, path) < 0)
+		goto fail;
+
+	strbuf_release(&tempfile);
+	return;
+
+fail:
+	close(fd);
+	unlink(tempfile.buf);
+	strbuf_release(&tempfile);
+}
+
+static void write_all_caches(void)
+{
+	struct metadata_cache *mc;
+	for (mc = caches; mc; mc = mc->next)
+		write_one_cache(mc);
+}
+
+void metadata_cache_init(struct metadata_cache *mc)
+{
+	const char *path;
+	struct stat st;
+	const unsigned char *p;
+	uint32_t version;
+	int fd;
+
+	if (mc->initialized)
+		return;
+
+	if (!caches)
+		atexit(write_all_caches);
+	mc->next = caches;
+	caches = mc;
+	mc->initialized = 1;
+
+	path = metadata_cache_path(mc);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return;
+
+	if (fstat(fd, &st) < 0)
+		goto fail;
+	mc->len = st.st_size;
+	mc->buf = xmmap(NULL, mc->len, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!mc->buf)
+		goto fail;
+	close(fd);
+	fd = -1;
+
+	if (mc->len < 8) {
+		warning("cache '%s' is missing header", path);
+		goto fail;
+	}
+	p = mc->buf;
+	if (memcmp(p, "MTAC", 4)) {
+		warning("cache '%s' has invalid magic: %c%c%c%c",
+			path, p[0], p[1], p[2], p[3]);
+		goto fail;
+	}
+	p += 4;
+	memcpy(&version, p, 4);
+	version = ntohl(version);
+	if (version != 1) {
+		warning("cache '%s' has unknown version: %"PRIu32,
+			path, version);
+		goto fail;
+	}
+
+	mc->attach(mc->buf + 8, mc->len - 8);
+	return;
+
+fail:
+	close(fd);
+	if (mc->buf)
+		munmap(mc->buf, mc->len);
+	mc->buf = NULL;
+	mc->len = 0;
+}
+
+#define IMPLEMENT_CACHE(name, maptype, ktype, vtype) \
+static struct map_persist_sha1pair_uint32 name##_map; \
+\
+static void name##_cache_attach(unsigned char *buf, unsigned long len) \
+{ \
+	map_persist_attach_##maptype(&name##_map, buf, len); \
+} \
+\
+static int name##_cache_flush(int fd) \
+{ \
+	return map_persist_flush_##maptype(&name##_map, fd); \
+} \
+\
+static int name##_cache_empty(void) \
+{ \
+	return !name##_map.mem.nr; \
+} \
+\
+static struct metadata_cache name##_cache = { \
+	#name, \
+	name##_cache_attach, \
+	name##_cache_flush, \
+	name##_cache_empty, \
+}; \
+\
+int name##_cache_get(ktype key, vtype *value) \
+{ \
+	metadata_cache_init(&name##_cache); \
+	return map_persist_get_##maptype(&name##_map, key, value); \
+} \
+\
+void name##_cache_set(ktype key, vtype value) \
+{ \
+	metadata_cache_init(&name##_cache); \
+	map_persist_set_##maptype(&name##_map, key, value); \
+}
diff --git a/metadata-cache.h b/metadata-cache.h
new file mode 100644
index 0000000..4354023
--- /dev/null
+++ b/metadata-cache.h
@@ -0,0 +1,8 @@
+#ifndef METADATA_CACHE_H
+#define METADATA_CACHE_H
+
+#define DECLARE_CACHE(name, ktype, vtype) \
+int name##_cache_get(ktype, vtype *); \
+void name##_cache_set(ktype, vtype);
+
+#endif /* METADATA_CACHE_H */
-- 
1.7.12.rc1.7.g7a223a6
