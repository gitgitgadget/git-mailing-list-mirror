From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] decorate: use "map" for the underlying implementation
Date: Thu, 14 Jul 2011 13:53:48 -0400
Message-ID: <20110714175348.GC21771@sigill.intra.peff.net>
References: <20110714173454.GA21657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 19:53:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQ6l-0002og-S6
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 19:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209Ab1GNRxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 13:53:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36425
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139Ab1GNRxu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 13:53:50 -0400
Received: (qmail 8856 invoked by uid 107); 14 Jul 2011 17:54:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 13:54:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 13:53:48 -0400
Content-Disposition: inline
In-Reply-To: <20110714173454.GA21657@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177143>

The decoration API maps objects to void pointers. This is a
subset of what the map API is capable of, so let's get rid
of the duplicate implementation.

We could just fix all callers of decorate to call the map
API directly. However, the map API is very generic since it
is meant to handle any type. In particular, it can't use
sentinel values like "NULL" to indicate "entry not found"
(since it doesn't know whether the type can represent such a
sentinel value).

Instead, the decorate API just becomes a set of wrappers,
and no callers need to be updated at all.

Signed-off-by: Jeff King <peff@peff.net>
---
The result should perform identically to the existing decorate code with
the exception of the extra "used" field, which makes each hash entry
bigger (see the comments in patch 1/3).

 decorate.c |  105 ++++++++++--------------------------------------------------
 decorate.h |   10 ++----
 map.c      |    1 +
 map.h      |    1 +
 4 files changed, 22 insertions(+), 95 deletions(-)
 rewrite decorate.c (89%)

diff --git a/decorate.c b/decorate.c
dissimilarity index 89%
index 2f8a63e..31e9656 100644
--- a/decorate.c
+++ b/decorate.c
@@ -1,88 +1,17 @@
-/*
- * decorate.c - decorate a git object with some arbitrary
- * data.
- */
-#include "cache.h"
-#include "object.h"
-#include "decorate.h"
-
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
-void *add_decoration(struct decoration *n, const struct object *obj,
-		void *decoration)
-{
-	int nr = n->nr + 1;
-
-	if (nr > n->size * 2 / 3)
-		grow_decoration(n);
-	return insert_decoration(n, obj, decoration);
-}
-
-/* Lookup a decoration pointer */
-void *lookup_decoration(struct decoration *n, const struct object *obj)
-{
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
-}
+#include "cache.h"
+#include "decorate.h"
+
+void *add_decoration(struct decoration *n, const struct object *obj,
+		     void *decoration)
+{
+	void *ret = NULL;
+	map_set_object_void(&n->map, obj, decoration, &ret);
+	return ret;
+}
+
+void *lookup_decoration(struct decoration *n, const struct object *obj)
+{
+	void *ret = NULL;
+	map_get_object_void(&n->map, obj, &ret);
+	return ret;
+}
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
index 28f885e..93e0364 100644
--- a/map.c
+++ b/map.c
@@ -86,3 +86,4 @@ int map_get_##name(struct map_##name *m, \
 }
 
 MAP_IMPLEMENT(object_uint32, struct object *, uint32_t, cmp_obj, hash_obj)
+MAP_IMPLEMENT(object_void, struct object *, void *, cmp_obj, hash_obj)
diff --git a/map.h b/map.h
index e80d85d..737054e 100644
--- a/map.h
+++ b/map.h
@@ -22,5 +22,6 @@ extern int map_set_##name(struct map_##name *, \
 			  vtype *old); \
 
 DECLARE_MAP(object_uint32, struct object *, uint32_t)
+DECLARE_MAP(object_void, struct object *, void *)
 
 #endif /* MAP_H */
-- 
1.7.6.38.ge5b33
