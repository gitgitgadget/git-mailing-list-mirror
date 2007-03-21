From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Wed, 21 Mar 2007 08:37:07 -0700
Message-ID: <7v648u38ws.fsf@assigned-by-dhcp.cox.net>
References: <20070321120643.GI20583@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Mar 21 16:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU2sJ-0001Q6-IW
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 16:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbXCUPhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 11:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbXCUPhP
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 11:37:15 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49614 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406AbXCUPhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 11:37:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321153709.PRQP2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 11:37:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dTd71W00m1kojtg0000000; Wed, 21 Mar 2007 11:37:08 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42798>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Hi!
> I often like to fetch some code from others, review and
> then merge. So:
>
> git fetch <URL>
> git log -p FETCH_HEAD
> git merge FETCH_HEAD
>
> which is all good but gets me this message in commit log:
>
>     Merge commit 'FETCH_HEAD' into master
>
> which is not very informative.
> I can always fix this up with git commit --amend, but
> I'd like to avoid the extra step.
>
> Would the following patch be appropriate?
>
> Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

Would "Hi!" and "Would the following be appropriate?" be part of
the final commit log message?

I often hear from people who seems to like "fetch & merge",
instead of "pull & reset ORIG_HEAD", as a workflow to avoid
undesirable merging.  This might largely be a matter of taste,
but from philosophical point of view, fetch & merge is a sign of
distrust (your default is not to merge, and you merge only when
you choose to), and pull & reset is the opposite (your default
is to merge, and after you inspect you may choose not to merge).
Tool support to encourage the former feels somewhat wrong.

Having said that, since that comes up every now and then, I
suspect it might make sense to have an optional behaviour in
"git pull" that lets you say...

	$ git pull --preview $URL $refspec

which runs the following:

	. git fetch
        . git log -p `sed -e '/	not-for-merge	/d'\
        .	-e 's/	.*//' $GIT_DIR/FETCH_HEAD` \
        .	--not HEAD
	. asks you if you want to conclude this with a merge
	. git merge if told, otherwise abort.

The "git-log" above reads "give me the commits that are
reachable from commits that are scheduled for merge but not in
the current HEAD", i.e. the ones that will get merged.

> diff --git a/git-merge.sh b/git-merge.sh
> index 8759c5a..629611b 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -108,6 +108,10 @@ merge_name () {
>  		git-show-ref -q --verify "refs/heads/$truname" 2>/dev/null
>  	then
>  		echo "$rh		branch '$truname' (early part) of ."
> +	elif test -r "$GIT_DIR/$remote"
> +	then
> +		echo -n "$rh		"
> +		grep -v not-for-merge "$GIT_DIR/$remote"
>  	else
>  		echo "$rh		commit '$remote'"
>  	fi

This 'not-for-merge' grep is only good while merging FETCH_HEAD,
and will not work for any other random stuff in "$GIT_DIR", so
at least it should be more specific, not just checking if it is
the name of a readable file in $GIT_DIR.  Somebody might find
good usecases for doing "git merge ORIG_HEAD" or "git merge
refs/bases/tutorial", for example, and your echo & grep would do
something "interesting".

Every time I added "echo -n" from my sloppiness, somebody sent
in a patch to replace it with "printf".  I think people on non
Linux platforms would hate you for using "echo -n" (I should bug
Tytso about this with git-mergetool).

I am not sure what you meant by echo -n and grep -v.  Other
codepaths in the if-else chain seems to create $rh (the value of
the single commit being merged) followed by two tabs followed by
the message, and each line in $GIT_DIR/FETCH_HEAD is already in
that format, so I suspect your code duplicates the commit object
name twice?

Even when you fetch more than one branch in FETCH_HEAD, using
FETCH_HEAD as an SHA-1 expression always picks up the object
name on the first line (iow "git merge FETCH_HEAD" will not
create an Octopus), so grepping for lines without not-for-merge
marker is not correct either.

You would probably want something like:

		...
	elif test FETCH_HEAD = "$remote" && test -r "$GIT_DIR/FETCH_HEAD"
        then
        	sed -e 's/	not-for-merge	/		/' \
		    -e 1q "$GIT_DIR/FETCH_HEAD"
	else
        	...
