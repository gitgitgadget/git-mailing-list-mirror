From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [1/4] Report info from trees
Date: Mon, 18 Apr 2005 21:51:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504182148330.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:48:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhq3-0001de-4H
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDSBvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDSBvp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:51:45 -0400
Received: from iabervon.org ([66.92.72.58]:19974 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261263AbVDSBvk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 21:51:40 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNhu7-0004Oe-00; Mon, 18 Apr 2005 21:51:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds actual information to struct tree, making it possible to
tell what sorts of things the referenced objects are. This is needed for
http-pull, and Junio wanted something of the sort.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: tree.c
===================================================================
--- 1172a9b8f45b2fd640985595cc5258db3b027828/tree.c  (mode:100644 sha1:7c5e5e46f4967b0812b06c0114946c3a6432c8d8)
+++ 7e5a0d93117ecadfb15de3a6bebdb1aa94234fde/tree.c  (mode:100644 sha1:39f9cbd1908e9046c148339f816025c9313ec142)
@@ -27,6 +27,7 @@
 	char type[20];
 	void *buffer, *bufptr;
 	unsigned long size;
+	struct tree_entry_list **list_p;
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed = 1;
@@ -38,8 +39,10 @@
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
@@ -48,6 +51,11 @@
 		    sscanf(bufptr, "%o", &mode) != 1)
 			return -1;
 
+		entry = malloc(sizeof(struct tree_entry_list));
+		entry->directory = S_ISDIR(mode);
+		entry->executable = mode & S_IXUSR;
+		entry->next = NULL;
+
 		/* Warn about trees that don't do the recursive thing.. */
 		if (strchr(path, '/')) {
 			item->has_full_path = 1;
@@ -56,12 +64,17 @@
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
--- 1172a9b8f45b2fd640985595cc5258db3b027828/tree.h  (mode:100644 sha1:14ebbacded09d5e058c7f94652dcb9e12bc31cae)
+++ 7e5a0d93117ecadfb15de3a6bebdb1aa94234fde/tree.h  (mode:100644 sha1:985500e2a9130fe8c33134ca121838af9320c465)
@@ -5,9 +5,20 @@
 
 extern const char *tree_type;
 
+struct tree_entry_list {
+	struct tree_entry_list *next;
+	unsigned directory : 1;
+	unsigned executable : 1;
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

