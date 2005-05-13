From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/4] Generic support for pulling refs
Date: Fri, 13 May 2005 02:56:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505130253160.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 08:49:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWTyd-000073-9F
	for gcvg-git@gmane.org; Fri, 13 May 2005 08:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVEMG4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 02:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVEMG4k
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 02:56:40 -0400
Received: from iabervon.org ([66.92.72.58]:52485 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262267AbVEMG4b (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 02:56:31 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DWU5g-0008Iz-00; Fri, 13 May 2005 02:56:08 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds a pull method to pull refs, provides dummy implementations for
the existing programs, and uses that method to try to get refs if
requested. It also adds generic support for writing the target to a refs
file.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: http-pull.c
===================================================================
--- adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/http-pull.c  (mode:100644 sha1:024457a9895ab10c4ef18aa6e232d12fdaab4da9)
+++ 90e05f81df7b7fd2c39d252b6f9a2374d4dd0cf5/http-pull.c  (mode:100644 sha1:af4e82fdf9c58a15564d40bef85d57e9f6626727)
@@ -98,6 +98,11 @@
 	return 0;
 }
 
+int fetch_ref(char *dir, char *name, unsigned char *sha1)
+{
+	return -1;
+}
+
 int main(int argc, char **argv)
 {
 	char *commit_id;
Index: local-pull.c
===================================================================
--- adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/local-pull.c  (mode:100644 sha1:3a342ab18390d7ce0df1f970a4961b31548a9417)
+++ 90e05f81df7b7fd2c39d252b6f9a2374d4dd0cf5/local-pull.c  (mode:100644 sha1:73aad965d0b190627aa95726e4feaa2623d31d26)
@@ -18,6 +18,11 @@
 
 static char *path;
 
+int fetch_ref(char *dir, char *name, unsigned char *sha1)
+{
+	return -1;
+}
+
 int fetch(unsigned char *sha1)
 {
 	static int object_name_start = -1;
Index: pull.c
===================================================================
--- adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/pull.c  (mode:100644 sha1:0bed44f4cbf6716cfc3152f35626123992766408)
+++ 90e05f81df7b7fd2c39d252b6f9a2374d4dd0cf5/pull.c  (mode:100644 sha1:d4d858cd638e915096a408ba3c37090a1b460c21)
@@ -3,6 +3,12 @@
 #include "cache.h"
 #include "commit.h"
 #include "tree.h"
+#include "tag.h"
+
+#include "refs.h"
+
+char *write_ref_dir = NULL;
+char *write_ref_name = NULL;
 
 int get_tree = 0;
 int get_history = 0;
@@ -98,16 +104,52 @@
 	return 0;
 }
 
+static int process_tag(unsigned char *sha1)
+{
+	return 0;
+}
+
+static int process_unknown(unsigned char *sha1)
+{
+	struct object *obj;
+	if (make_sure_we_have_it(NULL, sha1))
+		return -1;
+	obj = parse_object(sha1);
+	if (obj->type == commit_type) {
+		memcpy(current_commit_sha1, sha1, 20);
+		return process_commit(sha1);
+	} else if (obj->type == tag_type)
+		return process_tag(sha1);
+	return error("Cannot pull a %s object", obj->type);
+}
+
+static int interpret_target(char *target, unsigned char *sha1)
+{
+	char *dir, *name;
+	if (!get_sha1_hex(target, sha1))
+		return 0;
+	if (!split_ref(&dir, &name, target)) {
+		if (!fetch_ref(dir, name, sha1)) {
+			return 0;
+		}
+	}
+	return -1;
+}
+
 int pull(char *target)
 {
 	int retval;
 	unsigned char sha1[20];
-	retval = get_sha1_hex(target, sha1);
-	if (retval)
-		return retval;
-	retval = make_sure_we_have_it(commitS, sha1);
+	retval = interpret_target(target, sha1);
+	if (retval) {
+		return error("Could not interpret %s as something to pull",
+			     target);
+	}
+	retval = process_unknown(sha1);
 	if (retval)
 		return retval;
-	memcpy(current_commit_sha1, sha1, 20);
-	return process_commit(sha1);
+
+	if (write_ref_dir && write_ref_name)
+		write_split_ref_sha1(write_ref_dir, write_ref_name, sha1);
+	return 0;
 }
Index: pull.h
===================================================================
--- adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/pull.h  (mode:100644 sha1:d2dca02de7c23426e84e9f63762df9428933e8d8)
+++ 90e05f81df7b7fd2c39d252b6f9a2374d4dd0cf5/pull.h  (mode:100644 sha1:de0e9245b68856bcf84c033650b6b3eb151641e2)
@@ -4,6 +4,12 @@
 /** To be provided by the particular implementation. **/
 extern int fetch(unsigned char *sha1);
 
+extern int fetch_ref(char *dir, char *name, unsigned char *sha1);
+
+/** Ref filename to write target to. **/
+extern char *write_ref_dir;
+extern char *write_ref_name;
+
 /** Set to fetch the target tree. */
 extern int get_tree;
 
Index: rpull.c
===================================================================
--- adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/rpull.c  (mode:100644 sha1:b48e63157c66c160b9751603a92831f77106044c)
+++ 90e05f81df7b7fd2c39d252b6f9a2374d4dd0cf5/rpull.c  (mode:100644 sha1:493fcdae670ebb1d93b8c75d3e28798e060d7537)
@@ -22,6 +22,11 @@
 	return ret;
 }
 
+int fetch_ref(char *dir, char *name, unsigned char *sha1)
+{
+	return -1;
+}
+
 int main(int argc, char **argv)
 {
 	char *commit_id;

