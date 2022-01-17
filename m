Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4930C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 21:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiAQV4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 16:56:24 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:35350 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiAQV4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 16:56:23 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C35065B27D;
        Mon, 17 Jan 2022 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642456582;
        bh=PisQ3CvsQgBSdXdlEsyi4+Fg6Iq6HvpkRCxgw/+/VME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BO59ojR6D6aGoAhGGXaPfZl12JLWFZ6d2RrfOuujN6MwgB2Wub+zAhYuKk//ClkMm
         Us2g/RG0ww3r0fD227JOgDa62o51W9ihb30sEflLj//mm6WYaJNYmcM3lXsqIwE7/Y
         8uq8qEVgnH0Hb6zcgkiT5Vpelo4vku4yTRSq0j26Ll8/gris7EXVN89S6FJvOvl9xI
         hYxc8AukpcgEJ82bOAzELfun3fX9I3/0B5WijVCzydXhkYNLFbvm+ocsoA/rRTcLs6
         IE7ndj3N8gyHwVs7L9FflWi8xYVobnVraOvEQvZ/0koxKRFz3qZ9ymQ5hRFoYsWSEH
         U+Stod0WmizpjownG2qkAnSc8Lx5r85RPk2IEFkezIruruOBIof04tmwmOegMt0+Bg
         24Bn0+XWvGSb/arWgrXD/ypK3wfPFHMJw0xWkJVD9lKL6UGPS4SpRr099cDrb1u+a/
         A6rJXmdhwPERBYYjeSUlydksqdyh/5CIUExBn1DZjwUDGcQWc67
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 1/2] wrapper: add a helper to generate numbers from a CSPRNG
Date:   Mon, 17 Jan 2022 21:56:16 +0000
Message-Id: <20220117215617.843190-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
In-Reply-To: <20220117215617.843190-1-sandals@crustytoothpaste.net>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many situations in which having access to a cryptographically
secure pseudorandom number generator (CSPRNG) is helpful.  In the
future, we'll encounter one of these when dealing with temporary files.
To make this possible, let's add a function which reads from a system
CSPRNG and returns some bytes.

We know that all systems will have such an interface.  A CSPRNG is
required for a secure TLS or SSH implementation and a Git implementation
which provided neither would be of little practical use.  In addition,
POSIX is set to standardize getentropy(2) in the next version, so in the
(potentially distant) future we can rely on that.

For systems which lack one of the other interfaces, we provide the
ability to use OpenSSL's CSPRNG.  OpenSSL is highly portable and
functions on practically every known OS, and we know it will have access
to some source of cryptographically secure randomness.  We also provide
support for the arc4random in libbsd for folks who would prefer to use
that.

Because this is a security sensitive interface, we take some
precautions.  We either succeed by filling the buffer completely as we
requested, or we fail.  We don't return partial data because the caller
will almost never find that to be a useful behavior.

Specify a makefile knob which users can use to specify one or more
suitable CSPRNGs, and turn the multiple string options into a set of
defines, since we cannot match on strings in the preprocessor.  We allow
multiple options to make the job of handling this in autoconf easier.

The order of options is important here.  On systems with arc4random,
which is most of the BSDs, we use that, since, except on MirBSD and
macOS, it uses ChaCha20, which is extremely fast, and sits entirely in
userspace, avoiding a system call.  We then prefer getrandom over
getentropy, because the former has been available longer on Linux, and
then OpenSSL. Finally, if none of those are available, we use
/dev/urandom, because most Unix-like operating systems provide that API.
We prefer options that don't involve device files when possible because
those work in some restricted environments where device files may not be
available.

Set the configuration variables appropriately for Linux and the BSDs,
including macOS, as well as Windows and NonStop.  We specifically only
consider versions which receive publicly available security support
here.  For the same reason, we don't specify getrandom(2) on Linux,
because CentOS 7 doesn't support it in glibc (although its kernel does)
and we don't want to resort to making syscalls.

Finally, add a test helper to allow this to be tested by hand and in
tests.  We don't add any tests, since invoking the CSPRNG is not likely
to produce interesting, reproducible results.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile                            | 34 +++++++++++++++
 compat/winansi.c                    |  6 +++
 config.mak.uname                    |  8 ++++
 contrib/buildsystems/CMakeLists.txt |  2 +-
 git-compat-util.h                   | 19 +++++++++
 t/helper/test-csprng.c              | 29 +++++++++++++
 t/helper/test-tool.c                |  1 +
 t/helper/test-tool.h                |  1 +
 wrapper.c                           | 66 +++++++++++++++++++++++++++++
 9 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-csprng.c

diff --git a/Makefile b/Makefile
index 75ed168adb..198b759e76 100644
--- a/Makefile
+++ b/Makefile
@@ -234,6 +234,14 @@ all::
 # Define NO_TRUSTABLE_FILEMODE if your filesystem may claim to support
 # the executable mode bit, but doesn't really do so.
 #
