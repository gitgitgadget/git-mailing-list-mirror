From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] rebase: add --signoff option
Date: Sun, 30 Sep 2007 18:15:11 +0200
Message-ID: <11911689111797-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 18:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic1S1-0001Z5-N3
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 18:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340AbXI3QPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 12:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757423AbXI3QPQ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 12:15:16 -0400
Received: from mailer.zib.de ([130.73.108.11]:46011 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757340AbXI3QPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 12:15:13 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8UGFB2H000627
	for <git@vger.kernel.org>; Sun, 30 Sep 2007 18:15:11 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8UGFBOf026530;
	Sun, 30 Sep 2007 18:15:11 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59545>

When preparing a series of commits for upstream you may
need to signoff commits if you forgot to do so earlier.
This patch teaches git-rebase to signoff during rebase
if you pass the option --signoff.

Notes
1) --signoff cannot be used simultaneously with --interactive.
2) --signoff forces a rebase even if current path is a
   descendant of <upstream>.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-rebase.txt |    9 +++++++--
 git-rebase--interactive.sh   |    3 +++
 git-rebase.sh                |   10 ++++++++--
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e8e7579..befe337 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,8 +8,8 @@ git-rebase - Forward-port local commits to the updated upstream head
 SYNOPSIS
 --------
 [verse]
-'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
-	[-C<n>] [ --whitespace=<option>] [-p | --preserve-merges]
+'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge] [-C<n>]
+    [--signoff] [ --whitespace=<option>] [-p | --preserve-merges]
 	[--onto <newbase>] <upstream> [<branch>]
 'git-rebase' --continue | --skip | --abort
 
@@ -201,6 +201,11 @@ OPTIONS
 	is used instead (`git-merge-recursive` when merging a single
 	head, `git-merge-octopus` otherwise).  This implies --merge.
 
+--signoff::
+	Add `Signed-off-by:` line to each commit message, using
+	the committer identity of yourself.
+
+
 -v, \--verbose::
 	Display a diffstat of what changed upstream since the last rebase.
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8568a4f..29cef17 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -395,6 +395,9 @@ do
 	-C*)
 		die "Interactive rebase uses merge, so $1 does not make sense"
 		;;
+	--si|--sig|--sign|--signo|--signof|--signoff)
+		die "Interactive rebase doesn't support simultaneous signoff."
+		;;
 	-v|--verbose)
 		VERBOSE=t
 		;;
diff --git a/git-rebase.sh b/git-rebase.sh
index 1583402..3b06bf4 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -46,6 +46,7 @@ dotest=$GIT_DIR/.dotest-merge
 prec=4
 verbose=
 git_am_opt=
+opt_signoff=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -200,7 +201,7 @@ do
 		;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
-	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
+	-s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
 		case "$#,$1" in
 		*,*=*)
 			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
@@ -221,6 +222,10 @@ do
 	-C*)
 		git_am_opt="$git_am_opt $1"
 		;;
+	--si|--sig|--sign|--signo|--signof|--signoff)
+		git_am_opt="$git_am_opt --signoff"
+		opt_signoff=t
+		;;
 	-*)
 		usage
 		;;
@@ -302,8 +307,9 @@ branch=$(git rev-parse --verify "${branch_name}^0") || exit
 
 # Check if we are already based on $onto with linear history,
 # but this should be done only when upstream and onto are the same.
+# The check must also be skipped if signoff is requested.
 mb=$(git merge-base "$onto" "$branch")
-if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
+if test "$upstream" = "$onto" && test "$mb" = "$onto" && test -z "$opt_signoff" &&
 	# linear history?
 	! git rev-list --parents "$onto".."$branch" | grep " .* " > /dev/null
 then
-- 
1.5.3.3.127.g40d17
