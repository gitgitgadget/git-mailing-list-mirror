From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: "--bisect" flag
Date: Mon, 20 Jun 2005 13:27:21 +1000
Message-ID: <2cfc403205061920272ee47166@mail.gmail.com>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
	 <2cfc403205061817181e4d6d5e@mail.gmail.com>
	 <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
	 <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
	 <2cfc403205061903155a6090db@mail.gmail.com>
	 <2cfc40320506190741409f3a5@mail.gmail.com>
	 <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org>
	 <2cfc4032050619125537dee354@mail.gmail.com>
	 <Pine.LNX.4.58.0506192002240.2268@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 05:22:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkCr6-0004Mk-19
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 05:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVFTD11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 23:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVFTD11
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 23:27:27 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:57336 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261415AbVFTD1V convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 23:27:21 -0400
Received: by rproxy.gmail.com with SMTP id i8so552798rne
        for <git@vger.kernel.org>; Sun, 19 Jun 2005 20:27:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jCA8OOKkVJ+8MfoSyRKUGcjk1EhrzJ+7QC1ecLaaeElQzavUSbRxI+SfO+pKh1feCX3TAyre78bNYz+/gN5DiWki2W4jsHYYW7/5CHDGm4ZpGoRFtDJvQyAoxep1LWjN8htkTvkkUQgjkOVyB1lk0z1CPTqHsbrIzeGMNfxOtas=
Received: by 10.38.65.4 with SMTP id n4mr2004675rna;
        Sun, 19 Jun 2005 20:27:21 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sun, 19 Jun 2005 20:27:21 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506192002240.2268@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Well, it depends on how nasty it ends up being. I thought my stupid
> algorithm would suck horribly, but considering that it can trivially
> bisect all of the git history so far in basically zero time, it doesn't
> seem to be that bad. You're more likely to have problems with having to
> bring in all the commits from disk in the cold-cache case than you are to
> have problems with the current algorithm performance.
> 

I'll give you a sketch of the algorithm. 

First, recall that merge-order code uses an incremental topological
sort whose key idea is to employ a conservation of mass analogy. A
similar analogy can help here.

1. count all visible nodes [ i.e. nodes that git-rev-list would print
], call this value N
2. at the top node inject N units of mass
3. traverse the visible graph, in topological order
4. at each node, send all the mass received from parents minus 1 unit
onto visible parents. Record how much mass you have sent downstream.
Keep a record of the nodes that have seen nearest to half of that
mass.
5. when the traversal completes, choose the node that saw closest to
1/2 of the original mass [ or pick one at random if there is more than
one ]. It must be able to reach close to 1/2 of the visible graph,
'cos all that mass it has seen has to drain somewhere!

This algorithm is demonstrably O(V+E) because the traversal is O(V+E)

My intention is to add this algorithm to my refactored
epoch.c/traversal.c, since this is a much better framework for doing
traversals than the current epoch.c.

Do you have any objections to me doing that?

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
