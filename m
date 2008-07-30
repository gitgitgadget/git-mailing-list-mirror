From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 21:52:35 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807292126430.3334@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <20080729053108.GH26997@sigill.intra.peff.net> <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain> <20080729125247.GC12069@sigill.intra.peff.net>
 <alpine.LFD.1.10.0807291006070.3334@nehalem.linux-foundation.org> <20080730042609.GB3350@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 30 06:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO3kc-0004Pt-1g
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 06:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbYG3E41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 00:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbYG3E41
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 00:56:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53798 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756678AbYG3E40 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2008 00:56:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U4tYdk022298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 21:55:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U4tYtR007936;
	Tue, 29 Jul 2008 21:55:34 -0700
In-Reply-To: <20080730042609.GB3350@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.405 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Wed, 30 Jul 2008, Jeff King wrote:
> 
> I agree with you, btw. It is definitely correct and useful; however, I
> am curious if there is some "in between" level of simplification that
> might produce an alternate graph that has interesting features. And that
> is why I am trying to get Roman to lay out exactly what it is he wants.

Actually, I know what he wants, since I tried to describe it for the 
filter-branch discussion. It's really not that conceptually complex.

Basically, the stupid model is to just do this:

 - start with --full-history

 - for each merge, look at both parents. If one parent leads directly to 
   a commit that can be reached from the the other, just remove that 
   parent as being redundant. And if that removal leads to a merge now 
   becoming a non-merge, and it has no changes wrt its single remaining 
   parent, remove the commit entirely (rewriting any parenthood to make 
   the rest all stay together, of course)

 - repeat until you cannot do any more simplification (removing one commit 
   can actually cause its children to now become targets for this 
   simplification).

and I suspect that

 (a) the stupid model is probably at least O(n^3) if done stupidly and 
     O(n^2) with some modest amount of smarts (keeping a list of at least 
     potential targets of simplification and expanding it only when 
     actually simplifying), but that
 (b) you can concentrate on just the merges that the current optimizing 
     algorithm would have removed, so 'n' is not the total number of 
     commits, but at most the number of merges, and more likely actually 
     just the number of trivial merges in that file, and finally
 (c) there is likely some smart and efficient graph minimization algorithm 
     that is O(nlogn) or something.

so I don't think it's likely to be hugely more expensive than the 
topo-sort is. All the real expense is in the same thing the topo-sort 
expense, namely in generating the list up-front.

I bet googling for "minimal directed acyclic graph" will give pointers.

And despite the fact that I've argued against Roman's world-view, I 
actually _do_ think it would be nice to have that third mode, the same way 
that we have --topo-order. It wouldn't be good for the _default_ view, but 
then neither is --full-history, so that's not a big argument.

That said, I'd like to (again) repeat the caveat that it's probably best 
done in the tool that actally visualizes the mess - exactly for the same 
reason that I argued for the topological sort being done in gitk. It's 
very painful to have to wait for the first few commits to start appearing 
in the history window.

Admittedly most of my work is actually done on machines that are pretty 
fast, but every once in a while I travel with a laptop. And more 
importantly, not everybody gets new hardware from Intel for testing even 
before the CPU has been released. So others will still appreciate 
incremental history updates, even if my machine might be fast enough (and 
my kernel tree always in the caches) that I myself could live with a 
synchronous version a-la --topo-order.

			Linus
