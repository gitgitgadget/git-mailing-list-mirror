From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-push hook to update remote working copy safely
Date: Fri, 23 Feb 2007 03:00:09 -0800
Message-ID: <7v649t5ebq.fsf@assigned-by-dhcp.cox.net>
References: <1172220709.10221.1176113191@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sam Watkins" <swatkins@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Feb 23 12:00:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKYA7-0007UO-2j
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 12:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbXBWLAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 06:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbXBWLAL
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 06:00:11 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:44101 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbXBWLAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 06:00:10 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223110011.WFCP2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 06:00:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Sz091W0011kojtg0000000; Fri, 23 Feb 2007 06:00:09 -0500
In-Reply-To: <1172220709.10221.1176113191@webmail.messagingengine.com> (Sam
	Watkins's message of "Fri, 23 Feb 2007 19:51:49 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40438>

"Sam Watkins" <swatkins@fastmail.fm> writes:

> I'm looking for a command that will update the remote working copy after
> a "git push", without damaging any changes that may have been made to
> the working copy.

Define "without damaging".  If there are changes to paths that
are modified by the pushed commit since the current HEAD, what
should your "update the remote working copy" procedure would
do?

 * Abort the push and refuse to update branch head?

 * Run file-level merge and leave the conflicted results on the
   working tree, in the $GIT_DIR/index and leave the pushed
   commit object name in $GIT_DIR/MERGE_HEAD?

I think the latter is just crazy, as you would then have to
think about cases where you already have $GIT_DIR/MERGE_HEAD
when you attempt to push.

Why in the first place does checking out need to perform a
possibly conflicting update?  Unless it is _also_ modified by
something other than push (i.e. some human user modifies it in
the editor, iow active development happening in the repository),
you can assume that when a push tries to update the working
tree, the working tree is clean (i.e. the index matches HEAD and
the working tree files match the index).  And in such a case,
you can set receive.denyNonFastForwards, and push will not even
call the update hook unless it is fast-forward.  And checking
out a fast-forward in a clean working tree should always succeed
without conflicts.  So I am puzzled what you are really trying
to achieve here.

The only thing you need to protect against is simultaneous push,
and I think that can be solved by holding a lock file while your
update hook runs a checkout.

So it might be just the matter of something like this totally
untested script:

	#!/bin/sh
        # Assumes that the repository has its own working tree and
	# $GIT_DIR is "/path/to/repository/.git".  update hook
        # is always called with `pwd` the same as $GIT_DIR.

        GIT_DIR=`pwd`

	cd .. ;# to the top of working tree
        BRANCH="$1"
        OLDREV="$2"
        NEWREV="$3"

	# Do not bother with non branch push.
        case "$BRANCH" in refs/heads/*) ;; *) exit 0 ;; esac

	# Make sure it is a fast-forward, unless totally new.
	if test "0000000000000000000000000000000000000000" = "$OLDREV"
	then
		MB=$(git merge-base "$OLDREV" "$NEWREV") &&
	        test "$OLDREV" = "$NEWREV" || exit 1
	fi

	# Pushing into a non-checked-out branch -- no need to
        # do anything.
        HEAD_BRANCH=`git symbolic-ref HEAD`
        test "z$HEAD_BRANCH" = "z$BRANCH" || exit 0

	# Could we have a lock please?
	lock="$GIT_DIR/push-update.lock"
        lockfile "$lock"
        trap 'rm -f "$lock"' 0

        # Make sure the index, working tree and HEAD all match.
	HEAD=`git rev-parse --verify HEAD` &&
        test "z$HEAD" = "z$OLDREV" &&
        git update-index --refresh &&
        test -z "`git diff-files --name-only`" &&
        test -z "`git diff-index --cached --name-only $HEAD`" ||
	exit 1

	# Update the working tree -- we do not do git-checkout
        # because updating the ref in 'update' hook is a big
        # No-no.  It would screw up the lockless update in
        # receive-pack that happens after update hook returns.
        git read-tree -m -u "$OLDREV" "$NEWREV"
