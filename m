Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F407DC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD44261B96
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhKPDjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:39:42 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:43240 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhKPDir (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:38:47 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DE3575D467
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 03:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637033748;
        bh=sb7EXVGpsYnRDDzmh4zXfnu6Yd14/KM7U4GhOQsnjvs=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=PrWwg14Fv8X+qkHYX7dN4PKf8qYLoUZZP9HzMIYe9oxmQy+fDnJeAn3bfS8RL3GfN
         G8f4L9q4OvtzCugu8/C8UDrbF9/yH1Dxe7QM7PNTc14TXH0dVaBRNIppuFbT9x8fJP
         59ht+uDBGw9Oo+QHNiWxLO2w4yEzIynQmqb8okb5/Is2Y7fmI5HpFNzYmi8VHkPMlc
         2ApJnKiDxz9YIh+IpSMoQYfu5x/ShhW1ZVPgDM+rymMV1e/nzxrf1VkBWD0+zmwWPD
         oCljO+0P3HKo0oWheXiFElf4Hy3GCKJqcc+WgZ0pDYAOzPvkKDlSdfZzzgevE1oeAw
         k3plDEx/Y+5cxRDdsl8KyAy6eaMSTkgL7Bn5Q1o9qMnGv5sJhvhn4nxR7AVhCGzZD3
         C+d2RpmiZ9SfyMKrZ4p4fAaI2wkPfBU5yyf2nIdEByyb612oaTob8psvlZkOkEtPfk
         3UF6gWcXnjLRJt9RMnb6SMzJC6IYmFzSMHD7+8muB8hUOXnLV+7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH 1/2] wrapper: add a helper to generate numbers from a CSPRNG
Date:   Tue, 16 Nov 2021 03:35:41 +0000
Message-Id: <20211116033542.3247094-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f
In-Reply-To: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
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

Because this is a security sensitive interface, we take some
precautions.  We either succeed by filling the buffer completely as we
requested, or we fail.  We don't return partial data because the caller
will almost never find that to be a useful behavior.

The order of options is also important here.  On systems with
arc4random, which is most of the BSDs, we use that, since, except on
MirBSD, it uses ChaCha20, which is extremely fast, and sits entirely in
userspace, avoiding a system call.  We then prefer getrandom over
getentropy, because the former has been available longer on Linux, and
finally, if none of those are available, we use /dev/urandom, because
most Unix-like operating systems provide that API.  We prefer options
that don't involve device files when possible because those work in some
restricted environments where device files may not be available.

macOS appears to have arc4random but not the arc4random_buf function we
want to use, so we let it use the fallback of /dev/urandom.  Set the
configuration variables appropriately for Linux and the other BSDs.  We
specifically only consider versions which receive publicly available
security support; for example, getrandom(2) and getentropy(3) are only
available in FreeBSD 12, which is the oldest version with current
security support.  For the same reason, we don't specify getrandom(2) on
Linux, because CentOS 7 doesn't support it in glibc (although its kernel
does) and we don't want to resort to making syscalls.

Finally, add a self-test option here to make sure that our buffer
handling is correct and we aren't truncating data.  We simply read 64
KiB and then make sure we've seen each byte.  The probability of this
test failing spuriously is less than 10^-100.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile                            | 25 ++++++++++++
 compat/winansi.c                    |  6 +++
 config.mak.uname                    |  9 +++++
 contrib/buildsystems/CMakeLists.txt |  2 +-
 git-compat-util.h                   | 16 ++++++++
 t/helper/test-csprng.c              | 63 +++++++++++++++++++++++++++++
 t/helper/test-tool.c                |  1 +
 t/helper/test-tool.h                |  1 +
 t/t0000-basic.sh                    |  4 ++
 wrapper.c                           | 56 +++++++++++++++++++++++++
 10 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-csprng.c

diff --git a/Makefile b/Makefile
index 12be39ac49..1d17021f59 100644
--- a/Makefile
+++ b/Makefile
@@ -234,6 +234,14 @@ all::
 # Define NO_TRUSTABLE_FILEMODE if your filesystem may claim to support
 # the executable mode bit, but doesn't really do so.
 #
+# Define HAVE_ARC4RANDOM if your system has arc4random and arc4random_buf.
+#
+# Define HAVE_GETRANDOM if your system has getrandom.
+#
+# Define HAVE_GETENTROPY if your system has getentropy.
+#
+# Define HAVE_RTLGENRANDOM if your system has RtlGenRandom (Windows only).
+#
 # Define NEEDS_MODE_TRANSLATION if your OS strays from the typical file type
 # bits in mode values (e.g. z/OS defines I_SFMT to 0xFF000000 as opposed to the
 # usual 0xF000).
@@ -694,6 +702,7 @@ TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
+TEST_BUILTINS_OBJS += test-csprng.o
 TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
@@ -1900,6 +1909,22 @@ ifdef HAVE_GETDELIM
 	BASIC_CFLAGS += -DHAVE_GETDELIM
 endif
 
