From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 1/2] Make rebase--interactive use OPTIONS_SPEC
Date: Tue,  1 Jul 2008 04:39:27 +0200
Message-ID: <1214879968-17944-2-git-send-email-s-beyer@gmx.net>
References: <1214879914-17866-5-git-send-email-s-beyer@gmx.net>
 <1214879968-17944-1-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 04:40:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDVnF-0005Ky-UH
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 04:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683AbYGACjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 22:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756670AbYGACjf
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 22:39:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:43518 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756257AbYGACje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 22:39:34 -0400
Received: (qmail invoked by alias); 01 Jul 2008 02:39:32 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp063) with SMTP; 01 Jul 2008 04:39:32 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19IsTVeE7FIDSYWgxDnbhGU1+tRygTsD+a69/c/am
	EtoWeGCIZEUKL0
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KDVmC-0004ft-Qi; Tue, 01 Jul 2008 04:39:28 +0200
X-Mailer: git-send-email 1.5.6.1.130.ga8860.dirty
In-Reply-To: <1214879968-17944-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86990>

Also add some checks that --continue/--abort/--skip
actions are used without --onto, -p, -t, etc.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-rebase--interactive.sh |   72 ++++++++++++++++++++++++++++---------------
 1 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7e073bb..ad16fa2 100755
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
+ Available options are
+p,preserve-merges  try to recreate merges instead of ignoring them
+t,preserve-tags    update tags to the new commit object
+m,merge            always used (no-op)
+i,interactive      always used (no-op)
+onto=              rebase onto given branch instead of upstream
+v,verbose          display a diffstat of what changed upstream
+ When preserving merges
+f,first-parent     show only commits following the first parent of each commit
+s,strategy=        use the given merge strategy
+ Actions:
+continue           continue rebasing process
+abort              abort rebasing process and restore original branch
+skip               skip current patch and continue rebasing process
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
@@ -586,32 +616,33 @@ do
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
 
@@ -620,15 +651,6 @@ do
 
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
1.5.6.334.gdaf0
