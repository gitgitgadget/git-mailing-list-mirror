Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D47C04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 08:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiHYIbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiHYIbs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 04:31:48 -0400
X-Greylist: delayed 502 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 01:31:46 PDT
Received: from balab.aueb.gr (unknown [IPv6:2001:648:2ffe:3:a800:ff:fe99:2593])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88A9666113
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 01:31:45 -0700 (PDT)
Received: by balab.aueb.gr (Postfix, from userid 1000)
        id 4D570246161; Thu, 25 Aug 2022 11:23:21 +0300 (EEST)
From:   Diomidis Spinellis <dds@aueb.gr>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, avarab@gmail.com,
        gitster@pobox.com, Diomidis Spinellis <dds@aueb.gr>
Subject: [PATCH v3] grep: fix multibyte regex handling under macOS
Date:   Thu, 25 Aug 2022 11:20:45 +0300
Message-Id: <20220825082045.2662893-1-dds@aueb.gr>
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

To avoid running the new tests on the few platforms still using the
compatibility library, which is compiled without multibyte support,
store the corresponding NO_REGEX setting in the GIT-BUILD-OPTIONS file.
This makes it available to the test scripts.  Thanks to the global
initialization of CTYPE setlocale, the test-tool regex command now
works correctly with multibyte regexes and is used to further test
a platform's support for them.

Signed-off-by: Diomidis Spinellis <dds@aueb.gr>
---
- Move added setlocale from grep.c and test-regex.c to common-main.c
- Move added locale.h include from the above files to git-compat-util.h
- Correct use of test_expect_code 1
- Have old commit reference in the commit message follow commit
  referencing conventions

 Makefile                  |  2 +-
 common-main.c             |  1 +
 gettext.c                 |  2 --
 git-compat-util.h         |  1 +
 t/t7818-grep-multibyte.sh | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100755 t/t7818-grep-multibyte.sh

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
diff --git a/t/t7818-grep-multibyte.sh b/t/t7818-grep-multibyte.sh
new file mode 100755
index 0000000000..a3889f9822
--- /dev/null
+++ b/t/t7818-grep-multibyte.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='grep multibyte characters'
+
+. ./test-lib.sh
+
+# Multibyte regex search is only supported with a native regex library
+# that supports it.
+# (The supplied compatibility library is compiled with NO_MBSUPPORT.)
+test -z "$NO_REGEX" &&
+  LC_ALL=en_US.UTF-8 test-tool regex '^.$' '¿' &&
+  test_set_prereq MB_REGEX
+
+if ! test_have_prereq MB_REGEX
+then
+  skip_all='multibyte grep tests; Git compiled with NO_REGEX, NO_MBSUPPORT'
+  test_done
+fi
+
+test_expect_success 'setup' '
+	test_write_lines "¿" >file &&
+	git add file &&
+	LC_ALL="en_US.UTF-8" &&
+	export LC_ALL
+'
+test_expect_success 'grep exactly one char in single-char multibyte file' '
+	git grep "^.$"
+'
+
+test_expect_success 'grep two chars in single-char multibyte file' '
+	test_expect_code 1 git grep ".."
+'
+
+test_done
-- 
2.30.2

