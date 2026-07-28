Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C73A783F
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216369; cv=none; b=Q1XJZNe1CtZl/UoArkZLQ3fVJUFvPMkgmP0xWiOGcoip/T7sTtGzl7Zce2Ivxmj+Ev4OlxNO8ix58+6rWNp1W53rNU3ck+O99MFyKUxOAjiopAKagQ+MBk3b6emLlaPf1AY+f+XEdF4r6YTZXosm+PDY3YdTsdRp6UYq8eXkAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216369; c=relaxed/simple;
	bh=Ni4JTnegglPOes5tpCLYWu4xQJ37/hAHDhZZCYIHDkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTpeDs8bjHv+XYx/PKCh2XvKYDRlIa2wNad+uxIQqPZS+IGnOuy5hOzl6wY5K8X8vvMTpzLQ/eeZtkXeCKd7zW6HRf+9G5rGONTj51IijiVD8qE6JfCqEZxPMYjXXFR8l2EJnQ4zfGY4lKfFpQJaMOSiZPTwQa9bMlsq4uzXSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chungminlee.com; spf=pass smtp.mailfrom=chungminlee.com; dkim=pass (2048-bit key) header.d=chungminlee.com header.i=@chungminlee.com header.b=MQOOdEpv; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chungminlee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chungminlee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chungminlee.com header.i=@chungminlee.com header.b="MQOOdEpv"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4h8P7l4DMFzMlwt;
	Tue, 28 Jul 2026 07:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chungminlee.com;
	s=MBO0001; t=1785216355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc+iQSjrEaIRY5gv60qroUs6daOrp929+PVzyF5UpA8=;
	b=MQOOdEpvcT2oFEMtZtrexPu4JXgHZl2ZS2RONIixDXnQmzTzQgeaE3irZ9A0XE2JsbRjKd
	hEBFJNWzL3K8bJ5OoNS0SADEz2IE5tEwYxPB3AoBigD8GxqkYXZ6mllqYueP0lLdozDAx6
	Q8strxypy/JsdZyQSuHnyALYdl/MTUjcQr06KRhyFbmzwTXdAxiEZoxZStas2wdGFzdSHS
	aR3Jz+vhSYZvZfccvI3DShHEQ4Q/qMRciClqjcLUJGF7lKVNfeEXBxxrgYEoVJAyIMbrb+
	URaUym1JlDP0Ehisc9LtZD1wYMA4TN+QwYz6zRtRQhms3oJDbcjyRn4X4p4tQA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of chungmin@chungminlee.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=chungmin@chungminlee.com
From: Chungmin Lee <chungmin@chungminlee.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Chungmin Lee <chungmin@chungminlee.com>
Subject: [PATCH v2] regexec: work around macOS TRE leak on invalid UTF-8
Date: Mon, 27 Jul 2026 22:25:38 -0700
Message-ID: <20260728052538.12429-1-chungmin@chungminlee.com>
In-Reply-To: <20260722053127.37244-1-chungmin@chungminlee.com>
References: <20260722053127.37244-1-chungmin@chungminlee.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4h8P7l4DMFzMlwt

On macOS, the system regex engine leaks an internal buffer when
regexec() encounters an invalid multibyte sequence in a UTF-8 locale.
The line-by-line path can call regexec_buf() for each pattern on every
line, so "git grep" can leak repeatedly on a file containing invalid
UTF-8.  The total leak grows with the number of calls, and the per-call
allocation grows with the pattern's automaton.  In one case, grepping a
repository containing PDFs exhausted memory and caused the machine to
restart.

ce025ae4f61e (grep: disable lookahead on error, 2024-10-20) made "git
grep" fall back to line-by-line matching when regexec() reports an error
on invalid UTF-8.  That fallback cannot prevent this leak: the allocation
has already leaked when regexec() returns REG_ILLSEQ.

Avoid the leaking path by providing a Darwin-specific regexec_buf().
Walk the input with mbrtowc(), split it at bytes that cannot form a
complete multibyte character, and search each valid segment separately.
This preserves matches in valid text on either side of an invalid byte.

Search each segment with REG_STARTEND so match offsets remain relative to
the original buffer.  Set REG_NOTBOL and REG_NOTEOL for internal segment
boundaries so "^" and "$" do not match there.  Keep the flags clear at
the true beginning and end of the buffer.

