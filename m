Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AFEB2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbcF0UNL (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 16:13:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35356 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbcF0UNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 16:13:10 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FBA12018A;
	Mon, 27 Jun 2016 20:13:09 +0000 (UTC)
Date:	Mon, 27 Jun 2016 20:13:11 +0000
From:	Eric Wong <e@80x24.org>
To:	Stefan Beller <sbeller@google.com>
Cc:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
Message-ID: <20160627201311.GA7039@dcvr.yhbt.net>
References: <20160626232112.721-1-e@80x24.org>
 <20160626232112.721-2-e@80x24.org>
 <20160626234251.GA21668@sigill.intra.peff.net>
 <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
 <20160627143648.GA2618@sigill.intra.peff.net>
 <CAGZ79kZ94PaOfq3GimWiHULbTE7ihMzL9S=Y+npQ4F5gGwFrsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ94PaOfq3GimWiHULbTE7ihMzL9S=Y+npQ4F5gGwFrsA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:
> On Mon, Jun 27, 2016 at 7:36 AM, Jeff King <peff@peff.net> wrote:
> > It's also true that our error rate will never be 0%. So some bugs will
> > always slip through, some review comments will be forgotten, etc. Eric
> > did find and fix the bug just now, so the "many eyes" theory did work
> > here eventually.
> 
> Eric, thanks for catching and fixing the bug!

No problem :)  I only noticed it because I was scanning emails
randomly and Duy and David's index-helper thread turned up.

> Quite a while ago, when I started doing code reviews professionally, I wondered
> if the code review procedure can be semi-automated, as automation helps keeping
> the error rate low. By that I mean having a check list which I can
> check off each point

Maybe a test case or even a small unit test would've helped.
I didn't notice the problem in xread until:

1) I copied the code into xwrite
2) s/POLLIN/POLLOUT/;
3) forced EAGAIN using a patched, home-baked HTTP server

The biggish comment before the poll() obscured the missing
"continue" for me.  I read xread() before and did not notice
the missing "continue".

Maybe the following optional patch on top of this series
improves readability:

----------8<--------
Subject: [PATCH 3/2] hoist out io_wait function for xread and xwrite

At least for me, this improves the readability of xread and
xwrite; hopefully allowing missing "continue" statements to
be spotted more easily.

Signed-off-by: Eric Wong <e@80x24.org>
---
 wrapper.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index d973f86..04bb952 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -227,6 +227,20 @@ int xopen(const char *path, int oflag, ...)
 	}
 }
 
+static void io_wait(int fd, short poll_events)
+{
+	struct pollfd pfd;
+
+	pfd.fd = fd;
+	pfd.events = poll_events;
+
+	/*
+	 * no need to check for errors, here;
+	 * a subsequent read/write will detect unrecoverable errors
+	 */
+	poll(&pfd, 1, -1);
+}
+
 /*
  * xread() is the same a read(), but it automatically restarts read()
  * operations with a recoverable error (EAGAIN and EINTR). xread()
@@ -243,18 +257,7 @@ ssize_t xread(int fd, void *buf, size_t len)
 			if (errno == EINTR)
 				continue;
 			if (errno == EAGAIN || errno == EWOULDBLOCK) {
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
+				io_wait(fd, POLLIN);
 				continue;
 			}
 		}
@@ -278,18 +281,7 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 			if (errno == EINTR)
 				continue;
 			if (errno == EAGAIN || errno == EWOULDBLOCK) {
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
+				io_wait(fd, POLLOUT);
 				continue;
 			}
 		}
-- 
EW

