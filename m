From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2] Sleep 1 millisecond in poll() to avoid busy wait
Date: Mon, 28 Apr 2014 17:35:27 +0200
Organization: <)><
Message-ID: <20140428153527.GB12357@camelia.ucw.cz>
References: <20140428083931.GA10257@camelia.ucw.cz> <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com> <20140428113815.GA10559@camelia.ucw.cz> <20140428114224.GA11186@camelia.ucw.cz> <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com> <535E6E4B.6070308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, GIT Mailing-list <git@vger.kernel.org>,
	Theodore Leblond <theodore.leblond@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:35:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wenar-0000fc-My
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296AbaD1Pff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:35:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56416 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480AbaD1Pf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:35:28 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id A5ABB1C0073;
	Mon, 28 Apr 2014 17:35:27 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3SFZRr9012441;
	Mon, 28 Apr 2014 17:35:27 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3SFZRRX012440;
	Mon, 28 Apr 2014 17:35:27 +0200
Content-Disposition: inline
In-Reply-To: <535E6E4B.6070308@viscovery.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247367>

From: theoleblond <theodore.leblond@gmail.com>
Date: Wed, 16 May 2012 06:52:49 -0700

SwitchToThread() only gives away the rest of the current time slice
to another thread in the current process. So if the thread that feeds
the file decscriptor we're polling is not in the current process, we
get busy-waiting.

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

On Mon, Apr 28, 2014 at 05:05:47PM +0200, Johannes Sixt wrote:
> [...] but I very much prefer the commit message of the earlier post.

... but Paolo had a nice short description of the issue there;
I inserted that to the top of the earlier commit message.

The latter diff (without the comment), gets us closer to gnulib's poll.c.

Have a nice day,
	Stepan

 compat/poll/poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 31163f2..a9b41d8 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -605,7 +605,7 @@ restart:
 
   if (!rc && timeout == INFTIM)
     {
-      SwitchToThread();
+      SleepEx (1, TRUE);
       goto restart;
     }
 
-- 
1.9.2.msysgit.0.158.g6070cee