Use the normal regexec_buf() path in single-byte locales, where no byte
can form an invalid multibyte sequence.  Use the bundled regex
implementation unchanged when NO_REGEX is enabled.

Declare the Darwin override in compat/darwin.h and map regexec_buf() to
darwin_regexec_buf().  This follows the platform override pattern used
by the other compatibility headers and leaves the common inline
implementation as the default.

There is no reliable way to detect a future macOS version in which the
system regex implementation has been fixed.  Even after a fix, Git will
need the workaround while it supports affected macOS releases, so treat
it as an indefinite compatibility workaround.

Add tests for matches before, after, and between invalid bytes, including
an offset check after an invalid byte.  Also check incomplete trailing
input and anchors at true and internal line boundaries.

Signed-off-by: Chungmin Lee <chungmin@chungminlee.com>
---
Changes since v1:

  - Cite ce025ae4f61e, which handles the same macOS regexec() error.
  - Treat the workaround as indefinite instead of assuming a known
    removal point.
  - Document the -1 and -2 returns from mbrtowc().
  - Use one DARWIN_REGEXEC name in all build systems.
  - Move the implementation under compat/darwin/ and use a platform
    header to override regexec_buf().
  - Add coverage for offsets, incomplete sequences, and internal
    boundaries.
  - Use POSIX regex patterns in the tests so they exercise regexec_buf()
    rather than the fixed-string optimization.
  - Keep positive invalid-UTF-8 matching tests macOS-only because system
    regex implementations differ in how they handle invalid multibyte
    input.  Run the no-false-anchor test on every MB_REGEX platform.

Reproduction on macOS in a UTF-8 locale:

    perl -e 'print "\377" x 16, "\n" for 1..300000' >binfile
    git init -q r &&
    mv binfile r &&
    git -C r add binfile &&
    git -C r commit -qm x
    P='aa|bb|cc|dd|ee|ff|gg|hh|ii|jj|kk|ll|mm|nn|oo|pp|qq|rr|ss|tt'
    /usr/bin/time -l git -C r grep -i -E "$P" >/dev/null

On the machine used to reproduce the problem, stock Apple Git 2.50.1
reached roughly 1--2 GiB maximum RSS.  The patched build used roughly
13 MiB.  The difference grows with the number of invalid-byte lines and
the size of the pattern.

The leak was also reproduced in a standalone test using
malloc_zone_statistics().  It reported about 3072 bytes leaked per
REG_ILLSEQ call from tre_tnfa_run_parallel().

Tested with the native macOS regex engine and with NO_REGEX:

    make
    make test T=t7810-grep.sh
    make clean
    make NO_REGEX=YesPlease
    make test T=t7810-grep.sh NO_REGEX=YesPlease

 Makefile                            |  4 ++
 compat/darwin.h                     |  8 +++
 compat/darwin/regexec.c             | 91 +++++++++++++++++++++++++++++
 config.mak.uname                    |  1 +
 contrib/buildsystems/CMakeLists.txt |  3 +
 git-compat-util.h                   |  5 ++
 meson.build                         |  5 ++
 t/t7810-grep.sh                     | 37 ++++++++++++
 8 files changed, 154 insertions(+)
 create mode 100644 compat/darwin.h
 create mode 100644 compat/darwin/regexec.c

diff --git a/Makefile b/Makefile
index 1cec251..81075c3 100644
--- a/Makefile
+++ b/Makefile
@@ -2264,6 +2264,10 @@ ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 	COMPAT_CFLAGS += -DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 	COMPAT_OBJS += compat/regcomp_enhanced.o
 endif
+ifdef DARWIN_REGEXEC
+	COMPAT_OBJS += compat/darwin/regexec.o
+	BASIC_CFLAGS += -DDARWIN_REGEXEC
+endif
 endif
 ifdef NATIVE_CRLF
 	BASIC_CFLAGS += -DNATIVE_CRLF
