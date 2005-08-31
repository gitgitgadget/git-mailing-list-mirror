From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Object model additions for read-tree
Date: Tue, 30 Aug 2005 23:49:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508302348350.23242@iabervon.org>
References: <Pine.LNX.4.63.0508302317380.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 05:46:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAJXW-0002WI-SD
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 05:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVHaDp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 23:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVHaDp0
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 23:45:26 -0400
Received: from iabervon.org ([66.92.72.58]:22021 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932348AbVHaDpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2005 23:45:25 -0400
Received: (qmail 32450 invoked by uid 1000); 30 Aug 2005 23:49:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Aug 2005 23:49:10 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0508302317380.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7969>

Adds object_list_append() and a function to get the struct tree from an ent.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 object.c |   11 +++++++++++
 object.h |    3 +++
 tree.c   |   19 +++++++++++++++++++
 tree.h   |    3 +++
 4 files changed, 36 insertions(+), 0 deletions(-)

49d33c385aa69d17c991300f73e77c6718a2b4a6
diff --git a/object.c b/object.c
--- a/object.c
+++ b/object.c
@@ -184,6 +184,17 @@ struct object_list *object_list_insert(s
         return new_list;
 }

+void object_list_append(struct object *item,
+			struct object_list **list_p)
+{
+	while (*list_p) {
+		list_p = &((*list_p)->next);
+	}
+	*list_p = xmalloc(sizeof(struct object_list));
+	(*list_p)->next = NULL;
+	(*list_p)->item = item;
+}
+
 unsigned object_list_length(struct object_list *list)
 {
 	unsigned ret = 0;
diff --git a/object.h b/object.h
--- a/object.h
+++ b/object.h
@@ -41,6 +41,9 @@ void mark_reachable(struct object *obj,
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);

+void object_list_append(struct object *item,
+			struct object_list **list_p);
+
 unsigned object_list_length(struct object_list *list);

 int object_list_contains(struct object_list *list, struct object *obj);
diff --git a/tree.c b/tree.c
--- a/tree.c
+++ b/tree.c
@@ -1,5 +1,7 @@
 #include "tree.h"
 #include "blob.h"
+#include "commit.h"
+#include "tag.h"
 #include "cache.h"
 #include <stdlib.h>

@@ -212,3 +214,20 @@ int parse_tree(struct tree *item)
 	free(buffer);
 	return ret;
 }
+
+struct tree *parse_tree_indirect(const unsigned char *sha1)
+{
+	struct object *obj = parse_object(sha1);
+	do {
+		if (!obj)
+			return NULL;
+		if (obj->type == tree_type)
+			return (struct tree *) obj;
+		else if (obj->type == commit_type)
+			return ((struct commit *) obj)->tree;
+		else if (obj->type == tag_type)
+			obj = ((struct tag *) obj)->tagged;
+		else
+			return NULL;
+	} while (1);
+}
diff --git a/tree.h b/tree.h
--- a/tree.h
+++ b/tree.h
@@ -32,4 +32,7 @@ int parse_tree_buffer(struct tree *item,

 int parse_tree(struct tree *tree);

+/* Parses and returns the tree in the given ent, chasing tags and commits. */
+struct tree *parse_tree_indirect(const unsigned char *sha1);
+
 #endif /* TREE_H */
