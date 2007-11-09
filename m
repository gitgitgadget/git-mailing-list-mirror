From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] Add strchrnul()
Date: Fri, 09 Nov 2007 01:49:36 +0100
Message-ID: <4733AEA0.1060602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:01:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIFO-00047A-H2
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760783AbXKIA7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 19:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759500AbXKIA7t
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 19:59:49 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:52600
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756903AbXKIA7s (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 19:59:48 -0500
Received: from [10.0.1.201] (p57B7C9DB.dip.t-dialin.net [87.183.201.219])
	by neapel230.server4you.de (Postfix) with ESMTP id 6CBC9873BB;
	Fri,  9 Nov 2007 01:49:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64092>

As suggested by Pierre Habouzit, add strchrnul().  It's a useful GNU
extension and can simplify string parser code.  There are several
places in git that can be converted to strchrnul(); as a trivial
example, this patch introduces its usage to builtin-fetch--tool.c.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 Makefile              |   13 +++++++++++++
 builtin-fetch--tool.c |    8 ++------
 compat/strchrnul.c    |    8 ++++++++
 git-compat-util.h     |    5 +++++
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 0d5590f..578c999 100644
--- a/Makefile
+++ b/Makefile
@@ -30,6 +30,8 @@ all::
 #
 # Define NO_MEMMEM if you don't have memmem.
 #
+# Define NO_STRCHRNUL if you don't have strchrnul.
+#
 # Define NO_STRLCPY if you don't have strlcpy.
 #
 # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
@@ -406,6 +408,7 @@ ifeq ($(uname_S),Darwin)
 	OLD_ICONV = UnfortunatelyYes
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
+	NO_STRCHRNUL = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -413,6 +416,7 @@ ifeq ($(uname_S),SunOS)
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
+	NO_STRCHRNUL = YesPlease
 	NO_HSTRERROR = YesPlease
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
@@ -438,6 +442,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
+	NO_STRCHRNUL = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
@@ -452,12 +457,14 @@ endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
 	NO_MEMMEM = YesPlease
+	NO_STRCHRNUL = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
+	NO_STRCHRNUL = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
@@ -473,6 +480,7 @@ endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
+	NO_STRCHRNUL = YesPlease
 	NO_STRLCPY = YesPlease
 	NEEDS_LIBICONV=YesPlease
 endif
@@ -485,6 +493,7 @@ ifeq ($(uname_S),IRIX64)
 	NO_SETENV=YesPlease
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
+	NO_STRCHRNUL = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_SOCKADDR_STORAGE=YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
@@ -695,6 +704,10 @@ ifdef NO_MEMMEM
 	COMPAT_CFLAGS += -DNO_MEMMEM
 	COMPAT_OBJS += compat/memmem.o
 endif
+ifdef NO_STRCHRNUL
+	COMPAT_CFLAGS += -DNO_STRCHRNUL
+	COMPAT_OBJS += compat/strchrnul.o
+endif
 
 ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 6a78517..ed60847 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -435,9 +435,7 @@ static int pick_rref(int sha1_only, const char *rref, const char *ls_remote_resu
 				cp++;
 			if (!*cp)
 				break;
-			np = strchr(cp, '\n');
-			if (!np)
-				np = cp + strlen(cp);
+			np = strchrnul(cp, '\n');
 			if (pass) {
 				lrr_list[i].line = cp;
 				lrr_list[i].name = cp + 41;
@@ -461,9 +459,7 @@ static int pick_rref(int sha1_only, const char *rref, const char *ls_remote_resu
 			rref++;
 		if (!*rref)
 			break;
-		next = strchr(rref, '\n');
-		if (!next)
-			next = rref + strlen(rref);
+		next = strchrnul(rref, '\n');
 		rreflen = next - rref;
 
 		for (i = 0; i < lrr_count; i++) {
diff --git a/compat/strchrnul.c b/compat/strchrnul.c
new file mode 100644
index 0000000..51839fe
--- /dev/null
+++ b/compat/strchrnul.c
@@ -0,0 +1,8 @@
+#include "../git-compat-util.h"
+
+char *gitstrchrnul(const char *s, int c)
+{
+	while (*s && *s != c)
+		s++;
+	return (char *)s;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 7b29d1b..e72654b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -183,6 +183,11 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
                 const void *needle, size_t needlelen);
 #endif
 
+#ifdef NO_STRCHRNUL
+#define strchrnul gitstrchrnul
+char *gitstrchrnul(const char *s, int c);
+#endif
+
 extern void release_pack_memory(size_t, int);
 
 static inline char* xstrdup(const char *str)
