From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 20:41:34 -0600
Organization: Hewlett Packard
Message-ID: <20050825024134.GA31886@hpsvcnb.fc.hp.com>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com> <20050824181004.GA18790@hpsvcnb.fc.hp.com> <Pine.LNX.4.58.0508241148480.3317@g5.osdl.org> <20050824195615.GA693@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241634350.23242@iabervon.org> <20050824204736.GA13194@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241651420.23242@iabervon.org> <7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 04:42:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E87gW-0008K3-Oz
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 04:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVHYCll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 22:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVHYCll
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 22:41:41 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:42635 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932496AbVHYCll (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 22:41:41 -0400
Received: from smtp1.fc.hp.com (smtp1b.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id 7618E10D28;
	Wed, 24 Aug 2005 22:41:40 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id 363E33834A; Thu, 25 Aug 2005 02:41:35 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id EC5E22CE9C; Wed, 24 Aug 2005 20:41:34 -0600 (MDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7738>

Well, both are good ideas.  Both are stack oriented, though.

I see what you mean about adding an undo directory to .git/refs/.  I
will do some tests... (read further)

On Wed, Aug 24, 2005 at 03:48:21PM -0700, Junio C Hamano wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Generally, each subdirectory of refs/ has refs to objects of the same
> > type, and heads/ is commits, but other directories are other things. tags/
> > is all tag objects, and you could have undo/ be trees.
> 
> That's OK from the prune front, but I am not sure what the
> ramifications of this for pulling, pushing, and resolving.
> I would not recommend it without really thinking it through.

So, I've tried cloning, pulling to|from, pushing to|from and resolving
merges in a repository with undo information stored under
.git/refs/undo.  None of these operations seem to notice the existence
of this directory.  I think this is good.

The cloned repository does not end up 'inheriting' the undo directory
(as I would expect) but does end up with any objects reachable from the
undo tree.  However, these objects get pruned on the next 'git prune'.
This, I think, is minor.

Pull seems to ignore the undo directory and, of course, the objects
reachable by the undo trees.  This is what I expected and wanted.

Resolving merges worked as expected.

I think undo trees should be considered local to the repository and this
is the behavior that I observed.  I think this is a positive.

Before reading your message, I polished up the scripts and changed them
so that they store the undo tree and the base tree's hashes in the
.git/refs/undo directory.  Also, git-redo-script can take an optional
argument...the name of the undo to replay.  I guess undo should also
take an optional argument to give the undo tree some symbolic name.

I think this is getting rather solid.  Let me know what you think.

Here is the git-undo-script:

#!/bin/sh

. git-sh-setup-script || die "Not a git archive"

git-update-cache --refresh || exit 1

undodir=$GIT_DIR/refs/undo

undoinfo=$undodir/$(date +%Y.%m.%d.%H.%M.%S)

headtree=$(git-cat-file commit $(cat $GIT_DIR/HEAD) | sed -n 's/^tree //p')
undotree=$(git-write-tree)

if [ $headtree == $undotree ]; then
    echo There are no changes to undo.
else
    mkdir -p $(dirname $undoinfo)
    echo $headtree > $undoinfo.base
    echo $undotree > $undoinfo.undo

    echo Saved current state in $undodir as $(basename $undoinfo)

    git-read-tree -m -u $undotree $headtree
fi

# --- SNIP ---

and here, is the redo script

#!/bin/sh

. git-sh-setup-script || die "Not a git archive"

git-update-cache --refresh || exit 1

usage () {
    echo >&2 "Usage: git-redo-script [undo name]"
    exit 1
}

undodir=$GIT_DIR/refs/undo

# If an 'undo name' was given on the command line then try to use it.
# If not, then automatically pick the most recent undo.
undoinfo=
case "$#" in
0)
    undoinfo=$undodir/$(ls -tr $undodir | sed -n 's/\.undo$//p' | tail -n 1)
    ;;
1)
    if [ -s $undodir/$1 ]; then
        undoinfo=$(echo $undodir/$1 | sed -n "s/\.[^.]*$//p")
    elif [ -s $undodir/$1.undo -a -s $undodir/$1.base ]; then
        undoinfo=$undodir/$1
    else
        usage
    fi
    ;;
*)
    usage
    ;;
esac

# Perform a three-way merge between the base tree, undo tree and current index
if [ ! -s $undoinfo.undo -o ! -s $undoinfo.base ]; then
    echo "No undo information available"
else
    git-read-tree -u -m $(cat $undoinfo.base) $(cat $undoinfo.undo) $(git-write-tree)
    git-merge-cache git-merge-one-file-script -a

    rm -f $undoinfo.*
    test -z "$(ls $undodir)" && rmdir $undodir
fi

# --- SNIP ---

I would be glad to write up documentation and provide a patch.

Cheers,
Carl

> Also note that tags/ is not all tag objects.  I think "git tag"
> by default creates a lightweight tag, not an annotated kind.
> 
> I think you could do either one of two things.  As usual, totally
> untested.  Just thinking aloud.
> 
> (1) A hack.
> 
>      - Have a single "undo-redo" branch, which was forked from
>        somewhere on the "master" branch.
> 
>      - When doing "undo", make a commit that has the current top
>        of undo-redo branch as the first parent and the current
>        HEAD commit as the second parent, using the tree that
>        represents your snapshot, to grow "undo-redo" branch.
> 
>        No, this commit does *not* represent a merge, but I am
>        abusing the capability to record more than one parent
>        commits.
> 
>      - When running "redo", you would want a handy way to name
>        what to redo.  You can say "undo-redo~N" to mean "Nth
>        from the top of undo-redo branch.
> 
>        Your implementation of "redo" can either be (patch way):
> 
>        git-diff-tree -p undo-redo~N^ undo-redo~N | git apply --index
> 
>        or (merge way):
> 
>        git-read-tree -m undo-redo~N^2 undo-redo~N HEAD &&
>        git-merge-cache -o git-merge-one-file-script -a
> 
> (2) Try StGIT.
> 
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
