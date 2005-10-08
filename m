From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: First cut at git port to Cygwin
Date: Sun, 9 Oct 2005 00:06:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510090004370.30110@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home>
 <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
 <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
 <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
 <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home>
 <20051007212250.GA1423@steel.home> <4346E8AC.5030503@citi.umich.edu>
 <20051007213952.GA8821@steel.home> <Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
 <Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr7avrgr2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510082100020.26626@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk6gnpvf9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 09 00:07:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOMpU-0004u1-0i
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 00:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVJHWGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 18:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVJHWGD
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 18:06:03 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19587 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751146AbVJHWGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 18:06:02 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 79F4113EE40; Sun,  9 Oct 2005 00:06:01 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 547F3B4456; Sun,  9 Oct 2005 00:06:01 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2711AAC889; Sun,  9 Oct 2005 00:06:01 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E4E4613EE40; Sun,  9 Oct 2005 00:06:00 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6gnpvf9.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9856>

Hi,

On Sat, 8 Oct 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Sure. Something like this?
> 
> Not, really.  What I meant was to rip out the writing out
> altogether, and perhaps making sure that the caller never calls
> us without MAP_PRIVATE.

How about this, then?

[PATCH] If NO_MMAP is defined, fake mmap() and munmap()

Since some platforms do not support mmap() at all, and others do only just so,
this patch introduces the option to fake mmap() and munmap() by malloc()ing the
region explicitely.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile      |    6 ++++++
 cache.h       |   16 ++++++++++++++++
 compat/mmap.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mailsplit.c   |    1 -
 4 files changed, 73 insertions(+), 1 deletions(-)
 create mode 100644 compat/mmap.c

applies-to: 274542bcbc891cca353c2728ac4075df3d1d2c0d
ed334e3e2276fe9d41ed78917544ef6a3fa87eb7
diff --git a/Makefile b/Makefile
index 1bdf4de..7ca77cf 100644
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
@@ -258,6 +260,10 @@ ifdef NO_STRCASESTR
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
index 0000000..3f035a0
--- /dev/null
+++ b/compat/mmap.c
@@ -0,0 +1,51 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include "../cache.h"
+
+void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset)
+{
+	int n = 0;
+
+	if(start != NULL || !(flags & MAP_PRIVATE))
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
+	return start;
+}
+
+int gitfakemunmap(void *start, size_t length)
+{
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
