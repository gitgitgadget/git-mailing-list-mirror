From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: [PATCH] Embed an application manifest on MinGW
Date: Sat, 28 May 2011 16:58:27 -0300
Message-ID: <1306612707-29748-1-git-send-email-cesarb@cesarb.net>
Cc: git@vger.kernel.org, Cesar Eduardo Barros <cesarb@cesarb.net>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sat May 28 22:06:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQPly-0002VQ-5a
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 22:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab1E1UGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 16:06:04 -0400
Received: from smtp-03.mandic.com.br ([200.225.81.143]:41838 "EHLO
	smtp-03.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab1E1UGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 16:06:02 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 May 2011 16:06:01 EDT
Received: (qmail 29320 invoked from network); 28 May 2011 19:59:19 -0000
Received: from unknown (HELO localhost.localdomain) (zcncxNmDysja2tXBptWToZWJlF6Wp6IuYnI=@[200.157.204.20])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-03.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <msysgit@googlegroups.com>; 28 May 2011 19:59:19 -0000
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174673>

On Windows Vista, not having an application manifest with a
requestedExecutionLevel can cause several kinds of confusing behavior.

The first and more obvious is Installer Detection, where sometimes
Windows decides (by looking at things like the file name and even
sequences of bytes within the executable) that an executable is an
installer and should run elevated (causing the well-known popup dialog
to appear). On git, this happens for executables with names containing
"patch" or "update".

The second and more confusing is File Virtualization. With it, writes to
some files which should fail are instead redirected to somewhere else,
and reads to files might return different contents if a previous write
was redirected. Even more confusing, not all writes are redirected; I
recall reading somewhere that for instance writes to .exe files will
fail instead of redirecting.

Needless to say, git wants none of that. Not only that, but File
Virtualization has been blamed for dramatic slowdowns in git (see for
instance http://code.google.com/p/msysgit/issues/detail?id=320).

There are two ways to turn off these annoyances. Either you embed an
application manifest within all your executables, or you add an external
manifest (a file with the same name followed by .manifest) to all your
executables. Since for git some executables are copied (or hardlinked)
with several names, it is simpler and more robust to embed an internal
manifest.

A recent enough MSVC compiler should already embed a working internal
manifest, but for mingw you have to do so by hand.

Very lightly tested on Wine, where like on Windows XP it should not make
any difference.

References:
  - New UAC Technologies for Windows Vista
    http://msdn.microsoft.com/en-us/library/bb756960.aspx
  - Create and Embed an Application Manifest (UAC)
    http://msdn.microsoft.com/en-us/library/bb756929.aspx

Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 Makefile                  |   29 +++++++++++++++++++++--------
 compat/win32/git.manifest |   11 +++++++++++
 compat/win32/resource.rc  |    1 +
 3 files changed, 33 insertions(+), 8 deletions(-)
 create mode 100644 compat/win32/git.manifest
 create mode 100644 compat/win32/resource.rc

diff --git a/Makefile b/Makefile
index dec4a7f..3dbcdfb 100644
--- a/Makefile
+++ b/Makefile
@@ -323,6 +323,7 @@ XGETTEXT = xgettext
 PTHREAD_LIBS = -lpthread
 PTHREAD_CFLAGS =
 GCOV = gcov
+WINDRES = windres
 
 export TCL_PATH TCLTK_PATH
 
@@ -343,6 +344,7 @@ BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
 COMPAT_OBJS =
+RESOURCE_OBJS =
 EXTRA_CPPFLAGS =
 LIB_H =
 LIB_OBJS =
@@ -1174,6 +1176,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
+	APPLICATION_MANIFEST = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
@@ -1551,6 +1554,11 @@ ifdef USE_NED_ALLOCATOR
        COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
 endif
 
+ifdef APPLICATION_MANIFEST
+	# Cannot be in LIB_OBJS because it must always be linked in
+	RESOURCE_OBJS += compat/win32/resource.o
+endif
+
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	export GIT_TEST_CMP_USE_COPIED_CONTEXT
 endif
@@ -1586,6 +1594,7 @@ ifndef V
 	QUIET_LNCP     = @echo '   ' LN/CP $@;
 	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
+	QUIET_WINDRES  = @echo '   ' RC $@;
 	QUIET_SP       = @echo '   ' SP $<;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
@@ -1685,9 +1694,9 @@ git.o: common-cmds.h
 git.sp git.s git.o: EXTRA_CPPFLAGS = -DGIT_VERSION='"$(GIT_VERSION)"' \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"'
 
-git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o $(BUILTIN_OBJS) $(RESOURCE_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
-		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
+		$(BUILTIN_OBJS) $(RESOURCE_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 help.sp help.o: common-cmds.h
 
@@ -2011,17 +2020,17 @@ compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 	-DNDEBUG -DOVERRIDE_STRDUP -DREPLACE_SYSTEM_ALLOCATOR
 endif
 
-git-%$X: %.o $(GITLIBS)
+git-%$X: %.o $(RESOURCE_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o $(GITLIBS)
+git-imap-send$X: imap-send.o $(RESOURCE_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
-git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
+git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(RESOURCE_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
-git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
+git-http-push$X: revision.o http.o http-push.o $(RESOURCE_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
@@ -2031,10 +2040,14 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
+$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(RESOURCE_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+%.o: %.rc
+	$(QUIET_WINDRES)$(WINDRES) $< $@
+compat/win32/resource.o: compat/win32/git.manifest
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
 
@@ -2167,7 +2180,7 @@ test-svn-fe$X: vcs-svn/lib.a
 
 .PRECIOUS: $(TEST_OBJS)
 
-test-%$X: test-%.o $(GITLIBS)
+test-%$X: test-%.o $(RESOURCE_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
diff --git a/compat/win32/git.manifest b/compat/win32/git.manifest
new file mode 100644
index 0000000..a82605c
--- /dev/null
+++ b/compat/win32/git.manifest
@@ -0,0 +1,11 @@
+<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
+<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
+	<assemblyIdentity type="win32" name="Git" processorArchitecture="x86" version="0.0.0.0" />
+	<trustInfo xmlns="urn:schemas-microsoft-com:asm.v2">
+		<security>
+			<requestedPrivileges>
+				<requestedExecutionLevel level="asInvoker" uiAccess="false" />
+			</requestedPrivileges>
+		</security>
+	</trustInfo>
+</assembly>
diff --git a/compat/win32/resource.rc b/compat/win32/resource.rc
new file mode 100644
index 0000000..c2bf4a6
--- /dev/null
+++ b/compat/win32/resource.rc
@@ -0,0 +1 @@
+1 24 "git.manifest"
-- 
1.7.4.4
