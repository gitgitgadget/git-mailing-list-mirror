From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH(amend)] introduce GIT_WORK_TREE environment variable
Date: Tue, 10 Apr 2007 18:29:27 -0700
Message-ID: <7vzm5fr954.fsf@assigned-by-dhcp.cox.net>
References: <20070328141505.GA16600@moooo.ath.cx>
	<20070404201313.GB22782@moooo.ath.cx>
	<7vslbfydiv.fsf@assigned-by-dhcp.cox.net>
	<20070406132109.GA5682@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 10:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbReO-0001is-VN
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 03:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbXDKB33 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 21:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965860AbXDKB33
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 21:29:29 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33529 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964792AbXDKB32 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 21:29:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411012929.OYNV1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 21:29:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ldVT1W00b1kojtg0000000; Tue, 10 Apr 2007 21:29:28 -0400
In-Reply-To: <20070406132109.GA5682@moooo.ath.cx> (Matthias Lederhofer's
	message of "Fri, 6 Apr 2007 15:21:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44204>

Matthias Lederhofer <matled@gmx.net> writes:

> With splitting is_bare_repository() it is no longer abused to check
> for a working tree.  This raises the question what 'bare' is actually
> supposed to mean:
> (1) git may do operations on the repository which have strange effects
>     if I'm using the repository with a working tree (e.g. update HEAD
>     during a fetch)
> (2) git may do (1) but also disallows to use the repository with a
> working tree
>
> With (1) it would be ok to let a user work with a repository that has
> core.bare = true if she really wants to (e.g. by setting GIT_WORK_TREE
> explicitly, details to be figured out later).
> With (2) git should disallow the use of a working tree if core.bare = true.

Well, core.bare was designed without any support for something
like GIT_WORK_TREE in mind, so I do not think we should be tied
too much to whatever the current implementation happens to do.

If you are using GIT_WORK_TREE and GIT_DIR to name two
directories that are not connected in the usual way
(i.e. $GIT_DIR != $GIT_WORK_TREE/.git) to work in, I *think*
your intention is "I want to checkout, diff, commit and all the
usual git operations in GIT_WORK_TREE to grow branches in
GIT_DIR".  I do not think core.bare should even be looked at in
this case.

A quick "git grep is_bare" reveals that:

 - "git-branch foo $commit" refuses if the repository is not
   bare and foo is the current branch.  The intention here is if
   we allow it then it makes the HEAD and index+working tree out
   of sync, so this clearly is about "does it have a working
   tree, and is it used with one"?

 - "git gc" runs pack-refs only if the repository is not bare.
   This is to prevent public repositories from getting
   pack-ref-pruned (which would make older dumb clients not to
   be able to fetch from it).  This _is_ about is_bare; it does
   not matter if somebody else happens to use it with a working
   tree.

 - reflog update code in refs.c defaults log_all_ref_updates
   value to true when !is-bare; the intent is if the repository
   is used to actively build history with working tree we would
   want the reflog, otherwise if it is primarily used to track
   other repositories (either pushing into it, or fetching from
   elsewhere) reflog is often clutter.  So this is not about
   bare, but "does it have a working tree?".

 - "git ls-files" refuses if "is-bare" or "is-inside-git-dir" is
   true.  The intention is we want ls-files to be run inside the
   working tree.

 - Any other commands that says NOT_BARE does the same as
   ls-files, and the error message is "must be run in a work
   tree".

> One option to solve this is to make core.bare have three possible
> values, so the user can decide if he wants (1) or (2).
>     core.bare = true: no working tree allowed
>     core.bare = false: don't allow git-fetch to update HEAD etc.
>     core.bare = mixed: allow both
> In the third case is_bare_repository() would be true and
> inside_work_tree() would change depending on cwd and GIT_WORK_TREE
> setting.  This would allow git fetch to update the current branch even
> while inside the working tree.

I am not sure if you even want the "no working tree allowed"
case. Doesn't it directly contradict with the purpose of the
whole GIT_WORK_TREE idea?

I did not look at the Porcelain-ish scripts, but for example in
the case of git-fetch, the reason it does not allow updating the
current branch is the same as "git-branch" above.

So I suspect that most of the existing use of is_bare is just an
implementation detail of "do we have a working tree?", and it
has been a good implementation primarily because we did not even
allow doing something like GIT_WORK_TREE to begin with.  They
need to be adjusted to work well with GIT_WORK_TREE.

>> I think the only thing you care about in your "where is the repo
>> and where is the worktree" codepath are get_git_dir() and
>> is_bare_repository().  As a side effect of calling these
>> functions for your own purpose, you later have to call
>> setup_git_env() again to clean up, which is fine.  I would feel
>> better if there is an assert in setup_git_env that catches the
>> case where it is called for the second time even though the
>> first caller was something other than this repository/worktree
>> discovery code.
>
> You mean for the third time (first: git_get_dir() from git_config(),
> second: setup_gdg, third: someone who should not call setup_git_env)?

I am more worried about a case where

 (1) a program calls some function A (perhaps in environment.c);

 (2) both of us are forgetting right now that A ends up calling
    setup_git_env();

 (3) the result from A is used to make decision by the calling
     program, and...

 (4) then the program calls setup_git_directory().

Currently the damange is limited as A cannot be outside
environment.c because setup_git_env() is static there, but
whatever the program decides in step (3) may need to be rolled
back and recomputed if setup_git_directory() ends up moving
GIT_DIR and friends around.

> You mean something like assert(inside_work_tree >= 0); to check if
> setup_gdg was called yet?  I didn't see such checks in the git source
> yet but I like it, it is better to have an error message pointing at
> the bug instead of strange behaviour which may result in a bug.

Yes, but I would rather have something stroner than assert()
that cannot be compiled away.  An explicit if (...) die("Gaah").
