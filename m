From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Upstream merging and conflicts (was Re: Using cvs2git to track
 an external CVS project)
Date: Wed, 8 Jun 2005 08:59:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506080828240.2286@ppc970.osdl.org>
References: <46a038f905060105358e24723@mail.gmail.com> 
 <1117631266.26067.40.camel@imp.csi.cam.ac.uk>  <46a038f905060213104d9ad96f@mail.gmail.com>
 <46a038f9050602135971ece082@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:47:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg3gz-0006yv-3Q
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 18:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVFHQFD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 12:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFHQB3
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 12:01:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:28103 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261342AbVFHP5V (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 11:57:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j58FvEjA026192
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 08:57:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j58FvDa6026780;
	Wed, 8 Jun 2005 08:57:14 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050602135971ece082@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, Martin Langhoff wrote:
> 
> I understand this is architected to _not_ support cherry picking in
> the darcs/arch sense and I think it's a good idea. But it seems than
> any non-trivial merge ends up being a completely manual process.

Yes, and right now that "manual" part is actualyl fairly high. I'll fix 
that thing up (today, I hope), making nontrivial merges much easier.

> So it seems to me that git is well suited for a set of closely related
> HEADs that are very aggressive in synching with each other. Synching
> work is pushed out to the peripheral branches -- a design decision I
> agree with -- but there's very little support to help me keep a
> peripheral branch in sync.

Well, there's asome support for keeping a peripheral branch in sync, but
part of it ends up having to try to just merge into it from the main
branch every once in a while.

It all really boils down to "merge often, merge small". Git encourages 
that behaviour. Git concentrates on trivial merges, because the git 
philosophy is that if you let two trees diverge too much, your problems 
are not with the merge, but with other things.

NOTE! This does _not_ mean that you can't do big changes. You can very
much do a branch that does _huge_ changes, and as long as that branch
keeps merging with the original, it should work out reasonably well. Every
merge "re-bases" the work, so you'll never have to merge old changes. You
may end up with a fair number of manual things to fix up each time (and
see my comment on the manual fixup problems right now), but at least the 
thing should hopefully be incremental.

But yeah, if you actually do major re-organization, then the system
absolutely needs tons more smarts in the automated parts, since right now
it has no automated merging for renames etc things (things it _could_
detect, but doesn't do). There's really several layers of merging you can
automate, and git right now only automates the very very lowest stuff.

In other words, it should be possible to make git do pretty well even for
complex branches, but no, right now the automated parts don't even try.  
And it's still _all_ geared towards development that ends up being merged
reasonably often - you can merge in one direction for a while to keep the
pain incremental, but yes, you do need to merge the other way
_eventually_.

> The assumption that those peripheral branches must be short-lived and
> discardable is valid for a limited set of cases -- very circumscribed
> to short-term dev work. As soon as a dev branch has to run a little
> longer, it cannot afford to not sync with the HEAD. Particularly, it
> cannot skip a _single_ patch coming from HEAD.

It's true that you can't skip patches, since a merge is always 
all-or-nothing, and the global history really requires that (in a very 
fundamental way). However, you _can_ merge from the HEAD, and then say 
"that patch is no longer relevant in this tree", and remove it. Then 
you'll never need to worry about that patch any more, because you've 
merged it and in your merged result, it no longer exists).

That said, I don't claim that this is what you always want to do. In fact,
we have this exact issue in the kernel, and I think it's a great thing to
use a combination of a patch-based system _and_ git. You use git for the
"core", you use the patch-based system for the more fluid stuff. In the
case of the kernel, the patch-based system that seems to be used the most
is "quilt", but that's a detail. The big issue is that git is simply part 
of a bigger process:

> I use peripheral branches to track versions of code in production,
> that may have different sets of patches applied. For that purpose,
> patch-based SCMs are quite helpful (you can ask what patch is applied
> where), but as Linus pointed out, they don't actually help convergence
> at all. Git pulls towards convergence like a demon AFAICS -- yet some
> primitive patch trading smarts would save a lot of effort at the
> borders of the dev network.

Yes. I think this is fundamental. "git" needs to converge. It's how git
works. git also "crystallizes" the history and makes it unbreakable.  
Both of these things are _wonderful_ for what they mean, but both of these
fundamental issues are _horrible_ for other reasons.

So it's not a one-size-fits-all. git is designed to work around the kind
of stuff I do - my job in many ways is exactly to "crystallize" the work
that happens around me. I'm the ugly speck of dirt around which a
beautiful snowflake forms.

But to get the pieces that crystallize to form, you need all those unruly 
patches floating around freely as a gas, and feeding the crystallization 
process. And git is not suitable _at_all_ for that phase.

So I don't think that you should necessarily think of git as "the" souce
control management in the big picture. It's how you handle _one_ phase of
development, and the constraints it puts on that phase are both wonderful
and horrible, and thus you really should see the git phase as being the
solid core, but no more.

So git (apart from the use of "ephemeral branches for testing") is _not_ 
very conductive to wild development. I think git is actually a wonderful 
way of doing the wild development too, but only in a microscopic sense: 
you can use git either for the "big picture" crystal, or you can use git 
for the "I want to keep track of what I did" on a small scale, but then in 
between those things you'd need to have a patch-manager or something.

In other words, I'd expect that a _lot_ of git usage is of the type:
 - clone a throw-away tree from the standard repositories
 - do random things in it, merge with the standard repo every once in a 
   while. This is the "little picture".
 - export the result as a patch when you're happy with it, and use 
   somethign else to keep track of the patch until it can be merged into 
   the "big picture".

So I don't think any development effort that is big enough necessarily 
wants to use git as the _only_ way of doing development and merging stuff. 
The kernel certainly does not. Not now, and not in the long run.

(We know about the long run, because these issues were largely trye of BK
too, although BK handled especially metadata merges much much better. But
even with BK, we always ended up having 50% or more of the actual
development end results going around as patches, and BK was really the way
to crystallize the end result. It shouldn't come as a surprise that git
does the same - git was designed not so much as a technical BK
replacement, but as a replacement for that _process_ we had for BK).

Final note: I do believe that the kernel is kind of strange. I doubt
anybody else ended up using BK the way we did, and I suspect _most_ BK
users used BK as a better CVS, where BK was the primary - and only - thing
that kept track of patches.

Whether the kernel model is applicable to anything else, I dunno. 

		Linus
