From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/5] Parse tree objects completely
Date: Sat, 23 Apr 2005 20:10:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504232007150.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:06:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUdK-0006nc-7A
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVDXAKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVDXAKl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:10:41 -0400
Received: from iabervon.org ([66.92.72.58]:65030 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262190AbVDXAKZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:10:25 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPUhl-0008MC-00; Sat, 23 Apr 2005 20:10:33 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds the contents of trees to struct tree.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
commit af03ca2bdc01fdc2565c2914285d9c3ccb1205d3
tree 144a13fb75a39538ec4578792d2c374c6ef50f46
parent fda07b139124925a8000207fb1d91feec1fe675d
author Daniel Barkalow <barkalow@iabervon.org> 1114296377 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1114296377 -0400

    Parse tree objects completely

Index: tree.c
===================================================================
--- e09a6d73a7c6c7a8bfb7e7003a34a507ed97a3b6/tree.c  (mode:100644 sha1:e988aed6a85d15568dcb93b69035b97a24e30cc9)
+++ 144a13fb75a39538ec4578792d2c374c6ef50f46/tree.c  (mode:100644 sha1:79b9625855c017ce0298f62cc398ed4d16964cb1)
@@ -92,6 +92,7 @@
 	char type[20];
 	void *buffer, *bufptr;
 	unsigned long size;
+	struct tree_entry_list **list_p;
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed = 1;
@@ -103,8 +104,10 @@
 	if (strcmp(type, tree_type))
 		return error("Object %s not a tree",
 			     sha1_to_hex(item->object.sha1));
+	list_p = &item->entries;
 	while (size) {
 		struct object *obj;
+		struct tree_entry_list *entry;
 		int len = 1+strlen(bufptr);
 		unsigned char *file_sha1 = bufptr + len;
 		char *path = strchr(bufptr, ' ');
@@ -113,6 +116,12 @@
 		    sscanf(bufptr, "%o", &mode) != 1)
 			return -1;
 
+		entry = malloc(sizeof(struct tree_entry_list));
+		entry->name = strdup(path + 1);
+		entry->directory = S_ISDIR(mode);
+		entry->executable = mode & S_IXUSR;
+		entry->next = NULL;
+
 		/* Warn about trees that don't do the recursive thing.. */
 		if (strchr(path, '/')) {
 			item->has_full_path = 1;
@@ -121,12 +130,17 @@
 		bufptr += len + 20;
 		size -= len + 20;
 
-		if (S_ISDIR(mode)) {
-			obj = &lookup_tree(file_sha1)->object;
+		if (entry->directory) {
+			entry->item.tree = lookup_tree(file_sha1);
+			obj = &entry->item.tree->object;
 		} else {
-			obj = &lookup_blob(file_sha1)->object;
+			entry->item.blob = lookup_blob(file_sha1);
+			obj = &entry->item.blob->object;
 		}
 		add_ref(&item->object, obj);
+
+		*list_p = entry;
+		list_p = &entry->next;
 	}
 	return 0;
 }
Index: tree.h
===================================================================
--- e09a6d73a7c6c7a8bfb7e7003a34a507ed97a3b6/tree.h  (mode:100644 sha1:4d5496de307999f5ada8412259e0e86d2c8092de)
+++ 144a13fb75a39538ec4578792d2c374c6ef50f46/tree.h  (mode:100644 sha1:19b190565957a7a03c34f7efa68a7fe0c6783d04)
@@ -5,9 +5,21 @@
 
 extern const char *tree_type;
 
+struct tree_entry_list {
+	struct tree_entry_list *next;
+	unsigned directory : 1;
+	unsigned executable : 1;
+	char *name;
+	union {
+		struct tree *tree;
+		struct blob *blob;
+	} item;
+};
+
 struct tree {
 	struct object object;
 	unsigned has_full_path : 1;
+	struct tree_entry_list *entries;
 };
 
 struct tree *lookup_tree(unsigned char *sha1);

