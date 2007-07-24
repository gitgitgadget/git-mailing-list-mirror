From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Wed, 25 Jul 2007 00:56:20 +0200
Message-ID: <200707250056.20880.robin.rosenberg.lists@dewire.com>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net> <200707241134.31950.robin.rosenberg.lists@dewire.com> <alpine.LFD.0.999.0707241144490.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 00:57:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDTKG-0004Bx-73
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 00:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbXGXW52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 18:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754296AbXGXW5I
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 18:57:08 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15140 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753492AbXGXW5H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 18:57:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 029898026C7;
	Wed, 25 Jul 2007 00:49:50 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00578-02; Wed, 25 Jul 2007 00:49:49 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 73BED80019B;
	Wed, 25 Jul 2007 00:49:49 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LFD.0.999.0707241144490.3607@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53655>

tisdag 24 juli 2007 skrev Linus Torvalds:
> 
> On Tue, 24 Jul 2007, Robin Rosenberg wrote:
> >
> > 27778 time(NULL)                        = 1185268822
> > 27778 gettimeofday({1185268822, 953340}, NULL) = 0
> > 
> > Here CVS sleeps. The amount varies between invocations since it
> > only sleeps enough for the seconds to wrap.
> > 
> > 27778 nanosleep({0, 46660000}, NULL)    = 0
> > 27778 time(NULL)                        = 1185268823
> 
> Btw, this is *really* dangerous and buggy.
> 
> The reason? The CPU real-time clock is very different from whatever clock 
> the filesystems may use.
> 
> Filesystems generally do not use the same clock as the CPU does. That's 
> obviously true for things like networked filesystems, but it's actually 
> true even for local filesystems (even on UP) because the CPU "realtime" 
> clock rather expensive and much too exact for them. It does all the fancy 
> NTP date correction etc, and it has all the complex code to actually make 
> sure you don't get any time jumps etc.

Having our mind enlightened, I propose this or nothing as a workaround. Since
cvsexportcommit is really a CVS workaround we might work around some bugs
in CVS itself while we're at it.

-- robin

From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Wed, 25 Jul 2007 00:53:24 +0200
Subject: [PATCH] Sleep in git-cvsexportcommit

If git cvsexportcommit is executed fast enough in sequence, the CVS
timestamps could end up being the same. CVS tries to fix this
by sleeping until the CPU clock changes seconds. Unfortunately,
the CPU clock and the file system clock are not necessarily the same, so
the timestamps could be the same anyway. When that happens CVS may not
recognize changed files and cvs will forget to commit some files.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 git-cvsexportcommit.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d6ae99b..f6366be 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -277,6 +277,11 @@ if ($opt_c) {
 # clean up
 unlink(".cvsexportcommit.diff");
 
+# CVS version 1.11.x and 1.12.x sleeps the wrong way to ensure the timestamp 
+# used by CVS and the one set by subsequence file modifications are different.
+# If they are not different CVS will not detect changes.
+sleep(1);
+
 sub usage {
 	print STDERR <<END;
 Usage: GIT_DIR=/path/to/.git ${\basename $0} [-h] [-p] [-v] [-c] [-f] [-m msgprefix] [ parent ] commit
-- 
1.5.2.3
