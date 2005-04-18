From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 22:53:57 +0100
Message-ID: <20050418225356.B16789@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418102332.A21081@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504180802060.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:52:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNe8B-00052o-KT
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 23:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVDRVyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 17:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDRVyK
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 17:54:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63243 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261169AbVDRVyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 17:54:01 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNeBq-00015Z-FZ; Mon, 18 Apr 2005 22:53:59 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNeBp-0005Um-7g; Mon, 18 Apr 2005 22:53:57 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504180802060.7211@ppc970.osdl.org>; from torvalds@osdl.org on Mon, Apr 18, 2005 at 08:23:16AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 08:23:16AM -0700, Linus Torvalds wrote:
> NOTE NOTE NOTE! This is untested! I'm writing this within the email 
> editor, so do _not_ do this on a tree that you care about.

It did the right thing for me at least!

> 	#!/bin/sh
> 	#
> 	# use "$1" or something in a real script, this 
> 	# just hard-codes it.
> 	#
> 	merge_repo=master.kernel.org:/pub/linux/kernel/people/torvalds/linux-2.6.git
> 
> 	echo "Getting object database"
> 	rsync -avz --ignore-existing $merge_repo/ .git/
> 
> 	echo "Getting remote head"
> 	rsync -avz $merge_repo/HEAD .git/MERGE_HEAD
> 
> 	head=$(cat .git/HEAD)
> 	merge_head=$(cat .git/MERGE-HEAD)
> 	common=$(merge-base $head $merge_head)
> 	if [ -z "$common" ]; then
> 		echo "Unable to find common commit between" $merge_head $head
> 		exit 1
> 	fi
> 
> 	# Get the trees associated with those commits
> 	common_tree=tree=$(cat-file commit $common | sed 's/tree //;q')
> 	head_tree=tree=$(cat-file commit $head | sed 's/tree //;q')
> 	merge_tree=tree=$(cat-file commit $merge | sed 's/tree //;q')

This wants to be:

	common_tree=$(cat-file commit $common | sed 's/tree //;q')
	head_tree=$(cat-file commit $head | sed 's/tree //;q')
	merge_tree=$(cat-file commit $merge_head | sed 's/tree //;q')

> 	if [ "$common" == "$merge_head" ]; then
> 		echo "Already up-to-date. Yeeah!"
> 		exit 0
> 	fi
> 	if [ "$common" == "$head" ]; then
> 		echo "Updating from $head to $merge_head."
> 		echo "Destroying all noncommitted data!"
> 		echo "Kill me within 3 seconds.."
> 		sleep 3
> 		read-tree $merge_tree && checkout-cache -f -a

Don't we want to do an update-cache --refresh here?

> 		echo $merge_head > .git/HEAD
> 		exit 0
> 	fi
> 	echo "Trying to merge $merge_head into $head"
> 	read-tree -m $common_tree $head_tree $merge_tree
> 	result_tree=$(write-tree) || exit 1
> 	result_commit=$(echo "Merge $merge_repo" | commit-tree $result_tree -p $head -p $merge_head)
> 	echo "Committed merge $result_commit"
> 	echo $result_commit > .git/HEAD
> 	read-tree $result_tree && checkout-cache -f -a
> 
> The above looks like it might work, but I also warn you: it's not only
> untested, but it's pretty fragile in that if something breaks, you are
> probably left with a mess. I _tried_ to do the right thing, but... So it
> obviously will need testing, tweaking and just general tender loving care.

Maybe Petr can improve the error handling, and incorporate it (or at
least some of it) into git-pasky

> You shouldn't hit the "merge" case at all right now, you should hit the 
> "Updating from $head to $merge_head" thing.

Exactly what happened.  Thanks.

-- 
Russell King

