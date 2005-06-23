From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Patch (apply) vs. Pull
Date: Thu, 23 Jun 2005 01:15:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506230025420.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506222059150.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 07:17:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlK5b-0006yj-Ms
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 07:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVFWFXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 01:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVFWFXR
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 01:23:17 -0400
Received: from iabervon.org ([66.92.72.58]:31493 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262134AbVFWFR1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 01:17:27 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlK48-0003HT-00; Thu, 23 Jun 2005 01:15:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506222059150.11175@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Jun 2005, Linus Torvalds wrote:

> On Wed, 22 Jun 2005, Daniel Barkalow wrote:
> > I think it would we worthwhile for the common case for the system to
> > recognize that a patch went in unmodified, but potentially after a
> > different patch which caused it to have fuzz, and have a header that would
> > get the developer's update to recognize what happened.
> 
> Note that I don't even apply patches with fuzz at all. "git-apply" refuses 
> to recognize anything with fuzz, although it _will_ move the patch around 
> to make it match.

I bet I'm misunderstanding fuzz; what I actually mean is that, if a patch
applies after moving it, then regenerating it from the result would give
the a patch with different line numbers; if these affect the hash, the
author's tools will be sad.

> So as far as I'm concerned, you really could just take the SHA1 of the
> patch (leave out the '@@' lines with line numbers), and you'd have a
> reliable ID for it.
>
> In fact, you could probably replace every run of contiguous whitespace
> with a single space, and then you'd not have to worry about whitespace
> differences either. That would be very simple to do, and quite workable: I
> certainly think it sounds more reliable than just hoping that people
> always pass on a "patch ID" in their emails..

That's actually quite plausible. The only case it wouldn't handle is when
you actually discard parts, and I'm not sure at this point what other
people should see there.

> But yes, if it's a nasty case, I'll just apply it, edit it, re-create a
> diff, and then re-apply it with the re-created diff (since all my tools
> are geared towards getting the log message etc with the patch, I don't
> just commit it after fixing it up: that would screw up the author
> information etc).

I think most people's scripts stash the information needed for the commit
somewhere, and pick it back up at commit time, at least for merges.

> > > Yes. And I think (1) is pretty useful on its own, and that git could 
> > > support that with a nice helper script.
> > 
> > I think that this, by itself, is likely to be a sufficiently common case
> > to be worth just doing. Once the script exists, it makes it worthwhile for
> > developers to organize things such that it works.
> 
> Yeah. It probably works well in 99% of the cases to just do a simple
> "export as patch" + "apply on top with old commit message, author and
> author-date".

I think that you'll get better results out of "merge with top" + "commit
with old commit info, but not listing old commit as a parent". At least,
that's what StGIT is doing, IIRC, and using merge instead of patch seems
like it'll make the remaining 1% a lot more pleasant. In fact, isn't it
necessary if you want to make sense out of "half of my patch got applied",
as a bunch of "still needed" hunks and a bunch of "already applied" hunks 
that disappear after the message?

> > It's not just that
> > they're machine-readable and can apply with fuzz; they're also pretty
> > easy for humans to read, which is why unified diffs are better than
> > context diffs, despite having the same expressive power. In this case,
> > then, they aren't being used for cherry-picking or any other history
> > cleaning; you'll tend to apply the patch straight (or reject it), and
> > then it would be useful to have it act like a merge, with respect to
> > further operations understanding what happened.
> 
> I've _occasionally_ wanted patches to work that way, just because they 
> don't apply, but they'd apply to the right version and then I could just 
> merge them. So yes, sometimes a patch might be more of a merge thing. Most 
> of the time, the patch has really been around the block several times, and 
> it's really lost it's position in the history tree.. So it really ends up 
> being "just apply it to the top" 99% of the time anyway.

It should be fine as a merge if you apply it to the top; the case that's
cherry-picking is when you apply a patch that was second in a series
without applying the first. By "like a merge" I really mean "someone
changed <old> to <patched>; I want to make that change to <new>, such that
future merges aren't confused." In this case, you'd actually generate only
an "apply" commit, not recreate (or fetch) "patched-old" and generate a
merge commit. But, if you put the hash of the patch (as above) in a commit
header, other people who have the same patch (including the author) can
identify the commonality and not be confused. (I think putting
it in a header is likely necessary for efficiency reasons, so that it
isn't necessary to unpack/diff/hash all of the trees while updating.)

	-Daniel
*This .sig left intentionally blank*

