From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] daemon.c:handle: Remove unneeded check for null pointer.
Date: Sun, 26 May 2013 21:54:40 +0200
Message-ID: <1369598080-9561-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 21:54:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugh1p-0007li-FD
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 21:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010Ab3EZTyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 15:54:49 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:62131 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab3EZTyt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 15:54:49 -0400
Received: by mail-ea0-f169.google.com with SMTP id m14so3637644eaj.28
        for <git@vger.kernel.org>; Sun, 26 May 2013 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=O3c2twcTTlYo7dMO7HysmwHQqnyVoQEl88dB4li+FfY=;
        b=lDdpvKRakXVDflk+CawPr95dn6/xYkkObYp2tbWY5com0YvaJUw6Dr1qVjkHNNv3L8
         v8T9CFsJJOrFALaWkqtfnxLgb2wjh2vJ5WzJRtPyALkoLT2lTcz45XB+/VZalaPbOCm/
         xL9c05vyU/xYbjy1yjC4yOljYn3u/3GTQqHV98Lwp1gx8lxih36kyPhwWMNfMh2wEQFj
         bssrGyLPGfVqitZLGFaeFOtLIhV9vp8ScaW0dUUVpQtXv37qZjctnYOLnWMpo2W2E/T4
         e4hethx1vETc0au1JDSTAS9/DTZ7rSOgaV9NkrW+9mWvBS5E56uAUNA84d1iBqY8bGmx
         ByCg==
X-Received: by 10.14.2.199 with SMTP id 47mr7345966eef.131.1369598087491;
        Sun, 26 May 2013 12:54:47 -0700 (PDT)
Received: from localhost (ip-109-90-70-123.unitymediagroup.de. [109.90.70.123])
        by mx.google.com with ESMTPSA id a5sm37258482ees.6.2013.05.26.12.54.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 26 May 2013 12:54:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225565>

The handle function has the signature
static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen);
so the addr pointer may be passed as null syntactically.

However there is just one place in daemon.c, which calls the handle
function in function service_loop in daemon.c:1044:
handle(incoming, &ss.sa, sslen);
so there is always a valid pointer for the sockaddr passed to the handle
function.

The code in question was to its place in f9c87be6, when following the
git blame it originates from 5b276ee4.
That commit 5b276ee4 also seems to copy around the ipv6 code block
and the sockaddr pointer check being null is introduced.
However that commit has already a redundant check on addr being a
null pointer before.

I am including the authors of said patches to the receivers.
---
 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 6aeddcb..5e48c1e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -760,7 +760,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
 		    ntohs(sin_addr->sin_port));
 #ifndef NO_IPV6
-	} else if (addr && addr->sa_family == AF_INET6) {
+	} else if (addr->sa_family == AF_INET6) {
 		struct sockaddr_in6 *sin6_addr = (void *) addr;
 
 		char *buf = addrbuf + 12;
-- 
1.8.3
