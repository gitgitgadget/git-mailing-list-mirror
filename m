From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to get a directory filled with v2.6.11?
Date: Tue, 12 Jul 2005 21:37:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507122116280.17536@g5.osdl.org>
References: <20050712050347.GA10751@buici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 06:37:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsYzt-0001rs-Lp
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 06:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVGMEhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 00:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVGMEhO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 00:37:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262549AbVGMEhM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 00:37:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6D4bAjA012152
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 12 Jul 2005 21:37:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6D4b6Ts024684;
	Tue, 12 Jul 2005 21:37:07 -0700
To: Marc Singer <elf@buici.com>
In-Reply-To: <20050712050347.GA10751@buici.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Marc Singer wrote:
>
> I switched to using the git version in source control.
> Checkout/branching works great.  :-)
> 
> But, this version of git doesn't let me do
> 
>   # git checkout -f v2.6.11
>   error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
>   Needed a single revision
> 
> which I suspect is protection added to prevent my special sort of
> shenanigans.  If I cannot perform the checkout anymore, is there
> another way to fill a directory with the contents of that particular
> tree?

Yes. Multiple ways. 

You can

 - just force that tree to be checked out:

	git-read-tree -m v2.6.11
	git-checkout-cache -f -u -a

   this basically gets you the state at the time of v2.6.11, but you still 
   don't have a _commit_ yet, so you'd have nothing to start actual 
   development from. BE CAREFUL! Your "HEAD" is now pointing to something 
   else than what you have checked out, so the next thing you want to do 
   is fix that up.

 - now, you can commit that as a _parentless_ commit (ie an "Initial
   commit") on a new branch, with something like this:

	echo "Linux 2.6.11" | git-commit-tree $(git-write-tree) > .git/refs/heads/my-branch
	ln -sf .git/HEAD refs/heads/my-branch

   and off you go. The above just creates a commit of the tree (which is 
   the v2.6.11 tree, since you did a "git-read-tree" on it), and uses the
   commit message "Linux 2.6.11"). It gives it no parents, and writes the
   result to the "my-branch" thing. It then makes HEAD point to that 
   branch, which completes the thing, and now your tree is in a consistent 
   state (ie HEAD matches what you have checked out, which matches 
   v2.6.11)

That's one way.

You can do it sneakier too, if you want to, and create the branch first. 
In particular, you can do

	git-cat-file tag v2.6.11

which will print out that tag, which starts with:

	object c39ae07f393806ccf406ef966e9a15afc43cc36a
	type tree
	tag v2.6.11-tree
	...

and now you can just do use that tree directly, without even reading it 
in:

	head=$(echo "Linux 2.6.11" | git-commit-tree c39ae07f393806ccf406ef966e9a15afc43cc36a)
	echo $head > .git/refs/heads/my-branch

which will give you the new branch.

Now you can just do

	git checkout my-branch

and you'll be there.

That said, whatever you do you will eventually end up with a series of
commits that are not related to the "normal" commits in the 2.6.12-rc2+
chain, and since they don't have a common point, git won't be able to
merge them for you. Git will be able to _track_ them for you, but at some
point you'll want to probably try to move them forward to the "rest" of
the git history.

And I'll warn you that that is not going to be entirely trivial, although
Junio's "cherrypick" scripts should be useful as a way to automate it at
least to some degree. This is why it would be so much easier if you could 
have started with a 2.6.12-rc2 or other "real" commit ;)

			Linus
