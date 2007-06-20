From: Junio C Hamano <gitster@pobox.com>
Subject: Re: post-update script to update wc - suggestions welcome
Date: Wed, 20 Jun 2007 01:52:28 -0700
Message-ID: <7vr6o7uhwz.fsf@assigned-by-dhcp.pobox.com>
References: <E1I0tZY-0001Uz-00@www.watts.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Lederhofer <matled@gmx.net>
To: Sam Vilain <samv@utsl.gen.nz>
X-From: git-owner@vger.kernel.org Wed Jun 20 10:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0vvT-0001rh-V4
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 10:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbXFTIwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 04:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbXFTIwa
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 04:52:30 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48585 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbXFTIw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 04:52:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070620085229.ZIZH3133.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 20 Jun 2007 04:52:29 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DksU1X00C1kojtg0000000; Wed, 20 Jun 2007 04:52:29 -0400
In-Reply-To: <E1I0tZY-0001Uz-00@www.watts.utsl.gen.nz> (Sam Vilain's message
	of "Wed, 20 Jun 2007 18:21:44 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50550>

Sam Vilain <samv@utsl.gen.nz> writes:

> #!/bin/sh
> #
> # An example hook script to prepare a packed repository for use over
> # dumb transports.
> #
> # To enable this hook, make this file executable by "chmod +x post-update".
>
> git-update-server-info
>
> ref=$1
> active=`git-symbolic-ref HEAD`
> if [ "$ref" = "$active" ]

post-update hook takes list of refs that have been updated, so
the above check is bogus, I think.

Better do something like:

	case " $* " in
        *" $active "*)
        	: current branch was updated...
		;;
	*)
        	: do not have to worry about this one
                exit 0
                ;;
	esac
	# ... rest of the code here ...

Also you would want to see if the thing is bare.  

Unfortunately, git-sh-setup's is_bare_repository does a wrong
thing because receive-pack already runs GIT_DIR set to '.' after
chdir to it.  Matthias's long set of patches currently parked in
'pu' is supposed to clarify the semantics of bare/non-bare, so
it may help though (it has "rev-parse --is-bare-repository).

I think 80% of the time (because other 20% of bare repositories
are initialized, following an often repeated incorrect procedure
of making a worktree-full repository and moving its .git/ to
another place, $name.git --- that is wrong for at least three
reasons), if $GIT_DIR/index exists, you can treat it as a
non-bare repository.

So in short, I would follow the above quoted one with:

	test -f "$GIT_DIR/index" || exit 0

to ignore bare repositories.

Matthias, do you know if your patchset correctly handle this
case?  That is:

	$ git push site:my.git set of refs

will:

        (1) spawn git-receive-pack with my.git as its
            argument;

        (2) git-receive-pack finds the repository and chdir()'s
            to the directory that has refs/ and HEAD in it
            (i.e. if my.git is bare, the directory itself, if
            my.git has my.git/.git and possibly a checkout in
            my.git/{Makefile,README,...}, then it chdir()'s to
            my.git/.git);

	(3) then it sets GIT_DIR=. and exports it.

and from that environment, post-update hook is called.

I think Matthias's patch series may need to (conditionally) set
GIT_WORK_TREE environment when it finds the repository and see
if there is an associated work tree at its natural place (that
is, if $something/.git is found in (2) and $something/.git/index
exists, then worktree should be rooted at $something/, unless
core.worktree is set) .

> then
>   echo "Pushing to checked out branch - updating working copy" >&2
>   export GIT_DIR=`cd $GIT_DIR; pwd`

... and Matthias's patch series probably needs to update this
part of your patch as well.

>   cd ..
>   success=
>   if git-diff-files
>   then

I would suggest running update-index --refresh before running
diff-files.  The user may have cache-dirty file and only that.

>     git-diff-index -z -R --name-status HEAD | perl -n0 -le \
> 	'if ($z^=1) {
> 		$status=$_;
> 	 }
> 	 else {
>         	$filename=$_;
> 		printf STDERR "$status\t$filename\n";
> 		if($status eq "D"){
> 			unlink($filename)
> 				or die("unlink($filename) failed; $!")
> 		}
>          }' &&

With "--name-only --diff-filter=D" you would not have to do most
of the above ;-)  Use --diff-filter=A without -R, perhaps, to
make it even shorter.

>     git-reset --hard HEAD && success=1
>   fi

Wouldn't "reset --hard HEAD" pretty much unconditionally nuke
your local changes, including added files to the index?  For
example, if I do this:

	$ >foo && git add foo && git reset --hard HEAD

it would remove the newly added 'foo' from both the index and
the working tree.  So I am not quite sure what you are trying to
achieve with "diff-index | perl" magic.

>   if [ -z "$success" ]
>   then
>     (
>     echo "Non-bare repository checkout is not clean - not updating it"
>     echo "However I AM going to update the index.  Any in-progress commit"
>     echo "happening in that checkout will be thrown away, but on the bright"
>     echo "side this is probably the least confusing thing for us to do and"
>     echo "at least we're not throwing any files somebody has changed away"
>     git-reset --mixed HEAD
>     echo 
>     echo "This is the new status of the upstream working copy:"
>     git-status
>     ) >&2
>   fi
> fi

I'll cook up an alternative patch perhaps tomorrow.
