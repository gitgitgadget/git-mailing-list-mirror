From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 08:57:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607140843570.5623@g5.osdl.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org> 
 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
  <1152840456.31372.75.camel@shinybook.infradead.org> 
 <Pine.LNX.4.64.0607132157370.5623@g5.osdl.org> <1152872626.3191.56.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 17:59:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Q3Q-00051K-Dp
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 17:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWGNP6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 11:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWGNP6I
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 11:58:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17319 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161138AbWGNP6H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 11:58:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6EFw0nW026979
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Jul 2006 08:58:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6EFvxIc017624;
	Fri, 14 Jul 2006 08:57:59 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1152872626.3191.56.camel@pmac.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.86__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23895>



On Fri, 14 Jul 2006, David Woodhouse wrote:

> On Thu, 2006-07-13 at 22:16 -0700, Linus Torvalds wrote:
> > 
> >         HEAD  ->     A
> >                     / \
> >                    B   C
> >                   / \   \
> >                  D   E   F
> >                   \ /   / \
> >                    G   H  I
> >                   .......
> > 
> 
> So working from your example above, and assuming that only commits I and
> E actually change the files we care about. This means that merges A, B
> and F are _also_ going to show up in the output of 'rev-list -- myfile'.

Not necessarily.

> So the slave tree will look like this:
> 
>         A'
>        / \
>       B'  F'
>       |   |
>       E'  I'

Yes, but ONLY IF the following is true: A is different from _both_ F and B 
in the relevant files.

If A == F (in those files), then the A merge will have been simplified 
away. Strictly speaking, what happens is that when it sees the merge A 
(which has parents B and C), and sees that _all_ the changes came from C, 
the simplification will decide that B simply isn't even interesting, and 
rewrite the merge A as having _only_ C as a parent, since C clearly 
explains everything that happened to those files, and B had nothing to do 
with it.

It will then remove both A (which is no longer a merge) and C, since 
neither of them change the files, and will leave you with just

	F'
	|
	I'

instead.

> The interesting case, if I'm trying to convince myself that my 'slave'
> tree is always going to have the correct topology, is when a merge
> commit is _missing_ from the rev-list output

Note that there are only two ways you can be missing a merge:
 - you literally asked for it with "--no-merges"
 - the merge had one parent that was identical to it, and the merge was 
   simplified as above.

> In that case, we accept that the representation isn't going to be
> perfect -- the left-hand parent of A' is going to appear to be _either_
> D' or E', but not B'. In fact, since D' and E' are _identical_ as far as
> we're concerned, it doesn't really matter which is chosen. The other one
> of the two becomes an unused branch with no children -- we end up with a
> graph looking like this. 
> 
>       A'
>      / \
> D'  E'  F'
>   \/    |
>         I'

You will never see this, because D' is simply not reachable. You can have 
either:

 - A got simplified away as a merge entirely, because C was identical, and 
   B was thus considered "uninteresting" (as in "it not matter for the 
   end result"), and then the later phase will always remove A too (since, 
   by definition, for the merge to be simplified to a non-merge, it must 
   be identical to the parent it was simplified to have)

 - or _both_ B and C were different to A in those files, and A still 
   exists as a merge, but B was identical to one of its parents (let's say 
   E), and was first simplified to "B->E->G", and then because B and E 
   were identical, B itself was dropped, and only

	  A'
	 / \
	E'  F'
	|   |
	G'  I'

remains.

NOTE NOTE NOTE! This is how "git rev-list" (and all the other related git 
tools, like "git log" etc) simplify the tree. It is, in my opinion, the 
only sane way to do it, although you can pass in "--full-history" to say 
that you don't want any merge simplification at all.

The reason I mention it is that _your_ simplifications may obviously do 
something else entirely, and you may obviously have different rules for 
how you simplify the tree further. But it sounds like you don't simplify 
the history at all (apart from the simplification that git-rev-list did 
for you)?

			Linus