diff --git a/compat/darwin.h b/compat/darwin.h
new file mode 100644
index 0000000..6fbdc34
--- /dev/null
+++ b/compat/darwin.h
@@ -0,0 +1,8 @@
+#ifndef COMPAT_DARWIN_H
+#define COMPAT_DARWIN_H
+
+int darwin_regexec_buf(const regex_t *preg, const char *buf, size_t size,
+		       size_t nmatch, regmatch_t pmatch[], int eflags);
+#define regexec_buf darwin_regexec_buf
+
+#endif
diff --git a/compat/darwin/regexec.c b/compat/darwin/regexec.c
new file mode 100644
index 0000000..13fb7d5
--- /dev/null
+++ b/compat/darwin/regexec.c
@@ -0,0 +1,91 @@
+#include "git-compat-util.h"
+
+#include <wchar.h>
+
+/*
+ * Darwin's TRE regex engine leaks an internal buffer when it encounters an
+ * invalid multibyte sequence.  Since the leak has already happened when
+ * regexec() reports REG_ILLSEQ, keep invalid bytes out of regexec() by
+ * searching each valid segment separately.
+ */
+
+/*
+ * Search buf[start, end), where size is the full size of buf.  REG_STARTEND
+ * keeps match offsets relative to buf.  Do not let an internal segment create
+ * a false beginning or end of line.
+ */
+static int regexec_segment(const regex_t *preg, const char *buf,
+			   size_t size, size_t start, size_t end,
+			   size_t nmatch, regmatch_t pmatch[], int eflags)
+{
+	eflags |= REG_STARTEND;
+	if (start > 0)
+		eflags |= REG_NOTBOL;
+	if (end < size)
+		eflags |= REG_NOTEOL;
+	pmatch[0].rm_so = start;
+	pmatch[0].rm_eo = end;
+	return regexec(preg, buf, nmatch, pmatch, eflags);
+}
+
+int darwin_regexec_buf(const regex_t *preg, const char *buf, size_t size,
+		       size_t nmatch, regmatch_t pmatch[], int eflags)
+{
+	size_t seg_start = 0, i = 0;
+	mbstate_t mbs;
+
+	assert(nmatch > 0 && pmatch);
+
+	/*
+	 * A single-byte locale cannot contain an invalid multibyte sequence,
+	 * so use regexec() directly.
+	 */
+	if (MB_CUR_MAX == 1) {
+		pmatch[0].rm_so = 0;
+		pmatch[0].rm_eo = size;
+		return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
+	}
+
+	memset(&mbs, 0, sizeof(mbs));
+	while (i < size) {
+		unsigned char c = (unsigned char)buf[i];
+		size_t n;
+
+		if (c < 0x80) {
+			i++;
+			continue;
+		}
+
+		n = mbrtowc(NULL, buf + i, size - i, &mbs);
+		if (!n)
+			n = 1;
+		if (n != (size_t)-1 && n != (size_t)-2) {
+			i += n;
+			continue;
+		}
+
+		/*
+		 * -1 denotes an encoding error; -2 denotes an incomplete
+		 * trailing sequence.  In either case, buf[i] cannot begin a
+		 * complete valid character within this buffer.  Search an
+		 * empty initial segment to preserve zero-width matches at the
+		 * true beginning.
+		 */
+		if (i > seg_start || i == 0) {
+			int ret = regexec_segment(preg, buf, size, seg_start, i,
+						  nmatch, pmatch, eflags);
+			if (ret != REG_NOMATCH)
+				return ret;
+		}
+		i++;
+		seg_start = i;
+		memset(&mbs, 0, sizeof(mbs));
+	}
+
+	/*
+	 * Search the final segment even when it is empty, so an empty buffer
+	 * or a buffer ending in invalid bytes still has its true end.
+	 */
+	return regexec_segment(preg, buf, size, seg_start, size,
+			       nmatch, pmatch, eflags);
+}
diff --git a/config.mak.uname b/config.mak.uname
index 9ebd240..4660ff3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -154,6 +154,7 @@ ifeq ($(uname_S),Darwin)
 	HAVE_DEV_TTY = YesPlease
 	COMPAT_OBJS += compat/precompose_utf8.o
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
+	DARWIN_REGEXEC = YesPlease
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a57c4b4..83e8b71 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -519,6 +519,9 @@ if(NOT HAVE_REGEX)
 	include_directories(${CMAKE_SOURCE_DIR}/compat/regex)
 	list(APPEND compat_SOURCES compat/regex/regex.c )
 	add_compile_definitions(NO_REGEX NO_MBSUPPORT GAWK)
+elseif(APPLE)
+	list(APPEND compat_SOURCES compat/darwin/regexec.c)
+	add_compile_definitions(DARWIN_REGEXEC)
 endif()
 
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 8809776..96995c6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -162,6 +162,9 @@ static inline int is_xplatform_dir_sep(int c)
 #include "compat/win32/path-utils.h"
 #include "compat/msvc.h"
 #endif
