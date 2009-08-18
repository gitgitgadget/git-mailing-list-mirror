From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 14:58:55 +0200
Message-ID: <1250600335-8642-1-git-send-email-mstormo@gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Aug 18 14:59:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdOHP-000066-R5
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 14:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758881AbZHRM7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 08:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758866AbZHRM7B
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 08:59:01 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:33870 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbZHRM7A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 08:59:00 -0400
Received: by bwz22 with SMTP id 22so2994611bwz.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IIdH4ORgT5WFp4L94qzEWahHDpyTwDdnL4niXpDD4U4=;
        b=am4yefAiwAGFx/qkYLEgIWI0ocX9A4BVsEMSRbBjS3IqMFH0zazOGbUKmbDqvyBGnt
         OSCO2fUgmv3CZvekgN+FJmb2Juyg3HtyQpCzxanAZ0+8vlM6VH3lIWlHo+Lf5bs5dpQv
         JgxYaTYXwqZ5P11Nu8O8ydQ7kAx26yf0GWwZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=d6zMMkbVeTgVYJwOCWTUlTgAsGYdDCu3Hkr9OVIS8yOSyQOCu9WQG3Li3i8PdOkY6a
         +Pu4MLT9T98/aU1qFwNu1YL1oen4gRmKcEUEk8XxRfVs1Vi2Rdgo4ADT65aewYBT+M4i
         q96Tj4393KrBygUfJdhjwcBTywoUAwZxEj/z0=
Received: by 10.204.34.144 with SMTP id l16mr3748942bkd.60.1250600340457;
        Tue, 18 Aug 2009 05:59:00 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 2sm6637675fks.33.2009.08.18.05.58.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 05:59:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126390>

From: Marius Storm-Olsen <mstormo@gmail.com>

By using GNU Make we can also compile with the MSVC toolchain.
This is a rudementary patch, only meant as an RFC for now!!

!! DO NOT COMMIT THIS UPSTREAM !!
---
 So, instead of rely on these vcproj files which *will* go stale, we can
 simply use the same Makefile system which everyone else is using. :)
 After all, we're just compiling with a different compiler. The end result
 will still rely on the *msysGit environment* to function, so we already
 require it. Thus, GNU Make is present, and we can use it.

 This implementation is a quick hack to make it compile (hence the RFC
 subject), so please don't even consider basing anything ontop of it ;)

 But, do point out all the do's and don'ts, and I'll try to polish it up
 to something which we can add to Frank's series..
 

 Makefile      |   97 +++++++++++++++++++++++++++++++++++++++++++++++---------
 compat/msvc.h |   77 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index daf4296..2e14976 100644
--- a/Makefile
+++ b/Makefile
@@ -214,9 +214,13 @@ uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
 
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
+ARFLAGS = rcs\ # whitespace intentional
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
+COMPFLAG = -c
+COBJFLAG = -o\ # whitespace intended
+LOBJFLAG = -o\ # whitespace intended
 
 # Among the variables below, these:
 #   gitexecdir
@@ -874,6 +878,58 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
 	COMPAT_OBJS += compat/cygwin.o
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 endif
+ifneq (,$(findstring Microsoft Visual Studio, $(INCLUDE)))
+	pathsep = ;
+	MOZILLA_SHA1 = 1
+	NO_PREAD = YesPlease
+	NO_OPENSSL = YesPlease
+	NO_LIBGEN_H = YesPlease
+	NO_SYMLINK_HEAD = YesPlease
+	NO_IPV6 = YesPlease
+	NO_SETENV = YesPlease
+	NO_UNSETENV = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_MEMMEM = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	OLD_ICONV = YesPlease
+	NO_C99_FORMAT = YesPlease
+	NO_STRTOUMAX = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
+	SNPRINTF_RETURNS_BOGUS = YesPlease
+	NO_SVN_TESTS = YesPlease
+	NO_PERL_MAKEMAKER = YesPlease
+	RUNTIME_PREFIX = YesPlease
+	NO_POSIX_ONLY_PROGRAMS = YesPlease
+	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	NO_NSEC = YesPlease
+	USE_WIN32_MMAP = YesPlease
+	UNRELIABLE_FSTAT = UnfortunatelyYes
+	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
+	NO_REGEX = YesPlease
+
+	NO_CURL = YesPlease
+	NO_PTHREADS = YesPlease
+        
+	CC = cl 
+	COBJFLAG = -Fo
+	LOBJFLAG = -OUT:
+	CFLAGS =
+	BASIC_CFLAGS += -nologo -MT -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch
+	COMPAT_OBJS += compat/mingw.o compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
+	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
+
+	LINK = link
+	BASIC_LDFLAGS += -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib ../zlib/projects/vc9/Win32_LIB_Release/zlib.lib
+	NO_CFLAGS_TO_LINKER = YesPlease
+	EXTLIBS = 
+	AR = lib
+	ARFLAGS = -OUT:
+
+	X = .exe
+else
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -922,6 +978,7 @@ else
 	NO_PTHREADS = YesPlease
 endif
 endif
+endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 	NO_MKSTEMPS = YesPlease
@@ -1298,6 +1355,14 @@ LIB_OBJS += $(COMPAT_OBJS)
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
+ifndef LINK
+LINK = $(CC)
+endif
+
+ifndef NO_CFLAGS_TO_LINKER
+LINKER_CFLAGS += $(ALL_CFLAGS)
+endif
+
 export TAR INSTALL DESTDIR SHELL_PATH
 
 
@@ -1331,14 +1396,14 @@ strip: $(PROGRAMS) git$X
 git.o: git.c common-cmds.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
-		$(ALL_CFLAGS) -c $(filter %.c,$^)
+		$(ALL_CFLAGS) $(COMPFLAG) $(COBJFLAG)git.o $(filter %.c,$^)
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
+	$(QUIET_LINK)$(LINK) $(LINKER_CFLAGS) $(LOBJFLAG)$@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 builtin-help.o: builtin-help.c common-cmds.h GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
+	$(QUIET_CC)$(CC) $(COBJFLAG)$*.o $(COMPFLAG) $(ALL_CFLAGS) \
 		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 		'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 		'-DGIT_INFO_PATH="$(infodir_SQ)"' $<
@@ -1450,44 +1515,44 @@ git.o git.spec \
 	: GIT-VERSION-FILE
 
 %.o: %.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) $(COBJFLAG)$*.o $(COMPFLAG) $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
 %.o: %.S
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) $(COBJFLAG)$*.o $(COMPFLAG) $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
+	$(QUIET_CC)$(CC) $(COBJFLAG)$*.o $(COMPFLAG) $(ALL_CFLAGS) \
 		'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 		'-DBINDIR="$(bindir_relative_SQ)"' \
 		'-DPREFIX="$(prefix_SQ)"' \
 		$<
 
 builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
+	$(QUIET_CC)$(CC) $(COBJFLAG)$*.o $(COMPFLAG) $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
 
 config.o: config.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $<
+	$(QUIET_CC)$(CC) $(COBJFLAG)$*.o $(COMPFLAG) $(ALL_CFLAGS) -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $<
 
 http.o: http.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
+	$(QUIET_CC)$(CC) $(COBJFLAG)$*.o $(COMPFLAG) $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
 
 ifdef NO_EXPAT
 http-walker.o: http-walker.c http.h GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
+	$(QUIET_CC)$(CC) $(COBJFLAG)$*.o $(COMPFLAG) $(ALL_CFLAGS) -DNO_EXPAT $<
 endif
 
 git-%$X: %.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(LINK) $(LINKER_CFLAGS) $(LOBJFLAG)$@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 git-imap-send$X: imap-send.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LINK) $(LINKER_CFLAGS) $(LOBJFLAG)$@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
 http.o http-walker.o http-push.o transport.o: http.h
 
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LINK) $(LINKER_CFLAGS) $(LOBJFLAG)$@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
@@ -1495,7 +1560,7 @@ $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
 
 $(LIB_FILE): $(LIB_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS)$@ $(LIB_OBJS)
 
 XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
@@ -1503,7 +1568,7 @@ $(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS)$@ $(XDIFF_OBJS)
 
 
 doc:
