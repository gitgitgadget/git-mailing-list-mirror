From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Split out "pull" from particular methods
Date: Sat, 30 Apr 2005 01:36:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504300133430.30848-100000@iabervon.org>
References: <7vy8b12qg1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>, Petr Baudis <pasky@ucw.cz>,
	Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 07:32:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRkaC-0005kv-Oz
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 07:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVD3Fhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 01:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVD3Fha
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 01:37:30 -0400
Received: from iabervon.org ([66.92.72.58]:17414 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262514AbVD3Fgv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 01:36:51 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DRkeU-0006ur-00; Sat, 30 Apr 2005 01:36:30 -0400
To: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vy8b12qg1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The method for deciding what to pull is useful separately from any of the
ways of actually fetching the objects.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

Split out "pull" functionality from http-pull and rpull
Index: Makefile
===================================================================
--- 8602fe7cb4bf668fd021ab3bfb2082ac7d535e57/Makefile  (mode:100644 sha1:ef9a9fae88a1ac438c22beb50790f0f0e37ffc3c)
+++ 41f4697d0ada8e79a2f262aa9b6357a45194f31d/Makefile  (mode:100644 sha1:87fe8fef5ebd315f370af882bd3172632b850c02)
@@ -82,9 +82,9 @@
 git-export: export.c
 git-diff-cache: diff-cache.c
 git-convert-cache: convert-cache.c
-git-http-pull: http-pull.c
+git-http-pull: http-pull.c pull.c
 git-rpush: rsh.c
-git-rpull: rsh.c
+git-rpull: rsh.c pull.c
 git-rev-list: rev-list.c
 git-mktag: mktag.c
 git-diff-tree-helper: diff-tree-helper.c
Index: http-pull.c
===================================================================
--- 8602fe7cb4bf668fd021ab3bfb2082ac7d535e57/http-pull.c  (mode:100644 sha1:192dcc370dee47c52c72915394bb6f2a79f64e12)
+++ 41f4697d0ada8e79a2f262aa9b6357a45194f31d/http-pull.c  (mode:100644 sha1:d877c4abe3ff7766d858bfeac5c9a0eaf1385b65)
@@ -7,6 +7,8 @@
 #include <errno.h>
 #include <stdio.h>
 
+#include "pull.h"
+
 #include <curl/curl.h>
 #include <curl/easy.h>
 
@@ -14,10 +16,6 @@
 
 static char *base;
 
-static int tree = 0;
-static int commits = 0;
-static int all = 0;
-
 static SHA_CTX c;
 static z_stream stream;
 
@@ -47,7 +45,7 @@
 	return size;
 }
 
-static int fetch(unsigned char *sha1)
+int fetch(unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
 	char *filename = sha1_file_name(sha1);
@@ -105,77 +103,21 @@
 	return 0;
 }
 
-static int process_tree(unsigned char *sha1)
-{
-	struct tree *tree = lookup_tree(sha1);
-	struct tree_entry_list *entries;
-
-	if (parse_tree(tree))
-		return -1;
-
-	for (entries = tree->entries; entries; entries = entries->next) {
-		if (fetch(entries->item.tree->object.sha1))
-			return -1;
-		if (entries->directory) {
-			if (process_tree(entries->item.tree->object.sha1))
-				return -1;
-		}
-	}
-	return 0;
-}
-
-static int process_commit(unsigned char *sha1)
-{
-	struct commit *obj = lookup_commit(sha1);
-
-	if (fetch(sha1))
-		return -1;
-
-	if (parse_commit(obj))
-		return -1;
-
-	if (tree) {
-		if (fetch(obj->tree->object.sha1))
-			return -1;
-		if (process_tree(obj->tree->object.sha1))
-			return -1;
-		if (!all)
-			tree = 0;
-	}
-	if (commits) {
-		struct commit_list *parents = obj->parents;
-		for (; parents; parents = parents->next) {
-			if (has_sha1_file(parents->item->object.sha1))
-				continue;
-			if (fetch(parents->item->object.sha1)) {
-				/* The server might not have it, and
-				 * we don't mind. 
-				 */
-				continue;
-			}
-			if (process_commit(parents->item->object.sha1))
-				return -1;
-		}
-	}
-	return 0;
-}
-
 int main(int argc, char **argv)
 {
 	char *commit_id;
 	char *url;
 	int arg = 1;
-	unsigned char sha1[20];
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
-			tree = 1;
+			get_tree = 1;
 		} else if (argv[arg][1] == 'c') {
-			commits = 1;
+			get_history = 1;
 		} else if (argv[arg][1] == 'a') {
-			all = 1;
-			tree = 1;
-			commits = 1;
+			get_all = 1;
+			get_tree = 1;
+			get_history = 1;
 		}
 		arg++;
 	}
