From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [3/4] Add http-pull
Date: Mon, 18 Apr 2005 21:57:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504182155010.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:53:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhvo-00029D-9K
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVDSB5k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVDSB5k
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:57:40 -0400
Received: from iabervon.org ([66.92.72.58]:30982 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261266AbVDSB5S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 21:57:18 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNhzY-0004wF-00; Mon, 18 Apr 2005 21:57:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds a command to pull a commit and dependant objects from an HTTP
server.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 50afb5dd4184842d8da1da8dcb9ca6a591dfc5b0/Makefile  (mode:100644 sha1:803f1d49c436efa570d779db6d350efbceb29ddd)
+++ f7f62e0d2a822ad0937fd98a826f65ac7f938217/Makefile  (mode:100644 sha1:a3d26213c085e8b6bbc1ec352df0996e558e7c38)
@@ -15,7 +15,7 @@
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-base merge-cache unpack-file
+	check-files ls-tree merge-base merge-cache unpack-file http-pull
 
 all: $(PROG)
 
@@ -81,6 +81,11 @@
 unpack-file: unpack-file.o $(LIB_FILE)
 	$(CC) $(CFLAGS) -o unpack-file unpack-file.o $(LIBS)
 
+http-pull: LIBS += -lcurl
+
+http-pull: http-pull.o $(LIB_FILE)
+	$(CC) $(CFLAGS) -o http-pull http-pull.o $(LIBS)
+
 blob.o: $(LIB_H)
 cat-file.o: $(LIB_H)
 check-files.o: $(LIB_H)
@@ -105,6 +110,7 @@
 usage.o: $(LIB_H)
 unpack-file.o: $(LIB_H)
 write-tree.o: $(LIB_H)
+http-pull.o: $(LIB_H)
 
 clean:
 	rm -f *.o $(PROG) $(LIB_FILE)
Index: http-pull.c
===================================================================
--- /dev/null  (tree:50afb5dd4184842d8da1da8dcb9ca6a591dfc5b0)
+++ f7f62e0d2a822ad0937fd98a826f65ac7f938217/http-pull.c  (mode:100644 sha1:bd251f9e0748784bbd2cd5cf720f126d852fe888)
@@ -0,0 +1,170 @@
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include "cache.h"
+#include "commit.h"
+#include <errno.h>
+#include <stdio.h>
+
+#include <curl/curl.h>
+#include <curl/easy.h>
+
+static CURL *curl;
+
+static char *base;
+
+static int tree = 0;
+static int commits = 0;
+static int all = 0;
+
+static int has(unsigned char *sha1)
+{
+	char *filename = sha1_file_name(sha1);
+	struct stat st;
+
+	if (!stat(filename, &st))
+		return 1;
+	return 0;
+}
+
+static int fetch(unsigned char *sha1)
+{
+	char *hex = sha1_to_hex(sha1);
+	char *filename = sha1_file_name(sha1);
+
+	char *url;
+	char *posn;
+	FILE *local;
+	struct stat st;
+
+	if (!stat(filename, &st)) {
+		return 0;
+	}
+
+	local = fopen(filename, "w");
+
+	if (!local)
+		return error("Couldn't open %s\n", filename);
+
+	curl_easy_setopt(curl, CURLOPT_FILE, local);
+
+	url = malloc(strlen(base) + 50);
+	strcpy(url, base);
+	posn = url + strlen(base);
+	strcpy(posn, "objects/");
+	posn += 8;
+	memcpy(posn, hex, 2);
+	posn += 2;
+	*(posn++) = '/';
+	strcpy(posn, hex + 2);
+
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+
+	printf("Getting %s\n", hex);
+
+	if (curl_easy_perform(curl))
+		return error("Couldn't get %s for %s\n", url, hex);
+
+	fclose(local);
+	
+	return 0;
+}
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
+	if (tree) {
+		if (fetch(obj->tree->object.sha1))
+			return -1;
+		if (process_tree(obj->tree->object.sha1))
+			return -1;
+		if (!all)
+			tree = 0;
+	}
+	if (commits) {
+		struct commit_list *parents = obj->parents;
+		for (; parents; parents = parents->next) {
+			if (has(parents->item->object.sha1))
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
+int main(int argc, char **argv)
+{
+	char *commit_id;
+	char *url;
+	int arg = 1;
+	unsigned char sha1[20];
+
+	while (arg < argc && argv[arg][0] == '-') {
+		if (argv[arg][1] == 't') {
+			tree = 1;
+		} else if (argv[arg][1] == 'c') {
+			commits = 1;
+		} else if (argv[arg][1] == 'a') {
+			all = 1;
+			tree = 1;
+			commits = 1;
+		}
+		arg++;
+	}
+	if (argc < arg + 2) {
+		usage("http-pull [-c] [-t] [-a] commit-id url");
+		return 1;
+	}
+	commit_id = argv[arg];
+	url = argv[arg + 1];
+
+	get_sha1_hex(commit_id, sha1);
+
+	curl_global_init(CURL_GLOBAL_ALL);
+
+	curl = curl_easy_init();
+
+	base = url;
+
+	if (fetch(sha1))
+		return 1;
+	if (process_commit(sha1))
+		return 1;
+
+	curl_global_cleanup();
+	return 0;
+}

