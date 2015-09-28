From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/8] xread: poll on non blocking fds
Date: Mon, 28 Sep 2015 16:14:00 -0700
Message-ID: <1443482046-25569-3-git-send-email-sbeller@google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 01:14:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zghd2-0007Kf-Vo
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbbI1XOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:14:25 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33805 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbbI1XOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:14:24 -0400
Received: by padhy16 with SMTP id hy16so186626432pad.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g+wcV1UyjXdhh82jQ4bJcGEY4xIogMPjzLowg2P2U9o=;
        b=i09Kf4degk/dTNQNQXKdZ2GtpVoaSE2RuhfGdd2hloJKCqIFgmj0/TUfsj/QlXKAP5
         cRG6WoBS6w/aEXrtqBP6bXYxrmVj5MeHIK4NbZSziCKznoM/LhG1TKu07rHEhzkYNsbq
         rffdnsevTWfgNyd9scX4CXEtWV82DMQLbJZoZF8LBHnqLBZDBH/UvsmnbvcuA6fUSHq9
         MitIRHtPWu86OjOtiIqhY6WCf/2iNdG7h+GjVNwYS/NcyIp3YfvAV78xj+p+oiLZwTj5
         T0/M5oektF/kkQ+k2v1FjomRxktoS83ZXCy+BB0/Q3Q1TzQMO0aNKY0o/oqtGprMOvz9
         25pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g+wcV1UyjXdhh82jQ4bJcGEY4xIogMPjzLowg2P2U9o=;
        b=RZ/rjbtQ//LbmgJ/T08nWBnsmiZueWQQhnZvukDOnqbgEvhCCcY4oeAU5soO3oeIRO
         qXX9on1zLmuo6UvPZSOmwcs7GviD3/GqIqwg+tWOwEVs3EMs9EHPQNA++hxDVIyPmq1c
         5lw9KzdFx9rykdKFSEu1T4jalPfepdZ96M3A9dI5CVkZo02wEMc1KfKuH9r2pLmNPaeQ
         VuMV5m9R79q388cgvDpeGDnYZ9wGYKqd5lYEDZ7YQJWFNCi4zA8oaEZXzhI8ZzOXs97B
         4PkrLf9ck09bk5k9O3lUkI/jvzLxKQJmSkoIF40suRLKDArnvYsY1oC11jVym5Y2HZqo
         98zw==
X-Gm-Message-State: ALoCoQnnOuKwzZJlxnSdWe9K8v+j2x+Lgsey/6YM+KqRDHQ3JCaklrFaZWkwQG+x2gngtB1DqtwT
X-Received: by 10.66.190.41 with SMTP id gn9mr29033276pac.0.1443482063752;
        Mon, 28 Sep 2015 16:14:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:79ce:7412:e4be:3e39])
        by smtp.gmail.com with ESMTPSA id si1sm21463717pbc.72.2015.09.28.16.14.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 16:14:23 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <1443482046-25569-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278806>

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
2.5.0.273.g6fa2560.dirty
