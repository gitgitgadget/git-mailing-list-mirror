From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 15:04:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281451320.18901@ppc970.osdl.org>
References: <42703E79.8050808@zytor.com> <1114673723.12012.324.camel@baythorne.infradead.org>
 <20050428081005.GG8612@pasky.ji.cz> <1114676955.12012.346.camel@baythorne.infradead.org>
 <1114680199.12012.363.camel@baythorne.infradead.org>
 <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org> <7v1x8u7g26.fsf@assigned-by-dhcp.cox.net>
 <1114723402.2734.11.camel@localhost.localdomain> <7voeby60fp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, Petr Baudis <pasky@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:59:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRH1b-0007wJ-TW
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVD1WDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVD1WDt
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:03:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:42156 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262279AbVD1WDL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 18:03:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SM2ws4017620
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 15:02:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SM2vSD014381;
	Thu, 28 Apr 2005 15:02:57 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voeby60fp.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Junio C Hamano wrote:
> 
> If that is really the case, shouldn't we do one of the
> following:

No. It's not the case that time-stamps are meaningless. 

The thing about distributed stuff is that time gets "fuzzy". It doesn't go 
away. It's still very valid to say "this was done yesterday".

But what gets fuzzy is "before" and "after". For two reasons:

 - time isn't synchronized, and clocks can be off. Usually by just a 
   little bit, but sometimes you'll find just plain badly maintained 
   machines, and time can be a year or two off.

   Ergo: time is a _hint_. It's usually a pretty good hint, but it's a 
   hint.

 - the "parent" relationship is the only "hard" before/after thing that 
   git knows about, but it ignores a lot of real-world interaction, so
   thinking that it is the _only_ before/after measure is ignoring all the
   other communication in a system.

   So parenthood guarantees that something happened "before", but _not_ 
   being directly related doesn't mean that they were totally independent. 
   There's no fixed "speed of light" that defines some absolute "cone of 
   reachability".

So time is relevant, but it's more of a hint than anything absolute. 
Anything that -depends- on time is a bug waiting to happen, but something 
that uses time to visualize things makes sense.

The big advantage with time is that it's cheap. If you want to do a full 
reachability analysis, you have to look at the whole revision tree. That's 
quite possible RIGHT NOW, but it simply ill not be practical in a year, 
when we have 15,000 commits.

So "time" ends up being an approximation for "doing it right".

As an example: it's quite expensive to ask "was this commit part of 
2.6.12-rc3?" because that involves knowing the whole set of commits 
involved in 2.6.12-rc3. Which in turn involves walking the whole revision 
tree starting at 2.6.12-rc3 downwards. 

That's exactly what "rev-tree" does, though. "rev-tree" will do the whole
reachability thing, and as a result you can see whether something was in
2.6.12-rc3 or not. But just for fun - time how long it takes for
"rev-tree" to output its first entry, and how long it takes for "rev-list"
to print its first line. 

Hint: do it with a cold-cache "sparse" tree. "rev-list" will start
outputting data immediately, and work it out as it goes along. "rev-tree"  
will think for some time, and then blast the data out.

In other words: rev-list is what you want for something like "git log", 
because you care about _latency_ of the result.

And that's why it uses time. It's an approximation, but it is an 
approximation that has meaning in real life.

		Linus
