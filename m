From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sun, 24 Jun 2007 11:30:17 +0200
Message-ID: <20070624093017.GC2467@steel.home>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <20070624082906.GB2467@steel.home> <4D530871-0CBE-4F9A-99B7-ECF0F4656D85@zib.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 11:30:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2OQO-0005oE-VU
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 11:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbXFXJaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 05:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbXFXJaV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 05:30:21 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:57616 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935AbXFXJaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 05:30:20 -0400
Received: from tigra.home (Fad95.f.strato-dslnet.de [195.4.173.149])
	by post.webmailer.de (fruni mo21) (RZmta 7.5)
	with ESMTP id 601618j5O6ZUQC ; Sun, 24 Jun 2007 11:30:18 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 21C38277BD;
	Sun, 24 Jun 2007 11:30:18 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 88F7CC164; Sun, 24 Jun 2007 11:30:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4D530871-0CBE-4F9A-99B7-ECF0F4656D85@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFly0M=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50782>

Steffen Prohaska, Sun, Jun 24, 2007 11:05:29 +0200:
> >Steffen Prohaska, Sat, Jun 23, 2007 21:27:57 +0200:
> >>+for commit in $(git-rev-list --reverse $from..$to)
> >>+do
> >>+    echo "rewriting commit $commit..."
> >>+    git-diff-tree -r $commit | grep ^: | cut -b 9-15,57-97,100- |
> >>+    while read mode sha path
> >>+    do
> >>+        echo " $mode $sha $path"
> >>+        git-update-index --add --cacheinfo $mode $sha $path
> >>+    done
> >
> >Why not just read-tree for every commit? It is not like you're
> >modifying the repository in any way, just changing parenthood. That'd
> >solve the problem with deletions.
> >So it should be enough to read-tree the repo state for each and every
> >source commit into the index (and you can just use a temporary index
> >file for that, see GIT_INDEX_FILE). Than just commit the index.
> 
> I am changing the repository.
> 

No, you don't.

> I only modify the index for files that have changes in $commit. Their
> content gets replaced by the content from the commit. I'm leaving
> all other files untouched.

No, you don't modify anything. Ever tried to run git-status after your
script finished? Tried to understand what the output means?

> This creates a new series of commits that starts from the repository
> state of <onto> and has mixed in files only if they are changed in
> the series of commits from..to. These files are just replaced. I'm not
> trying to merge changes but just replace the whole file.
> 
> Opposed to that, read-tree would modify the content of _all_ files.

No, it wouldn't (unless you run git-read-tree -u, and I fail to see
why would you want that). You probably confuse git-read-tree with
git-checkout-index.

> This is exactly what I want to achieve. The content of the files on
> branch 3 is correct for all files that were committed after 2. But
> because 2 is the wrong branching point all the content originating
> from commits between 1 and 2 is wrong. Files committed between
> 2 and 3 have the right content but the branch needs to be attached
> at 1.

This misses merges (see git-rev-list --parents), but does the job for
linear history:

    export GIT_INDEX_FILE="$(git rev-parse --git-dir)/tr.idx"
    parent=$(git rev-parse "$onto")
    git rev-list --reverse "$from..$to" | while read c
    do
	rm -f "$GIT_INDEX_FILE"
	git read-tree $c || break;
	# Authorship information here
	parent=$(git cat-file commit $c | \
	    sed -e '1,/^$/d' | \
	    git commit-tree $(git write-tree) -p "$parent")
	echo "Commit $parent"
    done
