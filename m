From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Pull misc objects
Date: Tue, 21 Jun 2005 20:35:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506212035140.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506212029190.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 22 02:33:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DktAT-00010g-Tb
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 02:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVFVAiC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 20:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVFVAiC
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 20:38:02 -0400
Received: from iabervon.org ([66.92.72.58]:43014 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262406AbVFVAhV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 20:37:21 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DktDd-0003Hr-00; Tue, 21 Jun 2005 20:35:53 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0506212029190.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make pull fetch whatever is specified, parse it to figure out what it is, and
then process it appropriately. This also supports getting tag objects, and
getting whatever they tag.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: pull.c
===================================================================
--- d0df139324abdbf701ffcae26e43bcb0350c270e/pull.c  (mode:100644 sha1:e70fc02f3bf5b6c626a138d6d76d819fab76f0c8)
+++ b6a510708036fe29a19c33472f5c0b746e2d26d7/pull.c  (mode:100644 sha1:91d9db6c7b1be84e7a5fe21c5194fbf22dadc8cb)
@@ -3,6 +3,8 @@
 #include "cache.h"
 #include "commit.h"
 #include "tree.h"
+#include "tag.h"
+#include "blob.h"
 #include "refs.h"
 
 const char *write_ref = NULL;
@@ -57,6 +59,8 @@
 	return status;
 }
 
+static int process_unknown(unsigned char *sha1);
+
 static int process_tree(unsigned char *sha1)
 {
 	struct tree *tree = lookup_tree(sha1);
@@ -115,6 +119,35 @@
 	return 0;
 }
 
+static int process_tag(unsigned char *sha1)
+{
+	struct tag *obj = lookup_tag(sha1);
+
+	if (parse_tag(obj))
+		return -1;
+	return process_unknown(obj->tagged->sha1);
+}
+
+static int process_unknown(unsigned char *sha1)
+{
+	struct object *obj;
+	if (make_sure_we_have_it("object", sha1))
+		return -1;
+	obj = parse_object(sha1);
+	if (!obj)
+		return error("Unable to parse object %s", sha1_to_hex(sha1));
+	if (obj->type == commit_type)
+		return process_commit(sha1);
+	if (obj->type == tree_type)
+		return process_tree(sha1);
+	if (obj->type == blob_type)
+		return 0;
+	if (obj->type == tag_type)
+		return process_tag(sha1);
+	return error("Unable to determine requirement of type %s for %s",
+		     obj->type, sha1_to_hex(sha1));
+}
+
 static int interpret_target(char *target, unsigned char *sha1)
 {
 	if (!get_sha1_hex(target, sha1))
@@ -142,7 +175,7 @@
 	if (interpret_target(target, sha1))
 		return error("Could not interpret %s as something to pull",
 			     target);
-	if (process_commit(sha1))
+	if (process_unknown(sha1))
 		return -1;
 	
 	if (write_ref) {

