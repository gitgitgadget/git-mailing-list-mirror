From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] revert/cherry-pick: two minor fixes
Date: Thu, 17 Aug 2006 21:09:06 -0700
Message-ID: <7vk656elct.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 18 06:09:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDvfV-0002HL-MY
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 06:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWHREJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 00:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWHREJI
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 00:09:08 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:55219 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030356AbWHREJH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 00:09:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818040906.QYED6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 00:09:06 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25621>

Earlier it was noticed that revert has two seemingly overlapping
options, --no-commit and --no-edit.  An ambiguious option,
e.g. "--no", is interpreted as --no-commit.  It was consistent
because the documentation did not advertise the abbreviated
form, --no-edit, anyway, but that did not change the fact that
the case arm to handle --no-edit contained useless choices.

Linus asked to change cherry-pick's default not to record the
original commit object name (i.e. make -r the default).  This
patch introduces a new option, --record-original, for people who
might prefer the command to record it.

Sometime in the near future, we would change the default not to
record the original commit, but not yet.

Update the documentation to match the above change.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-cherry-pick.txt |   18 +++++++++++-------
 git-revert.sh                     |    8 ++++++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index bfa950c..c2a2c27 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -7,7 +7,7 @@ git-cherry-pick - Apply the change intro
 
 SYNOPSIS
 --------
-'git-cherry-pick' [--edit] [-n] [-r] <commit>
+'git-cherry-pick' [--edit] [-n] [--record-original] [-r] <commit>
 
 DESCRIPTION
 -----------
@@ -24,13 +24,17 @@ OPTIONS
 	With this option, `git-cherry-pick` will let you edit the commit
 	message prior committing.
 
--r|--replay::
-	Usually the command appends which commit was
+--record-original::
+	With this option, the command appends which commit was
 	cherry-picked after the original commit message when
-	making a commit.  This option, '--replay', causes it to
-	use the original commit message intact.  This is useful
-	when you are reordering the patches in your private tree
-	before publishing.
+	making a commit.
++
+This behaviour is still the default, and another option, `-r`,
+is used to turn it off.  The plan is to make `-r` the default in
+the near future.
+
+-r|--replay::
+	See `--record-original`.
 
 -n|--no-commit::
 	Usually the command automatically creates a commit with
diff --git a/git-revert.sh b/git-revert.sh
index 2bf35d1..179135b 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -12,7 +12,8 @@ case "$0" in
 *-cherry-pick* )
 	edit=
 	me=cherry-pick
-	USAGE='[--edit] [-n] [-r] <commit-ish>'  ;;
+	replay=
+	USAGE='[--edit] [-n] [--record-original] <commit-ish>'  ;;
 * )
 	die "What are you talking about?" ;;
 esac
@@ -29,12 +30,15 @@ do
 	-e|--e|--ed|--edi|--edit)
 		edit=-e
 		;;
-	--n|--no|--no-|--no-e|--no-ed|--no-edi|--no-edit)
+	--no-e|--no-ed|--no-edi|--no-edit)
 		edit=
 		;;
 	-r|--r|--re|--rep|--repl|--repla|--replay)
 		replay=t
 		;;
+	--record-original)
+		replay=
+		;;
 	-*)
 		usage
 		;;
-- 
1.4.2.gb0ae
