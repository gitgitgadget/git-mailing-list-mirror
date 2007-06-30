From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks: add post-update hook for updating working copy
Date: Sat, 30 Jun 2007 10:19:34 -0700
Message-ID: <7vejjte4wp.fsf@assigned-by-dhcp.cox.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
	<1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823588-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 30 19:20:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4gc9-0005pE-Kd
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 19:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422AbXF3RTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 13:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbXF3RTr
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 13:19:47 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:54512 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757174AbXF3RTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 13:19:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630171936.JWWZ1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 13:19:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HtKa1X00B1kojtg0000000; Sat, 30 Jun 2007 13:19:34 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51230>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 665f6dc..9f5fbc7 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -20,7 +20,9 @@ necessary to complete the given refs.
>  
>  You can make interesting things happen to a repository
>  every time you push into it, by setting up 'hooks' there.  See
> -documentation for gitlink:git-receive-pack[1].
> +documentation for gitlink:git-receive-pack[1].  One commonly
> +requested feature, updating the working copy of the target
> +repository, must be enabled in this way.

That is more like "could be", not "must be", and it is not the
manpage's job to pass judgement on if a feature is often requested.

> diff --git a/templates/hooks--post-update b/templates/hooks--post-update
> index bcba893..b5d490c 100644
> --- a/templates/hooks--post-update
> +++ b/templates/hooks--post-update
> @@ -1,8 +1,78 @@
>  #!/bin/sh
>  #
> -# An example hook script to prepare a packed repository for use over
> -# dumb transports.
> +# This hook does two things:
>  #
> -# To enable this hook, make this file executable by "chmod +x post-update".
> +#  1. update the "info" files that allow the list of references to be
> +#     queries over dumb transports such as http
> +#
> +#  2. if this repository looks like it is a non-bare repository, and
> +#     the checked-out branch is pushed to, then update the working copy.
> +#     This makes "push" and "pull" symmetric operations, as in darcs and
> +#     bzr.
> +
> +git-update-server-info
> +
> +export GIT_DIR=`cd $GIT_DIR; pwd`
> +[ `expr "$GIT_DIR" : '.*/\.git'` = 0 ] && exit 0

That's convoluted.  If you use 'expr', probably

	expr "$GIT_DIR" : '.*/\.git' >/dev/null || exit 0

but I would probably do without an extra fork, like this:

	case "$GIT_DIR" in */.git) : happy ;; *) exit 0 ;; esac

Also you can exit early if $GIT_DIR/index does not exist.

> +
> +tree_in_revlog() {

revlog?  Since when are we Hg?

> +    ref=$1
> +    tree=$2
> +    found=$(
> +    tail logs/$ref | while read commit rubbish
> +    do
> +        this_tree=`git-rev-parse commit $commit^{tree}`
> +	if [ "$this_tree" = "$tree" ]
> +        then
> +	    echo $commit
> +        fi
> +    done
> +    )
> +    [ -n "$found" ] && true
> +}

I would imagine that "$some_command && true" would always give
the same result as "$some_command" alone.  I'd just write this
as:

	test -n "$found"

if I were you.

> +
> +for ref
> +do
> +active=`git-symbolic-ref HEAD`

 - You do not want to do this inside "for ref" loop as this is
   constant expression.

 - When the HEAD is detached, this will give you an error message,
   and an empty string.  But you do not care about detached HEAD
   case anyway I would imagine.

Perhaps...

	active=$(git symbolic-ref -q HEAD) || exit 0
	for ref
        do
        	...

> +if [ "$ref" = "$active" ]
> +then
> +  echo "Pushing to checked out branch - updating working copy" >&2
> +  success=
> +  if ! (cd ..; git-diff-files) | grep -q .
> +  then

Trying to see if there is any difference from the index, aka

	git diff-files --quiet

?

> +    # save the current index just in case
> +    current_tree=`git-write-tree`

What happens if the user is in the middle of a merge?
write-tree would fail and you should error out.

> +    if tree_in_revlog $ref $current_tree
> +    then

Why should it behave differently depending on whether the index
matches one of the arbitrary (i.e. taken from "tail" default)
number of commits the user happened to be at in the recent past?
If the check were "does it match with the HEAD", there could be
a valid justification but this check does not make any sense to
me.

> +      cd ..
> +      if git-diff-index -R --name-status HEAD >&2 &&
> +         git-diff-index -z --name-only --diff-filter=A HEAD | xargs -0r rm &&
> +         git-reset --hard HEAD

I do not understand the first two lines at all.  Are you trying
to lose working files for the paths that were added to the index
since HEAD?  "git reset --hard HEAD" should take care of that
already.  To test:

	$ >a-new-file
        $ git add a-new-file
        $ git reset --hard HEAD
        $ ls -l a-new-file
	ls: a-new-file: No such file or directory

But more importantly, why is it justified to throw away such
files to begin with?

> +      then
> +         success=1
> +      else
> +        echo "E:unexpected error during update" >&2
> +      fi
> +    else
> +      echo "E:uncommitted, staged changes found" >&2
> +    fi
> +  else
> +    echo "E:unstaged changes found" >&2
> +  fi

I think this part is a good demonstration why pushing into a
live branch should not attempt to update the working tree.  It
sometimes happens, and it sometimes cannot (which is not your
fault at all), but the indication of what happened (or did not
happen) goes to the person who pushed the changes, not to the
person who gets confusing behaviour if the index/worktree
suddenly goes out of sync with respect to the updated HEAD.

The longer I look at this patch, the more inclined I become to
say that the only part that is worth saving is the next hunk.

> -exec git-update-server-info
> +  if [ -z "$success" ]
> +  then
> +    (
> +    echo "Non-bare repository checkout is not clean - not updating it"
> +    echo "However I AM going to update the index.  Any half-staged commit"
> +    echo "in that checkout will be thrown away, but on the bright side"
> +    echo "this is probably the least confusing thing for us to do and at"
> +    echo "least we're not throwing any files somebody has changed away"
> +    git-reset --mixed HEAD
> +    echo
> +    echo "This is the new status of the upstream working copy:"
> +    git-status
> +    ) >&2
> +  fi
> +fi
> +done
> -- 
> 1.5.2.1.1131.g3b90
