From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [3.1/5] Add http-pull
Date: Sun, 17 Apr 2005 14:58:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171457050.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504171127160.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 20:55:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNEuC-00082x-Ke
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVDQS5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVDQS5x
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:57:53 -0400
Received: from iabervon.org ([66.92.72.58]:774 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261412AbVDQS5n (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 14:57:43 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNEy0-0005h9-00; Sun, 17 Apr 2005 14:58:00 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504171127160.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

http-pull is a program that downloads from a (normal) HTTP server a commit
and all of the tree and blob objects it refers to (but not other commits,
etc.). Options could be used to make it download a larger or different
selection of objects.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 45f926575d2c44072bfcf2317dbf3f0fbb513a4e/Makefile  (mode:100644 sha1:346e3850de026485802e41e16a1180be2df85e4a)
+++ 3eae85f66143160a26f5545d197862c89e2a8fb8/Makefile  (mode:100644 sha1:0e84e3cd12f836602b420c197e08fabefe975493)
@@ -14,7 +17,7 @@
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-base
+	check-files ls-tree http-pull merge-base
 
 SCRIPT=	parent-id tree-id git gitXnormid.sh gitadd.sh gitaddremote.sh \
 	gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlsobj.sh \
@@ -35,6 +38,7 @@
 
 LIBS= -lssl -lz
 
+http-pull: LIBS += -lcurl
 
 $(PROG):%: %.o $(COMMON)
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
Index: README
===================================================================
--- 45f926575d2c44072bfcf2317dbf3f0fbb513a4e/README  (mode:100664 sha1:0170eafb60ad9009ca41c6536cecd6d1fdee5b86)
+++ 3eae85f66143160a26f5545d197862c89e2a8fb8/README  (mode:100664 sha1:921d552d810394e665323ec82b4826914918689c)
@@ -120,7 +120,7 @@
 	diff, patch
 	libssl
 	rsync
-
+	curl (later than 7.7, according to the docs)
 
 
 	The "core GIT"
Index: http-pull.c
===================================================================
--- /dev/null  (tree:45f926575d2c44072bfcf2317dbf3f0fbb513a4e)
+++ 3eae85f66143160a26f5545d197862c89e2a8fb8/http-pull.c  (mode:100644 sha1:7ba4ad67f6dac34addb537ee147ae3de0550a484)
@@ -0,0 +1,139 @@
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
+
+	if (!access(filename, R_OK)) {
+		return 0;
+	}
+
+	local = fopen(filename, "w");
+
+	if (!local) {
+		return error("Couldn't open %s", filename);
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
+	if (curl_easy_perform(curl)) {
+		fclose(local);
+		unlink(filename);
+		return error("Error downloading %s from %s",
+			     sha1_to_hex(sha1), url);
+	}
+
+	fclose(local);
+	
+	return 0;
+}
+
+static int process_tree(unsigned char *sha1)
+{
+	void *buffer;
+	unsigned long size;
+	char type[20];
+
+	buffer = read_sha1_file(sha1, type, &size);
+	if (!buffer)
+	 	return error("Couldn't read %s.",
+			     sha1_to_hex(sha1));
+	if (strcmp(type, "tree"))
+		return error("Expected %s to be a tree, but was a %s.",
+			     sha1_to_hex(sha1), type);
+	while (size) {
+		int len = strlen(buffer) + 1;
+		unsigned char *sha1 = buffer + len;
+		unsigned int mode;
+		int retval;
+
+		if (size < len + 20 || sscanf(buffer, "%o", &mode) != 1)
+			return error("Invalid tree object");
+
+		buffer = sha1 + 20;
+		size -= len + 20;
+
+		retval = fetch(sha1);
+		if (retval)
+			return retval;
+
+		if (S_ISDIR(mode)) {
+			retval = process_tree(sha1);
+			if (retval)
+				return retval;
+		}
+	}
+	return 0;
+}
+
+static int process_commit(unsigned char *sha1)
+{
+	int retval;
+	struct revision *rev = lookup_rev(sha1);
+	if (parse_commit_object(rev))
+		return error("Couldn't parse commit %s\n", sha1_to_hex(sha1));
+
+	retval = fetch(rev->tree);
+	if (retval)
+		return retval;
+	retval = process_tree(rev->tree);
+	return retval;
+}
+
+int main(int argc, char **argv)
+{
+	char *commit_id = argv[1];
+	char *url = argv[2];
+	int retval;
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
+	retval = fetch(sha1);
+	if (retval)
+		return 1;
+	retval = process_commit(sha1);
+	if (retval)
+		return 1;
+
+	curl_global_cleanup();
+	return 0;
+}

