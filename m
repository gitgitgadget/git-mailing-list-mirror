From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Get commits from remote repositories by HTTP
Date: Sat, 16 Apr 2005 18:03:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 17 00:00:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvKg-0005Bo-CL
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVDPWDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVDPWDo
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:03:44 -0400
Received: from iabervon.org ([66.92.72.58]:17926 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261153AbVDPWDb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 18:03:31 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMvOJ-0002xO-00
	for git@vger.kernel.org; Sat, 16 Apr 2005 18:03:51 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds a program to download a commit, the trees, and the blobs in them
from a remote repository using HTTP. It skips anything you already have.

There are a number of improvements possible, to be done if this catches
on, including, significantly, checking if the response was correct (or
even not an error).

It makes fsck-cache and rev-tree give harmless warnings, because it
includes some code that should probably be shared with them in revision.h

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Index: Makefile
===================================================================
--- ed4f6e454b40650b904ab72048b2f93a068dccc3/Makefile  (mode:100644 sha1:b39b4ea37586693dd707d1d0750a9b580350ec50)
+++ a65375b46154c90e7499b7e76998d430cd9cd29d/Makefile  (mode:100644 sha1:d41860aed161a14ca61e7b6c7f591f65928bd61f)
@@ -14,7 +14,7 @@
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-tree
+	check-files ls-tree merge-tree http-get
 
 all: $(PROG)
 
@@ -23,6 +23,9 @@
 
 LIBS= -lssl -lz
 
+http-get:%:%.o read-cache.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+
 init-db: init-db.o
 
 update-cache: update-cache.o read-cache.o
Index: http-get.c
===================================================================
--- /dev/null  (tree:ed4f6e454b40650b904ab72048b2f93a068dccc3)
+++ a65375b46154c90e7499b7e76998d430cd9cd29d/http-get.c  (mode:100644 sha1:6a36cfa079519a7a3ad5b1618be8711c5127b531)
@@ -0,0 +1,175 @@
+#include <sys/socket.h>
+#include <netdb.h>
+#include <netinet/in.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include "cache.h"
+#include "revision.h"
+#include <errno.h>
+
+static struct sockaddr_in sockad;
+static char *url;
+static char *base;
+
+static int target_url(char *target)
+{
+	char *name;
+	struct hostent *entry;
+	if (memcmp(target, "http://", 7))
+		return -1;
+	url = target;
+	base = strchr(target + 7, '/');
+	name = malloc(base - (target + 7) + 1);
+	memcpy(name, target + 7, base - (target + 7));
+	name[base - (target + 7)] = '\0';
+	printf("Connect to %s\n", name);
+	entry = gethostbyname(name);
+	memcpy(&sockad.sin_addr.s_addr,
+	       &((struct in_addr *)entry->h_addr)->s_addr, 4);
+	sockad.sin_port = htons(80);
+	sockad.sin_family = AF_INET;
+}
+
+static int get_connection()
+{
+	int fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (connect(fd, (struct sockaddr*) &sockad,
+		    sizeof(struct sockaddr_in))) {
+		perror(url);
+	}
+	return fd;
+}
+
+static void release_connection(int fd) {
+	close(fd);
+}
+
+static int fetch(unsigned char *sha1)
+{
+	int header_end_posn = 0;
+	int local;
+	char *hex = sha1_to_hex(sha1);
+	char *filename = sha1_file_name(sha1);
+	char buffer[4096];
+	int fd;
+	struct stat st;
+
+	if (!stat(filename, &st)) {
+		return 0;
+	}
+
+	fd = get_connection();
+	if (fd < 0) {
+		return 1;
+	}
+
+	write(fd, "GET ", 4);
+	write(fd, base, strlen(base));
+	write(fd, "objects/", 8);
+	write(fd, hex, 2);
+	write(fd, "/", 1);
+	write(fd, hex + 2, 38);
+	write(fd, " HTTP/1.0\r\n", 11);
+	write(fd, "\r\n", 2);
+
+	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+
+	do {
+		int sz = read(fd, buffer, 4096);
+		if (!sz) {
+			break;
+		}
+		if (sz < 0) {
+			perror("Reading from connection");
+			unlink(filename);
+			close(local);
+			return 1;
+		}
+		if (header_end_posn < 4) {
+			int i = 0;
+			char *flag = "\r\n\r\n";
+			while (i < sz && header_end_posn < 4) {
+				if (buffer[i] == flag[header_end_posn]) {
+					header_end_posn++;
+				} else {
+					header_end_posn = 0;
+				}
+				i++;
+			}
+			if (i < sz) {
+				write(local, buffer + i, sz - i);
+			}
+			continue;
+		}
+		write(local, buffer, sz);
+	} while (1);
+
+	close(local);
+	
+	release_connection(fd);
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
+	target_url(url);
+
+	fetch(sha1);
+	return process_commit(sha1);
+}
Index: revision.h
===================================================================
--- ed4f6e454b40650b904ab72048b2f93a068dccc3/revision.h  (mode:100664 sha1:28d0de3261a61f68e4e0948a25a416a515cd2e83)
+++ a65375b46154c90e7499b7e76998d430cd9cd29d/revision.h  (mode:100664 sha1:523bde6e14e18bb0ecbded8f83ad4df93fc467ab)
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

