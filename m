From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/4] Add raw tree buffer info to "struct tree"
Date: Sun, 28 May 2006 15:07:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605281504400.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605281453460.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 00:07:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkTPq-0004w2-BN
	for gcvg-git@gmane.org; Mon, 29 May 2006 00:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWE1WHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 18:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWE1WHO
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 18:07:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46209 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750995AbWE1WHN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 18:07:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4SM782g030458
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 May 2006 15:07:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4SM77e4015755;
	Sun, 28 May 2006 15:07:08 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605281453460.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20902>


This allows us to avoid allocating information for names etc, because
we can just use the information from the tree buffer directly.

We still keep the old "tree_entry_list" in struct tree as well, so old 
users aren't affected, apart from the fact that the allocations are 
different (if you free a tree entry, you should no longer free the name 
allocation for it, since it's allocated as part of "tree->buffer")

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index ec40d01..740a8c7 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -38,7 +38,7 @@ static struct tree_entry_list df_conflic
 
 typedef int (*merge_fn_t)(struct cache_entry **src);
 
-static int entcmp(char *name1, int dir1, char *name2, int dir2)
+static int entcmp(const char *name1, int dir1, const char *name2, int dir2)
 {
 	int len1 = strlen(name1);
 	int len2 = strlen(name2);
@@ -66,7 +66,7 @@ static int unpack_trees_rec(struct tree_
 	int src_size = len + 1;
 	do {
 		int i;
-		char *first;
+		const char *first;
 		int firstdir = 0;
 		int pathlen;
 		unsigned ce_size;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 5277d3c..72c1549 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -136,10 +136,11 @@ static struct object_list **process_tree
 			p = process_tree(entry->item.tree, p, &me, entry->name);
 		else
 			p = process_blob(entry->item.blob, p, &me, entry->name);
-		free(entry->name);
 		free(entry);
 		entry = next;
 	}
+	free(tree->buffer);
+	tree->buffer = NULL;
 	return p;
 }
 
diff --git a/fsck-objects.c b/fsck-objects.c
index 59b2590..a0290b0 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -197,17 +197,16 @@ static int fsck_tree(struct tree *item)
 			default:
 				break;
 			}
-			free(last->name);
 			free(last);
 		}
 
 		last = entry;
 	}
-	if (last) {
-		free(last->name);
+	if (last)
 		free(last);
-	}
 	item->entries = NULL;
+	free(item->buffer);
+	item->buffer = NULL;
 
 	retval = 0;
 	if (has_full_path) {
diff --git a/object.c b/object.c
index 4d46e0d..1a7823c 100644
--- a/object.c
+++ b/object.c
@@ -200,8 +200,11 @@ struct object *parse_object(const unsign
 			obj = &blob->object;
 		} else if (!strcmp(type, tree_type)) {
 			struct tree *tree = lookup_tree(sha1);
-			parse_tree_buffer(tree, buffer, size);
 			obj = &tree->object;
+			if (!tree->object.parsed) {
+				parse_tree_buffer(tree, buffer, size);
+				buffer = NULL;
+			}
 		} else if (!strcmp(type, commit_type)) {
 			struct commit *commit = lookup_commit(sha1);
 			parse_commit_buffer(commit, buffer, size);
diff --git a/tree.c b/tree.c
index d599fb5..1e76d9c 100644
--- a/tree.c
+++ b/tree.c
@@ -3,6 +3,7 @@ #include "tree.h"
 #include "blob.h"
 #include "commit.h"
 #include "tag.h"
+#include "tree-walk.h"
 #include <stdlib.h>
 
 const char *tree_type = "tree";
@@ -145,46 +146,45 @@ struct tree *lookup_tree(const unsigned 
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 {
-	void *bufptr = buffer;
+	struct tree_desc desc;
 	struct tree_entry_list **list_p;
 	int n_refs = 0;
 
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed = 1;
+	item->buffer = buffer;
+	item->size = size;
+
+	desc.buf = buffer;
+	desc.size = size;
+
 	list_p = &item->entries;
-	while (size) {
-		struct object *obj;
+	while (desc.size) {
+		unsigned mode;
+		const char *path;
+		const unsigned char *sha1;
 		struct tree_entry_list *entry;
-		int len = 1+strlen(bufptr);
-		unsigned char *file_sha1 = bufptr + len;
-		char *path = strchr(bufptr, ' ');
-		unsigned int mode;
-		if (size < len + 20 || !path || 
-		    sscanf(bufptr, "%o", &mode) != 1)
-			return -1;
+
+		sha1 = tree_entry_extract(&desc, &path, &mode);
 
 		entry = xmalloc(sizeof(struct tree_entry_list));
-		entry->name = strdup(path + 1);
+		entry->name = path;
+		entry->mode = mode;
 		entry->directory = S_ISDIR(mode) != 0;
 		entry->executable = (mode & S_IXUSR) != 0;
 		entry->symlink = S_ISLNK(mode) != 0;
-		entry->zeropad = *(char *)bufptr == '0';
-		entry->mode = mode;
+		entry->zeropad = *(const char *)(desc.buf) == '0';
 		entry->next = NULL;
 
-		bufptr += len + 20;
-		size -= len + 20;
+		update_tree_entry(&desc);
 
 		if (entry->directory) {
-			entry->item.tree = lookup_tree(file_sha1);
-			obj = &entry->item.tree->object;
+			entry->item.tree = lookup_tree(sha1);
 		} else {
-			entry->item.blob = lookup_blob(file_sha1);
-			obj = &entry->item.blob->object;
+			entry->item.blob = lookup_blob(sha1);
 		}
-		if (obj)
-			n_refs++;
+		n_refs++;
 		*list_p = entry;
 		list_p = &entry->next;
 	}
@@ -206,7 +206,6 @@ int parse_tree(struct tree *item)
 	 char type[20];
 	 void *buffer;
 	 unsigned long size;
-	 int ret;
 
 	if (item->object.parsed)
 		return 0;
@@ -219,9 +218,7 @@ int parse_tree(struct tree *item)
 		return error("Object %s not a tree",
 			     sha1_to_hex(item->object.sha1));
 	}
-	ret = parse_tree_buffer(item, buffer, size);
-	free(buffer);
-	return ret;
+	return parse_tree_buffer(item, buffer, size);
 }
 
 struct tree *parse_tree_indirect(const unsigned char *sha1)
diff --git a/tree.h b/tree.h
index 330ab64..066ac5d 100644
--- a/tree.h
+++ b/tree.h
@@ -12,7 +12,7 @@ struct tree_entry_list {
 	unsigned symlink : 1;
 	unsigned zeropad : 1;
 	unsigned int mode;
-	char *name;
+	const char *name;
 	union {
 		struct object *any;
 		struct tree *tree;
@@ -22,6 +22,8 @@ struct tree_entry_list {
 
 struct tree {
 	struct object object;
+	void *buffer;
+	unsigned long size;
 	struct tree_entry_list *entries;
 };
 
