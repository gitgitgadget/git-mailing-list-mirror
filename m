From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Use libcurl to use HTTP to get repositories
Date: Sat, 16 Apr 2005 20:14:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504162008190.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 02:10:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMxMg-0007FW-2t
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVDQAN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVDQAN7
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:13:59 -0400
Received: from iabervon.org ([66.92.72.58]:3332 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261214AbVDQANs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 20:13:48 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMxQO-0007ru-00; Sat, 16 Apr 2005 20:14:08 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This enables the use of HTTP to download commits and associated objects
from remote repositories. It now uses libcurl instead of local hack code.

Still causes warnings for fsck-cache and rev-tree, due to unshared code.

Still leaks a bit of memory due to bug copied from read-tree.

Needs libcurl post 7.7 or so.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Index: Makefile
===================================================================
--- ed4f6e454b40650b904ab72048b2f93a068dccc3/Makefile  (mode:100644 sha1:b39b4ea37586693dd707d1d0750a9b580350ec50)
+++ d332a8ddffb50c1247491181af458970bf639942/Makefile  (mode:100644 sha1:ca5dfd41b750cb1339128e4431afbbbc21bf57bb)
@@ -14,7 +14,7 @@
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-tree
+	check-files ls-tree merge-tree http-get
 
 all: $(PROG)
 
@@ -23,6 +23,11 @@
 
 LIBS= -lssl -lz
 
+http-get: LIBS += -lcurl
+
+http-get:%:%.o read-cache.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+
 init-db: init-db.o
 
 update-cache: update-cache.o read-cache.o
Index: http-get.c
===================================================================
--- /dev/null  (tree:ed4f6e454b40650b904ab72048b2f93a068dccc3)
+++ d332a8ddffb50c1247491181af458970bf639942/http-get.c  (mode:100644 sha1:106ca31239e6afe6784e7c592234406f5c149e44)
@@ -0,0 +1,126 @@
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include "cache.h"
+#include "revision.h"
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
+	if (!local) {
+		fprintf(stderr, "Couldn't open %s\n", filename);
+		return -1;
+	}
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
+	curl_easy_perform(curl);
+
+	fclose(local);
+	
+	return 0;
+}
+
+static int process_tree(unsigned char *sha1)
+{
+	void *buffer;
+        unsigned long size;
+        char type[20];
+
+        buffer = read_sha1_file(sha1, type, &size);
+	if (!buffer)
+		return -1;
+	if (strcmp(type, "tree"))
+		return -1;
+	while (size) {
+		int len = strlen(buffer) + 1;
+		unsigned char *sha1 = buffer + len;
+		unsigned int mode;
+		int retval;
+
+		if (size < len + 20 || sscanf(buffer, "%o", &mode) != 1)
+			return -1;
+
+		buffer = sha1 + 20;
+		size -= len + 20;
+
+		retval = fetch(sha1);
+		if (retval)
+			return -1;
+
+		if (S_ISDIR(mode)) {
+			retval = process_tree(sha1);
+			if (retval)
+				return -1;
+		}
+	}
+	return 0;
+}
+
+static int process_commit(unsigned char *sha1)
+{
+	struct revision *rev = lookup_rev(sha1);
+	if (parse_commit_object(rev))
+		return -1;
+	
+	fetch(rev->tree);
+	process_tree(rev->tree);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	char *commit_id = argv[1];
+	char *url = argv[2];
+
+	unsigned char sha1[20];
+
+	get_sha1_hex(commit_id, sha1);
+
+	curl_global_init(CURL_GLOBAL_ALL);
+
+	curl = curl_easy_init();
+
+	base = url;
+
+	fetch(sha1);
+	process_commit(sha1);
+
+	curl_global_cleanup();
+	return 0;
+}
Index: revision.h
===================================================================
--- ed4f6e454b40650b904ab72048b2f93a068dccc3/revision.h  (mode:100664 sha1:28d0de3261a61f68e4e0948a25a416a515cd2e83)
+++ d332a8ddffb50c1247491181af458970bf639942/revision.h  (mode:100664 sha1:523bde6e14e18bb0ecbded8f83ad4df93fc467ab)
@@ -24,6 +24,7 @@
 	unsigned int flags;
 	unsigned char sha1[20];
 	unsigned long date;
+	unsigned char tree[20];
 	struct parent *parent;
 };
 
@@ -111,4 +112,29 @@
 	}
 }
 
+static int parse_commit_object(struct revision *rev)
+{
+	if (!(rev->flags & SEEN)) {
+		void *buffer, *bufptr;
+		unsigned long size;
+		char type[20];
+		unsigned char parent[20];
+
+		rev->flags |= SEEN;
+		buffer = bufptr = read_sha1_file(rev->sha1, type, &size);
+		if (!buffer || strcmp(type, "commit"))
+			return -1;
+		get_sha1_hex(bufptr + 5, rev->tree);
+		bufptr += 46; /* "tree " + "hex sha1" + "\n" */
+		while (!memcmp(bufptr, "parent ", 7) && 
+		       !get_sha1_hex(bufptr+7, parent)) {
+			add_relationship(rev, parent);
+			bufptr += 48;   /* "parent " + "hex sha1" + "\n" */
+		}
+		//rev->date = parse_commit_date(bufptr);
+		free(buffer);
+	}
+	return 0;
+}
+
 #endif /* REVISION_H */

