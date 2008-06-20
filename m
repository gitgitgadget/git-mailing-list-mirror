From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 3/3] Make rebase--interactive use OPTIONS_SPEC
Date: Fri, 20 Jun 2008 04:45:35 +0200
Message-ID: <1213929935-15093-4-git-send-email-s-beyer@gmx.net>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net>
 <1213929935-15093-2-git-send-email-s-beyer@gmx.net>
 <1213929935-15093-3-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 04:46:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9WeM-0006EA-Hg
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 04:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbYFTCpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 22:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbYFTCpr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 22:45:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:38421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751962AbYFTCpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 22:45:41 -0400
Received: (qmail invoked by alias); 20 Jun 2008 02:45:39 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp061) with SMTP; 20 Jun 2008 04:45:39 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19rIqFNDl5r0tmJSno5WzBxfx7CEQpTBFdrXUSZXh
	WfbnE0Hg9SN80u
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9Wd5-0003x4-Iv; Fri, 20 Jun 2008 04:45:35 +0200
X-Mailer: git-send-email 1.5.5.1.561.gd8556
In-Reply-To: <1213929935-15093-3-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85589>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-rebase--interactive.sh |   58 ++++++++++++++++++++++++++-----------------
 1 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e8ac2ae..aeb9628 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -10,10 +10,25 @@
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
 
-USAGE='(--continue | --abort | --skip | [--preserve-merges] [--first-parent]
-	[--preserve-tags] [--verbose] [--onto <branch>] <upstream> [<branch>])'
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC='
+git-rebase -i [options] <upstream> [<branch>]
+git-rebase (--continue | --abort | --skip)
+--
+continue           Continue rebasing process
+abort              Abort rebasing process and restore original branch
+skip               Skip current patch and continue rebasing process
+p,preserve-merges  Try to recreate merges instead of ignoring
+t,preserve-tags    Update tags to the new commit object
+m,merge            Used anyways (no-op)
+i,interactive      Used anyways (no-op)
+onto=              Rebase onto given branch instead of upstream
+v,verbose          Display a diffstat of what changed upstream
+ When preserving merges:
+f,first-parent     Show only commits following the first parent of each commit
+s,strategy=        Use the given merge strategy
+'
 
-OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
 
@@ -25,6 +40,7 @@ SQUASH_MSG="$DOTEST"/message-squash
 PRESERVE_MERGES=
 STRATEGY=
 VERBOSE=
+ONTO=
 MARK_PREFIX='refs/rebase-marks'
 test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 test -f "$DOTEST"/verbose && VERBOSE=t
@@ -584,7 +600,7 @@ do
 
 		output git reset --hard && do_rest
 		;;
-	-s|--strategy)
+	-s)
 		case "$#,$1" in
 		*,*=*)
 			STRATEGY="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
@@ -595,32 +611,36 @@ do
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
 
@@ -629,15 +649,6 @@ do
 
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
@@ -720,6 +731,7 @@ EOF
 			die_abort "Nothing to do"
 
 		output git checkout $ONTO && do_rest
+		exit 0
 		;;
 	esac
 	shift
-- 
1.5.5.1.561.gd8556
