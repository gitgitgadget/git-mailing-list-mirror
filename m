From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
Date: Wed, 15 Aug 2012 18:50:55 +0200
Message-ID: <20120815165054.GA43523@book.hvoigt.net>
References: <20120811070030.GA83665@book.hvoigt.net> <7vd32whgvl.fsf@alter.siamese.dyndns.org> <20120813170221.GB6418@book.hvoigt.net> <7vmx1yel9d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 18:51:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1goO-0006hE-0W
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 18:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab2HOQvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 12:51:06 -0400
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:57551 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652Ab2HOQvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 12:51:04 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1T1go4-0001OH-1y; Wed, 15 Aug 2012 18:50:56 +0200
Content-Disposition: inline
In-Reply-To: <7vmx1yel9d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203472>

Hi Junio,

On Mon, Aug 13, 2012 at 10:48:14AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > What do you think?
> 
> Does having the "stat()" help on Windows in any way?  Does it ever
> return an executable bit by itself?

No, AFAIK it does not return anything about executability. But I think
the stat is still necessary to verify that the file exists and is a
regular file.

Here is a draft of a patch I would follow up with:

Subject: [PATCH RFC] help: extract platform dependent part of is_executable in
 extra module

To remove various ifdefs required for the special handling of
executables on windows we create a new module 'executable' in compat
which allows a user to correctly fill the S_IXUSR flag of struct stat on
Windows.

Since this is valid for all variants of windows (mingw, msvc, cygwin) we
create a new module to avoid code duplication. compat/msvc.h includes
mingw.h so we do not add an extra include there. By default we define
correct_executeable_stat() to a no op on all other platforms. This is
guarded by a NO_EXECUTABLE_STAT which when defined by a compat header
requires and implementation of this function.

NOTE: I did not test this. I first would like to discuss whether the
overall structure this approach is taking is ok.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Makefile                  |  8 +++++---
 compat/cygwin.h           |  2 ++
 compat/mingw.h            |  2 ++
 compat/win32/executable.c | 33 +++++++++++++++++++++++++++++++++
 compat/win32/executable.h |  9 +++++++++
 git-compat-util.h         |  4 ++++
 help.c                    | 30 ++----------------------------
 7 files changed, 57 insertions(+), 31 deletions(-)
 create mode 100644 compat/win32/executable.c
 create mode 100644 compat/win32/executable.h

diff --git a/Makefile b/Makefile
index 6b0c961..cea3559 100644
--- a/Makefile
+++ b/Makefile
@@ -1073,7 +1073,7 @@ ifeq ($(uname_O),Cygwin)
 	# Try commenting this out if you suspect MMAP is more efficient
 	NO_MMAP = YesPlease
 	X = .exe
-	COMPAT_OBJS += compat/cygwin.o
+	COMPAT_OBJS += compat/cygwin.o compat/win32/executable.o
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
 endif
@@ -1257,7 +1257,8 @@ ifeq ($(uname_S),Windows)
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/poll.o compat/win32/dirent.o
+		compat/win32/poll.o compat/win32/dirent.o \
+		compat/win32/executable.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
@@ -1347,7 +1348,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/poll.o compat/win32/dirent.o
+		compat/win32/poll.o compat/win32/dirent.o \
+		compat/win32/executable.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
diff --git a/compat/cygwin.h b/compat/cygwin.h
index a3229f5..e3bbd4d 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -1,6 +1,8 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
+#include "win32/executable.h"
+
 typedef int (*stat_fn_t)(const char*, struct stat*);
 extern stat_fn_t cygwin_stat_fn;
 extern stat_fn_t cygwin_lstat_fn;
diff --git a/compat/mingw.h b/compat/mingw.h
index 61a6521..73c4f3d 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,6 +1,8 @@
 #include <winsock2.h>
 #include <ws2tcpip.h>
 
+#include "win32/executable.h"
+
 /*
  * things that are not available in header files
  */
diff --git a/compat/win32/executable.c b/compat/win32/executable.c
new file mode 100644
index 0000000..326ddb1
--- /dev/null
+++ b/compat/win32/executable.c
@@ -0,0 +1,33 @@
+#include "executeable.h"
+
+void correct_executable_stat(const char *filename, struct stat *st)
+{
+	char buf[3] = { 0 };
+	int n, fd;
+
+	/* On Windows we cannot use the executable bit. The executable
+	 * state is determined by extension only. We do this first
+	 * because with virus scanners opening an executeable for
+	 * reading is potentially expensive.
+	 */
+	if (has_extension(name, ".exe"))
+		st->st_mode |= S_IXUSR;
+
+	if (st.st_mode & S_IXUSR)
+		return;
+
+	/* now that we know it does not have an executable extension,
+	   peek into the file instead */
+	fd = open(name, O_RDONLY);
+	if (fd < 0)
+		return;
+
+	n = read(fd, buf, 2);
+	if (n == 2) {
+		/* look for a she-bang */
+		if (!strcmp(buf, "#!"))
+			st.st_mode |= S_IXUSR;
+	}
+
+	close(fd);
+}
diff --git a/compat/win32/executable.h b/compat/win32/executable.h
new file mode 100644
index 0000000..e4f0c5c
--- /dev/null
+++ b/compat/win32/executable.h
@@ -0,0 +1,9 @@
+#ifndef COMPAT_WIN32_EXECUTEABLE
+#define COMPAT_WIN32_EXECUTEABLE
+
+#include "../../git-compat-util.h"
+
+#define NO_EXECUTABLE_STAT
+extern void correct_executable_stat(const char *filename, struct stat *st);
+
+#endif /* COMPAT_WIN32_EXECUTEABLE */
diff --git a/git-compat-util.h b/git-compat-util.h
index 35b095e..1b723af 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -607,4 +607,8 @@ int remove_or_warn(unsigned int mode, const char *path);
 /* Get the passwd entry for the UID of the current process. */
 struct passwd *xgetpwuid_self(void);
 
+#ifndef NO_EXECUTABLE_STAT
+#define correct_executable_stat(name, stat) ;
+#endif
+
 #endif
diff --git a/help.c b/help.c
index ebc2c42..d9fae3c 100644
--- a/help.c
+++ b/help.c
@@ -106,34 +106,8 @@ static int is_executable(const char *name)
 	    !S_ISREG(st.st_mode))
 		return 0;
 
-#if defined(WIN32) || defined(__CYGWIN__)
-	/* On Windows we cannot use the executable bit. The executable
-	 * state is determined by extension only. We do this first
-	 * because with virus scanners opening an executeable for
-	 * reading is potentially expensive.
-	 */
-	if (has_extension(name, ".exe"))
-		return S_IXUSR;
-
-#if defined(__CYGWIN__)
-if ((st.st_mode & S_IXUSR) == 0)
-#endif
-{	/* now that we know it does not have an executable extension,
-	   peek into the file instead */
-	char buf[3] = { 0 };
-	int n;
-	int fd = open(name, O_RDONLY);
-	st.st_mode &= ~S_IXUSR;
-	if (fd >= 0) {
-		n = read(fd, buf, 2);
-		if (n == 2)
-			/* look for a she-bang */
-			if (!strcmp(buf, "#!"))
-				st.st_mode |= S_IXUSR;
-		close(fd);
-	}
-}
-#endif
+	correct_executable_stat(name, &st);
+
 	return st.st_mode & S_IXUSR;
 }
 
-- 
1.7.12.rc2.11.g5d52328
