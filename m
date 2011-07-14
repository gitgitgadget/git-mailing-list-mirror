From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] implement generic key/value map
Date: Thu, 14 Jul 2011 13:51:05 -0400
Message-ID: <20110714175105.GA21771@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Thu Jul 14 19:51:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQ4B-0001Hx-5R
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 19:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288Ab1GNRvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 13:51:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53262
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168Ab1GNRvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 13:51:07 -0400
Received: (qmail 8770 invoked by uid 107); 14 Jul 2011 17:51:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 13:51:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 13:51:05 -0400
Content-Disposition: inline
In-Reply-To: <20110714173454.GA21657@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177141>

It is frequently useful to have a fast, generic data
structure mapping keys to values. We already have something
like this in the "decorate" API, but it has two downsides:

  1. The key type must always be a "struct object *".

  2. The value type is a void pointer, which means it is
     inefficient and cumbersome for storing small values.
     One must either encode their value inside the void
     pointer, or allocate additional storage for the pointer
     to point to.

This patch introduces a generic map data structure, mapping
keys of arbitrary type to values of arbitrary type.

One possible strategy for implementation is to have a struct
that points to a sequence of bytes for each of the key and
the value, and to try to treat them as opaque in the code.
However, this code gets complex, has a lot of casts, and
runs afoul of violating alignment and strict aliasing rules.

This patch takes a different approach. We parameterize the
types in each map by putting the declarations and
implementations inside macros, and expand the macros with
the correct types. This lets the compiler see the actual
code, with its real types, and figure out things like struct
packing and alignment itself.

Signed-off-by: Jeff King <peff@peff.net>
---
In addition to switching from using void pointers to macro expansion,
this has one other difference from my previous patch: it handles
arbitrary types for keys, not just object pointers. This was mentioned
by Jakub, and would allow things like a fast bi-directional map for SVN
revision numbers and commits.

I tried to keep the implementation simple. Two things that could be changed:

  1. We can't assume that the map key is a pointer. So the sentinel
     "NULL" value isn't necessarily available to use, and we have to
     keep a separate bit in each hash entry to say "is this valid".
     This means when we _do_ store a pointer, we end up with an extra
     32 bits or so in each hash entry for the "used" flag.

     We could add a macro parameter for sentinel values, so that types
     which _can_ handle this efficiently don't have to pay the price.
     Or we could decide that mapping arbitrary keys isn't worth the
     hassle. I wrote this way to be flexible for future use; I don't
     personally have plans to add svn revision number mappings.

  2. It assumes values are assignable. That means storing something like
     "unsigned char sha1[20]" doesn't work. You can wrap it in a struct,
     but do we assume that struct assignment works everywhere? I didn't
     check, but I think it is in C89 but some antique compilers didn't
     allow it. Switching it to use memcpy() would be easy enough (or
     again, parameterizing so that assignable things don't have to pay
     the price).

 Makefile |    2 +
 map.c    |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 map.h    |   24 +++++++++++++++++
 3 files changed, 112 insertions(+), 0 deletions(-)
 create mode 100644 map.c
 create mode 100644 map.h

diff --git a/Makefile b/Makefile
index 46793d1..6242321 100644
--- a/Makefile
+++ b/Makefile
@@ -530,6 +530,7 @@ LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
+LIB_H += map.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
 LIB_H += notes.h
@@ -621,6 +622,7 @@ LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += mailmap.o
+LIB_OBJS += map.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
diff --git a/map.c b/map.c
new file mode 100644
index 0000000..378cecb
--- /dev/null
+++ b/map.c
@@ -0,0 +1,86 @@
+#include "cache.h"
+#include "map.h"
+#include "object.h"
+
+static unsigned int hash_obj(const struct object *obj, unsigned int n)
+{
+	unsigned int hash;
+
+	memcpy(&hash, obj->sha1, sizeof(unsigned int));
+	return hash % n;
+}
+
+static unsigned int cmp_obj(const struct object *a, const struct object *b)
+{
+	return b == a;
+}
+
+#define MAP_IMPLEMENT(name, ktype, vtype, cmp_fun, hash_fun) \
+static int map_insert_##name(struct map_##name *m, \
+			     const ktype key, \
+			     vtype value, \
+			     vtype *old) \
+{ \
+	unsigned int j; \
+ \
+	for (j = hash_fun(key, m->size); m->hash[j].used; j = (j+1) % m->size) { \
+		if (cmp_fun(m->hash[j].key, key)) { \
+			if (old) \
+				*old = m->hash[j].value; \
+			m->hash[j].value = value; \
+			return 1; \
+		} \
+	} \
+ \
+	m->hash[j].key = key; \
+	m->hash[j].value = value; \
+	m->hash[j].used = 1; \
+	m->nr++; \
+	return 0; \
+} \
+ \
+static void map_grow_##name(struct map_##name *m) \
+{ \
+	struct map_entry_##name *old_hash = m->hash; \
+	unsigned int old_size = m->size; \
+	unsigned int i; \
+ \
+	m->size = (old_size + 1000) * 3 / 2; \
+	m->hash = xcalloc(m->size, sizeof(*m->hash)); \
+	m->nr = 0; \
+ \
+	for (i = 0; i < old_size; i++) { \
+		if (!old_hash[i].used) \
+			continue; \
+		map_insert_##name(m, old_hash[i].key, old_hash[i].value, NULL); \
+	} \
+	free(old_hash); \
+} \
+ \
+int map_set_##name(struct map_##name *m, \
+		   const ktype key, \
+		   vtype value, \
+		   vtype *old) \
+{ \
+	if (m->nr >= m->size * 2 / 3) \
+		map_grow_##name(m); \
+	return map_insert_##name(m, key, value, old); \
+} \
+ \
+int map_get_##name(struct map_##name *m, \
+		   const ktype key, \
+		   vtype *value) \
+{ \
+	unsigned int j; \
+ \
+	if (!m->size) \
+		return 0; \
+ \
+	for (j = hash_fun(key, m->size); m->hash[j].used; j = (j+1) % m->size) { \
+		if (cmp_fun(m->hash[j].key, key)) { \
+			*value = m->hash[j].value; \
+			return 1; \
+		} \
+	} \
+	return 0; \
+}
diff --git a/map.h b/map.h
new file mode 100644
index 0000000..496c5d1
--- /dev/null
+++ b/map.h
@@ -0,0 +1,24 @@
+#ifndef MAP_H
+#define MAP_H
+
+#define DECLARE_MAP(name, ktype, vtype) \
+struct map_entry_##name { \
+	const ktype key; \
+	vtype value; \
+	unsigned used:1; \
+}; \
+ \
+struct map_##name { \
+	unsigned int size, nr; \
+	struct map_entry_##name *hash; \
+}; \
+ \
+extern int map_get_##name(struct map_##name *, \
+			  const ktype key, \
+			  vtype *value); \
+extern int map_set_##name(struct map_##name *, \
+			  const ktype key, \
+			  vtype value, \
+			  vtype *old); \
+
+#endif /* MAP_H */
-- 
1.7.6.38.ge5b33
