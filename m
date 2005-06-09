From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Upstream merging and conflicts (was Re: Using cvs2git to track
 an external CVS project)
Date: Wed, 8 Jun 2005 19:34:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506081918050.2286@ppc970.osdl.org>
References: <46a038f905060105358e24723@mail.gmail.com> 
 <1117631266.26067.40.camel@imp.csi.cam.ac.uk>  <46a038f905060213104d9ad96f@mail.gmail.com>
  <46a038f9050602135971ece082@mail.gmail.com>  <Pine.LNX.4.58.0506080828240.2286@ppc970.osdl.org>
 <46a038f905060815096382636a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 04:29:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgCnM-0004au-8t
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 04:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVFICdT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 22:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFICdT
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 22:33:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:55212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262257AbVFICcc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 22:32:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j592WMjA018095
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 19:32:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j592WL8o010631;
	Wed, 8 Jun 2005 19:32:22 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905060815096382636a@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 9 Jun 2005, Martin Langhoff wrote:

> On 6/9/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > Yes, and right now that "manual" part is actualyl fairly high. I'll fix
> > that thing up (today, I hope), making nontrivial merges much easier.
> 
> Wow -- I'll be tracking your tree closely then ;-)

Well, it's done, and it's now "much easier" in the sense that anything 
that doesn't have metadata changes should be picked up pretty trivially by 
the three-way merge thing.

But if you move things around, then you'd need to have a merge that is
aware of movement, ie something much more sophisticated than just 3way
merge.

> > It's true that you can't skip patches, since a merge is always
> > all-or-nothing, and the global history really requires that (in a very
> > fundamental way). However, you _can_ merge from the HEAD, and then say
> > "that patch is no longer relevant in this tree", and remove it. Then
> > you'll never need to worry about that patch any more, because you've
> > merged it and in your merged result, it no longer exists).
> 
> I had that strategy in my back-pocket already, but it doesn't sound right. 

With global history, you really don't end up having much choice. 

The alternative is to have per-file history, which sucks pretty bad
(you're screwed if you have a file that is touched by two things, so it
just moves the problem a bit, but more importantly you now have all the
CVS crud), or then you have to play games like arch or darcs which is all
about re-ordering patches (and then your history is totally malleable,
with all the problems that entails).

> > Yes. I think this is fundamental. "git" needs to converge. It's how git
> > works. git also "crystallizes" the history and makes it unbreakable.
> > Both of these things are _wonderful_ for what they mean, but both of these
> > fundamental issues are _horrible_ for other reasons.
> 
> Fair enough -- and actually I'm not convinced it's a horrible thing.

It's absolutely not horrible, but it limits how you work. _I_ think it 
limits you in good ways, but it's definitely a limitation.

> Having worked with forever-diverging tools like Arch, I can appreciate
> the value of crystallizing and identifying when you've converged --
> and rebasing all steps forward on the fact that you've converged. This
> is huge.

My gut feel is that it should be possible to have a hybrid system that
handles both the solid "crystalline" phase (aka git) and the "gas" phase
(aka free-lowing patches) and have them integrate with each other well. 
That's kind of the way the kernel works, with people using quilt as a way 
to capture the patches in between.

My read is that this analogy arch and darcs try to avoid the really solid
crystalline phase entirely and end up being amorphous. You can probably 
have that too, but on the other hand it's fairly easy to merge between two 
"crystallized" repositories and be totally unambigious about what the 
result is, but if there's a lot of the amorpous stuff going on, it's not 
clear any more.

> > Whether the kernel model is applicable to anything else, I dunno.
> 
> I don't know either -- but I'm sure the toolset around git can support
> a range of dev models. I don't think any other project has such a
> large pool and strong convergence dynamics as the kernel. But git and
> its tools and practices can be (I'm hoping) quite flexible to support
> a range of dev models.

Hey, I obviously think you're right. Using git gives good ways of
communicating the core infrastructure between two (or more) groups, while
then internally within the group they may use loser patch-tracking systems
that don't have the same kind of convergence requirements (but which you
don't need for a "small" set of patches anyway, where "small" can
obviously be hundreds of internal patches).

			Linus
