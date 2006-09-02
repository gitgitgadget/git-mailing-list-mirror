From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla .git tree
Date: Sat, 2 Sep 2006 13:39:22 -0400
Message-ID: <20060902173922.GA27826@spearce.org>
References: <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com> <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home> <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net> <20060902011950.GB24234@spearce.org> <7v8xl23oia.fsf@assigned-by-dhcp.cox.net> <20060902043931.GA25146@spearce.org> <7vveo6zfx0.fsf@assigned-by-dhcp.cox.net> <9e4733910609020720w3633aa0cq5016fb1e223fc4cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 19:41:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJZUu-0004k1-5U
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 19:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWIBRlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 13:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWIBRlc
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 13:41:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:21451 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751238AbWIBRlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 13:41:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJZUg-0001LH-K2; Sat, 02 Sep 2006 13:41:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A294520FB7C; Sat,  2 Sep 2006 13:39:22 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910609020720w3633aa0cq5016fb1e223fc4cb@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26346>

Jon Smirl <jonsmirl@gmail.com> wrote:
> If you're going to redo the pack formats another big win for the
> Mozilla pack is to convert pack internal sha1 references into file
> offsets.within the pack. Doing that will take around 30MB off from the
> Mozilla pack size. sha1's are not compressible so this is a direct
> savings.

Right now Junio's working on the index to break the 4 GiB barrier.
I think Junio and Nico have already agreed to change the base SHA1
to be an offset instead; though this is an issue for the current
way the base gets written out behind the delta as you need to know
exactly how many bytes the delta is going to be so you can correctly
compute the offset.
 
> This might reduce memory usage too. The index is only needed to get
> the initial object from the pack. Since index use is lighter it could
> just be open/closed when needed.

True; however when you are walking a series of commits (to produce
output for `git log` for example) every time you parse a commit you
need to go back to the .idx to relookup the ancestor commit(s).
So you don't want to open/close the .idx file on every object;
instead put the .idx file into the LRU like the .pack files are
(or into their own LRU chain) and maintain some threshold on how
many bytes worth of .idx is kept live.
 
> You could also introduce a zlib dictionary object into the format and
> just leave it empty for now.

No.  I'm not sure I'm ready to propose that as a solution for
decreasing pack size.  Now that my exams are over I've started
working on a true dictionary based compression implementation.
I want to try to get Git itself repacked under it, then try the
Mozilla pack after I get my new amd64 based system built.

If that's as big of space saver as we're hoping it would be then
the pack format would be radically different and need to change;
if it doesn't gain us anything (or is worse!) then we can go back
to the drawing board and consider other pack format changes such as
a zlib dictionary.  But right now its measly 4% gain isn't very much.

-- 
Shawn.

-- 
VGER BF report: U 0.653439
