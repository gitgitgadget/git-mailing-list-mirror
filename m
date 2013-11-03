From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH 7/8] rebase: parse options in stuck-long mode
Date: Sun,  3 Nov 2013 16:54:23 +0100
Message-ID: <1383494064-5653-8-git-send-email-boklm@mars-attacks.org>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 16:55:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd011-0007zG-Pj
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 16:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab3KCPy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 10:54:56 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:35798 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab3KCPyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 10:54:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 893C648C2
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 16:55:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id M7k3umyM0MQq; Sun,  3 Nov 2013 16:55:06 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 010B548C9;
	Sun,  3 Nov 2013 16:55:06 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 9831243934; Sun,  3 Nov 2013 16:54:49 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237263>

There is no functionnal change. The reason for this change is to be able
to add a new option taking an optional argument.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 git-rebase.sh | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2f2f8ded5c3f..a6c294b2289b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -5,7 +5,7 @@
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
-OPTIONS_STUCKLONG=
+OPTIONS_STUCKLONG=t
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
@@ -235,21 +235,19 @@ do
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
-	--onto)
-		onto="$2"
-		shift
+	--onto=*)
+		onto="${1#--onto=}"
 		;;
-	-x)
-		cmd="${cmd}exec $2${LF}"
-		shift
+	--exec=*)
+		cmd="${cmd}exec ${1#--exec=}${LF}"
 		;;
-	-i)
+	--interactive)
 		interactive_rebase=explicit
 		;;
-	-k)
+	--keep-empty)
 		keep_empty=yes
 		;;
-	-p)
+	--preserve-merges)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
 		;;
@@ -259,21 +257,19 @@ do
 	--no-autosquash)
 		autosquash=
 		;;
-	-m)
+	--merge)
 		do_merge=t
 		;;
-	-X)
-		shift
-		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$1")"
+	--strategy-option=*)
+		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--${1#--strategy-option=}")"
 		do_merge=t
 		test -z "$strategy" && strategy=recursive
 		;;
-	-s)
-		shift
-		strategy="$1"
+	--strategy=*)
+		strategy="${1#--strategy=}"
 		do_merge=t
 		;;
-	-n)
+	--no-stat)
 		diffstat=
 		;;
 	--stat)
@@ -282,21 +278,20 @@ do
 	--autostash)
 		autostash=true
 		;;
-	-v)
+	--verbose)
 		verbose=t
 		diffstat=t
 		GIT_QUIET=
 		;;
-	-q)
+	--quiet)
 		GIT_QUIET=t
 		git_am_opt="$git_am_opt -q"
 		verbose=
 		diffstat=
 		;;
-	--whitespace)
-		shift
-		git_am_opt="$git_am_opt --whitespace=$1"
-		case "$1" in
+	--whitespace=*)
+		git_am_opt="$git_am_opt --whitespace=${1#--whitespace=}"
+		case "${1#--whitespace=}" in
 		fix|strip)
 			force_rebase=t
 			;;
@@ -309,14 +304,13 @@ do
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
-	-C)
-		shift
-		git_am_opt="$git_am_opt -C$1"
+	-C*)
+		git_am_opt="$git_am_opt $1"
 		;;
 	--root)
 		rebase_root=t
 		;;
-	-f|--no-ff)
+	--force-rebase|--no-ff)
 		force_rebase=t
 		;;
 	--rerere-autoupdate|--no-rerere-autoupdate)
-- 
1.8.4.2
