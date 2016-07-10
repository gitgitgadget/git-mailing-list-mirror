Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779AF1F744
	for <e@80x24.org>; Sun, 10 Jul 2016 08:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbcGJIUw (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 04:20:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33696 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbcGJIUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 04:20:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24C91F744;
	Sun, 10 Jul 2016 08:20:46 +0000 (UTC)
Date:	Sun, 10 Jul 2016 08:20:46 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: [PATCH 3/2] hoist out handle_nonblock function for xread and xwrite
Message-ID: <20160710082046.GB29312@whir>
References: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
 <20160709234518.GA3702@dcvr.yhbt.net>
 <20160710025232.GA4666@sigill.intra.peff.net>
 <20160710034736.GA19151@dcvr.yhbt.net>
 <20160710044529.GA10777@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160710044529.GA10777@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

At least for me, this improves the readability of xread and
xwrite; hopefully allowing missing "continue" statements to
be spotted more easily.

Signed-off-by: Eric Wong <e@80x24.org>
Signed-off-by: Jeff King <peff@peff.net>
---
  Jeff King <peff@peff.net> wrote:
  > On Sun, Jul 10, 2016 at 03:47:36AM +0000, Eric Wong wrote:
  > > Yes, I'm fine with either, but I'm slightly thrown off by
  > > a function relying on errno being set by the caller, even if it
  > > is errno.  So maybe localizing it is better (see below)
  > 
  > Yeah, I had a similar reservation, but didn't want to clutter the
  > interface. However, just passing errno isn't too bad (as you showed
  > below), and is much less magical.
  > 
  > Do you want to squash that and re-send the whole patch to make Junio's
  > life easier?

  Done, also updated the subject to match the new function name.

  I wasn't attached to the "io_wait" name, either, as it could
  be confused with "I/O wait" commonly associated with disk I/O
  and not often with socket/pipe I/O that poll gets used for.

 wrapper.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 0b920f1..78f6431 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -227,6 +227,24 @@ int xopen(const char *path, int oflag, ...)
 	}
 }
 
+static int handle_nonblock(int fd, short poll_events, int err)
+{
+	struct pollfd pfd;
+
+	if (err != EAGAIN && err != EWOULDBLOCK)
+		return 0;
+
+	pfd.fd = fd;
+	pfd.events = poll_events;
+
+	/*
+	 * no need to check for errors, here;
+	 * a subsequent read/write will detect unrecoverable errors
+	 */
+	poll(&pfd, 1, -1);
+	return 1;
+}
+
 /*
  * xread() is the same a read(), but it automatically restarts read()
  * operations with a recoverable error (EAGAIN and EINTR). xread()
@@ -242,21 +260,8 @@ ssize_t xread(int fd, void *buf, size_t len)
 		if (nr < 0) {
 			if (errno == EINTR)
 				continue;
-			if (errno == EAGAIN || errno == EWOULDBLOCK) {
-				struct pollfd pfd;
-				pfd.events = POLLIN;
-				pfd.fd = fd;
-				/*
-				 * it is OK if this poll() failed; we
-				 * want to leave this infinite loop
-				 * only when read() returns with
-				 * success, or an expected failure,
-				 * which would be checked by the next
-				 * call to read(2).
-				 */
-				poll(&pfd, 1, -1);
+			if (handle_nonblock(fd, POLLIN, errno))
 				continue;
-			}
 		}
 		return nr;
 	}
@@ -277,21 +282,8 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 		if (nr < 0) {
 			if (errno == EINTR)
 				continue;
-			if (errno == EAGAIN || errno == EWOULDBLOCK) {
-				struct pollfd pfd;
-				pfd.events = POLLOUT;
-				pfd.fd = fd;
-				/*
-				 * it is OK if this poll() failed; we
-				 * want to leave this infinite loop
-				 * only when write() returns with
-				 * success, or an expected failure,
-				 * which would be checked by the next
-				 * call to write(2).
-				 */
-				poll(&pfd, 1, -1);
+			if (handle_nonblock(fd, POLLOUT, errno))
 				continue;
-			}
 		}
 
 		return nr;
-- 
EW
