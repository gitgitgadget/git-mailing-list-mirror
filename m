Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107B31FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932419AbeARWnP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:43:15 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:46325
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932379AbeARWnM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jan 2018 17:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516315391; bh=sbomicm9FjR7Giy4QGHfjq7any4ydNs3ROrKy5/9/ck=; h=From:To:Cc:Subject:Date:From:Subject; b=KMGsf/s2Pjjd8fEr2Pg/KatnZbjHUlZBFEX8wdKzGAkNRkqSUdfGWf05jALt16AHDfM/DSC4tLdCSqXGcGNXEed3uDfGngxC1WjWOH75SYig3n8bH4ieMhPDHxWLiLCUjXG+CRkGfksZHJtv4oOcZZmSDqwBpKRZVNlM4IGnyJKe0QOexkT9b+iZhK/BzhgIVeqTi9YLHnmvjd4ldJT+xzdBtN0prPui99sy7hKHhh6qcGhoj2eNV0/75vZwaYsPu0yRNJfayEISzh1h5X+uRDKyIYVIP8HqfnYtDYOB2xUpipu4pemRB32BXYn4dpX0/5pKqjCsnDgACiaLv8xL0A==
X-YMail-OSG: CZi58NQVM1klgbNJnPqaP17SHVZZ9abXyQ3rDAKqeb_we9q_XZQC4MvDS2DOB_a
 4LKWuv0HCTnHvl5dQl3W39L3mNrmrSIY3MXFJiCF4MP8K2v_fGaRj3qKXRafKUsqPOnz7ej9hEYf
 U1wVX8nLa6KVRnxkjbn5kuACVaBIEWNA1XBwC2QtHb5.xTKncFhV8G7Zc.vghbVPRHTcukxtEOV8
 xvSquU8hr.NuotpybpO4sOx0uG1ODaVqsW.3SYHND79m6nKyJ4tMNCd9VCzMmbOwrbqzPtKwIxlj
 qO3DDx9RSJaqoa8tBe1SGptKcItFkvIT7PzhWvbcd4i7fRvQcISsbVR1cPnpldEHUbTp588GEgZX
 JLikNxwpsn6k.pj4af0Miu1ujxCdmxhZQOlUdBmV0eGQ4mNDfH65iKNJXG3Cwieg7PFkb0QUVTpo
 lvLS1nrx2IqiuCb3k9WMVVMvNM0boASbp05qxmCWjLCuJAZRdit85U2XaDWBooKPfSpo34KqAADb
 1JB.xeBWsb7S5GMv4G2dWWstGjmzWs.KXj3crntneZbZhHNVtNw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 Jan 2018 22:43:11 +0000
Received: from smtp228.mail.ne1.yahoo.com (EHLO localhost.localdomain) ([10.218.253.213])
          by smtp414.mail.ne1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID 2626225014578d830367cf1358daea86;
          Thu, 18 Jan 2018 22:43:07 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [RFC PATCH] NonStop port changes for git 2.16.0.
Date:   Thu, 18 Jan 2018 17:42:43 -0500
Message-Id: <20180118224243.5016-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Explanation: I'm looking for comments on how best to handle the changes
below that are needed for the NonStop port. The hashmap.h and
transport-helper.c will not be included in the final patch as they have 
already been communicated but did not make it into 2.16.0.
It is likely that some of the changes below are in the wrong files
(for example: NSIG, intptr_t) and should be moved. This is just the
current state of the port, as it grew (and fortunately shrank a lot)
over the past few years. My objective, as the platform maintainer, is
to clean it up, and to try to get the platform's modifications
included so that we can just (obviously) pull directly from the standard
repository and not have to apply these mods in future and focus on
any platform-related breakages.

Further: there are 6 known breakages that have been reported. The perl
issues relating to completion codes are being examined at present by the
platform support teams so are not addressed by this patch.

With Respect,
Randall

* Fixes platform issues not covered in the vanilla git code.

* Pulls previous ports forward into a single commit.

* Still has some known breaks based on platform limits and restrictions.

