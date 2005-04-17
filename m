From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [3/5] Add http-pull
Date: Sun, 17 Apr 2005 11:31:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171127160.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:28:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNBgQ-0003nS-CL
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVDQPbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVDQPbZ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:31:25 -0400
Received: from iabervon.org ([66.92.72.58]:4356 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261271AbVDQPbA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 11:31:00 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNBjw-0006bO-00; Sun, 17 Apr 2005 11:31:16 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

http-pull is a program that downloads from a (normal) HTTP server a commit
and all of the tree and blob objects it refers to (but not other commits,
etc.). Options could be used to make it download a larger or different
selection of objects. It depends on libcurl, which I forgot to mention in
the README again.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- d662b707e11391f6cfe597fd4d0bf9c41d34d01a/Makefile  (mode:100644 sha1:b2ce7c5b63fffca59653b980d98379909f893d44)
+++ 157b46ce1d82b3579e2e1258927b0d9bdbc033ab/Makefile  (mode:100644 sha1:940ef8578cf469354002cd8feaec25d907015267)
@@ -14,7 +14,7 @@
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-base
+	check-files ls-tree http-pull merge-base
 
 SCRIPT=	parent-id tree-id git gitXnormid.sh gitadd.sh gitaddremote.sh \
 	gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlsobj.sh \
@@ -35,6 +35,7 @@
 
 LIBS= -lssl -lz
 
+http-pull: LIBS += -lcurl
 
 $(PROG):%: %.o $(COMMON)
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
Index: http-pull.c
===================================================================
--- /dev/null  (tree:d662b707e11391f6cfe597fd4d0bf9c41d34d01a)
+++ 157b46ce1d82b3579e2e1258927b0d9bdbc033ab/http-pull.c  (mode:100644 sha1:106ca31239e6afe6784e7c592234406f5c149e44)
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

