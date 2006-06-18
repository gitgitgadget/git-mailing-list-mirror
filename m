From: Linus Torvalds <torvalds@osdl.org>
Subject: Remove "refs" field from "struct object"
Date: Sun, 18 Jun 2006 11:45:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606181137380.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jun 18 20:45:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs2Gq-0004HX-Ay
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 20:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWFRSpM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 14:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWFRSpL
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 14:45:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62093 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751220AbWFRSpJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 14:45:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5IIj3gt028211
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Jun 2006 11:45:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5IIj2Km000938;
	Sun, 18 Jun 2006 11:45:03 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22096>


This shrinks "struct object" to the absolutely minimal size possible.
It now contains /only/ the object flags and the SHA1 hash name of the
object.

The "refs" field, which is really needed only for fsck, is maintained in
a separate hashed lookup-table, allowing all normal users to totally
ignore it.

This helps memory usage, although not as much as I hoped: it looks like 
the allocation overhead of malloc (and the alignment constraints in 
particular) means that while the structure size shrinks, the actual 
allocation overhead mostly does not.

[ That said: memory usage is actually down, but not as much as it should
  be: I suspect just one of the object types actually ended up shrinking
  its effective allocation size.

  To get to the next level, we probably need specialized allocators that
  don't pad the allocation more than necessary. ]

The separation makes for some code cleanup, though, and makes the ref
tracking that fsck wants a clearly separate thing.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

It turns out that removing the refs member wasn't as hard as I 
anticipated: the refs usage by git-fsck-objects was very well defined, and 
the actual patch to do this all is mostly the addition of the hashed 
lookup and insertion (same logic as for the objects themselves), and some 
very small cosmetic changes to anything that set/read the object->refs 
field.

Half of the patch is moving the refs-related code to a file of its own.

I'd like to clean up some things later (make the object re-hashing be as 
clean and simple as the refs re-hashing is), but wanted to keep this patch 
fairly minimal and do just the refs-related changes.

The alignment problem is because the objects actually need just 4-byte 
alignment on 32-bit architectures, but "malloc()" will return 8- or 
16-byte aligned allocations, so we will have totally unnecessary overhead 
there. 

This patch will be necessary regardless - the alloction alignment is a 
separate issue that just hides much of the shrinkage win.

 Makefile       |    2 -
 fsck-objects.c |    5 +-
 object-refs.c  |  142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 object.c       |   70 ----------------------------
 object.h       |    4 +-
 5 files changed, 149 insertions(+), 74 deletions(-)

diff --git a/Makefile b/Makefile
index 2a1e639..244a4d1 100644
--- a/Makefile
+++ b/Makefile
@@ -212,7 +212,7 @@ LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o lockfile.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
-	quote.o read-cache.o refs.o run-command.o dir.o \
+	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
diff --git a/fsck-objects.c b/fsck-objects.c
index 2b1aab4..769bb2a 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -64,6 +64,7 @@ static void check_connectivity(void)
 
 	/* Look up all the requirements, warn about missing objects.. */
 	for (i = 0; i < obj_allocs; i++) {
+		const struct object_refs *refs;
 		struct object *obj = objs[i];
 
 		if (!obj)
@@ -78,8 +79,8 @@ static void check_connectivity(void)
 			continue;
 		}
 
