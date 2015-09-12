From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] poll: honor the timeout on Win32
Date: Sat, 12 Sep 2015 17:50:26 +0000
Message-ID: <0000014fc2adfd6a-40802cb4-acb3-4b45-ac12-ce046f6c408b-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 20:02:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zap8G-0004W2-R9
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 20:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbbILSCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 14:02:10 -0400
Received: from a6-247.smtp-out.eu-west-1.amazonses.com ([54.240.6.247]:38347
	"EHLO a6-247.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751545AbbILSCJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2015 14:02:09 -0400
X-Greylist: delayed 700 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Sep 2015 14:02:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1442080226;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=WVxZfpVP7XkKuW3/nyhOHi26TcpVsJDb4z+Ys3Z8hNM=;
	b=XLX6Z11Wp5Vzvy8DvTdJPFt70PdRIQyi34cyiaA4gyF6Pp0Wgo2y4k98DZ/vyoUc
	SbDw+Q3ORdrx7v9keEkwODnKRkluDxY2s+7FFt/bf94tMNqm4muzlrIAMq2NhulCARn
	S5g0n058HilfiYVxRGgHd1D8vy4YzHT5O33tL90Y=
X-SES-Outgoing: 2015.09.12-54.240.6.247
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277731>

From: Edward Thomson <ethomson@microsoft.com>

Ensure that when passing a pipe, the gnulib poll replacement will not
return 0 before the timeout has passed.

Not obeying the timeout (and merely returning 0) causes pathological
behavior when preparing a packfile for a repository and taking a
long time to do so.  If poll were to return 0 immediately, this would
cause keep-alives to get sent as quickly as possible until the packfile
was created.  Such deviance from the standard would cause megabytes (or
more) of keep-alive packets to be sent.

GetTickCount is used as it is efficient, stable and monotonically
increasing.  (Neither GetSystemTime nor QueryPerformanceCounter have
all three of these properties.)

Signed-off-by: Edward Thomson <ethomson@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/poll/poll.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index a9b41d8..db4e03e 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -446,7 +446,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
   static HANDLE hEvent;
   WSANETWORKEVENTS ev;
   HANDLE h, handle_array[FD_SETSIZE + 2];
-  DWORD ret, wait_timeout, nhandles;
+  DWORD ret, wait_timeout, nhandles, start = 0, elapsed, orig_timeout = 0;
   fd_set rfds, wfds, xfds;
   BOOL poll_again;
   MSG msg;
@@ -459,6 +459,12 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
       return -1;
     }
 
+  if (timeout != INFTIM)
+    {
+      orig_timeout = timeout;
+      start = GetTickCount();
+    }
+
   if (!hEvent)
     hEvent = CreateEvent (NULL, FALSE, FALSE, NULL);
 
@@ -603,7 +609,13 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
 	rc++;
     }
 
-  if (!rc && timeout == INFTIM)
+  if (!rc && orig_timeout && timeout != INFTIM)
+    {
+      elapsed = GetTickCount() - start;
+      timeout = elapsed >= orig_timeout ? 0 : orig_timeout - elapsed;
+    }
+
+  if (!rc && timeout)
     {
       SleepEx (1, TRUE);
       goto restart;

--
https://github.com/git/git/pull/176
