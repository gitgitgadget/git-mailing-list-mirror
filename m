From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Make rebase--interactive use OPTIONS_SPEC
Date: Sat, 12 Jul 2008 17:48:20 +0200
Message-ID: <1215877700-17080-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 17:49:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHhLn-0006Vl-HF
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 17:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbYGLPsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 11:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbYGLPsZ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 11:48:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:50187 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753510AbYGLPsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 11:48:24 -0400
Received: (qmail invoked by alias); 12 Jul 2008 15:48:23 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp068) with SMTP; 12 Jul 2008 17:48:23 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+HX9tWEviHy6LOdLR4235MjGBH2a9Vrm5DmbEy1k
	0IEIGJp12s1jiE
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHhKe-0004Rr-Ib; Sat, 12 Jul 2008 17:48:20 +0200
X-Mailer: git-send-email 1.5.6.2.303.g79662
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88250>

Also add some checks that --continue/--abort/--skip
actions are used without --onto, -p, -t, etc.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Yes, I've already sent a similar patch, that was dropped because it
depended on the js/rebase-i-sequencer patches that are dropped.

Now I picked this out of my sequencer patchset because it is general
enough.

 git-rebase--interactive.sh |   77 +++++++++++++++++++++++++++++---------------
 1 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a64d9d5..3d85486 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -10,10 +10,24 @@
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
 
-USAGE='(--continue | --abort | --skip | [--preserve-merges] [--verbose]
-	[--onto <branch>] <upstream> [<branch>])'
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git-rebase [-i] [options] [--] <upstream> [<branch>]
+git-rebase [-i] (--continue | --abort | --skip)
+--
+ Available options are
+v,verbose          display a diffstat of what changed upstream
+onto=              rebase onto given branch instead of upstream
+p,preserve-merges  try to recreate merges instead of ignoring them
+s,strategy=        use the given merge strategy
+m,merge            always used (no-op)
+i,interactive      always used (no-op)
+ Actions:
+continue           continue rebasing process
+abort              abort rebasing process and restore original branch
+skip               skip current patch and continue rebasing process
+"
 
-OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
 
@@ -25,10 +39,8 @@ SQUASH_MSG="$DOTEST"/message-squash
 REWRITTEN="$DOTEST"/rewritten
 PRESERVE_MERGES=
 STRATEGY=
+ONTO=
 VERBOSE=
-test -d "$REWRITTEN" && PRESERVE_MERGES=t
-test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
-test -f "$DOTEST"/verbose && VERBOSE=t
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -366,10 +378,27 @@ do_rest () {
 	done
 }
 
+# check if no other options are set
+is_standalone () {
+	test $# -eq 2 -a "$2" = '--' &&
+	test -z "$ONTO" &&
+	test -z "$PRESERVE_MERGES" &&
+	test -z "$STRATEGY" &&
+	test -z "$VERBOSE"
+}
+
+get_saved_options () {
+	test -d "$REWRITTEN" && PRESERVE_MERGES=t
+	test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
+	test -f "$DOTEST"/verbose && VERBOSE=t
+}
+
 while test $# != 0
 do
 	case "$1" in
 	--continue)
+		is_standalone "$@" || usage
+		get_saved_options
 		comment_for_reflog continue
 
 		test -d "$DOTEST" || die "No interactive rebase running"
@@ -402,6 +431,8 @@ do
 		do_rest
 		;;
 	--abort)
+		is_standalone "$@" || usage
+		get_saved_options
 		comment_for_reflog abort
 
 		git rerere clear
@@ -419,6 +450,8 @@ do
 		exit
 		;;
 	--skip)
+		is_standalone "$@" || usage
+		get_saved_options
 		comment_for_reflog skip
 
 		git rerere clear
@@ -426,7 +459,7 @@ do
 
 		output git reset --hard && do_rest
 		;;
-	-s|--strategy)
+	-s)
 		case "$#,$1" in
 		*,*=*)
 			STRATEGY="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
@@ -437,25 +470,26 @@ do
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
-	-i|--interactive)
+	-i)
 		# yeah, we know
 		;;
-	''|-h)
-		usage
+	--onto)
+		shift
+		ONTO=$(git rev-parse --verify "$1") ||
+			die "Does not point to a valid commit: $1"
 		;;
-	*)
+	--)
+		shift
+		test $# -eq 1 -o $# -eq 2 || usage
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
 
@@ -464,15 +498,6 @@ do
 
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
1.5.6.2.303.g79662
