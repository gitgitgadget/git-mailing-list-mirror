From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Tue, 21 Oct 2008 11:13:19 +0100
Message-ID: <1224583999-26279-3-git-send-email-charles@hashpling.org>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org>
 <1224583999-26279-2-git-send-email-charles@hashpling.org>
Cc: Jeff King <peff@peff.net>,
	William Pursell <bill.pursell@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Theodore Ts'o" <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 12:14:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsEG8-0002PX-09
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 12:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbYJUKN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 06:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbYJUKN0
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 06:13:26 -0400
Received: from pih-relay08.plus.net ([212.159.14.20]:40777 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYJUKNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 06:13:25 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1KsEEr-0003Gf-8M; Tue, 21 Oct 2008 11:13:21 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9LADKN4026311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Oct 2008 11:13:20 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m9LADKLg026310;
	Tue, 21 Oct 2008 11:13:20 +0100
X-Mailer: git-send-email 1.6.0.2.534.g5ab59
In-Reply-To: <1224583999-26279-2-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: 69e7ca22c8cc593aa486781687072ebf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98770>

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
index b4e4ee4..789c88a 100644
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
index 6d6bfe0..15466f3 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -7,7 +7,8 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 
 SYNOPSIS
 --------
-'git mergetool' [--tool=<tool>] [-n|--no-prompt|--prompt] [<file>]...
+'git mergetool' [--tool=<tool>] [-n|--no-prompt|--prompt]
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
index 8bc5366..c1e2de9 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -8,7 +8,8 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [-n|--no-prompt|--prompt] [file to merge] ...'
+USAGE='[--tool=tool] [-n|--no-prompt|--prompt]
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
