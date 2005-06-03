From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] ssh-protocol version, command types, response code
Date: Fri, 3 Jun 2005 17:43:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506031740020.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 23:42:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeJvU-0006dt-3h
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 23:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVFCVpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 17:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFCVpI
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 17:45:08 -0400
Received: from iabervon.org ([66.92.72.58]:62468 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261425AbVFCVox (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 17:44:53 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DeJxI-0002S4-00; Fri, 3 Jun 2005 17:43:52 -0400
To: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch makes an incompatible change to the protocol used by
rpull/rpush which will let it be extended in the future without
incompatible changes. 

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: rpull.c
===================================================================
--- 33942306faa3093107cc7105dff046de5c981d2e/rpull.c  (mode:100644 sha1:36e49f799a6ac300a00f8d09d9dc9e6636b3d8e0)
+++ 1f3a64b193531d17cafb7db8aae4a08d92be3132/rpull.c  (mode:100644 sha1:a3d13595d3db6c26d4d55fe7ef516efd5c8f6a0c)
@@ -6,16 +6,39 @@
 static int fd_in;
 static int fd_out;
 
+static unsigned char remote_version = 0;
+static unsigned char local_version = 1;
+
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
 
+int get_version(void)
+{
+	char type = 'v';
+	write(fd_out, &type, 1);
+	write(fd_out, &local_version, 1);
+	if (read(fd_in, &remote_version, 1) < 1) {
+		return error("Couldn't read version from remote end");
+	}
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	char *commit_id;
@@ -46,6 +69,9 @@
 	if (setup_connection(&fd_in, &fd_out, "git-rpush", url, arg, argv + 1))
 		return 1;
 
+	if (get_version())
+		return 1;
+
 	if (pull(commit_id))
 		return 1;
 
Index: rpush.c
===================================================================
--- 33942306faa3093107cc7105dff046de5c981d2e/rpush.c  (mode:100644 sha1:17d5ab8a60ab2ec7fa3a7dc927351e8a34de3a89)
+++ 1f3a64b193531d17cafb7db8aae4a08d92be3132/rpush.c  (mode:100644 sha1:bd381ac9d1787dc979b1eba5bd72c1fd644a094b)
@@ -3,46 +3,81 @@
 #include <sys/socket.h>
 #include <errno.h>
 
-static void service(int fd_in, int fd_out) {
+unsigned char local_version = 1;
+unsigned char remote_version = 0;
+
+int serve_object(int fd_in, int fd_out) {
 	ssize_t size;
-	int posn;
-	char unsigned sha1[20];
+	int posn = 0;
+	char sha1[20];
 	unsigned long objsize;
 	void *buf;
+	signed char remote;
+	do {
+		size = read(fd_in, sha1 + posn, 20 - posn);
+		if (size < 0) {
+			perror("git-rpush: read ");
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
+		fprintf(stderr, "git-rpush: could not find %s\n", 
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
 	do {
-		posn = 0;
-		do {
-			size = read(fd_in, sha1 + posn, 20 - posn);
-			if (size < 0) {
-				perror("git-rpush: read ");
-				return;
+		size = write(fd_out, buf + posn, objsize - posn);
+		if (size <= 0) {
+			if (!size) {
+				fprintf(stderr, "git-rpush: write closed");
+			} else {
+				perror("git-rpush: write ");
 			}
-			if (!size)
-				return;
-			posn += size;
-		} while (posn < 20);
-
-		/* fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1)); */
-
-		buf = map_sha1_file(sha1, &objsize);
-		if (!buf) {
-			fprintf(stderr, "git-rpush: could not find %s\n", 
-				sha1_to_hex(sha1));
+			return -1;
+		}
+		posn += size;
+	} while (posn < objsize);
+	return 0;
+}
+
+int serve_version(int fd_in, int fd_out)
+{
+	if (read(fd_in, &remote_version, 1) < 1)
+		return -1;
+	write(fd_out, &local_version, 1);
+	return 0;
+}
+
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
-					fprintf(stderr, "git-rpush: write closed");
-				} else {
-					perror("git-rpush: write ");
-				}
-				return;
-			}
-			posn += size;
-		} while (posn < objsize);
+		if (type == 'v' && serve_version(fd_in, fd_out))
+			return;
+		if (type == 'o' && serve_object(fd_in, fd_out))
+			return;
 	} while (1);
 }
 
@@ -56,7 +91,7 @@
                 arg++;
         }
         if (argc < arg + 2) {
-                usage("git-rpush [-c] [-t] [-a] commit-id url");
+		usage("git-rpush [-c] [-t] [-a] commit-id url");
                 return 1;
         }
 	commit_id = argv[arg];

