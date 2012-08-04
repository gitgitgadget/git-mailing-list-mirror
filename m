From: Jeff King <peff@peff.net>
Subject: [PATCH 4/8] decorate: use "map" for the underlying implementation
Date: Sat, 4 Aug 2012 13:11:15 -0400
Message-ID: <20120804171115.GD19378@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:11:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxhsq-0003Iu-01
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 19:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab2HDRLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 13:11:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51683 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753769Ab2HDRLR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 13:11:17 -0400
Received: (qmail 2016 invoked by uid 107); 4 Aug 2012 17:11:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Aug 2012 13:11:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2012 13:11:15 -0400
Content-Disposition: inline
In-Reply-To: <20120804170905.GA19267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202884>

The decoration API maps objects to void pointers. This is a
subset of what the map API is capable of, so let's get rid
of the duplicate implementation.

We could just fix all callers of decorate to call the map
API directly. However, the map API is very generic since it
is meant to handle any type. In particular, it can't use
sentinel values like "NULL" to indicate "entry not found"
(since it doesn't know whether the type can represent such a
sentinel value), which makes the interface slightly more
complicated.

Instead, let's keep the existing decorate API as a wrapper
on top of map. No callers need to be updated at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-decorate.txt | 38 +++++++++++++-
 Makefile                                 |  3 ++
 decorate.c                               | 85 +++-----------------------------
 decorate.h                               | 10 ++--
 map-object-void-params.h                 |  6 +++
 map-object-void.c                        |  7 +++
 map-object-void.h                        |  8 +++
 7 files changed, 70 insertions(+), 87 deletions(-)
 create mode 100644 map-object-void-params.h
 create mode 100644 map-object-void.c
 create mode 100644 map-object-void.h

diff --git a/Documentation/technical/api-decorate.txt b/Documentation/technical/api-decorate.txt
index 1d52a6c..3c1197a 100644
--- a/Documentation/technical/api-decorate.txt
+++ b/Documentation/technical/api-decorate.txt
@@ -1,6 +1,40 @@
 decorate API
 ============
 
-Talk about <decorate.h>
+The decorate API is a system for efficiently mapping objects to values
+in memory. It is slightly slower than an actual member of an object
+struct (because it incurs a hash lookup), but it uses less memory when
+the mapping is not in use, or when the number of decorated objects is
+small compared to the total number of objects.
 
-(Linus)
+The decorate API is a special form of the `map` link:api-map.html[map
+API]. It has slightly simpler calling conventions, but only use objects
+as keys, and can only store void pointers as values.
+
+
+Data Structures
+---------------
+
+`struct decoration`::
+
+	This structure represents a single mapping of objects to values.
+	The `name` field is not used by the decorate API itself, but may
+	be used by calling code. The `map` field represents the actual
+	mapping of objects to void pointers (see the
+	link:api-map.html[map API] for details).
+
+
+Functions
+---------
+
+`add_decoration`::
+
+	Add a mapping from an object to a void pointer. If there was a
+	previous value for this object, the function returns this value;
+	otherwise, the function returns NULL.
+
+`lookup_decoration`::
+
+	Retrieve the stored value pointer for an object from the
+	mapping. The return value is the value pointer, or `NULL` if
+	there is no value for this object.
diff --git a/Makefile b/Makefile
index 1d29a95..7684a76 100644
--- a/Makefile
+++ b/Makefile
@@ -633,6 +633,8 @@ LIB_H += map-decl.h
 LIB_H += map-done.h
 LIB_H += map-impl.h
 LIB_H += map-init.h
+LIB_H += map-object-void-params.h
+LIB_H += map-object-void.h
 LIB_H += map-object.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
@@ -747,6 +749,7 @@ LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += mailmap.o
+LIB_OBJS += map-object-void.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
diff --git a/decorate.c b/decorate.c
index 2f8a63e..31e9656 100644
--- a/decorate.c
+++ b/decorate.c
@@ -1,88 +1,17 @@
-/*
- * decorate.c - decorate a git object with some arbitrary
- * data.
- */
 #include "cache.h"
-#include "object.h"
 #include "decorate.h"
 
