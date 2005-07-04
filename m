From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Specify object not useful to pull
Date: Mon, 4 Jul 2005 14:50:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507041448400.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0507041416240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 20:53:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpW3a-0006vH-2V
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 20:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVGDSwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 14:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVGDSwb
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 14:52:31 -0400
Received: from iabervon.org ([66.92.72.58]:48644 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261543AbVGDSwU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 14:52:20 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DpW1X-00088I-00; Mon, 4 Jul 2005 14:50:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0507041416240.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add support for the pull common code to specify to a pull implementation
hashes which wouldn't be useful to fetch implicitly. This can be used to
infer (possibly) what hashes would be useful to fetch implicitly, such that
a later call to fetch can also fetch extra stuff.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---
commit 9bc0256d2e834e101d7bd3f4867a330c92104929
tree a2b4cfdaac954c46babffd585a61f3faf68969e1
parent d0efc8a71da1855c705fd2074b219bcb158b6dbd
author Daniel Barkalow <barkalow@iabervon.org> 1120411439 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1120411439 -0400

Index: http-pull.c
===================================================================
--- f26b700095ec30154fede14638a099f49744981d/http-pull.c  (mode:100644 sha1:1f9d60b9b1d5eed85b24d96c240666bbfc5a22ed)
+++ a2b4cfdaac954c46babffd585a61f3faf68969e1/http-pull.c  (mode:100644 sha1:f252a4b9d5448afa7af8a62176808a631429b9cd)
@@ -139,6 +139,10 @@
         return 0;
 }
 
+void dont_fetch(const unsigned char *sha1)
+{
+}
+
 int main(int argc, char **argv)
 {
 	char *commit_id;
Index: local-pull.c
===================================================================
--- f26b700095ec30154fede14638a099f49744981d/local-pull.c  (mode:100644 sha1:2f06fbee8b840a7ae642f5a22e2cb993687f3470)
+++ a2b4cfdaac954c46babffd585a61f3faf68969e1/local-pull.c  (mode:100644 sha1:270e3a0b8405793cd70e6efa70ec6aa4b1674141)
@@ -73,6 +73,10 @@
 	return -1;
 }
 
+void dont_fetch(const unsigned char *sha1)
+{
+}
+
 int fetch_ref(char *ref, unsigned char *sha1)
 {
 	static int ref_name_start = -1;
Index: pull.c
===================================================================
--- f26b700095ec30154fede14638a099f49744981d/pull.c  (mode:100644 sha1:ed3078e3b27c62c07558fd94f339801cbd685593)
+++ a2b4cfdaac954c46babffd585a61f3faf68969e1/pull.c  (mode:100644 sha1:f7f5a89aef36ffc2436dbd30170e4c8dbb2ba3a3)
@@ -155,6 +155,10 @@
 	unsigned char sha1[20];
 	int fd = -1;
 
+	if (current_ref) {
+		dont_fetch(current_ref);
+	}
+
 	if (write_ref && current_ref) {
 		fd = lock_ref_sha1(write_ref, current_ref);
 		if (fd < 0)
Index: pull.h
===================================================================
--- f26b700095ec30154fede14638a099f49744981d/pull.h  (mode:100644 sha1:e173ae3337c4465da87d849f4e5c9da203fdf01d)
+++ a2b4cfdaac954c46babffd585a61f3faf68969e1/pull.h  (mode:100644 sha1:6a35d39fd69bb884faa2d5e70c79e5c40b3ba436)
@@ -15,6 +15,12 @@
  */
 extern int fetch_ref(char *ref, unsigned char *sha1);
 
+/*
+ * Specify that the given SHA1, and everything it references, need not
+ * be fetched.  To be provided by the particular implementation. 
+ */
+extern void dont_fetch(const unsigned char *sha1);
+
 /* If set, the ref filename to write the target value to. */
 extern const char *write_ref;
 
Index: ssh-pull.c
===================================================================
--- f26b700095ec30154fede14638a099f49744981d/ssh-pull.c  (mode:100644 sha1:87d523899a83d8c0d3c5ff721208ded30c1a38f4)
+++ a2b4cfdaac954c46babffd585a61f3faf68969e1/ssh-pull.c  (mode:100644 sha1:362318071333420a7cf2450ada7269a94ec2cc7c)
@@ -53,6 +53,10 @@
 	return 0;
 }
 
+void dont_fetch(const unsigned char *sha1)
+{
+}
+
 int main(int argc, char **argv)
 {
 	char *commit_id;
