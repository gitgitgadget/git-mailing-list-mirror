From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sun, 11 Feb 2007 02:23:58 -0500
Message-ID: <20070211072358.GB2082@spearce.org>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com> <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de> <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com> <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de> <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com> <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702101049480.1757@xanadu.home> <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702101131070.1757@xanadu.home> <Pine.LNX.4.64.0702100913020.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 08:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG94b-0008Hv-93
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 08:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbXBKHY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 02:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbXBKHY3
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 02:24:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52802 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbXBKHY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 02:24:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HG944-00031o-73; Sun, 11 Feb 2007 02:24:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5B0EF20FBAE; Sun, 11 Feb 2007 02:23:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702100913020.8424@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39276>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> It's not even a "technical issue". It's a fundamental optimization. Sure, 
> you can call optimizations just "technical issues", but the fact is, it's 
> one of the things that makes git so _usable_ on large archives. At some 
> point, an "optimization" is no longer just about making things slightly 
> faster, it's about something much bigger, and has real semantic meaning.
> 
> So the fact is, "git status" _needs_ to refresh the index. Because if it 
> doesn't, you'll see every file that doesn't match the index as "dirty", 
> and that is not just a "technical issue".

Indeed.  Except that `git-update-index --refresh` is itself not
very fast on Cygwin+NTFS and large projects (about the size of
the kernel).  So git-status is a real slouch there.  Not running
`git update-index --refresh` saves at least a couple of seconds.

This is why git-gui lets you disable the refresh, and is part of
the reason why it computes the status on its own by diff-index,
diff-files and ls-files --others.
 
> THIS IS NOT "JUST A TECHNICAL ISSUE". 
> 
> When the difference is 40 seconds vs 4 (uncached), or 2 seconds vs 0.06, 
> it's not about "just an optimization" any more. At that point, it's about 
> "unusable vs usable".
> 
> And yeah, waiting 40 seconds for a global "diff" for a big project may be 
> something that a person coming from CVS considers to be just par for the 
> course. Maybe I'm just unreasonable. But I think it's a _bug_ if I can't 
> get a small diff in about a tenth of a second. It needs to be so fast that 
> I never even _think_ about it.

Yes.  Which is why if git-gui finds a file that has an empty diff,
but that was reported as modified by diff-files, it tells the user
its about to go waste a few seconds running `update-index --refresh`,
then does so.

In practice I've found it rare that a file is dirty in the index,
but is not actually modified.  The typical culprit appears to
actually be the virus scanner on a Windows system.  For some reason
it feels a need to modify some random XML 'source' files that are
tracked by Git.  Out of 30,000 files it likes to modify about 100.
*sigh* At least I have Git to tell me it didn't change any content.
 
> I think it would be much better if "git status" always wrote the refreshed 
> index file. It could then choose to ignore any errors if they happen, 
> because if you have a broken setup like the NTFS read-only thing, then 
> tough, it's broken, but git can't do anythign about it. But people should 
> be aware that yes, "git status" absolutely _needs_ to write the index 
> file. 

Not only that, but I think we can do much better with git-runstatus
than we do now.  If we scan the working directory (to search for
untracked files), and we walk the index in parallel, we can update
the index with new stat data if necessary.

Of course that doesn't matter much on Linux; its VFS operations
don't take hours.

-- 
Shawn.
