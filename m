From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Add a generic "object decorator" interface, and make
 object refs use it
Date: Mon, 16 Apr 2007 16:03:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704161600470.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>, "Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 01:03:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdaEO-0004TY-QR
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 01:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbXDPXD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 19:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbXDPXD3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 19:03:29 -0400
Received: from smtp.osdl.org ([65.172.181.24]:55073 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754031AbXDPXD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 19:03:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GN3GIs008013
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 16:03:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GN3F3O014504;
	Mon, 16 Apr 2007 16:03:15 -0700
X-Spam-Status: No, hits=-3.947 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44700>


This allows you to add an arbitrary "decoration" of your choice to any
object.  It's a space- and time-efficient way to add information to
arbitrary objects, especially if most objects probably do not have the
decoration.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This shouldn't change any behaviour, just re-implements the object-refs 
hashing as a new generic "decorator".

 Makefile      |    4 +-
 decorate.c    |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 decorate.h    |   18 +++++++++++
 object-refs.c |   69 ++++---------------------------------------
 object.h      |    1 -
 5 files changed, 116 insertions(+), 65 deletions(-)
 create mode 100644 decorate.c
 create mode 100644 decorate.h

diff --git a/Makefile b/Makefile
index b8e6030..251fc31 100644
--- a/Makefile
+++ b/Makefile
@@ -283,7 +283,7 @@ LIB_H = \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-	utf8.h reflog-walk.h patch-ids.h
+	utf8.h reflog-walk.h patch-ids.h decorate.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -305,7 +305,7 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o
+	convert.o decorate.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/decorate.c b/decorate.c
new file mode 100644
index 0000000..721bcd1
--- /dev/null
+++ b/decorate.c
@@ -0,0 +1,89 @@
+/*
+ * decorate.c - decorate a git object with some arbitrary
+ * data.
+ */
+#include "cache.h"
+#include "object.h"
+#include "decorate.h"
+
+static unsigned int hash_obj(struct object *obj, unsigned int n)
+{
+	unsigned int hash = *(unsigned int *)obj->sha1;
+	return hash % n;
+}
+
+static void *insert_decoration(struct decoration *n, struct object *base, void *decoration)
+{
+	int size = n->size;
+	struct object_decoration *hash = n->hash;
+	int j = hash_obj(base, size);
+
+	while (hash[j].base) {
+		if (hash[j].base == base) {
+			void *old = hash[j].decoration;
+			hash[j].decoration = decoration;
+			return old;
+		}
+		j++;
+		if (++j >= size)
+			j = 0;
+	}
+	hash[j].base = base;
+	hash[j].decoration = decoration;
+	n->nr++;
+	return NULL;
+}
+
+static void grow_decoration(struct decoration *n)
+{
+	int i;
+	int old_size = n->size;
+	struct object_decoration *old_hash;
+
+	old_size = n->size;
+	old_hash = n->hash;
+	
+	n->size = (old_size + 1000) * 3 / 2;
+	n->hash = xcalloc(n->size, sizeof(struct object_decoration));
+	n->nr = 0;
+	
+	for (i = 0; i < old_size; i++) {
+		struct object *base = old_hash[i].base;
+		void *decoration = old_hash[i].decoration;
+
+		if (!base)
+			continue;
+		insert_decoration(n, base, decoration);
+	}
+	free(old_hash);
+}
+
+/* Add a decoration pointer, return any old one */
+void *add_decoration(struct decoration *n, struct object *obj, void *decoration)
+{
+	int nr = n->nr + 1;
+
+	if (nr > n->size * 2 / 3)
+		grow_decoration(n);
+	return insert_decoration(n, obj, decoration);
+}
+
+/* Lookup a decoration pointer */
+void *lookup_decoration(struct decoration *n, struct object *obj)
+{
+	int j;
+
+	/* nothing to lookup */
+	if (!n->size)
+		return NULL;
+	j = hash_obj(obj, n->size);
+	for (;;) {
+		struct object_decoration *ref = n->hash + j;
+		if (ref->base == obj)
+			return ref->decoration;
+		if (!ref->base)
+			return NULL;
+		if (++j == n->size)
+			j = 0;
+	}
+}
diff --git a/decorate.h b/decorate.h
new file mode 100644
index 0000000..1fa4ad9
--- /dev/null
+++ b/decorate.h
@@ -0,0 +1,18 @@
+#ifndef DECORATE_H
+#define DECORATE_H
+
+struct object_decoration {
+	struct object *base;
+	void *decoration;
+};
+
+struct decoration {
+	const char *name;
+	unsigned int size, nr;
+	struct object_decoration *hash;
+};
+
+extern void *add_decoration(struct decoration *n, struct object *obj, void *decoration);
+extern void *lookup_decoration(struct decoration *n, struct object *obj);
+
+#endif
diff --git a/object-refs.c b/object-refs.c
index 98ea100..022e8d8 100644
--- a/object-refs.c
+++ b/object-refs.c
@@ -1,75 +1,20 @@
 #include "cache.h"
 #include "object.h"
+#include "decorate.h"
 
 int track_object_refs = 0;
 
-static unsigned int refs_hash_size, nr_object_refs;
-static struct object_refs **refs_hash;
+static struct decoration ref_decorate;
 
-static unsigned int hash_obj(struct object *obj, unsigned int n)
+struct object_refs *lookup_object_refs(struct object *base)
 {
-	unsigned int hash = *(unsigned int *)obj->sha1;
-	return hash % n;
+	return lookup_decoration(&ref_decorate, base);
 }
 
-static void insert_ref_hash(struct object_refs *ref, struct object_refs **hash, unsigned int size)
+static void add_object_refs(struct object *obj, struct object_refs *refs)
 {
-	int j = hash_obj(ref->base, size);
-
-	while (hash[j]) {
-		j++;
-		if (j >= size)
-			j = 0;
-	}
-	hash[j] = ref;
-}
-
-static void grow_refs_hash(void)
-{
-	int i;
-	int new_hash_size = (refs_hash_size + 1000) * 3 / 2;
-	struct object_refs **new_hash;
-
-	new_hash = xcalloc(new_hash_size, sizeof(struct object_refs *));
-	for (i = 0; i < refs_hash_size; i++) {
-		struct object_refs *ref = refs_hash[i];
-		if (!ref)
-			continue;
-		insert_ref_hash(ref, new_hash, new_hash_size);
-	}
-	free(refs_hash);
-	refs_hash = new_hash;
-	refs_hash_size = new_hash_size;
-}
-
-static void add_object_refs(struct object *obj, struct object_refs *ref)
-{
-	int nr = nr_object_refs + 1;
-
-	if (nr > refs_hash_size * 2 / 3)
-		grow_refs_hash();
-	ref->base = obj;
-	insert_ref_hash(ref, refs_hash, refs_hash_size);
-	nr_object_refs = nr;
-}
-
-struct object_refs *lookup_object_refs(struct object *obj)
-{
-	struct object_refs *ref;
-	int j;
-
-	/* nothing to lookup */
-	if (!refs_hash_size)
-		return NULL;
-	j = hash_obj(obj, refs_hash_size);
-	while ((ref = refs_hash[j]) != NULL) {
-		if (ref->base == obj)
-			break;
-		j++;
-		if (j >= refs_hash_size)
-			j = 0;
-	}
-	return ref;
+	if (add_decoration(&ref_decorate, obj, refs))
+		die("object %s tried to add refs twice!", sha1_to_hex(obj->sha1));
 }
 
 struct object_refs *alloc_object_refs(unsigned count)
diff --git a/object.h b/object.h
index bdbf0fa..bdbbc18 100644
--- a/object.h
+++ b/object.h
@@ -8,7 +8,6 @@ struct object_list {
 
 struct object_refs {
 	unsigned count;
-	struct object *base;
 	struct object *ref[FLEX_ARRAY]; /* more */
 };
 
-- 
1.5.1.1.107.g7a15
