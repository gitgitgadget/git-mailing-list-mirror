From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 03/11] Define free_all_objects to deallocate object pools
Date: Fri, 9 Nov 2007 06:06:16 -0500
Message-ID: <20071109110616.GC19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:07:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqRhG-0007XS-MB
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbXKILGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbXKILGW
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:06:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34089 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbXKILGU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:06:20 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqRgl-0003CA-E6; Fri, 09 Nov 2007 06:06:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CCF4A20FBAE; Fri,  9 Nov 2007 06:06:16 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64156>

The new API call free_all_objects releases all struct objects that
have been allocated thus far in the process, invalidating all of
those pointers and clearing out the object hash.  This resets the
process to before any objects were parsed and allocated, allowing
a future revision walk to start from a clean slate without needing
to clear_commit_marks() first, or worry about parent rewriting.

The release routines support recursively releasing any buffers held
by an active object through object specific scrub functions.  These
only need to free any buffers that had been held by the object and
are not yet released as any other clearing activity would be handled
by the next user of the memory.

Performance testing with `git rev-list --objects --all` shows that
calling free_all_objects() after completing the traversal doesn't
cost us any additional significant running time.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 alloc.c  |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 cache.h  |    1 +
 commit.c |    6 ++++++
 commit.h |    1 +
 object.c |   11 +++++++++++
 object.h |    1 +
 tag.c    |    5 +++++
 tag.h    |    1 +
 tree.c   |    5 +++++
 tree.h   |    1 +
 10 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/alloc.c b/alloc.c
index a61ae41..aa429ec 100644
--- a/alloc.c
+++ b/alloc.c
@@ -51,7 +51,7 @@ static void report(const char* name, struct node_pool *p, size_t sz)
 
 #undef SZ_FMT
 
