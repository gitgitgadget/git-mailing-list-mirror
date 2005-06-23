From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch (apply) vs. Pull
Date: Thu, 23 Jun 2005 15:20:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506231510370.11175@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506231522080.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 00:23:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dla5l-0004Jd-S6
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 00:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVFWW1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 18:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbVFWWUL
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 18:20:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47338 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262834AbVFWWSt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 18:18:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5NMIVjA005288
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Jun 2005 15:18:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5NMIUET015406;
	Thu, 23 Jun 2005 15:18:30 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506231522080.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 23 Jun 2005, Daniel Barkalow wrote:
>
> On Thu, 23 Jun 2005, Linus Torvalds wrote:
> > 
> > Right, that would mean that we don't control the hash generation at both 
> > points, and would make it fundamentally harder. But since the whole point 
> > is that we should be able to generate the ID _without_ it actually being 
> > stored away anywhere, this hash approach should work fine.
> 
> ("We" in this case being the developer checking whether the patch went in,
> not the maintainer)

Yes.

> We'll need to see if the performance is okay this way, both in terms of
> time spent searching for the patch you're checking on and in terms of
> recognizing the patch as being the same. No point in designing anything
> more complex until we determine if we can't just recognize it already.

Actually, this is a _very_ efficient check to do, because I'm just 
incredibly smart.

What you do is to download the current git tree (give it a while to mirror 
out, actually), and you get a magic "git-patch-id" program.

Now, the reason this is very efficient is magical. Let's say that you have
my tree as branch "linus", and you have your own tree (branch "daniel"),
and you want to see what commits are in both (but are not the _same_
commit - you just wonder if they have the same diff). That's a big clue 
that you should drop your copy, because I applied it as a diff.

What you do is simply:

	git-whatchanged -p linus..daniel | git-patch-id | sort > daniel-patch-id
	git-whatchanged -p daniel..linus | git-patch-id | sort > linus-patch-id
	join -j 1 linus-patch-id daniel-patch-id

and you're done. You've just created a list of commits that have the same 
patch ID (and it will list the patch ID _and_ the two commit ID's, just 
to be really nice about it).

It's all totally linear in number of patches involved (yeah, the "sort" is
obviously reall NlogN, and technically the git-rev-list between the two
trees _could_ be more than linear, but in practice they are very cheap and
very close to linear anyway).

It's also obviously totally untested, but hey, I always write perfect
code, so what could _possibly_ go wrong..

		Linus
