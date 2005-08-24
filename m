From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 12:10:04 -0600
Organization: Hewlett Packard
Message-ID: <20050824181004.GA18790@hpsvcnb.fc.hp.com>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 20:12:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7zhc-0001AL-8n
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 20:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVHXSKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 14:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVHXSKG
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 14:10:06 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:63174 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751340AbVHXSKF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 14:10:05 -0400
Received: from smtp1.fc.hp.com (smtp1b.fc.hp.com [15.15.136.127])
	by atlrel8.hp.com (Postfix) with ESMTP id D01131DD6
	for <git@vger.kernel.org>; Wed, 24 Aug 2005 14:10:04 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 9CDC538412
	for <git@vger.kernel.org>; Wed, 24 Aug 2005 18:10:04 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 8C7FA2CE96; Wed, 24 Aug 2005 12:10:04 -0600 (MDT)
To: Carl Baldwin <cnb@fc.hp.com>
Content-Disposition: inline
In-Reply-To: <20050824172339.GA7083@hpsvcnb.fc.hp.com>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7714>

Oops.  I forgot to actually exit from the script if git-diff-files is
non-empty.

Also, looking at it now, I don't think keeping undo information in a
stack is the right thing.  But keeping more than just one would be good.
Oh well, my first shot is never perfect.  ;-)

Carl

On Wed, Aug 24, 2005 at 11:23:39AM -0600, Carl Baldwin wrote:
> Hello,
> 
> So, one thing that I liked about GNU Arch when I tried it out was the
> ability to undo and redo changes in the local working copy.  I decided
> to try to do this with git.  What I have is preliminary.  I'm sure it
> could use some work.
> 
> So, I started with the assumption that all changes in the working copy
> have been updated to the cache.  My scripts check this (with
> git-diff-files) and abort if this is not the case.
> 
> Undo calls git-write-tree to write the changes to the object store.  It
> stores that tree's hash and the current HEAD's tree's hash in a file.
> Then it reverts the working copy to HEAD.
> 
> Redo grabs these two trees from the file, does git-write-tree to produce
> a third tree and merges the three using the old HEAD's tree as the base
> of the merge.  This way, new commits can happen and the local copy can
> be modified since the undo and it should still work assuming no
> conflicts emerge.
> 
> Attached are the two scripts.  Comments and criticism are welcome.
> 
> Cheers,
> Carl
> 
> -- 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>  Carl Baldwin                        Systems VLSI Laboratory
>  Hewlett Packard Company
>  MS 88                               work: 970 898-1523
>  3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
>  Fort Collins, CO 80525              home: Carl@ecBaldwin.net
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

> #!/bin/sh
> 
> . git-sh-setup-script || die "Not a git archive"
> 
> if [ -n "$(git-diff-files)" ]; then
>     echo The following files should be updated!
>     echo
>     git-diff-files | awk '{print $6}'
> fi
> 
> undostack=$GIT_DIR/undostack
> 
> if [ ! -s $undostack ]; then
>     echo "No undo information in $undostack"
> else
>     # Read the top of the stack
>     basetree=$(cat $undostack | tail -n 2 | head -n 1)
>     redotree=$(cat $undostack | tail -n 1)
> 
>     # Pop the stack
>     cat $undostack | head -n -2 > $undostack.tmp
>     mv $undostack{.tmp,}
> 
>     currenttree=$(git-write-tree)
> 
>     git-read-tree -u -m $basetree $currenttree $redotree
>     git-merge-cache git-merge-one-file-script -a
> fi

> #!/bin/sh
> 
> . git-sh-setup-script || die "Not a git archive"
> 
> if [ -n "$(git-diff-files)" ]; then
>     echo The following files should be updated!
>     echo
>     git-diff-files | awk '{print $6}'
> fi
> 
> undostack=$GIT_DIR/undostack
> 
> headtree=$(git-cat-file commit $(cat $GIT_DIR/HEAD) | head -n 1 | sed -e 's/tree //')
> undotree=$(git-write-tree)
> 
> if [ $headtree == $undotree ]; then
>     echo There are no changes to undo.
> else
>     {
>        echo $headtree
>        echo $undotree
>     } >> $undostack
> 
>     echo Saved current state as tree $undotree.
>     echo Reverting to HEAD, $headtree...
> 
>     git-checkout-script -f
> fi


-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
