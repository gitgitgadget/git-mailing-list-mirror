From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
Date: Wed, 15 Aug 2012 19:02:31 -0700
Message-ID: <7vwr0z387c.fsf@alter.siamese.dyndns.org>
References: <20120811070030.GA83665@book.hvoigt.net>
 <7vd32whgvl.fsf@alter.siamese.dyndns.org>
 <20120813170221.GB6418@book.hvoigt.net>
 <7vmx1yel9d.fsf@alter.siamese.dyndns.org>
 <20120815165054.GA43523@book.hvoigt.net>
 <7v7gt06nyk.fsf@alter.siamese.dyndns.org>
 <20120815222911.GA44080@book.hvoigt.net>
 <7va9xv4uir.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 04:03:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1pQh-0004Vk-Th
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 04:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab2HPCCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 22:02:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab2HPCCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 22:02:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60BFF975B;
	Wed, 15 Aug 2012 22:02:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yFs0JslAGt4Dyk/A54RmDhreTv0=; b=BqFke8
	67/So+dPhJVxJy382PWo2dx2+DlXRu/JJSbot/RL+4dMzQSI4jtttrW9BFimd9Fh
	4GmrupIxrnB4v5SgX9sBQdlzDjIiJ18j7soKA7t4MyC8WXlYRXagEwfNB5y4g5F5
	oKGD47u8PYGEwVpRYGfQqJDWNkYgVjuUxdwUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gYRqe1PnGsuijHWe2OZb2ZdaXHigfF1e
	SJl+Umfgk57xxeQuLM2lWTI4EGssL2a8qjCYEJpfQQ8A8nNYngtjIGbxFhAA0dLf
	0XDjus/GYoAjaxnFre+dOsvgD3mdwvg1FIVnTWZ5cWpuB2Z6vTKm+HlJ+sUf2pZw
	8/s/Ca2EMP4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C6959759;
	Wed, 15 Aug 2012 22:02:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B7299756; Wed, 15 Aug 2012
 22:02:32 -0400 (EDT)
In-Reply-To: <7va9xv4uir.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 15 Aug 2012 16:15:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71303AAE-E746-11E1-A288-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> My preference is to remove "static int is_executable()" function
> from help.c, have an...
> ... I wouldn't mind seeing the implementation of posix_is_executable()
> in help.c, which will be dead-code on Windows and Cygwin, if that
> makes linking and Makefile easier.

An outline of such a change might look like this.

