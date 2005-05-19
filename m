From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Make rsh protocol extensible
Date: Thu, 19 May 2005 01:11:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505190108490.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 07:12:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYdKS-0006yO-OT
	for gcvg-git@gmane.org; Thu, 19 May 2005 07:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVESFMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 01:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVESFMy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 01:12:54 -0400
Received: from iabervon.org ([66.92.72.58]:44804 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262215AbVESFMT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 01:12:19 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DYdJy-0006x0-00; Thu, 19 May 2005 01:11:46 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This changes the rsh protocol to allow reporting failure in getting an
object without breaking the connection, and to allow other types of
request than for objects to be made. It is a preliminary to any more
extensive pull operation.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: rpull.c
===================================================================
--- 75b95bec390d6728b9b1b4572056af8cee34ea7d/rpull.c  (mode:100644 sha1:b48e63157c66c160b9751603a92831f77106044c)
+++ c70baff05489356575384857c7cc4d4c641c39e3/rpull.c  (mode:100644 sha1:7f5b390d8ed653bfb67363db2c61c576a4d3134d)
@@ -15,7 +15,16 @@
 int fetch(unsigned char *sha1)
 {
 	int ret;
-	write(fd_out, sha1, 20);
+	signed char remote;
+	char type = 'o';
+	if (has_sha1_file(sha1))
+		return 0;
+	write(fd_out, &type, 1);
+        write(fd_out, sha1, 20);
+	if (read(fd_in, &remote, 1) < 1)
+		return -1;
+	if (remote < 0)
+		return remote;
 	ret = write_sha1_from_fd(sha1, fd_in);
 	if (!ret)
 		pull_say("got %s\n", sha1_to_hex(sha1));
Index: rpush.c
===================================================================
--- 75b95bec390d6728b9b1b4572056af8cee34ea7d/rpush.c  (mode:100644 sha1:3f2c898c8f5cf5ba62d689a13c646936b8372ee7)
+++ c70baff05489356575384857c7cc4d4c641c39e3/rpush.c  (mode:100644 sha1:07a8461878ad7b1d8cea27e44003b2ed44632834)
@@ -3,46 +3,68 @@
 #include <sys/socket.h>
 #include <errno.h>
 
-void service(int fd_in, int fd_out) {
+int serve_object(int fd_in, int fd_out) {
 	ssize_t size;
-	int posn;
+	int posn = 0;
 	char unsigned sha1[20];
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
-
-		/* fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1)); */
+			return -1;
+		}
+		posn += size;
+	} while (posn < objsize);
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
 	} while (1);
 }
 
@@ -53,6 +75,8 @@
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
--- 75b95bec390d6728b9b1b4572056af8cee34ea7d/rsh.c  (mode:100644 sha1:5d1cb9d578a8e679fc190a9d7d2c842ad811223f)
+++ c70baff05489356575384857c7cc4d4c641c39e3/rsh.c  (mode:100644 sha1:71afc1aa5c9fb3cfe8d49e73471c30e92df9e327)
@@ -36,8 +36,8 @@
 	*(path++) = '\0';
 	/* ssh <host> 'cd /<path>; stdio-pull <arg...> <commit-id>' */
 	snprintf(command, COMMAND_SIZE, 
-		 "cd /%s; %s=objects %s",
-		 path, DB_ENVIRONMENT, remote_prog);
+		 "GIT_DIR='%s' %s",
+		 path, remote_prog);
 	posn = command + strlen(command);
 	for (i = 0; i < rmt_argc; i++) {
 		*(posn++) = ' ';

