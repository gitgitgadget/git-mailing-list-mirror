From: Shawn Pearce <spearce@spearce.org>
Subject: Segfault in xdl_merge is back
Date: Tue, 26 Dec 2006 23:16:44 -0500
Message-ID: <20061227041644.GA22449@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 05:17:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzQDs-0001fz-Rl
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 05:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbWL0EQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 23:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbWL0EQv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 23:16:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51095 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900AbWL0EQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 23:16:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzQDS-00074u-3b; Tue, 26 Dec 2006 23:16:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C149020FB65; Tue, 26 Dec 2006 23:16:44 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35444>

So I've been able to reproduce the segfault that was earlier reported
in xdl_merge.  Unfortunately its in the repo that I can't publish.
I plan to spend some time tomorrow evening to attempt to further
debug the problem.  I would certainly appreciate any advice.  :-)

I can say its *not* related to 1510fea7 (or its fix 5caf9232 for
that matter).  Tonight I only had a few minutes to look at the issue
but reverting 1510fea7/5caf9232 does not fix the segfault on Cygwin,
even though 5caf9232 appears to have fixed the issue for the original
reporter on Linux.

If I recall it correctly we were segfaulting on line 197 of xmerge.c:

    197         t1.ptr = (char *)xe1->xdf2.recs[m->i1]->ptr;

according to my particular case m->i1 == 70, but it looks like
xdf2.recs isn't that large as index 70 is not a valid pointer.

I'm suspecting this is actually some sort of memory corruption in
the heap (due to a bad malloc/free) as the bug seems to rear its
head only based on the data we are allocating/have allocated.

If you look at what 1510fea7 would do on Linux the 1510fea7 bug
would send us into the else case of diff_populate_filespec where we
malloc the file data during decompression from the pack.  Yet when
we fixed it with 5caf9232 we started to mmap the working tree file,
avoiding the malloc/free.  This behavior, plus the fact that it
happens no matter what for a particular merge on Cygwin (but not
other merges), leads me to suspect heap corruption.

I may try to bisect this on Cygwin, but I may need to go all the way
back to pre-xdl_merge() to get a working merge-recursive, and I may
just find the bug pointing at the original merge-recursive code,
or just find it pointing at a random commit like what happened
with 1510fea7.  So bisection may not really help out very much.

Has anyone run merge-recursive through Valgrind lately?  I don't
have a setup handy to run it through and see if we have any obvious
errors.

-- 
Shawn.