@@ -1605,7 +1670,7 @@ test-parse-options.o: parse-options.h
 .PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 
 test-%$X: test-%.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(LINK) $(LINKER_CFLAGS) $(LOBJFLAG)$@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
 	./test-sha1.sh
diff --git a/compat/msvc.h b/compat/msvc.h
index 6071565..a9d5f7f 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -10,50 +10,120 @@
 
 /*Configuration*/
 
+#ifndef NO_PREAD
 #define NO_PREAD
+#endif
+#ifndef NO_OPENSSL
 #define NO_OPENSSL
+#endif
+#ifndef NO_LIBGEN_H
 #define NO_LIBGEN_H
+#endif
+#ifndef NO_SYMLINK_HEAD
 #define NO_SYMLINK_HEAD
+#endif
+#ifndef NO_IPV6
 #define NO_IPV6
+#endif
+#ifndef NO_SETENV
 #define NO_SETENV
+#endif
+#ifndef NO_UNSETENV
 #define NO_UNSETENV
+#endif
+#ifndef NO_STRCASESTR
 #define NO_STRCASESTR
+#endif
+#ifndef NO_STRLCPY
 #define NO_STRLCPY
+#endif
+#ifndef NO_MEMMEM
 #define NO_MEMMEM
+#endif
+#ifndef NO_C99_FORMAT
 #define NO_C99_FORMAT
+#endif
+#ifndef NO_STRTOUMAX
 #define NO_STRTOUMAX
+#endif
+#ifndef NO_MKDTEMP
 #define NO_MKDTEMP
+#endif
+#ifndef NO_MKSTEMPS
 #define NO_MKSTEMPS
+#endif
 
+
+#ifndef RUNTIME_PREFIX
 #define RUNTIME_PREFIX
+#endif
+#ifndef NO_ST_BLOCKS_IN_STRUCT_STAT
 #define NO_ST_BLOCKS_IN_STRUCT_STAT
+#endif
+#ifndef NO_NSEC
 #define NO_NSEC
+#endif
+#ifndef USE_WIN32_MMAP
 #define USE_WIN32_MMAP
+#endif
+#ifndef USE_NED_ALLOCATOR
 #define USE_NED_ALLOCATOR
+#endif
+
 
+#ifndef NO_REGEX
 #define NO_REGEX
+#endif
 
+
+#ifndef NO_SYS_SELECT_H
 #define NO_SYS_SELECT_H
+#endif
+#ifndef NO_PTHEADS
 #define NO_PTHEADS
+#endif
+#ifndef HAVE_STRING_H
 #define HAVE_STRING_H 1
+#endif
+#ifndef STDC_HEADERS
 #define STDC_HEADERS
+#endif
+#ifndef NO_ICONV
 #define NO_ICONV
+#endif
+
 
 #define inline __inline
 #define __inline__ __inline
 
+#ifndef SNPRINTF_RETURNS_BOGUS
 #define SNPRINTF_RETURNS_BOGUS
+#endif
 
+
+#ifndef SHA1_HEADER
 #define SHA1_HEADER "mozilla-sha1\\sha1.h"
+#endif
 
+#ifndef ETC_GITCONFIG
 #define ETC_GITCONFIG "%HOME%"
+#endif
+
 
+#ifndef NO_PTHREADS
 #define NO_PTHREADS
+#endif
+#ifndef NO_CURL
 #define NO_CURL
+#endif
 
 
+#ifndef NO_STRTOUMAX
 #define NO_STRTOUMAX
+#endif
+#ifndef REGEX_MALLOC
 #define REGEX_MALLOC
+#endif
 
 
 #define GIT_EXEC_PATH "bin"
@@ -65,9 +135,16 @@
 #define GIT_HTML_PATH "html"
 #define DEFAULT_GIT_TEMPLATE_DIR "templates"
 
+#ifndef NO_STRLCPY
 #define NO_STRLCPY
+#endif
+#ifndef NO_UNSETENV
 #define NO_UNSETENV
+#endif
+#ifndef NO_SETENV
 #define NO_SETENV
+#endif
+
 
 #define strdup _strdup
 #define read _read
-- 
1.6
