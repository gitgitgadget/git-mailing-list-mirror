From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 2/8] xread: poll on non blocking fds
Date: Mon, 12 Oct 2015 11:47:15 -0700
Message-ID: <1444675641-14866-3-git-send-email-sbeller@google.com>
References: <1444675641-14866-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 20:47:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zli8V-0006Ox-NL
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbbJLSrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:47:32 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36314 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbJLSr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:47:29 -0400
Received: by pacex6 with SMTP id ex6so6694125pac.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D0vsC/XYybAQbgLl8GDMI4ZO0ET79Eu2NpwSBKfhsWk=;
        b=gGk+jnSoMrg+qzUE+PiXviXEFP/jWFFXDHC0+5ruxE/vU17e71vCd5B66DQkw2Y2ft
         LRQqeQjectOvCzuMmIe5/9OlNV7+TUuFOkC30UC2JS1FSs00z0rS0mewoe6+ZW4JW1XG
         SQlqIbLibJylCbJ1hBOIVXINIUR73mkRwdppnUr6HU2s4xb+STofdu+aMO4+8z5R19Vk
         c3x+qCrWRjJC+PcpCALFuFIY+fJzrr5bguveqMYtLKLimrW9SNpkEeJsLitgpidc1oSU
         vZZeheifn3nOfU7D/NQf/OyB9wGjsgW2LhX6ryYGcZerKpA0QtohFipDJrpPOWAZJrMR
         v0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D0vsC/XYybAQbgLl8GDMI4ZO0ET79Eu2NpwSBKfhsWk=;
        b=cQjr39dShLyrj5YfKNbMuFxQr6SwNKgWWEV5ULqpTtDoBUNjOGRkIZ0ZiuAAhPmbDd
         3hQjR/RuFwyu1EdfPyg3wEZ0S2fa+7SVe7sa7Kn1X9tJDxRXnWQQX/cRJJSyiTWtLsjm
         iFN+NlU0opIJ1afnj7wFdHmIL+MX/0wDJXZCLqvtLlTxBrg3op+4cjMyK9MjinNR6qha
         QwRdiSitkTIIvhuSKjXKV659U//dvfCy/ft8UrOnFbwO3suPc5DamkWX8cWYI5iQ1kJZ
         SETYWFKaKRsBR5UsjBMQ0tMwGzIH87S632/hhYMvI1biJywBvO8Y7jZY+pbbTtO9D1e6
         jAOQ==
X-Gm-Message-State: ALoCoQnzszsRLlkL9S+qKikb+J85iZM45BjKGNOoTNmTCwiOQLKL2pxgb0nJrbOgagMX5BBKxiK0
X-Received: by 10.66.141.70 with SMTP id rm6mr35592604pab.20.1444675648849;
        Mon, 12 Oct 2015 11:47:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id zn9sm19812152pac.48.2015.10.12.11.47.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 11:47:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.268.g453a26a
In-Reply-To: <1444675641-14866-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279395>

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
2.5.0.268.g453a26a
