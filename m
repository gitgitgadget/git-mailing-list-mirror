From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 10:11:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504150950420.7211@ppc970.osdl.org>
References: <20050414002902.GU25711@pasky.ji.cz>  <20050413212546.GA17236@64m.dyndns.org>
  <20050414004504.GW25711@pasky.ji.cz>  <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
  <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
  <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
  <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>  <20050414121624.GZ25711@pasky.ji.cz>
  <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
  <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
  <1113559330.12012.292.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
 <1113580881.27227.73.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.61.0504151230180.27637@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 19:07:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMUGq-0003B9-Gc
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 19:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVDORJv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 13:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVDORJv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 13:09:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:63410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261866AbVDORJr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 13:09:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3FH9Zs4032210
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 10:09:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3FH9Xp7001896;
	Fri, 15 Apr 2005 10:09:34 -0700
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504151230180.27637@cag.csail.mit.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, C. Scott Ananian wrote:
> 
> I think examining the rsync algorithms should convince you that finding 
> common chunks can be fairly efficient.

Note that "efficient" really depends on how good a job you want to do, so 
you can tune it to how much CPU you can afford to waste on the problem.

For example, my example had this thing where we merged five different
functions into one function, and it is truly pretty efficient to find
things like that _IF_ we only look at the files that changed (since the
set of files that change in any one particular commit tends to be small,
relative to the whole repository). There are many good algorithms for 
finding "common code", and with modern hardware that is basically 
instantaneous if you look at a few tens of files.

For example, people wrote efficient things to compare _millions_ of lines 
of code for the whole SCO saga - you can do quite well. Some googling 
comes up with for example

	http://minnie.tuhs.org/Programs

and applying those to a smallish set of files is quite efficient.

What is _not_ necessarily as easy is the situation where you notice that a 
new set of lines appeared, but you don't see any place that matches that 
set of lines in the set of CHANGED files. That's actually quite common, ie 
let's say that you have a new filesystem or a new driver, and almost 
always it's based on a template or something, and you _would_ be able to 
see where that template came from, except it's not in that _changed_ set.

And that is still doable, but now you really have to compare against the
whole tree if you want to do it. Even _that_ is actually efficient if you
cache the hashes - that's how the comparison tools compare two totally
independent trees against each other, and it makes it practically possible
to do even that expensive O(n**2) operation in reasonable time. It's
certainly possible to do exactly the same thing for the "new code got
added, does it bear any similarity to old code" case.

Note! This is a question that is relevant and actually is in the realm of
the "possible to find the answer interactively".  It may fairly expensive, 
but the point is that this is the kind of relevant question that really 
does depend on the fundamental notion that "data matters more than any 
local changes". And when you think about the problem in that form, you 
find these kinds of interesting questions that you _can_ answer.

Because the way git identifies data, the example "is there any other
relevant code that may actually be similar to the newly added code" is
actually not that hard to do in git. Remember: the way to answer that
question is to have a cache of hashes of the contents. Guess what git
_is_? You can now index your line-based hashes of contents against the
_object_ hashes that git keeps track of, and you suddenly have an
efficient way to actually look up those hashes.

NOTE! All of this is outside the scope of git itself. This is all
"visualization and comparison tools" built up on top of git. And I'm not
at all interested in writing those tools myself, and I'm absolutely not
signing up for that part. All I'm arguing for is that the git architecture
is actually a very good architecture for doing these kinds of very very
cool tools.

			Linus
