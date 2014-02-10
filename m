From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 7/9] rebase: parse options in stuck-long mode
Date: Mon, 10 Feb 2014 01:03:36 +0000
Message-ID: <1391994218-639101-8-git-send-email-sandals@crustytoothpaste.net>
References: <1391994218-639101-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 10 02:04:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCfII-0001O6-UR
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 02:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbaBJBEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 20:04:04 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51748 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153AbaBJBDq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Feb 2014 20:03:46 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EE26428088;
	Mon, 10 Feb 2014 01:03:45 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.rc3.1008.gd08b47c.dirty
In-Reply-To: <1391994218-639101-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241894>

From: Nicolas Vigier <boklm@mars-attacks.org>

There is no functionnal change. The reason for this change is to be able
to add a new option taking an optional argument.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-rebase.sh | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 3b55211..842d7d4 100755
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
@@ -237,21 +237,19 @@ do
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
@@ -267,21 +265,19 @@ do
 	--no-fork-point)
 		fork_point=
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
@@ -290,21 +286,20 @@ do
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
@@ -317,14 +312,13 @@ do
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
1.9.0.rc3.1008.gd08b47c.dirty
