Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF58285060
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698789; cv=none; b=ayitnWIhZbMk5j73Pt5dCJMPc6wUpe3Evgc/scPKELxi3eAoPS8aHWvW1u6oSQJhrLhuRknmXkWC6P3KxjVEv3cuyRZt+O99n+vmn/xusgcuEBAhcfcuATLGFTachOlBA5KZz/mh40PZlgPRw3mQSq45WitBmgmcnVcVU8Xym6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698789; c=relaxed/simple;
	bh=8ui9AKCzu2jCX0zjgKI7V/HLISfeSr2g9hM9XWJrQXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAPXEIDcJFq7poslS2VFmJyrxTzYlFh96PY+BLb5WNz804FG22QZCSuCin/dv+N+pJkZ9xDKh0hKHuzBY+GgHe1IZIDHC6T8gL8KUZChNXw71CzLwYrdxMY0xciEJ1yj4yEuNC9Uk6EWOIpkLBfbL2u6Zjb9g05q5Qi1IAJCcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chungminlee.com; spf=pass smtp.mailfrom=chungminlee.com; dkim=pass (2048-bit key) header.d=chungminlee.com header.i=@chungminlee.com header.b=1DfU1Jqr; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chungminlee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chungminlee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chungminlee.com header.i=@chungminlee.com header.b="1DfU1Jqr"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4h4jY84RyMz7t9W;
	Wed, 22 Jul 2026 07:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chungminlee.com;
	s=MBO0001; t=1784698300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n3IHrIkVsSNvgUnn+8wXtjXJHeaXhluYE+e0l/lQYKM=;
	b=1DfU1Jqr7OnRfh90ZLzhwsyIFvJPpKfySFg+AeOltbZWmTfQKBP7IuXwg4bHEOndUhlQpX
	NGTHrb5yEhaFxIuVt/ol4R9NEJhdOL9Sf+5lt0fvExoZQ/uJRPG3mhkdY98L0xndHzDpbQ
	fQlnS6kwpbKM+FtWomTXoEwZLwd+qGYVUexj4w4e70m/UoZZZsGHjWR3vzRGsBQhlUfOnt
	bqNbxlNfDi/Dj2M9q64qiIpQzCvSJMpSj2hlZlbmAyVw67Cerl8Ughb6Dfj2jBW9LEwpUK
	yh3rtVEKTCnEsK7zmOeEzBN1tVCFzzOFyzAf4g1/lMIdlJ0yPRpZUQlTJM9oVw==
From: Chungmin Lee <chungmin@chungminlee.com>
To: git@vger.kernel.org
Cc: Chungmin Lee <chungmin@chungminlee.com>
Subject: [PATCH] regexec: work around macOS TRE memory leak on invalid UTF-8
Date: Tue, 21 Jul 2026 22:31:27 -0700
Message-ID: <20260722053127.37244-1-chungmin@chungminlee.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On macOS the system regex engine (TRE) leaks the buffer it allocates for
a match (in tre_tnfa_run_parallel()) whenever regexec() encounters an
invalid multibyte sequence in a UTF-8 locale: it returns REG_ILLSEQ
without freeing that buffer.  Because regexec_buf() is called once per
line, grepping a file that mixes text with binary data (for example a PDF
checked into a repository) leaks a buffer per line.  The leaked buffer is
sized in proportion to the line length and the pattern's automaton, so a
large case-insensitive alternation over long binary lines can leak
gigabytes in a single command; this has been observed to exhaust memory
and trigger a kernel watchdog panic on the machine running "git grep".

A line that contains an invalid multibyte sequence can still contain
real matches: when a match lies on either side of the invalid bytes, TRE
finds it, returns REG_OK, and frees the buffer normally.  So the fix
cannot simply reject or truncate such a line -- that would silently drop
matches the platform engine itself would report.  Nor can it search the
whole line first and fall back to segmentation only on REG_ILLSEQ: by the
time regexec() returns REG_ILLSEQ it has already leaked, so the fallback
cannot prevent it.

Add a Darwin-only regexec_buf() (compat/regexec.c) that never hands the
platform matcher an invalid byte.  It walks the buffer, splits it at each
invalid sequence, and searches each maximal run of valid text between
them, returning the first match.  Each segment is searched with
REG_STARTEND (whose offsets are relative to the buffer, so no translation
is needed) and with REG_NOTBOL / REG_NOTEOL suppressed only when the
segment does not reach the true start or end of the buffer, so "^" and
"$" keep matching exactly where they would on the whole line.  The split
points are chosen with mbrtowc(), so the buffer is cut at exactly the
bytes the platform's own decoder -- and therefore TRE, which decodes the
same way -- rejects.

