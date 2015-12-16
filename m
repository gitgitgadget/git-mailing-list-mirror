From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/7] xread: poll on non blocking fds
Date: Tue, 15 Dec 2015 16:04:07 -0800
Message-ID: <1450224252-16833-3-git-send-email-sbeller@google.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 16 01:04:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8za9-0005zR-FL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933631AbbLPAEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:04:24 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36679 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbbLPAEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:04:23 -0500
Received: by mail-pa0-f41.google.com with SMTP id nt2so3553375pab.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kjyog/2ViHAs+1Hc+O+T7UIJ2RAjtj9dLCkqxyaOQDw=;
        b=cv4hjRVdgEDu/2A4E3+UUu1fj/9v9nI8T4vzpZfN7D4PNAAkTmBXkTJ1ol2LDPV98C
         wTq0Nfq3ave0esnDbogvzG/Ui6x1kpusrrRlbD9aFZEm+0APW1jtoc9TiK1lXDd49tFA
         naVI2vwJxeEaIBTT9D8ljTfrUrD1I4CuFrcnLw/BUPvEJHWfaC186GS8T4H5FVIGmTCC
         ytEi7bmFQ9rTJzAiTy63zvlDkr/TH8Gd+XU2kLL6cMhOWSfQ476eK30pgRnay/UOYj0W
         QPND/PZHkA24hlNJV9Cs6DL4rwkPHVBxZJiNpKEgpKlBfYzdQ2khPKDcxBV2PKLRXNf0
         SIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kjyog/2ViHAs+1Hc+O+T7UIJ2RAjtj9dLCkqxyaOQDw=;
        b=SF0Rl4+kAGoxgdsL+c3GTzoYyDMzB5s3qqFU16X7tDfWqPupgNOEKGm6LASsV/jQ4s
         K/d69jGmJxs0wK/vPMQvDeSKMEfsdo/g5G2Jm3tJJk4CQHwAm5UOM+AC8GoePOAifor8
         NOMbt6YGz1kdBziR96UPhc60k8klAerz497FUgi942qJR9Ya+iSjFdpJgTl4XQ238/uV
         /5L1LTYwac5ACPIhv+OSW2Jppzs1C8BEvmM+DlqB5PgEbSJYusnK/oRz/ewPqHsrMlwq
         x8IKb8rxVskOpci2YWUrhhfqoISkLB8ba8X/oiY4nejRMjmSx1Dl/SISbQZyhUaVgQnO
         qzdg==
X-Gm-Message-State: ALoCoQkiWr3Wa2wzsEw73EE6sVcpOB8i2zNyuGkTUbUty/CSn74TZLtdIFxVFXA2VunKPUKQNDNdgjTWuRmLDY8AaetqJ+Obrw==
X-Received: by 10.66.62.201 with SMTP id a9mr58443131pas.7.1450224262443;
        Tue, 15 Dec 2015 16:04:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a171:258:4778:14b4])
        by smtp.gmail.com with ESMTPSA id 10sm398449pft.5.2015.12.15.16.04.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 16:04:21 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450224252-16833-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282519>

The man page of read(2) says:

  EAGAIN The file descriptor fd refers to a file other than a socket
	 and has been marked nonblocking (O_NONBLOCK), and the read
	 would block.

  EAGAIN or EWOULDBLOCK
	 The file descriptor fd refers to a socket and has been marked
	 nonblocking (O_NONBLOCK), and the read would block.  POSIX.1-2001
	 allows either error to be returned for this case, and does not
	 require these constants to have the same value, so a portable
	 application should check for both possibilities.

If we get an EAGAIN or EWOULDBLOCK the fd must have set O_NONBLOCK.
As the intent of xread is to read as much as possible either until the
fd is EOF or an actual error occurs, we can ease the feeder of the fd
by not spinning the whole time, but rather wait for it politely by not
busy waiting.

We should not care if the call to poll failed, as we're in an infinite
loop and can only get out with the correct read().

Signed-off-by: Stefan Beller <sbeller@google.com>
Acked-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wrapper.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 6fcaa4d..1770efa 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -236,8 +236,24 @@ ssize_t xread(int fd, void *buf, size_t len)
 	    len = MAX_IO_SIZE;
 	while (1) {
 		nr = read(fd, buf, len);
-		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
-			continue;
+		if (nr < 0) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EAGAIN || errno == EWOULDBLOCK) {
+				struct pollfd pfd;
+				pfd.events = POLLIN;
+				pfd.fd = fd;
+				/*
+				 * it is OK if this poll() failed; we
+				 * want to leave this infinite loop
+				 * only when read() returns with
+				 * success, or an expected failure,
+				 * which would be checked by the next
+				 * call to read(2).
+				 */
+				poll(&pfd, 1, -1);
+			}
+		}
 		return nr;
 	}
 }
-- 
2.6.4.443.ge094245.dirty
