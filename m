From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/4] Add a function for getting a struct tree for an ent.
Date: Mon, 5 Sep 2005 02:03:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509050203270.23242@iabervon.org>
References: <Pine.LNX.4.63.0509050151240.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 08:00:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECA1X-0003oN-Pv
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 08:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVIEF77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 01:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVIEF77
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 01:59:59 -0400
Received: from iabervon.org ([66.92.72.58]:33042 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932222AbVIEF77 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 01:59:59 -0400
Received: (qmail 22862 invoked by uid 1000); 5 Sep 2005 02:03:51 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Sep 2005 02:03:51 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0509050151240.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8085>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 tree.c |   21 +++++++++++++++++++++
 tree.h |    3 +++
 2 files changed, 24 insertions(+), 0 deletions(-)

3bfcc20b6aeff3e1fbcce97a426383c9770a2105
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
 
@@ -212,3 +214,22 @@ int parse_tree(struct tree *item)
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
+			obj = &(((struct commit *) obj)->tree->object);
+		else if (obj->type == tag_type)
+			obj = ((struct tag *) obj)->tagged;
+		else
+			return NULL;
+		if (!obj->parsed)
+			parse_object(obj->sha1);
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
