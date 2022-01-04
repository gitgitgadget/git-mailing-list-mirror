Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC08C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 02:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiADCJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 21:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiADCJE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 21:09:04 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752D8C061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 18:09:04 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8C8365B214;
        Tue,  4 Jan 2022 02:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641262143;
        bh=KKsLLgduAPbKljhxbVQMnPouTOX9uvYpHLDU7S9YMYA=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=dxDa4lHaSFfUgkG+XsSdcku2tAUvse/EGlYSQkI6Ev+6j2vBqJNmwSK8B/8+A9Gx9
         HZXozMtmR7R2xJuZa9Fql2r6U9doqozzUcb4jIAb78vd0s9AMAUNPOvisxXCcmAtcJ
         yOHtIi3yNX8uWMRTFmNjJsEZ6rG1ibW6PisyaZgaRjD+qoT2AHMw4dh8wJjez0EpXf
         KY8kd5yc+vDpqsmMAqSwNyUd4JcYOEMIBmgVmK8057LDubgUs435gW++tj2VsPoQjU
         wFCcVhXcFhL+DQTxskeHIkXNzL90B5gQbCNMbfrH/Mfvr/6CMvHqibXh8IEQsT4n9b
         rpkZM5knJ982DMzoLzAgVhC5NJTVNxuh9a9xfQS9OV07yYve1bPi9z29rsvm+yeOzd
         8V/+LQeyHQXJQeUYlLe9noTUkGgrR8VZpsGiYLah4rkieWNDWbtHNJtKfZOfRnJN6v
         Jynt3VT91SgBwPCoplbsmYd3JXX6lJW+TYxhwF4vtxuzxaVRmZX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 0/2] Generate temporary files using a CSPRNG
Date:   Tue,  4 Jan 2022 01:55:53 +0000
Message-Id: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, when we generate a temporary file name, we use the seconds,
microseconds, and the PID to generate a unique value.  The resulting
value, while changing frequently, is actually predictable and on some
systems, it may be possible to cause a DoS by creating all potential
temporary files when the temporary file is being created in TMPDIR.

The solution to this is to use the system CSPRNG to generate the
temporary file name.  This is the approach taken by FreeBSD, NetBSD, and
OpenBSD, and glibc also recently switched to this approach from an
approach that resembled ours in many ways.

Even if this is not practically exploitable on many systems, it seems
prudent to be at least as careful about temporary file generation as
libc is.

In this round, I've switched to using a single Makefile variable instead
of multiple.  This lets folks set the compile options in a simpler way,
but it does require that we strip whitespace when parsing the values,
since we have several places in our makefiles where we add extra
whitespace.  We still have multiple #defines because that's functionally
required.

I've also added support for the OpenSSL CSPRNG here, which should
address concerns for NonStop.  Because OpenSSL is very portable across
systems and a TLS library is effectively required for a generally useful
Git on the Internet today, we can assume that this is a safe fallback.

I have noted in my updated commit message that POSIX is set to
standardize getentropy in a future revision of the standard.  Of course,
we don't demand that systems implement a specific version of POSIX, but
that does mean that this code will likely shrink somewhat over time
instead of increasing in size.  That's my hope, at least.

I have, in light of the above additions, chosen not to add a fallback to
an insecure option.  I think we provide plenty of options that should
meet the needs of all users and in the unlikely event we find a system
which simply cannot provide the relevant interface, we can add one then.

There was a proposal to switch to using mkstemp instead.  I have not
adopted that approach because it is strictly less functional than our
current approach (e.g., it would not support modes properly), I have
doubts about its portability (in which case we'd have to reimplement it
using something like this series anyway), and as mentioned in the
thread, I plan to investigate further uses of this code in the future.

For those that are interested in the nitty-gritty details after reading
the commit message, I did end up determining that modern macOS supports
the arc4random interfaces we require.  It currently calls out to its own
CTR DRBG in CoreCrypto, which is why it doesn't use ChaCha.  MirBSD also
supports these interfaces, but still uses RC4.  We use those interfaces
anyway and will let them deal with the consequences, since the interface
is stated to use a CSPRNG and as far as I can tell the kernel uses the
same algorithm.  All the other BSDs I checked (and libbsd) use ChaCha
and have the boring and secure OpenBSD-like behavior.

