From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 3/4] git-submodule: New subcommand 'summary' (3) - limit summary size
Date: Mon,  3 Mar 2008 02:15:09 +0800
Message-ID: <1204481710-29791-3-git-send-email-pkufranky@gmail.com>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 19:15:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVsj2-0001jW-SN
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 19:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbYCBSPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 13:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbYCBSPQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 13:15:16 -0500
Received: from mail.qikoo.org ([60.28.205.235]:50500 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752409AbYCBSPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 13:15:13 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 0DABD470AF; Mon,  3 Mar 2008 02:15:10 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75823>

This patch teaches git-submodule an option '--summary-limit|-n <number>'
to limit number of commits in total for the summary. Number 0 will disable
summary and minus number means unlimted (the default).

For beauty and clarification, the fork-point (i.e. the last commits for
both backward and forward sections) will always be shown disregarding the
given limit. So actual summary size may be greater than the given limit.

'git submodule summary -n 2 sm1' and 'git submodule summary -n 3 sm1'
will show the same in the super project mentioned in last patch.

---------------------------------------
 $ git submodule summary -n 2 sm1
 # Submodules modifiled: sm1
 #
 # * sm1 354cd45...3f751e5:
 #   <one line message for C
 #   <one line message for B
 #   >...
 #   >one line message for E
 #
---------------------------------------

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3313d6c..dfd2952 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,7 +4,9 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update|summary [<commit>]] [--] [<path>...]'
+USAGE="[--quiet] [--cached] \
+[add <repo> [-b branch]|status|init|update|summary [-n|--summary-limit <n>] [<commit>]] \
+[--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -329,6 +331,8 @@ set_name_rev () {
 # $@ = [commit (default 'HEAD'),] requested paths (default all)
 #
 cmd_summary() {
+	summary_limit=-1
+
 	# parse $args after "submodule ... summary".
 	while test $# -ne 0
 	do
@@ -336,6 +340,15 @@ cmd_summary() {
 		--cached)
 			cached="$1"
 			;;
+		-n|--summary-limit)
+			if summary_limit=$(($2 + 0)) 2>/dev/null && test "$summary_limit" = "$2"
+			then
+				:
+			else
+				usage
+			fi
+			shift
+			;;
 		--)
 			shift
 			break
@@ -350,6 +363,8 @@ cmd_summary() {
 		shift
 	done
 
+	test $summary_limit = 0 && return
+
 	if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)
 	then
 		head=$rev
@@ -442,8 +457,52 @@ cmd_summary() {
 			# Don't give error msg for modification whose dst is not submodule, i.e. deleted or changed to blob
 			test $mod_dst = 160000 && echo "$errmsg"
 		else
-			test -n "$left" && echo "$left"
-			test -n "$right" && echo "$right"
+			lc0=0
+			rc0=0
+			test -n "$left" && lc0=$(echo "$left" | wc -l)
+			test -n "$right" && rc0=$(echo "$right" | wc -l)
+
+			if test $summary_limit -lt 0
+			then
+				lc=$lc0
+				rc=$rc0
+			elif test $lc0 -lt $summary_limit
+			then
+				lc=$lc0
+				rc=$(($summary_limit-$lc))
+			else
+				lc=$summary_limit
+				rc=1
+			fi
+
+			if test $rc -gt $rc0
+			then
+				rc=$rc0
+			fi
+
+			if test -n "$left"
+			then
+				skip=$(($lc0-$lc))
+				echo "$left" | head -$(($lc-1))
+				case $skip in
+					0) : ;;
+					1) echo "  <..." ;;
+					*) echo "  <... ($skip more)" ;;
+				esac
+				echo "$left" | tail -1
+			fi
+
+			if test -n "$right"
+			then
+				skip=$(($rc0-$rc))
+				echo "$right" | head -$(($rc-1))
+				case $skip in
+					0) : ;;
+					1) echo "  <..." ;;
+					*) echo "  <... ($skip more)" ;;
+				esac
+				echo "$right" | tail -1
+			fi
 		fi
 		echo
 	done | sed -e 's/^/# /'
-- 
1.5.4.3.347.g5314c

