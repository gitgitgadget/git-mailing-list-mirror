From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Mon, 21 Sep 2015 15:39:08 -0700
Message-ID: <1442875159-13027-3-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:39:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kJ-0006NK-1m
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960AbbIUWj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:39:28 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36474 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbbIUWj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:26 -0400
Received: by padbj2 with SMTP id bj2so3591628pad.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wZh5r54A8inDkOpa0+U38NrsDvrAtnrcIDsHZiPbdxk=;
        b=JICHfLWZIa5qavvRUvNN5mO1/mTeBPwK8jXiBJM5qIOqDu6ee62DgZiNh8YLK9E+0R
         C/tFu2btwZsDT8/XFt7Ql9f5ZddKpT1ZLCUk+qSwg51jdMlwxAD34mOPqCHCFtvxsW9M
         weuX59MAoR2YANAZBW9z3CzM5rJpjuj1AflT+CL9/+EAJw/g9JO6BV9NDuKexuPj+yDn
         +0sjT979R+o782reVKa8S5720AECJYAJYT96orj2zs0wIY/4eFZ75CMNRcR0OwDInx3a
         DQK+1S+FI07Pdzy9tHnVwVydCdsJVE3EYVfMDaLczElgXf90K0oV8zuNlbBeqIld0/Tz
         5Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wZh5r54A8inDkOpa0+U38NrsDvrAtnrcIDsHZiPbdxk=;
        b=kxdwp2QhxR9h/45XPsz3czJE0aew/8/NoFJPggOlGGrJnv66btPg0n1u0NPOsns/37
         TUaQoj2YtebPb8pQUNCl2eQYTQxcuHcaqmq2VQjH4fwpjlFKsROeOF3UqxZGsoPWCxIf
         aJ3IxAsT2+W3WZQ4q/KKO8UDegIDkUFXXnB9kQllbvQJeYSBMJMZ7FxTFNZTsA3Ky7Jm
         okI0DoqmIGIOFRSp3EWOtPCQ1XMLPF9tGZ5zxmeD+52YX4WMncT7j0jz//Cv4PKJDo3L
         KtG1dVb9bdN9JAc2cElTxqZI0SvRLAZIsDj3n4DRygGyeHhsPJoddoTndwGM/ygWFiO6
         /fPw==
X-Gm-Message-State: ALoCoQnW0ziVV/Glj0pMVDfHOKfqNWzYVAwv2cCiCvg/R34c6Rm3KcDwLUEvugkRuXt02V3CW1BY
X-Received: by 10.66.175.7 with SMTP id bw7mr28240424pac.155.1442875166159;
        Mon, 21 Sep 2015 15:39:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id gw3sm26489660pbc.46.2015.09.21.15.39.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278336>

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

So if we get an EAGAIN or EWOULDBLOCK error the fd must be nonblocking.
As the intend of xread is to read as much as possible either until the
fd is EOF or an actual error occurs, we can ease the feeder of the fd
by not spinning the whole time, but rather wait for it politely by not
busy waiting.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 wrapper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index ff49807..50267a4 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -201,8 +201,23 @@ ssize_t xread(int fd, void *buf, size_t len)
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
+				int i;
+				pfd.events = POLLIN;
+				pfd.fd = fd;
+				i = poll(&pfd, 1, 100);
+				if (i < 0) {
+					if (errno == EINTR || errno == ENOMEM)
+						continue;
+					else
+						die_errno("poll");
+				}
+			}
+		}
 		return nr;
 	}
 }
-- 
2.5.0.275.ge015d2a
