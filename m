Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A4A2018B
	for <e@80x24.org>; Sun, 26 Jun 2016 23:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcFZXVd (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 19:21:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58156 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbcFZXVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 19:21:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A722018E;
	Sun, 26 Jun 2016 23:21:25 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] xwrite: poll on non-blocking FDs
Date:	Sun, 26 Jun 2016 23:21:12 +0000
Message-Id: <20160626232112.721-3-e@80x24.org>
In-Reply-To: <20160626232112.721-1-e@80x24.org>
References: <20160626232112.721-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

write(2) can hit the same EAGAIN/EWOULDBLOCK errors as read(2),
so busy-looping on a non-blocking FD is a waste of resources.

Currently, I do not know of a way for this happen:

* the NonBlocking directive in systemd does not apply to stdin,
  stdout, or stderr.

* xinetd provides no way to set the non-blocking flag at all

But theoretically, it's possible a careless C10K HTTP server
could use pipe2(..., O_NONBLOCK) to setup a pipe for
git-http-backend with only the intent to use non-blocking reads;
but accidentally leave non-blocking set on the write end passed
as stdout to git-upload-pack.

Followup-to: 1079c4be0b720 ("xread: poll on non blocking fds")

Signed-off-by: Eric Wong <e@80x24.org>
---
 wrapper.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index f1155d0..d973f86 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -274,8 +274,26 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 	    len = MAX_IO_SIZE;
 	while (1) {
 		nr = write(fd, buf, len);
-		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
-			continue;
+		if (nr < 0) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EAGAIN || errno == EWOULDBLOCK) {
+				struct pollfd pfd;
+				pfd.events = POLLOUT;
+				pfd.fd = fd;
+				/*
+				 * it is OK if this poll() failed; we
+				 * want to leave this infinite loop
+				 * only when write() returns with
+				 * success, or an expected failure,
+				 * which would be checked by the next
+				 * call to write(2).
+				 */
+				poll(&pfd, 1, -1);
+				continue;
+			}
+		}
+
 		return nr;
 	}
 }