The split runs only where a byte can be invalid.  In a single-byte
locale (MB_CUR_MAX == 1) nothing is invalid, so the whole buffer is
searched as before and behavior is unchanged.  The leak is not specific
to UTF-8 -- any multibyte locale drives TRE through the same REG_ILLSEQ
path -- so the guard keys on MB_CUR_MAX rather than the codeset name,
which is also simpler.  MB_CUR_MAX reflects the LC_CTYPE the C library
installed, the same locale mbrtowc() decodes against.

regexec_buf() backs every regex caller, so this affects "git grep",
diffcore-pickaxe (-G/-S --pickaxe-regex) and diff word splitting alike.
The fix does not reproduce the platform's exact output on lines with
invalid bytes -- doing so would mean deliberately hiding matches that are
really there.  No match the platform engine reported before is lost, and
every match reported now is a genuine one: each segment is searched as
valid text at its real offset, so nothing spurious is introduced.
Unanchored matches -- which the engine already found, even next to
invalid bytes -- are unchanged.  The only additional matches are
zero-width ones at a true line boundary next to invalid bytes: a "^",
"$", or word boundary that holds there now matches, where the engine used
to hit the invalid byte, return REG_ILLSEQ, and report nothing even
though the match is genuine.

The workaround is compiled in only when the platform's own regex engine
is used, across the Makefile, Meson and CMake builds: it is skipped
whenever the bundled engine (which has no REG_ILLSEQ and does not leak)
is selected by NO_REGEX -- as it is under AddressSanitizer in the
Makefile and Meson builds.  compat/regexec.c guards its body on the same
macro, so a build that does not enable the workaround compiles it to
nothing rather than colliding with the inline regexec_buf().  The
workaround avoids the leaking path rather than depending on it, so it
stays correct if the platform is fixed and can be dropped once a macOS
without the leak is the minimum supported baseline.

A regression test cannot bound a process's memory portably -- setrlimit
RLIMIT_AS is not enforced on macOS -- so t7810 checks the observable
behavior instead: valid text matches on both sides of an invalid byte
and in a run between two invalid sequences, and "^" and "$" do not match
across an invalid byte in mid-line.  A further check, guarded by the
MACOS prerequisite because only macOS runs this code, confirms that "^"
and "$" match at the true start and end of such a line.  (A line that is
entirely invalid bytes still does not match an unanchored empty-width
pattern such as "^", as before.)

Signed-off-by: Chungmin Lee <chungmin@chungminlee.com>
---
This came out of a real incident: "git grep -i" over a repository that
contains PDFs exhausted memory on an otherwise idle Mac mini and took the
machine down with a kernel watchdog panic ("no checkins from watchdogd").
The leak is in the system regex engine, not in git, but git is what
drives it into the leaking path, once per line.

Why this belongs in regexec_buf():

  - regexec_buf() already exists as the place to wrap platform regexec()
    quirks.  It was added in v2.11.0 (backported to v2.10.1) for exactly
    this kind of reason -- "a regexec_buf() helper that takes a <ptr,len>
    pair with REG_STARTEND extension" (RelNotes/2.11.0).

  - git already treats REG_ILLSEQ on invalid UTF-8 as a cross-platform
    reality -- "As FreeBSD is not the only platform whose regexp library
    reports a REG_ILLSEQ error when fed invalid UTF-8..."
    (RelNotes/2.28.0).  This patch keeps returning the matches around the
    invalid bytes, and just stops leaking on the way there.

On the behavior change: the fix does not reproduce the platform engine's
exact output on a line with invalid bytes, because that output is "leak,
then report nothing".  It never drops a match the engine reported before
and never invents a spurious one; the only additional matches are
zero-width assertions at a true line boundary next to the invalid bytes
(the log describes the exact envelope).

Reproducing (macOS, UTF-8 locale):

    perl -e 'print "\377" x 16, "\n" for 1..300000' >binfile
    git init -q r && mv binfile r && git -C r add binfile &&
        git -C r commit -qm x
    P='aa|bb|cc|dd|ee|ff|gg|hh|ii|jj|kk|ll|mm|nn|oo|pp|qq|rr|ss|tt'
    /usr/bin/time -l git -C r grep -i -E "$P" >/dev/null

  Max RSS on this machine (grep is multithreaded, so the stock figure
  varies run to run):
    stock  git 2.50.1 (Apple):  ~1-2 GiB
    patched:                    ~13 MiB
  The gap grows without bound with the number of invalid-byte lines and
  the size of the pattern's automaton; the original incident is believed
  to have reached tens of GiB before the watchdog panic.

