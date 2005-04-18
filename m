From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 08:23:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504180802060.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
 <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418102332.A21081@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 17:19:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNY1H-0001R0-SM
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 17:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVDRPWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 11:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVDRPWY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 11:22:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:50665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262107AbVDRPVb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 11:21:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3IFLJs4032132
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 08:21:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3IFLIj7017267;
	Mon, 18 Apr 2005 08:21:18 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050418102332.A21081@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Russell King wrote:
> 
> Ok, I just tried pulling your tree into the tree you pulled from, and
> got this:

No, that can't work. The pesky tools are helpful, but they really don't do 
merges worth cr*p right now, excuse my french. 

The _real_ way to pull is to do the (horribly complex) thing I described
by the merge, but noticing that one of the commits you are merging is a
proper subset of the other one, and just updating the head instead of
actually doing a real merge (ie skipping the "read-tree -m" and
"write-tree" phases).

> This was with some random version of git-pasky-0.04.  Unfortunately,
> this version doesn't have the sha1 ID appended, so I couldn't say
> definitively that it's the latest and greatest.  It might be a day
> old.

I'm afraid that until Pasky's tools script this properly, a "pull" really 
ends up being something like this (which _can_ be scripted, never fear):

NOTE NOTE NOTE! This is untested! I'm writing this within the email 
editor, so do _not_ do this on a tree that you care about.

	#!/bin/sh
	#
	# use "$1" or something in a real script, this 
	# just hard-codes it.
	#
	merge_repo=master.kernel.org:/pub/linux/kernel/people/torvalds/linux-2.6.git

	echo "Getting object database"
	rsync -avz --ignore-existing $merge_repo/ .git/

	echo "Getting remote head"
	rsync -avz $merge_repo/HEAD .git/MERGE_HEAD

	head=$(cat .git/HEAD)
	merge_head=$(cat .git/MERGE-HEAD)
	common=$(merge-base $head $merge_head)
	if [ -z "$common" ]; then
		echo "Unable to find common commit between" $merge_head $head
		exit 1
	fi

	# Get the trees associated with those commits
	common_tree=tree=$(cat-file commit $common | sed 's/tree //;q')
	head_tree=tree=$(cat-file commit $head | sed 's/tree //;q')
	merge_tree=tree=$(cat-file commit $merge | sed 's/tree //;q')

	if [ "$common" == "$merge_head" ]; then
		echo "Already up-to-date. Yeeah!"
		exit 0
	fi
	if [ "$common" == "$head" ]; then
		echo "Updating from $head to $merge_head."
		echo "Destroying all noncommitted data!"
		echo "Kill me within 3 seconds.."
		sleep 3
		read-tree $merge_tree && checkout-cache -f -a
		echo $merge_head > .git/HEAD
		exit 0
	fi
	echo "Trying to merge $merge_head into $head"
	read-tree -m $common_tree $head_tree $merge_tree
	result_tree=$(write-tree) || exit 1
	result_commit=$(echo "Merge $merge_repo" | commit-tree $result_tree -p $head -p $merge_head)
	echo "Committed merge $result_commit"
	echo $result_commit > .git/HEAD
	read-tree $result_tree && checkout-cache -f -a

The above looks like it might work, but I also warn you: it's not only
untested, but it's pretty fragile in that if something breaks, you are
probably left with a mess. I _tried_ to do the right thing, but... So it
obviously will need testing, tweaking and just general tender loving care.

And if the merge isn't clean, it will exit early thanks to the

	write-tree || exit 1

and now you have to resolve the merge yourself. There are tools to help
you do so automatically, but that's really a separate script.

You shouldn't hit the "merge" case at all right now, you should hit the 
"Updating from $head to $merge_head" thing.

If Pesky wants to take the above script, test it, and see if it works,
that would be good. It's definitely a much better "pull" than trying to
apply the patches forward..

		Linus