-		if (obj->refs) {
-			const struct object_refs *refs = obj->refs;
+		refs = lookup_object_refs(obj);
+		if (refs) {
 			unsigned j;
 			for (j = 0; j < refs->count; j++) {
 				struct object *ref = refs->ref[j];
diff --git a/object-refs.c b/object-refs.c
new file mode 100644
index 0000000..8afa227
--- /dev/null
+++ b/object-refs.c
@@ -0,0 +1,142 @@
+#include "cache.h"
+#include "object.h"
+
+int track_object_refs = 0;
+
+static unsigned int refs_hash_size, nr_object_refs;
+static struct object_refs **refs_hash;
+
+static unsigned int hash_obj(struct object *obj, unsigned int n)
+{
+	unsigned int hash = *(unsigned int *)obj->sha1;
+	return hash % n;
+}
+
+static void grow_refs_hash(void)
+{
+	int i;
+	int new_hash_size = (refs_hash_size + 1000) * 3 / 2;
+	struct object_refs **new_hash;
+
+	new_hash = calloc(new_hash_size, sizeof(struct object_refs *));
+	for (i = 0; i < refs_hash_size; i++) {
+		int j;
+		struct object_refs *ref = refs_hash[i];
+		if (!ref)
+			continue;
+		j = hash_obj(ref->base, new_hash_size);
+		new_hash[j] = ref;
+	}
+	free(refs_hash);
+	refs_hash = new_hash;
+	refs_hash_size = new_hash_size;
+}
+
+static void insert_ref_hash(struct object_refs *ref)
+{
+	int j = hash_obj(ref->base, refs_hash_size);
+
+	while (refs_hash[j]) {
+		j++;
+		if (j >= refs_hash_size)
+			j = 0;
+	}
+	refs_hash[j] = ref;
+}
+
+static void add_object_refs(struct object *obj, struct object_refs *ref)
+{
+	int nr = nr_object_refs + 1;
+
+	if (nr > refs_hash_size * 2 / 3)
+		grow_refs_hash();
+	ref->base = obj;
+	insert_ref_hash(ref);
+	nr_object_refs = nr;
+}
+
+struct object_refs *lookup_object_refs(struct object *obj)
+{
+	int j = hash_obj(obj, refs_hash_size);
+	struct object_refs *ref;
+
+	while ((ref = refs_hash[j]) != NULL) {
+		if (ref->base == obj)
+			break;
+		j++;
+		if (j >= refs_hash_size)
+			j = 0;
+	}
+	return ref;
+}
+
+struct object_refs *alloc_object_refs(unsigned count)
+{
+	struct object_refs *refs;
+	size_t size = sizeof(*refs) + count*sizeof(struct object *);
+
+	refs = xcalloc(1, size);
+	refs->count = count;
+	return refs;
+}
+
+static int compare_object_pointers(const void *a, const void *b)
+{
+	const struct object * const *pa = a;
+	const struct object * const *pb = b;
+	if (*pa == *pb)
+		return 0;
+	else if (*pa < *pb)
+		return -1;
+	else
+		return 1;
+}
+
+void set_object_refs(struct object *obj, struct object_refs *refs)
+{
+	unsigned int i, j;
+
+	/* Do not install empty list of references */
+	if (refs->count < 1) {
+		free(refs);
+		return;
+	}
+
+	/* Sort the list and filter out duplicates */
+	qsort(refs->ref, refs->count, sizeof(refs->ref[0]),
+	      compare_object_pointers);
+	for (i = j = 1; i < refs->count; i++) {
+		if (refs->ref[i] != refs->ref[i - 1])
+			refs->ref[j++] = refs->ref[i];
+	}
+	if (j < refs->count) {
+		/* Duplicates were found - reallocate list */
+		size_t size = sizeof(*refs) + j*sizeof(struct object *);
+		refs->count = j;
+		refs = xrealloc(refs, size);
+	}
+
+	for (i = 0; i < refs->count; i++)
+		refs->ref[i]->used = 1;
+	add_object_refs(obj, refs);
+}
+
+void mark_reachable(struct object *obj, unsigned int mask)
+{
+	const struct object_refs *refs;
+
+	if (!track_object_refs)
+		die("cannot do reachability with object refs turned off");
+	/* If we've been here already, don't bother */
+	if (obj->flags & mask)
+		return;
+	obj->flags |= mask;
+	refs = lookup_object_refs(obj);
+	if (refs) {
+		unsigned i;
+		for (i = 0; i < refs->count; i++)
+			mark_reachable(refs->ref[i], mask);
+	}
+}
+
+
diff --git a/object.c b/object.c
index 0f70890..e26e319 100644
--- a/object.c
+++ b/object.c
@@ -13,8 +13,6 @@ const char *type_names[] = {
 	"none", "blob", "tree", "commit", "bad"
 };
 
-int track_object_refs = 0;
-
 static int hashtable_index(const unsigned char *sha1)
 {
 	unsigned int i;
@@ -55,7 +53,6 @@ void created_object(const unsigned char 
 	obj->parsed = 0;
 	memcpy(obj->sha1, sha1, 20);
 	obj->type = TYPE_NONE;
-	obj->refs = NULL;
 	obj->used = 0;
 
 	if (obj_allocs - 1 <= nr_objs * 2) {
@@ -84,73 +81,6 @@ void created_object(const unsigned char 
 	nr_objs++;
 }
 
-struct object_refs *alloc_object_refs(unsigned count)
-{
-	struct object_refs *refs;
-	size_t size = sizeof(*refs) + count*sizeof(struct object *);
-
-	refs = xcalloc(1, size);
-	refs->count = count;
-	return refs;
-}
-
-static int compare_object_pointers(const void *a, const void *b)
-{
-	const struct object * const *pa = a;
-	const struct object * const *pb = b;
-	if (*pa == *pb)
-		return 0;
-	else if (*pa < *pb)
-		return -1;
-	else
-		return 1;
-}
-
-void set_object_refs(struct object *obj, struct object_refs *refs)
-{
-	unsigned int i, j;
-
-	/* Do not install empty list of references */
-	if (refs->count < 1) {
-		free(refs);
-		return;
-	}
-
-	/* Sort the list and filter out duplicates */
-	qsort(refs->ref, refs->count, sizeof(refs->ref[0]),
-	      compare_object_pointers);
-	for (i = j = 1; i < refs->count; i++) {
-		if (refs->ref[i] != refs->ref[i - 1])
-			refs->ref[j++] = refs->ref[i];
-	}
-	if (j < refs->count) {
-		/* Duplicates were found - reallocate list */
-		size_t size = sizeof(*refs) + j*sizeof(struct object *);
-		refs->count = j;
-		refs = xrealloc(refs, size);
-	}
-
-	for (i = 0; i < refs->count; i++)
-		refs->ref[i]->used = 1;
-	obj->refs = refs;
-}
-
-void mark_reachable(struct object *obj, unsigned int mask)
-{
-	if (!track_object_refs)
-		die("cannot do reachability with object refs turned off");
-	/* If we've been here already, don't bother */
-	if (obj->flags & mask)
-		return;
-	obj->flags |= mask;
-	if (obj->refs) {
-		const struct object_refs *refs = obj->refs;
-		unsigned i;
-		for (i = 0; i < refs->count; i++)
-			mark_reachable(refs->ref[i], mask);
-	}
-}
-
 struct object *lookup_object_type(const unsigned char *sha1, const char *type)
 {
 	if (!type) {
diff --git a/object.h b/object.h
index f4ee2e5..c537b4b 100644
--- a/object.h
+++ b/object.h
@@ -9,6 +9,7 @@ struct object_list {
 
 struct object_refs {
 	unsigned count;
+	struct object *base;
 	struct object *ref[FLEX_ARRAY]; /* more */
 };
 
@@ -28,7 +29,6 @@ struct object {
 	unsigned type : TYPE_BITS;
 	unsigned flags : FLAG_BITS;
 	unsigned char sha1[20];
-	struct object_refs *refs;
 };
 
 extern int track_object_refs;
@@ -41,6 +41,8 @@ static inline const char *typename(unsig
 	return type_names[type > TYPE_TAG ? TYPE_BAD : type];
 }
 
+extern struct object_refs *lookup_object_refs(struct object *);
+
 /** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
 
