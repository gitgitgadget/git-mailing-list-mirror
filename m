From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/8] xread: poll on non blocking fds
Date: Mon, 14 Dec 2015 11:37:12 -0800
Message-ID: <1450121838-7069-3-git-send-email-sbeller@google.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 20:37:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8YwC-0003B1-0N
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbbLNThd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:37:33 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33576 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbbLNThb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:37:31 -0500
Received: by pfnn128 with SMTP id n128so110419013pfn.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 11:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o8nEiyyk1fx7wLrkxgcPofqZ8hxVrR/PTkytzuq3nk0=;
        b=l4hOXDr7dw5uGCasqFox+2Aj6DQS8hbB0zIcUEyZCHQF0S+DjFBwSY964s7iC2SpCX
         CmC/1Doa8utp/Bc4pxWnjEITHeCa4+WAP8pXEOJVEDxWOfSnZHTTCyZI/9kQSqjHuwNm
         U2OL7dXjt711R3lAog1lshDotjbhWvZw2P9Sxe6twz7qxq3UnrDqWX9WIkVCWjnVlSrP
         HEb8JMDTWjW9KQYPjHaTYT/4AUoYcoP6rqTThvcmB7/gRGUrWst4MwJq4Xln+ZXNu4uk
         js4rAy9WvsazHFwjzJynIglMTPPz1oribqjU39/XZBTfiTSm9rWHhaiQdzRwyA1btzNS
         ElXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o8nEiyyk1fx7wLrkxgcPofqZ8hxVrR/PTkytzuq3nk0=;
        b=IewZZDx1uQYqgkyo9bL7QsMLpp8vM3+/NxyhPNqrHdF7gLXUeFdSM81Yrka5buxy+e
         SW4ax7HaTipqSRQ8id59NVuL+oseY0XKuyn95w3D4WS4NM0w9yQA3ynQEGukhtEWg6jl
         GK/IcWZrxjzeV5gzp1qiXRFXsZwX8e0RZGrbzOFgYAup/JqI+rlw70pCgo8ZlHhPKcUC
         ZKUEOZ4rz6IkDTwWErveRdClQwA81MLgDrhjhDvcROECqKdcC75+F45FFTw2hUfryH/8
         ylrwLQNxmwVLTL8NzSPA7/2tHQBcNtiRyQLBV91xTqCgaIdtMWfw8C8zlOBIHBZaUygz
         fQjw==
X-Gm-Message-State: ALoCoQkC4fVLgRZ+goH9cJzk93jpl4gTMtD3mgNKUa0sFgh4x6ro9zVB9uBibdJmguicfcYOWdQT/j/HD/rwBAhWBlMq7gSTGg==
X-Received: by 10.98.70.70 with SMTP id t67mr6654192pfa.27.1450121850813;
        Mon, 14 Dec 2015 11:37:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a894:af1d:9081:95fb])
        by smtp.gmail.com with ESMTPSA id n16sm44119527pfa.53.2015.12.14.11.37.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 11:37:29 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450121838-7069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282386>

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
index 6fcaa4d..4f720fe 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -236,8 +236,17 @@ ssize_t xread(int fd, void *buf, size_t len)
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
2.6.4.443.ge094245.dirty
