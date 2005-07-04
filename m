From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Unlock refs files on error exit
Date: Mon, 4 Jul 2005 16:08:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507041557310.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 22:17:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpXNV-0008E9-IE
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 22:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVGDURB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 16:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVGDURB
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 16:17:01 -0400
Received: from iabervon.org ([66.92.72.58]:6661 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261629AbVGDUKv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 16:10:51 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DpXFP-00034l-00; Mon, 4 Jul 2005 16:08:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If a program locks a refs file (as git-ssh-pull -w now does for an
existing file), it should unlock it again if it exits without changing
it. Some trickiness is required to make this not happen in forks of the
process.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---
commit 8934c88118c900fe38abbf60f893ee9ef4e83b3c
tree 62a74516551505e5fd2b5c2fd14486f3ac8a400e
parent 2045e6098dfa0f8760b6a4a65227a6ea51de990d
author Daniel Barkalow <barkalow@iabervon.org> 1120507109 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1120507109 -0400

Index: refs.c
===================================================================
--- 3d3e671c0ac57ea66434768c2b3432352b7c20ae/refs.c  (mode:100644 sha1:447080edde385a470a815944c2f002c1e51699a5)
+++ 62a74516551505e5fd2b5c2fd14486f3ac8a400e/refs.c  (mode:100644 sha1:6e75e82665f5c8e3e155579228c5104c16318239)
@@ -2,6 +2,14 @@
 #include "cache.h"
 
 #include <errno.h>
+#include <signal.h>
+
+#define MAX_LOCKS 10
+
+static int setup = 0;
+
+static int num_locks = 0;
+static char *locknames[MAX_LOCKS];
 
 static int read_ref(const char *path, unsigned char *sha1)
 {
@@ -88,6 +96,22 @@
 	return ret;
 }
 
+static void remove_lock_files(void)
+{
+	int i;
+	if (getpid() != setup)
+		return;
+	for (i = 0; i < num_locks; i++) {
+		unlink(locknames[i]);
+	}
+	num_locks = 0;
+}
+
+static void remove_lock_files_on_signal(int signo) 
+{
+	remove_lock_files();
+}
+
 static int read_ref_file(const char *filename, unsigned char *sha1) {
 	int fd = open(filename, O_RDONLY);
 	char hex[41];
@@ -120,9 +144,12 @@
 static int lock_ref_file(const char *filename, const char *lock_filename,
 			 const unsigned char *old_sha1)
 {
-	int fd = open(lock_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	int fd;
 	unsigned char current_sha1[20];
 	int retval;
+	if (num_locks >= MAX_LOCKS)
+		return error("Too many locks in refs.c");
+	fd = open(lock_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
 	if (fd < 0) {
 		return error("Couldn't open lock file for %s: %s",
 			     filename, strerror(errno));
@@ -151,6 +178,12 @@
 				     sha1_to_hex(current_sha1), filename);
 		}
 	}
+	if (!setup) {
+		signal(SIGINT, remove_lock_files_on_signal);
+		atexit(remove_lock_files);
+		setup = getpid();
+	}
+	locknames[num_locks++] = strdup(lock_filename);
 	return fd;
 }
 
@@ -175,6 +208,7 @@
 {
 	char *hex = sha1_to_hex(sha1);
 	char term = '\n';
+	int i;
 	if (write(fd, hex, 40) < 40 ||
 	    write(fd, &term, 1) < 1) {
 		error("Couldn't write %s\n", filename);
@@ -182,7 +216,14 @@
 		return -1;
 	}
 	close(fd);
-	rename(lock_filename, filename);
+	if (rename(lock_filename, filename))
+		return error("Couldn't update %s", filename);
+	for (i = 0; i < num_locks; i++) {
+		if (!strcmp(lock_filename, locknames[i])) {
+			locknames[i] = locknames[--num_locks];
+			break;
+		}
+	}
 	return 0;
 }
 
