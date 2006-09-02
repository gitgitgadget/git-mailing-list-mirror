From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sat, 2 Sep 2006 00:52:46 -0400
Message-ID: <20060902045246.GB25146@spearce.org>
References: <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com> <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home> <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com> <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> <7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0609011721390.27779@g5.osdl.org> <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 10:21:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJQkT-0005QF-Qm
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 10:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWIBIVB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 04:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIBIVB
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 04:21:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:15757 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750839AbWIBIVA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 04:21:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJQkD-0004mF-Tl; Sat, 02 Sep 2006 04:20:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9782D20FB08; Sat,  2 Sep 2006 00:52:46 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26324>

Junio C Hamano <junkio@cox.net> wrote:
> It might be worthwhile to disable revalidate reused objects
> individually and instead scan and checksum the entire .pack file
> when the number of objects being reused exceeds certain
> threshold, relative to the number of objects in existing pack,
> perhaps.

Correct me if I'm wrong but didn't this revalidate check happen
because the SHA1 of the pack was correct but there was a bad bit
in the zlib stream?

If we are trying to detect such an error before removing the possibly
valid pack how are we supposed to do that if we are bypassing the
code on larger packs?


I think the better thing to do here is to not repack objects which
are already contained in very large packs.  Just leave them be.

If the pack you are about to copy an object out of is over 25 MiB,
you aren't outputting to stdout and the object isn't needed
as a delta base in the new pack then don't copy it.  Introduce a
new flag to git-pack-objects such as "--max-source-pack-size=100"
which can be used to change this 25 MiB threshold; setting it to
0 would act as "-a" does today.

This way users can repack with 'git repack -a -d' as though it were
free and much less frequently (such as once a year) combine their
medium sized packs together based on a larger maximum threshold
while still ignoring their really large historical packs.

Note that you are never bypassing the deflate validation; before
copying an object you *always* validate it is correct, even if the
source pack SHA1 is correct.  But this time consuming validation
should not be a big issue as users shouldn't repack very large
packs very frequently with this strategy.  E.g. some kernel devs
might repack once a year with --max-source-pack-size=512 (512 MiB)
but during normal use accept the 25 MiB default and the slightly
larger number of small packs that result.

-- 
Shawn.

-- 
VGER BF report: U 0.5
