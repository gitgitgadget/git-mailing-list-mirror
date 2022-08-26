Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FE5ECAAD2
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 08:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245501AbiHZI6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 04:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245273AbiHZI6l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 04:58:41 -0400
X-Greylist: delayed 88515 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 01:58:39 PDT
Received: from balab.aueb.gr (balab.aueb.gr [83.212.173.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34C1D61B01
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 01:58:39 -0700 (PDT)
Received: by balab.aueb.gr (Postfix, from userid 1000)
        id 08432246161; Fri, 26 Aug 2022 11:58:35 +0300 (EEST)
From:   Diomidis Spinellis <dds@aueb.gr>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, avarab@gmail.com,
        gitster@pobox.com, Diomidis Spinellis <dds@aueb.gr>
Subject: [PATCH v4] grep: fix multibyte regex handling under macOS
Date:   Fri, 26 Aug 2022 11:58:15 +0300
Message-Id: <20220826085815.2771102-1-dds@aueb.gr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <pull.1313.v2.git.git.1661289990205.gitgitgadget () gmail ! com>
References: <pull.1313.v2.git.git.1661289990205.gitgitgadget () gmail ! com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit 29de20504e (Makefile: fix default regex settings on
Darwin, 2013-05-11) fixed t0070-fundamental.sh under Darwin (macOS) by
adopting Git's regex library.  However, this library is compiled with
NO_MBSUPPORT, which causes git-grep to work incorrectly on multibyte
(e.g. UTF-8) files.  Current macOS versions pass t0070-fundamental.sh
with the native macOS regex library, which also supports multibyte
characters.

Adjust the Makefile to use the native regex library, and call
setlocale(3) to set CTYPE according to the user's preference.
The setlocale call is required on all platforms, but in platforms
supporting gettext(3), setlocale was called as a side-effect of
initializing gettext.  Therefore, move the CTYPE setlocale call from
gettext.c to common-main.c and the corresponding locale.h include
into git-compat-util.h.

Thanks to the global initialization of CTYPE setlocale, the test-tool
regex command now works correctly with supported multibyte regexes, and
is used to set the MB_REGEX test prerequisite by assessing a platform's
support for them.

Signed-off-by: Diomidis Spinellis <dds@aueb.gr>
---

- Fold test script into t7810-grep.sh
- Simplify the test prerequisite evaluation

 Makefile          |  2 +-
 common-main.c     |  1 +
 gettext.c         |  2 --
 git-compat-util.h |  1 +
 t/t7810-grep.sh   | 15 +++++++++++++++
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 04d0fd1fe6..d1a9825715 100644
--- a/Makefile
+++ b/Makefile
@@ -1427,7 +1427,6 @@ ifeq ($(uname_S),Darwin)
 		APPLE_COMMON_CRYPTO = YesPlease
 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
 	endif
-	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
 endif
 
@@ -2970,6 +2969,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
+	@echo NO_REGEX=\''$(subst ','\'',$(subst ','\'',$(NO_REGEX)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
diff --git a/common-main.c b/common-main.c
index c531372f3f..0a22861f1c 100644
--- a/common-main.c
+++ b/common-main.c
@@ -40,6 +40,7 @@ int main(int argc, const char **argv)
 
 	git_resolve_executable_dir(argv[0]);
 
+	setlocale(LC_CTYPE, "");
 	git_setup_gettext();
 
 	initialize_the_repository();
diff --git a/gettext.c b/gettext.c
index bb5ba1fe7c..f139008d0a 100644
--- a/gettext.c
+++ b/gettext.c
@@ -10,7 +10,6 @@
 #include "config.h"
 
 #ifndef NO_GETTEXT
-#	include <locale.h>
 #	include <libintl.h>
 #	ifdef GIT_WINDOWS_NATIVE
 
@@ -80,7 +79,6 @@ static int test_vsnprintf(const char *fmt, ...)
 
 static void init_gettext_charset(const char *domain)
 {
-	setlocale(LC_CTYPE, "");
 	charset = locale_charset();
 	bind_textdomain_codeset(domain, charset);
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 58d7708296..c6fa3c7469 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -212,6 +212,7 @@
 #endif
 #include <errno.h>
 #include <limits.h>
+#include <locale.h>
 #ifdef NEEDS_SYS_PARAM_H
 #include <sys/param.h>
 #endif
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 6935601171..308a3dc231 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -18,6 +18,9 @@ test_invalid_grep_expression() {
 	'
 }
 
+LC_ALL=en_US.UTF-8 test-tool regex '^.$' '¿' &&
+  test_set_prereq MB_REGEX
+
 cat >hello.c <<EOF
 #include <assert.h>
 #include <stdio.h>
@@ -87,6 +90,10 @@ test_expect_success setup '
 		echo unusual >"\"unusual\" pathname" &&
 		echo unusual >"t/nested \"unusual\" pathname"
 	fi &&
+	if test_have_prereq MB_REGEX
+	then
+		echo "¿" >reverse-question-mark
+	fi &&
 	git add . &&
 	test_tick &&
 	git commit -m initial
@@ -568,6 +575,14 @@ do
 	'
 done
 
+test_expect_success MB_REGEX 'grep exactly one char in single-char multibyte file' '
+	LC_ALL=en_US.UTF-8 git grep "^.$" reverse-question-mark
+'
+
+test_expect_success MB_REGEX 'grep two chars in single-char multibyte file' '
+	LC_ALL=en_US.UTF-8 test_expect_code 1 git grep ".." reverse-question-mark
+'
+
 cat >expected <<EOF
 file
 EOF
-- 
2.30.2

