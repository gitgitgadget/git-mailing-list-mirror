From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] decorate: use "map" for the underlying implementation
Date: Thu, 4 Aug 2011 16:46:08 -0600
Message-ID: <20110804224608.GC27912@sigill.intra.peff.net>
References: <20110804224354.GA27476@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 00:46:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp6gE-0006xl-6A
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 00:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab1HDWqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 18:46:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32919
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756057Ab1HDWqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 18:46:11 -0400
Received: (qmail 23395 invoked by uid 107); 4 Aug 2011 22:46:45 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 18:46:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 16:46:08 -0600
Content-Disposition: inline
In-Reply-To: <20110804224354.GA27476@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178770>

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
 Documentation/technical/api-decorate.txt |   38 +++++++++++++-
 decorate.c                               |   85 +++---------------------------
 decorate.h                               |   10 +---
 map.c                                    |    1 +
 map.h                                    |    1 +
 5 files changed, 48 insertions(+), 87 deletions(-)

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
index e732804..6a3adcd 100644
--- a/decorate.h
+++ b/decorate.h
@@ -1,15 +1,11 @@
 #ifndef DECORATE_H
 #define DECORATE_H
 
-struct object_decoration {
-	const struct object *base;
-	void *decoration;
-};
+#include "map.h"
 
 struct decoration {
-	const char *name;
-	unsigned int size, nr;
-	struct object_decoration *hash;
+	char *name;
+	struct map_object_void map;
 };
 
 extern void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
diff --git a/map.c b/map.c
index 1fdd1aa..73f45e0 100644
--- a/map.c
+++ b/map.c
@@ -86,3 +86,4 @@ int map_get_##name(struct map_##name *m, \
 }
 
 IMPLEMENT_MAP(object_uint32, obj_equal, hash_obj)
+IMPLEMENT_MAP(object_void, obj_equal, hash_obj)
diff --git a/map.h b/map.h
index 7449593..cb9aea6 100644
--- a/map.h
+++ b/map.h
@@ -24,5 +24,6 @@ extern int map_set_##name(struct map_##name *, \
 			  map_vtype_##name *old);
 
 DECLARE_MAP(object_uint32, const struct object *, uint32_t)
+DECLARE_MAP(object_void, const struct object *, void *)
 
 #endif /* MAP_H */
-- 
1.7.6.34.g86521e
