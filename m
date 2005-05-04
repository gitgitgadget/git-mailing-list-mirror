From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] Fix memory leaks in git-fsck-cache
Date: Wed, 4 May 2005 21:44:15 +0400
Message-ID: <20050504174415.GC29536@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 19:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTNpR-0000OW-SS
	for gcvg-git@gmane.org; Wed, 04 May 2005 19:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVEDRoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 13:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVEDRoy
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 13:44:54 -0400
Received: from mivlgu.ru ([81.18.140.87]:47327 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S261254AbVEDRoT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 13:44:19 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 4792018011A; Wed,  4 May 2005 21:44:15 +0400 (MSD)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch fixes memory leaks in parse_object() and related functions;
these leaks were very noticeable when running git-fsck-cache.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

---

 blob.c   |    1 +
 commit.c |    4 +++-
 object.c |    3 ++-
 tag.c    |   21 ++++++++++++++-------
 tree.c   |    9 +++++++--
 5 files changed, 27 insertions(+), 11 deletions(-)

Index: blob.c
===================================================================
--- 51a882a2dc62e0d3cdc79e0badc61559fb723481/blob.c  (mode:100644 sha1:d4af4a309433744d2fe819886d66741ab016f62b)
+++ uncommitted/blob.c  (mode:100644)
@@ -34,6 +34,7 @@ int parse_blob(struct blob *item)
         if (!buffer)
                 return error("Could not read %s",
                              sha1_to_hex(item->object.sha1));
+	free(buffer);
         if (strcmp(type, blob_type))
                 return error("Object %s not a blob",
                              sha1_to_hex(item->object.sha1));
Index: commit.c
===================================================================
--- 51a882a2dc62e0d3cdc79e0badc61559fb723481/commit.c  (mode:100644 sha1:3956c7ba961781f72b39c42368df1e76b2d035dd)
+++ uncommitted/commit.c  (mode:100644)
@@ -54,9 +54,11 @@ int parse_commit(struct commit *item)
 	if (!buffer)
 		return error("Could not read %s",
 			     sha1_to_hex(item->object.sha1));
-	if (strcmp(type, commit_type))
+	if (strcmp(type, commit_type)) {
+		free(buffer);
 		return error("Object %s not a commit",
 			     sha1_to_hex(item->object.sha1));
+	}
 	get_sha1_hex(bufptr + 5, parent);
 	item->tree = lookup_tree(parent);
 	if (item->tree)
Index: object.c
===================================================================
--- 51a882a2dc62e0d3cdc79e0badc61559fb723481/object.c  (mode:100644 sha1:ca4af8fa2dc0672b92310a3ebdd4d14bf070dd69)
+++ uncommitted/object.c  (mode:100644)
@@ -107,11 +107,12 @@ struct object *parse_object(unsigned cha
 		char type[100];
 		unsigned long size;
 		void *buffer = unpack_sha1_file(map, mapsize, type, &size);
+		munmap(map, mapsize);
 		if (!buffer)
 			return NULL;
 		if (check_sha1_signature(sha1, buffer, size, type) < 0)
 			printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
-		munmap(map, mapsize);
+		free(buffer);
 		if (!strcmp(type, "blob")) {
 			struct blob *ret = lookup_blob(sha1);
 			parse_blob(ret);
Index: tag.c
===================================================================
--- 51a882a2dc62e0d3cdc79e0badc61559fb723481/tag.c  (mode:100644 sha1:406dba2aa5607332fe022fcba1beb045fa61c5f4)
+++ uncommitted/tag.c  (mode:100644)
@@ -37,37 +37,44 @@ int parse_tag(struct tag *item)
         if (!data)
                 return error("Could not read %s",
                              sha1_to_hex(item->object.sha1));
-        if (strcmp(type, tag_type))
+        if (strcmp(type, tag_type)) {
+		free(data);
                 return error("Object %s not a tag",
                              sha1_to_hex(item->object.sha1));
+	}
 
 	if (size < 64)
-		return -1;
+		goto err;
 	if (memcmp("object ", data, 7) || get_sha1_hex(data + 7, object))
-		return -1;
+		goto err;
 
 	item->tagged = parse_object(object);
 
 	type_line = data + 48;
 	if (memcmp("\ntype ", type_line-1, 6))
-		return -1;
+		goto err;
 
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line || memcmp("tag ", ++tag_line, 4))
-		return -1;
+		goto err;
 
 	sig_line = strchr(tag_line, '\n');
 	if (!sig_line)
-		return -1;
+		goto err;
 	sig_line++;
 
 	typelen = tag_line - type_line - strlen("type \n");
 	if (typelen >= 20)
-		return -1;
+		goto err;
 	taglen = sig_line - tag_line - strlen("tag \n");
 	item->tag = xmalloc(taglen + 1);
 	memcpy(item->tag, tag_line + 4, taglen);
 	item->tag[taglen] = '\0';
 
+	free(data);
 	return 0;
+
+err:
+	free(data);
+	return -1;
 }
Index: tree.c
===================================================================
--- 51a882a2dc62e0d3cdc79e0badc61559fb723481/tree.c  (mode:100644 sha1:72305a357b6694cdb1b29dad9975902fdef86457)
+++ uncommitted/tree.c  (mode:100644)
@@ -101,9 +101,11 @@ int parse_tree(struct tree *item)
 	if (!buffer)
 		return error("Could not read %s",
 			     sha1_to_hex(item->object.sha1));
-	if (strcmp(type, tree_type))
+	if (strcmp(type, tree_type)) {
+		free(buffer);
 		return error("Object %s not a tree",
 			     sha1_to_hex(item->object.sha1));
+	}
 	list_p = &item->entries;
 	while (size) {
 		struct object *obj;
@@ -113,8 +115,10 @@ int parse_tree(struct tree *item)
 		char *path = strchr(bufptr, ' ');
 		unsigned int mode;
 		if (size < len + 20 || !path || 
-		    sscanf(bufptr, "%o", &mode) != 1)
+		    sscanf(bufptr, "%o", &mode) != 1) {
+			free(buffer);
 			return -1;
+		}
 
 		entry = xmalloc(sizeof(struct tree_entry_list));
 		entry->name = strdup(path + 1);
@@ -138,5 +142,6 @@ int parse_tree(struct tree *item)
 		*list_p = entry;
 		list_p = &entry->next;
 	}
+	free(buffer);
 	return 0;
 }
