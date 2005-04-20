From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] Possible strategy cleanup for git add/remove/diff etc.
Date: Tue, 19 Apr 2005 17:32:02 -0700
Message-ID: <7vacnumgot.fsf@assigned-by-dhcp.cox.net>
References: <20050419035107.GB5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 02:28:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO34f-0000s0-Dk
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 02:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDTAcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 20:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVDTAcW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 20:32:22 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7893 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261179AbVDTAcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 20:32:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050420003203.FHQW22013.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 19 Apr 2005 20:32:03 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419035107.GB5554@pasky.ji.cz> (Petr Baudis's message of
 "Tue, 19 Apr 2005 05:51:07 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I was reading this comment in gitcommit.sh and started
thinking...

    # We bother with added/removed files here instead of updating
    # the cache at the time of git(add|rm).sh, since we want to
    # have the cache in a consistent state representing the tree
    # as it was the last time we committed. Otherwise, e.g. partial
    # conflicts would be a PITA since added/removed files would
    # be committed along automagically as well.

Let's for a moment forget what git-pasky currently does, which
is not to touch .git/index until the user says "Ok, let's
commit".  I am wondering if that is the root cause of all the
trouble git-pasky needs to go through.  Specifically I think
having to deal with add/remove queue seems to affect not just
commit you have that comment above but also with diffs.

I'd like to start from a different premise and see what happens:

 - What .git/index records is *not* the state as the last
   commit.  It is just an cache Cogito uses to speed up access
   to the user's working tree.  From the user's point of view,
   it does not even exist.

 - The way this hypothetical Cogito uses .git/index is to always
   reflect add and remove but modification may be out of sync.
   It is updated lazily when .git/index must match the working
   tree.  Again, this is invisible to the user.  From the user's
   point of view, there are only two things: the last commit
   represented as .git/HEAD and his own working tree.

I call this hypothetical implementation of Cogito "jit-*" in the
following description.  Also this is just to convey the idea, so
all the error checking (e.g. "what the user gave jit-merge is
not a valid commit id") and sugarcoating (e.g. tags, symbolic
foreign repository names instead of rsync URL etc) are omitted.


* jit-checkout $commit_id

  This is like "cvs co".  Same as what you are doing I suppose.

    committed_tree=$(cat-file commit $commit_id | sed -e 's/^tree //;q')
    read-tree $committed_tree
    checkout-cache -f -a
    echo $commit_id >.git/HEAD

* jit-add files... | jit-remove files...

  Like "cvs add".  Here, .git/index is treated as just a cache
  of the working tree, not the mirror of previous commit.  So
  unlike git-pasky, jit-* touches .git/index here.

    update-cache --add "$@"

    ---

    rm -f "$@" ;# this is debatable...
    update-cache --remove "$@"

* jit-diff [files...]

  Like "cvs diff".  The user wants to see what's different
  between his working tree and the last commit.

    case "$#" in 0) set x $(show-files --cached); shift ;; esac
    update-cache --add --remove "$@" --refresh
    current_tree=$(write-tree)

    committed_tree=$(cat-file commit $commit_id | sed -e 's/^tree //;q')
    diff-tree -r -z $committed_tree $current_tree |
      filter-output-to-limit-to-given-filelist "$@" |
      parse-diff-tree-output-and-show-real-file-diffs

  Unlike git-pasky, jit-* does not keep the state from the last
  commit in .git/index.  Instead, .git/index is meant to cache
  the state of the working tree.  So the first three lines in
  the above updates .git/index lazily from what is in the
  working tree for the part that needs to be diffed.  Then it
  uses helper scripts to filter and parse diff-tree output and
  generates per-file diffs.  Since add and remove are already
  recorded in .git/index, it does not have to special case
  "uncommitted add" and such.

* jit-commit

  Like "cvs commit".

    set x $(show-files --cached); shift
    update-cache --add --remove "$@"

    current_tree=$(write-tree)
    next_commit=$(commmit-tree $current_tree -p $(cat .git/HEAD))
    echo $next_commit >.git/HEAD

  Unlike git-pasky, .git/index already has adds and removes but
  it does not know about local modifications.  So it runs
  update-cache to make it match the working tree first, and then
  does the usual commit thing.  

  The above only allows the whole tree commit.  But allowing
  single file commit is not that hard:

    (
        set x $(show-files --cached); shift
        update-cache --add --remove "$@"
    ) ;# we use subshell to preserve "$@" here...
    current_tree=$(write-tree)

    committed_tree=$(cat-file commit $commit_id | sed -e 's/^tree //;q')
    read-tree $(committed_tree)
    update-cache --add --remove "$@"
    next_commit=$(commmit-tree $current_tree -p $(cat .git/HEAD))
    echo $next_commit >.git/HEAD

    read-tree $current_tree

  The first four lines are to preserve the current tree state.
  Then we rewind the dircache to the last committed state,
  update only the named files to bring it to the state the user
  wanted to commit, and commit.  Once done, we re-read the state
  to match the user's original intention (e.g. adds recorded in
  .git/index previously but not committed in this run is
  preserved).


* jit-merge $commit_id

  LIke "cvs up -j".  I have working tree which is based on some
  commit, and I want to merge somebody else's head $commit_id.
  Stated more exactly: I want to have the result of my changes
  in my working tree, if I started out from the merge between
  the commit I am actually based on and $commit_id.

    # First get my changes and stash away in a safe place.
    jit-diff >,,working-tree-changes-as-patch

    # After the above, we know .git/index matches the working tree, so...
    current_tree=$(write-tree)

    # Usual 3-way Linus merge.
    merge_base=$(merge-base $(cat .git/HEAD) $commit_id)

    base_tree=$(cat-file commit $merge_base | sed -e 's/^tree //;q')
    committed_tree=$(cat-file commit $(cat .git/HEAD) | sed -e 's/^tree //;q')
    his_tree=$(cat-file commit $commit_id | sed -e 's/^tree //;q')

    read-tree -m $base_tree $committed_tree $his_tree
    merge-cache three-way-merge-script -a

    # Now our .git/index has the merge result.  Match working
    # tree to it.
    checkout-cache -f -a

    # Apply our precious changes.
    patch <,,working-tree-changes-as-patch

    # Here we need to detect adds and removes and issue
    # appropriate update-cache --add --remove.

* jit-pull $foreign_repository

  I do not think we need this.  Just rsync but not merge.


It looks quite simple.  I am asking your opinion because I am
sure you have thought about issues involved through, and the
above outline looks simple only because it is missing something
important that you already had to deal with and solved---and the
solution looks convoluted to me only because I am not aware of
the problem you had to solve.

