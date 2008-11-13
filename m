From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Thu, 13 Nov 2008 12:41:15 +0000
Message-ID: <1226580075-29289-4-git-send-email-charles@hashpling.org>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org>
 <1226580075-29289-2-git-send-email-charles@hashpling.org>
 <1226580075-29289-3-git-send-email-charles@hashpling.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:43:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0bX5-00086U-5w
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 13:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbYKMMle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 07:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbYKMMld
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 07:41:33 -0500
Received: from fhw-relay07.plus.net ([212.159.14.148]:36374 "EHLO
	fhw-relay07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbYKMMl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 07:41:28 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1L0bVc-0007fg-Ul; Thu, 13 Nov 2008 12:41:17 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id mADCfGtY029331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 12:41:16 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id mADCfGFg029330;
	Thu, 13 Nov 2008 12:41:16 GMT
X-Mailer: git-send-email 1.6.0.2.534.g5ab59
In-Reply-To: <1226580075-29289-3-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: 71fedc9d8b397d0dce5b2cb79f52f738
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100871>

This option stops git mergetool from aborting at the first failed merge.
This allows some additional use patterns. Merge conflicts can now be
previewed one at time and merges can also be skipped so that they can be
performed in a later pass.

There is also a mergetool.keepGoing configuration variable covering the
same behaviour.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 Documentation/config.txt        |    4 +++
 Documentation/git-mergetool.txt |   12 +++++++++-
 git-mergetool.sh                |   46 ++++++++++++++++++++++++++++++--------
 3 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c5b211a..0b0bc99 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -976,6 +976,10 @@ mergetool.keepBackup::
 	is set to `false` then this file is not preserved.  Defaults to
 	`true` (i.e. keep the backup files).
 
+mergetool.keepGoing::
+	Continue to attempt resolution of remaining conflicted files even
+	after a merge has failed or been aborted.
+
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
 
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 176483a..bd2a5ab 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -7,7 +7,8 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 
 SYNOPSIS
 --------
-'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>]...
+'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt]
+	[-k|--keep-going|--no-keep-going] [<file>]...
 
 DESCRIPTION
 -----------
@@ -69,6 +70,15 @@ success of the resolution after the custom tool has exited.
 	This is the default behaviour; the option is provided to
 	override any configuration settings.
 
+-k or --keep-going::
+	Continue to attempt resolution of remaining conflicted files
+	even after a merge has failed or been aborted.
+
+--no-keep-going::
+	Abort the conflict resolution attempt if any single conflict
+	resolution fails or is aborted. This is the default behaviour;
+	the option is provided to override any configuration settings.
+
 Author
 ------
 Written by Theodore Y Ts'o <tytso@mit.edu>
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 507028f..d60f493 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -8,7 +8,8 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [-y|--no-prompt|--prompt] [file to merge] ...'
+USAGE='[--tool=tool] [-y|--no-prompt|--prompt]
+[-k|--keep-going|--no-keep-going] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
@@ -70,16 +71,16 @@ resolve_symlink_merge () {
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
@@ -97,15 +98,15 @@ resolve_deleted_merge () {
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
@@ -137,7 +138,7 @@ merge_file () {
 	else
 	    echo "$MERGED: file does not need merging"
 	fi
-	exit 1
+	return 1
     fi
 
     ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
@@ -269,7 +270,8 @@ merge_file () {
     if test "$status" -ne 0; then
 	echo "merge of $MERGED failed" 1>&2
 	mv -- "$BACKUP" "$MERGED"
-	exit 1
+	cleanup_temp_files
+	return 1
     fi
 
     if test "$merge_keep_backup" = "true"; then
@@ -280,9 +282,11 @@ merge_file () {
 
     git add -- "$MERGED"
     cleanup_temp_files
+    return 0
 }
 
 prompt=$(git config --bool mergetool.prompt || echo true)
+keep_going=$(git config --bool mergetool.keepGoing || echo false)
 
 while test $# != 0
 do
@@ -305,6 +309,12 @@ do
 	--prompt)
 	    prompt=true
 	    ;;
+	-k|--keep-going)
+	    keep_going=true
+	    ;;
+	--no-keep-going)
+	    keep_going=false
+	    ;;
 	--)
 	    break
 	    ;;
@@ -409,6 +419,7 @@ else
     fi
 fi
 
+rollup_status=0
 
 if test $# -eq 0 ; then
     files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
@@ -424,12 +435,27 @@ if test $# -eq 0 ; then
     do
 	printf "\n"
 	merge_file "$i" < /dev/tty > /dev/tty
+	if test $? -ne 0; then
+	    if test "$keep_going" = true; then
+		rollup_status=1
+	    else
+		exit 1
+	    fi
+	fi
     done
 else
     while test $# -gt 0; do
 	printf "\n"
 	merge_file "$1"
+	if test $? -ne 0; then
+	    if test "$keep_going" = true; then
+		rollup_status=1
+	    else
+		exit 1
+	    fi
+	fi
 	shift
     done
 fi
-exit 0
+
+exit $rollup_status
-- 
1.6.0.2.534.g5ab59
