From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 6/6] get rid of lookup_object_type()
Date: Mon, 26 Feb 2007 14:56:00 -0500
Message-ID: <11725197723910-git-send-email-nico@cam.org>
References: <11725197603476-git-send-email-nico@cam.org>
 <1172519760216-git-send-email-nico@cam.org>
 <11725197613482-git-send-email-nico@cam.org>
 <11725197622423-git-send-email-nico@cam.org>
 <11725197633144-git-send-email-nico@cam.org>
 <11725197632516-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlxd-0004Dt-17
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbXBZT4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbXBZT4T
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:56:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36667 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030501AbXBZT4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:56:14 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE3007SW61CD1Q1@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Feb 2007 14:56:12 -0500 (EST)
In-reply-to: <11725197632516-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.572.ge86d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40657>

This function is called only once in the whole source tree.  Let's move
its code inline instead, which is also in the spirit of removing as much
object type char arrays as possible (not that this patch does anything for
that but at least it is now a local matter).

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 object.c |   18 ------------------
 object.h |    3 ---
 tag.c    |   21 ++++++++++++++++++---
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/object.c b/object.c
index 0e67af3..5b46889 100644
--- a/object.c
+++ b/object.c
@@ -120,24 +120,6 @@ void created_object(const unsigned char *sha1, struct object *obj)
 	nr_objs++;
 }
 
-struct object *lookup_object_type(const unsigned char *sha1, const char *type)
-{
-	if (!type) {
-		return lookup_unknown_object(sha1);
-	} else if (!strcmp(type, blob_type)) {
-		return &lookup_blob(sha1)->object;
-	} else if (!strcmp(type, tree_type)) {
-		return &lookup_tree(sha1)->object;
-	} else if (!strcmp(type, commit_type)) {
-		return &lookup_commit(sha1)->object;
-	} else if (!strcmp(type, tag_type)) {
-		return &lookup_tag(sha1)->object;
-	} else {
-		error("Unknown type %s", type);
-		return NULL;
-	}
-}
-
 union any_object {
 	struct object object;
 	struct commit commit;
diff --git a/object.h b/object.h
index 749a6f5..bdbf0fa 100644
--- a/object.h
+++ b/object.h
@@ -47,9 +47,6 @@ extern struct object_refs *lookup_object_refs(struct object *);
 /** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
 
-/** Returns the object, having looked it up as being the given type. **/
-struct object *lookup_object_type(const unsigned char *sha1, const char *type);
-
 void created_object(const unsigned char *sha1, struct object *obj);
 
 /** Returns the object, having parsed it to find out what it is. **/
diff --git a/tag.c b/tag.c
index 30ffc17..56a49f4 100644
--- a/tag.c
+++ b/tag.c
@@ -1,5 +1,8 @@
 #include "cache.h"
 #include "tag.h"
+#include "commit.h"
+#include "tree.h"
+#include "blob.h"
 
 const char *tag_type = "tag";
 
@@ -37,7 +40,7 @@ struct tag *lookup_tag(const unsigned char *sha1)
 int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 {
 	int typelen, taglen;
-	unsigned char object[20];
+	unsigned char sha1[20];
 	const char *type_line, *tag_line, *sig_line;
 	char type[20];
 
@@ -47,7 +50,7 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 
 	if (size < 64)
 		return -1;
-	if (memcmp("object ", data, 7) || get_sha1_hex((char *) data + 7, object))
+	if (memcmp("object ", data, 7) || get_sha1_hex((char *) data + 7, sha1))
 		return -1;
 
 	type_line = (char *) data + 48;
@@ -73,7 +76,19 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 	memcpy(item->tag, tag_line + 4, taglen);
 	item->tag[taglen] = '\0';
 
-	item->tagged = lookup_object_type(object, type);
+	if (!strcmp(type, blob_type)) {
+		item->tagged = &lookup_blob(sha1)->object;
+	} else if (!strcmp(type, tree_type)) {
+		item->tagged = &lookup_tree(sha1)->object;
+	} else if (!strcmp(type, commit_type)) {
+		item->tagged = &lookup_commit(sha1)->object;
+	} else if (!strcmp(type, tag_type)) {
+		item->tagged = &lookup_tag(sha1)->object;
+	} else {
+		error("Unknown type %s", type);
+		item->tagged = NULL;
+	}
+
 	if (item->tagged && track_object_refs) {
 		struct object_refs *refs = alloc_object_refs(1);
 		refs->ref[0] = item->tagged;
-- 
1.5.0.572.ge86d