I also have a standalone, self-verifying reproducer that measures the
heap directly (malloc_zone_statistics(), no external tools); it reports
~3072 bytes leaked per REG_ILLSEQ call, allocated in
tre_tnfa_run_parallel() (confirmed with MallocStackLogging + leaks(1)).
I can post it, and I have prepared it to file with Apple as well.

Environment:
    macOS 26.5 (build 25F71), Darwin 25.5.0 arm64, Apple M4
    Apple clang 21.0.0; /usr/bin/git 2.50.1 (Apple Git-155)

Tested: t7810 passes (268/268), including the invalid-byte cases added
here.  (t7812 exits clean but its cases are all skipped on this machine
for lack of a suitable GETTEXT_LOCALE; it exercises the system-regex path
on platforms that have one.)  Built with the platform regex engine on
macOS; NO_REGEX builds, and Makefile/Meson ASAN builds, use the bundled
engine and skip the workaround.

 Makefile                            |   4 ++
 compat/regexec.c                    | 108 ++++++++++++++++++++++++++++
 config.mak.uname                    |   1 +
 contrib/buildsystems/CMakeLists.txt |   5 ++
 git-compat-util.h                   |   5 ++
 meson.build                         |   7 ++
 t/t7810-grep.sh                     |  28 ++++++++
 7 files changed, 158 insertions(+)
 create mode 100644 compat/regexec.c

diff --git a/Makefile b/Makefile
index 1cec251f4..b568dde52 100644
--- a/Makefile
+++ b/Makefile
@@ -2264,6 +2264,10 @@ ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 	COMPAT_CFLAGS += -DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 	COMPAT_OBJS += compat/regcomp_enhanced.o
 endif
+ifdef DARWIN_TRE_REGEXEC_LEAK_WORKAROUND
+	COMPAT_OBJS += compat/regexec.o
+	BASIC_CFLAGS += -DREGEXEC_MAY_LEAK_ON_ILLSEQ
+endif
 endif
 ifdef NATIVE_CRLF
 	BASIC_CFLAGS += -DNATIVE_CRLF
diff --git a/compat/regexec.c b/compat/regexec.c
new file mode 100644
index 000000000..0677162a8
--- /dev/null
+++ b/compat/regexec.c
@@ -0,0 +1,108 @@
+#include "git-compat-util.h"
+
+#ifdef REGEXEC_MAY_LEAK_ON_ILLSEQ
+
+#include <wchar.h>
+
+/*
+ * macOS's libc regex engine (TRE) leaks the buffer it allocates for a
+ * match whenever regexec() encounters an invalid multibyte sequence in
+ * a multibyte locale: it returns REG_ILLSEQ without freeing that buffer.
+ * A single "git grep" over a file with binary data can call regexec()
+ * once per line and leak gigabytes, which has been observed to exhaust
+ * memory and trigger a kernel watchdog panic.
+ *
+ * The leak happens inside regexec() before it returns, so reacting to
+ * REG_ILLSEQ cannot avoid it: the invalid bytes must never reach the
+ * matcher.  Split the buffer at each invalid sequence and search the
+ * surrounding runs of valid text separately.  A match on either side of
+ * the invalid bytes is still found (the same result the matcher gives on
+ * valid input), but the leaking REG_ILLSEQ path is never reached.
+ *
+ * Use mbrtowc() to decide where to split, so that we split at exactly the
+ * bytes the platform's own decoder -- and thus the regex engine, which
+ * decodes the same way -- rejects.  A hand-rolled validator would
+ * have to guess that boundary; being too lenient reintroduces the leak.
+ */
+
+/*
+ * Search buf[start, end) for a match.  REG_STARTEND reports offsets
+ * relative to buf, so a hit needs no translation.  ^ may only match at
+ * the real start of the buffer and $ only at its real end, so suppress
+ * them when this segment does not reach those boundaries.
+ */
+static int regexec_segment(const regex_t *preg, const char *buf,
+			   size_t start, size_t end, size_t size,
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
+int regexec_buf(const regex_t *preg, const char *buf, size_t size,
+		size_t nmatch, regmatch_t pmatch[], int eflags)
+{
+	size_t seg_start = 0, i = 0;
+	mbstate_t mbs;
+
+	assert(nmatch > 0 && pmatch);
+
+	/*
+	 * Only a multibyte locale drives TRE through the leaking multibyte
+	 * path.  In a single-byte locale (MB_CUR_MAX == 1) no byte is
+	 * invalid, so search the whole buffer as before.  MB_CUR_MAX
+	 * reflects the current LC_CTYPE, the same locale mbrtowc() below
+	 * decodes against.
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
+		if (c < 0x80) {		/* ASCII fast path */
+			i++;
+			continue;
+		}
+
+		n = mbrtowc(NULL, buf + i, size - i, &mbs);
+		if (!n)			/* embedded NUL decodes to one byte */
+			n = 1;
+		if (n != (size_t)-1 && n != (size_t)-2) {
+			i += n;
+			continue;
+		}
+
+		/* buf[i] begins an invalid sequence; search the run before it */
+		if (i > seg_start) {
+			int ret = regexec_segment(preg, buf, seg_start, i, size,
+						  nmatch, pmatch, eflags);
+			if (ret != REG_NOMATCH)
+				return ret;
+		}
+		i++;			/* skip the invalid byte and resync */
+		seg_start = i;
+		memset(&mbs, 0, sizeof(mbs));
+	}
+
+	/*
+	 * Search the final run.  Do this even when it is empty (a line that
+	 * ends in invalid bytes, or an empty buffer) so that "$" and
+	 * empty-matching patterns still match at the true end of the buffer.
+	 */
+	return regexec_segment(preg, buf, seg_start, size, size,
+			       nmatch, pmatch, eflags);
+}
+
+#endif /* REGEXEC_MAY_LEAK_ON_ILLSEQ */
diff --git a/config.mak.uname b/config.mak.uname
index 9ebd24037..2402a2449 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -154,6 +154,7 @@ ifeq ($(uname_S),Darwin)
 	HAVE_DEV_TTY = YesPlease
 	COMPAT_OBJS += compat/precompose_utf8.o
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
+	DARWIN_TRE_REGEXEC_LEAK_WORKAROUND = YesPlease
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a57c4b464..5cfb48f78 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -519,6 +519,11 @@ if(NOT HAVE_REGEX)
 	include_directories(${CMAKE_SOURCE_DIR}/compat/regex)
 	list(APPEND compat_SOURCES compat/regex/regex.c )
 	add_compile_definitions(NO_REGEX NO_MBSUPPORT GAWK)
