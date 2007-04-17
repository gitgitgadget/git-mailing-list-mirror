From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [DUBIOUS PATCH 3/3] Make the object lookup hash use a "object index"
 instead of a pointer
Date: Mon, 16 Apr 2007 22:13:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704162211460.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704162041290.5473@woody.linux-foundation.org>
 <7vfy6zskb4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704162200420.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 07:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdg0D-0005CZ-OV
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 07:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031094AbXDQFNO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 01:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031096AbXDQFNO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 01:13:14 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36088 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031094AbXDQFNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 01:13:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3H5D9Is018249
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 22:13:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3H5D9Sw020911;
	Mon, 16 Apr 2007 22:13:09 -0700
In-Reply-To: <Pine.LNX.4.64.0704162200420.5473@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.963 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44732>


This uses less memory on 64-bit architectures (a 32-bit object index
rather than a full 64-bit pointer), but could also allow for some other
optimizations.  However, most of them would require that we actually
expose the object index to other parts of the system, which we currently
don't.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

As mentioned, the overhead of doing the index->object pointer conversion 
seems to be big enough that this isn't worth it.

Admittedly part of that overhead is the debugging code I added, so this 
may not be that bad an idea after all, but still..

 alloc.c  |   89 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 cache.h  |   11 ++++---
 object.c |   50 +++++++++++++++++++++-------------
 object.h |    2 +-
 4 files changed, 108 insertions(+), 44 deletions(-)

diff --git a/alloc.c b/alloc.c
index 216c23a..bc6aa30 100644
--- a/alloc.c
+++ b/alloc.c
@@ -16,27 +16,78 @@
 #include "commit.h"
 #include "tag.h"
 
-#define BLOCKING 1024
+/*
+ * We allocate 1024 object nodes at a time.
+ *
+ * This not only avoids any fragmentation in the system "malloc()"
+ * libraries, it also means that we can generate a denser "object
+ * index" that does not need a full pointer: we can use an integer
+ * with the low bits indicating the object node ID within an
+ * allocation block, and the high bits indicating the allocation
+ * block number.
+ */
+#define BLOCKING_BITS 10
+#define BLOCKING_SIZE (1u << BLOCKING_BITS)
+#define BLOCKING_MASK (BLOCKING_SIZE-1)
 
