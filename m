From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix pulling into the same branch.
Date: Thu, 25 Aug 2005 18:29:10 -0700
Message-ID: <7vr7chmqop.fsf_-_@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043B9B85@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 07:16:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8T2a-0005ah-RT
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 03:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVHZB3R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 21:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVHZB3R
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 21:29:17 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:12954 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965039AbVHZB3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 21:29:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826012910.IWCS1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 Aug 2005 21:29:10 -0400
To: git@vger.kernel.org
In-Reply-To: Junio C. Hamano's message of "(unknown date)"
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7787>

Earlier, I said:

    Subject: Re: cache status after git pull
    Date: Thu, 25 Aug 2005 13:26:07 -0700
    Message-ID: <7v4q9dvk4g.fsf@assigned-by-dhcp.cox.net>

    > 1) Updated my "linus" branch:
    >
    >   $ git checkout linus && git pull linus

    The second command, "git pull linus", would internally run "git
    fetch linus".  It depends on how your shorthand "linus" is
    defined, but if it is set to update (either overwrite or
    fast-forward) the "linus" branch head, then your HEAD pointer
    would be updated without updating the index and working tree.
    This is bad because now you are telling git that your working
    tree is based on updated "linus" branch head, and what you
    _could_ commit on top of it is the same thing as what old
    "linus" branch head commit used to have.  That's why "git
    status" output shows the minefield.

    If I keep copies of foreign brahches in $GIT_DIR/refs/heads/
    somewhere, I never checkout those branches in my working tree.
    I always stay in my branches to do my work.  I may "diff"
    against them to see where I am.  Of course I would "resolve"
    with them when I feel I am ready.

    So, assuming that "linus" short-hand is set up to update
    $GIT_DIR/refs/heads/linus with the foreign branch head, the
    above example would have been:

        $ git checkout master && git pull linus
        : examine diffs and be convinced what Linus does is always right.

This "do not pull into the branch you are on" is probably a good
advice as a workaround, but there is no fundamental reason to
forbid it.  Worse, there is no machinery to even warn about the
situation right now.

This patch is to show my current thinking.  Please let me know
what you think.

-jc

------------
When the "git pull" command updates the branch head you are
currently on, before doing anything else, first update your
index file and the working tree contents to that of the new
branch head.  Otherwise, the later resolving steps would think
your index file is attempting to revert the change between the
original head commit and the updated head commit.

It uses two-tree fast-forward form of "read-tree -m -u" to
prevent losing whatever local changes you may have in the
working tree to do this update.  I think this would at least
make things safer (a lot safer), and prevent mistakes.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-pull-script |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

10f624a7743fc1e29277de9875dbd6a882f2d3b3
diff --git a/git-pull-script b/git-pull-script
--- a/git-pull-script
+++ b/git-pull-script
@@ -5,7 +5,25 @@
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
 . git-sh-setup-script || die "Not a git archive"
+
+orig_head=$(cat "$GIT_DIR/HEAD") || die "Pulling into a black hole?"
 git-fetch-script "$@" || exit 1
+
+curr_head=$(cat "$GIT_DIR/HEAD")
+if test "$curr_head" != "$orig_head"
+then
+	# The fetch involved updating the current branch.
+
+	# The working tree and the index file is still based on the
+	# $orig_head commit, but we are merging into $curr_head.
+	# First update the working tree to match $curr_head.
+
+	echo >&2 "Warning: fetch updated the current branch head."
+	echo >&2 "Warning: fast forwarding your working tree."
+	git-read-tree -u -m "$orig_head" "$curr_head" ||
+		die "You need to first update your working tree."
+fi
+
 merge_head=$(sed -e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | tr '\012' ' ')
 merge_name=$(sed -e 's/^[0-9a-f]*	//' "$GIT_DIR"/FETCH_HEAD |
 	 tr '\012' ' ')
