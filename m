From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 20:44:05 +0200
Message-ID: <20080911184405.GA1451@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <alpine.LFD.1.10.0809111047380.23787@xanadu.home> <20080911160040.GE2056@cuci.nl> <alpine.LFD.1.10.0809111222170.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 20:45:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdrAM-0007XS-4m
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 20:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYIKSoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 14:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYIKSoJ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 14:44:09 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:44900 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYIKSoI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 14:44:08 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 59A7E5465; Thu, 11 Sep 2008 20:44:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809111222170.23787@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95627>

Nicolas Pitre wrote:
>On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
>> Let me try and describe once more the typical environment this origin field
>> is vital in:

>> Without the origin links, this workflow will cost a lot more time to
>> pursue (I know it, because I'm living it at the moment, and no, I'm not

>First, its name.  The word "origin" probably has a too narrow meaning 
>that creates confusion.  I'd suggest something like a 
>"may-be-related-to" field that would be like a weak link.

Well, the important properties of the name/field would be:
- It should be as specific as possible, in order to minimise the
  potential for abuse in the future.  I distill the desirability of this
  requirement out of the various earlier discussions about commitheaders
  in the past on this mailinglist held by others.
- It should convey a sense of direction (it's a directed graph).

Any generic may-be-related-to field is therefore probably a non-starter.

>The semantics of a "may-be-related-to" link would be defined for object 
>reachability only:
>- If the may-be-related-to link is dangling then it is ignored.
>- If it is not dangling then usual reachability rules apply.
>That's all the core git might care about, and the only real argument for 
>not having this information in the free form commit message.

The origin field as currently proposed tightens the requirements that
it either is dangling and ignored or points to a commit.
rev-list --topo-order should use the origin links to order the output.
gc/prune won't delete commits referenced *by* an origin link.

The only two other arguments one might give to actually keep the field
in the header of the commit as opposed to the trailer is that the 
physical field can be kept machine readable, and the actual display can be
beautified like:  Origin: 2abcdef..1234567
The output of the field could be suppressed (if so desired) if the
target commit isn't reachable.
All this is of course possible for a trailer field in the free-form
area as well, but it seems a bit silly to have two places for "headers".

>Still, in your case, you probably won't get rid of your stable branches, 

True.

>hence the reachability argument is rather weak for your usage scenario, 

Then again, I don't want to be bothered by stupid free-form origin links
made to local branches by a developer.  If the developer creates them
using cherry-pick -o which creates an origin link, I'll never have to
see his silly commit hashes where he is referring to commits in his
local branch (and never waste time wondering where those commits are).

>meaning that you could as well have that info in the free form text 
>(like cherry-pick -x), and even generate a special graft file from that 
>locally for visualization/blame purposes.  Sure the indirection will add 
>some overhead, but I doubt it'll be measurable.

The free-form equivalent looks like:
Origin: df85f7855da44c730f942b330ada181209d09d7a ff1e8bfcd69e5e0ee1a3167e80ef75b611f72123
You need a pair of hashes, which is, a bit bulky, for my taste.

What special graft file would I need to visualise?  Isn't having the
origin link information enough?

>People fetching your main branch won't have to carry the whole 
>repository because those weak links would otherwise be followed if 
>they're formally part of the commit header.  And if they want 
>to benefit from the information those weak links carry then they just 
>have to also fetch the branch(es) where those links are pointing.  At 
>that point it is trivial to regenerate the special graft file locally 
>which would also have the benefit of only containing links to actually 
>reachable commits, hence you'd never have dangling "origin" links.

You lost me here somewhere.  Could you give a concrete example with one
commit, one origin link (your style) and a special graftfile entry?

>Conclusion: the only fundamental reason for having this weak link 
>information in the commit header is for reachability convenience for 
>when the actual branch that contained the referenced commits is gone, 

Erm.  Quite the opposite, actually.
The practical use for the origin link in case the target is unreachable
is zero to none, so it can gleefully be ignored in that case.
But maybe the semantics of your "related" link and my origin link are
sufficiently distinct.
For the arguments why it should be in the header of a commit, see above.

>which IMHO is a bad justification.  Having lines of developments hanging 
>off of a weak link alone is just plain stupid if you can't reach it via 
>proper branches or tags.

Agreed.  But this is in reference to your "related" link proposal.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
