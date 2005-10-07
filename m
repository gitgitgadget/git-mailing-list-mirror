From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] If NO_MMAP is defined, fake mmap() and munmap()
Date: Sat, 8 Oct 2005 00:55:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510080050550.20922@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Oct 08 00:57:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO184-0007Yw-1h
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 00:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbVJGWzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 18:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbVJGWzt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 18:55:49 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47780 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030556AbVJGWzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 18:55:48 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BD80013F002; Sat,  8 Oct 2005 00:55:47 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 99FE49DD32; Sat,  8 Oct 2005 00:55:47 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6A3F6831CF; Sat,  8 Oct 2005 00:55:40 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3867113F002; Sat,  8 Oct 2005 00:55:40 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9824>


Since some platforms do not support mmap() at all, and others do only just 
so, this patch introduces the option to fake mmap() and munmap() by 
malloc()ing and read()ing explicitely.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

Only lightly tested, but it seems to work correctly (after all, this 
commit was created after compiling with NO_MMAP=1).

 Makefile      |    6 +++
 cache.h       |   16 ++++++++
 compat/mmap.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mailsplit.c   |    1 -
 4 files changed, 135 insertions(+), 1 deletions(-)
 create mode 100644 compat/mmap.c

applies-to: 2c165e1b55bf857247c0f074e9bea680bf411586
3d4f1e103b35c28c8190f9a59ffa95221277fdb4
diff --git a/Makefile b/Makefile
index 2f7cdd4..fb4c410 100644
--- a/Makefile
+++ b/Makefile
@@ -27,6 +27,8 @@
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
 #
+# Define NO_MMAP if you want to avoid mmap.
+#
 # Define WITH_OWN_SUBPROCESS_PY if you want to use with python 2.3.
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
@@ -259,6 +261,10 @@ ifdef NO_STRCASESTR
 	DEFINES += -Dstrcasestr=gitstrcasestr
 	LIB_OBJS += compat/strcasestr.o
 endif
+ifdef NO_MMAP
+	DEFINES += -Dmmap=gitfakemmap -Dmunmap=gitfakemunmap -DNO_MMAP
+	LIB_OBJS += compat/mmap.o
+endif
 ifdef NO_IPV6
 	DEFINES += -DNO_IPV6 -Dsockaddr_storage=sockaddr_in
 endif
diff --git a/cache.h b/cache.h
index 514adb8..5987d4c 100644
--- a/cache.h
+++ b/cache.h
@@ -11,7 +11,9 @@
 #include <string.h>
 #include <errno.h>
 #include <limits.h>
+#ifndef NO_MMAP
 #include <sys/mman.h>
+#endif
 #include <sys/param.h>
 #include <netinet/in.h>
 #include <sys/types.h>
@@ -356,4 +358,18 @@ extern void packed_object_info_detail(st
 /* Dumb servers support */
 extern int update_server_info(int);
 
+#ifdef NO_MMAP
+
+#ifndef PROT_READ
+#define PROT_READ 1
+#define PROT_WRITE 2
+#define MAP_PRIVATE 1
+#define MAP_FAILED ((void*)-1)
+#endif
+
+extern void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset);
+extern int gitfakemunmap(void *start, size_t length);
+
+#endif
+
 #endif /* CACHE_H */
diff --git a/compat/mmap.c b/compat/mmap.c
new file mode 100644
index 0000000..fca6321
--- /dev/null
+++ b/compat/mmap.c
@@ -0,0 +1,113 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include "../cache.h"
+
+typedef struct fakemmapwritable {
+	void *start;
+	size_t length;
+	int fd;
+	off_t offset;
+	struct fakemmapwritable *next;
+} fakemmapwritable;
+
+static fakemmapwritable *writablelist = NULL;
+
+void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset)
+{
+	int n = 0;
+
+	if(start != NULL)
+		die("Invalid usage of gitfakemmap.");
+
+	if(lseek(fd, offset, SEEK_SET)<0) {
+		errno = EINVAL;
+		return MAP_FAILED;
+	}
+
+	start = xmalloc(length);
+	if(start == NULL) {
+		errno = ENOMEM;
+		return MAP_FAILED;
+	}
+
+	while(n < length) {
+		int count = read(fd, start+n, length-n);
+
+		if(count == 0) {
+			memset(start+n, 0, length-n);
+			break;
+		}
+
+		if(count < 0) {
+			free(start);
+			errno = EACCES;
+			return MAP_FAILED;
+		}
+
+		n += count;
+	}
+
+	if(prot & PROT_WRITE) {
+		fakemmapwritable *next = xmalloc(sizeof(fakemmapwritable));
+		next->start = start;
+		next->length = length;
+		next->fd = dup(fd);
+		next->offset = offset;
+		next->next = writablelist;
+		writablelist = next;
+	}
+
+	return start;
+}
+
+int gitfakemunmap(void *start, size_t length)
+{
+	fakemmapwritable *writable = writablelist, *before = NULL;
+
+	while(writable && (writable->start > start + length
+			|| writable->start + writable->length < start)) {
+		before = writable;
+		writable = writable->next;
+	}
+
+	if(writable) {
+		/* need to write back the contents */
+		int n = 0;
+
+		if(writable->start != start || writable->length != length)
+			die("fakemmap does not support partial write back.");
+
+		if(lseek(writable->fd, writable->offset, SEEK_SET) < 0) {
+			free(start);
+			errno = EBADF;
+			return -1;
+		}
+
+		while(n < length) {
+			int count = write(writable->fd, start + n, length - n);
+
+			if(count < 0) {
+				errno = EINVAL;
+				return -1;
+			}
+
+			n += count;
+		}
+
+		close(writable->fd);
+
+		if(before)
+			before->next = writable->next;
+		else
+			writablelist = writable->next;
+
+		free(writable);
+	}
+
+	free(start);
+
+	return 0;
+}
+
diff --git a/mailsplit.c b/mailsplit.c
index 7981f87..0f8100d 100644
--- a/mailsplit.c
+++ b/mailsplit.c
@@ -9,7 +9,6 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <string.h>
 #include <stdio.h>
 #include <ctype.h>
---
0.99.8.GIT
