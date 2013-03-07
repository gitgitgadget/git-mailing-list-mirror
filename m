From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: What I want rebase to do
Date: Thu, 7 Mar 2013 17:06:28 -0500
Message-ID: <201303072206.r27M6SAN008424@freeze.ariadne.com>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com>
	<7vtxoqx3s1.fsf@alter.siamese.dyndns.org>
	<87sj4aoo3s.fsf@pctrast.inf.ethz.ch>
	<7vppzex2pq.fsf@alter.siamese.dyndns.org>
	<201303061855.r26ItKtM018797@freeze.ariadne.com> <87r4jra942.fsf@pctrast.inf.ethz.ch>
Cc: gitster@pobox.com, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 07 23:06:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDixm-0007MU-Ek
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 23:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847Ab3CGWGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 17:06:32 -0500
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:49170
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758733Ab3CGWGb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 17:06:31 -0500
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id 8j6P1l02c0cZkys55m6W3c; Thu, 07 Mar 2013 22:06:30 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id 8m6V1l00t1KKtkw3Wm6WzR; Thu, 07 Mar 2013 22:06:30 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r27M6S8B008425;
	Thu, 7 Mar 2013 17:06:28 -0500
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r27M6SAN008424;
	Thu, 7 Mar 2013 17:06:28 -0500
In-reply-to: <87r4jra942.fsf@pctrast.inf.ethz.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1362693990;
	bh=fhieopfzg66d+AH+b5c93hoH0neTuKLE14hXqHcLCVM=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=hGeT/eSlqeLj3zJikro7cyR46ehWGP290uRuy7atJ6lyhq5s5+dqJd3GxnT2QOAcT
	 y3Q8hUT7Oc6UK59ajLQPOPKRHFJH20EAgMMyJQ4KvffZUk69y7DY1lbWOtZLMKRuR6
	 HLOyUlBoMF/8VJXZaVDDULHTXtuq1haXg8fg3xqXLDsm/L3SyGFjjGr8nySSAxKMSe
	 u8ooYt5CIW7w+oX4mgrlsq3poqimQAXsgZSt0bQJZRs9YFduyLOmKGM5E3JHxTaP9R
	 N6MBAKDgtyiEpdypX9P1QUpczf+/bAQY6U6jMSH+cFcX22wZI6Xb0yGDvP1xYQfrQY
	 NZLZ455WjydhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217621>

> From: Thomas Rast <trast@student.ethz.ch>
> 
> worley@alum.mit.edu (Dale R. Worley) writes:
> [...snip...]
> 
> Isn't that just a very long-winded way of restating what Junio said
> earlier:
> 
> > > It was suggested to make it apply the first-parent diff and record
> > > the result, I think.  If that were an acceptable approach (I didn't
> > > think about it through myself, though), that would automatically
> > > cover the evil-merge case as well.

Well, I believe what I said was a fleshed-out way of saying what I
*think* Junio said, but...

> You can fake that with something like
> 
> git rev-list --first-parent --reverse RANGE_TO_REBASE |
> while read rev; do
>     if git rev-parse $rev^2 >/dev/null 2>&1; then
>         git cherry-pick -n -m1 $rev
>         git rev-parse $rev^2 >.git/MERGE_HEAD
>         git commit -C$rev
>     else
>         git cherry-pick $rev
>     fi
> done

This code doesn't do that.  I don't want something that rebases a
single thread of the current branch, I want something that rebases
*all* the commits between the head commit and the merge base.  Which
is what is illustrated in my message.

> [1]  If you don't get the sarcasm: that would amount to reinventing
> large parts of git-rebase.

Yes, that is the point of the exercise.

I've done a proof-of-concept implementation of what I want to see,
calling it git-rebase--merge-safe.  But I'm new here and likely that
is a pretty crude solution.  I suspect that a real implementation
could be done by inserting this logic into the framework of
git-filter-tree.  Following is git-rebase--merge-safe, and the script
I use to test it (and explore rebase problems).

Dale
----------------------------------------------------------------------
git-rebase--merge-safe

#!/bin/bash

. git-sh-setup

prec=4

set -ex

# Ensure the work tree is clean.
require_clean_work_tree "rebase" "Please commit or stash them."

onto_name=$1        
onto=$(git rev-parse --verify "${onto_name}^0") ||
    die "Does not point to a valid commit: $1"

head_name=$( git symbolic-ref HEAD )
orig_head=$(git rev-parse --verify $head_name) ||
    exit 1

echo onto=$onto
echo head_name=$head_name
echo orig_head=$orig_head

# Get the merge base, which is the root of the branch that we are rebasing.
# (For now, ignore the question of whether there is more than one merge base.)
mb=$(git merge-base "$onto" "$orig_head")
echo mb=$mb

# Get the list of commits to rebase, which is everything between $mb and
# $orig_head.
# Note that $mb is not included.
revisions=`git rev-list --reverse --ancestry-path $mb..$orig_head`
echo revisions=$revisions

# Set up the list mapping the commits on the original branch to the commits
# on the branch we are creating.
# Its format is ",old-hash1/new-hash1,old-hash2/new-hash2,...,".
# The initial value maps $mb to $onto.
map=",$mb/$onto,"

# Export these so git commit can see them.
export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE

