From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cygwin: push/pull takes very long time
Date: Thu, 2 Mar 2006 22:54:08 +0100
Message-ID: <20060302215408.GC6183@steel.home>
References: <81b0412b0603020526w7db41994v54a96895c1a6e960@mail.gmail.com> <81b0412b0603020909p179ed9bx4ed8fc2ddf77e868@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 02 22:54:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEvkw-0004U8-6h
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 22:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbWCBVyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 16:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWCBVyg
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 16:54:36 -0500
Received: from devrace.com ([198.63.210.113]:26628 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751997AbWCBVyf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 16:54:35 -0500
Received: from tigra.home (p54A05596.dip.t-dialin.net [84.160.85.150])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k22LsB9I017555
	for <git@vger.kernel.org>; Thu, 2 Mar 2006 15:54:12 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FEvkP-0005lb-00
	for <git@vger.kernel.org>; Thu, 02 Mar 2006 22:54:09 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FEvkO-0002Dp-UZ
	for <git@vger.kernel.org>; Thu, 02 Mar 2006 22:54:08 +0100
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81b0412b0603020909p179ed9bx4ed8fc2ddf77e868@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17110>

Alex Riesen, Thu, Mar 02, 2006 18:09:23 +0100:
> I'll cleanup the profiling code and send it as well soon
> (I had to instrument x*alloc).

This is not exactly the same. It counts free as well, even if that is
not really interesting - there are places were there is more frees
than allocs. Probably something missed or a result coming from libc.

Also it is _not_ the code I used for windows. I had to have a global
variable for argv[0], which needs modification of all main()s, which
gets too easily out of sync.

BTW, maybe someone has an idea as to how attach valgrind to everything?
(I mean, without changing every script. Maybe modify git.c?)

Anyway, here it is, could be useful for something.

---

diff --git a/Makefile b/Makefile
index a5eb0c4..18fc802 100644
--- a/Makefile
+++ b/Makefile
@@ -206,7 +206,7 @@ LIB_OBJS = \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
-	fetch-clone.o \
+	fetch-clone.o alloc.o \
 	$(DIFF_OBJS)
 
 LIBS = $(LIB_FILE)
diff --git a/alloc.c b/alloc.c
new file mode 100644
index 0000000..76727e6
--- /dev/null
+++ b/alloc.c
@@ -0,0 +1,108 @@
+/* simple allocation logging */
+#include <unistd.h>
+#include <limits.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include "git-compat-util.h"
+
+#undef free
+
+#define SHIFT 2
+static unsigned cnts[12] = {0,0,0,0, 0,0,0,0};
+static unsigned fcnt = 0;
+
+static int exit_hook = 1;
+
+static void alloc_profile()
+{
+	char argv0[PATH_MAX];
+	FILE *fp;
+	fp = fopen("/proc/self/cmdline", "r");
+	if ( !fp ) {
+		sprintf(argv0, "%d", getpid());
+	} else {
+		fread(argv0, sizeof(argv0), 1, fp);
+		fclose(fp);
+		char *s = strrchr(argv0, '/');
+		if ( s )
+			memmove(argv0, s + 1, strlen(s));
+	}
+	fp = fopen("/tmp/git-alloc", "ab");
+	if ( !fp )
+		return;
+	unsigned i, c = 0;
+	for ( i = 0; i < sizeof(cnts)/sizeof(*cnts); ++i ) {
+		if ( !cnts[i] )
+			continue;
+		fprintf(fp, "%s %u %u:%u %u times\n",
+			argv0,
+			i,
+			i ? 1 << i * SHIFT: 0,
+			1 << (i+1) * SHIFT,
+			cnts[i]);
+		c += cnts[i];
+	}
+	fprintf(fp, "%s alloc-free = %u\n", argv0, c - fcnt);
+	fclose(fp);
+}
+
+static inline void count(size_t size)
+{
+	if ( exit_hook ) {
+		exit_hook = 0;
+		atexit(alloc_profile);
+	}
+        unsigned i = 0;
+	while ( size && i < sizeof(cnts)/sizeof(*cnts) ) {
+		size >>= SHIFT;
+		if ( size )
+			++i;
+		else {
+			++cnts[i];
+			return;
+		}
+	}
+	++cnts[sizeof(cnts)/sizeof(*cnts)-1];
+}
+
+void *xmalloc(size_t size)
+{
+	void *ret = malloc(size);
+	count(size);
+	if (!ret && !size)
+		ret = malloc(1);
+	if (!ret)
+		die("Out of memory, malloc failed, %u bytes requested", size);
+	return ret;
+}
+
+void *xrealloc(void *ptr, size_t size)
+{
+	void *ret = realloc(ptr, size);
+	count(size);
+	if (!ret && !size)
+		ret = realloc(ptr, 1);
+	if (!ret)
+		die("Out of memory, realloc failed, %u bytes requested", size);
+	return ret;
+}
+
+void *xcalloc(size_t nmemb, size_t size)
+{
+	void *ret = calloc(nmemb, size);
+	count(size);
+	if (!ret && (!nmemb || !size))
+		ret = calloc(1, 1);
+	if (!ret)
+		die("Out of memory, calloc failed");
+	return ret;
+}
+
+void xfree(void *ptr)
+{
+	if ( !ptr )
+		return;
+	free(ptr);
+	++fcnt;
+}
+
diff --git a/git-compat-util.h b/git-compat-util.h
index f982b8e..ab4f855 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -73,35 +73,11 @@ extern void gitunsetenv(const char *);
 extern char *gitstrcasestr(const char *haystack, const char *needle);
 #endif
 
-static inline void *xmalloc(size_t size)
-{
-	void *ret = malloc(size);
-	if (!ret && !size)
-		ret = malloc(1);
-	if (!ret)
-		die("Out of memory, malloc failed");
-	return ret;
-}
-
-static inline void *xrealloc(void *ptr, size_t size)
-{
-	void *ret = realloc(ptr, size);
-	if (!ret && !size)
-		ret = realloc(ptr, 1);
-	if (!ret)
-		die("Out of memory, realloc failed");
-	return ret;
-}
-
-static inline void *xcalloc(size_t nmemb, size_t size)
-{
-	void *ret = calloc(nmemb, size);
-	if (!ret && (!nmemb || !size))
-		ret = calloc(1, 1);
-	if (!ret)
-		die("Out of memory, calloc failed");
-	return ret;
-}
+void *xmalloc(size_t size);
+void *xrealloc(void *ptr, size_t size);
+void *xcalloc(size_t nmemb, size_t size);
+void xfree(void *ptr);
+#define free(p) xfree(p)
 
 static inline ssize_t xread(int fd, void *buf, size_t len)
 {
diff --git a/prof-decode.sh b/prof-decode.sh
new file mode 100755
index 0000000..9c07e05
--- /dev/null
+++ b/prof-decode.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+if [ $# = 0 ]; then
+    set -- /tmp/git-alloc
+fi
+cat "$@" | perl -e '
+    while(<>) {
+        if (/(\S*) \d+ (\d+:\d+) (\d+)/) {
+		$c{$1}->{$2} += $3;
+		$c{$1}->{all} += $3
+	}
+        if (/(\S*) alloc-free = (\d+)/) { $d{$1} += $2 }
+    }
+    foreach $k (sort {$c{$b}->{all} <=> $c{$a}->{all}} grep {$c{$_}} keys %c) {
+	for ( sort {
+		if ( $a eq "all" ) { -1 }
+		elsif ( $b eq "all" ) { 1 }
+		else {
+		"$a $b" =~ /(\d+):\d+ (\d+):\d+/;
+		$1 <=> $2 }
+	    } grep { $c{$k}->{$_} } keys %{$c{$k}} ) {
+	    printf "%20s\t%20s\t%d\n", $k, $_, $c{$k}->{$_}
+	}
+	printf "%20s\t%d leaks\n\n", $k, $d{$k}
+    }
+'