@@ -186,17 +128,13 @@
 	commit_id = argv[arg];
 	url = argv[arg + 1];
 
-	get_sha1_hex(commit_id, sha1);
-
 	curl_global_init(CURL_GLOBAL_ALL);
 
 	curl = curl_easy_init();
 
 	base = url;
 
-	if (fetch(sha1))
-		return 1;
-	if (process_commit(sha1))
+	if (pull(commit_id))
 		return 1;
 
 	curl_global_cleanup();
Index: pull.c
===================================================================
--- /dev/null  (tree:8602fe7cb4bf668fd021ab3bfb2082ac7d535e57)
+++ 41f4697d0ada8e79a2f262aa9b6357a45194f31d/pull.c  (mode:100644 sha1:86a7b6901fe69a82c12c3470b456982ef52cebd0)
@@ -0,0 +1,77 @@
+#include "pull.h"
+
+#include "cache.h"
+#include "commit.h"
+#include "tree.h"
+
+int get_tree = 0;
+int get_history = 0;
+int get_all = 0;
+
+static int process_tree(unsigned char *sha1)
+{
+	struct tree *tree = lookup_tree(sha1);
+	struct tree_entry_list *entries;
+
+	if (parse_tree(tree))
+		return -1;
+
+	for (entries = tree->entries; entries; entries = entries->next) {
+		if (fetch(entries->item.tree->object.sha1))
+			return -1;
+		if (entries->directory) {
+			if (process_tree(entries->item.tree->object.sha1))
+				return -1;
+		}
+	}
+	return 0;
+}
+
+static int process_commit(unsigned char *sha1)
+{
+	struct commit *obj = lookup_commit(sha1);
+
+	if (fetch(sha1))
+		return -1;
+
+	if (parse_commit(obj))
+		return -1;
+
+	if (get_tree) {
+		if (fetch(obj->tree->object.sha1))
+			return -1;
+		if (process_tree(obj->tree->object.sha1))
+			return -1;
+		if (!get_all)
+			get_tree = 0;
+	}
+	if (get_history) {
+		struct commit_list *parents = obj->parents;
+		for (; parents; parents = parents->next) {
+			if (has_sha1_file(parents->item->object.sha1))
+				continue;
+			if (fetch(parents->item->object.sha1)) {
+				/* The server might not have it, and
+				 * we don't mind. 
+				 */
+				continue;
+			}
+			if (process_commit(parents->item->object.sha1))
+				return -1;
+		}
+	}
+	return 0;
+}
+
+int pull(char *target)
+{
+	int retval;
+	unsigned char sha1[20];
+	retval = get_sha1_hex(target, sha1);
+	if (retval)
+		return retval;
+	retval = fetch(sha1);
+	if (retval)
+		return retval;
+	return process_commit(sha1);
+}
Index: pull.h
===================================================================
--- /dev/null  (tree:8602fe7cb4bf668fd021ab3bfb2082ac7d535e57)
+++ 41f4697d0ada8e79a2f262aa9b6357a45194f31d/pull.h  (mode:100644 sha1:314bc7e95ab1a73634f6a96a8a3782fda91ea261)
@@ -0,0 +1,18 @@
+#ifndef PULL_H
+#define PULL_H
+
+/** To be provided by the particular implementation. **/
+extern int fetch(unsigned char *sha1);
+
+/** Set to fetch the target tree. */
+extern int get_tree;
+
+/** Set to fetch the commit history. */
+extern int get_history;
+
+/** Set to fetch the trees in the commit history. **/
+extern int get_all;
+
+extern int pull(char *target);
+
+#endif /* PULL_H */
Index: rpull.c
===================================================================
--- 8602fe7cb4bf668fd021ab3bfb2082ac7d535e57/rpull.c  (mode:100644 sha1:c27af2c2464de28732b8ad1fff3ed8a0804250d6)
+++ 41f4697d0ada8e79a2f262aa9b6357a45194f31d/rpull.c  (mode:100644 sha1:6624440d5ad24854e1bd1a8dff628427581198e0)
@@ -7,15 +7,12 @@
 #include <errno.h>
 #include <stdio.h>
 #include "rsh.h"
