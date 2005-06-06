From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/4] Generic support for pulling refs
Date: Mon, 6 Jun 2005 16:38:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506061635070.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:43:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfOPO-0003FA-5T
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 22:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVFFUoX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 16:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVFFUoW
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 16:44:22 -0400
Received: from iabervon.org ([66.92.72.58]:6149 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261680AbVFFUjg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 16:39:36 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DfOMc-0006Z0-00; Mon, 6 Jun 2005 16:38:26 -0400
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds support to pull.c for requesting a reference and writing it to a
file. All of the git-*-pull programs get stubs for now.

Index: http-pull.c
===================================================================
--- 9138b84eb683fc23a285445f7d7fc5a836ba01cb/http-pull.c  (mode:100644 sha1:551663e49234dc9b719ee4abb9f8dc8609d759aa)
+++ 8deba080337c75a41cb456cc8b59000654278e59/http-pull.c  (mode:100644 sha1:4f097e0d0bbd5ae28babf8b685dc3b02747f9f15)
@@ -92,6 +92,11 @@
 	return 0;
 }
 
+int fetch_ref(char *ref, unsigned char *sha1)
+{
+	return -1;
+}
+
 int main(int argc, char **argv)
 {
 	char *commit_id;
Index: local-pull.c
===================================================================
--- 9138b84eb683fc23a285445f7d7fc5a836ba01cb/local-pull.c  (mode:100644 sha1:e5d834ff2f7d6949ca2c7dd2424c65f6431a839b)
+++ 8deba080337c75a41cb456cc8b59000654278e59/local-pull.c  (mode:100644 sha1:867e78dbdd2fc5dacdad3c3e3ab5ef1bfde6ba51)
@@ -73,6 +73,11 @@
 	return -1;
 }
 
+int fetch_ref(char *ref, unsigned char *sha1)
+{
+	return -1;
+}
+
 static const char *local_pull_usage = 
 "git-local-pull [-c] [-t] [-a] [-l] [-s] [-n] [-v] [-d] commit-id path";
 
Index: pull.c
===================================================================
--- 9138b84eb683fc23a285445f7d7fc5a836ba01cb/pull.c  (mode:100644 sha1:cd77738ac62be17e7382bc3b368e686f11f7098d)
+++ 8deba080337c75a41cb456cc8b59000654278e59/pull.c  (mode:100644 sha1:a60f1e49bda1bf12e11e0abccfaf4201130f4303)
@@ -3,6 +3,11 @@
 #include "cache.h"
 #include "commit.h"
 #include "tree.h"
+#include "refs.h"
+
+const char *write_ref = NULL;
+
+const unsigned char *current_ref = NULL;
 
 int get_tree = 0;
 int get_history = 0;
@@ -105,16 +110,42 @@
 	return 0;
 }
 
+static int interpret_target(char *target, unsigned char *sha1)
+{
+	if (!get_sha1_hex(target, sha1))
+		return 0;
+	if (!check_ref_format(target)) {
+		if (!fetch_ref(target, sha1)) {
+			return 0;
+		}
+	}
+	return -1;
+}
+
+
 int pull(char *target)
 {
-	int retval;
 	unsigned char sha1[20];
-	retval = get_sha1_hex(target, sha1);
-	if (retval)
-		return retval;
-	retval = make_sure_we_have_it(commitS, sha1);
-	if (retval)
-		return retval;
-	memcpy(current_commit_sha1, sha1, 20);
-	return process_commit(sha1);
+	int fd = -1;
+
+	if (write_ref && current_ref) {
+		fd = lock_ref_sha1(write_ref, current_ref);
+		if (fd < 0)
+			return -1;
+	}
+
+	if (interpret_target(target, sha1))
+		return error("Could not interpret %s as something to pull",
+			     target);
+	if (process_commit(sha1))
+		return -1;
+	
+	if (write_ref) {
+		if (current_ref) {
+			write_ref_sha1(write_ref, fd, sha1);
+		} else {
+			write_ref_sha1_unlocked(write_ref, sha1);
+		}
+	}
+	return 0;
 }
Index: pull.h
===================================================================
--- 9138b84eb683fc23a285445f7d7fc5a836ba01cb/pull.h  (mode:100644 sha1:3cd14cfb811a755a8770a0d01e8e2f96ba604058)
+++ 8deba080337c75a41cb456cc8b59000654278e59/pull.h  (mode:100644 sha1:83295892d1e401e4719ae26f16de07d6eb61a8d2)
@@ -4,6 +4,14 @@
 /** To be provided by the particular implementation. **/
 extern int fetch(unsigned char *sha1);
 
+extern int fetch_ref(char *ref, unsigned char *sha1);
+
+/** If set, the ref filename to write the target value to. **/
+extern const char *write_ref;
+
+/** If set, the hash that the current value of write_ref must be. **/
+extern const unsigned char *current_ref;
+
 /** Set to fetch the target tree. */
 extern int get_tree;
 
Index: ssh-pull.c
===================================================================
--- 9138b84eb683fc23a285445f7d7fc5a836ba01cb/ssh-pull.c  (mode:100644 sha1:f4ab89836455a40aaab3ff4114396185f6d5655a)
+++ 8deba080337c75a41cb456cc8b59000654278e59/ssh-pull.c  (mode:100644 sha1:c0cee73facbbb3ced2e566789ba1dda57b245f47)
@@ -39,6 +39,11 @@
 	return 0;
 }
 
+int fetch_ref(char *ref, unsigned char *sha1)
+{
+	return -1;
+}
+
 int main(int argc, char **argv)
 {
 	char *commit_id;

