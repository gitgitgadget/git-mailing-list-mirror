From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] cherry-pick: make -r the default
Date: Thu, 05 Oct 2006 17:56:10 -0700
Message-ID: <7vsli245zp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610051711310.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 03:06:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVe0d-0005Vt-PN
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 02:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWJFA4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 20:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWJFA4M
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 20:56:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:12474 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932517AbWJFA4L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 20:56:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061006005610.KKNR16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 20:56:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WowD1V0051kojtg0000000
	Thu, 05 Oct 2006 20:56:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610051711310.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 5 Oct 2006 17:14:29 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28381>

And introduce -x to expose (possibly) private commit object name
for people who cherry-pick between public branches.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * We discussed about this a few times already and every time I
   end up forgetting.  I noticed the topic on the kernel list a
   few days ago again.

   Thanks for reminding.  Does the rationale and warning for -x
   in the documentation look Ok?

 Documentation/git-cherry-pick.txt |   23 ++++++++++++++++-------
 git-revert.sh                     |   12 +++++++-----
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index bfa950c..875edb6 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -7,7 +7,7 @@ git-cherry-pick - Apply the change intro
 
 SYNOPSIS
 --------
-'git-cherry-pick' [--edit] [-n] [-r] <commit>
+'git-cherry-pick' [--edit] [-n] [-x] <commit>
 
 DESCRIPTION
 -----------
@@ -24,13 +24,22 @@ OPTIONS
 	With this option, `git-cherry-pick` will let you edit the commit
 	message prior committing.
 
--r|--replay::
-	Usually the command appends which commit was
+-x::
+	Cause the command to append which commit was
 	cherry-picked after the original commit message when
-	making a commit.  This option, '--replay', causes it to
-	use the original commit message intact.  This is useful
-	when you are reordering the patches in your private tree
-	before publishing.
+	making a commit.  Do not use this option if you are
+	cherry-picking from your private branch because the
+	information is useless to the recipient.  If on the
+	other hand you are cherry-picking between two publicly
+	visible branches (e.g. backporting a fix to a
+	maintenance branch for an older release from a
+	development branch), adding this information can be
+	useful.
+
+-r|--replay::
+	It used to be that the command defaulted to do `-x`
+	described above, and `-r` was to disable it.  Now the
+	default is not to do `-x` so this option is a no-op.
 
 -n|--no-commit::
 	Usually the command automatically creates a commit with
diff --git a/git-revert.sh b/git-revert.sh
index 2bf35d1..0784f74 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -12,13 +12,13 @@ case "$0" in
 *-cherry-pick* )
 	edit=
 	me=cherry-pick
-	USAGE='[--edit] [-n] [-r] <commit-ish>'  ;;
+	USAGE='[--edit] [-n] [-r] [-x] <commit-ish>'  ;;
 * )
 	die "What are you talking about?" ;;
 esac
 . git-sh-setup
 
-no_commit= replay=
+no_commit= replay=t
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -32,8 +32,10 @@ do
 	--n|--no|--no-|--no-e|--no-ed|--no-edi|--no-edit)
 		edit=
 		;;
-	-r|--r|--re|--rep|--repl|--repla|--replay)
-		replay=t
+	-r)
+		: no-op ;;
+	-x|--i-really-want-to-expose-my-private-commit-object-name)
+		replay=
 		;;
 	-*)
 		usage
@@ -121,7 +123,7 @@ cherry-pick)
 	git-cat-file commit $commit | sed -e '1,/^$/d'
 	case "$replay" in
 	'')
-		echo "(cherry picked from $commit commit)"
+		echo "(cherry picked from commit $commit)"
 		test "$rev" = "$commit" ||
 		echo "(original 'git cherry-pick' arguments: $@)"
 		;;
-- 
1.4.2.3.gae59
