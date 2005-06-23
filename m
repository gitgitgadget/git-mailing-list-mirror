From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 23:32:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506221821260.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506221504370.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 05:28:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlINi-00047g-MA
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 05:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVFWDeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 23:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVFWDeL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 23:34:11 -0400
Received: from iabervon.org ([66.92.72.58]:29700 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261935AbVFWDd5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 23:33:57 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlIRr-00078j-00; Wed, 22 Jun 2005 23:32:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221504370.2353@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Jun 2005, Linus Torvalds wrote:

> I've been doing unified diffs for a _loong_ time, and I edit patches in my 
> sleep. The rules for line numbers etc are really quite simple, and yes, I 
> do edit patches before I apply them.

Ah, okay. I actually know the rules for line numbers, and I still can't
change the lines and line numbers reliably in sync.

> Similarly, the "remove patch fragments" is often because somebody mixes up
> two things in a patch, and I decide to take one of them but there's some
> problem with the other.  Sometimes that patch fragment thing means that I
> have to edit even within one fragment, and fix up the patch line-counters
> etc.

Right; I do this myself, when I turn a mass of changes into a set of
patches. I think it would be worth having a good tool for applying a
patch while discarding undesired hunks and editing the regions it applies
to. This is, of course, not immediately relevant, aside from it making the
tracking more useful, because more people would be able to reliably modify
patches. In any case, though, after you've fixed a patch, you apply it
rather than sending it to anyone or archiving it or something, right?

> NOTE! This is "rare" in the sense that it doesn't happen for most patches,
> but that said, I get a _lot_ of patches, and it's not rare in the sense
> that it doesn't happen weekly.

I think it would we worthwhile for the common case for the system to
recognize that a patch went in unmodified, but potentially after a
different patch which caused it to have fuzz, and have a header that would
get the developer's update to recognize what happened.

> I don't want crap in my code. I disagree very strongly with people who say
> that "you can just fix it later". That's not how people work, and worst of
> all, not only does it not get fixed up, even _if_ it is fixed up the wrong
> version inevitably ends up showing up somewhere else, just because
> somebody ended up using the original patch.

If you can modify patches, that's better; I think most maintainers would
fall back to applying the patch and fixing things in the working directory
before committing; the history still doesn't get dirty, which is what
actually matters.

> > I believe there are separate issues here: 
> > 
> >  1. pure history rewriting: maintainer merges a developer's
> >     intermediate head; developer generates a new history in which
> >     everything later is based on the new mainline.
> >  2. patches: changes are transferred as diffs over SMTP instead of trees
> >     inside git.
> >  3. cherry-picking: maintainer applies some set of changes from a
> >     developer which is not merging a head the developer created.
> > 
> > I think (1) is easily handled as a merge script that goes through a series
> > of commits and makes a new series out of merging each of them, rather than
> > merging the last of them only.
> 
> Yes. And I think (1) is pretty useful on its own, and that git could 
> support that with a nice helper script.

I think that this, by itself, is likely to be a sufficiently common case
to be worth just doing. Once the script exists, it makes it worthwhile for
developers to organize things such that it works.

E.g., yesterday, I'd have had:

You -- A1 -- A2
 \             \
  ----- B ------ Stuff I've sent -- Stuff I'm working on

If you pulled A1 or A2, and/or B, the script would take care of everything
without any fuss. I didn't actually make this structure of commits,
however, because I didn't have the script that would make it useful. 

> > I think (2) should be as transparent as possible, and, in cases where
> > there was no cherry-picking, be equivalent in the system's behavior to the
> > result of pull and merge (with the possibility for various cleanup 
> > happening on top of or along with the merge in either method).
> 
> I really see patches as something totally different than merging. I 
> literally see them as a way to move between different systems.
> 
> For example, the git model just doesn't work very well for "fluid" 
> development: git ends up setting history entirely in stone, which means 
> that you can't fix up mistakes later. And this is where patches come in: 
> they work as a way to transfer the information, while at the same time 
> totally breaking the connection with the original messy tree.

I certainly use patches internally as a way of going from my messy
development tree to my clean patch tree. But that's mostly a developer's
own usage. (I suppose developers might diff their latest commit against
the mainline, and then hand-edit it into a series without regenerating
patches, but I think that would be really awkward and failure-prone for
non-experts in unified diff.)

But I think that the real value of patches for submission as opposed to
merges is that you can review them conveniently. It's not just that
they're machine-readable and can apply with fuzz; they're also pretty easy
for humans to read, which is why unified diffs are better than context
diffs, despite having the same expressive power. In this case, then, they
aren't being used for cherry-picking or any other history cleaning; you'll
tend to apply the patch straight (or reject it), and then it would be
useful to have it act like a merge, with respect to further operations
understanding what happened.

> So I really think our view on what "patches" are is very fundamentally 
> different. I don't think SMTP is a good medium for merges: BK actually 
> supports that with "bk send" (or something like that) and I refused to use 
> it. It was a "worst of both worlds" thing.

Certainly, if you trust the result enough to merge, there's no need to
review anything and therefore no need to go through email.

> > The tricky part is (3), which is currently only possible by going outside
> > of git. But I think that this is something to tackle separately from
> > (1) and (2) (where (2) does not involve doing (3)).
> 
> I think the cherry-picking kind of goes hand in hand with 1/2, though. 
> Patches are really the perfect form of cherry-picking, exactly because 
> they do _not_ imply a very strong ordering or even a very strong 
> dependency on the state of the rest of the sources. So patches end up 
> being the perfect medium for cherry-picking, and SMTP ends up being one of 
> the best ways to transport them and let them evolve.

I think that cherry-picking depends on 1/2, but that each of them has a
non-cherry-picking case worth supporting specifically.

	-Daniel
*This .sig left intentionally blank*

