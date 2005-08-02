From: barkalow@iabervon.org
Subject: [PATCH 1/3] Object library enhancements
Date: Tue, 2 Aug 2005 19:45:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0508021945200.23721@iabervon.org>
References: <Pine.LNX.4.62.0508021939320.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 01:43:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E06PQ-0005Jw-4L
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 01:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVHBXmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 19:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVHBXmw
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 19:42:52 -0400
Received: from iabervon.org ([66.92.72.58]:4363 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261910AbVHBXmv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 19:42:51 -0400
Received: (qmail 5079 invoked by uid 1000); 2 Aug 2005 19:45:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Aug 2005 19:45:48 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.62.0508021939320.23721@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add function to look up an object which is entirely unknown, so that
it can be put in a list. Various other functions related to lists of
objects.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 object.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 object.h |   10 ++++++++++
 tree.h   |    1 +
 3 files changed, 65 insertions(+), 1 deletions(-)

6f610ea3a0118fd7bcda89b75b538d3711418b72
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
@@ -150,3 +173,33 @@ struct object *parse_object(const unsign
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
+
+int object_list_contains(struct object_list *list, struct object *obj)
+{
+	while (list) {
+		if (list->item == obj)
+			return 1;
+		list = list->next;
+	}
+	return 0;
+}
diff --git a/object.h b/object.h
--- a/object.h
+++ b/object.h
@@ -31,8 +31,18 @@ void created_object(const unsigned char 
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
+int object_list_contains(struct object_list *list, struct object *obj);
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