-static unsigned int hash_obj(const struct object *obj, unsigned int n)
-{
-	unsigned int hash;
-
-	memcpy(&hash, obj->sha1, sizeof(unsigned int));
-	return hash % n;
-}
-
-static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
-{
-	int size = n->size;
-	struct object_decoration *hash = n->hash;
-	unsigned int j = hash_obj(base, size);
-
-	while (hash[j].base) {
-		if (hash[j].base == base) {
-			void *old = hash[j].decoration;
-			hash[j].decoration = decoration;
-			return old;
-		}
-		if (++j >= size)
-			j = 0;
-	}
-	hash[j].base = base;
-	hash[j].decoration = decoration;
-	n->nr++;
-	return NULL;
-}
-
-static void grow_decoration(struct decoration *n)
-{
-	int i;
-	int old_size = n->size;
-	struct object_decoration *old_hash = n->hash;
-
-	n->size = (old_size + 1000) * 3 / 2;
-	n->hash = xcalloc(n->size, sizeof(struct object_decoration));
-	n->nr = 0;
-
-	for (i = 0; i < old_size; i++) {
-		const struct object *base = old_hash[i].base;
-		void *decoration = old_hash[i].decoration;
-
-		if (!base)
-			continue;
-		insert_decoration(n, base, decoration);
-	}
-	free(old_hash);
-}
-
-/* Add a decoration pointer, return any old one */
 void *add_decoration(struct decoration *n, const struct object *obj,
-		void *decoration)
+		     void *decoration)
 {
-	int nr = n->nr + 1;
-
-	if (nr > n->size * 2 / 3)
-		grow_decoration(n);
-	return insert_decoration(n, obj, decoration);
+	void *ret = NULL;
+	map_set_object_void(&n->map, obj, decoration, &ret);
+	return ret;
 }
 
-/* Lookup a decoration pointer */
 void *lookup_decoration(struct decoration *n, const struct object *obj)
 {
-	unsigned int j;
-
-	/* nothing to lookup */
-	if (!n->size)
-		return NULL;
-	j = hash_obj(obj, n->size);
-	for (;;) {
-		struct object_decoration *ref = n->hash + j;
-		if (ref->base == obj)
-			return ref->decoration;
-		if (!ref->base)
-			return NULL;
-		if (++j == n->size)
-			j = 0;
-	}
+	void *ret = NULL;
+	map_get_object_void(&n->map, obj, &ret);
+	return ret;
 }
diff --git a/decorate.h b/decorate.h
index e732804..c58acbc 100644
--- a/decorate.h
+++ b/decorate.h
@@ -1,15 +1,11 @@
 #ifndef DECORATE_H
 #define DECORATE_H
 
-struct object_decoration {
-	const struct object *base;
-	void *decoration;
-};
+#include "map-object-void.h"
 
 struct decoration {
-	const char *name;
-	unsigned int size, nr;
-	struct object_decoration *hash;
+	char *name;
+	struct map_object_void map;
 };
 
 extern void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
diff --git a/map-object-void-params.h b/map-object-void-params.h
new file mode 100644
index 0000000..471fbdc
--- /dev/null
+++ b/map-object-void-params.h
@@ -0,0 +1,6 @@
+#define NAME object_void
+#define KEY_TYPE const struct object *
+#define VALUE_TYPE void *
+#define HASH hash_obj
+#define KEY_EQUAL obj_equal
+#define SENTINEL_NULL
diff --git a/map-object-void.c b/map-object-void.c
new file mode 100644
index 0000000..4934642
--- /dev/null
+++ b/map-object-void.c
@@ -0,0 +1,7 @@
+#include "cache.h"
+#include "map-object-void.h"
+
+#include "map-object.h"
+#include "map-object-void-params.h"
+#include "map-impl.h"
+#include "map-done.h"
diff --git a/map-object-void.h b/map-object-void.h
new file mode 100644
index 0000000..b4bc64d
--- /dev/null
+++ b/map-object-void.h
@@ -0,0 +1,8 @@
+#ifndef MAP_OBJECT_VOID_H
+#define MAP_OBJECT_VOID_H
+
+#include "map-object-void-params.h"
+#include "map-decl.h"
+#include "map-done.h"
+
+#endif /* MAP_OBJECT_VOID_H */
-- 
1.7.12.rc1.7.g7a223a6
