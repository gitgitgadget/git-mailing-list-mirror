Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BFCC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiHQGFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiHQGE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:04:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0E769F70
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:04:56 -0700 (PDT)
Received: (qmail 6576 invoked by uid 109); 17 Aug 2022 06:04:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Aug 2022 06:04:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13673 invoked by uid 111); 17 Aug 2022 06:04:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Aug 2022 02:04:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Aug 2022 02:04:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/6] compat: add function to enable nonblocking pipes
Message-ID: <YvyFBzdO8PN7Ou0W@coredump.intra.peff.net>
References: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'd like to be able to make some of our pipes nonblocking so that
poll() can be used effectively, but O_NONBLOCK isn't portable. Let's
introduce a compat wrapper so this can be abstracted for each platform.

The interface is as narrow as possible to let platforms do what's
natural there (rather than having to implement fcntl() and a fake
O_NONBLOCK for example, or having to handle other types of descriptors).

The next commit will add Windows support, at which point we should be
covering all platforms in practice. But if we do find some other
platform without O_NONBLOCK, we'll return ENOSYS. Arguably we could just
trigger a build-time #error in this case, which would catch the problem
earlier. But since we're not planning to use this compat wrapper in many
code paths, a seldom-seen runtime error may be friendlier for such a
platform than blocking compilation completely. Our test suite would
still notice it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile          |  1 +
 compat/nonblock.c | 23 +++++++++++++++++++++++
 compat/nonblock.h |  9 +++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 compat/nonblock.c
 create mode 100644 compat/nonblock.h

diff --git a/Makefile b/Makefile
index e8adeb09f1..224e193b66 100644
--- a/Makefile
+++ b/Makefile
@@ -918,6 +918,7 @@ LIB_OBJS += combine-diff.o
 LIB_OBJS += commit-graph.o
 LIB_OBJS += commit-reach.o
 LIB_OBJS += commit.o
+LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += compat/zlib-uncompress2.o
diff --git a/compat/nonblock.c b/compat/nonblock.c
new file mode 100644
index 0000000000..b08105a21d
--- /dev/null
+++ b/compat/nonblock.c
@@ -0,0 +1,23 @@
+#include "git-compat-util.h"
+#include "nonblock.h"
+
+#ifdef O_NONBLOCK
+
+int enable_pipe_nonblock(int fd)
+{
+	int flags = fcntl(fd, F_GETFL);
+	if (flags < 0)
+		return -1;
+	flags |= O_NONBLOCK;
+	return fcntl(fd, F_SETFL, flags);
+}
+
+#else
+
+int enable_pipe_nonblock(int fd)
+{
+	errno = ENOSYS;
+	return -1;
+}
+
+#endif
diff --git a/compat/nonblock.h b/compat/nonblock.h
new file mode 100644
index 0000000000..af1a331301
--- /dev/null
+++ b/compat/nonblock.h
@@ -0,0 +1,9 @@
+#ifndef COMPAT_NONBLOCK_H
+#define COMPAT_NONBLOCK_H
+
+/*
+ * Enable non-blocking I/O for the pipe specified by the passed-in descriptor.
+ */
+int enable_pipe_nonblock(int fd);
+
+#endif
-- 
2.37.2.881.gb57357660c

