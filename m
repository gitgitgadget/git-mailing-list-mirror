From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/4] -w support for git-ssh-pull/push
Date: Mon, 6 Jun 2005 16:43:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506061638300.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:43:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfOQA-0003Mr-FI
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 22:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVFFUpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 16:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFFUpe
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 16:45:34 -0400
Received: from iabervon.org ([66.92.72.58]:14853 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261702AbVFFUom (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 16:44:42 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DfORT-0007Bh-00; Mon, 6 Jun 2005 16:43:27 -0400
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds support for -w to git-ssh-pull and git-ssh-push to make
receiving side write the commit that was transferred to a reference file.

Index: ssh-pull.c
===================================================================
--- 8deba080337c75a41cb456cc8b59000654278e59/ssh-pull.c  (mode:100644 sha1:c0cee73facbbb3ced2e566789ba1dda57b245f47)
+++ 8293f31cb78c1c7aaf6e521e99a9d2d2a05fabec/ssh-pull.c  (mode:100644 sha1:3d1ff5ef0107da9f56f5f7024af9e2d02f7eec57)
@@ -2,6 +2,7 @@
 #include "commit.h"
 #include "rsh.h"
 #include "pull.h"
+#include "refs.h"
 
 static int fd_in;
 static int fd_out;
@@ -41,7 +42,15 @@
 
 int fetch_ref(char *ref, unsigned char *sha1)
 {
-	return -1;
+	signed char remote;
+	char type = 'r';
+	write(fd_out, &type, 1);
+	write(fd_out, ref, strlen(ref) + 1);
+	read(fd_in, &remote, 1);
+	if (remote < 0)
+		return remote;
+	read(fd_in, sha1, 20);
+	return 0;
 }
 
 int main(int argc, char **argv)
@@ -63,11 +72,14 @@
 			get_history = 1;
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
+		} else if (argv[arg][1] == 'w') {
+			write_ref = argv[arg + 1];
+			arg++;
 		}
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("git-ssh-pull [-c] [-t] [-a] [-v] [-d] commit-id url");
+		usage("git-ssh-pull [-c] [-t] [-a] [-v] [-d] [-w ref] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
Index: ssh-push.c
===================================================================
--- 8deba080337c75a41cb456cc8b59000654278e59/ssh-push.c  (mode:100644 sha1:bd381ac9d1787dc979b1eba5bd72c1fd644a094b)
+++ 8293f31cb78c1c7aaf6e521e99a9d2d2a05fabec/ssh-push.c  (mode:100644 sha1:79fb6fc05f859a9daa4597296bfe8c1440949833)
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "rsh.h"
-#include <sys/socket.h>
-#include <errno.h>
+#include "refs.h"
 
 unsigned char local_version = 1;
 unsigned char remote_version = 0;
@@ -64,6 +63,27 @@
 	return 0;
 }
 
+int serve_ref(int fd_in, int fd_out)
+{
+	char ref[PATH_MAX];
+	unsigned char sha1[20];
+	int posn = 0;
+	signed char remote = 0;
+	do {
+		if (read(fd_in, ref + posn, 1) < 1)
+			return -1;
+		posn++;
+	} while (ref[posn - 1]);
+	if (get_ref_sha1(ref, sha1))
+		remote = -1;
+	write(fd_out, &remote, 1);
+	if (remote)
+		return 0;
+	write(fd_out, sha1, 20);
+        return 0;
+}
+
+
 void service(int fd_in, int fd_out) {
 	char type;
 	int retval;
@@ -78,6 +98,8 @@
 			return;
 		if (type == 'o' && serve_object(fd_in, fd_out))
 			return;
+		if (type == 'r' && serve_ref(fd_in, fd_out))
+			return;
 	} while (1);
 }
 
@@ -88,10 +110,12 @@
         char *url;
 	int fd_in, fd_out;
 	while (arg < argc && argv[arg][0] == '-') {
+		if (argv[arg][1] == 'w')
+			arg++;
                 arg++;
         }
         if (argc < arg + 2) {
-		usage("git-ssh-push [-c] [-t] [-a] commit-id url");
+		usage("git-ssh-push [-c] [-t] [-a] [-w ref] commit-id url");
                 return 1;
         }
 	commit_id = argv[arg];