As usual, I am not great at names, so you may want to rename the
shared one.  Also I do not know what headers Cygwin and Windows
specific bits would need to include, so you would have to include
more than just "git-compat-util.h" in the compat/*.c files this
patch adds.

It would make sense to move the "does it end with .exe" check from
the caller to the shared function, but because that does not match
the concept of the name I came up with (peek-contents), I left it
out of the function. If there is a good name to express what such a
combined "ends with .exe, or inspected contents look like an
executable", it would make sense to rename it as such and move
".exe" check to it.

Thanks.

 Makefile                     |  6 ++++--
 compat/cygwin.c              | 16 ++++++++++++++++
 compat/win32/is_executable.c | 14 ++++++++++++++
 compat/win32/peek_contents.c | 16 ++++++++++++++++
 git-compat-util.h            |  9 +++++++++
 help.c                       | 32 +-------------------------------
 is_executable.c              | 12 ++++++++++++
 7 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/Makefile b/Makefile
index 6b0c961..2bcb9f4 100644
--- a/Makefile
+++ b/Makefile
@@ -734,6 +734,7 @@ LIB_OBJS += hash.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
+LIB_OBJS += is_executable.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += list-objects.o
@@ -1073,7 +1074,7 @@ ifeq ($(uname_O),Cygwin)
 	# Try commenting this out if you suspect MMAP is more efficient
 	NO_MMAP = YesPlease
 	X = .exe
-	COMPAT_OBJS += compat/cygwin.o
+	COMPAT_OBJS += compat/cygwin.o compat/win32/peek_contents.o
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
 endif
@@ -1257,7 +1258,8 @@ ifeq ($(uname_S),Windows)
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/poll.o compat/win32/dirent.o
+		compat/win32/poll.o compat/win32/dirent.o \
+		compat/win32/is_executable.o compat/win32/peek_contents.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
diff --git a/compat/cygwin.c b/compat/cygwin.c
index dfe9b30..5eb948a 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -140,3 +140,19 @@ static int cygwin_lstat_stub(const char *file_name, struct stat *buf)
 stat_fn_t cygwin_stat_fn = cygwin_stat_stub;
 stat_fn_t cygwin_lstat_fn = cygwin_lstat_stub;
 
+extern int win32_peek_contents_executable(const char *);
+
+int cygwin_is_path_executable(const char *name)
+{
+	struct stat st;
+
+	/* stat, not lstat */
+	if (stat(name, &st) || !S_ISREG(st.st_mode))
+		return 0;
+	if (st.st_mode & S_IXUSR)
+		return 1;
+
+	if (has_extension(name, ".exe"))
+		return 1;
+	return win32_peek_contents_executable(name);
+}
diff --git a/compat/win32/is_executable.c b/compat/win32/is_executable.c
new file mode 100644
index 0000000..f7907b3
--- /dev/null
+++ b/compat/win32/is_executable.c
@@ -0,0 +1,14 @@
+#include "git-compat-util.h"
+
+int win32_path_is_executable(const char *name)
+{
+	/*
+	 * Do whatever you would do on win32 to make sure
+	 * "name" exists here
+	 */
+	if (!file_exists(name))
+		return 0;
+	if (has_extension(name, ".exe"))
+		return 1;
+	return win32_peek_contents_executable(name);
+}
diff --git a/compat/win32/peek_contents.c b/compat/win32/peek_contents.c
new file mode 100644
index 0000000..5e425aa
--- /dev/null
+++ b/compat/win32/peek_contents.c
@@ -0,0 +1,16 @@
+#include "git-compat-util.h"
+
+int win32_peek_contents_executable(const char *name)
+{
+	char buf[2];
+	int n, fd;
+
+	fd = open(name, O_RDONLY);
+	if (fd < 0)
+		return 0;
+	n = read(fd, buf, 2);
+	close(fd);
+	return (n == 2 &&
+		/* DOS executables start with "MZ" */
+		(!memcmp(buf, "#!", 2) || !memcmp(buf, "MZ", 2)));
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 35b095e..e8f8cb1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -607,4 +607,13 @@ int remove_or_warn(unsigned int mode, const char *path);
 /* Get the passwd entry for the UID of the current process. */
 struct passwd *xgetpwuid_self(void);
 
+/* Does the given path name an executable command? */
+#if defined(__CYGWIN__)
+#define is_path_executable(p) cygwin_is_path_executable(p)
+#elif defined(WIN32)
+#define is_path_executable(p) win32_is_path_executable(p)
+#endif
+
+extern int is_path_executable(const char *);
+
 #endif
diff --git a/help.c b/help.c
index 2a42ec6..672d9d3 100644
--- a/help.c
+++ b/help.c
@@ -98,36 +98,6 @@ static void pretty_print_string_list(struct cmdnames *cmds,
 	string_list_clear(&list, 0);
 }
 
-static int is_executable(const char *name)
-{
-	struct stat st;
-
-	if (stat(name, &st) || /* stat, not lstat */
-	    !S_ISREG(st.st_mode))
-		return 0;
-
-#if defined(WIN32) || defined(__CYGWIN__)
-#if defined(__CYGWIN__)
-if ((st.st_mode & S_IXUSR) == 0)
-#endif
-{	/* cannot trust the executable bit, peek into the file instead */
-	char buf[3] = { 0 };
-	int n;
-	int fd = open(name, O_RDONLY);
-	st.st_mode &= ~S_IXUSR;
-	if (fd >= 0) {
-		n = read(fd, buf, 2);
-		if (n == 2)
-			/* DOS executables start with "MZ" */
-			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
-				st.st_mode |= S_IXUSR;
-		close(fd);
-	}
-}
-#endif
-	return st.st_mode & S_IXUSR;
-}
-
 static void list_commands_in_dir(struct cmdnames *cmds,
 					 const char *path,
 					 const char *prefix)
@@ -155,7 +125,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 
 		strbuf_setlen(&buf, len);
 		strbuf_addstr(&buf, de->d_name);
-		if (!is_executable(buf.buf))
+		if (!is_path_executable(buf.buf))
 			continue;
 
 		entlen = strlen(de->d_name) - prefix_len;
diff --git a/is_executable.c b/is_executable.c
new file mode 100644
index 0000000..9dacd2a
--- /dev/null
+++ b/is_executable.c
@@ -0,0 +1,12 @@
+#include "git-compat-util.h"
+
+int is_path_executable(const char *name)
+{
+	struct stat st;
+
+	/* stat, not lstat */
+	if (stat(name, &st) || !S_ISREG(st.st_mode))
+		return 0;
+
+	return st.st_mode & S_IXUSR;
+}
