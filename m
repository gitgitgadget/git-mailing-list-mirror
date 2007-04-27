From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] A utility to perform merges between Subversion branches using git
Date: Thu, 26 Apr 2007 21:30:31 -0700
Message-ID: <7vy7kephg8.fsf@assigned-by-dhcp.cox.net>
References: <20070427005528.GA12688@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 06:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhI6O-00043l-GF
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 06:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbXD0Eae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 00:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbXD0Ead
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 00:30:33 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43237 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbXD0Eac (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 00:30:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427043032.MOJJ1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Apr 2007 00:30:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id s4WX1W00S1kojtg0000000; Fri, 27 Apr 2007 00:30:32 -0400
In-Reply-To: <20070427005528.GA12688@midwinter.com> (Steven Grimm's message of
	"Thu, 26 Apr 2007 17:55:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45683>

Steven Grimm <koreth@midwinter.com> writes:

> diff --git a/contrib/svn/git-svnmerge b/contrib/svn/git-svnmerge
> new file mode 100755
> index 0000000..e7ed45d
> --- /dev/null
> +++ b/contrib/svn/git-svnmerge
> @@ -0,0 +1,139 @@
> +#!/bin/sh
> +#
> +# Handles svn merges using git-svn.
> +#
> +# Usage: git-svnmerge [-m commit-message] other-branch-name
> +#
> +# This script pulls the changes from another svn branch into the current branch
> +# and checks the result into svn. Then it updates the grafts file so that the
> +# merge is known to git. That means that subsequent runs of the script will
> +# automatically know which changes to apply.
> +#
> +# The user is assumed to have already updated the repository using git-svn.
> +#
> +# Exit codes:
> +#   0 Merge successfully committed to svn.
> +#   1 Merge has conflicts that need to be resolved.
> +#   2 Encountered an error.
> +#
> +# Author: Steven Grimm <koreth@midwinter.com>
> +#

This is contrib stuff, so I'll limit the comments mostly to style.

> +
> +die() {
> +	echo "$@" 1>&2

Many of our scripts do redirection at the beginning, like:

	echo >&2 ...

Also omitting 1 when redirecting to stderr is an idiom.

> +	exit 2
> +}

Does exit value 2 have any significance, or just any non-zero
value would do?

> +
> +store_status() {
> +	echo $Status $OldHead $RevToMerge $CommitMessage > "$StatusFile"
> +}

We do not seem to do CamelCase on shell variable names.  This is
minor, as it is mostly taste.

> +
> +while test $# -gt 1; do

        while <<command>>
        do

without semicolon.

> +	case "$1" in
> +		-m)

Align case arms with "case/esac", just like you would do
"switch" and "case" in C.

> +		*)
> +			die "Unknown argument $1"
> +	esac

... and do not omit ';;' just like you do not omit "break" in
the last case arm in switch in C.

> +done
> +
> +if test $# -lt 1; then

	if <<command>>
        then

without semicolon.

> +	die "Usage: $0 [-m commit-message] other-branch-name"
> +fi
> +
> +GitDir="`git rev-parse --git-dir`"

GIT_DIR?

> +if test -z "$GitDir"; then
> +	die "Not a git repository."
> +fi
> +StatusFile="$GitDir/svnmerge-status"
> +
> +# We might be resuming a previous run, so get the old state if any.
> +Status="start"
> +if test -f "$StatusFile"; then
> +	read Status OldHead RevToMerge CommitMessage < "$StatusFile"
> +fi
> +
> +if test "$Status" = "start"; then
> +	# Make sure there aren't uncommitted (to svn) changes here.
> +	if test -n "`git svn dcommit -n`"; then
> +		die "Can't merge to dirty branch"
> +	fi
> +
> +	# Record the revisions we're merging. We'll use them in the
> +	# grafts file later.
> +	OldHead="`git rev-list --max-count=1 HEAD`"

OldHead=`git rev-parse --verify HEAD`

> +	RevToMerge="`git rev-list --max-count=1 $1`"
> +	if test -z "$RevToMerge"; then
> +		die "Can't merge nonexistent branch."
> +	fi

Wouldn't it possible that $1 might have $IFS in it here, would
it?

	RevToMerge=`git rev-parse --verify "$1"`

If you are expecting "$1" to be only an existing branch, not
just an arbitrary rev, you might want to be more strict by
saying:

	RevToMerge=`git show-ref -s refs/heads/"$1"` ||
        die "Can't merge nonexistent branch."

> +
> +	# Do the actual merge.
> +	git merge --squash "$RevToMerge" || \
> +		MergeFailed=1
> +
> +	# Did we actually merge anything?
> +	if git status > /dev/null; then
> +		:
> +	else
> +		echo "No changes to merge. Have you fetched from svn?"
> +		exit 0
> +	fi
> +
> +	Status=merged
> +	store_status
> +
> +	# If there are conflicts, bail out.
> +	if test -n "$MergeFailed`git ls-files -u`"; then
> +		echo "Please resolve conflicts and run again to continue."
> +		exit 1
> +	fi
> +fi
> +
> +if test "$Status" = "merged"; then
> +	if test -n "`git ls-files -u`"; then
> +		echo "There are still conflicts; can't continue."
> +		exit 1
> +	fi
> +
> +	SvnRevision="`git log --pretty=format:%b -n 1 $RevToMerge | \
> +			egrep '^git-svn-id:' | \
> +			sed 's:.*/\([^/]*\)@\([0-9]*\) [0-9a-f].*:\1 revision \2:'`"

Piping grep to sed often makes your script look amateurish.
How about...

        script='s|^git-svn-id:.*/\([^/]*\)@\([0-9]*\) [0-9a-f].*|\1 revision \2|p'
        git show -s --pretty=format:%b $RevToMerge |
        sed -n -e "$script"

> +	echo "$SvnRevision merged. Committing."
> +
> +	if test -z "$CommitMessage"; then
> +		CommitMessage="Merge from $SvnRevision"
> +	fi
> +
> +	git commit -m "$CommitMessage" || \
> +		die "Commit failed"
> +
> +	Status=committed
> +	store_status
> +fi
> +
> +# Since git-svn dcommit can fail for reasons having nothing to do with the
> +# local repository (e.g. the svn server is down), we allow the user to retry
> +# the dcommit by running this command again.
> +if test "$Status" = "committed"; then
> +	git svn dcommit || \
> +		die "Can't commit to Subversion"
> +
> +	# dcommit will update our current HEAD to point to the newly committed
> +	# svn revision. Update grafts file to tell git that it's a merge.
> +	NewRevision="`git rev-list --max-count=1 HEAD`"
> +	echo "$NewRevision $OldHead $RevToMerge" >> $GitDir/info/grafts

This graft look very yucky, and would not scale.

Presumably, the tree in HEAD commit before dcommit match the one
in NewRevision, right?  I wonder if there is a way to convince
"git-svn" after dcommit that the commit you made yourself above
is where it should stay.

> +
> +	rm "$StatusFile"
> +	echo "Successfully merged $SvnRevision."
> +
> +	Status=""
> +fi
> +
> +if test -n "$Status"; then
> +	die "Unknown status $Status in status file!"
> +fi
> +
> +exit 0
> -- 
> 1.5.2.rc0.35.gf41c8
