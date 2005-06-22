From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Parse tags for absent objects
Date: Tue, 21 Jun 2005 20:35:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506212029190.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 22 02:31:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkt97-0008An-9N
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 02:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVFVAhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 20:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVFVAhG
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 20:37:06 -0400
Received: from iabervon.org ([66.92.72.58]:40198 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262397AbVFVAgh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 20:36:37 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DktCw-0003Hl-00; Tue, 21 Jun 2005 20:35:10 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0506212029190.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Handle parsing a tag for a non-present object. This adds a function to lookup
an object with lookup_* for * in a string, so that it can get the right storage
based on the "type" line in the tag.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

Index: object.c
===================================================================
--- 5760644db3f9cb044c99aa0f9ce4fc8d4eb76da1/object.c  (mode:100644 sha1:5e8378857028afeb4d1cd91c0de26c8414e137de)
+++ d0df139324abdbf701ffcae26e43bcb0350c270e/object.c  (mode:100644 sha1:21f872ee163e9eeff1a52854791c5b96a2ec2ceb)
@@ -98,6 +98,22 @@
 	}
 }
 
+struct object *lookup_object_type(const unsigned char *sha1, const char *type)
+{
+	if (!strcmp(type, blob_type)) {
+		return &lookup_blob(sha1)->object;
+	} else if (!strcmp(type, tree_type)) {
+		return &lookup_tree(sha1)->object;
+	} else if (!strcmp(type, commit_type)) {
+		return &lookup_commit(sha1)->object;
+	} else if (!strcmp(type, tag_type)) {
+		return &lookup_tag(sha1)->object;
+	} else {
+		error("Unknown type %s", type);
+		return NULL;
+	}
+}
+
 struct object *parse_object(const unsigned char *sha1)
 {
 	unsigned long mapsize;
Index: object.h
===================================================================
--- 5760644db3f9cb044c99aa0f9ce4fc8d4eb76da1/object.h  (mode:100644 sha1:ca455d57117af5f15e83b791a336351b43af6716)
+++ d0df139324abdbf701ffcae26e43bcb0350c270e/object.h  (mode:100644 sha1:1bd59ac6fcf7798e02c2474e630c282f022eff10)
@@ -21,8 +21,12 @@
 extern int nr_objs;
 extern struct object **objs;
 
+/** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
 
+/** Returns the object, having looked it up as being the given type. **/
+struct object *lookup_object_type(const unsigned char *sha1, const char *type);
+
 void created_object(const unsigned char *sha1, struct object *obj);
 
 /** Returns the object, having parsed it to find out what it is. **/
Index: tag.c
===================================================================
--- 5760644db3f9cb044c99aa0f9ce4fc8d4eb76da1/tag.c  (mode:100644 sha1:4041af2572a4427a03bc8955137b7d2211f9d770)
+++ d0df139324abdbf701ffcae26e43bcb0350c270e/tag.c  (mode:100644 sha1:2b25fc0e1dc53234e38e8ed8fdc1cb99fa4fd84a)
@@ -28,6 +28,7 @@
 	int typelen, taglen;
 	unsigned char object[20];
 	const char *type_line, *tag_line, *sig_line;
+	char type[20];
 
         if (item->object.parsed)
                 return 0;
@@ -38,10 +39,6 @@
 	if (memcmp("object ", data, 7) || get_sha1_hex(data + 7, object))
 		return -1;
 
-	item->tagged = parse_object(object);
-	if (item->tagged)
-		add_ref(&item->object, item->tagged);
-
 	type_line = data + 48;
 	if (memcmp("\ntype ", type_line-1, 6))
 		return -1;
@@ -58,11 +55,17 @@
 	typelen = tag_line - type_line - strlen("type \n");
 	if (typelen >= 20)
 		return -1;
+	memcpy(type, type_line + 5, typelen);
+	type[typelen] = '\0';
 	taglen = sig_line - tag_line - strlen("tag \n");
 	item->tag = xmalloc(taglen + 1);
 	memcpy(item->tag, tag_line + 4, taglen);
 	item->tag[taglen] = '\0';
 
+	item->tagged = lookup_object_type(object, type);
+	if (item->tagged)
+		add_ref(&item->object, item->tagged);
+
 	return 0;
 }
 

