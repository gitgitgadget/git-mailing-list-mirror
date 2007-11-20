From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 13:03:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711201226320.32410@iabervon.org>
References: <20071120155922.GA6271@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuXSP-0000R1-4s
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505AbXKTSDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbXKTSDt
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:03:49 -0500
Received: from iabervon.org ([66.92.72.58]:47201 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbXKTSDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:03:48 -0500
Received: (qmail 9316 invoked by uid 1000); 20 Nov 2007 18:03:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2007 18:03:46 -0000
In-Reply-To: <20071120155922.GA6271@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65553>

On Tue, 20 Nov 2007, Finn Arne Gangstad wrote:

> My use case it this: We have some huge projects (let's call them
> supermodules) that are the only products we really release. Any change
> going into any of the submodules go in solely to modify the
> superproject, the submodules are not released on their own.
> 
> We cannot keep the supermodule with all its submodules in one git
> repository for two reasons: Size & sharing. A 6GB+ repository is too
> big to handle gracefully, and there are multiple superprojects sharing
> some of the submodules. Our supermodules typically contains 50-250
> submodules. Usually it is sufficient to look at just a few of these
> submodules at the same time.
> 
> I looked into the current git submodules to see if they support what I
> think we need, but it seems like they do not really cut it (If I'm
> wrong about this, please educate me).
> 
> What I want is this: 
> 
> Somewhere the following modules all exist:
> 
> supermodule/
>    submodule1
>    submodule2
>    submodule3
>     ...
>    submodule200
> 
> You pull the supermodule, and initialize random collection of
> submodules, e.g. locally you have:
> 
> supermodule/
>    submodule13
>    submodule71
>    submodule102
> 
> Now I want this to behave as if it was a partial checkout of
> "supermodule" - i.e. I want _all_ operations in any of the submodules
> to act as if they happened in all the submodules (as if supermodule
> was a single repository containing all the submodules directly).
> 
> If I do a change in submodule13, another change in submodule71 and yet
> another change in submodule102, I want to be able to commit them all
> as ONE commit (obviously it will be 4 commits, 1 in each submodule and
> one in the supermodule, but anyone looking at this in the context of
> this supermodule should see it as one commit).

This has theoretical problems: it's going to be practically impossible, in 
most cases, to write a commit message that describes changes in three 
submodules (which are sometimes used in the context of a different 
supermodule) as well as the supermodule.

On the other hand, the supermodule commit is the one that's relevant in 
the context of the supermodule, and that commit's message should describe 
the set of changes as a whole.

I think it should be possible and sufficient to have "git commit" able to 
recursively start a "git commit" in submodules (where you'd write a 
separate message suitable for exposure to other supermodules), so you'd 
have to write 4 messages but only type one command line.

> If I pull supermodule, I get updates to supermodule, submodule13,
> submodule71 and submodule102, but nothing else.

This should work. Of course, if other people have made changes to parts of 
the supermodule that you haven't checked out, your supermodule index will 
reflect those changes, so that supermodule commits you make aren't 
reverting or removing those submodules. But you won't fetch the contents 
of those submodules, and won't have them checked out. (Note, however, 
that, if you pull from two places, each of which has changed the same 
submodule you don't have in a different way, you'll get a conflict you 
can't resolve without getting the submodule yourself or getting somebody 
else to merge them; git won't let you make commits which leave the 
submodule merge for somebody who cares)

> If I make a branch on submodule71, the branch is made in all submodules &
> the supermodule.

I don't think this aspect has been worked out too carefully. I think the 
branch is made only in the supermodule, but the submodules are attached to 
the supermodule's index, rather than particularly using branches, and so, 
when the supermodule switches branches, the submodules should all follow, 
regardless of whether they have explicit branches.

> With this setup it should be possible to handle supermodule as a
> normal module with branches for each feature/topic/bugfix, and those
> features being merged into other branches in a reasonable way. Does
> something like this look doable?

AFAIK, supermodules haven't gotten heavy enough use to work out all of the 
details of what should happen when the user does different things. I think 
it's all doable, but you may have to convince people to actually do it, 
and I don't think everything yet works the way you'd want.

	-Daniel
*This .sig left intentionally blank*
