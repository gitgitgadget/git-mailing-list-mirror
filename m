From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v6 3/4] poll() exits too early with EFAULT if 1st arg is NULL
Date: Mon, 17 Sep 2012 09:02:20 +0200
Message-ID: <k36hu7$oaj$1@ger.gmane.org>
References: <k36h3i$ihb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 09:10:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDVTC-0007BH-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 09:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab2IQHKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 03:10:01 -0400
Received: from plane.gmane.org ([80.91.229.3]:44046 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425Ab2IQHKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 03:10:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TDVT1-00077k-Ll
	for git@vger.kernel.org; Mon, 17 Sep 2012 09:10:03 +0200
Received: from dsdf-4db53772.pool.mediaways.net ([77.181.55.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 09:10:03 +0200
Received: from jojo by dsdf-4db53772.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 09:10:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db53772.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205661>

If poll() is used as a milli-second sleep, like in help.c, by passing a NULL
in the 1st and a 0 in the 2nd arg, it exits with EFAULT.

As per Paolo Bonzini, the original author, this is a bug and to be fixed 
like
in this commit, which is not to exit if the 2nd arg is 0. It got fixed in
gnulib in the same manner the other day.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 compat/poll/poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/poll/poll.c b/compat/win32/poll.c
index 403eaa7..9e7a25c 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -349,7 +349,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)

   /* EFAULT is not necessary to implement, but let's do it in the
      simplest case. */
-  if (!pfd)
+  if (!pfd && nfd)
     {
       errno = EFAULT;
       return -1;
-- 
1.7.12 
