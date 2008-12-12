From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/2] mergetool: Add prompt to continue after failing to merge a file
Date: Fri, 12 Dec 2008 21:48:40 +0000
Message-ID: <1229118521-22923-2-git-send-email-charles@hashpling.org>
References: <1229118521-22923-1-git-send-email-charles@hashpling.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 22:50:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBFu8-00079x-Ob
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 22:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbYLLVtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 16:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753743AbYLLVtD
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 16:49:03 -0500
Received: from ptb-relay02.plus.net ([212.159.14.146]:34030 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbYLLVs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 16:48:59 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1LBFsM-0007cC-6Y; Fri, 12 Dec 2008 21:48:46 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id mBCLmjUa022987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Dec 2008 21:48:45 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id mBCLmja8022986;
	Fri, 12 Dec 2008 21:48:45 GMT
X-Mailer: git-send-email 1.6.1.rc1.342.g83b24d
In-Reply-To: <1229118521-22923-1-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: 2770b63f20a6e143728f823d3bddfd7e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102946>

This option stops git mergetool from aborting at the first failed merge.
After a failed merge the user will be prompted to indicated whether he
wishes to continue with attempting to merge subsequent paths or to
abort.

This allows some additional use patterns. Merge conflicts can now be
previewed one at time and merges can also be skipped so that they can be
performed in a later pass.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 git-mergetool.sh |   52 +++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 507028f..5144971 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -70,16 +70,16 @@ resolve_symlink_merge () {
 		git checkout-index -f --stage=2 -- "$MERGED"
 		git add -- "$MERGED"
 		cleanup_temp_files --save-backup
-		return
+		return 0
 		;;
 	    [rR]*)
 		git checkout-index -f --stage=3 -- "$MERGED"
 		git add -- "$MERGED"
 		cleanup_temp_files --save-backup
-		return
+		return 0
 		;;
 	    [aA]*)
-		exit 1
+		return 1
 		;;
 	    esac
 	done
@@ -97,15 +97,15 @@ resolve_deleted_merge () {
 	    [mMcC]*)
 		git add -- "$MERGED"
 		cleanup_temp_files --save-backup
-		return
+		return 0
 		;;
 	    [dD]*)
 		git rm -- "$MERGED" > /dev/null
 		cleanup_temp_files
-		return
+		return 0
 		;;
 	    [aA]*)
-		exit 1
+		return 1
 		;;
 	    esac
 	done
@@ -137,7 +137,7 @@ merge_file () {
 	else
 	    echo "$MERGED: file does not need merging"
 	fi
-	exit 1
+	return 1
     fi
 
     ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
@@ -269,7 +269,7 @@ merge_file () {
     if test "$status" -ne 0; then
 	echo "merge of $MERGED failed" 1>&2
 	mv -- "$BACKUP" "$MERGED"
-	exit 1
+	return 1
     fi
 
     if test "$merge_keep_backup" = "true"; then
@@ -280,6 +280,7 @@ merge_file () {
 
     git add -- "$MERGED"
     cleanup_temp_files
+    return 0
 }
 
 prompt=$(git config --bool mergetool.prompt || echo true)
@@ -350,6 +351,22 @@ init_merge_tool_path() {
 	fi
 }
 
+prompt_after_failed_merge() {
+    while true; do
+	printf "Continue merging other unresolved paths (y/n) ? "
+	read ans
+	case "$ans" in
+
+	    [yY]*)
+		return 0
+		;;
+
+	    [nN]*)
+		return 1
+		;;
+	esac
+    done
+}
 
 if test -z "$merge_tool"; then
     merge_tool=`git config merge.tool`
@@ -409,6 +426,8 @@ else
     fi
 fi
 
+last_status=0
+rollup_status=0
 
 if test $# -eq 0 ; then
     files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
@@ -422,14 +441,29 @@ if test $# -eq 0 ; then
     sort -u |
     while IFS= read i
     do
+	if test $last_status -ne 0; then
+	    prompt_after_failed_merge < /dev/tty || exit 1
+	fi
 	printf "\n"
 	merge_file "$i" < /dev/tty > /dev/tty
+	last_status=$?
+	if test $last_status -ne 0; then
+	    rollup_status=1
+	fi
     done
 else
     while test $# -gt 0; do
+	if test $last_status -ne 0; then
+	    prompt_after_failed_merge || exit 1
+	fi
 	printf "\n"
 	merge_file "$1"
+	last_status=$?
+	if test $last_status -ne 0; then
+	    rollup_status=1
+	fi
 	shift
     done
 fi
-exit 0
+
+exit $rollup_status
-- 
1.6.1.rc1.342.g83b24d
