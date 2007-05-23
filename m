From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add a configuration option to control diffstat after merge
Date: Wed, 23 May 2007 22:02:23 +0200
Message-ID: <20070523200223.GB2554@steel.home>
References: <81b0412b0705230828s7fcdd836gf3bb92000d8ebd79@mail.gmail.com> <7vhcq32yda.fsf@assigned-by-dhcp.cox.net> <20070523195823.GA2554@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 22:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqx2T-0003mj-CJ
	for gcvg-git@gmane.org; Wed, 23 May 2007 22:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbXEWUC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 16:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756173AbXEWUC0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 16:02:26 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:61663 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898AbXEWUCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 16:02:25 -0400
Received: from tigra.home (Fa87d.f.strato-dslnet.de [195.4.168.125])
	by post.webmailer.de (klopstock mo13) (RZmta 6.7)
	with ESMTP id A01b96j4NH4gDf ; Wed, 23 May 2007 22:02:23 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C070A277BD;
	Wed, 23 May 2007 22:02:23 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 9C694D195; Wed, 23 May 2007 22:02:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070523195823.GA2554@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVo8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48169>

The diffstat can be controlled either with command-line options
(--summary|--no-summary) or with merge.diffstat. The default is
left as it was: diffstat is active by default.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I have to explain the implementation a bit: in Windows, every exec is
*very* expensive, so I tried to avoid a call to git-config as long as
possible. The stupid OS is my reason for this change, actually:
diffstat not just takes too long. It also takes a *long* while before
the diffstat even starts!

 Documentation/git-merge.txt     |    2 +-
 Documentation/merge-options.txt |    4 ++++
 git-merge.sh                    |   18 ++++++++++++------
 git-pull.sh                     |    3 +++
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 9c08efa..912ef29 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,7 +9,7 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [verse]
-'git-merge' [-n] [--no-commit] [--squash] [-s <strategy>]...
+'git-merge' [-n] [--summary] [--no-commit] [--squash] [-s <strategy>]...
 	[-m <msg>] <remote> <remote>...
 
 DESCRIPTION
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 182cef5..56f1d8d 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,3 +1,7 @@
+--summary::
+	Show a diffstat at the end of the merge. The diffstat is also
+	controlled by the configuration option merge.diffstat.
+
 -n, \--no-summary::
 	Do not show diffstat at the end of the merge.
 
diff --git a/git-merge.sh b/git-merge.sh
index 351676f..80f7de8 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
+USAGE='[-n] [--summary] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -88,12 +88,11 @@ finish () {
 	'')
 		;;
 	?*)
-		case "$no_summary" in
-		'')
+		if test "$show_diffstat" = t
+		then
 			# We want color (if set), but no pager
 			GIT_PAGER='' git-diff --stat --summary -M "$head" "$1"
-			;;
-		esac
+		fi
 		;;
 	esac
 }
@@ -126,7 +125,9 @@ do
 	case "$1" in
 	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
 		--no-summa|--no-summar|--no-summary)
-		no_summary=t ;;
+		show_diffstat=false ;;
+	--summary)
+		show_diffstat=t ;;
 	--sq|--squ|--squa|--squas|--squash)
 		squash=t no_commit=t ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
@@ -168,6 +169,11 @@ do
 	shift
 done
 
+if test -z "$show_diffstat"; then
+    test "$(git-config merge.diffstat)" = false && show_diffstat=false
+    test -z "$show_diffstat" && show_diffstat=t
+fi
+
 # This could be traditional "merge <msg> HEAD <commit>..."  and the
 # way we can tell it is to see if the second token is HEAD, but some
 # people might have misused the interface and used a committish that
diff --git a/git-pull.sh b/git-pull.sh
index a3665d7..ba0ca07 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -22,6 +22,9 @@ do
 	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
 		--no-summa|--no-summar|--no-summary)
 		no_summary=-n ;;
+	--summary)
+		no_summary=$1
+		;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=--no-commit ;;
 	--sq|--squ|--squa|--squas|--squash)
-- 
1.5.2.36.g04e2-dirty
