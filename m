From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 5/10] Remove "tree->entries" tree-entry list from tree parser
Date: Mon, 29 May 2006 12:18:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291218060.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 21:19:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FknGq-0000Yw-Oq
	for gcvg-git@gmane.org; Mon, 29 May 2006 21:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWE2TTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 15:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWE2TTI
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 15:19:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751226AbWE2TTH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 15:19:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4TJIY2g015094
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 12:18:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4TJIXXi015515;
	Mon, 29 May 2006 12:18:34 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20960>


Instead, just use the tree buffer directly, and use the tree-walk
infrastructure to walk the buffers instead of the tree-entry list.

The tree-entry list is inefficient, and generates tons of small
allocations for no good reason. The tree-walk infrastructure is
generally no harder to use than following a linked list, and allows
us to do most tree parsing in-place.

Some programs still use the old tree-entry lists, and are a bit
painful to convert without major surgery. For them we have a helper
function that creates a temporary tree-entry list on demand.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 builtin-ls-tree.c   |    2 +
 builtin-read-tree.c |    4 +--
 builtin-rev-list.c  |   26 ++++++++++------
 fetch.c             |   16 +++++++---
 fsck-objects.c      |    7 +++-
 http-push.c         |   30 +++++++++++++------
 revision.c          |    3 +-
 tree.c              |   81 ++++++++++++++++++++++++++++++++++++---------------
 tree.h              |    4 ++-
 9 files changed, 116 insertions(+), 57 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 48385d5..b8d0d88 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -53,7 +53,7 @@ static int show_recursive(const char *ba
 	}
 }
 
