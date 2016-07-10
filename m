Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B148C1FE4E
	for <e@80x24.org>; Sun, 10 Jul 2016 02:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbcGJCwh (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 22:52:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:42444 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751083AbcGJCwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 22:52:36 -0400
Received: (qmail 12341 invoked by uid 102); 10 Jul 2016 02:52:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Jul 2016 22:52:37 -0400
Received: (qmail 23042 invoked by uid 107); 10 Jul 2016 02:52:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Jul 2016 22:52:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jul 2016 22:52:32 -0400
Date:	Sat, 9 Jul 2016 22:52:32 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #03; Fri, 8)
Message-ID: <20160710025232.GA4666@sigill.intra.peff.net>
References: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
 <20160709234518.GA3702@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160709234518.GA3702@dcvr.yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 09, 2016 at 11:45:18PM +0000, Eric Wong wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > * sb/submodule-parallel-fetch (2016-06-27) 2 commits
> >   (merged to 'next' on 2016-07-06 at de5fd35)
> >  + xwrite: poll on non-blocking FDs
> >  + xread: retry after poll on EAGAIN/EWOULDBLOCK
> > 
> >  Fix a recently introduced codepaths that are involved in parallel
> >  submodule operations, which gave up on reading too early, and
> >  could have wasted CPU while attempting to write under a corner case
> >  condition.
> > 
> >  Will merge to 'master'.
> 
> Any thoughts on my cleanup 3/2 patch for this series?
> ("hoist out io_wait function for xread and xwrite")
> https://public-inbox.org/git/20160627201311.GA7039@dcvr.yhbt.net/raw
> 
> Jeff liked it:
> https://public-inbox.org/git/20160627214947.GA17149@sigill.intra.peff.net/

I did (and do) like it. I think it may have simply gotten lost in the
mass of "should we handle EAGAIN from getdelim()" patches I sent (to
which I concluded "probably not").

There was one minor improvement I suggested[1] (and which you seemed to
like), which is to push the errno check into the function. That wasn't
expressed in patch form, though, so I've included below a version of
your patch with my suggestion squashed in.

I didn't include the test I mentioned in [2]. I think the potential for
portability and raciness problems make it probably not worth the
trouble.

[1] https://public-inbox.org/git/20160627222238.GA23645@sigill.intra.peff.net

[2] https://public-inbox.org/git/20160627214947.GA17149@sigill.intra.peff.net

-- >8 --
From: Eric Wong <e@80x24.org>
Subject: [PATCH] hoist out io_wait function for xread and xwrite

At least for me, this improves the readability of xread and
xwrite; hopefully allowing missing "continue" statements to
be spotted more easily.

Signed-off-by: Eric Wong <e@80x24.org>
Signed-off-by: Jeff King <peff@peff.net>
---
Since both conditionals just call "continue", you could actually fold
them into a single if() in each caller, but I think it's easier to
follow as two separate ones.

You could actually fold the t
 wrapper.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index f7ea6c4..0a966d6 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -224,6 +224,24 @@ int xopen(const char *path, int oflag, ...)
 	}
 }
 
+static int handle_nonblock(int fd, short poll_events)
+{
+	struct pollfd pfd;
+
+	if (errno != EAGAIN && errno != EWOULDBLOCK)
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
@@ -239,21 +257,8 @@ ssize_t xread(int fd, void *buf, size_t len)
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
+			if (handle_nonblock(fd, POLLIN))
 				continue;
-			}
 		}
 		return nr;
 	}
@@ -274,21 +279,8 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
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
+			if (handle_nonblock(fd, POLLOUT))
 				continue;
-			}
 		}
 
 		return nr;
-- 
2.9.0.406.g77f030d

