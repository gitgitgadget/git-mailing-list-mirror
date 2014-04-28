From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] Sleep 1 millisecond in poll() to avoid busy wait
Date: Mon, 28 Apr 2014 10:39:31 +0200
Organization: <)><
Message-ID: <20140428083931.GA10257@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: theoleblond <theodore.leblond@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 10:39:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weh6F-0007Wq-FN
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 10:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbaD1Ijh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 04:39:37 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48663 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbaD1Ijd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 04:39:33 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id BC9C41C00A0;
	Mon, 28 Apr 2014 10:39:31 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3S8dVWv010277;
	Mon, 28 Apr 2014 10:39:31 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3S8dVfH010276;
	Mon, 28 Apr 2014 10:39:31 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247244>

From: theoleblond <theodore.leblond@gmail.com>
Date: Wed, 16 May 2012 06:52:49 -0700

I played around with this quite a bit. After trying some more complex
schemes, I found that what worked best is to just sleep 1 millisecond
between iterations. Though it's a very short time, it still completely
eliminates the busy wait condition, without hurting perf.

There code uses SleepEx(1, TRUE) to sleep. See this page for a good
discussion of why that is better than calling SwitchToThread, which
is what was used previously:
http://stackoverflow.com/questions/1383943/switchtothread-vs-sleep1

Note that calling SleepEx(0, TRUE) does *not* solve the busy wait.

The most striking case was when testing on a UNC share with a large repo,
on a single CPU machine. Without the fix, it took 4 minutes 15 seconds,
and with the fix it took just 1:08! I think it's because git-upload-pack's
busy wait was eating the CPU away from the git process that's doing the
real work. With multi-proc, the timing is not much different, but tons of
CPU time is still wasted, which can be a killer on a server that needs to
do bunch of other things.

I also tested the very fast local case, and didn't see any measurable
difference. On a big repo with 4500 files, the upload-pack took about 2
seconds with and without the fix.
---

This is one of the patches that lives in msysGit, could it be
accepted upstream?
It modifies the Windows compat function only.

Have a nice day,
	Stepan

 compat/poll/poll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 31163f2..c5a9a93 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -605,7 +605,9 @@ restart:
 
   if (!rc && timeout == INFTIM)
     {
-      SwitchToThread();
+      /* Sleep 1 millisecond to avoid busy wait */
+      SleepEx(1, TRUE);
+
       goto restart;
     }
 
-- 
1.9.2.msysgit.0.158.g6070cee
