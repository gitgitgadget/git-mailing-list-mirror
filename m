From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 5/5] Various transport programs
Date: Sat, 23 Apr 2005 20:24:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504232018330.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:20:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUrD-0007nG-RN
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVDXAZC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVDXAZC
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:25:02 -0400
Received: from iabervon.org ([66.92.72.58]:16903 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262197AbVDXAYb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:24:31 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPUvP-000086-00; Sat, 23 Apr 2005 20:24:39 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds three similar and related programs. http-pull downloads
objects from an HTTP server; rpull downloads objects by using ssh and
rpush on the other side; and rpush uploads objects by using ssh and rpull
on the other side.

The algorithm should be sufficient to make the network throughput required
depend only on how much content is new, not at all on how much content the
repository contains.

The combination should enable people to have remote repositories by way of
ssh login for authenticated users and HTTP for anonymous access.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 9b75904eab1300d83264a1840d396160482fee88/Makefile  (mode:100644 sha1:57e70239503466fb3a77f1f2618ee64377e8e04b)
+++ a56d8adaecc49ce7f26536f9f5d54ec813072e4f/Makefile  (mode:100644 sha1:b60d8eb691f4edd56d5b310b0dd670e98c852228)
@@ -16,7 +16,7 @@
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
 	check-files ls-tree merge-base merge-cache unpack-file git-export \
-	diff-cache convert-cache
+	diff-cache convert-cache http-pull rpush rpull
 
 all: $(PROG)
 
@@ -51,7 +51,13 @@
 init-db: init-db.o
 
 %: %.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
+	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+
+rpush: rsh.o
+
+rpull: rsh.o
+
+http-pull: LIBS += -lcurl
 
 blob.o: $(LIB_H)
 cat-file.o: $(LIB_H)
@@ -80,6 +86,9 @@
 usage.o: $(LIB_H)
 unpack-file.o: $(LIB_H)
 write-tree.o: $(LIB_H)
+http-pull.o: $(LIB_H)
+rpull.o: $(LIB_H)
+rpush.o: $(LIB_H)
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
Index: http-pull.c
===================================================================
--- /dev/null  (tree:9b75904eab1300d83264a1840d396160482fee88)
+++ a56d8adaecc49ce7f26536f9f5d54ec813072e4f/http-pull.c  (mode:100644 sha1:a17225719c53508a37905618c624ad8c4d0372ec)
@@ -0,0 +1,204 @@
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
+static SHA_CTX c;
+static z_stream stream;
+
+static int local;
+static int zret;
+
+static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb, 
+			       void *data) {
+	char expn[4096];
+	size_t size = eltsize * nmemb;
+	int posn = 0;
+	do {
+		ssize_t retval = write(local, ptr + posn, size - posn);
+		if (retval < 0)
+			return posn;
+		posn += retval;
+	} while (posn < size);
+
+	stream.avail_in = size;
+	stream.next_in = ptr;
+	do {
+		stream.next_out = expn;
+		stream.avail_out = sizeof(expn);
+		zret = inflate(&stream, Z_SYNC_FLUSH);
+		SHA1_Update(&c, expn, sizeof(expn) - stream.avail_out);
+	} while (stream.avail_in && zret == Z_OK);
+	return size;
+}
+
+static int fetch(unsigned char *sha1)
+{
+	char *hex = sha1_to_hex(sha1);
+	char *filename = sha1_file_name(sha1);
+	char real_sha1[20];
+	char *url;
+	char *posn;
+
+	if (has_sha1_file(sha1)) {
+		return 0;
+	}
+
+	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+
+	if (local < 0)
+		return error("Couldn't open %s\n", filename);
+
+	memset(&stream, 0, sizeof(stream));
+
+	inflateInit(&stream);
+
+	SHA1_Init(&c);
+
+	curl_easy_setopt(curl, CURLOPT_FILE, NULL);
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
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
+	/*printf("Getting %s\n", hex);*/
+
+	if (curl_easy_perform(curl))
+		return error("Couldn't get %s for %s\n", url, hex);
+
+	close(local);
+	inflateEnd(&stream);
+	SHA1_Final(real_sha1, &c);
+	if (zret != Z_STREAM_END) {
+		unlink(filename);
+		return error("File %s (%s) corrupt\n", hex, url);
+	}
+	if (memcmp(sha1, real_sha1, 20)) {
+		unlink(filename);
+		return error("File %s has bad hash\n", hex);
+	}
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
Index: rpull.c
===================================================================
--- /dev/null  (tree:9b75904eab1300d83264a1840d396160482fee88)
+++ a56d8adaecc49ce7f26536f9f5d54ec813072e4f/rpull.c  (mode:100644 sha1:c27af2c2464de28732b8ad1fff3ed8a0804250d6)
@@ -0,0 +1,128 @@
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include "cache.h"
+#include "commit.h"
+#include <errno.h>
+#include <stdio.h>
+#include "rsh.h"
+
+static int tree = 0;
+static int commits = 0;
+static int all = 0;
+
+static int fd_in;
+static int fd_out;
+
+static int fetch(unsigned char *sha1)
+{
+	if (has_sha1_file(sha1))
+		return 0;
+	write(fd_out, sha1, 20);
+	return write_sha1_from_fd(sha1, fd_in);
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
+		/*
+		  fprintf(stderr, "Tree %s ", sha1_to_hex(sha1));
+		  fprintf(stderr, "needs %s\n", 
+		  sha1_to_hex(entries->item.tree->object.sha1));
+		*/
+		if (fetch(entries->item.tree->object.sha1)) {
+			return error("Missing item %s",
+				     sha1_to_hex(entries->item.tree->object.sha1));
+		}
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
+	if (fetch(sha1)) {
+		return error("Fetching %s", sha1_to_hex(sha1));
+	}
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
+			if (has_sha1_file(parents->item->object.sha1))
+				continue;
+			if (fetch(parents->item->object.sha1)) {
+				/* The server might not have it, and
+				 * we don't mind. 
+				 */
+				error("Missing tree %s; continuing", 
+				      sha1_to_hex(parents->item->object.sha1));
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
+		usage("rpull [-c] [-t] [-a] commit-id url");
+		return 1;
+	}
+	commit_id = argv[arg];
+	url = argv[arg + 1];
+
+	if (setup_connection(&fd_in, &fd_out, "rpush", url, arg, argv + 1))
+		return 1;
+
+	get_sha1_hex(commit_id, sha1);
+
+	if (fetch(sha1))
+		return 1;
+	if (process_commit(sha1))
+		return 1;
+
+	return 0;
+}
Index: rpush.c
===================================================================
--- /dev/null  (tree:9b75904eab1300d83264a1840d396160482fee88)
+++ a56d8adaecc49ce7f26536f9f5d54ec813072e4f/rpush.c  (mode:100644 sha1:0293a1a46311d7e20b13177143741ab9d6d0d201)
@@ -0,0 +1,69 @@
+#include "cache.h"
+#include "rsh.h"
+#include <sys/socket.h>
+#include <errno.h>
+
+void service(int fd_in, int fd_out) {
+	ssize_t size;
+	int posn;
+	char sha1[20];
+	unsigned long objsize;
+	void *buf;
+	do {
+		posn = 0;
+		do {
+			size = read(fd_in, sha1 + posn, 20 - posn);
+			if (size < 0) {
+				perror("rpush: read ");
+				return;
+			}
+			if (!size)
+				return;
+			posn += size;
+		} while (posn < 20);
+
+		/* fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1)); */
+
+		buf = map_sha1_file(sha1, &objsize);
+		if (!buf) {
+			fprintf(stderr, "rpush: could not find %s\n", 
+				sha1_to_hex(sha1));
+			return;
+		}
+		posn = 0;
+		do {
+			size = write(fd_out, buf + posn, objsize - posn);
+			if (size <= 0) {
+				if (!size) {
+					fprintf(stderr, "rpush: write closed");
+				} else {
+					perror("rpush: write ");
+				}
+				return;
+			}
+			posn += size;
+		} while (posn < objsize);
+	} while (1);
+}
+
+int main(int argc, char **argv)
+{
+	int arg = 1;
+        char *commit_id;
+        char *url;
+	int fd_in, fd_out;
+	while (arg < argc && argv[arg][0] == '-') {
+                arg++;
+        }
+        if (argc < arg + 2) {
+                usage("rpush [-c] [-t] [-a] commit-id url");
+                return 1;
+        }
+	commit_id = argv[arg];
+	url = argv[arg + 1];
+	if (setup_connection(&fd_in, &fd_out, "rpull", url, arg, argv + 1))
+		return 1;
+
+	service(fd_in, fd_out);
+	return 0;
+}
Index: rsh.c
===================================================================
--- /dev/null  (tree:9b75904eab1300d83264a1840d396160482fee88)
+++ a56d8adaecc49ce7f26536f9f5d54ec813072e4f/rsh.c  (mode:100644 sha1:4d6a90bf6c1b290975fb2ac22f25979be56cb476)
@@ -0,0 +1,63 @@
+#include "rsh.h"
+
+#include <string.h>
+#include <sys/socket.h>
+
+#include "cache.h"
+
+#define COMMAND_SIZE 4096
+
+int setup_connection(int *fd_in, int *fd_out, char *remote_prog, 
+		     char *url, int rmt_argc, char **rmt_argv)
+{
+	char *host;
+	char *path;
+	int sv[2];
+	char command[COMMAND_SIZE];
+	char *posn;
+	int i;
+
+	if (!strcmp(url, "-")) {
+		*fd_in = 0;
+		*fd_out = 1;
+		return 0;
+	}
+
+	host = strstr(url, "//");
+	if (!host) {
+		return error("Bad URL: %s", url);
+	}
+	host += 2;
+	path = strchr(host, '/');
+	if (!path) {
+		return error("Bad URL: %s", url);
+	}
+	*(path++) = '\0';
+	/* ssh <host> 'cd /<path>; stdio-pull <arg...> <commit-id>' */
+	snprintf(command, COMMAND_SIZE, 
+		 "cd /%s; SHA1_FILE_DIRECTORY=objects %s",
+		 path, remote_prog);
+	posn = command + strlen(command);
+	for (i = 0; i < rmt_argc; i++) {
+		*(posn++) = ' ';
+		strncpy(posn, rmt_argv[i], COMMAND_SIZE - (posn - command));
+		posn += strlen(rmt_argv[i]);
+		if (posn - command + 4 >= COMMAND_SIZE) {
+			return error("Command line too long");
+		}
+	}
+	strcpy(posn, " -");
+	if (socketpair(AF_LOCAL, SOCK_STREAM, 0, sv)) {
+		return error("Couldn't create socket");
+	}
+	if (!fork()) {
+		close(sv[1]);
+		dup2(sv[0], 0);
+		dup2(sv[0], 1);
+		execlp("ssh", "ssh", host, command, NULL);
+	}
+	close(sv[0]);
+	*fd_in = sv[1];
+	*fd_out = sv[1];
+	return 0;
+}
Index: rsh.h
===================================================================
--- /dev/null  (tree:9b75904eab1300d83264a1840d396160482fee88)
+++ a56d8adaecc49ce7f26536f9f5d54ec813072e4f/rsh.h  (mode:100644 sha1:97e4f20b2b80662269827d77f3104025143087e7)
@@ -0,0 +1,7 @@
+#ifndef RSH_H
+#define RSH_H
+
+int setup_connection(int *fd_in, int *fd_out, char *remote_prog, 
+		     char *url, int rmt_argc, char **rmt_argv);
+
+#endif

