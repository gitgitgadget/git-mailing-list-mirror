From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git diffs
Date: Sun, 31 Jul 2005 18:00:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507311725590.14342@g5.osdl.org>
References: <20050731172256.73f91a20.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 03:01:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzOgA-0002hH-Qx
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 03:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVHABA5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 21:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVHABA5
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 21:00:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262312AbVHABAv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 21:00:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7110jjA023441
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Sun, 31 Jul 2005 18:00:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7110i9S012653;
	Sun, 31 Jul 2005 18:00:44 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050731172256.73f91a20.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 31 Jul 2005, Andrew Morton wrote:
> 
> So I finally decided to take a look at my git problems.  Discovered I
> couldn't fix them with zero git knowledge :(

Heh. We're here to please.

I'll cc the git list too, because there really _are_ a lot of people out 
there that know it fairly well, and may even have better suggestions than 
I do.

> What I want to do is to pull zillions of people's git trees into one repo
> and then run some magic command to give me unified diffs from everyone's
> trees which will apply to your latest.

Absolutely. 

Here's how to do it:

 - start off by fetching every single tree you want to have into its own 
   local branch. I think you basically do this already. If you're using 
   cogito, I think a simple "cg-pull" will do it for you.

   If you are using raw git, the easiest thing to do is to really just do

	result=$(git-fetch-pack "$repo" "$head") || exit

   which will fetch the named "head" from the named "repo", and stuff the 
   result in the "result" variable. You can then stuff that result 
   anywhere, so for example, if you pull _my_ repostiry, you could then 
   name the result "linus-tree" by just doing

	echo $result > .git/refs/heads/linus-tree

   and it really is that easy.

   So just do this for all the repos you want to pull, so that you have 
   <n> heads in the same tree, names however you wish (it the head naming
   _you_ have in your tree do not necessarily have anything at all to do 
   with the head naming in the heads in the trees the data came from. In
   fact, that's very important, because there can be multiple HEAD or
   "master" source branches, of course, and you need to make _your_ heads
   be unique).

 - second phase is to select some kind of order for these things, and just 
   start merging. Start off with a known base, and for each tree you merge 
   it against the previous merge, and then just generate the diff against 
   the previous merge.

   Now, one downside is that the current "git resolve" will _always_ 
   resolve into HEAD, which is admittedly a bit of a bummer: you can't 
   resolve into a totally temporary tree, which is what your usage might 
   want.

   This might be something git could do better for you, but the upside is
   that "git resolve" will always leave the previous tree in ORIG_HEAD,
   and since you really need to generate a temporary branch for all your
   merges anyway, you might as well just do exactly that, and switch to it
   before you start the merge process.

   Anyway, this example script will jusy always create a temporary branch
   called "merge-branch" that starts at whatever point you use as your
   base. Not a biggie. You can choose whatever as your starting point, I'm 
   just assuming that it's the "master" branch, and that you'd keep (for 
   example) my last release in there as the base.

   But if you want to keep the result of your quilt stuff, that should be 
   doable too, for example. I'm _assuming_ that you'd do the git merge 
   diffs first, and then do the quilt stuff on top of the result, but 
   there's nothing really that forces that order.

   So it should literally be as simple as something like this:

	#
	# Start off from "master", create a new branch "merge-branch"
	# off that state.
	#
	git checkout -f master
	git-rev-parse master > .git/refs/heads/merge-branch

	#
	# Switch to it, always leaving "master" untouched
	#
	git checkout -f merge-branch

	#
	#
	# For each tree you want to merge, just do so..
	#
	# This also decides the order of the patches
	#
	for i in linus-tree davem-net-tree davem-sparc-tree ...
	do
		git resolve HEAD $i "Merging $i"
		if [ "$?" -ne 0 ]; then
			echo "Automatic resolve failed, skipping $i" >&2

			#
			# Revert back to previous state, we're not going
			# to do any manual fixups here.
			#
			git checkout -f
		else
			#
			# Yay! The resolve worked, let's just diff what
			# it did and continue onward from here
			#
			git diff ORIG_HEAD.. > merge-diff-$i
		fi
	done

	#
	# Finally, just switch back to "master", throw away all the work
	# we did (the objects will stay around, but you can do a
	#
	#	git prune
	#
	# once a week to get rid of the temporary objects. Don't do it
	# here, it's too expensive and there's no real point).
	#
	git checkout -f master
	rm .git/refs/heads/merge-branch

and you're hopefully done. It really _should_ be that easy.

The above will leave you with a series of diffs called

	merge-diff-linus-tree
	merge-diff-davem-net-tree
	merge-diff-davem-sparc-tree
	...

which are all relative to each other (ie order very much matters, and 
comes directly from the order you did the merging in).

NOTE NOTE NOTE! I wrote the above in this email client, I've not tested it 
at all. It _looks_ straightforward enough, but hey, maybe I'm a retard.

And btw, this should all be quite efficient. It really shouldn't take many 
seconds per tree. The most expensive op _should_ be downloading the 
changes, and the fact that "git resolve" will always do a "diffstat" of 
the result..

		Linus
