From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 23:11:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508232231110.23242@iabervon.org>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
 <7vhddgnw9q.fsf@assigned-by-dhcp.cox.net> <1124836282.14730.4.camel@toshiba>
 <7vzmr8mci2.fsf@assigned-by-dhcp.cox.net> <7vek8kmb2a.fsf@assigned-by-dhcp.cox.net>
 <7v3bp0m9ax.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Len Brown <len.brown@intel.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 05:08:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7lcI-0002Tx-A9
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 05:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVHXDHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 23:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVHXDHs
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 23:07:48 -0400
Received: from iabervon.org ([66.92.72.58]:14605 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750926AbVHXDHs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 23:07:48 -0400
Received: (qmail 18932 invoked by uid 1000); 23 Aug 2005 23:11:20 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Aug 2005 23:11:20 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bp0m9ax.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7700>

On Tue, 23 Aug 2005, Junio C Hamano wrote:

> Only lightly tested, in the sense that I did only this one case
> and nothing else.  For a large repository and with complex
> merges, "merge-base -a" _might_ end up reporting many
> candidates, in which case the pre-merge step to figure out the
> best merge base may turn out to be disastrously slow.  I dunno.

I think it's the right thing to do for now (and what I was going to
suggest), and if people find it too slow, we can consider teaching
read-tree to take multiple common ancestors and use any of them that gives
clear result on a per-file basis.

On the other hand, Tony might have hit a bad case with an ill-chosen
common ancestor for a patch/revert sequence, and we probably want to look
into that if we've got some history that demonstrates the problem. I think
that, if there are two common ancestors, one of which has applied a patch
and one of which hasn't, and on one side of the merge it gets reverted, we
should get the revert, but we'll only get it if we choose the ancestor
where it was applied.

(Letters are versions of the file, which 'b' being the bad patch; the
 second column is the two choices for common ancestor)

  a-b-a-?
 / X   /
a-b-b-b

Of course, you could have the two lines exactly flipped for a different
file in the same commits, or for a different hunk in the same file, and
there would be no single choice that doesn't lose the revert. The really
right thing to do is identify that there is a b->a transition that is not
a trivial merge and that is not beyond a common ancestor, but that's hard
to determine easily and with sufficient granularity to catch everything.

I still someday want to do a version of diff/merge for git that could
select common ancestors on a per-hunk basis and identify block moves and
avoid giving confusing (but marginally shorter) diffs, but that's a major
undertaking that I don't have time for right now.

	-Daniel
*This .sig left intentionally blank*