-#define DEFINE_ALLOCATOR(name, t)				\
+#define DEFINE_BASE_ALLOCATOR(name, t)				\
 static struct node_pool name##_pool;				\
 void *alloc_##name##_node(void)					\
 {								\
@@ -76,6 +76,36 @@ static void report_##name(void)					\
 	report(#name, &name##_pool, sizeof(t));			\
 }
 
+#define DEFINE_ALLOCATOR(name, t)				\
+DEFINE_BASE_ALLOCATOR(name, t)					\
+static void free_all_##name(void)				\
+{								\
+	struct node_block *b, *n;				\
+	for (b = name##_pool.block_list; b; b = n) {		\
+		n = b->next;					\
+		free(b);					\
+	}							\
+	memset(&name##_pool, 0, sizeof(name##_pool));		\
+}
+
+#define DEFINE_SCRUBBING_ALLOCATOR(name, t, scrub)		\
+DEFINE_BASE_ALLOCATOR(name, t)					\
+static void free_all_##name(void)				\
+{								\
+	struct node_block *b, *n;				\
+	for (b = name##_pool.block_list; b; b = n) {		\
+		size_t nr = BLOCKING;				\
+		char *e = (char*)(b + 1);			\
+		if (b == name##_pool.block_list)		\
+			nr -= name##_pool.nr;			\
+		for (; nr--; e += sizeof(t))			\
+			scrub((t*)e);				\
+		n = b->next;					\
+		free(b);					\
+	}							\
+	memset(&name##_pool, 0, sizeof(name##_pool));		\
+}
+
 union any_object {
 	struct object object;
 	struct blob blob;
@@ -84,11 +114,22 @@ union any_object {
 	struct tag tag;
 };
 
+static void scrub_any_object(union any_object *o)
+{
+	switch (o->object.type) {
+	case OBJ_COMMIT: scrub_commit(&o->commit); break;
+	case OBJ_TREE: scrub_tree(&o->tree); break;
+	case OBJ_BLOB: break;
+	case OBJ_TAG: scrub_tag(&o->tag); break;
+	default: die("unknown type %s", typename(o->object.type));
+	}
+}
+
 DEFINE_ALLOCATOR(blob, struct blob)
-DEFINE_ALLOCATOR(tree, struct tree)
-DEFINE_ALLOCATOR(commit, struct commit)
-DEFINE_ALLOCATOR(tag, struct tag)
-DEFINE_ALLOCATOR(object, union any_object)
+DEFINE_SCRUBBING_ALLOCATOR(tree, struct tree, scrub_tree)
+DEFINE_SCRUBBING_ALLOCATOR(commit, struct commit, scrub_commit)
+DEFINE_SCRUBBING_ALLOCATOR(tag, struct tag, scrub_tag)
+DEFINE_SCRUBBING_ALLOCATOR(object, union any_object, scrub_any_object)
 
 void alloc_report(void)
 {
@@ -98,3 +139,12 @@ void alloc_report(void)
 	report_tag();
 	report_object();
 }
+
+void alloc_free_everything(void)
+{
+	free_all_blob();
+	free_all_tree();
+	free_all_commit();
+	free_all_tag();
+	free_all_object();
+}
diff --git a/cache.h b/cache.h
index 7174eb1..8289de1 100644
--- a/cache.h
+++ b/cache.h
@@ -587,6 +587,7 @@ extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
 extern void alloc_report(void);
+extern void alloc_free_everything(void);
 
 /* trace.c */
 extern void trace_printf(const char *format, ...);
diff --git a/commit.c b/commit.c
index f074811..05f3cd6 100644
--- a/commit.c
+++ b/commit.c
@@ -318,6 +318,12 @@ int parse_commit(struct commit *item)
 	return ret;
 }
 
+void scrub_commit(struct commit *item)
+{
+	free_commit_list(item->parents);
+	free(item->buffer);
+}
+
 struct commit_list *commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
 	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
diff --git a/commit.h b/commit.h
index aa67986..cd0d286 100644
--- a/commit.h
+++ b/commit.h
@@ -39,6 +39,7 @@ struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 
 int parse_commit(struct commit *item);
+void scrub_commit(struct commit *item);
 
 struct commit_list * commit_list_insert(struct commit *item, struct commit_list **list_p);
 struct commit_list * insert_by_date(struct commit *item, struct commit_list **list);
diff --git a/object.c b/object.c
index 16793d9..9b49472 100644
--- a/object.c
+++ b/object.c
@@ -43,6 +43,17 @@ int type_from_string(const char *str)
 	die("invalid object type \"%s\"", str);
 }
 
+void free_all_objects(void)
+{
+	if (obj_hash) {
+		free(obj_hash);
+		obj_hash = NULL;
+		nr_objs = 0;
+		obj_hash_size = 0;
+		alloc_free_everything();
+	}
+}
+
 static unsigned int hash_obj(struct object *obj, unsigned int n)
 {
 	unsigned int hash = *(unsigned int *)obj->sha1;
diff --git a/object.h b/object.h
index 397bbfa..642beeb 100644
--- a/object.h
+++ b/object.h
@@ -40,6 +40,7 @@ extern int track_object_refs;
 extern const char *typename(unsigned int type);
 extern int type_from_string(const char *str);
 
+extern void free_all_objects(void);
 extern unsigned int get_max_object_index(void);
 extern struct object *get_indexed_object(unsigned int);
 extern struct object_refs *lookup_object_refs(struct object *);
diff --git a/tag.c b/tag.c
index f62bcdd..c39d3f0 100644
--- a/tag.c
+++ b/tag.c
@@ -114,3 +114,8 @@ int parse_tag(struct tag *item)
 	free(data);
 	return ret;
 }
+
+void scrub_tag(struct tag *item)
+{
+	free(item->tag);
+}
diff --git a/tag.h b/tag.h
index 7a0cb00..933b876 100644
--- a/tag.h
+++ b/tag.h
@@ -15,6 +15,7 @@ struct tag {
 extern struct tag *lookup_tag(const unsigned char *sha1);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
+extern void scrub_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 
 #endif /* TAG_H */
diff --git a/tree.c b/tree.c
index 8c0819f..278dad7 100644
--- a/tree.c
+++ b/tree.c
@@ -281,6 +281,11 @@ int parse_tree(struct tree *item)
 	return parse_tree_buffer(item, buffer, size);
 }
 
+void scrub_tree(struct tree *tree)
+{
+	free(tree->buffer);
+}
+
 struct tree *parse_tree_indirect(const unsigned char *sha1)
 {
 	struct object *obj = parse_object(sha1);
diff --git a/tree.h b/tree.h
index dd25c53..d03cfd7 100644
--- a/tree.h
+++ b/tree.h
@@ -16,6 +16,7 @@ struct tree *lookup_tree(const unsigned char *sha1);
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
 int parse_tree(struct tree *tree);
+void scrub_tree(struct tree *tree);
 
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
 struct tree *parse_tree_indirect(const unsigned char *sha1);
-- 
1.5.3.5.1622.g41d10
