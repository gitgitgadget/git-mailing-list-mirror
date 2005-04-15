From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 08:51:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504150836410.7211@ppc970.osdl.org>
References: <20050414002902.GU25711@pasky.ji.cz>  <20050413212546.GA17236@64m.dyndns.org>
  <20050414004504.GW25711@pasky.ji.cz>  <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
  <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
  <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
  <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>  <20050414121624.GZ25711@pasky.ji.cz>
  <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
  <1113556448.12012.269.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0504150740310.7211@ppc970.osdl.org>
 <1113578964.27227.65.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 17:48:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMT2A-0007jX-76
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 17:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVDOPuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 11:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVDOPuV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 11:50:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:47500 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261816AbVDOPuH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 11:50:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3FFnvs4025158
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 08:49:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3FFnuLi029808;
	Fri, 15 Apr 2005 08:49:56 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113578964.27227.65.camel@hades.cambridge.redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, David Woodhouse wrote:
> 
> And when I'm looking for the change that broke something, I can almost
> always tell which file it's in and go looking in _that_ file.

Read my email about finding "what changed" that I sent out a minute ago.

I claim that my algorithm for finding "what changed" handles your "single
file" case as a very small (and usually quite uninteresting) special case.

I claim (and if you just look at my proposal I think you'll agree) that I
can track single functions, and do it efficiently. WITHOUT adding any
meta-data at all.

The thing is, if the question is "I have this piece of code, and I want to 
see what changed", you fundamentally _can_ do that efficiently. That's 
really what git was designed for. It's the whole _point_ of having history 
in the first place. If git didn't care, it wouldn't have a back-pointer to 
the tree it came from, and we'd all be just merging pure trees.

But you mix that question up with "how do I save that information in the 
commit", which is a totally unnecessary mix-up, and which makes things 
MUCH more complicated, for absolutely zero gain.

In fact, because you mixed up those two issues, the problem now became so
complicated that you can no longer solve it, so you start doing hacks like
"the user has to tell us what he did" (aka "bk mv" or "svn rename"), and 
you start mentally to limit yourself to files, because you realize that 
you _have_ to limit your intractable problem to make it at all solvable.

And I'm telling you that your problem is STUPID. You made it stupid by 
thinking that every question about the source tree should be answered at 
commit time. Which just clearly isn't true!

If you just drop the tying-together, and accept that "what changed" is a
valid question _regardless_ of trying to track it at commit time, now your
whole world opens up. Birds sing, the sun is shining on you, and beautiful
scantily clad women (or men) dance around you. The world is suddenly a 
good place, just _filled_ with possibilities.

Suddenly you realize that if the question is just "what changed in this
piece of code" (and let's face it, that _is_ the question), you can track 
it afterwards. Trying to tie in "commit time" into the question was what 
made it hard. If you do _not_ due that (totally unnecessary) tie-in, the 
question suddenly becomes easy to answer, and several obvious and simple 
answers spring to mind pretty immediately.

> It's not about ditching the per-tree tracking and doing per-file
> tracking instead. I agree that would be wrong. It's about storing enough
> information to track what happened to given content as it moved around
> within the tree.

No. Git absolutely does have everything you need already. You just aren't 
realizing that it's already there - in the data - and that you can do much 
more intelligent searches for changes if you accept that undeniable fact.

The fact that you can NOT do those searches at commit-time (which is a 
global op), and can only do them if you have a specific question in mind 
("what changed _here_"), is the big issue.

The thing is, at commit-time you'd need to answer every possible question
("what changed here, and here, and here, and in this function, and in this
file, and in this directory and why did this identifier get renamed and 
why is the sky blue"). AND YOU FUNDAMENTALLY CANNOT DO THAT. It's 
impossible.

But once you _know_ the question (which is the only time when the answer
is actually relevant, so why care about if before that time?), you can
find out the answer by just automating the job of looking at the _data_. 
It's easy. The question makes it obvious by its nature. The question is 
the thing that gives you the specifics that makes the search possible in 
the first place.

And _this_ is why the data matters. Renames and file boundaries do not.
And until you accept that, you just limit yourself.

		Linus
