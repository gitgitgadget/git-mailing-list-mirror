From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: "--bisect" flag
Date: Mon, 20 Jun 2005 05:55:19 +1000
Message-ID: <2cfc4032050619125537dee354@mail.gmail.com>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
	 <2cfc403205061817181e4d6d5e@mail.gmail.com>
	 <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
	 <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
	 <2cfc403205061903155a6090db@mail.gmail.com>
	 <2cfc40320506190741409f3a5@mail.gmail.com>
	 <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 19 21:49:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk5nk-0007qe-JB
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 21:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVFSTzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 15:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVFSTzb
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 15:55:31 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:59720 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261296AbVFSTzU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 15:55:20 -0400
Received: by rproxy.gmail.com with SMTP id i8so491013rne
        for <git@vger.kernel.org>; Sun, 19 Jun 2005 12:55:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H3tcGuBA+Jx6lV2F+oEx8P+UpjEVTWdFIOwA0t/noyB7625AnJHg83aaG7NYRqPxn9QKq1y0woU/AhIxtmYatUouOma6qsiL9BDdeh974YIQ3Ml9JQz+sTW7qPyjlsOTzArWj5taJpFzP7BIN+WXP9h99R3by1+HDNB5OZ2RNnw=
Received: by 10.38.65.4 with SMTP id n4mr1904559rna;
        Sun, 19 Jun 2005 12:55:19 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sun, 19 Jun 2005 12:55:19 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/20/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Mon, 20 Jun 2005, Jon Seymour wrote:
> >
> > Would I be correct in stating that an intuitive  reason why your
> > algorithm is better than selecting the linear middle is the following:
> >
> > If you concentrate on testing merges, rather than non-merges, the
> > chances are you are going to eliminate N-times as many possible good
> > commits as if you pick a random commit, where N is the average fan-out
> > of the commit graph.
> 
> No. You really shouldn't concentrate on merges either.
> 
> The thing is, you do _not_ want to test as many commits as possible, or as
> few commits as possible.
> 
> This is _not_ a "try to eliminate as many commits as possible" problem.
> It's really one of trying to eliminate _half_ the commits. Not more, not
> less.
> 

Yep, ok, so the node you are looking for is one that can reach as
close to half of the rest of the graph as possible - that's what you
mean by half-way reachability. If the graph was N nodes deep (no
fan-out) that would be the literal middle. If it was N nodes wide
(e.g. fanout N), there is no good node and you basically have to test
everything since one test doesn't imply anything about the other N-1
nodes.

A typical commit graph is worse than O(log2 N) by a factor that is
determined by some measure of the parallel branching in the graph.

> 
> The reason my algorithm is so horrid (O(3)) is that you can't even cache
> the dang thing sanely: you can't optimize if by remembering how many
> interesting commits are reachable from one commit, and then doing "this
> commit reaches commits X and Y, so I can reach X.count + Y.count commits
> from it". That's just not true, because often (basically always) there is
> lots of common commits in X.count and Y.count..

I presume  you mean O(N^3)?
 
Will you accept a patch that can reduce the worst case cost to some
lower order? I have a hunch (conceivably wrong, of course) that it can
be done in O(N).

> > This compares with my naive literal middle algorithm (measurements
> > only for the first 619 commits):
> >
> > average(21), median(16), stdev(10.6), max(49), min(8).
> 
> Yes. I really don't believe you can do better than 12, unless you start
> depending on knowledge of the distribution of bugs.
> 

Agreed. 

jon.