+#ifdef DARWIN_REGEXEC
+#include "compat/darwin.h"
+#endif
 
 /* used on Mac OS X */
 #ifdef PRECOMPOSE_UNICODE
@@ -992,6 +995,7 @@ static inline int strtol_i(char const *s, int base, int *result)
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
 
+#ifndef regexec_buf
 static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 			      size_t nmatch, regmatch_t pmatch[], int eflags)
 {
@@ -1000,6 +1004,7 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 	pmatch[0].rm_eo = size;
 	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
 }
+#endif
 
 #ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 int git_regcomp(regex_t *preg, const char *pattern, int cflags);
diff --git a/meson.build b/meson.build
index 3247697..53c4816 100644
--- a/meson.build
+++ b/meson.build
@@ -1387,6 +1387,11 @@ if not get_option('b_sanitize').contains('address') and get_option('regex').allo
     libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
     compat_sources += 'compat/regcomp_enhanced.c'
   endif
+
+  if host_machine.system() == 'darwin'
+    libgit_c_args += '-DDARWIN_REGEXEC'
+    compat_sources += 'compat/darwin/regexec.c'
+  endif
 elif not get_option('regex').enabled()
   libgit_c_args += [
     '-DNO_REGEX',
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index d61c4a4..149654e 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -89,6 +89,10 @@ test_expect_success setup '
 	function dummy() {}
 	EOF
 	printf "\200\nASCII\n" >invalid-utf8 &&
+	printf "before\346world\n" >invalid-utf8-embedded &&
+	printf "a\346b\347c\n" >invalid-utf8-multi &&
+	printf "\346world\n" >invalid-utf8-leading &&
+	printf "before\346\n" >invalid-utf8-trailing &&
 	if test_have_prereq FUNNYNAMES
 	then
 		echo unusual >"\"unusual\" pathname" &&
@@ -595,6 +599,39 @@ test_expect_success MB_REGEX 'grep two chars in single-char multibyte file' '
 	LC_ALL=en_US.UTF-8 test_expect_code 1 git grep ".." reverse-question-mark
 '
 
+test_expect_success MACOS,MB_REGEX 'grep matches valid text on both sides of invalid UTF-8' '
+	LC_ALL=en_US.UTF-8 git grep -h "befo[r]e" invalid-utf8-embedded >actual &&
+	test_cmp invalid-utf8-embedded actual &&
+	LC_ALL=en_US.UTF-8 git grep -h "worl[d]" invalid-utf8-embedded >actual &&
+	test_cmp invalid-utf8-embedded actual &&
+	LC_ALL=en_US.UTF-8 git grep -h -o "worl[d]" invalid-utf8-embedded >actual &&
+	echo world >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success MACOS,MB_REGEX 'grep matches a run between two invalid sequences' '
+	LC_ALL=en_US.UTF-8 git grep -h "[b]" invalid-utf8-multi >actual &&
+	test_cmp invalid-utf8-multi actual
+'
+
+test_expect_success MB_REGEX 'grep does not anchor ^ or $ inside an invalid-byte line' '
+	test_expect_code 1 env LC_ALL=en_US.UTF-8 \
+		git grep -h "^world" invalid-utf8-embedded &&
+	test_expect_code 1 env LC_ALL=en_US.UTF-8 \
+		git grep -h "before\$" invalid-utf8-embedded
+'
+
+test_expect_success MACOS,MB_REGEX 'grep anchors ^ and $ at true line ends past invalid UTF-8' '
+	LC_ALL=en_US.UTF-8 git grep -h "^before" invalid-utf8-embedded >actual &&
+	test_cmp invalid-utf8-embedded actual &&
+	LC_ALL=en_US.UTF-8 git grep -h "world\$" invalid-utf8-embedded >actual &&
+	test_cmp invalid-utf8-embedded actual &&
+	LC_ALL=en_US.UTF-8 git grep -h "^" invalid-utf8-leading >actual &&
+	test_cmp invalid-utf8-leading actual &&
+	LC_ALL=en_US.UTF-8 git grep -h "\$" invalid-utf8-trailing >actual &&
+	test_cmp invalid-utf8-trailing actual
+'
+
 cat >expected <<EOF
 file
 EOF

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0