+elseif(APPLE)
+	# macOS's system regex engine (TRE) leaks memory when regexec()
+	# hits invalid UTF-8; work around it via compat/regexec.c.
+	list(APPEND compat_SOURCES compat/regexec.c)
+	add_compile_definitions(REGEXEC_MAY_LEAK_ON_ILLSEQ)
 endif()
 
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 880977640..3861c9353 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -992,6 +992,10 @@ static inline int strtol_i(char const *s, int base, int *result)
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
 
+#ifdef REGEXEC_MAY_LEAK_ON_ILLSEQ
+int regexec_buf(const regex_t *preg, const char *buf, size_t size,
+		size_t nmatch, regmatch_t pmatch[], int eflags);
+#else
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
index 3247697f7..2ce37b607 100644
--- a/meson.build
+++ b/meson.build
@@ -1387,6 +1387,13 @@ if not get_option('b_sanitize').contains('address') and get_option('regex').allo
     libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
     compat_sources += 'compat/regcomp_enhanced.c'
   endif
+
+  # macOS's system regex engine (TRE) leaks memory when regexec()
+  # hits invalid UTF-8; work around it via compat/regexec.c.
+  if host_machine.system() == 'darwin'
+    libgit_c_args += '-DREGEXEC_MAY_LEAK_ON_ILLSEQ'
+    compat_sources += 'compat/regexec.c'
+  endif
 elif not get_option('regex').enabled()
   libgit_c_args += [
     '-DNO_REGEX',
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index d61c4a4d7..b325a2e11 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -89,6 +89,8 @@ test_expect_success setup '
 	function dummy() {}
 	EOF
 	printf "\200\nASCII\n" >invalid-utf8 &&
+	printf "before\346world\n" >invalid-utf8-embedded &&
+	printf "a\346b\347c\n" >invalid-utf8-multi &&
 	if test_have_prereq FUNNYNAMES
 	then
 		echo unusual >"\"unusual\" pathname" &&
@@ -595,6 +597,32 @@ test_expect_success MB_REGEX 'grep two chars in single-char multibyte file' '
 	LC_ALL=en_US.UTF-8 test_expect_code 1 git grep ".." reverse-question-mark
 '
 
+test_expect_success MB_REGEX 'grep matches valid text on both sides of invalid UTF-8' '
+	LC_ALL=en_US.UTF-8 git grep -h before invalid-utf8-embedded >actual &&
+	test_cmp invalid-utf8-embedded actual &&
+	LC_ALL=en_US.UTF-8 git grep -h world invalid-utf8-embedded >actual &&
+	test_cmp invalid-utf8-embedded actual
+'
+
+test_expect_success MB_REGEX 'grep matches a run between two invalid sequences' '
+	LC_ALL=en_US.UTF-8 git grep -h b invalid-utf8-multi >actual &&
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
+	test_cmp invalid-utf8-embedded actual
+'
+
 cat >expected <<EOF
 file
 EOF

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0

