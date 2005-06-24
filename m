From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Finding what change broke ARM
Date: Fri, 24 Jun 2005 09:03:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506240824320.11175@ppc970.osdl.org>
References: <20050624101951.B23185@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Whitcroft <apw@shadowen.org>,
	Dave Hansen <haveblue@us.ibm.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 18:02:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlqc9-0000tL-Gp
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 18:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbVFXQG5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 12:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbVFXQEi
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 12:04:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263067AbVFXQBk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 12:01:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5OG16jA011836
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 09:01:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5OG15XD029197;
	Fri, 24 Jun 2005 09:01:06 -0700
To: Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20050624101951.B23185@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 24 Jun 2005, Russell King wrote:
>
> When building current git for ARM, I see:
> 
>   CC      arch/arm/mm/consistent.o
> arch/arm/mm/consistent.c: In function `dma_free_coherent':
> arch/arm/mm/consistent.c:357: error: `mem_map' undeclared (first use in this function)
> arch/arm/mm/consistent.c:357: error: (Each undeclared identifier is reported only once
> arch/arm/mm/consistent.c:357: error: for each function it appears in.)
> make[2]: *** [arch/arm/mm/consistent.o] Error 1
> 
> How can I find what change elsewhere in the kernel tree caused this
> breakage?

Ahhah! A real-world example of what cool things git can do. 

Anyway, the first starting point is _exactly_ the same as under BK, except 
the syntax is very different, and git does it better, in fact:

	git-whatchanged -p arch/arm/mm/consistent.c

However, in this case nothing has changed in that file over the whole 
git history, so you get an empty answer. Let's go to phase two, but first 
a comment:

> With bk, you could ask for a per-file revision history of the likely
> candidates, and then find the changeset to view the other related
> changes.
> 
> With git... ?  We don't have per-file revision history so...

We don't _store_ changes as per-file revision histories, but we do store 
it in a way where finding out what happened is efficient even per-file. 
While a line-by-line "annotate" is not efficient, the "what changed" 
certainly is.

And git actually does better than BK (or _any_ per-file history thing),
because "git-whatchanged" actually works over directories or multiple
independent files too, and it works purely on pathnames, so you can say
"git-whatchanged" for a file that has gone away to see _why_ it went away.  
In most other systems it's really hard to see what happened to something
that isn't there any more..

Anyway, the problem clearly didn't happen because of any changes to that 
file at all, so here per-file history simply doesn't help. But never fear, 
we're not screwed yet. In particular, you will now obviously suspect that 
since it wasn't that _file_ that changed, and since you know what changed 
in the ARM code, it's going to be a generic linux header file change that 
screwed you over.

So phase #2 is to do

	git-whatchanged -p include/linux

(which shows every commit that touches include/linux, and shows that part
as a patch, thus the "-p"). That starts up a pager on the results by
default, so we just be stupid about it and do a "/mem_map" to look for
changes that mention mem_map. Maybe we'll be lucky.

Even that doesn't show a whole lot: but it does point a very suspicious
finger to the recently merged sparse-mem stuff from Andy Whitcroft,
though.

And now you have a commit to look at, namely the "sparsemem memory model" 
one, commit ID d41dee369bff3b9dcb6328d4d822926c28cc2594.

In fact, looking at it, I think it's simply config option changes, and
probably the SPARSEMEM config option that has preempted your lack of
DISCONTIGMEM support.  But now you have somebody to blame and to ask for
help from: Andy Whitcroft and Dave Hansen, whom I've cc'd.

I might start phase #3 with

	git-whatchanged -p mm/Kconfig arch/arm/Kconfig

but at this point you may already have enough of a clue that you don't 
even care any more.

		Linus
