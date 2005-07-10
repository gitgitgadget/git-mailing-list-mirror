From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Make --recover cause pull to trace everything
Date: Sun, 10 Jul 2005 16:43:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507101635160.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jul 10 22:48:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrijP-0004Z7-Tw
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 22:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVGJUsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 16:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVGJUqN
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 16:46:13 -0400
Received: from iabervon.org ([66.92.72.58]:29701 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262108AbVGJUpL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 16:45:11 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Dridu-0001UB-00; Sun, 10 Jul 2005 16:43:14 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make the --recover flag check the parents of commits which are already
available. This is needed currently to deal with cases where a parent is
pulled along with a commit (in a pack, e.g.) and references above that
parent aren't also pulled together.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
commit 75e8c1be7a778e0a0fa119fe1bc408341932e7e5
tree ffbe708117543c356eb2981f1e0540b89b7a95e2
parent a7336ae514738f159dad314d6674961427f043a6
author Daniel Barkalow <barkalow@iabervon.org> 1121024019 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1121024019 -0400

Index: http-pull.c
===================================================================
--- 248f72f3e4dcb40693488b0c06f93d0b38122b8e/http-pull.c  (mode:100644 sha1:1f9d60b9b1d5eed85b24d96c240666bbfc5a22ed)
+++ ffbe708117543c356eb2981f1e0540b89b7a95e2/http-pull.c  (mode:100644 sha1:3fa56f08b0b8e7316afcaab3a7bfa3f2d26b550f)
@@ -146,7 +146,10 @@
 	int arg = 1;
 
 	while (arg < argc && argv[arg][0] == '-') {
-		if (argv[arg][1] == 't') {
+		if (argv[arg][1] == '-') {
+			if (!strcmp(argv[arg] + 2, "recover"))
+				careful = 1;
+		} else if (argv[arg][1] == 't') {
 			get_tree = 1;
 		} else if (argv[arg][1] == 'c') {
 			get_history = 1;
Index: local-pull.c
===================================================================
--- 248f72f3e4dcb40693488b0c06f93d0b38122b8e/local-pull.c  (mode:100644 sha1:2f06fbee8b840a7ae642f5a22e2cb993687f3470)
+++ ffbe708117543c356eb2981f1e0540b89b7a95e2/local-pull.c  (mode:100644 sha1:0d10c07844030bc7cb615cf916dce89592151be7)
@@ -116,7 +116,10 @@
 	int arg = 1;
 
 	while (arg < argc && argv[arg][0] == '-') {
-		if (argv[arg][1] == 't')
+		if (argv[arg][1] == '-') {
+			if (!strcmp(argv[arg] + 2, "recover"))
+				careful = 1;
+		} else if (argv[arg][1] == 't')
 			get_tree = 1;
 		else if (argv[arg][1] == 'c')
 			get_history = 1;
Index: pull.c
===================================================================
--- 248f72f3e4dcb40693488b0c06f93d0b38122b8e/pull.c  (mode:100644 sha1:ed3078e3b27c62c07558fd94f339801cbd685593)
+++ ffbe708117543c356eb2981f1e0540b89b7a95e2/pull.c  (mode:100644 sha1:d9763840c7ebcb1e5838c3b960695cafcca3ac73)
@@ -11,6 +11,7 @@
 
 const unsigned char *current_ref = NULL;
 
+int careful = 0;
 int get_tree = 0;
 int get_history = 0;
 int get_all = 0;
@@ -91,7 +92,8 @@
 	if (get_history) {
 		struct commit_list *parents = obj->parents;
 		for (; parents; parents = parents->next) {
-			if (has_sha1_file(parents->item->object.sha1))
+			if (!careful &&
+			    has_sha1_file(parents->item->object.sha1))
 				continue;
 			if (make_sure_we_have_it(NULL,
 						 parents->item->object.sha1)) {
Index: pull.h
===================================================================
--- 248f72f3e4dcb40693488b0c06f93d0b38122b8e/pull.h  (mode:100644 sha1:e173ae3337c4465da87d849f4e5c9da203fdf01d)
+++ ffbe708117543c356eb2981f1e0540b89b7a95e2/pull.h  (mode:100644 sha1:d1076468b71b31dd5e59ec55d98de830cf9df60e)
@@ -21,6 +21,12 @@
 /* If set, the hash that the current value of write_ref must be. */
 extern const unsigned char *current_ref;
 
+/* 
+ * Set to check on everything, instead of stopping at points where we think
+ * we must have everything.
+ */
+extern int careful;
+
 /* Set to fetch the target tree. */
 extern int get_tree;
 
Index: ssh-pull.c
===================================================================
--- 248f72f3e4dcb40693488b0c06f93d0b38122b8e/ssh-pull.c  (mode:100644 sha1:26356dd7d84ea1bc9f7320b18562ed4117d4fac0)
+++ ffbe708117543c356eb2981f1e0540b89b7a95e2/ssh-pull.c  (mode:100644 sha1:7ca4243f3bd84590e7bb94467fd5acccd7d4d6f9)
@@ -61,7 +61,10 @@
 	const char *prog = getenv("GIT_SSH_PUSH") ? : "git-ssh-push";
 
 	while (arg < argc && argv[arg][0] == '-') {
-		if (argv[arg][1] == 't') {
+		if (argv[arg][1] == '-') {
+			if (!strcmp(argv[arg] + 2, "recover"))
+				careful = 1;
+		} else if (argv[arg][1] == 't') {
 			get_tree = 1;
 		} else if (argv[arg][1] == 'c') {
 			get_history = 1;
