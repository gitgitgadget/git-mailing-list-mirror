From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Wed, 18 Jul 2007 14:05:02 +0200
Message-ID: <20070718120502.GZ999MdfPADPa@greensroom.kotnet.org>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707141140510.14781@racer.site>
 <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707160054340.14781@racer.site>
 <20070716102407.GL999MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707181153200.14781@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB8HG-0005hK-0N
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 14:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbXGRMFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 08:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbXGRMFG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 08:05:06 -0400
Received: from smtp13.wxs.nl ([195.121.247.4]:64567 "EHLO smtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754440AbXGRMFE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 08:05:04 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JLD00JNQIWEXZ@smtp13.wxs.nl> for git@vger.kernel.org; Wed,
 18 Jul 2007 14:05:03 +0200 (CEST)
Received: (qmail 23523 invoked by uid 500); Wed, 18 Jul 2007 12:05:02 +0000
In-reply-to: <Pine.LNX.4.64.0707181153200.14781@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52855>

On Wed, Jul 18, 2007 at 12:02:50PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 16 Jul 2007, Sven Verdoolaege wrote:
> 
> > On Mon, Jul 16, 2007 at 01:38:11AM +0100, Johannes Schindelin wrote:
> > > On Sun, 15 Jul 2007, Sven Verdoolaege wrote:
> > > > TREECHANGE is only set when path pruning is in effect.
> > > > If I didn't check for path_pruning, then all commits would be
> > > > considered to have been pruned.  (Or am I missing something?
> > > > Honestly, I found all that TREECHANGE stuff difficult to follow.)
> > > 
> > > AFAICT TREECHANGE means that parents were rewritten.
> > 
> > I think you'll find that if all commits touch a path in the
> > path specifiers then all commits will have TREECHANGE set and
> > so no parents will be rewritten.
> 
> The code suggests otherwise.

Check again.

> But I really have to wonder: why do you play games with TREECHANGE?  I had 
> the impression that commit->parents is set appropriately by the revision 
> walker,

Only for unpruned commits and the references (explicitly specified
on the command line if you wish) may have been pruned.

> > > > revision.c itself is also riddled with "prune_fn && ".
> > > > Wouldn't it make sense to invert the meaning of this bit and call
> > > > it, say, PRUNED, so that the default is off and you would only
> > > > have to check if the bit was set ?
> > > 
> > > You meant the TREECHANGE bit?  No.
> > 
> > Yes.  Why?
> 
> Why invert the meaning of a perfectly fine bit?  Because you can?  It is 
> working right now, and it is not even a buglet, so what is there to fix?

Because it is confusing.  As explained above, the bit doesn't have a
meaning of its own.  You can only interpret the bit if some other
conditions are met.
It would be even more confusing if it meant what you claim it means.

> 
> > > BTW what do you plan to do about my objection to UNINTERESTING, given 
> > > the example "git rewrite-commits A..B x/y"?
> > 
> > That was based on an apparent misunderstanding of my code
> > that I tried to address above.  I did not intend to do what
> > you claim I do and a quick test confirms that my code does
> > indeed not to what you claim it does.
> > 
> > More specifically, the history will not be cut off at A
> > because A is marked UNINTERESTING and is therefore not considered
> > to have been pruned.
> 
> Why do you test for TREECHANGE | UNINTERESTING then?

Exactly for the reason mentioned above.
If the commit is marked UNINTERESTING then it has not been pruned,
because it hasn't even been checked for TREECHANGE.

> > A commit is considered pruned if it was either explicitly marked
> > as such or if TREECHANGE is not set, but the later check (in is_pruned)
> > is only done on commits that were checked for tree changes.
> 
> I don't understand.  What do you mean by "a commit is pruned"?  Does it 
> mean that this commit was left out from the revision walk?  What does that 
> have to do with TREECHANGE, which means that the parents set was modified?

You just claim that that is what it means.  The code (see try_to_simplify_commit
where the bit is set) and a simple experiment (explained above) show otherwise.

skimo
