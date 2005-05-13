From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/4] Pulling refs by ssh
Date: Fri, 13 May 2005 03:01:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505130258030.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 08:54:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWU3a-0000ad-L6
	for gcvg-git@gmane.org; Fri, 13 May 2005 08:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVEMHBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 03:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVEMHBr
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 03:01:47 -0400
Received: from iabervon.org ([66.92.72.58]:63237 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262270AbVEMHBf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 03:01:35 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DWUAa-0008Nn-00; Fri, 13 May 2005 03:01:12 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Adds support for pulling refs by rsh.

This changes the rsh protocol to allow requests for different things, and
to allow the server to report that it doesn't have something without
breaking the connection.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: rpull.c
===================================================================
--- 4931f2d8b9c2ab83718f6446d5ef3af5fa320b3f/rpull.c  (mode:100644 sha1:493fcdae670ebb1d93b8c75d3e28798e060d7537)
+++ a219d8e31f3882aaa32e7dbac7a1f92b35a9dbff/rpull.c  (mode:100644 sha1:cce9e71becc95f728d320ef49e11a647a420b75d)
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include "rsh.h"
 #include "pull.h"
+#include "refs.h"
 
 static int fd_in;
 static int fd_out;
@@ -15,16 +16,34 @@
 int fetch(unsigned char *sha1)
 {
 	int ret;
+	signed char remote;
+	char type = 'o';
+	if (has_sha1_file(sha1))
+		return 0;
+	write(fd_out, &type, 1);
 	write(fd_out, sha1, 20);
+	if (read(fd_in, &remote, 1) < 1)
+		return -1;
+	if (remote < 0)
+		return remote;
 	ret = write_sha1_from_fd(sha1, fd_in);
 	if (!ret)
 		pull_say("got %s\n", sha1_to_hex(sha1));
 	return ret;
 }
 
-int fetch_ref(char *dir, char *name, unsigned char *sha1)
+int fetch_ref(char *name, char *dir, unsigned char *sha1)
 {
-	return -1;
+	signed char remote;
+	char type = 'r';
+	write(fd_out, &type, 1);
+	write(fd_out, name, strlen(name) + 1);
+	write(fd_out, dir, strlen(dir) + 1);
+	read(fd_in, &remote, 1);
+	if (remote < 0)
+		return remote;
+	read(fd_in, sha1, 20);
+	return 0;
 }
 
 int main(int argc, char **argv)
@@ -44,6 +63,10 @@
 			get_history = 1;
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
+		} else if (argv[arg][1] == 'w') {
+			char *write_ref = argv[arg + 1];
+			split_ref(&write_ref_dir, &write_ref_name, write_ref);
+			arg++;
 		}
 		arg++;
 	}
Index: rpush.c
===================================================================
--- 4931f2d8b9c2ab83718f6446d5ef3af5fa320b3f/rpush.c  (mode:100644 sha1:26518846704ecf63ad00390599b251aa1b32713e)
+++ a219d8e31f3882aaa32e7dbac7a1f92b35a9dbff/rpush.c  (mode:100644 sha1:c3cad4eac186307e743eacb913a0b382a455d1f4)
@@ -2,47 +2,98 @@
 #include "rsh.h"
 #include <sys/socket.h>
 #include <errno.h>
+#include "refs.h"
 
