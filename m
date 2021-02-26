Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7AFC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6325864EDB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhBZGPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 01:15:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:45526 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhBZGPR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 01:15:17 -0500
Received: (qmail 11885 invoked by uid 109); 26 Feb 2021 06:14:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 06:14:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16434 invoked by uid 111); 26 Feb 2021 06:14:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 01:14:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 01:14:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: [PATCH v2] Makefile: add OPEN_RETURNS_EINTR knob
Message-ID: <YDiRywyld/0OTT5U@coredump.intra.peff.net>
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
 <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net>
 <xmqqzgzuyqli.fsf@gitster.g>
 <YDaY/M3Rw+6xwZlf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDaY/M3Rw+6xwZlf@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 01:20:44PM -0500, Jeff King wrote:

> > Hmph, just like other workarounds, shouldn't this be "if your
> > platform screws this up, define this knob to work it around"?  That
> > would make it fit better with the rest of compat/.
> 
> I actually started that way, but then I got stuck deciding which
> platforms in config.mak.uname to enable it for. We've seen it on Linux
> and on macOS. I don't know how prevalent it is on those platforms (or
> whether it is indeed a bug that may even get fixed). Since the check is
> basically zero-cost at run-time, it seemed like it was worth just being
> on guard for it so that nobody ever had to worry about it again.
> 
> But I don't feel that strongly. I'd be happy to do it with a Makefile
> knob if you prefer.

So here's a v2 that turns it into a Makefile knob.

This was motivated by two things:

  - it must not be enabled on Windows, where it overrides the existing
    mingw_open()

  - I couldn't replicate it on a Big Sur machine, using the same
    sequence that Aleksey did (basically just cloning and checking out
    dotnet/runtime.git from scratch).

    So it's not entirely clear to me how widespread the problem is. A
    conservative approach (at least in terms of change from the status
    quo) is to introduce this knob but not enable it automatically
    (which this patch does). And then if somebody runs into it, they can
    try turning the knob.

    It's less conservative in the sense that we won't be preemptively
    protecting people. I dunno. Once we have the knob, it would be
    pretty easy to just flip the default.

-- >8 --
Subject: [PATCH] Makefile: add OPEN_RETURNS_EINTR knob

On some platforms, open() reportedly returns EINTR when opening regular
files and we receive a signal (usually SIGALRM from our progress meter).
This shouldn't happen, as open() should be a restartable syscall, and we
specify SA_RESTART when setting up the alarm handler. So it may actually
be a kernel or libc bug for this to happen. But it has been reported on
at least one version of Linux (on a network filesystem):

  https://lore.kernel.org/git/c8061cce-71e4-17bd-a56a-a5fed93804da@neanderfunk.de/

as well as on macOS starting with Big Sur even on a regular filesystem.

We can work around it by retrying open() calls that get EINTR, just as
we do for read(), etc. Since we don't ever _want_ to interrupt an open()
call, we can get away with just redefining open, rather than insisting
all callsites use xopen().

We actually do have an xopen() wrapper already (and it even does this
retry, though there's no indication of it being an observed problem back
then; it seems simply to have been lifted from xread(), etc). But it is
used hardly anywhere, and isn't suitable for general use because it will
die() on error. In theory we could combine the two, but it's awkward to
do so because of the variable-args interface of open().

This patch adds a Makefile knob for enabling the workaround. It's not
enabled by default for any platforms in config.mak.uname yet, as we
don't have enough data to decide how common this is (I have not been
able to reproduce on either Linux or Big Sur myself). It may be worth
enabling preemptively anyway, since the cost is pretty low (if we don't
see an EINTR, it's just an extra conditional).

However, note that we must not enable this on Windows. It doesn't do
anything there, and the macro overrides the existing mingw_open()
redirection. I've added a preemptive #undef here in the mingw header
(which is processed first) to just quietly disable it (we could also
make it an #error, but there is little point in being so aggressive).

Reported-by: Aleksey Kliger <alklig@microsoft.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile          |  7 +++++++
 compat/mingw.h    |  1 +
 compat/open.c     | 25 +++++++++++++++++++++++++
 git-compat-util.h |  6 ++++++
 4 files changed, 39 insertions(+)
 create mode 100644 compat/open.c

diff --git a/Makefile b/Makefile
index 9b1bde2e0e..c4872ca16e 100644
--- a/Makefile
+++ b/Makefile
@@ -22,6 +22,9 @@ all::
 # when attempting to read from an fopen'ed directory (or even to fopen
 # it at all).
 #
+# Define OPEN_RETURNS_EINTR if your open() system call may return EINTR
+# when a signal is received (as opposed to restarting).
+#
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 #
 # Define USE_LIBPCRE if you have and want to use libpcre. Various
@@ -1538,6 +1541,10 @@ ifdef FREAD_READS_DIRECTORIES
 	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
 	COMPAT_OBJS += compat/fopen.o
 endif
+ifdef OPEN_RETURNS_EINTR
+	COMPAT_CFLAGS += -DOPEN_RETURNS_EINTR
+	COMPAT_OBJS += compat/open.o
+endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
diff --git a/compat/mingw.h b/compat/mingw.h
index af8eddd73e..c9a52ad64a 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -227,6 +227,7 @@ int mingw_rmdir(const char *path);
 
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
+#undef OPEN_RETURNS_EINTR
 
 int mingw_fgetc(FILE *stream);
 #define fgetc mingw_fgetc
diff --git a/compat/open.c b/compat/open.c
new file mode 100644
index 0000000000..eb3754a23b
--- /dev/null
+++ b/compat/open.c
@@ -0,0 +1,25 @@
+#include "git-compat-util.h"
+
+#undef open
+int git_open_with_retry(const char *path, int flags, ...)
+{
+	mode_t mode = 0;
+	int ret;
+
+	/*
+	 * Also O_TMPFILE would take a mode, but it isn't defined everywhere.
+	 * And anyway, we don't use it in our code base.
+	 */
+	if (flags & O_CREAT) {
+		va_list ap;
+		va_start(ap, flags);
+		mode = va_arg(ap, int);
+		va_end(ap);
+	}
+
+	do {
+		ret = open(path, flags, mode);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 838246289c..551cc9f22f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -788,6 +788,12 @@ int git_vsnprintf(char *str, size_t maxsize,
 		  const char *format, va_list ap);
 #endif
 
+#ifdef OPEN_RETURNS_EINTR
+#undef open
+#define open git_open_with_retry
+int git_open_with_retry(const char *path, int flag, ...);
+#endif
+
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
 #define HAVE_STRCHRNUL
-- 
2.31.0.rc0.520.g3ffb8d01f4

