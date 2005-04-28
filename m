From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [1'/5] Mark blobs as parsed when they're actually parsed
Date: Thu, 28 Apr 2005 01:58:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504280155320.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504280131400.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 07:56:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR20i-0002gn-Fh
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVD1GBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 02:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVD1GAM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 02:00:12 -0400
Received: from iabervon.org ([66.92.72.58]:33285 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262145AbVD1F6K (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 01:58:10 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DR22K-0003SL-00; Thu, 28 Apr 2005 01:58:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504280131400.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This eliminates the special case for blobs versus other types of
objects. Now the scheme is entirely regular and I won't introduce stupid
bugs. (And fsck-cache doesn't have to do the do-nothing parse)

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: blob.c
===================================================================
--- 89fdfd09b281fdf5071bc13a30ef683bd6851b61/blob.c  (mode:100644 sha1:3d99b93f020d84c5410c2b1056f2d7446b647d1e)
+++ bcb43fecd82fa6f851e266b7e3873973068d51f3/blob.c  (mode:100644 sha1:d4af4a309433744d2fe819886d66741ab016f62b)
@@ -14,10 +14,28 @@
 		ret->object.type = blob_type;
 		return ret;
 	}
-	if (obj->parsed && obj->type != blob_type) {
+	if (obj->type != blob_type) {
 		error("Object %s is a %s, not a blob", 
 		      sha1_to_hex(sha1), obj->type);
 		return NULL;
 	}
 	return (struct blob *) obj;
 }
+
+int parse_blob(struct blob *item)
+{
+        char type[20];
+        void *buffer;
+        unsigned long size;
+        if (item->object.parsed)
+                return 0;
+        item->object.parsed = 1;
+        buffer = read_sha1_file(item->object.sha1, type, &size);
+        if (!buffer)
+                return error("Could not read %s",
+                             sha1_to_hex(item->object.sha1));
+        if (strcmp(type, blob_type))
+                return error("Object %s not a blob",
+                             sha1_to_hex(item->object.sha1));
+	return 0;
+}
Index: blob.h
===================================================================
--- 89fdfd09b281fdf5071bc13a30ef683bd6851b61/blob.h  (mode:100644 sha1:5cbf6d65ee88e1e0c0f1153af4aa7f80c3c48c16)
+++ bcb43fecd82fa6f851e266b7e3873973068d51f3/blob.h  (mode:100644 sha1:4afad0f067e1979d7ccc4778e254cce6962ad136)
@@ -11,4 +11,6 @@
 
 struct blob *lookup_blob(unsigned char *sha1);
 
+int parse_blob(struct blob *item);
+
 #endif /* BLOB_H */