+# Define CSPRNG_METHOD to "arc4random" if your system has arc4random and
+# arc4random_buf, "libbsd" if your system has those functions from libbsd,
+# "getrandom" if your system has getrandom, "getentropy" if your system has
+# getentropy, "rtlgenrandom" for RtlGenRandom (Windows only), or "openssl" if
+# you'd want to use the OpenSSL CSPRNG.  You may set multiple options with
+# spaces, in which case a suitable option will be chosen.  If unset or set to
+# anything else, defaults to using "/dev/urandom".
+#
 # Define NEEDS_MODE_TRANSLATION if your OS strays from the typical file type
 # bits in mode values (e.g. z/OS defines I_SFMT to 0xFF000000 as opposed to the
 # usual 0xF000).
@@ -693,6 +701,7 @@ TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
+TEST_BUILTINS_OBJS += test-csprng.o
 TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
@@ -1908,6 +1917,31 @@ ifdef HAVE_GETDELIM
 	BASIC_CFLAGS += -DHAVE_GETDELIM
 endif
 
+ifneq ($(findstring arc4random,$(CSPRNG_METHOD)),)
+	BASIC_CFLAGS += -DHAVE_ARC4RANDOM
+endif
+
+ifneq ($(findstring libbsd,$(CSPRNG_METHOD)),)
+	BASIC_CFLAGS += -DHAVE_ARC4RANDOM_LIBBSD
+	EXTLIBS += -lbsd
+endif
+
+ifneq ($(findstring getrandom,$(CSPRNG_METHOD)),)
+	BASIC_CFLAGS += -DHAVE_GETRANDOM
+endif
+
+ifneq ($(findstring getentropy,$(CSPRNG_METHOD)),)
+	BASIC_CFLAGS += -DHAVE_GETENTROPY
+endif
+
+ifneq ($(findstring rtlgenrandom,$(CSPRNG_METHOD)),)
+	BASIC_CFLAGS += -DHAVE_RTLGENRANDOM
+endif
+
+ifneq ($(findstring openssl,$(CSPRNG_METHOD)),)
+	BASIC_CFLAGS += -DHAVE_OPENSSL_CSPRNG
+endif
+
 ifneq ($(PROCFS_EXECUTABLE_PATH),)
 	procfs_executable_path_SQ = $(subst ','\'',$(PROCFS_EXECUTABLE_PATH))
 	BASIC_CFLAGS += '-DPROCFS_EXECUTABLE_PATH="$(procfs_executable_path_SQ)"'
diff --git a/compat/winansi.c b/compat/winansi.c
index c27b20a79d..0e5a9cc82e 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -3,6 +3,12 @@
  */
 
 #undef NOGDI
+
+/*
+ * Including the appropriate header file for RtlGenRandom causes MSVC to see a
+ * redefinition of types in an incompatible way when including headers below.
+ */
+#undef HAVE_RTLGENRANDOM
 #include "../git-compat-util.h"
 #include <wingdi.h>
 #include <winreg.h>
diff --git a/config.mak.uname b/config.mak.uname
index a3a779327f..ff0710a612 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -141,6 +141,7 @@ ifeq ($(uname_S),Darwin)
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
+	CSPRNG_METHOD = arc4random
 
 	# Workaround for `gettext` being keg-only and not even being linked via
 	# `brew link --force gettext`, should be obsolete as of
@@ -256,6 +257,7 @@ ifeq ($(uname_S),FreeBSD)
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	CSPRNG_METHOD = arc4random
 	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	FILENO_IS_A_MACRO = UnfortunatelyYes
@@ -274,6 +276,7 @@ ifeq ($(uname_S),OpenBSD)
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	CSPRNG_METHOD = arc4random
 	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	FILENO_IS_A_MACRO = UnfortunatelyYes
@@ -285,6 +288,7 @@ ifeq ($(uname_S),MirBSD)
 	NEEDS_LIBICONV = YesPlease
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
+	CSPRNG_METHOD = arc4random
 endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
@@ -296,6 +300,7 @@ ifeq ($(uname_S),NetBSD)
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	CSPRNG_METHOD = arc4random
 	PROCFS_EXECUTABLE_PATH = /proc/curproc/exe
 endif
 ifeq ($(uname_S),AIX)
@@ -425,6 +430,7 @@ ifeq ($(uname_S),Windows)
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_INTTYPES_H = YesPlease
+	CSPRNG_METHOD = rtlgenrandom
 	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
 	# so we don't need this:
 	#
@@ -593,6 +599,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_MMAP = YesPlease
 	NO_POLL = YesPlease
 	NO_INTPTR_T = UnfortunatelyYes
+	CSPRNG_METHOD = openssl
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
 endif
