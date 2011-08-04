From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] implement metadata cache subsystem
Date: Thu, 4 Aug 2011 16:46:48 -0600
Message-ID: <20110804224647.GE27912@sigill.intra.peff.net>
References: <20110804224354.GA27476@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 00:46:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp6gq-0007GQ-4l
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 00:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab1HDWqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 18:46:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32925
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab1HDWqv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 18:46:51 -0400
Received: (qmail 23453 invoked by uid 107); 4 Aug 2011 22:47:25 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 18:47:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 16:46:48 -0600
Content-Disposition: inline
In-Reply-To: <20110804224354.GA27476@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178772>

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
 Documentation/technical/api-metadata-cache.txt |   67 +++++++++++++
 Makefile                                       |    2 +
 metadata-cache.c                               |  126 ++++++++++++++++++++++++
 metadata-cache.h                               |   10 ++
 4 files changed, 205 insertions(+), 0 deletions(-)
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
index acda5b8..3b39538 100644
--- a/Makefile
+++ b/Makefile
@@ -536,6 +536,7 @@ LIB_H += mailmap.h
 LIB_H += map.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
+LIB_H += metadata-cache.h
 LIB_H += notes.h
 LIB_H += notes-cache.h
 LIB_H += notes-merge.h
@@ -629,6 +630,7 @@ LIB_OBJS += map.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += metadata-cache.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
diff --git a/metadata-cache.c b/metadata-cache.c
new file mode 100644
index 0000000..e217db1
--- /dev/null
+++ b/metadata-cache.c
@@ -0,0 +1,126 @@
+#include "cache.h"
+#include "metadata-cache.h"
+#include "map.h"
+
+static const char *metadata_cache_path(const char *name,
+				       void (*validity)(unsigned char [20]))
+{
+	unsigned char token[20];
+
+	if (validity)
+		validity(token);
+	else
+		hashcpy(token, null_sha1);
+	return git_path("cache/%s/%s", name, sha1_to_hex(token));
+}
+
+#define IMPLEMENT_METADATA_CACHE(name, map, validity) \
+static struct map_persist_##map name##_map; \
+static int name##_fd; \
+static unsigned char *name##_buf; \
+static unsigned long name##_len; \
+\
+static void write_##name##_cache(void) \
+{ \
+	const char *path; \
+	struct strbuf tempfile = STRBUF_INIT; \
+	int fd = -1; \
+\
+	if (!name##_map.mem.nr) \
+		return; \
+\
+	path = metadata_cache_path(#name, validity); \
+	strbuf_addf(&tempfile, "%s.XXXXXX", path); \
+\
+	if (safe_create_leading_directories(tempfile.buf) < 0) \
+		goto fail; \
+	fd = git_mkstemp_mode(tempfile.buf, 0444); \
+	if (fd < 0) \
+		goto fail; \
+\
+	if (write_in_full(fd, "MTAC\x00\x00\x00\x01", 8) < 0) \
+		goto fail; \
+	if (map_persist_flush_##map(&name##_map, fd) < 0) \
+		goto fail; \
+	if (close(fd) < 0) \
+		goto fail; \
+	if (rename(tempfile.buf, path) < 0) \
+		goto fail; \
+\
+	strbuf_release(&tempfile); \
+	return; \
+\
+fail: \
+	close(fd); \
+	unlink(tempfile.buf); \
+	strbuf_release(&tempfile); \
+} \
+\
+static void init_##name##_cache(void) \
+{ \
+	static int initialized; \
+	const char *path; \
+	struct stat sb; \
+	const unsigned char *p; \
+	uint32_t version; \
+\
+	if (initialized) \
+		return; \
+\
+	atexit(write_##name##_cache); \
+	initialized = 1; \
+\
+	path = metadata_cache_path(#name, validity); \
+	name##_fd = open(path, O_RDONLY); \
+	if (name##_fd < 0) \
+		return; \
+\
+	if (fstat(name##_fd, &sb) < 0) \
+		goto fail; \
+	name##_len = sb.st_size; \
+	name##_buf = xmmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, \
+				 name##_fd, 0); \
+\
+	if (name##_len < 8) { \
+		warning("cache '%s' is missing header", path); \
+		goto fail; \
+	} \
+	p = name##_buf; \
+	if (memcmp(p, "MTAC", 4)) { \
+		warning("cache '%s' has invalid magic: %c%c%c%c", \
+			path, p[0], p[1], p[2], p[3]); \
+		goto fail; \
+	} \
+	p += 4; \
+	memcpy(&version, p, 4); \
+	version = ntohl(version); \
+	if (version != 1) { \
+		warning("cache '%s' has unknown version: %"PRIu32, \
+			path, version); \
+		goto fail; \
+	} \
+\
+	map_persist_attach_##map(&name##_map, \
+				     name##_buf + 8, \
+				     name##_len - 8); \
+	return; \
+\
+fail: \
+	close(name##_fd); \
+	name##_fd = -1; \
+	if (name##_buf) \
+		munmap(name##_buf, name##_len); \
+	name##_buf = NULL; \
+	name##_len = 0; \
+} \
+\
+int name##_cache_get(map_ktype_##map key, map_vtype_##map *value) \
+{ \
+	init_##name##_cache(); \
+	return map_persist_get_##map(&name##_map, key, value); \
+} \
+int name##_cache_set(map_ktype_##map key, map_vtype_##map value) \
+{ \
+	init_##name##_cache(); \
+	return map_persist_set_##map(&name##_map, key, value); \
+}
diff --git a/metadata-cache.h b/metadata-cache.h
new file mode 100644
index 0000000..851a4eb
--- /dev/null
+++ b/metadata-cache.h
@@ -0,0 +1,10 @@
+#ifndef METADATA_CACHE_H
+#define METADATA_CACHE_H
+
+#include "map.h"
+
+#define DECLARE_METADATA_CACHE(name, map) \
+extern int name##_cache_get(map_ktype_##map key, map_vtype_##map *value); \
+extern int name##_cache_set(map_ktype_##map key, map_vtype_##map value);
+
+#endif /* METADATA_CACHE_H */
-- 
1.7.6.34.g86521e
