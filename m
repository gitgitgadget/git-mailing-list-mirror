From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fast-import and unique objects.
Date: Tue, 8 Aug 2006 18:45:37 -0400
Message-ID: <20060808224537.GB18163@spearce.org>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com> <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com> <20060806180323.GA19120@spearce.org> <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com> <20060807050422.GD20514@spearce.org> <9e4733910608070737k52aaea7clf871d716d16547c2@mail.gmail.com> <20060808031240.GB19067@spearce.org> <9e4733910608080511t5aa96865p41d6bc1b85e236fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 09 00:45:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAaKX-0002Oq-OY
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 00:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWHHWpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 18:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWHHWpm
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 18:45:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:13965 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965065AbWHHWpl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 18:45:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GAaKI-0000AG-4p; Tue, 08 Aug 2006 18:45:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D4FD720FB77; Tue,  8 Aug 2006 18:45:37 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608080511t5aa96865p41d6bc1b85e236fa@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25096>

Jon Smirl <jonsmirl@gmail.com> wrote:
> We're designing a dumpfile format for git like the one SVN has.

I'm not sure I'd call it a dumpfile format.  More like an importfile
format.  Reading a GIT pack is really pretty trivial; if someone was
going to write a parser/reader to pull apart a GIT repository and
use that information in another way they would just do it against
the pack files.  Its really not that much code.  But generating a
pack efficiently for a large volume of data is slightly less trivial;
the attempt here is to produce some tool that can take a relatively
trivial data stream and produce a reasonable (but not necessarily
absolute smallest) pack from it in the least amount of CPU and
disk time necessary to do the job.  I would hope that nobody would
seriously consider dumping a GIT repository back INTO this format!

[snip]
> AFAIK the svn code doesn't do merge commits. We probably need a post
> processing pass in the git repo that finds the merges and closes off
> the branches. gitk won't be pretty with 1,500 open branches. This may
> need some manual clues.

*wince* 1500 open branches.  Youch.  OK, that answers a lot of
questions for me with regards to memory handling in fast-import.
Which you provide excellent suggestions for below.  I guess I didn't
think you had nearly that many...
 
[snip]
> The file names are used over and over. Alloc a giant chunk of memory
> and keep appending the file name strings to it. Then build a little
> tree so that you can look up existing names. i.e. turn the files names
> into atoms. Never delete anything.

Agreed.  For 1500 branches its worth doing.
 
[snip]
> About 100,000 files in the initial change set that builds the repo.
> FInal repo has 120,000 files.
> 
> There are 1,500 branches. I haven't looked at the svn dump file format
> for branches, but I suspect that it sends everything on a branch out
> at once and doesn't intersperse it with the trunk commits.

If you can tell fast-import your are completely done processing a
branch I can recycle the memory I have tied up for that branch; but
if that's going to be difficult then...  hmm.

Right now I'm looking at around 5 MB/branch, based on implementing
the memory handling optimizations you suggested.  That's still *huge*
for 1500 branches.  I clearly can't hang onto every branch in memory
for the entire life of the import like I was planning on doing.
I'll kick that around for a couple of hours and see what I come
up with.

-- 
Shawn.
