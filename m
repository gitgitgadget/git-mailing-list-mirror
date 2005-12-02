From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Add compat/setenv.c, use in git.c.
Date: Fri, 02 Dec 2005 15:08:28 -0800
Message-ID: <28409.1133564908@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Sat Dec 03 00:09:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiK13-0000Rw-3u
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 00:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVLBXIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 18:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVLBXIa
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 18:08:30 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:38038 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751104AbVLBXI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 18:08:29 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB2N8T6d028411
	for <git@vger.kernel.org>; Fri, 2 Dec 2005 15:08:29 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB2N8SiP028410
	for <git@vger.kernel.org>; Fri, 2 Dec 2005 15:08:28 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13133>

There is no setenv() in Solaris 5.8.  The trivial calls to
setenv() were replaced by putenv() in a much earlier patch,
but setenv() was used again in git.c.  This patch just adds
a compat/setenv.c.

The rule for building git$(X) also needs to include compat.
objects and compiler flags.  Those are now in makefile vars
COMPAT_OBJS and COMPAT_CFLAGS.

Signed-off-by: E. Jason Riedy <ejr@cs.berkeley.edu>

---

 Makefile        |   27 ++++++++++++++++++---------
 compat/setenv.c |   31 +++++++++++++++++++++++++++++++
 git.c           |    4 ++++
 3 files changed, 53 insertions(+), 9 deletions(-)
 create mode 100644 compat/setenv.c

applies-to: fc206c1ad60cfb6481cc51f6737ce728d1d8d83f
4bbc94c80d34b1ef859dd92254284198b0c3c2b6
diff --git a/Makefile b/Makefile
index 45db357..df3c6eb 100644
--- a/Makefile
+++ b/Makefile
@@ -21,6 +21,8 @@ all:
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
+# Define NO_SETENV if you don't have setenv in the C library.
+#
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
@@ -194,6 +196,7 @@ shellquote = '$(call shq,$(1))'
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
+uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
 
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
@@ -211,6 +214,9 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_LIBICONV = YesPlease
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
+	ifeq ($(uname_R),5.8)
+		NO_SETENV = YesPlease
+	endif
 	INSTALL = ginstall
 	TAR = gtar
 	ALL_CFLAGS += -D__EXTENSIONS__
@@ -314,12 +320,16 @@ ifdef NEEDS_NSL
 	SIMPLE_LIB += -lnsl
 endif
 ifdef NO_STRCASESTR
-	ALL_CFLAGS += -Dstrcasestr=gitstrcasestr -DNO_STRCASESTR=1
-	LIB_OBJS += compat/strcasestr.o
+	COMPAT_CFLAGS += -Dstrcasestr=gitstrcasestr -DNO_STRCASESTR=1
+	COMPAT_OBJS += compat/strcasestr.o
+endif
+ifdef NO_SETENV
+	COMPAT_CFLAGS += -Dsetenv=gitsetenv -DNO_SETENV=1
+	COMPAT_OBJS += compat/setenv.o
 endif
 ifdef NO_MMAP
-	ALL_CFLAGS += -Dmmap=gitfakemmap -Dmunmap=gitfakemunmap -DNO_MMAP
-	LIB_OBJS += compat/mmap.o
+	COMPAT_CFLAGS += -Dmmap=gitfakemmap -Dmunmap=gitfakemunmap -DNO_MMAP
+	COMPAT_OBJS += compat/mmap.o
 endif
 ifdef NO_IPV6
 	ALL_CFLAGS += -DNO_IPV6 -Dsockaddr_storage=sockaddr_in
@@ -343,8 +353,8 @@ endif
 endif
 endif
 
-ALL_CFLAGS += -DSHA1_HEADER=$(call shellquote,$(SHA1_HEADER))
-
+ALL_CFLAGS += -DSHA1_HEADER=$(call shellquote,$(SHA1_HEADER)) $(COMPAT_CFLAGS)
+LIB_OBJS += $(COMPAT_OBJS)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
@@ -353,10 +363,9 @@ all: $(ALL_PROGRAMS)
 all:
 	$(MAKE) -C templates
 
-# Only use $(CFLAGS). We don't need anything else.
-git$(X): git.c Makefile
+git$(X): git.c $(COMPAT_OBJS) Makefile
 	$(CC) -DGIT_EXEC_PATH='"$(bindir)"' -DGIT_VERSION='"$(GIT_VERSION)"' \
-		$(CFLAGS) $< -o $@
+		$(CFLAGS) $(COMPAT_CFLAGS) -o $@ $(filter %.c,$^) $(filter %.o,$^)
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	rm -f $@
diff --git a/compat/setenv.c b/compat/setenv.c
new file mode 100644
index 0000000..94acd2d
--- /dev/null
+++ b/compat/setenv.c
@@ -0,0 +1,31 @@
+#include <stdlib.h>
+#include <string.h>
+
+int gitsetenv(const char *name, const char *value, int replace)
+{
+	int out;
+	size_t namelen, valuelen;
+	char *envstr;
+
+	if (!name || !value) return -1;
+	if (!replace) {
+		char *oldval = NULL;
+		oldval = getenv(name);
+		if (oldval) return 0;
+	}
+
+	namelen = strlen(name);
+	valuelen = strlen(value);
+	envstr = malloc((namelen + valuelen + 2) * sizeof(char));
+	if (!envstr) return -1;
+
+	memcpy(envstr, name, namelen);
+	envstr[namelen] = '=';
+	memcpy(envstr + namelen + 1, value, valuelen);
+	envstr[namelen + valuelen + 1] = 0;
+
+	out = putenv(envstr);
+
+	free(envstr);
+	return out;
+}
diff --git a/git.c b/git.c
index 878c359..619f25a 100644
--- a/git.c
+++ b/git.c
@@ -13,6 +13,10 @@
 # define PATH_MAX 4096
 #endif
 
+#ifdef NO_SETENV
+extern int gitsetenv(char *name, char *value, int overwrite);
+#endif
+
 static const char git_usage[] =
 	"Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
 
---
0.99.9h
