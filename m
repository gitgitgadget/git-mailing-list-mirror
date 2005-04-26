From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: : Networking
Date: Tue, 26 Apr 2005 07:59:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504260746320.18901@ppc970.osdl.org>
References: <20050425214326.512b006e.davem@davemloft.net>
 <20050426005725.6bfe6135.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David S. Miller" <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 16:54:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQRQi-0001uS-EI
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 16:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVDZO5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 10:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVDZO5x
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 10:57:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:29613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261505AbVDZO5e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 10:57:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QEvVs4023845
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 07:57:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QEvUCu018481;
	Tue, 26 Apr 2005 07:57:31 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050426005725.6bfe6135.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Andrew Morton wrote:
> 
> So I tried to apply my new get-mm-patches-from-git methodology on this and
> came unstuck.

Yes. You cannot just apply patches, since that will inevitably fail if 
there is any overlap. Which there quite often is.

For this to work in general, you really have to merge the different git 
trees, and generate patches from _that_.

> a) Set up the git repo
> 
> 	mkdir git26
> 	git init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Yes. In the long run, you really should need to do this just once, since 
if there is one thing git should be good at, it's just keeping tons of 
random collections of objects around.

The only thing you should be a bit careful about is to remember what the 
"heads" at different points were. In particular, you want to remember 
where you merged with me last was. I've started tagging my releases with 
the git tag facility (_not_ the pasky one, but I think pasky will start 
picking up on that soon enough), so finding a specific release will be 
easy, but if you ever do a non-release merge you'll just have to tag it 
yourself.

> b) Add davem's repo:
> 
> 	git addremote git-net rsync://rsync.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git
> 
> c) To generate -mm's linus.patch (patch against 2.6.12-rc3):
> 
> 	git pull origin
> 	git diff -r v2.6.12-rc3 > ../25/patches/linus.patch

You should now also remember the HEAD at this point. That's your "base" 
for any future patches, since you expect other patches to apply on top of 
that.

I think cogito remembers it in the "origin" thing, but you should check.

Save it away in (for example) .git/last-diff-head:

	cat .git/HEAD > .git/last-diff-head

> d) To generate davem's tree (patch against linus's current tree (ie: patch
>    against 2.6.12-rc3+linus.patch)):
> 
> 	git pull git-net

Yes. This should have merged the two (assuming "git pull" does what I 
think it does).

> 	MERGE_BASE=$(merge-base $(cat .git/heads/origin ) $(cat .git/heads/git-net))
> 	git diff -r $MERGE_BASE:$(cat .git/heads/git-net) > ../25/patches/git-net.patch

No. Now you ended up looking at the last common ancestor of the thing you 
merged, and you _should_ have looked at what the difference was _before_ 
the merge. 

So assuming it does remember it in "origin", you should just have done

	git diff -r $(cat .git/last-diff-head):$(cat .git/HEAD)

which basically says "diff between the tree at the time of my last diff,
and the result of the merge".

Then you just update your last-diff-head to reflect that:

	cat .git/HEAD > .git/last-diff-head

and you go on:

> e) Repeat d) for all known git trees.

Yup.

				Linus