-
-static int tree = 0;
-static int commits = 0;
-static int all = 0;
+#include "pull.h"
 
 static int fd_in;
 static int fd_out;
 
-static int fetch(unsigned char *sha1)
+int fetch(unsigned char *sha1)
 {
 	if (has_sha1_file(sha1))
 		return 0;
@@ -23,87 +20,21 @@
 	return write_sha1_from_fd(sha1, fd_in);
 }
 
-static int process_tree(unsigned char *sha1)
-{
-	struct tree *tree = lookup_tree(sha1);
-	struct tree_entry_list *entries;
-
-	if (parse_tree(tree))
-		return -1;
-
-	for (entries = tree->entries; entries; entries = entries->next) {
-		/*
-		  fprintf(stderr, "Tree %s ", sha1_to_hex(sha1));
-		  fprintf(stderr, "needs %s\n", 
-		  sha1_to_hex(entries->item.tree->object.sha1));
-		*/
-		if (fetch(entries->item.tree->object.sha1)) {
-			return error("Missing item %s",
-				     sha1_to_hex(entries->item.tree->object.sha1));
-		}
-		if (entries->directory) {
-			if (process_tree(entries->item.tree->object.sha1))
-				return -1;
-		}
-	}
-	return 0;
-}
-
-static int process_commit(unsigned char *sha1)
-{
-	struct commit *obj = lookup_commit(sha1);
-
-	if (fetch(sha1)) {
-		return error("Fetching %s", sha1_to_hex(sha1));
-	}
-
-	if (parse_commit(obj))
-		return -1;
-
-	if (tree) {
-		if (fetch(obj->tree->object.sha1))
-			return -1;
-		if (process_tree(obj->tree->object.sha1))
-			return -1;
-		if (!all)
-			tree = 0;
-	}
-	if (commits) {
-		struct commit_list *parents = obj->parents;
-		for (; parents; parents = parents->next) {
-			if (has_sha1_file(parents->item->object.sha1))
-				continue;
-			if (fetch(parents->item->object.sha1)) {
-				/* The server might not have it, and
-				 * we don't mind. 
-				 */
-				error("Missing tree %s; continuing", 
-				      sha1_to_hex(parents->item->object.sha1));
-				continue;
-			}
-			if (process_commit(parents->item->object.sha1))
-				return -1;
-		}
-	}
-	return 0;
-}
-
 int main(int argc, char **argv)
 {
 	char *commit_id;
 	char *url;
 	int arg = 1;
-	unsigned char sha1[20];
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
-			tree = 1;
+			get_tree = 1;
 		} else if (argv[arg][1] == 'c') {
-			commits = 1;
+			get_history = 1;
 		} else if (argv[arg][1] == 'a') {
-			all = 1;
-			tree = 1;
-			commits = 1;
+			get_all = 1;
+			get_tree = 1;
+			get_history = 1;
 		}
 		arg++;
 	}
@@ -117,11 +48,7 @@
 	if (setup_connection(&fd_in, &fd_out, "rpush", url, arg, argv + 1))
 		return 1;
 
-	get_sha1_hex(commit_id, sha1);
-
-	if (fetch(sha1))
-		return 1;
-	if (process_commit(sha1))
+	if (pull(commit_id))
 		return 1;
 
 	return 0;