# Process each commit in forward topological order.
for cmt in $revisions
do
    # Examine the commit to extract information we will need to reconstruct it.
    # First parent of the commit that has a mapping, i.e., is part of the
    # branch (and has thus been rebuilt already.
    first_mapped_parent=
    # The new commit that was made of $first_mapped_parent.
    first_mapped_parent_mapped=
    # List of -p options naming the parent commits, or their new commits if they
    # are in the branch.
    parents=
   # Dissect the old commit's data.
    # Output the commit data into FD 3.
    exec 3< <( git cat-file commit $cmt )

    while read keyword rest <&3
    do
	case $keyword in
	    tree)
		# Ignored
		;;
	    parent)
		# See if the parent is mapped, i.e., is in the
		# original branch.
		if [[ "$map" == *,$rest/* ]]
		then
		    # This parent has been mapped.  Get the new commit.
		    parent_mapped=${map#*,$rest/}
		    parent_mapped=${parent_mapped%%,*}
		    if test -z "$first_mapped_parent"
		    then
			first_mapped_parent=$rest
			first_mapped_parent_mapped=$parent_mapped
		    fi
		else
		    # This parent has not been mapped.
		    parent_mapped=$rest
		fi
		# $parent_mapped is a parent of the new commit.
		parents="$parents -p $parent_mapped"
		;;
	    author)
		# Extract the information about the author.
		GIT_AUTHOR_NAME="${rest%% <*}"
		GIT_AUTHOR_EMAIL="${rest##* <}"
		GIT_AUTHOR_EMAIL="${GIT_AUTHOR_EMAIL%%> *}"
		GIT_AUTHOR_DATE="${rest##*> }"
		;;
	    committer)
		# Ignored:  The new commit will have this use's name
		# as committer.
		;;
	    '')
		# End of fixed fields, remainder is the commit comment.
		# Leave contents of FD 3 queued to be read later by
		# git commit-tree.
		break
		;;
	    *)
		# Ignore all other keywords.
		;;
	esac
    done

    echo GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME"
    echo GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL"
    echo GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE"
    echo parents="$parents"
    echo first_mapped_parent=$first_mapped_parent
    echo first_mapped_parent_mapped=$first_mapped_parent_mapped

    test -n "$first_mapped_parent" || exit 1

    # Do the three-way merge.
    # Empty the tree so git read-tree will merge into it.
    git read-tree --empty
    git read-tree -m --aggressive \
	$first_mapped_parent $cmt $first_mapped_parent_mapped
    git merge-index git-merge-one-file -a

    # Construct the file tree for the new commit.
    tree=$( git write-tree )

    # Create the new commit
    # Note that FD 3 contains the remainder of the commit description
    # from the git cat-file above.
    new_commit=$( git commit-tree $tree $parents <&3 )
    echo new_commit=$new_commit

    # Add the new commit to the map.
    map="$map$cmt/$new_commit,"

done

echo Final commit is $new_commit

# Update the branch pointers.
git update-ref ORIG_HEAD $orig_head
git update-ref $head_name $new_commit

# Go to the new head of the branch.
git checkout ${head_name#refs/heads/}
----------------------------------------------------------------------
script.fixed

set -e

# Create a temporary directory and go into it.
DIR=temp.$$
mkdir $DIR
cd $DIR

# Create a Git repository.
git init

# Create a file containing the lines 1 to 10.
seq 1 10 >file
git add file
git commit -m 'Commit A'

# Start the dev branch at commit A.
git branch dev HEAD

# Add lines 1.5, 2.5, and 3.5 in a series of commits on master.

# This sed command adds a line 1.5 before the line 2.
sed --in-place -e '/^2$/i1.5' file
git commit -a -m 'Commit B'

sed --in-place -e '/^3$/i2.5' file
git commit -a -m 'Commit C'

sed --in-place -e '/^4$/i3.5' file
git commit -a -m 'Commit D'

# Show the commit structure of master.
#git log --graph --oneline master
#git log --graph -p master
echo 'On master:'
cat file

# Go to the dev branch and create commits with a non-trivial merge.
git checkout dev

sed --in-place -e '/^5$/i4.5' file
git commit -a -m 'Commit P'

git branch dev1 HEAD

sed --in-place -e '/^6$/i5.5' file
git commit -a -m 'Commit Q'

git checkout dev1

sed --in-place -e '/^7$/i6.5' file
git commit -a -m 'Commit R'

git checkout dev

# Merge commits Q and R, but add the additional line 7.5 (to simulate
# fixes that were needed to resolve the merge).

git merge --no-commit dev1
sed --in-place -e '/^8$/i7.5' file
git commit -a -m 'Commit S'

sed --in-place -e '/^9$/i8.5' file
git commit -a -m 'Commit T'

# Show the commit structure of dev.
#git log --graph --oneline dev
# *** Note that the diffs do not show the line 7.5 added in commit S.
#git log --graph -p dev
echo 'On dev:'
cat file

# Show the branch structure.
git show-branch --sha1-name
git log --all --oneline --graph

# Rebase the dev branch to the tip of master using our hack script.
git checkout dev
git branch -f rebase dev
git checkout rebase
PATH=/usr/libexec/git-core:$PATH
../git-rebase--merge-safe master

# Show the commit structure.
git log --graph --oneline
# *** Note that the line 7.5 added in commit S isn't carried into the new branch.
git log --graph -p

echo 'After rebasing:'
cat file
----------------------------------------------------------------------
[EOF]