-static int show_tree(unsigned char *sha1, const char *base, int baselen,
+static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 		     const char *pathname, unsigned mode, int stage)
 {
 	int retval = 0;
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 67492bf..480e6ed 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -165,7 +165,7 @@ #endif
 				struct tree *tree = lookup_tree(posns[i]->sha1);
 				any_dirs = 1;
 				parse_tree(tree);
-				subposns[i] = tree->entries;
+				subposns[i] = create_tree_entry_list(tree);
 				posns[i] = posns[i]->next;
 				src[i + merge] = &df_conflict_entry;
 				continue;
@@ -370,7 +370,7 @@ static int unpack_trees(merge_fn_t fn)
 	if (len) {
 		posns = xmalloc(len * sizeof(struct tree_entry_list *));
 		for (i = 0; i < len; i++) {
-			posns[i] = ((struct tree *) posn->item)->entries;
+			posns[i] = create_tree_entry_list((struct tree *) posn->item);
 			posn = posn->next;
 		}
 		if (unpack_trees_rec(posns, len, "", fn, &indpos))
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 94f520b..6e2b898 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -113,7 +113,7 @@ static struct object_list **process_tree
 					 const char *name)
 {
 	struct object *obj = &tree->object;
-	struct tree_entry_list *entry;
+	struct tree_desc desc;
 	struct name_path me;
 
 	if (!revs.tree_objects)
@@ -128,16 +128,22 @@ static struct object_list **process_tree
 	me.up = path;
 	me.elem = name;
 	me.elem_len = strlen(name);
-	entry = tree->entries;
-	tree->entries = NULL;
-	while (entry) {
-		struct tree_entry_list *next = entry->next;
-		if (entry->directory)
-			p = process_tree(lookup_tree(entry->sha1), p, &me, entry->name);
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
+
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+		update_tree_entry(&desc);
+
+		if (S_ISDIR(mode))
+			p = process_tree(lookup_tree(sha1), p, &me, name);
 		else
-			p = process_blob(lookup_blob(entry->sha1), p, &me, entry->name);
-		free(entry);
-		entry = next;
+			p = process_blob(lookup_blob(sha1), p, &me, name);
 	}
 	free(tree->buffer);
 	tree->buffer = NULL;
diff --git a/fetch.c b/fetch.c
index f7f8902..d9fe41f 100644
--- a/fetch.c
+++ b/fetch.c
@@ -41,16 +41,22 @@ static int process_tree(struct tree *tre
 	if (parse_tree(tree))
 		return -1;
 
-	entry = tree->entries;
-	tree->entries = NULL;
+	entry = create_tree_entry_list(tree);
 	while (entry) {
 		struct tree_entry_list *next = entry->next;
-		if (process(entry->item.any))
-			return -1;
-		free(entry->name);
+
+		if (entry->directory) {
+			struct tree *tree = lookup_tree(entry->sha1);
+			process_tree(tree);
+		} else {
+			struct blob *blob = lookup_blob(entry->sha1);
+			process(&blob->object);
+		}
 		free(entry);
 		entry = next;
 	}
+	free(tree->buffer);
+	tree->buffer = NULL;
 	return 0;
 }
 
diff --git a/fsck-objects.c b/fsck-objects.c
index ed2eb27..42778e8 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -11,6 +11,7 @@ #include "pack.h"
 #include "cache-tree.h"
 
 #define REACHABLE 0x0001
+#define SEEN      0x0002
 
 static int show_root = 0;
 static int show_tags = 0;
@@ -161,7 +162,7 @@ static int fsck_tree(struct tree *item)
 	struct tree_entry_list *entry, *last;
 
 	last = NULL;
-	for (entry = item->entries; entry; entry = entry->next) {
+	for (entry = create_tree_entry_list(item); entry; entry = entry->next) {
 		if (strchr(entry->name, '/'))
 			has_full_path = 1;
 		has_zero_pad |= entry->zeropad;
@@ -205,7 +206,6 @@ static int fsck_tree(struct tree *item)
 	}
 	if (last)
 		free(last);
-	item->entries = NULL;
 	free(item->buffer);
 	item->buffer = NULL;
 
@@ -277,6 +277,9 @@ static int fsck_sha1(unsigned char *sha1
 	struct object *obj = parse_object(sha1);
 	if (!obj)
 		return error("%s: object not found", sha1_to_hex(sha1));
+	if (obj->flags & SEEN)
+		return 0;
+	obj->flags |= SEEN;
 	if (obj->type == blob_type)
 		return 0;
 	if (obj->type == tree_type)
diff --git a/http-push.c b/http-push.c
index f492a5d..72ad89c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1704,6 +1704,7 @@ static struct object_list **process_blob
 		return p;
 
 	obj->flags |= SEEN;
+	name = strdup(name);
 	return add_object(obj, p, path, name);
 }
 
@@ -1713,7 +1714,7 @@ static struct object_list **process_tree
 					 const char *name)
 {
 	struct object *obj = &tree->object;
-	struct tree_entry_list *entry;
+	struct tree_desc desc;
 	struct name_path me;
 
 	obj->flags |= LOCAL;
@@ -1724,21 +1725,30 @@ static struct object_list **process_tree
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 
 	obj->flags |= SEEN;
+	name = strdup(name);
 	p = add_object(obj, p, NULL, name);
 	me.up = path;
 	me.elem = name;
 	me.elem_len = strlen(name);
-	entry = tree->entries;
-	tree->entries = NULL;
-	while (entry) {
-		struct tree_entry_list *next = entry->next;
-		if (entry->directory)
-			p = process_tree(lookup_tree(entry->sha1), p, &me, entry->name);
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
+
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+		update_tree_entry(&desc);
+
+		if (S_ISDIR(mode))
+			p = process_tree(lookup_tree(sha1), p, &me, name);
 		else
-			p = process_blob(lookup_blob(entry->sha1), p, &me, entry->name);
-		free(entry);
-		entry = next;
+			p = process_blob(lookup_blob(sha1), p, &me, name);
 	}
+	free(tree->buffer);
+	tree->buffer = NULL;
 	return p;
 }
 
diff --git a/revision.c b/revision.c
index 8d70a6f..c51ea83 100644
--- a/revision.c
+++ b/revision.c
@@ -63,8 +63,7 @@ void mark_tree_uninteresting(struct tree
 		return;
 	if (parse_tree(tree) < 0)
 		die("bad tree %s", sha1_to_hex(obj->sha1));
-	entry = tree->entries;
-	tree->entries = NULL;
+	entry = create_tree_entry_list(tree);
 	while (entry) {
 		struct tree_entry_list *next = entry->next;
 		if (entry->directory)
diff --git a/tree.c b/tree.c
index 8a7fdd4..db6e59f 100644
--- a/tree.c
+++ b/tree.c
@@ -151,22 +151,65 @@ struct tree *lookup_tree(const unsigned 
 	return (struct tree *) obj;
 }
 
-int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
+static int track_tree_refs(struct tree *item)
 {
+	int n_refs = 0, i;
+	struct object_refs *refs;
 	struct tree_desc desc;
-	struct tree_entry_list **list_p;
-	int n_refs = 0;
 
+	/* Count how many entries there are.. */
+	desc.buf = item->buffer;
+	desc.size = item->size;
+	while (desc.size) {
+		n_refs++;
+		update_tree_entry(&desc);
+	}
+
+	/* Allocate object refs and walk it again.. */
+	i = 0;
+	refs = alloc_object_refs(n_refs);
+	desc.buf = item->buffer;
+	desc.size = item->size;
+	while (desc.size) {
+		unsigned mode;
+		const char *name;
+		const unsigned char *sha1;
+		struct object *obj;
+
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+		update_tree_entry(&desc);
+		if (S_ISDIR(mode))
+			obj = &lookup_tree(sha1)->object;
+		else
+			obj = &lookup_blob(sha1)->object;
+		refs->ref[i++] = obj;
+	}
+	set_object_refs(&item->object, refs);
+	return 0;
+}
+
+int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
+{
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed = 1;
 	item->buffer = buffer;
 	item->size = size;
 
-	desc.buf = buffer;
-	desc.size = size;
+	if (track_object_refs)
+		track_tree_refs(item);
+	return 0;
+}
+
+struct tree_entry_list *create_tree_entry_list(struct tree *tree)
+{
+	struct tree_desc desc;
+	struct tree_entry_list *ret = NULL;
+	struct tree_entry_list **list_p = &ret;
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
 
-	list_p = &item->entries;
 	while (desc.size) {
 		unsigned mode;
 		const char *path;
@@ -186,29 +229,19 @@ int parse_tree_buffer(struct tree *item,
 		entry->next = NULL;
 
 		update_tree_entry(&desc);
-		n_refs++;
 		*list_p = entry;
 		list_p = &entry->next;
 	}
+	return ret;
+}
 
-	if (track_object_refs) {
-		struct tree_entry_list *entry;
-		unsigned i = 0;
-		struct object_refs *refs = alloc_object_refs(n_refs);
-		for (entry = item->entries; entry; entry = entry->next) {
-			struct object *obj;
-
-			if (entry->directory)
-				obj = &lookup_tree(entry->sha1)->object;
-			else
-				obj = &lookup_blob(entry->sha1)->object;
-			refs->ref[i++] = obj;
-		}
-				
-		set_object_refs(&item->object, refs);
+void free_tree_entry_list(struct tree_entry_list *list)
+{
+	while (list) {
+		struct tree_entry_list *next = list->next;
+		free(list);
+		list = next;
 	}
-
-	return 0;
 }
 
 int parse_tree(struct tree *item)
diff --git a/tree.h b/tree.h
index a27bae4..c7b5248 100644
--- a/tree.h
+++ b/tree.h
@@ -20,9 +20,11 @@ struct tree {
 	struct object object;
 	void *buffer;
 	unsigned long size;
-	struct tree_entry_list *entries;
 };
 
+struct tree_entry_list *create_tree_entry_list(struct tree *);
+void free_tree_entry_list(struct tree_entry_list *);
+
 struct tree *lookup_tree(const unsigned char *sha1);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
-- 
1.3.3.gcd01d