A range-diff appears below for your convenience.

Changes from v1:
* Remove the automatic testing using buckets because it didn't seem to
  add much.
* Switch to a single makefile variable.
* Add support for OpenSSL CSPRNG.
* Add more defaults for various systems, including macOS and NonStop.
* Add an arc4random-libbsd variant for improved testing of the
  arc4random code paths on Linux.  The only difference is the inclusion
  of an additional header.
* Print a more useful error message than before, indicating that the
  CSPRNG failed.

brian m. carlson (2):
  wrapper: add a helper to generate numbers from a CSPRNG
  wrapper: use a CSPRNG to generate random file names

 Makefile                            | 33 ++++++++++++
 compat/winansi.c                    |  6 +++
 config.mak.uname                    |  8 +++
 contrib/buildsystems/CMakeLists.txt |  2 +-
 git-compat-util.h                   | 19 +++++++
 t/helper/test-csprng.c              | 29 +++++++++++
 t/helper/test-tool.c                |  1 +
 t/helper/test-tool.h                |  1 +
 wrapper.c                           | 81 +++++++++++++++++++++++++----
 9 files changed, 168 insertions(+), 12 deletions(-)
 create mode 100644 t/helper/test-csprng.c

Diff-intervalle contre v1 :
1:  8ffb65a1f8 ! 1:  edd623bd9a wrapper: add a helper to generate numbers from a CSPRNG
    @@ Commit message
         To make this possible, let's add a function which reads from a system
         CSPRNG and returns some bytes.
     
    +    We know that all systems will have such an interface.  A CSPRNG is
    +    required for a secure TLS or SSH implementation and a Git implementation
    +    which provided neither would be of little practical use.  In addition,
    +    POSIX is set to standardize getentropy(2) in the next version, so in the
    +    (potentially distant) future we can rely on that.
    +
    +    For systems which lack one of the other interfaces, we provide the
    +    ability to use OpenSSL's CSPRNG.  OpenSSL is highly portable and
    +    functions on practically every known OS, and we know it will have access
    +    to some source of cryptographically secure randomness.  We also provide
    +    support for the arc4random in libbsd for folks who would prefer to use
    +    that.
    +
         Because this is a security sensitive interface, we take some
         precautions.  We either succeed by filling the buffer completely as we
         requested, or we fail.  We don't return partial data because the caller
         will almost never find that to be a useful behavior.
     
    -    The order of options is also important here.  On systems with
    -    arc4random, which is most of the BSDs, we use that, since, except on
    -    MirBSD, it uses ChaCha20, which is extremely fast, and sits entirely in
    -    userspace, avoiding a system call.  We then prefer getrandom over
    -    getentropy, because the former has been available longer on Linux, and
    -    finally, if none of those are available, we use /dev/urandom, because
    -    most Unix-like operating systems provide that API.  We prefer options
    -    that don't involve device files when possible because those work in some
    -    restricted environments where device files may not be available.
    +    Specify a makefile knob which users can use to specify their preferred
    +    CSPRNG, and turn the multiple string options into a set of defines,
    +    since we cannot match on strings in the preprocessor.
     
    -    macOS appears to have arc4random but not the arc4random_buf function we
    -    want to use, so we let it use the fallback of /dev/urandom.  Set the
    -    configuration variables appropriately for Linux and the other BSDs.  We
    -    specifically only consider versions which receive publicly available
    -    security support; for example, getrandom(2) and getentropy(3) are only
    -    available in FreeBSD 12, which is the oldest version with current
    -    security support.  For the same reason, we don't specify getrandom(2) on
    -    Linux, because CentOS 7 doesn't support it in glibc (although its kernel
    -    does) and we don't want to resort to making syscalls.
    +    The order of suggested options is important here.  On systems with
    +    arc4random, which is most of the BSDs, we suggest that, since, except on
    +    MirBSD and macOS, it uses ChaCha20, which is extremely fast, and sits
    +    entirely in userspace, avoiding a system call.  We then prefer getrandom
    +    over getentropy, because the former has been available longer on Linux,
    +    and then OpenSSL. Finally, if none of those are available, we use
    +    /dev/urandom, because most Unix-like operating systems provide that API.
    +    We prefer to suggest options that don't involve device files when
    +    possible because those work in some restricted environments where device
    +    files may not be available.
     
    -    Finally, add a self-test option here to make sure that our buffer
    -    handling is correct and we aren't truncating data.  We simply read 64
    -    KiB and then make sure we've seen each byte.  The probability of this
    -    test failing spuriously is less than 10^-100.
    +    Set the configuration variables appropriately for Linux and the BSDs,
    +    including macOS, as well as Windows and NonStop.  We specifically only
    +    consider versions which receive publicly available security support
    +    here.  For the same reason, we don't specify getrandom(2) on Linux,
    +    because CentOS 7 doesn't support it in glibc (although its kernel does)
    +    and we don't want to resort to making syscalls.
    +
    +    Finally, add a test helper to allow this to be tested by hand and in
    +    tests.  We don't add any tests, since invoking the CSPRNG is not likely
    +    to produce interesting, reproducible results.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ Makefile: all::
      # Define NO_TRUSTABLE_FILEMODE if your filesystem may claim to support
      # the executable mode bit, but doesn't really do so.
      #
    -+# Define HAVE_ARC4RANDOM if your system has arc4random and arc4random_buf.
    -+#
    -+# Define HAVE_GETRANDOM if your system has getrandom.
    -+#
    -+# Define HAVE_GETENTROPY if your system has getentropy.
    -+#
    -+# Define HAVE_RTLGENRANDOM if your system has RtlGenRandom (Windows only).
    ++# Define CSPRNG_METHOD to "arc4random" if your system has arc4random and
    ++# arc4random_buf, "arc4random-libbsd" if your system has those functions from
    ++# libbsd, "getrandom" if your system has getrandom, "getentropy" if your
    ++# system has getentropy, "rtlgenrandom" for RtlGenRandom (Windows only), or
    ++# "openssl" if you'd want to use the OpenSSL CSPRNG.  If unset or set to
    ++# anything else, defaults to using "/dev/urandom".
     +#
      # Define NEEDS_MODE_TRANSLATION if your OS strays from the typical file type
      # bits in mode values (e.g. z/OS defines I_SFMT to 0xFF000000 as opposed to the
    @@ Makefile: ifdef HAVE_GETDELIM
      	BASIC_CFLAGS += -DHAVE_GETDELIM
      endif
      
    -+ifdef HAVE_ARC4RANDOM
    ++ifeq ($(strip $(CSPRNG_METHOD)),arc4random)
     +	BASIC_CFLAGS += -DHAVE_ARC4RANDOM
     +endif
     +
    -+ifdef HAVE_GETRANDOM
    ++ifeq ($(strip $(CSPRNG_METHOD)),arc4random-libbsd)
    ++	BASIC_CFLAGS += -DHAVE_ARC4RANDOM_LIBBSD
    ++	EXTLIBS += -lbsd
    ++endif
    ++
    ++ifeq ($(strip $(CSPRNG_METHOD)),getrandom)
     +	BASIC_CFLAGS += -DHAVE_GETRANDOM
     +endif
     +
    -+ifdef HAVE_GETENTROPY
    ++ifeq ($(strip $(CSPRNG_METHOD)),getentropy)
     +	BASIC_CFLAGS += -DHAVE_GETENTROPY
     +endif
     +
    -+ifdef HAVE_RTLGENRANDOM
    ++ifeq ($(strip $(CSPRNG_METHOD)),rtlgenrandom)
     +	BASIC_CFLAGS += -DHAVE_RTLGENRANDOM
     +endif
    ++
    ++ifeq ($(strip $(CSPRNG_METHOD)),openssl)
    ++	BASIC_CFLAGS += -DHAVE_OPENSSL_CSPRNG
    ++endif
     +
      ifneq ($(PROCFS_EXECUTABLE_PATH),)
      	procfs_executable_path_SQ = $(subst ','\'',$(PROCFS_EXECUTABLE_PATH))
    @@ compat/winansi.c
      #include <winreg.h>
     
      ## config.mak.uname ##
    +@@ config.mak.uname: ifeq ($(uname_S),Darwin)
    + 	HAVE_BSD_SYSCTL = YesPlease
    + 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
    + 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
    ++	CSPRNG_METHOD = arc4random
    + 
    + 	# Workaround for `gettext` being keg-only and not even being linked via
    + 	# `brew link --force gettext`, should be obsolete as of
     @@ config.mak.uname: ifeq ($(uname_S),FreeBSD)
      	HAVE_PATHS_H = YesPlease
      	HAVE_BSD_SYSCTL = YesPlease
      	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
    -+	HAVE_ARC4RANDOM = YesPlease
    -+	HAVE_GETRANDOM = YesPlease
    -+	HAVE_GETENTROPY = YesPlease
    ++	CSPRNG_METHOD = arc4random
      	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
      	FREAD_READS_DIRECTORIES = UnfortunatelyYes
      	FILENO_IS_A_MACRO = UnfortunatelyYes
    @@ config.mak.uname: ifeq ($(uname_S),OpenBSD)
      	HAVE_PATHS_H = YesPlease
      	HAVE_BSD_SYSCTL = YesPlease
      	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
    -+	HAVE_ARC4RANDOM = YesPlease
    -+	HAVE_GETENTROPY = YesPlease
    ++	CSPRNG_METHOD = arc4random
      	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
      	FREAD_READS_DIRECTORIES = UnfortunatelyYes
      	FILENO_IS_A_MACRO = UnfortunatelyYes
    @@ config.mak.uname: ifeq ($(uname_S),MirBSD)
      	NEEDS_LIBICONV = YesPlease
      	HAVE_PATHS_H = YesPlease
      	HAVE_BSD_SYSCTL = YesPlease
    -+	HAVE_ARC4RANDOM = YesPlease
    ++	CSPRNG_METHOD = arc4random
      endif
      ifeq ($(uname_S),NetBSD)
      	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
    @@ config.mak.uname: ifeq ($(uname_S),NetBSD)
      	HAVE_PATHS_H = YesPlease
      	HAVE_BSD_SYSCTL = YesPlease
      	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
    -+	HAVE_ARC4RANDOM = YesPlease
    ++	CSPRNG_METHOD = arc4random
      	PROCFS_EXECUTABLE_PATH = /proc/curproc/exe
      endif
      ifeq ($(uname_S),AIX)
    @@ config.mak.uname: ifeq ($(uname_S),Windows)
      	NO_STRTOUMAX = YesPlease
      	NO_MKDTEMP = YesPlease
      	NO_INTTYPES_H = YesPlease
    -+	HAVE_RTLGENRANDOM = YesPlease
    ++	CSPRNG_METHOD = rtlgenrandom
      	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
      	# so we don't need this:
      	#
    +@@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
    + 	NO_MMAP = YesPlease
    + 	NO_POLL = YesPlease
    + 	NO_INTPTR_T = UnfortunatelyYes
    ++	CSPRNG_METHOD = openssl
    + 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
    + 	SHELL_PATH = /usr/coreutils/bin/bash
    + endif
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
      	NO_POSIX_GOODIES = UnfortunatelyYes
      	DEFAULT_HELP_FORMAT = html
      	HAVE_PLATFORM_PROCINFO = YesPlease
    -+	HAVE_RTLGENRANDOM = YesPlease
    ++	CSPRNG_METHOD = rtlgenrandom
      	BASIC_LDFLAGS += -municode
      	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
      	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
    @@ git-compat-util.h
      #else
      #include <stdint.h>
      #endif
    ++#ifdef HAVE_ARC4RANDOM_LIBBSD
    ++#include <bsd/stdlib.h>
    ++#endif
     +#ifdef HAVE_GETRANDOM
     +#include <sys/random.h>
     +#endif
    @@ t/helper/test-csprng.c (new)
     +#include "test-tool.h"
     +#include "git-compat-util.h"
     +
    -+/*
    -+ * Check that we read each byte value at least once when reading 64 KiB from the
    -+ * CSPRNG.  This is not to test the quality of the CSPRNG, but to test our
    -+ * buffer handling of it.
    -+ *
    -+ * The probability of this failing by random is less than 10^-100.
    -+ */
    -+static int selftest(void)
    -+{
    -+	int buckets[256] = { 0 };
    -+	unsigned char buf[1024];
    -+	unsigned long count = 64 * 1024;
    -+	int i;
    -+
    -+	while (count) {
    -+		if (csprng_bytes(buf, sizeof(buf)) < 0) {
    -+			perror("failed to read");
    -+			return 3;
    -+		}
    -+		for (i = 0; i < sizeof(buf); i++)
    -+			buckets[buf[i]]++;
    -+		count -= sizeof(buf);
    -+	}
    -+	for (i = 0; i < ARRAY_SIZE(buckets); i++)
    -+		if (!buckets[i]) {
    -+			fprintf(stderr, "failed to find any bytes with value %02x\n", i);
    -+			return 4;
    -+		}
    -+	return 0;
    -+}
     +
     +int cmd__csprng(int argc, const char **argv)
     +{
    @@ t/helper/test-csprng.c (new)
     +	unsigned char buf[1024];
     +
     +	if (argc > 2) {
    -+		fprintf(stderr, "usage: %s [--selftest | <size>]\n", argv[0]);
    ++		fprintf(stderr, "usage: %s [<size>]\n", argv[0]);
     +		return 2;
     +	}
     +
    -+	if (!strcmp(argv[1], "--selftest")) {
    -+		return selftest();
    -+	}
    -+
     +	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : -1L;
     +
     +	while (count) {
    @@ t/helper/test-tool.h: int cmd__bloom(int argc, const char **argv);
      int cmd__date(int argc, const char **argv);
      int cmd__delta(int argc, const char **argv);
     
    - ## t/t0000-basic.sh ##
    -@@ t/t0000-basic.sh: test_expect_success 'test_must_fail rejects a non-git command with env' '
    - 	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
    - '
    - 
    -+test_expect_success 'CSPRNG handling functions correctly' '
    -+	test-tool csprng --selftest
    -+'
    -+
    - test_done
    -
      ## wrapper.c ##
     @@ wrapper.c: int open_nofollow(const char *path, int flags)
      	return open(path, flags);
    @@ wrapper.c: int open_nofollow(const char *path, int flags)
     +
     +int csprng_bytes(void *buf, size_t len)
     +{
    -+#if defined(HAVE_ARC4RANDOM)
    ++#if defined(HAVE_ARC4RANDOM) || defined(HAVE_ARC4RANDOM_LIBBSD)
    ++	/* This function never returns an error. */
     +	arc4random_buf(buf, len);
     +	return 0;
     +#elif defined(HAVE_GETRANDOM)
    @@ wrapper.c: int open_nofollow(const char *path, int flags)
     +	if (!RtlGenRandom(buf, len))
     +		return -1;
     +	return 0;
    ++#elif defined(HAVE_OPENSSL_CSPRNG)
    ++	int res = RAND_bytes(buf, len);
    ++	if (res == 1)
    ++		return 0;
    ++	if (res == -1)
    ++		errno = ENOTSUP;
    ++	else
    ++		errno = EIO;
    ++	return -1;
     +#else
     +	ssize_t res;
     +	char *p = buf;
2:  f7212e0dce ! 2:  b4cd8700e3 wrapper: use a CSPRNG to generate random file names
    @@ Commit message
         Unfortunately, this is not the best idea from a security perspective.
         If we're writing into TMPDIR, an attacker can guess these values easily
         and prevent us from creating any temporary files at all by creating them
    -    all first.  POSIX only requires TMP_MAX to be 25, so this is achievable
    +    all first.  Even though we set TMP_MAX to 16384, this may be achievable
         in some contexts, even if unlikely to occur in practice.
     
         Fortunately, we can simply solve this by using the system
    @@ wrapper.c: int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
      		int i;
     +		uint64_t v;
     +		if (csprng_bytes(&v, sizeof(v)) < 0)
    -+			return -1;
    ++			return error_errno("unable to get random bytes for temporary file");
     +
      		/* Fill in the random bits. */
      		for (i = 0; i < num_x; i++) {
