From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [2/5] Implementations of parsing functions
Date: Sun, 17 Apr 2005 22:36:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504172235260.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:32:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNM3u-0001fK-Kc
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVDRCg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVDRCg2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:36:28 -0400
Received: from iabervon.org ([66.92.72.58]:31494 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261608AbVDRCgG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:36:06 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNM7Y-0004zy-00; Sun, 17 Apr 2005 22:36:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This implements the parsing functions.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: blob.c
===================================================================
--- /dev/null  (tree:5ca133e1b74aee39b2124c0ec9fd51539babb5e0)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/blob.c  (mode:100644 sha1:04e0c1da9b1f4cdb1d1c5881b785babd3b0ceb09)
@@ -0,0 +1,24 @@
+#include "blob.h"
+#include "cache.h"
+#include <stdlib.h>
+
+const char *blob_type = "blob";
+
+struct blob *lookup_blob(unsigned char *sha1)
+{
+	struct object *obj = lookup_object(sha1);
+	if (!obj) {
+		struct blob *ret = malloc(sizeof(struct blob));
+		bzero(ret, sizeof(struct blob));
+		created_object(sha1, &ret->object);
+		ret->object.type = blob_type;
+		ret->object.parsed = 1;
+		return ret;
+	}
+	if (obj->parsed && obj->type != blob_type) {
+		error("Object %s is a %s, not a blob", 
+		      sha1_to_hex(sha1), obj->type);
+		return NULL;
+	}
+	return (struct blob *) obj;
+}
Index: commit.c
===================================================================
--- /dev/null  (tree:5ca133e1b74aee39b2124c0ec9fd51539babb5e0)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/commit.c  (mode:100644 sha1:0099baa63971d86ee30ef2a7da25057f0f45a964)
@@ -0,0 +1,85 @@
+#include "commit.h"
+#include "cache.h"
+#include <string.h>
+
+const char *commit_type = "commit";
+
+struct commit *lookup_commit(unsigned char *sha1)
+{
+	struct object *obj = lookup_object(sha1);
+	if (!obj) {
+		struct commit *ret = malloc(sizeof(struct commit));
+		bzero(ret, sizeof(struct commit));
+		created_object(sha1, &ret->object);
+		return ret;
+	}
+	if (obj->parsed && obj->type != commit_type) {
+		error("Object %s is a %s, not a commit", 
+		      sha1_to_hex(sha1), obj->type);
+		return NULL;
+	}
+	return (struct commit *) obj;
+}
+
+static unsigned long parse_commit_date(const char *buf)
+{
+	unsigned long date;
+
+	if (memcmp(buf, "author", 6))
+		return 0;
+	while (*buf++ != '\n')
+		/* nada */;
+	if (memcmp(buf, "committer", 9))
+		return 0;
+	while (*buf++ != '>')
+		/* nada */;
+	date = strtoul(buf, NULL, 10);
+	if (date == ULONG_MAX)
+		date = 0;
+	return date;
+}
+
+int parse_commit(struct commit *item)
+{
+	char type[20];
+	void * buffer, *bufptr;
+	unsigned long size;
+	unsigned char parent[20];
+	if (item->object.parsed)
+		return 0;
+	item->object.parsed = 1;
+	buffer = bufptr = read_sha1_file(item->object.sha1, type, &size);
+	if (!buffer)
+		return error("Could not read %s",
+			     sha1_to_hex(item->object.sha1));
+	if (strcmp(type, commit_type))
+		return error("Object %s not a commit",
+			     sha1_to_hex(item->object.sha1));
+	item->object.type = commit_type;
+	get_sha1_hex(bufptr + 5, parent);
+	item->tree = lookup_tree(parent);
+	add_ref(&item->object, &item->tree->object);
+	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
+	while (!memcmp(bufptr, "parent ", 7) &&
+	       !get_sha1_hex(bufptr + 7, parent)) {
+		struct commit_list *new_parent = 
+			malloc(sizeof(struct commit_list));
+		new_parent->next = item->parents;
+		new_parent->item = lookup_commit(parent);
+		add_ref(&item->object, &new_parent->item->object);
+		item->parents = new_parent;
+		bufptr += 48;
+	}
+	item->date = parse_commit_date(bufptr);
+	free(buffer);
+	return 0;
+}
+
+void free_commit_list(struct commit_list *list)
+{
+	while (list) {
+		struct commit_list *temp = list;
+		list = temp->next;
+		free(temp);
+	}
+}
Index: object.c
===================================================================
--- /dev/null  (tree:5ca133e1b74aee39b2124c0ec9fd51539babb5e0)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/object.c  (mode:100644 sha1:986624ac7a7fd9229e05e1f181fd500640298d9e)
@@ -0,0 +1,96 @@
+#include "object.h"
+#include "cache.h"
+#include <stdlib.h>
+#include <string.h>
+
+struct object **objs;
+int nr_objs;
+static int obj_allocs;
+
+static int find_object(unsigned char *sha1)
+{
+	int first = 0, last = nr_objs;
+
+        while (first < last) {
+                int next = (first + last) / 2;
+                struct object *obj = objs[next];
+                int cmp;
+
+                cmp = memcmp(sha1, obj->sha1, 20);
+                if (!cmp)
+                        return next;
+                if (cmp < 0) {
+                        last = next;
+                        continue;
+                }
+                first = next+1;
+        }
+        return -first-1;
+}
+
+struct object *lookup_object(unsigned char *sha1)
+{
+	int pos = find_object(sha1);
+	if (pos >= 0)
+		return objs[pos];
+	return NULL;
+}
+
+void created_object(unsigned char *sha1, struct object *obj)
+{
+	int pos = find_object(sha1);
+
+	obj->parsed = 0;
+	memcpy(obj->sha1, sha1, 20);
+	obj->type = NULL;
+	obj->refs = NULL;
+	obj->used = 0;
+
+	if (pos >= 0)
+		die("Inserting %s twice\n", sha1_to_hex(sha1));
+	pos = -pos-1;
+
+	if (obj_allocs == nr_objs) {
+		obj_allocs = alloc_nr(obj_allocs);
+		objs = realloc(objs, obj_allocs * sizeof(struct object *));
+	}
+
+	/* Insert it into the right place */
+	memmove(objs + pos + 1, objs + pos, (nr_objs - pos) * 
+		sizeof(struct object *));
+
+	objs[pos] = obj;
+	nr_objs++;
+}
+
+void add_ref(struct object *refer, struct object *target)
+{
+	struct object_list **pp = &refer->refs;
+	struct object_list *p;
+	
+	while ((p = *pp) != NULL) {
+		if (p->item == target)
+			return;
+		pp = &p->next;
+	}
+
+	target->used = 1;
+	p = malloc(sizeof(*p));
+	p->item = target;
+	p->next = NULL;
+	*pp = p;
+}
+
+void mark_reachable(struct object *obj, unsigned int mask)
+{
+	struct object_list *p = obj->refs;
+
+	/* If we've been here already, don't bother */
+	if (obj->flags & mask)
+		return;
+	obj->flags |= mask;
+	while (p) {
+		mark_reachable(p->item, mask);
+		p = p->next;
+	}
+}
Index: tree.c
===================================================================
--- /dev/null  (tree:5ca133e1b74aee39b2124c0ec9fd51539babb5e0)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/tree.c  (mode:100644 sha1:7c5e5e46f4967b0812b06c0114946c3a6432c8d8)
@@ -0,0 +1,67 @@
+#include "tree.h"
+#include "blob.h"
+#include "cache.h"
+#include <stdlib.h>
+
+const char *tree_type = "tree";
+
+struct tree *lookup_tree(unsigned char *sha1)
+{
+	struct object *obj = lookup_object(sha1);
+	if (!obj) {
+		struct tree *ret = malloc(sizeof(struct tree));
+		bzero(ret, sizeof(struct tree));
+		created_object(sha1, &ret->object);
+		return ret;
+	}
+	if (obj->parsed && obj->type != tree_type) {
+		error("Object %s is a %s, not a tree", 
+		      sha1_to_hex(sha1), obj->type);
+		return NULL;
+	}
+	return (struct tree *) obj;
+}
+
+int parse_tree(struct tree *item)
+{
+	char type[20];
+	void *buffer, *bufptr;
+	unsigned long size;
+	if (item->object.parsed)
+		return 0;
+	item->object.parsed = 1;
+	item->object.type = tree_type;
+	buffer = bufptr = read_sha1_file(item->object.sha1, type, &size);
+	if (!buffer)
+		return error("Could not read %s",
+			     sha1_to_hex(item->object.sha1));
+	if (strcmp(type, tree_type))
+		return error("Object %s not a tree",
+			     sha1_to_hex(item->object.sha1));
+	while (size) {
+		struct object *obj;
+		int len = 1+strlen(bufptr);
+		unsigned char *file_sha1 = bufptr + len;
+		char *path = strchr(bufptr, ' ');
+		unsigned int mode;
+		if (size < len + 20 || !path || 
+		    sscanf(bufptr, "%o", &mode) != 1)
+			return -1;
+
+		/* Warn about trees that don't do the recursive thing.. */
+		if (strchr(path, '/')) {
+			item->has_full_path = 1;
+		}
+
+		bufptr += len + 20;
+		size -= len + 20;
+
+		if (S_ISDIR(mode)) {
+			obj = &lookup_tree(file_sha1)->object;
+		} else {
+			obj = &lookup_blob(file_sha1)->object;
+		}
+		add_ref(&item->object, obj);
+	}
+	return 0;
+}