-#define DEFINE_ALLOCATOR(name, type)				\
-static unsigned int name##_allocs;				\
-void *alloc_##name##_node(void)					\
-{								\
-	static int nr;						\
-	static type *block;					\
-	void *ret;						\
-								\
-	if (!nr) {						\
-		nr = BLOCKING;					\
-		block = xmalloc(BLOCKING * sizeof(type));	\
-	}							\
-	nr--;							\
-	name##_allocs++;					\
-	ret = block++;						\
-	memset(ret, 0, sizeof(type));				\
-	return ret;						\
+struct alloc_descriptor {
+	unsigned int size, nr;
+	unsigned int block;
+};
+
+struct block_descriptor {
+	unsigned int size;
+	unsigned char *base;
+};
+
+static struct block_descriptor *block_allocations;
+static unsigned int nr_block_allocations;
+
+static unsigned int alloc_new_block(unsigned int size)
+{
+	static unsigned int index;
+	unsigned int i = ++index;
+
+	if (i >= nr_block_allocations) {
+		unsigned int old = nr_block_allocations;
+		unsigned int nr = alloc_nr(i);
+		block_allocations = xrealloc(block_allocations, nr * sizeof(*block_allocations));
+		memset(block_allocations + old, 0, (nr - old) * sizeof(*block_allocations));
+		nr_block_allocations = nr;
+	}
+	block_allocations[i].size = size;
+	block_allocations[i].base = xcalloc(BLOCKING_SIZE, size);
+	return i;
+}
+
+static unsigned int allocate_one_index(struct alloc_descriptor *desc)
+{
+	unsigned int nr = desc->nr++;
+	unsigned int index = nr & BLOCKING_MASK;
+	if (!index)
+		desc->block = alloc_new_block(desc->size);
+	return (desc->block << BLOCKING_BITS) + index;
+}
+
+struct object *object_index_address(unsigned int index)
+{
+	unsigned int block = index >> BLOCKING_BITS;
+	struct block_descriptor *desc;
+
+	index &= BLOCKING_MASK;
+	if (!block || block >= nr_block_allocations)
+		die("invalid object index (block = %u/%u)", block, nr_block_allocations);
+	desc = block_allocations + block;
+	if (!desc->size || !desc->base)
+		die("bad object block index entry %u:%p", desc->size, desc->base);
+	return (struct object *)(index * desc->size + desc->base);
 }
 
+#define DEFINE_ALLOCATOR(name, type)				\
+static struct alloc_descriptor name##_desc = { sizeof(type) };	\
+unsigned int alloc_##name##_node(void)				\
+{ return allocate_one_index(&name##_desc); }
+
 union any_object {
 	struct object object;
 	struct blob blob;
@@ -65,7 +116,7 @@ static void report(const char* name, unsigned int count, size_t size)
 #undef SZ_FMT
 
 #define REPORT(name)	\
-    report(#name, name##_allocs, name##_allocs*sizeof(struct name) >> 10)
+    report(#name, name##_desc.nr, name##_desc.nr*sizeof(struct name) >> 10)
 
 void alloc_report(void)
 {
diff --git a/cache.h b/cache.h
index 4de25cc..9342980 100644
--- a/cache.h
+++ b/cache.h
@@ -476,12 +476,13 @@ int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
 
 /* alloc.c */
-extern void *alloc_blob_node(void);
-extern void *alloc_tree_node(void);
-extern void *alloc_commit_node(void);
-extern void *alloc_tag_node(void);
-extern void *alloc_object_node(void);
+extern unsigned int alloc_blob_node(void);
+extern unsigned int alloc_tree_node(void);
+extern unsigned int alloc_commit_node(void);
+extern unsigned int alloc_tag_node(void);
+extern unsigned int alloc_object_node(void);
 extern void alloc_report(void);
+extern struct object *object_index_address(unsigned int index);
 
 /* trace.c */
 extern int nfasprintf(char **str, const char *fmt, ...);
diff --git a/object.c b/object.c
index 7bd3fec..a91d238 100644
--- a/object.c
+++ b/object.c
@@ -5,7 +5,11 @@
 #include "commit.h"
 #include "tag.h"
 
-static struct object **obj_hash;
+struct hash_entry {
+	unsigned int index;
+};
+
+static struct hash_entry *obj_hash;
 static int nr_objs, obj_hash_size;
 
 unsigned int get_max_object_index(void)
@@ -13,9 +17,11 @@ unsigned int get_max_object_index(void)
 	return obj_hash_size;
 }
 
+/* Purely for external object walkers (like fsck) */
 struct object *get_indexed_object(unsigned int idx)
 {
-	return obj_hash[idx];
+	unsigned int object_index = obj_hash[idx].index;
+	return object_index ? object_index_address(object_index) : NULL;
 }
 
 static const char *object_type_strings[] = {
@@ -49,16 +55,16 @@ static unsigned int hash_obj(struct object *obj, unsigned int n)
 	return hash % n;
 }
 
-static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
+static void insert_obj_hash(unsigned int object_index, struct object *object, struct hash_entry *hash, unsigned int size)
 {
-	int j = hash_obj(obj, size);
+	int j = hash_obj(object, size);
 
-	while (hash[j]) {
+	while (hash[j].index) {
 		j++;
 		if (j >= size)
 			j = 0;
 	}
-	hash[j] = obj;
+	hash[j].index = object_index;
 }
 
 static int hashtable_index(const unsigned char *sha1)
@@ -71,43 +77,49 @@ static int hashtable_index(const unsigned char *sha1)
 struct object *lookup_object(const unsigned char *sha1)
 {
 	int i;
-	struct object *obj;
 
 	if (!obj_hash)
 		return NULL;
 
 	i = hashtable_index(sha1);
-	while ((obj = obj_hash[i]) != NULL) {
-		if (!hashcmp(sha1, obj->sha1))
+	for (;;) {
+		struct hash_entry *entry = obj_hash + i;
+		unsigned int index = entry->index;
+		struct object *obj;
+
+		if (!index)
 			break;
+		obj = object_index_address(index);
+		if (!hashcmp(sha1, obj->sha1))
+			return obj;
 		i++;
 		if (i == obj_hash_size)
 			i = 0;
 	}
-	return obj;
+	return NULL;
 }
 
 static void grow_object_hash(void)
 {
 	int i;
 	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
-	struct object **new_hash;
+	struct hash_entry *new_hash;
 
-	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
+	new_hash = xcalloc(new_hash_size, sizeof(struct hash_entry));
 	for (i = 0; i < obj_hash_size; i++) {
-		struct object *obj = obj_hash[i];
-		if (!obj)
+		unsigned int index = obj_hash[i].index;
+		if (!index)
 			continue;
-		insert_obj_hash(obj, new_hash, new_hash_size);
+		insert_obj_hash(index, object_index_address(index), new_hash, new_hash_size);
 	}
 	free(obj_hash);
 	obj_hash = new_hash;
 	obj_hash_size = new_hash_size;
 }
 
-void *create_object(const unsigned char *sha1, int type, void *o)
+void *create_object(const unsigned char *sha1, int type, unsigned int index)
 {
-	struct object *obj = o;
+	struct object *obj = object_index_address(index);
 
 	obj->parsed = 0;
 	obj->used = 0;
@@ -118,7 +130,7 @@ void *create_object(const unsigned char *sha1, int type, void *o)
 	if (obj_hash_size - 1 <= nr_objs * 2)
 		grow_object_hash();
 
-	insert_obj_hash(obj, obj_hash, obj_hash_size);
+	insert_obj_hash(index, obj, obj_hash, obj_hash_size);
 	nr_objs++;
 	return obj;
 }
@@ -127,7 +139,7 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
-		obj = create_object(sha1, OBJ_NONE, alloc_object_node());
+		return create_object(sha1, OBJ_NONE, alloc_object_node());
 	return obj;
 }
 
diff --git a/object.h b/object.h
index c0a5fd3..099bbdb 100644
--- a/object.h
+++ b/object.h
@@ -47,7 +47,7 @@ extern struct object_refs *lookup_object_refs(struct object *);
 /** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
 
-extern void *create_object(const unsigned char *sha1, int type, void *obj);
+extern void *create_object(const unsigned char *sha1, int type, unsigned int object_index);
 
 /** Returns the object, having parsed it to find out what it is. **/
 struct object *parse_object(const unsigned char *sha1);
-- 
1.5.1.1.107.g7a15
