From: barkalow@iabervon.org
Subject: [PATCH 1/2] Support for making struct objects for absent objects of
 unknown type
Date: Sun, 31 Jul 2005 21:29:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0507312112360.23721@iabervon.org>
References: <Pine.LNX.4.62.0507312055030.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 03:26:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzP4u-0004Z2-Ib
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 03:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVHAB0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 21:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVHAB0n
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 21:26:43 -0400
Received: from iabervon.org ([66.92.72.58]:25359 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261265AbVHAB0m (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 21:26:42 -0400
Received: (qmail 25036 invoked by uid 1000); 31 Jul 2005 21:29:39 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jul 2005 21:29:39 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0507312055030.23721@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds support for calling lookup_object_type() with NULL for the type, 
which will cause it to allocate enough memory for the largest type. This 
allows struct object_lists for objects that need to be fetched to find out 
what they are.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 object.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 object.h |    8 ++++++++
 tree.h   |    1 +
 3 files changed, 53 insertions(+), 1 deletions(-)

6ed7f76e658c02cb2539a52813fe20d3fd9aa250
diff --git a/object.c b/object.c
--- a/object.c
+++ b/object.c
@@ -99,7 +99,9 @@ void mark_reachable(struct object *obj, 
 
 struct object *lookup_object_type(const unsigned char *sha1, const char *type)
 {
-	if (!strcmp(type, blob_type)) {
+	if (!type) {
+		return lookup_unknown_object(sha1);
+	} else if (!strcmp(type, blob_type)) {
 		return &lookup_blob(sha1)->object;
 	} else if (!strcmp(type, tree_type)) {
 		return &lookup_tree(sha1)->object;
@@ -113,6 +115,27 @@ struct object *lookup_object_type(const 
 	}
 }
 
+union any_object {
+	struct object object;
+	struct commit commit;
+	struct tree tree;
+	struct blob blob;
+	struct tag tag;
+};
+
+struct object *lookup_unknown_object(const unsigned char *sha1)
+{
+	struct object *obj = lookup_object(sha1);
+	if (!obj) {
+		union any_object *ret = xmalloc(sizeof(*ret));
+		memset(ret, 0, sizeof(*ret));
+		created_object(sha1, &ret->object);
+		ret->object.type = NULL;
+		return &ret->object;
+	}
+	return obj;
+}
+
 struct object *parse_object(const unsigned char *sha1)
 {
 	unsigned long size;
@@ -150,3 +173,23 @@ struct object *parse_object(const unsign
 	}
 	return NULL;
 }
+
+struct object_list *object_list_insert(struct object *item,
+				       struct object_list **list_p)
+{
+	struct object_list *new_list = xmalloc(sizeof(struct object_list));
+        new_list->item = item;
+        new_list->next = *list_p;
+        *list_p = new_list;
+        return new_list;
+}
+
+unsigned object_list_length(struct object_list *list)
+{
+	unsigned ret = 0;
+	while (list) {
+		list = list->next;
+		ret++;
+	}
+	return ret;
+}
diff --git a/object.h b/object.h
--- a/object.h
+++ b/object.h
@@ -31,8 +31,16 @@ void created_object(const unsigned char 
 /** Returns the object, having parsed it to find out what it is. **/
 struct object *parse_object(const unsigned char *sha1);
 
+/** Returns the object, with potentially excess memory allocated. **/
+struct object *lookup_unknown_object(const unsigned  char *sha1);
+
 void add_ref(struct object *refer, struct object *target);
 
 void mark_reachable(struct object *obj, unsigned int mask);
 
+struct object_list *object_list_insert(struct object *item, 
+				       struct object_list **list_p);
+
+unsigned object_list_length(struct object_list *list);
+
 #endif /* OBJECT_H */
diff --git a/tree.h b/tree.h
--- a/tree.h
+++ b/tree.h
@@ -14,6 +14,7 @@ struct tree_entry_list {
 	unsigned int mode;
 	char *name;
 	union {
+		struct object *any;
 		struct tree *tree;
 		struct blob *blob;
 	} item;