+ifdef HAVE_ARC4RANDOM
+	BASIC_CFLAGS += -DHAVE_ARC4RANDOM
+endif
+
+ifdef HAVE_GETRANDOM
+	BASIC_CFLAGS += -DHAVE_GETRANDOM
+endif
+
+ifdef HAVE_GETENTROPY
+	BASIC_CFLAGS += -DHAVE_GETENTROPY
+endif
+
+ifdef HAVE_RTLGENRANDOM
+	BASIC_CFLAGS += -DHAVE_RTLGENRANDOM
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
index 3236a4918a..5030d3c70b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -257,6 +257,9 @@ ifeq ($(uname_S),FreeBSD)
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	HAVE_ARC4RANDOM = YesPlease
+	HAVE_GETRANDOM = YesPlease
+	HAVE_GETENTROPY = YesPlease
 	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	FILENO_IS_A_MACRO = UnfortunatelyYes
@@ -271,6 +274,8 @@ ifeq ($(uname_S),OpenBSD)
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	HAVE_ARC4RANDOM = YesPlease
+	HAVE_GETENTROPY = YesPlease
 	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	FILENO_IS_A_MACRO = UnfortunatelyYes
@@ -282,6 +287,7 @@ ifeq ($(uname_S),MirBSD)
 	NEEDS_LIBICONV = YesPlease
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
+	HAVE_ARC4RANDOM = YesPlease
 endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
@@ -293,6 +299,7 @@ ifeq ($(uname_S),NetBSD)
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
+	HAVE_ARC4RANDOM = YesPlease
 	PROCFS_EXECUTABLE_PATH = /proc/curproc/exe
 endif
 ifeq ($(uname_S),AIX)
@@ -422,6 +429,7 @@ ifeq ($(uname_S),Windows)
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_INTTYPES_H = YesPlease
+	HAVE_RTLGENRANDOM = YesPlease
 	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
 	# so we don't need this:
 	#
@@ -624,6 +632,7 @@ ifeq ($(uname_S),MINGW)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
 	HAVE_PLATFORM_PROCINFO = YesPlease
+	HAVE_RTLGENRANDOM = YesPlease
 	BASIC_LDFLAGS += -municode
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fd1399c440..134e00bde3 100644
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
index d70ce14286..f2cff656e7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -165,6 +165,12 @@
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
@@ -235,6 +241,9 @@
 #else
 #include <stdint.h>
 #endif
+#ifdef HAVE_GETRANDOM
+#include <sys/random.h>
+#endif
 #ifdef NO_INTPTR_T
 /*
  * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
@@ -1381,4 +1390,11 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 
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
index 0000000000..196c14e44f
--- /dev/null
+++ b/t/helper/test-csprng.c
@@ -0,0 +1,63 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+
+/*
+ * Check that we read each byte value at least once when reading 64 KiB from the
+ * CSPRNG.  This is not to test the quality of the CSPRNG, but to test our
+ * buffer handling of it.
+ *
+ * The probability of this failing by random is less than 10^-100.
+ */
+static int selftest(void)
+{
+	int buckets[256] = { 0 };
+	unsigned char buf[1024];
+	unsigned long count = 64 * 1024;
+	int i;
+
+	while (count) {
+		if (csprng_bytes(buf, sizeof(buf)) < 0) {
+			perror("failed to read");
+			return 3;
+		}
+		for (i = 0; i < sizeof(buf); i++)
+			buckets[buf[i]]++;
+		count -= sizeof(buf);
+	}
+	for (i = 0; i < ARRAY_SIZE(buckets); i++)
+		if (!buckets[i]) {
+			fprintf(stderr, "failed to find any bytes with value %02x\n", i);
+			return 4;
+		}
+	return 0;
+}
+
+int cmd__csprng(int argc, const char **argv)
+{
+	unsigned long count;
+	unsigned char buf[1024];
+
+	if (argc > 2) {
+		fprintf(stderr, "usage: %s [--selftest | <size>]\n", argv[0]);
+		return 2;
+	}
+
+	if (!strcmp(argv[1], "--selftest")) {
+		return selftest();
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
index 3ce5585e53..fc0fb86c1b 100644
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
index 9f0f522850..077d9bfcca 100644
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
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b007f0efef..9647ec9629 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1131,4 +1131,8 @@ test_expect_success 'test_must_fail rejects a non-git command with env' '
 	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
 '
 
+test_expect_success 'CSPRNG handling functions correctly' '
+	test-tool csprng --selftest
+'
+
 test_done
diff --git a/wrapper.c b/wrapper.c
index 36e12119d7..0046f32e46 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -702,3 +702,59 @@ int open_nofollow(const char *path, int flags)
 	return open(path, flags);
 #endif
 }
+
+int csprng_bytes(void *buf, size_t len)
+{
+#if defined(HAVE_ARC4RANDOM)
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
