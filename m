From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 17:42:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
References: <20050414002902.GU25711@pasky.ji.cz> <20050413212546.GA17236@64m.dyndns.org>
 <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz>
 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
 <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 02:38:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMEq8-00053B-7P
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 02:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVDOAk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 20:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVDOAk4
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 20:40:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:29132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261682AbVDOAkj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 20:40:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3F0eXs4025193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 17:40:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3F0eWio029781;
	Thu, 14 Apr 2005 17:40:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



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
figure out the trees, and then at least have the _option_ to do the merge 
at a pure tree object.

In particular, if you ever find yourself wanting to graft together two
different commit histories, that almost certainly is what you'd want to
do. Somebody might have arrived at the exact same tree some other way,
starting with a 2.6.12 tar.ball or something, and I think we should at
least support the notion of saying "these two totally unrelated commits
actually have the same base tree, so let's merge them in "space" (ie data)
even if we can't really sanely join them in "time" (ie "commits").

I dunno.

And it's also a question of sanity. The fact is, we know how to make tree 
merges unambiguous, by just totally ignoring the history between them. Ie 
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

I've not even been convinved that renames are worth it. Nobody has really 
given a good reason why.

There are two reasons for renames I can think of:

 - space efficiency in delta-based trees. This is a total non-issue for 
   git, and trying to explicitly track renames is going to cause _more_
   space to be wasted rather than less.

 - "annotate". Something git doesn't really handle anyway, and it has 
   little to do with renames. You can fake an annotate, but let's face it, 
   it's _always_ going to be depending on interpreting a diff. In fact, 
   that ends up how traditional SCM's do it too - they don't really 
   annotate lines, they just interpret the diff.

   I think you might as well interpret the whole object thing. Git _does_ 
   tell you how the objects changed, and I actually believe that a diff 
   that works in between objects (ie can show "these lines moved from this
   file X to tjhat file Y") is a _hell_ of a lot more powerful than
   "rename"  is.

   So I'd seriously suggest that instead of worryign about renames, people 
   think about global diffs that aren't per-file. Git is good at limiting 
   the changes to a set of objects, and it should be entirely possible to 
   think of diffs as ways of moving lines _between_ objects and not just
   within objects. It's quite common to move a function from one file to 
   another - certainly more so than renaming the whole file.

   In other words, I really believe renames are just a meaningless special 
   case of a much more interesting problem. Which is just one reason why 
   I'm not at all interested in bothering with them other than as a "data 
   moved" thing, which git already handles very well indeed.

So there,

		Linus
