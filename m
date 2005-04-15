From: "Barry Silverman" <barry@disus.com>
Subject: RE: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 22:33:26 -0400
Message-ID: <000001c54163$85540150$6400a8c0@gandalf>
References: <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Petr Baudis'" <pasky@ucw.cz>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:31:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMGbG-00005J-6R
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 04:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVDOCdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 22:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVDOCdv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 22:33:51 -0400
Received: from borg.disus.com ([199.243.199.210]:9735 "EHLO borg.disus.com")
	by vger.kernel.org with ESMTP id S261724AbVDOCdd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 22:33:33 -0400
Received: from gandalf (vpn2000h.secdisus.com [199.246.34.127])
	by borg.disus.com (8.11.6/8.11.6) with ESMTP id j3F1XSf18556;
	Thu, 14 Apr 2005 21:33:28 -0400
To: "'Linus Torvalds'" <torvalds@osdl.org>,
	"'Junio C Hamano'" <junkio@cox.net>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>In particular, if you ever find yourself wanting to graft together two
>>different commit histories, that almost certainly is what you'd want
to >>do. Somebody might have arrived at the exact same tree some other
way, >>starting with a 2.6.12 tar.ball or something, and I think we
should at >>least support the notion of saying "these two totally
unrelated commits >>actually have the same base tree, so let's merge
them in "space" (ie data) >>even if we can't really sanely join them in
"time" (ie "commits").

If this is true - then the tree-id's of the two commits would be
identical, but the commit-id's wouldn't.

Does this imply that common ancestor lookup should work by comparing the
tree-id's (space-wise the same) rather than the commit-ids (time-wise
the same)?

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
Behalf Of Linus Torvalds
Sent: Thursday, April 14, 2005 8:43 PM
To: Junio C Hamano
Cc: Petr Baudis; git@vger.kernel.org
Subject: Re: Merge with git-pasky II.



On Thu, 14 Apr 2005, Junio C Hamano wrote:
>
> You say "merge these two trees" above (I take it that you mean
> "merge these two trees, taking account of this tree as their
> common ancestor", so actually you are dealing with three trees),

Yes. We're definitely talking three trees.

> and I am tending to agree with the notion of merging trees not
> commits.  However you might get richer context and more sensible
> resulting merge if you say "merge these two commits".  Since
> commit chaining is part of the fundamental git object model you
> may as well use it.

Yes and no. There are real advantages to using the commit state to just 
figure out the trees, and then at least have the _option_ to do the
merge 
at a pure tree object.

In particular, if you ever find yourself wanting to graft together two
different commit histories, that almost certainly is what you'd want to
do. Somebody might have arrived at the exact same tree some other way,
starting with a 2.6.12 tar.ball or something, and I think we should at
least support the notion of saying "these two totally unrelated commits
actually have the same base tree, so let's merge them in "space" (ie
data)
even if we can't really sanely join them in "time" (ie "commits").

I dunno.

And it's also a question of sanity. The fact is, we know how to make
tree 
merges unambiguous, by just totally ignoring the history between them.
Ie 
we know how to merge data. I am pretty damn sure that _nobody_ knows how

to merge "data over time". Maybe BK does. I'm pretty sure it actually 
takes the "over time" into account. But My goal is to get something that

works, and something that is reliable because it is simple and it has 
simple rules.

As you say:

> This however opens up another set of can of worms---it would
> involve not just three trees but all the trees in the commit
> chain in between.

Exactly.  I seriously believe that the model is _broken_, simply because

it gets too complicated. At some point it boils down to "keep it simple,

stupid".

>  That's when you start wondering if it would
> be better to add renames in the git object model, which is the
> topic of another thread.  I have not formed an opinion on that
> one myself yet.

I've not even been convinved that renames are worth it. Nobody has
really 
given a good reason why.

There are two reasons for renames I can think of:

 - space efficiency in delta-based trees. This is a total non-issue for 
   git, and trying to explicitly track renames is going to cause _more_
   space to be wasted rather than less.

 - "annotate". Something git doesn't really handle anyway, and it has 
   little to do with renames. You can fake an annotate, but let's face
it, 
   it's _always_ going to be depending on interpreting a diff. In fact, 
   that ends up how traditional SCM's do it too - they don't really 
   annotate lines, they just interpret the diff.

   I think you might as well interpret the whole object thing. Git
_does_ 
   tell you how the objects changed, and I actually believe that a diff 
   that works in between objects (ie can show "these lines moved from
this
   file X to tjhat file Y") is a _hell_ of a lot more powerful than
   "rename"  is.

   So I'd seriously suggest that instead of worryign about renames,
people 
   think about global diffs that aren't per-file. Git is good at
limiting 
   the changes to a set of objects, and it should be entirely possible
to 
   think of diffs as ways of moving lines _between_ objects and not just
   within objects. It's quite common to move a function from one file to

   another - certainly more so than renaming the whole file.

   In other words, I really believe renames are just a meaningless
special 
   case of a much more interesting problem. Which is just one reason why

   I'm not at all interested in bothering with them other than as a
"data 
   moved" thing, which git already handles very well indeed.

So there,

		Linus
-
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


