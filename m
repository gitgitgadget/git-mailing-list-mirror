Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1A4C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbiHQGHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHQGHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:07:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36906E2D6
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:06:59 -0700 (PDT)
Received: (qmail 6609 invoked by uid 109); 17 Aug 2022 06:06:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Aug 2022 06:06:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13709 invoked by uid 111); 17 Aug 2022 06:07:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Aug 2022 02:07:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Aug 2022 02:06:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 3/6] git-compat-util: make MAX_IO_SIZE define globally
 available
Message-ID: <YvyFggmzXAGf3jlL@coredump.intra.peff.net>
References: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We define MAX_IO_SIZE within wrapper.c, but it's useful for any code
that wants to do a raw write() for whatever reason (say, because they
want different EAGAIN handling). Let's make it available everywhere.

The alternative would be adding xwrite_foo() variants to give callers
more options. But there's really no reason MAX_IO_SIZE needs to be
abstracted away, so this give callers the most flexibility.

Signed-off-by: Jeff King <peff@peff.net>
---
I did actually write xwrite_nonblock() at first, and I could be
persuaded to go in that direction if we prefer. But given that using it
sanely requires the caller to have a poll() loop, I feel like
pipe_command() is already the right level of abstraction.

 git-compat-util.h | 22 ++++++++++++++++++++++
 wrapper.c         | 22 ----------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 36a25ae252..6aee4d92e7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -998,6 +998,28 @@ static inline unsigned long cast_size_t_to_ulong(size_t a)
 	return (unsigned long)a;
 }
 
+/*
+ * Limit size of IO chunks, because huge chunks only cause pain.  OS X
+ * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
+ * the absence of bugs, large chunks can result in bad latencies when
+ * you decide to kill the process.
+ *
+ * We pick 8 MiB as our default, but if the platform defines SSIZE_MAX
+ * that is smaller than that, clip it to SSIZE_MAX, as a call to
+ * read(2) or write(2) larger than that is allowed to fail.  As the last
+ * resort, we allow a port to pass via CFLAGS e.g. "-DMAX_IO_SIZE=value"
+ * to override this, if the definition of SSIZE_MAX given by the platform
+ * is broken.
+ */
+#ifndef MAX_IO_SIZE
+# define MAX_IO_SIZE_DEFAULT (8*1024*1024)
+# if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
+#  define MAX_IO_SIZE SSIZE_MAX
+# else
+#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT
+# endif
+#endif
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))
diff --git a/wrapper.c b/wrapper.c
index cfe79bd081..299d6489a6 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -161,28 +161,6 @@ void xsetenv(const char *name, const char *value, int overwrite)
 		die_errno(_("could not setenv '%s'"), name ? name : "(null)");
 }
 
-/*
- * Limit size of IO chunks, because huge chunks only cause pain.  OS X
- * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
- * the absence of bugs, large chunks can result in bad latencies when
- * you decide to kill the process.
- *
- * We pick 8 MiB as our default, but if the platform defines SSIZE_MAX
- * that is smaller than that, clip it to SSIZE_MAX, as a call to
- * read(2) or write(2) larger than that is allowed to fail.  As the last
- * resort, we allow a port to pass via CFLAGS e.g. "-DMAX_IO_SIZE=value"
- * to override this, if the definition of SSIZE_MAX given by the platform
- * is broken.
- */
-#ifndef MAX_IO_SIZE
-# define MAX_IO_SIZE_DEFAULT (8*1024*1024)
-# if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
-#  define MAX_IO_SIZE SSIZE_MAX
-# else
-#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT
-# endif
-#endif
-
 /**
  * xopen() is the same as open(), but it die()s if the open() fails.
  */
-- 
2.37.2.881.gb57357660c