-void service(int fd_in, int fd_out) {
+int serve_object(int fd_in, int fd_out) {
 	ssize_t size;
-	int posn;
+	int posn = 0;
 	char sha1[20];
 	unsigned long objsize;
 	void *buf;
+	signed char remote;
 	do {
-		posn = 0;
-		do {
-			size = read(fd_in, sha1 + posn, 20 - posn);
-			if (size < 0) {
-				perror("rpush: read ");
-				return;
+		size = read(fd_in, sha1 + posn, 20 - posn);
+		if (size < 0) {
+			perror("rpush: read ");
+			return -1;
+		}
+		if (!size)
+			return -1;
+		posn += size;
+	} while (posn < 20);
+	
+	/* fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1)); */
+	remote = 0;
+	
+	buf = map_sha1_file(sha1, &objsize);
+	
+	if (!buf) {
+		fprintf(stderr, "rpush: could not find %s\n", 
+			sha1_to_hex(sha1));
+		remote = -1;
+	}
+	
+	write(fd_out, &remote, 1);
+	
+	if (remote < 0)
+		return 0;
+	
+	posn = 0;
+	do {
+		size = write(fd_out, buf + posn, objsize - posn);
+		if (size <= 0) {
+			if (!size) {
+				fprintf(stderr, "rpush: write closed");
+			} else {
+				perror("rpush: write ");
 			}
-			if (!size)
-				return;
-			posn += size;
-		} while (posn < 20);
+			return -1;
+		}
+		posn += size;
+	} while (posn < objsize);
+	return 0;
+}
 
-		/* fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1)); */
+int serve_ref(int fd_in, int fd_out)
+{
+	char dir[PATH_MAX], name[PATH_MAX];
+	unsigned char sha1[20];
+	int posn = 0;
+	signed char remote = 0;
+	do {
+		if (read(fd_in, dir + posn, 1) < 1)
+			return -1;
+		posn++;
+	} while (dir[posn - 1]);
+	posn = 0;
+	do {
+		if (read(fd_in, name + posn, 1) < 1)
+			return -1;
+		posn++;
+	} while (name[posn - 1]);
+	if (get_split_ref_sha1(dir, name, sha1))
+		remote = -1;
+	write(fd_out, &remote, 1);
+	if (remote)
+		return 0;
+	write(fd_out, sha1, 20);
+	return 0;
+}
 
-		buf = map_sha1_file(sha1, &objsize);
-		if (!buf) {
-			fprintf(stderr, "rpush: could not find %s\n", 
-				sha1_to_hex(sha1));
+void service(int fd_in, int fd_out) {
+	char type;
+	int retval;
+	do {
+		retval = read(fd_in, &type, 1);
+		if (retval < 1) {
+			if (retval < 0)
+				perror("rpush: read ");
 			return;
 		}
-		posn = 0;
-		do {
-			size = write(fd_out, buf + posn, objsize - posn);
-			if (size <= 0) {
-				if (!size) {
-					fprintf(stderr, "rpush: write closed");
-				} else {
-					perror("rpush: write ");
-				}
-				return;
-			}
-			posn += size;
-		} while (posn < objsize);
+		if (type == 'o' && serve_object(fd_in, fd_out))
+			return;
+		if (type == 'r' && serve_ref(fd_in, fd_out))
+			return;
 	} while (1);
 }
 
@@ -53,6 +104,8 @@
         char *url;
 	int fd_in, fd_out;
 	while (arg < argc && argv[arg][0] == '-') {
+		if (argv[arg][1] == 'w')
+			arg++;
                 arg++;
         }
         if (argc < arg + 2) {
Index: rsh.c
===================================================================
--- 4931f2d8b9c2ab83718f6446d5ef3af5fa320b3f/rsh.c  (mode:100644 sha1:5d1cb9d578a8e679fc190a9d7d2c842ad811223f)
+++ a219d8e31f3882aaa32e7dbac7a1f92b35a9dbff/rsh.c  (mode:100644 sha1:192d8f67e9a5e2bf7bb9e14c8c037dff49e74d57)
@@ -36,8 +36,8 @@
 	*(path++) = '\0';
 	/* ssh <host> 'cd /<path>; stdio-pull <arg...> <commit-id>' */
 	snprintf(command, COMMAND_SIZE, 
-		 "cd /%s; %s=objects %s",
-		 path, DB_ENVIRONMENT, remote_prog);
+		 "cd /%s; GIT_DIR=. %s",
+		 path, remote_prog);
 	posn = command + strlen(command);
 	for (i = 0; i < rmt_argc; i++) {
 		*(posn++) = ' ';

