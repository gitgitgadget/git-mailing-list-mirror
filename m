From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 05:08:00 -0500
Message-ID: <20070111100800.GB28309@spearce.org>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701102241230.4964@xanadu.home> <20070111080035.GA28222@spearce.org> <7v1wm16gyd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 11:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wrB-0007Lh-OX
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 11:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbXAKKIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 05:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbXAKKIJ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 05:08:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37900 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030247AbXAKKIG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 05:08:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4wqr-0005Jn-OC; Thu, 11 Jan 2007 05:08:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 45A8A20FBAE; Thu, 11 Jan 2007 05:08:01 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wm16gyd.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36574>

Junio C Hamano <junkio@cox.net> wrote:
> I looked at the algorithm, and after scratching my head for a
> while, I finally found it sane (modulo leaks, which I think I
> fixed with the attached patch).

Thanks.  I don't think it says much for the quality of my code
if you had to scratch your head before you understood it.  But
at least you finally got it.  :)
 
> One minor problem that you inherited from the original algorithm
> is the name priority.  If you have an annotated tag A and a
> lightweight tag b, and ask "git describe --tags" in this graph:
> 
>     ---o---o---o---o---x
>            A   b
> 
> you would still want to describe 'x' with A, not b.
> Unfortunately you don't (and the original doesn't either).

Actually I think you want to describe it with b.  If you ask
'--tags' then you want the lightweight ones too.  In the case above
the lightweight tag b better describes x as it has more in common
with x than A has.

> I think this is probably easy to solve in the loop that finds
> "all_matches"; once you hit an annotated tag, your traversal
> should stop in any case.  But if you were asked for --tags, and
> if your "initialized" piece did find both lightweight and
> annotated tags, you do not stop when you saw a lightweight one,
> but keep looking for an annotated one, ignoring any further
> lightweight ones.

I just implemented this in that loop, and then realized what
I wrote above.  The lower loop that performs the revision list
traversal would have both A and b in all_matches and b would win,
as its closer to x.  So having the first loop abort when it does
is the right thing to do, and so is describing x with b.

> Another thought.  I often do "git describe maint master next
> pu", and I see an opportunity for optimizing for such a
> multi-ref query.  Once you traversed the commits in
> "all_matches" loop, you know which strands of pearls are
> reachable to what tags, so you could hang that information
> somewhere (perhaps ->utils) in each commit.  But I think
> optimizing for a multi-ref query is probably not worth it.

Without my patch its ~170ms; with my patch its ~1000ms.  That is
a huge difference for such a simple program.  I'm not sure your
optimization will make a big difference.  The bulk of the cost
appears to be in the later loop, not in the earlier one that
produces all_matches.

-- 
Shawn.
