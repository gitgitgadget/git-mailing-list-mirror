From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-checkout-index, flag ordering and --prefix kludgy handling
Date: Mon, 17 Oct 2005 19:27:50 -0700
Message-ID: <7vmzl7tv89.fsf@assigned-by-dhcp.cox.net>
References: <200510162114.27429.blaisorblade@yahoo.it>
	<Pine.LNX.4.64.0510171546580.3369@g5.osdl.org>
	<7v8xwry88u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510171814430.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 04:28:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERhD4-0007ij-It
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 04:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVJRC1x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 22:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVJRC1x
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 22:27:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61675 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932382AbVJRC1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 22:27:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051018022721.SPFW24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Oct 2005 22:27:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10202>

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, I'd really like a "git checkout" that can do the per-file thing, 
> instead of always using the equivalent of git-checkout-index with "-a".
>
> It's actually one of the few places where I still use the raw git 
> commands, doing things like
>
> 	git-checkout-index -u -f filename
>
> and I suspect that a lot of people would prefer that
>
> 	git checkout filename
>
> would just do that. Instead, we error out ("no such branch"). Which 
> isn't even what I want, and almost certainly not what most CVS users want 
> (they're used to checking out individual files).

Yes, it has been on the TODO list for quite some time.

One reason I have not done nor said much about this was because
I've been thinking about making the branch/refname more explicit
on our command line.

Currently, we tell 'git-rev-parse' to tell refnames and other
non-flag parameters apart, which in practice does not result in
much confusion, but I think it is not quite right.

I used to have a local branch, only to fetch updates from
paulus, and naturally the branch was called 'gitk'.  But we have
a file called gitk sitting at the top level of the tree, and
'git diff gitk gitk' was not really working as well as I would
have liked ('git diff heads/gitk gitk' should have worked, but I
do not think it did).  Since then this forced me to rename the
branch to 'paulus' X-<.

On the other hand, if there is no ambiguity, I do not think
forcing people to always spell out '-r' like CVS or SVN do
is not necessary:

        $ git diff -r master^^ -r master ;# two commits
        $ git diff -r v0.99.8		 ;# changes since that tag
	$ git checkout -r master
        $ git checkout -r master $filename

This checkout optionally taking filename is introducing one more
ambiguity, and I was reluctant to do so before deciding what to
do about other commands.

Another thing I was thinking was that this might be better
implemented as a separate command that can revert the working
tree file to an artibtrary tree-ish as well.  So:

	$ git xxxxxx --index file1 file2...

would do your 'git-checkout-index -f -u file1 file2...', while

	$ git xxxxxx file1 file2...

would do an equivalent of:

	git ls-tree HEAD file1 file2... |
        sed -e 's/^\([0-7]*\) [^ ]* /\1 /' |
        git-update-index --index-info
        git-checkout-index -f -u file1 file2...

or even:

	$ git xxxxxx HEAD^^ file1 file2...

would give you back file1 and file2 from two revs back.  Of
course, to avoid ambiguities, the last one will be spelled as 

	$ git xxxxxx -r HEAD^^ file1 file2...

if people find that a separate command is cleaner.

Anyway, in the meantime...

 ------------
[PATCH] checking out individual files from index.

'git checkout filename1 filename2...' can be used to revert the
changes you made to files in the working tree to the version
recorded in the index file.

Signed-off-by: Signed-off-by: Junio C Hamano <junkio@cox.net>

---

diff --git a/git-checkout.sh b/git-checkout.sh
index 2c053a3..6af71a2 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -6,6 +6,7 @@ new=
 force=
 branch=
 newbranch=
+
 while [ "$#" != "0" ]; do
     arg="$1"
     shift
@@ -24,19 +25,28 @@ while [ "$#" != "0" ]; do
 		force=1
 		;;
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
+			if [ "$new" ]; then
+				echo "Multiple revisions?"
+				exit 1
+			fi
+			new="$rev"
+			if [ -f "$GIT_DIR/refs/heads/$arg" ]; then
+				branch="$arg"
+			fi
+		else
+			# check out individual files from index
+			if test "$new" || test "$newbranch"
+			then
+				die "checkout and switch tree?"
+			fi
+			git-checkout-index -f -u "$arg" "$@"
+			exit $?
 		fi
 		;;
     esac

Compilation finished at Mon Oct 17 19:08:29