* Makefile: allows error codes during install. Change the options associated
  with the tar operation providing options required on platform. To be
  refactored into variables.

* regcomp.c: fixes missing intptr_t on NonStop.

* config.mak.uname: upgrades old options for current operating system
  requirements.

* git-compat-util.h: adds FLOSS definitions to allow platform support.

* remote.c: force ignoring of GCC __attribute construct not supported
  by c99.

* run_command.c: Added NSIG definition that is missing from NonStop
  signal.h.

* lib-git-daemon.sh: fixed incompatibilities with ksh traps not cleared
  automatically on platform.

* wrapper.c: added setbuf(stream,0) to force pipe flushes not enabled by
  default on platform.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 Makefile               |  4 ++--
 compat/regex/regcomp.c |  7 +++++++
 config.mak.uname       | 29 +++++++++++++++++++++--------
 git-compat-util.h      |  9 +++++++++
 hashmap.h              |  3 +--
 remote.c               |  4 ++++
 run-command.c          |  5 +++++
 t/lib-git-daemon.sh    |  3 +++
 transport-helper.c     |  2 +-
 wrapper.c              |  3 +++
 10 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 1a9b23b67..c91602609 100644
--- a/Makefile
+++ b/Makefile
@@ -2567,9 +2567,9 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 ifndef NO_GETTEXT
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
+	-$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
+	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xvof -)
 endif
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 51cd60baa..cb03fab78 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -17,6 +17,13 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
+#if defined __TANDEM
+#ifdef NO_INTPTR_T
+typedef long intptr_t;
+typedef unsigned long uintptr_t;
+#endif
+#endif
+
 static reg_errcode_t re_compile_internal (regex_t *preg, const char * pattern,
 					  size_t length, reg_syntax_t syntax);
 static void re_compile_fastmap_iter (regex_t *bufp,
diff --git a/config.mak.uname b/config.mak.uname
index 685a80d13..d9f8d57e3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -428,27 +428,37 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# INLINE='' would just replace one set of warnings with another and
 	# still not compile in c89 mode, due to non-const array initializations.
 	CC = cc -c99
+	# Build down-rev compatible objects that don't use our new getopt_long.
+	ifeq ($(uname_R).$(uname_V),J06.21)
+		CC += -WRVU=J06.20
+	endif
+	ifeq ($(uname_R).$(uname_V),L17.02)
+		CC += -WRVU=L16.05
+	endif
 	# Disable all optimization, seems to result in bad code, with -O or -O2
 	# or even -O1 (default), /usr/local/libexec/git-core/git-pack-objects
 	# abends on "git push". Needs more investigation.
-	CFLAGS = -g -O0
+	CFLAGS = -g -O0 -Winline
 	# We'd want it to be here.
 	prefix = /usr/local
 	# Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
-	PERL_PATH = ${prefix}/bin/perl
-	PYTHON_PATH = ${prefix}/bin/python
-
+	PERL_PATH = /usr/bin/perl
+	PYTHON_PATH = /usr/bin/python
+	RM = /bin/rm -f
 	# As detected by './configure'.
 	# Missdetected, hence commented out, see below.
 	#NO_CURL = YesPlease
 	# Added manually, see above.
 	NEEDS_SSL_WITH_CURL = YesPlease
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
+	HAVE_DEV_TTY = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
 	HAVE_STRINGS_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
 	NO_SYS_SELECT_H = UnfortunatelyYes
 	NO_D_TYPE_IN_DIRENT = YesPlease
+	NO_GETTEXT = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
@@ -458,8 +468,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_MKDTEMP = YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV = UnfortunatelyYes
-	NO_REGEX = YesPlease
+	NO_REGEX=NeedsStartEnd
 	NO_PTHREADS = UnfortunatelyYes
+	ifdef NO_PTHREADS
+	else # WIP, use Posix User Threads
+		PTHREAD_CFLAGS = -D_PUT_MODEL_ -I/usr/include
+		PTHREAD_LIBS = -lput
+	endif
 
 	# Not detected (nor checked for) by './configure'.
 	# We don't have SA_RESTART on NonStop, unfortunalety.
@@ -477,9 +492,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# RFE 10-120912-4693 submitted to HP NonStop development.
 	NO_SETITIMER = UnfortunatelyYes
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
-	SHELL_PATH = /usr/local/bin/bash
-	# as of H06.25/J06.14, we might better use this
-	#SHELL_PATH = /usr/coreutils/bin/bash
+	SHELL_PATH = /usr/coreutils/bin/bash
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
diff --git a/git-compat-util.h b/git-compat-util.h
index 68b2ad531..5fc6b259d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -378,6 +378,15 @@ static inline char *git_find_last_dir_sep(const char *path)
 #define find_last_dir_sep git_find_last_dir_sep
 #endif
 
+#ifdef __TANDEM
+#if !defined(_THREAD_SUPPORT_FUNCTIONS) && !defined(_PUT_MODEL_)
+/* #include <floss.h(floss_read,floss_write,floss_fsync,floss_fork)> */
+/* #include <floss.h(floss_fork)> */
+#endif
+#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
+#include <floss.h(floss_getpwuid)>
+#endif
+
 #if defined(__HP_cc) && (__HP_cc >= 61000)
 #define NORETURN __attribute__((noreturn))
 #define NORETURN_PTR
diff --git a/hashmap.h b/hashmap.h
index 7ce79f3f7..d375d9cce 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -400,7 +400,6 @@ static inline void hashmap_disable_item_counting(struct hashmap *map)
  */
 static inline void hashmap_enable_item_counting(struct hashmap *map)
 {
-	void *item;
 	unsigned int n = 0;
 	struct hashmap_iter iter;
 
@@ -408,7 +407,7 @@ static inline void hashmap_enable_item_counting(struct hashmap *map)
 		return;
 
 	hashmap_iter_init(map, &iter);
-	while ((item = hashmap_iter_next(&iter)))
+	while (hashmap_iter_next(&iter))
 		n++;
 
 	map->do_count_items = 1;
diff --git a/remote.c b/remote.c
index 4e93753e1..c18f9de7f 100644
--- a/remote.c
+++ b/remote.c
@@ -11,6 +11,10 @@
 #include "mergesort.h"
 #include "argv-array.h"
 
+#if defined (__TANDEM)
+#define __attribute(a)
+#endif
+
 enum map_direction { FROM_SRC, FROM_DST };
 
 static struct refspec s_tag_refspec = {
diff --git a/run-command.c b/run-command.c
index 31fc5ea86..aaae8b54d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -7,6 +7,11 @@
 #include "strbuf.h"
 #include "string-list.h"
 
+#if defined __TANDEM && ! defined NSIG
+/* See platform kill -l for list is all signals */
+# define NSIG 100
+#endif
+
 void child_process_init(struct child_process *child)
 {
 	memset(child, 0, sizeof(*child));
diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 987d40680..955beecd9 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -68,6 +68,7 @@ start_git_daemon() {
 		test_skip_or_die $GIT_TEST_GIT_DAEMON \
 			"git daemon failed to start"
 	fi
+	trap '' EXIT
 }
 
 stop_git_daemon() {
@@ -89,4 +90,6 @@ stop_git_daemon() {
 	fi
 	GIT_DAEMON_PID=
 	rm -f git_daemon_output
+
+	trap '' EXIT
 }
diff --git a/transport-helper.c b/transport-helper.c
index 508015023..d48be722a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1207,7 +1207,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
 		return 0;	/* No space for more. */
 
 	transfer_debug("%s is readable", t->src_name);
-	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
+	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
 	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
 		errno != EINTR) {
 		error_errno("read(%s) failed", t->src_name);
diff --git a/wrapper.c b/wrapper.c
index d20356a77..671cbb4b4 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -403,6 +403,9 @@ FILE *xfdopen(int fd, const char *mode)
 	FILE *stream = fdopen(fd, mode);
 	if (stream == NULL)
 		die_errno("Out of memory? fdopen failed");
+#ifdef __TANDEM
+	setbuf(stream,0);
+#endif
 	return stream;
 }
 
-- 
2.16.0.31.gf1a482c

