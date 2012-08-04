From: Jeff King <peff@peff.net>
Subject: [PATCH 7/8] implement rename cache
Date: Sat, 4 Aug 2012 13:12:32 -0400
Message-ID: <20120804171232.GG19378@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:12:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxhu3-0004Uf-2v
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 19:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805Ab2HDRMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 13:12:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51700 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729Ab2HDRMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 13:12:34 -0400
Received: (qmail 2132 invoked by uid 107); 4 Aug 2012 17:12:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Aug 2012 13:12:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2012 13:12:32 -0400
Content-Disposition: inline
In-Reply-To: <20120804170905.GA19267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202888>

This just stores pairs of sha1s mapped to their similarity scores.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                     |  5 +++++
 cache.h                      |  5 +++++
 map-sha1pair-uint32-params.h | 12 ++++++++++++
 map-sha1pair-uint32.c        |  8 ++++++++
 map-sha1pair-uint32.h        |  8 ++++++++
 map-sha1pair.h               | 22 ++++++++++++++++++++++
 map-uint32.h                 | 16 ++++++++++++++++
 metadata-cache.c             |  3 +++
 metadata-cache.h             |  2 ++
 9 files changed, 81 insertions(+)
 create mode 100644 map-sha1pair-uint32-params.h
 create mode 100644 map-sha1pair-uint32.c
 create mode 100644 map-sha1pair-uint32.h
 create mode 100644 map-sha1pair.h
 create mode 100644 map-uint32.h

diff --git a/Makefile b/Makefile
index 08ddfa7..f020994 100644
--- a/Makefile
+++ b/Makefile
@@ -637,6 +637,10 @@ LIB_H += map-init.h
 LIB_H += map-object-void-params.h
 LIB_H += map-object-void.h
 LIB_H += map-object.h
+LIB_H += map-sha1pair-uint32-params.h
+LIB_H += map-sha1pair-uint32.h
+LIB_H += map-sha1pair.h
+LIB_H += map-uint32.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
 LIB_H += mergesort.h
@@ -752,6 +756,7 @@ LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += map-object-void.o
+LIB_OBJS += map-sha1pair-uint32.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
diff --git a/cache.h b/cache.h
index 67f28b4..23a2f93 100644
--- a/cache.h
+++ b/cache.h
@@ -677,6 +677,11 @@ static inline int is_empty_blob_sha1(const unsigned char *sha1)
 	return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
 }
 
+struct sha1pair {
+	unsigned char one[20];
+	unsigned char two[20];
+};
+
 int git_mkstemp(char *path, size_t n, const char *template);
 
 int git_mkstemps(char *path, size_t n, const char *template, int suffix_len);
diff --git a/map-sha1pair-uint32-params.h b/map-sha1pair-uint32-params.h
new file mode 100644
index 0000000..74c6506
--- /dev/null
+++ b/map-sha1pair-uint32-params.h
@@ -0,0 +1,12 @@
+#define NAME sha1pair_uint32
+#define PERSIST
+#define KEY_TYPE struct sha1pair
+#define PASS_KEY_BY_REF
+#define KEY_EQUAL sha1pair_equal
+#define KEY_SIZE 40
+#define KEY_TO_DISK sha1pair_to_disk
+#define HASH hash_sha1pair
+#define VALUE_TYPE uint32_t
+#define VALUE_SIZE 4
+#define VALUE_TO_DISK uint32_to_disk
+#define DISK_TO_VALUE disk_to_uint32
diff --git a/map-sha1pair-uint32.c b/map-sha1pair-uint32.c
new file mode 100644
index 0000000..93b3c16
--- /dev/null
+++ b/map-sha1pair-uint32.c
@@ -0,0 +1,8 @@
+#include "cache.h"
+#include "map-sha1pair-uint32.h"
+
+#include "map-sha1pair.h"
+#include "map-uint32.h"
+#include "map-sha1pair-uint32-params.h"
+#include "map-impl.h"
+#include "map-done.h"
diff --git a/map-sha1pair-uint32.h b/map-sha1pair-uint32.h
new file mode 100644
index 0000000..6e022fb
--- /dev/null
+++ b/map-sha1pair-uint32.h
@@ -0,0 +1,8 @@
+#ifndef MAP_SHA1PAIR_UINT32_H
+#define MAP_SHA1PAIR_UINT32_H
+
+#include "map-sha1pair-uint32-params.h"
+#include "map-decl.h"
+#include "map-done.h"
+
+#endif /* MAP_SHA1PAIR_UINT32_H */
diff --git a/map-sha1pair.h b/map-sha1pair.h
new file mode 100644
index 0000000..ea7ead8
--- /dev/null
+++ b/map-sha1pair.h
@@ -0,0 +1,22 @@
+#ifndef MAP_SHA1PAIR_H
+#define MAP_SHA1PAIR_H
+
+static inline unsigned int hash_sha1pair(const struct sha1pair *k, unsigned int n)
+{
+	unsigned int hash;
+	memcpy(&hash, k, sizeof(unsigned int));
+	return hash % n;
+}
+
+static inline int sha1pair_equal(const struct sha1pair *a, const struct sha1pair *b)
+{
+	return !hashcmp(a->one, b->one) && !hashcmp(a->two, b->two);
+}
+
+static inline void sha1pair_to_disk(const struct sha1pair *v, unsigned char *out)
+{
+	hashcpy(out, v->one);
+	hashcpy(out+20, v->two);
+}
+
+#endif /* MAP_SHA1PAIR_H */
diff --git a/map-uint32.h b/map-uint32.h
new file mode 100644
index 0000000..ce63dac
--- /dev/null
+++ b/map-uint32.h
@@ -0,0 +1,16 @@
+#ifndef MAP_UINT32_H
+#define MAP_UINT32_H
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
+#endif /* MAP_UINT32_H */
diff --git a/metadata-cache.c b/metadata-cache.c
index 94eabfb..d70d116 100644
--- a/metadata-cache.c
+++ b/metadata-cache.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "metadata-cache.h"
+#include "map-sha1pair-uint32.h"
 
 struct metadata_cache {
 	const char *name;
@@ -167,3 +168,5 @@ void name##_cache_set(ktype key, vtype value) \
 	metadata_cache_init(&name##_cache); \
 	map_persist_set_##maptype(&name##_map, key, value); \
 }
+
+IMPLEMENT_CACHE(rename, sha1pair_uint32, const struct sha1pair *, uint32_t)
diff --git a/metadata-cache.h b/metadata-cache.h
index 4354023..f3e6f51 100644
--- a/metadata-cache.h
+++ b/metadata-cache.h
@@ -5,4 +5,6 @@
 int name##_cache_get(ktype, vtype *); \
 void name##_cache_set(ktype, vtype);
 
+DECLARE_CACHE(rename, const struct sha1pair *, uint32_t)
+
 #endif /* METADATA_CACHE_H */
-- 
1.7.12.rc1.7.g7a223a6
