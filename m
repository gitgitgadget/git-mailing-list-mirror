From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/2 (with .gitignore)] simple random data generator for tests
Date: Wed, 11 Apr 2007 13:59:51 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704111355390.28181@xanadu.home>
References: <alpine.LFD.0.98.0704111330120.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbh6p-0000C8-HG
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 19:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbXDKR7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 13:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbXDKR7w
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 13:59:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15108 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbXDKR7v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 13:59:51 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGC00GRPHZR91N0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Apr 2007 13:59:51 -0400 (EDT)
In-reply-to: <alpine.LFD.0.98.0704111330120.28181@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44250>

Reliance on /dev/urandom produces test vectors that are, well, random. 
This can cause problems impossible to track down when the data is 
different from one test invokation to another.

The goal is not to have random data to test, but rather to have a 
convenient way to create sets of large files with non compressible and 
non deltifiable data in a reproducible way.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/Makefile b/Makefile
index a77d31d..bd0ba95 100644
--- a/Makefile
+++ b/Makefile
@@ -932,7 +932,7 @@ endif
 
 export NO_SVN_TESTS
 
-test: all test-chmtime$X
+test: all test-chmtime$X test-genrandom$X
 	$(MAKE) -C t/ all
 
 test-date$X: test-date.c date.o ctype.o
@@ -953,6 +953,9 @@ test-match-trees$X: test-match-trees.o $(GITLIBS)
 test-chmtime$X: test-chmtime.c
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
 
+test-genrandom$X: test-genrandom.c
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
+
 check-sha1:: test-sha1$X
 	./test-sha1.sh
 
@@ -1041,7 +1044,7 @@ dist-doc:
 
 clean:
 	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
-		test-chmtime$X $(LIB_FILE) $(XDIFF_LIB)
+		test-chmtime$X test-genrandom$X $(LIB_FILE) $(XDIFF_LIB)
 	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
 	rm -rf autom4te.cache
diff --git a/test-genrandom.c b/test-genrandom.c
new file mode 100644
index 0000000..6cc4650
--- /dev/null
+++ b/test-genrandom.c
@@ -0,0 +1,34 @@
+/*
+ * Simple random data generator used to create reproducible test files.
+ * This is inspired from POSIX.1-2001 implementation example for rand().
+ * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+int main(int argc, char *argv[])
+{
+	unsigned long count, next = 0;
+	unsigned char *c;
+
+	if (argc < 2 || argc > 3) {
+		fprintf( stderr, "Usage: %s <seed_string> [<size>]", argv[0]);
+		return 1;
+	}
+
+	c = (unsigned char *) argv[1];
+	do {
+		next = next * 11 + *c;
+	} while (*c++);
+	
+	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : -1L;
+
+	while (count--) {
+		next = next * 1103515245 + 12345;
+		if (putchar((next >> 16) & 0xff) == EOF)
+			return -1;
+	}
+
+	return 0;
+}
diff --git a/.gitignore b/.gitignore
index 9229e91..fa7ac93 100644
--- a/.gitignore
+++ b/.gitignore
@@ -149,6 +149,7 @@ test-chmtime
 test-date
 test-delta
 test-dump-cache-tree
+test-genrandom
 test-match-trees
 common-cmds.h
 *.tar.gz
