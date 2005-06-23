From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 21:23:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506222059150.11175@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506221821260.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 06:16:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlJ86-0004gh-1Q
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 06:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVFWEWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 00:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVFWEWE
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 00:22:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262057AbVFWEVg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 00:21:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N4LQjA021238
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 21:21:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N4LPOe025523;
	Wed, 22 Jun 2005 21:21:25 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506221821260.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Daniel Barkalow wrote:
> 
> Ah, okay. I actually know the rules for line numbers, and I still can't
> change the lines and line numbers reliably in sync.

Heh. I usually just edit the fragment, and ignore the line numbers, and 
then I go back and just count ;)

So I don't even try to keep things in sync, I just fix them up 
after-the-fact.

> Right; I do this myself, when I turn a mass of changes into a set of
> patches. I think it would be worth having a good tool for applying a
> patch while discarding undesired hunks and editing the regions it applies
> to.

There at least one GNU emacs "patch mode" editing thing to help you, and I
think there is even a tool specifically geared to splitting up a patch
into several sub-patches. I've been pointed at it occasionally, I just do 
it by hand.

> I think it would we worthwhile for the common case for the system to
> recognize that a patch went in unmodified, but potentially after a
> different patch which caused it to have fuzz, and have a header that would
> get the developer's update to recognize what happened.

Note that I don't even apply patches with fuzz at all. "git-apply" refuses 
to recognize anything with fuzz, although it _will_ move the patch around 
to make it match.

I've got this theory that if you apply a thousand patches, and one of them 
applies with fuzz, you want to stop right there and see what's wrong.

This was what I did before I wrote "git-apply":

	patch -E -u --no-backup-if-mismatch -f -p1 --fuzz=0 --input=$PATCHFILE

ie pretty unambiguous. I don't trust the "automatically guess the depth of 
the patch" thing, for example, since it, together with allowing fuzz, has 
several times caused nasty problems for me with things like the wrong 
Makefile being modified by a patch..

So as far as I'm concerned, you really could just take the SHA1 of the
patch (leave out the '@@' lines with line numbers), and you'd have a
reliable ID for it.

In fact, you could probably replace every run of contiguous whitespace
with a single space, and then you'd not have to worry about whitespace
differences either. That would be very simple to do, and quite workable: I
certainly think it sounds more reliable than just hoping that people
always pass on a "patch ID" in their emails..

> > I don't want crap in my code. I disagree very strongly with people who say
> > that "you can just fix it later". That's not how people work, and worst of
> > all, not only does it not get fixed up, even _if_ it is fixed up the wrong
> > version inevitably ends up showing up somewhere else, just because
> > somebody ended up using the original patch.
> 
> If you can modify patches, that's better; I think most maintainers would
> fall back to applying the patch and fixing things in the working directory
> before committing; the history still doesn't get dirty, which is what
> actually matters.

The reason I much prefer editing patches is my batch-mode approach to then
applying them. If I were to fix things up after applying a patch, I'd have
to break up the series: apply <n> patches, fix up, apply <m> patches, fix
up, etc. In contrast, now I just fix up the mbox directly (at a minimum,
add the sign-off, even if I don't actually touch the patch itself), and
just apply it all in one go.

But yes, if it's a nasty case, I'll just apply it, edit it, re-create a
diff, and then re-apply it with the re-created diff (since all my tools
are geared towards getting the log message etc with the patch, I don't
just commit it after fixing it up: that would screw up the author
information etc).

> > Yes. And I think (1) is pretty useful on its own, and that git could 
> > support that with a nice helper script.
> 
> I think that this, by itself, is likely to be a sufficiently common case
> to be worth just doing. Once the script exists, it makes it worthwhile for
> developers to organize things such that it works.

Yeah. It probably works well in 99% of the cases to just do a simple
"export as patch" + "apply on top with old commit message, author and
author-date".

> But I think that the real value of patches for submission as opposed to
> merges is that you can review them conveniently.

Yes, agreed (with the exception of how I tend to merge with Andrew, where 
it's really more of a regular merge in the sense of "I pull from Andrew 
because I trust him, not because I look at every patch").

> It's not just that
> they're machine-readable and can apply with fuzz; they're also pretty
> easy for humans to read, which is why unified diffs are better than
> context diffs, despite having the same expressive power. In this case,
> then, they aren't being used for cherry-picking or any other history
> cleaning; you'll tend to apply the patch straight (or reject it), and
> then it would be useful to have it act like a merge, with respect to
> further operations understanding what happened.

I've _occasionally_ wanted patches to work that way, just because they 
don't apply, but they'd apply to the right version and then I could just 
merge them. So yes, sometimes a patch might be more of a merge thing. Most 
of the time, the patch has really been around the block several times, and 
it's really lost it's position in the history tree.. So it really ends up 
being "just apply it to the top" 99% of the time anyway.

		Linus
