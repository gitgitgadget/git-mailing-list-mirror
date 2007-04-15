From: Junio C Hamano <junkio@cox.net>
Subject: Reverting the whole index-base series
Date: Sun, 15 Apr 2007 12:56:55 -0700
Message-ID: <7vbqhp4diw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 21:57:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdAqK-0003NH-Qo
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 21:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbXDOT45 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 15:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbXDOT45
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 15:56:57 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41063 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbXDOT44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 15:56:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415195655.HKRD1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 15:56:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nXwv1W00H1kojtg0000000; Sun, 15 Apr 2007 15:56:56 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44508>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That index base thing is definitely *not* ready for merging into master 
> yet!

I have been thinking about the approach using index-base to
guard against somebody else updating the tip of branch you are
currently on (let's call that "gremlin updates (to the HEAD)"
for lack of better wording).  Unlike the earlier cache-tree
based write-tree optimization, it turns out to be an uphill
battle to make it an "opt-in" enhancement [*1*].

This is primarily because updating the branch tip is not tied
closely to writing out a commit, and writing out a commit is not
tied closely to writing out a tree (to be contained in that
commit) out of the index.

If a command creates a commit that has HEAD as a parent, treats
what is in the index as derived from HEAD, and/or modifies the
index and/or HEAD and leaves the index in a state suitable to
create the next commit out of that has the HEAD commit as a
parent, in order to make such a command aware of the index-base
based guard, the rules are:

 (1) You are relying on the index to be actually based on the
     HEAD you are going to record as one of the parents of the
     resulting commit.  Hence, you need to make sure the HEAD
     agrees with the commit the current index is based on.  The
     former can be read with 'rev-parse --verify HEAD', and the
     latter can be read from the BASE extension ('update-index
     --get-base').

     The design goal is not to require everybody to be
     index-base aware.  So if the index does not record BASE,
     the check should succeed, assuming the HEAD has not been
     moved.

 (2) In order to leave the index in a state suitable to create
     the next commit out of that has the updated HEAD commit as
     a parent, you need to tell the next command that performs
     the check (1) which commit the index is based on.  Use
     'update-index --set-base' to record the commit you think
     the index is based on.

     The design goal again is not to require everybody to be
     index-base aware.  Because most basic operations would not
     usually move HEAD when they update index, read_cache()
     followed by write_cache() can just keep the base if one is
     already recorded in the index, but read-tree by default
     invalidates the base, as any command that makes the index
     based on a different commit needs to lose the base by
     default (if the command is updated to be index-base aware,
     instead of losing the base, it would record the right base,
     of course).

Updating HEAD commit without changing the index can be done in
two ways.  Building on top of HEAD (write-tree then commit-tree
then update-ref), or changing the HEAD commit (using
symbolic-ref to switch branches).  I do not think there is a
sane way to make this "opt-in", and that is where recently
triggered problems come from (applymbox problem was noticed by
Linus; I have a small patch for contrib/emacs/git.el, git-gui,
quiltimport, and git-svn).  If we make symbolic-ref and
update-ref invalidate the base recorded in the index by default
to avoid false positives, that would make the feature "opt-in",
but that would defeat the whole point of detecting gremlin
update, which would update the ref using these exact commands.

Which leads me to conclude that the current approach based on
index-base needs to be rethought.  For now, I'll revert the
whole index base series from 'next'; git will remember it if we
need it later ;-).


[Footnote]

*1* Making it an "opt-in" enhancement to optimize write-tree
    using cache-tree was simpler, as there was only one place
    that actually writes out the contents of the index.  When
    the command updates paths with well-defined API implemented
    in read-cache.c, we can incrementally invalidate the
    cache-tree we originally read from the index and write the
    modified cache-tree out to keep write-tree optimized.  When
    keeping track of cache-tree entries and incrementally
    invalidating affected paths is more trouble than its worth,
    on the other hand, we can just invalidate the cache-tree
    upfront.  So the commands that do not want to bother
    spending cycles to keep cache-tree up-to-date can easily be
    prevented from writing out an out-of-sync cache-tree to
    confuse later write-tree.
