From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-checkout: revert specific paths to either index or a given tree-ish.
Date: Tue, 18 Oct 2005 01:34:58 -0700
Message-ID: <7vu0ffrznx.fsf_-_@assigned-by-dhcp.cox.net>
References: <200510162114.27429.blaisorblade@yahoo.it>
	<Pine.LNX.4.64.0510171546580.3369@g5.osdl.org>
	<7v8xwry88u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510171814430.3369@g5.osdl.org>
	<7vmzl7tv89.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Oct 18 10:37:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERmwN-0004kQ-1w
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 10:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVJRIfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 04:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVJRIfF
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 04:35:05 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:22448 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932412AbVJRIfD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 04:35:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051018083500.TENY9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 04:35:00 -0400
To: git@vger.kernel.org
In-Reply-To: <7vmzl7tv89.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 17 Oct 2005 19:27:50 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10210>

When extra paths arguments are given, git-checkout reverts only those
paths to either the version recorded in the index or the version
recorded in the given tree-ish.

This has been on the TODO list for quite a while.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    Junio C Hamano <junkio@cox.net> writes:

    > Linus Torvalds <torvalds@osdl.org> writes:
    >
    >> Btw, I'd really like a "git checkout" that can do the per-file thing, 
    >> instead of always using the equivalent of git-checkout-index with "-a".
    >>
    >> and I suspect that a lot of people would prefer that
    >>
    >> 	git checkout filename
    >>
    >> would just do that. Instead, we error out ("no such branch"). Which 
    >> isn't even what I want, and almost certainly not what most CVS users want 
    >> (they're used to checking out individual files).

    I've redone this a bit differently since last night's "in
    the meantime..." patch, so that we can pull selected paths
    out of arbitrary tree-ish.

 git-checkout.sh                |   79 ++++++++++++++++++++++++++++++++--------
 Documentation/git-checkout.txt |   42 ++++++++++++++++++++-
 2 files changed, 103 insertions(+), 18 deletions(-)

applies-to: f7e1a8387657c4da9991861ae44347813b67bc46
4aaa702794447d9b281dd22fe532fd61e02434e1
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index f753c14..b7bb1b4 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -7,12 +7,24 @@ git-checkout - Checkout and switch to a 
 
 SYNOPSIS
 --------
-'git-checkout' [-f] [-b <new_branch>] [<branch>]
+'git-checkout' [-f] [-b <new_branch>] [<branch>] [<paths>...]
 
 DESCRIPTION
 -----------
-Updates the index and working tree to reflect the specified branch,
-<branch>. Updates HEAD to be <branch> or, if specified, <new_branch>.
+
+When <paths> are not given, this command switches branches, by
+updating the index and working tree to reflect the specified
+branch, <branch>, and updating HEAD to be <branch> or, if
+specified, <new_branch>.
+
+When <paths> are given, this command does *not* switch
+branches.  It updates the named paths in the working tree from
+the index file (i.e. it runs `git-checkout-index -f -u`).  In
+this case, `-f` and `-b` options are meaningless and giving
+either of them results in an error.  <branch> argument can be
+used to specify a specific tree-ish to update the index for the
+given paths before updating the working tree.
+
 
 OPTIONS
 -------
@@ -29,6 +41,30 @@ OPTIONS
 	Branch to checkout; may be any object ID that resolves to a
 	commit. Defaults to HEAD.
 
+
+EXAMPLE
+-------
+
+The following sequence checks out the `master` branch, reverts
+the `Makefile` to two revisions back, deletes hello.c by
+mistake, and gets it back from the index.
+
+------------
+$ git checkout master
+$ git checkout master~2 Makefile
+$ rm -f hello.c
+$ git checkout hello.c
+------------
+
+If you have an unfortunate branch that is named `hello.c`, the
+last step above would be confused as an instruction to switch to
+that branch.  You should instead write:
+
+------------
+$ git checkout -- hello.c
+------------
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/git-checkout.sh b/git-checkout.sh
index 2c053a3..73652fa 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -23,32 +23,81 @@ while [ "$#" != "0" ]; do
 	"-f")
 		force=1
 		;;
+	--)
+		break
+		;;
 	*)
-		rev=$(git-rev-parse --verify "$arg^0" 2>/dev/null) ||
-			die "I don't know any '$arg'."
-		if [ -z "$rev" ]; then
-			echo "unknown flag $arg"
-			exit 1
-		fi
-		if [ "$new" ]; then
-			echo "Multiple revisions?"
-			exit 1
-		fi
-		new="$rev"
-		if [ -f "$GIT_DIR/refs/heads/$arg" ]; then
-			branch="$arg"
+		if rev=$(git-rev-parse --verify "$arg^0" 2>/dev/null)
+		then
+			if [ -z "$rev" ]; then
+				echo "unknown flag $arg"
+				exit 1
+			fi
+			new="$rev"
+			if [ -f "$GIT_DIR/refs/heads/$arg" ]; then
+				branch="$arg"
+			fi
+		elif rev=$(git-rev-parse --verify "$arg^{tree}" 2>/dev/null)
+		then
+			# checking out selected paths from a tree-ish.
+			new="$rev"
+			branch=
+		else
+			new=
+			branch=
+			set x "$arg" "$@"
+			shift
 		fi
+		break
 		;;
     esac
 done
-[ -z "$new" ] && new=$old
 
+# The behaviour of the command with and without explicit path
+# parameters is quite different.
+#
+# Without paths, we are checking out everything in the work tree,
+# possibly switching branches.  This is the traditional behaviour.
 #
+# With paths, we are _never_ switching branch, but checking out
+# the named paths from either index (when no rev is given),
+# or the named tree-ish (when rev is given).
+
+if test "$#" -ge 1
+then
+	if test '' != "$newbranch$force"
+	then
+		die "updating paths and switching branches or forcing are incompatible."
+	fi
+	if test '' != "$new"
+	then
+		# from a specific tree-ish; note that this is for
+		# rescuing paths and is never meant to remove what
+		# is not in the named tree-ish.
+		git-ls-tree -r "$new" "$@" |
+		sed -ne 's/^\([0-7]*\) blob \(.*\)$/\1 \2/p' |
+		git-update-index --index-info || exit $?
+	fi
+	git-checkout-index -f -u -- "$@"
+	exit $?
+else
+	# Make sure we did not fall back on $arg^{tree} codepath
+	# since we are not checking out from an arbitrary tree-ish,
+	# but switching branches.
+	if test '' != "$new"
+	then
+		git-rev-parse --verify "$new^{commit}" >/dev/null 2>&1 ||
+		die "Cannot switch branch to a non-commit."
+	fi
+fi
+
+[ -z "$new" ] && new=$old
+
 # If we don't have an old branch that we're switching to,
 # and we don't have a new branch name for the target we
 # are switching to, then we'd better just be checking out
 # what we already had
-#
+
 [ -z "$branch$newbranch" ] &&
 	[ "$new" != "$old" ] &&
 	die "git checkout: you need to specify a new branch name"
---
0.99.8.GIT
