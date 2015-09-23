From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 02/14] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 18:45:20 -0700
Message-ID: <1442972732-12118-3-git-send-email-sbeller@google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:46:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ8I-0007Dx-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759982AbbIWBpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:45:45 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33729 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbIWBpi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:38 -0400
Received: by pacex6 with SMTP id ex6so25230537pac.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wbthosLJvpHoQbSsEqvJHfH1N0r+1v2JdKsHqWhhc4o=;
        b=lsC1VPD5FhlWYgOWzCRJVXU6sd1/KDZ7qWz4S2vKG8s4qXNm+U8USqFcyF+D3PZcuV
         txuekrS5Rpg5XzzGNPpehb11j55rwWOKVD6yAo10qjX5AtR3cVaU0CadI0w3d3Qrwepe
         bFo3WqSTDifihTFEWpo7LHFn3jP95BMYm8P3j6zhRxJr9SGkvGSLjbceu/dyLOfkV9GW
         ib6xs480grm74KLM93fiEB77Hj3hu3rYnuYQJBVCiH7gizHkul0xmx643ltW4lN5E36Q
         5nHhAYLZisVmoPbBpE1cxi4k6zHoCe8bc/WngyMtWIYOVAAWYNR6acMgxgSA/FzgK2RM
         aYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wbthosLJvpHoQbSsEqvJHfH1N0r+1v2JdKsHqWhhc4o=;
        b=KSR/vGnChw0wNG2rqLX6LXb6nNu/mKkth0ROHkV2vv80fm08kAb0gSB7/cGfBWXsyi
         5tQWeJLhezhcg7HYhDrseyqCWLLevYI38SBbyFj0sHEL9M/OHXtXVeNO/fBeOjh/enmE
         euB/TUg0gPzeShagmjoKahF4qgTWxmTbLGga0SI3fcFQh3y0q40J2FacJY5EBwe1TERl
         6xQylnELlvWgtuKVB77a0dZRlqNkdoY7kmmexkBO2PuKC5Ps5X9USiVXCjHt10JEqTOk
         Ap41gxROqWlzHfBIXiUs+4F/UigZagujngRGww+oFucmet9q71eKXM+x/adJO3U6JtyJ
         MCFg==
X-Gm-Message-State: ALoCoQlWjGJ+GN3T+sl7WVAyw1Cwjrys9G7krKa4kJpGKg5g5WZoBtTi4ngzt5+9h9IGVAUA3F7m
X-Received: by 10.68.227.8 with SMTP id rw8mr34844211pbc.74.1442972738479;
        Tue, 22 Sep 2015 18:45:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id mn2sm4571121pbc.75.2015.09.22.18.45.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
In-Reply-To: <1442972732-12118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278457>

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
2.5.0.272.ga84127c.dirty
