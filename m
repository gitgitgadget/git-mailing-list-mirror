From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 15:21:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221504370.2353@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506221654550.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 00:17:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlDX0-0001j1-IU
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 00:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVFVWW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVFVWWo
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 18:22:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262301AbVFVWTb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 18:19:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5MMJ9jA028918
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 15:19:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5MMJ8Qu008424;
	Wed, 22 Jun 2005 15:19:08 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506221654550.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Daniel Barkalow wrote:
> 
> Do you actually modify patches before applying them, rather than applying
> them and the fixing the resulting files? I've never managed to modify
> content in a patch (aside from dropping hunks) without upsetting patch.

I've been doing unified diffs for a _loong_ time, and I edit patches in my 
sleep. The rules for line numbers etc are really quite simple, and yes, I 
do edit patches before I apply them.

The most common form of editing is just removing single fragments, or
fixing up whitespace. Quite often people send me patches that don't even
apply, because whitespace got corrupted either because their mailer ate
it, or simply because they cut-and-pasted the patch. So I end up fixing
things up, and the end result may not actually match the original one
byte-for-byte, even if it matches visually.

Similarly, the "remove patch fragments" is often because somebody mixes up
two things in a patch, and I decide to take one of them but there's some
problem with the other.  Sometimes that patch fragment thing means that I
have to edit even within one fragment, and fix up the patch line-counters
etc.

NOTE! This is "rare" in the sense that it doesn't happen for most patches,
but that said, I get a _lot_ of patches, and it's not rare in the sense
that it doesn't happen weekly.

So for example, I did one such edit just Monday in the "sparse" project,
where Peter Jones sent me a patch that added parsing for a lot of new gcc
attributes (good), but he had also done some other things that weren't
quite ready yet (bad). And because they were easy to separate out in the
patch, I just did it right there instead of asking him to do it for me and
re-sending.

> If you apply them and then fix things, the ID (and for that matter, the
> hash) will be safely conveyed from my system to yours and available for
> the commit to mention.

I don't want crap in my code. I disagree very strongly with people who say
that "you can just fix it later". That's not how people work, and worst of
all, not only does it not get fixed up, even _if_ it is fixed up the wrong
version inevitably ends up showing up somewhere else, just because
somebody ended up using the original patch.

So I want things to be cleaned up before they hit the tree, rather than 
have a really dirty history. A dirty history just makes it harder to read, 
and I don't believe in a second that it's "closer to reality" like some 
people claim.

I don't believe anybody wants to see the "true" history. If they did, we'd 
be logging keystrokes, and sending all of that around. Nope, people want 
(and need, in order to be able to follow it) an "idealized" history.

> I believe there are separate issues here: 
> 
>  1. pure history rewriting: maintainer merges a developer's
>     intermediate head; developer generates a new history in which
>     everything later is based on the new mainline.
>  2. patches: changes are transferred as diffs over SMTP instead of trees
>     inside git.
>  3. cherry-picking: maintainer applies some set of changes from a
>     developer which is not merging a head the developer created.
> 
> I think (1) is easily handled as a merge script that goes through a series
> of commits and makes a new series out of merging each of them, rather than
> merging the last of them only.

Yes. And I think (1) is pretty useful on its own, and that git could 
support that with a nice helper script.

> I think (2) should be as transparent as possible, and, in cases where
> there was no cherry-picking, be equivalent in the system's behavior to the
> result of pull and merge (with the possibility for various cleanup 
> happening on top of or along with the merge in either method).

I really see patches as something totally different than merging. I 
literally see them as a way to move between different systems.

For example, the git model just doesn't work very well for "fluid" 
development: git ends up setting history entirely in stone, which means 
that you can't fix up mistakes later. And this is where patches come in: 
they work as a way to transfer the information, while at the same time 
totally breaking the connection with the original messy tree.

So I really think our view on what "patches" are is very fundamentally 
different. I don't think SMTP is a good medium for merges: BK actually 
supports that with "bk send" (or something like that) and I refused to use 
it. It was a "worst of both worlds" thing.

> The tricky part is (3), which is currently only possible by going outside
> of git. But I think that this is something to tackle separately from
> (1) and (2) (where (2) does not involve doing (3)).

I think the cherry-picking kind of goes hand in hand with 1/2, though. 
Patches are really the perfect form of cherry-picking, exactly because 
they do _not_ imply a very strong ordering or even a very strong 
dependency on the state of the rest of the sources. So patches end up 
being the perfect medium for cherry-picking, and SMTP ends up being one of 
the best ways to transport them and let them evolve.

And then (1) ends up often being the way the patches actually get 
generated in the first place. So these things are intertwined, I think.

		Linus
