From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 14:12:45 -0500
Message-ID: <E1EIWUv-0004HR-F6@jdl.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 21:14:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIWVR-0002rw-Uk
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 21:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVIVTMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 15:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVIVTMs
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 15:12:48 -0400
Received: from jdl.com ([66.118.10.122]:11436 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751081AbVIVTMr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 15:12:47 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EIWUv-0004HR-F6
	for git@vger.kernel.org; Thu, 22 Sep 2005 14:12:46 -0500
To: git@vger.kernel.org
In-Reply-To: Pine.LNX.4.58.0509220826460.2553@g5.osdl.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9138>


Linus calmly explained again:
>
> The "origin" branch was already updated automatically if you used
> 
> 	git pull origin
> 
> However, if you used
> 
> 	git pull rsync:..../linus-2.6.git
> 
> then git would only have fetched the objects, and _not_ updated the 
> "origin" branch (because you didn't tell it about the "origin" branch). 
> 
> But you can trivially fix that by doing
> 
> 	git fetch origin
> 
> at this point, which will end up doing the equivalent of
> 
> 	git fetch rsync:..../linus-2.6.git master:origin
> 
> (depending on what the contents of your .git/remotes/origin are, of 
> course, the above is just an example).

This was a very helpful section for me.

> For example, it _may_ just contain something like
> 
>	URL: rsync:..../linus2.6.git
> 
> in which case there is no explicit heads specified. In that case, you 
> really should specify _which_ of the heads you want to pull, and what the 
> target should be. 

In fact it contained just the "rsync:...." bits.


> For example, you can do that with
>
>	git fetch linus master:linus
>
> which says: "fetch the branch 'master' from the repository described by 
> 'linus' (.git/remotes/linus) into _my_ branch 'linus'".

Just to be clear on the overloaded use of "linus" here,
let me rewrite that:

	git fetch foo master:bar

    which says: "fetch the branch 'master' from the repository described
    by 'foo' (.git/remotes/foo) into _my_ branch 'bar'".

Right?

> Now, you can specify that this is what you _always_ want to do, and
> actually set the branches in the ".git/remotes/linus" file explicitly.
> You can make your .git/remotes/linus file look like this instead:
>
>	URL: rsync:..../linus2.6.git
>	Pull: master:linus

OK.  I think I get it.  The concept you are trying to beat into
my head is essentially the difference between a "complete" and
an "incomplete" specifier.  If there is enough specification to
fetch and merge into a branch, you can.  And there are a few
different ways to do so:

    A) git fetch rsync:..../linus-2.6.git master:origin
or 
    B) git fetch linus master:linus
       with just the URL bits in the .git/remotes
or
    C)	git fetch linus
        with both URL and "Pull:" clauses in .git remotes
            URL: rsync:..../linus2.6.git
	    Pull: master:linus

If it is an incomplete specification (without branch names),
you just can't do the whole sheebang.  You have to stop after
fetching the objects.

And add "merging" in the "git pull" cases.

> Now, this is where "dirty" comes in. The merge will fail if you have 
> changed any files that the merge wants to modify. So do a

D'oh.  This is what bites me.  Some of those diffs that
come back to me in the linus tree are one that I originated
and sent up stream in the first place.  To get those to
wash-out with the merge, I will have had to have had those
committed in my branch, right?  Otherwise they just look
like dirty files -- never mind that they are (should be)
the exact same bits coming back at me.

> So do a
>
>	git diff --name-only HEAD
>
> to see if there are any changes, and commit them - or undo them - if so.
> Then try to pull again.

Ah hah.  OK.


I want to return to this for one last comment:

    > You can make your .git/remotes/linus file look like this instead:
    >
    >	URL: rsync:..../linus2.6.git
    >	Pull: master:linus

So, philosophically perhaps, there are several different
reasons for having branches within a repository.  One of
them is to track external repositories as indicated above.
But no-one (ie, no tool) currently constructs the .git/remotes
files to have that layout, right?  I mean, The One True editor
can, but there is no git or Cogito command that says to
construct the URL: and Pull: bits like that for the purposes
of establishing a "track branch", right?  Would it make sense
to have a "--tracking" flag added to branch creation that
trumped these bits up and promotes a simpler, or specific
purpose branch?

jdl
