From: Edgar Toernig <froese@gmx.de>
Subject: git compatibility patches
Date: Sat, 30 Apr 2005 13:40:20 +0200
Message-ID: <20050430134020.7fc926ae.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 13:35:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRqFb-0006Hr-3V
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 13:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVD3Lkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 07:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVD3Lkl
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 07:40:41 -0400
Received: from pop.gmx.net ([213.165.64.20]:59092 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261200AbVD3LkZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 07:40:25 -0400
Received: (qmail invoked by alias); 30 Apr 2005 11:40:23 -0000
Received: from p50906D95.dip.t-dialin.net (EHLO dialup) [80.144.109.149]
  by mail.gmx.net (mp010) with SMTP; 30 Apr 2005 13:40:23 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With these fourc patches and the previous date patch git compiles
and works on my good old gcc2.7/libc5/2.0-kernel system.

The first one: support for pre-1.2 zlib:

--- k/cache.h  (mode:100644)
+++ l/cache.h  (mode:100644)
@@ -17,6 +17,10 @@
 #include SHA1_HEADER
 #include <zlib.h>
 
+#if ZLIB_VERNUM < 0x1200
+#define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
+#endif
+
 /*
  * Basic data structures for the directory cache
  *




The second one: missing dirent.d_type field

--- k/cache.h  (mode:100644)
+++ l/cache.h  (mode:100644)
@@ -21,6 +21,15 @@
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
+#ifdef DT_UNKNOWN
+#define DTYPE(de)	((de)->d_type)
+#else
+#define DT_UNKNOWN	0
+#define DT_DIR		1
+#define DT_REG		2
+#define DTYPE(de)	DT_UNKNOWN
+#endif
+
 /*
  * Basic data structures for the directory cache
  *
--- k/show-files.c  (mode:100644)
+++ l/show-files.c  (mode:100644)
@@ -129,7 +129,7 @@ static void read_directory(const char *p
 			len = strlen(de->d_name);
 			memcpy(fullname + baselen, de->d_name, len+1);
 
-			switch (de->d_type) {
+			switch (DTYPE(de)) {
 			struct stat st;
 			default:
 				continue;



The third one: replace AF_LOCAL with AF_UNIX (there's no AF_LOCAL in POSIX).

--- k/rsh.c  (mode:100644)
+++ l/rsh.c  (mode:100644)
@@ -48,7 +48,7 @@ int setup_connection(int *fd_in, int *fd
 		}
 	}
 	strcpy(posn, " -");
-	if (socketpair(AF_LOCAL, SOCK_STREAM, 0, sv)) {
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv)) {
 		return error("Couldn't create socket");
 	}
 	if (!fork()) {


And the last one: move variable declarations to the start of the function.

--- k/tag.c  (mode:100644)
+++ l/tag.c  (mode:100644)
@@ -26,6 +26,10 @@ int parse_tag(struct tag *item)
         char type[20];
         void *data, *bufptr;
         unsigned long size;
+	int typelen, taglen;
+	unsigned char object[20];
+	const char *type_line, *tag_line, *sig_line;
+
         if (item->object.parsed)
                 return 0;
         item->object.parsed = 1;
@@ -36,10 +40,6 @@ int parse_tag(struct tag *item)
         if (strcmp(type, tag_type))
                 return error("Object %s not a tag",
                              sha1_to_hex(item->object.sha1));
-
-	int typelen, taglen;
-	unsigned char object[20];
-	const char *type_line, *tag_line, *sig_line;
 
 	if (size < 64)
 		return -1;

Ciao, ET.
