From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3.5/3] add memmem()
Date: Fri, 07 Sep 2007 00:32:54 +0200
Message-ID: <46E08016.9030604@lsrfire.ath.cx>
References: <46DC4D45.4030208@lsrfire.ath.cx>	<7vtzqb8fw2.fsf@gitster.siamese.dyndns.org> <46DCF0EF.9020604@op5.se>	<Pine.LNX.4.64.0709041139140.28586@racer.site>	<46DDE69C.1080908@lsrfire.ath.cx> <7vzm02klip.fsf@gitster.siamese.dyndns.org> <46E028B9.2090908@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:34:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITPvL-00037L-Oh
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 00:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbXIFWdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 18:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755980AbXIFWdD
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 18:33:03 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:44696
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754448AbXIFWdB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 18:33:01 -0400
Received: from [10.0.1.201] (p508ED793.dip.t-dialin.net [80.142.215.147])
	by neapel230.server4you.de (Postfix) with ESMTP id ABCC0873B5;
	Fri,  7 Sep 2007 00:32:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46E028B9.2090908@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57937>

memmem() is a nice GNU extension for searching a length limited string
in another one.

This compat version is based on the version found in glibc 2.2 (GPL 2);
I only removed the optimization of checking the first char by hand, and
generally tried to keep the code simple.  We can add it back if memcmp
shows up high in a profile, but for now I prefer to keep it (almost
trivially) simple.

Since I don't really know which platforms beside those with a glibc
have their own memmem(), I used a heuristic: if NO_STRCASESTR is set,
then NO_MEMMEM is set, too.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile          |   11 +++++++++++
 compat/memmem.c   |   29 +++++++++++++++++++++++++++++
 git-compat-util.h |    6 ++++++
 3 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 compat/memmem.c

diff --git a/Makefile b/Makefile
index 51af531..bae073f 100644
--- a/Makefile
+++ b/Makefile
@@ -28,6 +28,8 @@ all::
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
+# Define NO_MEMMEM if you don't have memmem.
+#
 # Define NO_STRLCPY if you don't have strlcpy.
 #
 # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
@@ -402,6 +404,7 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_NSL = YesPlease
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
 	NO_HSTRERROR = YesPlease
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
@@ -424,6 +427,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_D_TYPE_IN_DIRENT = YesPlease
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
@@ -442,6 +446,7 @@ ifeq ($(uname_S),FreeBSD)
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
@@ -456,6 +461,7 @@ ifeq ($(uname_S),NetBSD)
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
+	NO_MEMMEM = YesPlease
 	NO_STRLCPY = YesPlease
 	NEEDS_LIBICONV=YesPlease
 endif
@@ -467,6 +473,7 @@ ifeq ($(uname_S),IRIX64)
 	NO_IPV6=YesPlease
 	NO_SETENV=YesPlease
 	NO_STRCASESTR=YesPlease
+	NO_MEMMEM = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_SOCKADDR_STORAGE=YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
@@ -661,6 +668,10 @@ ifdef NO_HSTRERROR
 	COMPAT_CFLAGS += -DNO_HSTRERROR
 	COMPAT_OBJS += compat/hstrerror.o
 endif
+ifdef NO_MEMMEM
+	COMPAT_CFLAGS += -DNO_MEMMEM
+	COMPAT_OBJS += compat/memmem.o
+endif
 
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
diff --git a/compat/memmem.c b/compat/memmem.c
new file mode 100644
index 0000000..cd0d877
--- /dev/null
+++ b/compat/memmem.c
@@ -0,0 +1,29 @@
+#include "../git-compat-util.h"
+
+void *gitmemmem(const void *haystack, size_t haystack_len,
+                const void *needle, size_t needle_len)
+{
+	const char *begin = haystack;
+	const char *last_possible = begin + haystack_len - needle_len;
+
+	/*
+	 * The first occurrence of the empty string is deemed to occur at
+	 * the beginning of the string.
+	 */
+	if (needle_len == 0)
+		return (void *)begin;
+
+	/*
+	 * Sanity check, otherwise the loop might search through the whole
+	 * memory.
+	 */
+	if (haystack_len < needle_len)
+		return NULL;
+
+	for (; begin <= last_possible; begin++) {
+		if (!memcmp(begin, needle, needle_len))
+			return (void *)begin;
+	}
+
+	return NULL;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index ca0a597..1bfbdeb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -172,6 +172,12 @@ extern uintmax_t gitstrtoumax(const char *, char **, int);
 extern const char *githstrerror(int herror);
 #endif
 
+#ifdef NO_MEMMEM
+#define memmem gitmemmem
+void *gitmemmem(const void *haystack, size_t haystacklen,
+                const void *needle, size_t needlelen);
+#endif
+
 extern void release_pack_memory(size_t, int);
 
 static inline char* xstrdup(const char *str)
-- 
1.5.3