@@ -628,6 +635,7 @@ ifeq ($(uname_S),MINGW)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
 	HAVE_PLATFORM_PROCINFO = YesPlease
+	CSPRNG_METHOD = rtlgenrandom
 	BASIC_LDFLAGS += -municode
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5100f56bb3..e44232f85d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -260,7 +260,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
 				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
-				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
+				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
 	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
 		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
 		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
diff --git a/git-compat-util.h b/git-compat-util.h
index 5fa54a7afe..50597c76be 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -188,6 +188,12 @@
 #endif
 #include <windows.h>
 #define GIT_WINDOWS_NATIVE
+#ifdef HAVE_RTLGENRANDOM
+/* This is required to get access to RtlGenRandom. */
+#define SystemFunction036 NTAPI SystemFunction036
+#include <NTSecAPI.h>
+#undef SystemFunction036
+#endif
 #endif
 
 #include <unistd.h>
@@ -258,6 +264,12 @@
 #else
 #include <stdint.h>
 #endif
+#ifdef HAVE_ARC4RANDOM_LIBBSD
+#include <bsd/stdlib.h>
+#endif
+#ifdef HAVE_GETRANDOM
+#include <sys/random.h>
+#endif
 #ifdef NO_INTPTR_T
 /*
  * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
@@ -1421,4 +1433,11 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 
 void sleep_millisec(int millisec);
 
+/*
+ * Generate len bytes from the system cryptographically secure PRNG.
+ * Returns 0 on success and -1 on error, setting errno.  The inability to
+ * satisfy the full request is an error.
+ */
+int csprng_bytes(void *buf, size_t len);
+
 #endif
diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
new file mode 100644
index 0000000000..65d14973c5
--- /dev/null
+++ b/t/helper/test-csprng.c
@@ -0,0 +1,29 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+
+
+int cmd__csprng(int argc, const char **argv)
+{
+	unsigned long count;
+	unsigned char buf[1024];
+
+	if (argc > 2) {
+		fprintf(stderr, "usage: %s [<size>]\n", argv[0]);
+		return 2;
+	}
+
+	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : -1L;
+
+	while (count) {
+		unsigned long chunk = count < sizeof(buf) ? count : sizeof(buf);
+		if (csprng_bytes(buf, chunk) < 0) {
+			perror("failed to read");
+			return 5;
+		}
+		if (fwrite(buf, chunk, 1, stdout) != chunk)
+			return 1;
+		count -= chunk;
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 338a57b104..e6ec69cf32 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -20,6 +20,7 @@ static struct test_cmd cmds[] = {
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "crontab", cmd__crontab },
+	{ "csprng", cmd__csprng },
 	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
 	{ "delta", cmd__delta },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 48cee1f4a2..20756eefdd 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -10,6 +10,7 @@ int cmd__bloom(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__crontab(int argc, const char **argv);
+int cmd__csprng(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
diff --git a/wrapper.c b/wrapper.c
index 36e12119d7..1052356703 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -702,3 +702,69 @@ int open_nofollow(const char *path, int flags)
 	return open(path, flags);
 #endif
 }
+
+int csprng_bytes(void *buf, size_t len)
+{
+#if defined(HAVE_ARC4RANDOM) || defined(HAVE_ARC4RANDOM_LIBBSD)
+	/* This function never returns an error. */
+	arc4random_buf(buf, len);
+	return 0;
+#elif defined(HAVE_GETRANDOM)
+	ssize_t res;
+	char *p = buf;
+	while (len) {
+		res = getrandom(p, len, 0);
+		if (res < 0)
+			return -1;
+		len -= res;
+		p += res;
+	}
+	return 0;
+#elif defined(HAVE_GETENTROPY)
+	int res;
+	char *p = buf;
+	while (len) {
+		/* getentropy has a maximum size of 256 bytes. */
+		size_t chunk = len < 256 ? len : 256;
+		res = getentropy(p, chunk);
+		if (res < 0)
+			return -1;
+		len -= chunk;
+		p += chunk;
+	}
+	return 0;
+#elif defined(HAVE_RTLGENRANDOM)
+	if (!RtlGenRandom(buf, len))
+		return -1;
+	return 0;
+#elif defined(HAVE_OPENSSL_CSPRNG)
+	int res = RAND_bytes(buf, len);
+	if (res == 1)
+		return 0;
+	if (res == -1)
+		errno = ENOTSUP;
+	else
+		errno = EIO;
+	return -1;
+#else
+	ssize_t res;
+	char *p = buf;
+	int fd, err;
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0)
+		return -1;
+	while (len) {
+		res = xread(fd, p, len);
+		if (res < 0) {
+			err = errno;
+			close(fd);
+			errno = err;
+			return -1;
+		}
+		len -= res;
+		p += res;
+	}
+	close(fd);
+	return 0;
+#endif
+}
