From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Use read_object_with_reference() in tar-tree
Date: Fri, 29 Apr 2005 05:21:27 +0200
Message-ID: <20050429032127.GA12160@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 05:16:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRLyw-0005YV-By
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 05:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVD2DVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 23:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVD2DVd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 23:21:33 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:62106 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262375AbVD2DV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 23:21:28 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 2FD593A5; Fri, 29 Apr 2005 05:21:27 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch replaces the usage of read_tree_with_tree_or_commit_sha1()
with read_object_with_reference() in tar-tree.  As a result the code
that tries to figure out the commit time doesn't need to open the commit
object 'by hand' any more.

Signed-off-by: Rene Scharfe <lsrfire.ath.cx>

Index: tar-tree.c
===================================================================
--- dc0b54b68c90574a689fef23c5ab26d165f3ee2e/tar-tree.c  (mode:100644 sha1:d078cb5a8d4ab5bc2c774b889b602d179bde39b1)
+++ 1e2168c7d554a4fbd25a09bb591ae0f82dac6513/tar-tree.c  (mode:100644 sha1:5cc7cfef6db1269d81589b82255537fb64ba02fa)
@@ -291,35 +291,28 @@
 }
 
 /* get commit time from committer line of commit object */
-time_t commit_time(const unsigned char *sha1)
+time_t commit_time(void * buffer, unsigned long size)
 {
-        char type[20];
-        void *buffer;
-        unsigned long size;
 	time_t result = 0;
+	char *p = buffer;
 
-        buffer = read_sha1_file(sha1, type, &size);
-	if (buffer) {
-		char *p = buffer;
-		while (size > 0) {
-			char *endp = memchr(p, '\n', size);
-			if (!endp || endp == p)
-				break;
-			*endp = '\0';
-			if (endp - p > 10 && !memcmp(p, "committer ", 10)) {
-				char *nump = strrchr(p, '>');
-				if (!nump)
-					break;
-				nump++;
-				result = strtoul(nump, &endp, 10);
-				if (*endp != ' ')
-					result = 0;
+	while (size > 0) {
+		char *endp = memchr(p, '\n', size);
+		if (!endp || endp == p)
+			break;
+		*endp = '\0';
+		if (endp - p > 10 && !memcmp(p, "committer ", 10)) {
+			char *nump = strrchr(p, '>');
+			if (!nump)
 				break;
-			}
-			size -= endp - p - 1;
-			p = endp + 1;
+			nump++;
+			result = strtoul(nump, &endp, 10);
+			if (*endp != ' ')
+				result = 0;
+			break;
 		}
-		free(buffer);
+		size -= endp - p - 1;
+		p = endp + 1;
 	}
 	return result;
 }
@@ -329,7 +322,6 @@
 	unsigned char sha1[20];
 	void *buffer;
 	unsigned long size;
-	unsigned char tree_sha1[20];
 
 	switch (argc) {
 	case 3:
@@ -347,11 +339,15 @@
 	if (!sha1_file_directory)
 		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
 
-	buffer = read_tree_with_tree_or_commit_sha1(sha1, &size, tree_sha1);
+	buffer = read_object_with_reference(sha1, "commit", &size, NULL);
+	if (buffer) {
+		archive_time = commit_time(buffer, size);
+		free(buffer);
+	}
+	buffer = read_object_with_reference(sha1, "tree", &size, NULL);
 	if (!buffer)
-		die("unable to read sha1 file");
-	if (memcmp(sha1, tree_sha1, 20))	/* is sha1 a commit object? */
-		archive_time = commit_time(sha1);
+		die("not a reference to a tag, commit or tree object: %s",
+		    sha1_to_hex(sha1));
 	if (!archive_time)
 		archive_time = time(NULL);
 	if (basedir)
