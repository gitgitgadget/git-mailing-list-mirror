From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 13:02:36 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809111222170.23787@xanadu.home>
References: <20080909132212.GA25476@cuci.nl>
 <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
 <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com>
 <20080911123148.GA2056@cuci.nl>
 <alpine.LFD.1.10.0809111047380.23787@xanadu.home>
 <20080911160040.GE2056@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 19:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdpaf-0001w3-GI
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 19:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbYIKRDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 13:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbYIKRDN
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 13:03:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61632 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbYIKRDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 13:03:13 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K71001JNJCC20C1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 11 Sep 2008 13:02:37 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080911160040.GE2056@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95622>

On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:

> Let me try and describe once more the typical environment this origin field
> is vital in:
> 
> Imagine a repository with:
> - 33774 commits total
> - 13 years of history
> - 1 development branch
> - 9 stable branches (forked off of the development branch at regular
>   intervals during the past 13 years).
> - The stable branches are never merged with each other or with the
>   development branch.
> - 2787 individual back/forward ports between the development and stable
>   branches.
> 
> In order to have meaningful output for git-blame, it needs to follow the
> chain across cherry-picks reliably.
> Once you alter a piece of code, in order to figure out what more to alter,
> you need to verify if this piece of code was or wasn't forward/backported.
> Reliable and fast reporting of this, and actual comparison of the
> different forward/backports between the 9 branches is essential.  It
> basically means that you need to view the diffs of the patches across 9
> branches on a regular basis.
> 
> Without the origin links, this workflow will cost a lot more time to
> pursue (I know it, because I'm living it at the moment, and no, I'm not
> the only developer, it's a development team).
> 
> This development model is not unique to my situation, it occurs at more
> places.

OK.  I think I might be able to believe you.

Where I feel uncomfortable is with the real semantics of your "origin" 
link proposal.

First, its name.  The word "origin" probably has a too narrow meaning 
that creates confusion.  I'd suggest something like a 
"may-be-related-to" field that would be like a weak link.

The format of a may-be-related-to field would be the same as the parent 
field, except that the object pointed to by the sha1 could have its type 
relaxed, i.e. it could be anything like a blob or a tag.

The semantics of a "may-be-related-to" link would be defined for object 
reachability only:

- If the may-be-related-to link is dangling then it is ignored.

- If it is not dangling then usual reachability rules apply.

That's all the core git might care about, and the only real argument for 
not having this information in the free form commit message.

Still, in your case, you probably won't get rid of your stable branches, 
hence the reachability argument is rather weak for your usage scenario, 
meaning that you could as well have that info in the free form text 
(like cherry-pick -x), and even generate a special graft file from that 
locally for visualization/blame purposes.  Sure the indirection will add 
some overhead, but I doubt it'll be measurable.

People fetching your main branch won't have to carry the whole 
repository because those weak links would otherwise be followed if 
they're formally part of the commit header.  And if they want 
to benefit from the information those weak links carry then they just 
have to also fetch the branch(es) where those links are pointing.  At 
that point it is trivial to regenerate the special graft file locally 
which would also have the benefit of only containing links to actually 
reachable commits, hence you'd never have dangling "origin" links.

Conclusion: the only fundamental reason for having this weak link 
information in the commit header is for reachability convenience for 
when the actual branch that contained the referenced commits is gone, 
which IMHO is a bad justification.  Having lines of developments hanging 
off of a weak link alone is just plain stupid if you can't reach it via 
proper branches or tags.

So I think that your usage scenario is a valid one, but I think that you 
should implement it some other ways, like this special graft file I 
mentioned above, which can be generated and updated from custom 
information found in the free form comment text of a commit object, and 
that proper reachability issues should continue to be handled through 
proper branches and tags as it is done today.


Nicolas
