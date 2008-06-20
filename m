From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 2/2] Make rebase--interactive use OPTIONS_SPEC
Date: Fri, 20 Jun 2008 20:30:14 +0200
Message-ID: <1213986614-19536-2-git-send-email-s-beyer@gmx.net>
References: <alpine.DEB.1.00.0806201407230.6439@racer>
 <1213986614-19536-1-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 20:31:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9lOP-0004Gb-GX
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 20:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYFTSa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 14:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbYFTSa1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 14:30:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:53018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751281AbYFTSaY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 14:30:24 -0400
Received: (qmail invoked by alias); 20 Jun 2008 18:30:22 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp030) with SMTP; 20 Jun 2008 20:30:22 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/hLhZHtX7hEjn/wrogKvrov7u0IlWNPc15zmc9T5
	xdJ1QwjKrfFwxG
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9lNH-00055V-0G; Fri, 20 Jun 2008 20:30:15 +0200
X-Mailer: git-send-email 1.5.6.167.g86f2
In-Reply-To: <1213986614-19536-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85670>

Also add some checks that --continue/--abort/--skip
actions are used without --onto, -p, -t, etc.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

Dscho wrote:
> You probably need to introduce checks against "git rebase --continue
> --onto blabla", then.

Now the is_standalone function does that.

Regards,
  Stephan

PS: I wondered that nobody moaned that the patch is for pu.

 git-rebase--interactive.sh |   71 +++++++++++++++++++++++++++++--------------
 1 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3f926d8..1894c37 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -10,10 +10,27 @@
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
 
-USAGE='(--continue | --abort | --skip | [--preserve-merges] [--first-parent]
-	[--preserve-tags] [--verbose] [--onto <branch>] <upstream> [<branch>])'
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git-rebase [-i] [options] [--] <upstream> [<branch>]
+git-rebase [-i] (--continue | --abort | --skip)
+--
+ Available options are:
+p,preserve-merges  Try to recreate merges instead of ignoring them
+t,preserve-tags    Update tags to the new commit object
+m,merge            Always used (no-op)
+i,interactive      Always used (no-op)
+onto=              Rebase onto given branch instead of upstream
+v,verbose          Display a diffstat of what changed upstream
+ When preserving merges:
+f,first-parent     Show only commits following the first parent of each commit
+s,strategy=        Use the given merge strategy
+ Actions:
+continue           Continue rebasing process
+abort              Abort rebasing process and restore original branch
+skip               Skip current patch and continue rebasing process
+"
 
-OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
 
@@ -25,6 +42,8 @@ SQUASH_MSG="$DOTEST"/message-squash
 PRESERVE_MERGES=
 STRATEGY=
 VERBOSE=
+ONTO=
+MARK_PREFIX='refs/rebase-marks'
 test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 test -f "$DOTEST"/verbose && VERBOSE=t
 
@@ -515,10 +534,19 @@ create_extended_todo_list () {
 	done
 }
 
+is_standalone () {
+	test $# -eq 2 -a "$2" = '--' &&
+	test -z "$ONTO" &&
+	test -z "$PRESERVE_TAGS" &&
+	test -z "$PRESERVE_MERGES" &&
+	test -z "$FIRST_PARENT"
+}
+
 while test $# != 0
 do
 	case "$1" in
 	--continue)
+		is_standalone "$@" || usage
 		comment_for_reflog continue
 
 		test -d "$DOTEST" || die "No interactive rebase running"
@@ -551,6 +579,7 @@ do
 		do_rest
 		;;
 	--abort)
+		is_standalone "$@" || usage
 		comment_for_reflog abort
 
 		git rerere clear
@@ -568,6 +597,7 @@ do
 		exit
 		;;
 	--skip)
+		is_standalone "$@" || usage
 		comment_for_reflog skip
 
 		git rerere clear
@@ -575,7 +605,7 @@ do
 
 		output git reset --hard && do_rest
 		;;
-	-s|--strategy)
+	-s)
 		case "$#,$1" in
 		*,*=*)
 			STRATEGY="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
@@ -586,32 +616,36 @@ do
 			shift ;;
 		esac
 		;;
-	-m|--merge)
+	-m)
 		# we use merge anyway
 		;;
-	-C*)
-		die "Interactive rebase uses merge, so $1 does not make sense"
-		;;
-	-v|--verbose)
+	-v)
 		VERBOSE=t
 		;;
-	-p|--preserve-merges)
+	-p)
 		PRESERVE_MERGES=t
 		;;
-	-f|--first-parent)
+	-f)
 		FIRST_PARENT=t
 		PRESERVE_MERGES=t
 		;;
-	-t|--preserve-tags)
+	-t)
 		PRESERVE_TAGS=t
 		;;
-	-i|--interactive)
+	-i)
 		# yeah, we know
 		;;
+	--onto)
+		shift
+		ONTO=$(git rev-parse --verify "$1") ||
+			die "Does not point to a valid commit: $1"
+		;;
 	''|-h)
 		usage
 		;;
-	*)
+	--)
+		shift
+		test $# -eq 1 -o $# -eq 2 || usage
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
 
@@ -620,15 +654,6 @@ do
 
 		comment_for_reflog start
 
-		ONTO=
-		case "$1" in
-		--onto)
-			ONTO=$(git rev-parse --verify "$2") ||
-				die "Does not point to a valid commit: $2"
-			shift; shift
-			;;
-		esac
-
 		require_clean_work_tree
 
 		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
-- 
1.5.6.167.g86f2
