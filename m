From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [3/5] Add function to parse an object of unspecified type
Date: Thu, 28 Apr 2005 01:11:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504280106540.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 07:06:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR1EK-0007U8-MP
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVD1FLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVD1FLx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:11:53 -0400
Received: from iabervon.org ([66.92.72.58]:56580 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261986AbVD1FLo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 01:11:44 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DR1JQ-0001mF-00; Thu, 28 Apr 2005 01:11:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds a function that parses an object from the database when we have
to look up its actual type. It also checks the hash of the file, due to
its heritage as part of fsck-cache.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: object.c
===================================================================
--- e08498de8d0216a24378c454597ecb38f65c4ee1/object.c  (mode:100644 sha1:91bbc6e5e2eadfb0a66b14d992eac260d07267f8)
+++ dd06c679f8acb720976073de90a9eeabbc11e951/object.c  (mode:100644 sha1:787cda1f5667cdd4e92b7c18eb115cf125f6df9c)
@@ -1,5 +1,9 @@
 #include "object.h"
+#include "blob.h"
+#include "tree.h"
+#include "commit.h"
 #include "cache.h"
+#include "tag.h"
 #include <stdlib.h>
 #include <string.h>
 
@@ -94,3 +98,39 @@
 		p = p->next;
 	}
 }
+
+struct object *parse_object(unsigned char *sha1)
+{
+	unsigned long mapsize;
+	void *map = map_sha1_file(sha1, &mapsize);
+	if (map) {
+		char type[100];
+		unsigned long size;
+		void *buffer = unpack_sha1_file(map, mapsize, type, &size);
+		if (!buffer)
+			return NULL;
+		if (check_sha1_signature(sha1, buffer, size, type) < 0)
+			printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
+		munmap(map, mapsize);
+		if (!strcmp(type, "blob")) {
+			struct blob *ret = lookup_blob(sha1);
+			//parse_blob(ret);
+			return &ret->object;
+		} else if (!strcmp(type, "tree")) {
+			struct tree *ret = lookup_tree(sha1);
+			parse_tree(ret);
+			return &ret->object;
+		} else if (!strcmp(type, "commit")) {
+			struct commit *ret = lookup_commit(sha1);
+			parse_commit(ret);
+			return &ret->object;
+		} else if (!strcmp(type, "tag")) {
+			struct tag *ret = lookup_tag(sha1);
+			parse_tag(ret);
+			return &ret->object;
+		} else {
+			return NULL;
+		}
+	}
+	return NULL;
+}
Index: object.h
===================================================================
--- e08498de8d0216a24378c454597ecb38f65c4ee1/object.h  (mode:100644 sha1:bc607fd55f6ce4e56ce87766369b5d4d55ec79af)
+++ dd06c679f8acb720976073de90a9eeabbc11e951/object.h  (mode:100644 sha1:d53a35a4d7321b5ec970103208ac576f9f722dff)
@@ -22,6 +22,9 @@
 
 void created_object(unsigned char *sha1, struct object *obj);
 
+/** Returns the object, having parsed it to find out what it is. **/
+struct object *parse_object(unsigned char *sha1);
+
 void add_ref(struct object *refer, struct object *target);
 
 void mark_reachable(struct object *obj, unsigned int mask);

