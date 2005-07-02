From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Fri, 1 Jul 2005 18:56:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507011831060.2977@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com>
 <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org> <42C482ED.1010306@zytor.com>
 <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org> <42C5D553.80905@timesys.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 04:01:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoXK2-00042Q-8X
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 04:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbVGBCHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 22:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVGBBzf
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 21:55:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261678AbVGBBzO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 21:55:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j621snjA019204
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 1 Jul 2005 18:54:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j621sco1005893;
	Fri, 1 Jul 2005 18:54:44 -0700
To: Mike Taht <mike.taht@timesys.com>
In-Reply-To: <42C5D553.80905@timesys.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 1 Jul 2005, Mike Taht wrote:
> 
> You are getting closer and closer to where something like bitTorrent or 
> a multicast protocol makes sense. The problem isn't just the number of 
> outstanding commit objects but the number of machines and developers 
> that want to grab those commits at the same time.

I don't think so. First off, I don't think the decision is kernel- 
specific, in the sense that I at least use git for sparse and git itself 
too, so the solution should make sense for small projects as well.

Also, even for the kernel, the total dataset right now (after three months
or whatever) is a 60MB pack. It's not like we're sending DVD's or even
CD's worth of data around - we're sending the equivalent of 20MB per
_month_. That's really not a lot of data. You could easily keep up with a 
slow modem.

Also, the number of people involved isn't _that_ big. We're talking a few
thousand people who actively would update their trees for a big project,
and many smaller projects have anything from a couple to maybe a hundred. 
A few mirrors, and you don't have any problem.

So I think that the problem is actually not that big, and we just need to
find an acceptable format. Quite frankly, it might be perfectly acceptable
for kernel.org to run a simple packing script once a week which packs
everything into one single file, and even if that means that the mirrors
will have to re-get everything once a week, that actually sounds 
acceptable.

It's obviously a _stupid_ way to handle the rsync problem, so there's 
bound to be some cleaner solution, but the point is that we can probably 
make mirroring acceptable even with a really really stupid approach. I'd 
be a bit ashamed of just how ugly it is, but it would likely _work_ fine.
You'd create 52 pack-files in a year, but each pack-file is likely just
ten megabytes each. 

Oh, each pack-file should also be associated with the list of "refs" that
were used to generate that pack-file, so make that 104 files per project
year (but the list of "refs" would usually be something small, like

	refs/heads/master       4a89a04f1ee21a7c1f4413f1ad7dcfac50ff9b63
	refs/tags/v2.6.11       5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
	refs/tags/v2.6.11-tree  5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
	refs/tags/v2.6.12       26791a8bcf0e6d33f43aef7682bdb555236d56de
	refs/tags/v2.6.12-rc2   9e734775f7c22d2f89943ad6c745571f1930105f
	refs/tags/v2.6.12-rc3   0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
	refs/tags/v2.6.12-rc4   ebb5573ea8beaf000d4833735f3e53acb9af844c
	refs/tags/v2.6.12-rc5   06f6d9e2f140466eeb41e494e14167f90210f89d
	refs/tags/v2.6.12-rc6   701d7ecec3e0c6b4ab9bb824fd2b34be4da63b7e
	refs/tags/v2.6.13-rc1   733ad933f62e82ebc92fed988c7f0795e64dea62

which was trivially generated from my current tree with

	for i in refs/*/*; do echo -ne $i"\t"; cat $i; done

so now you can use the refs associated with the previous pack-file as the 
list of refs you're _not_ interested in, and the current list of refs as 
the list you _are_ interested in, and generate the new pack-file.

Generating the pack-file would literally be something like

	obj=$(git-rev-parse $(cut -f2 new-list) --not $(cut -f2 old-list))
	git-rev-list $obj | git-pack-objects --stdin > new-pack

so a few one-liners like this, run from a cron-job once a week, should
just do it.

		Linus
