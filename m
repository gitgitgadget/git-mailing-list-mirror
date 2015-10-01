From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 2/8] xread: poll on non blocking fds
Date: Wed, 30 Sep 2015 18:54:10 -0700
Message-ID: <1443664456-1307-3-git-send-email-sbeller@google.com>
References: <1443664456-1307-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 03:55:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhT5M-00006B-6Q
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 03:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbbJABy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 21:54:59 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34267 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbJAByb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 21:54:31 -0400
Received: by padhy16 with SMTP id hy16so57626885pad.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E9xUCpVR/CP9AYp2jIYXvXC9ZHJFGQyA5OwVoctdfeA=;
        b=MwiY653MsQhqx3M3xLY/APChd5dc76SimgarfVYPINLeQ8+KNpwGzkmBDv/fZP92T0
         A+QxVe1uP0jZC5ez1XUoEmToSX/M/FMNxWpf/zgF8xFtJFjTcov9pyer7u0WTd4Bdm2T
         7ke05103Cyg59jFQS0AK36YXGqEA8rbAizPiCBlQwJdEL4w8jsSk9oEMz4L/o0mhsPoZ
         ZuczSzco4G2cCrYc8XNICQrvmTHswPig9dN5Twu3o+4ZqUFfEq3waaFd1G0hXHNgzAgF
         z19D6hHKiYtZf67W3SreITQTLq9K9NfZiQGZh8w/skl+MzVCQaitjKo4uZNVcJ3I/eOV
         cHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E9xUCpVR/CP9AYp2jIYXvXC9ZHJFGQyA5OwVoctdfeA=;
        b=MoplChVsIxhsreiQJDYBfqYBzcOY3KKXE3uZ2kpZPAyqMzHA+qeHdI7EmY8ErKbB4p
         NJjISUqrwIoJaaBC9oFnZo8dcMIQKEuUnZgD9rTqs/UH6275QL8kFMKcudNoziGH6wh6
         P+TjG3AqsTra+E1SFDTaLRSVwECiFp7eSoyWAtBTeISxFsTM9q6jl8kH/oqXAGg2cdPz
         6wu+8Db+j1rS556/mTfCZPz6S+D5gyA5OmrjN6Hq3qvOBoI3LJuNb8agKmEJnAY5uxcU
         d/AhMo7JctoPW+6bxIvkJO5YI0NDT59B9e29xnT82S+dc1DJXUA4S3DZeuwH13dez+1m
         vZOA==
X-Gm-Message-State: ALoCoQkkULCJVD+sNg19bfO/2z+OHbmpdO50v/TxFQb/IR2+adX140nHc4UDWTbOqaPLkbuCKkor
X-Received: by 10.68.219.169 with SMTP id pp9mr8886855pbc.115.1443664471063;
        Wed, 30 Sep 2015 18:54:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8d91:1679:adb7:b916])
        by smtp.gmail.com with ESMTPSA id pq1sm3052011pbb.91.2015.09.30.18.54.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 18:54:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gf20166c.dirty
In-Reply-To: <1443664456-1307-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278871>

>From the man page:
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wrapper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index ff49807..5517928 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -201,8 +201,17 @@ ssize_t xread(int fd, void *buf, size_t len)
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
+				/* We deliberately ignore the return value */
+				poll(&pfd, 1, -1);
+			}
+		}
 		return nr;
 	}
 }
-- 
2.5.0.275.gf20166c.dirty
