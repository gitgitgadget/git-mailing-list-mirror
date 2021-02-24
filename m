Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89DFC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B1364E85
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhBXEn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:43:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:42658 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhBXEn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:43:57 -0500
Received: (qmail 28948 invoked by uid 109); 24 Feb 2021 04:43:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Feb 2021 04:43:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8783 invoked by uid 111); 24 Feb 2021 04:43:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 23:43:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 23:43:15 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Aleksey Kliger <alklig@microsoft.com>
Subject: [PATCH] wrapper: add workaround for open() returning EINTR
Message-ID: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

The workaround here is enabled all the time, without a Makefile knob,
since it's a complete noop if open() never returns EINTR. I did push it
into its own compat/ source file, though, since it has to #undef our
macro redirection. Putting it in a file with other code risks confusion
if more code is added after that #undef.

Reported-by: Aleksey Kliger <alklig@microsoft.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This was reported to me off-list. Aleksey was kind enough to test the
patch on a system that was reliably showing the problem during the
checkout phase of git-clone (which naturally has both a progress meter
and is calling open() on a ton of files).

I do still think the OS is doing the wrong thing here. But even if I'm
right, it's probably prudent to work around it.

 git-compat-util.h |  4 ++++
 wrapper.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 838246289c..2be022c422 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -788,6 +788,10 @@ int git_vsnprintf(char *str, size_t maxsize,
 		  const char *format, va_list ap);
 #endif
 
+#undef open
+#define open git_open_with_retry
+int git_open_with_retry(const char *path, int flag, ...);
+
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
 #define HAVE_STRCHRNUL
diff --git a/wrapper.c b/wrapper.c
index bcda41e374..130f441064 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -678,3 +678,32 @@ int is_empty_or_missing_file(const char *filename)
 
 	return !st.st_size;
 }
+
+/*
+ * Do not add other callers of open() after this. Our redefinition
+ * below will ensure the compiler catches any.
+ */
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
+#define open do_not_allow_use_of_bare_open
-- 
2.30.1.1095.g03347429ea
