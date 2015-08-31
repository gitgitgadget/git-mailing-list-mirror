From: Juerg Haefliger <juerg.haefliger@hp.com>
Subject: [PATCH] git-quiltimport: add commandline option --series <file>
Date: Mon, 31 Aug 2015 14:06:38 +0200
Message-ID: <1441022798-6033-1-git-send-email-juerg.haefliger@hp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 14:05:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWNqL-00018t-RD
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 14:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbbHaMFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 08:05:41 -0400
Received: from g4t3427.houston.hp.com ([15.201.208.55]:37714 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbbHaMFl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 08:05:41 -0400
Received: from smtp1.hp.com (ospra1.fc.hp.com [16.79.38.118])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by g4t3427.houston.hp.com (Postfix) with ESMTPS id 275E612C
	for <git@vger.kernel.org>; Mon, 31 Aug 2015 12:05:39 +0000 (UTC)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276875>

The quilt series file doesn't have to be located in the same directory
with the patches and can be named differently than 'series' as well. This
patch adds a commandline option to allow for a non-standard series
filename and location.

Signed-off-by: Juerg Haefliger <juerg.haefliger@hp.com>
---
 Documentation/git-quiltimport.txt | 11 +++++++++--
 git-quiltimport.sh                | 16 ++++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index d64388c..ff633b0 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git quiltimport' [--dry-run | -n] [--author <author>] [--patches <dir>]
+		[--series <file>]
 
 
 DESCRIPTION
@@ -42,13 +43,19 @@ OPTIONS
 	information can be found in the patch description.
 
 --patches <dir>::
-	The directory to find the quilt patches and the
-	quilt series file.
+	The directory to find the quilt patches.
 +
 The default for the patch directory is patches
 or the value of the $QUILT_PATCHES environment
 variable.
 
+--series <file>::
+	The quilt series file.
++
+The default for the series file is <patches>/series
+or the value of the $QUILT_SERIES environment
+variable.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 167d79f..6d3a88d 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -6,7 +6,8 @@ git quiltimport [options]
 --
 n,dry-run     dry run
 author=       author name and email address for patches without any
-patches=      path to the quilt series and patches
+patches=      path to the quilt patches
+series=       path to the quilt series file
 "
 SUBDIRECTORY_ON=Yes
 . git-sh-setup
@@ -27,6 +28,10 @@ do
 		shift
 		QUILT_PATCHES="$1"
 		;;
+	--series)
+		shift
+		QUILT_SERIES="$1"
+		;;
 	--)
 		shift
 		break;;
@@ -53,6 +58,13 @@ if ! [ -d "$QUILT_PATCHES" ] ; then
 	exit 1
 fi
 
+# Quilt series file
+: ${QUILT_SERIES:=$QUILT_PATCHES/series}
+if ! [ -e "$QUILT_SERIES" ] ; then
+	echo "The \"$QUILT_SERIES\" file does not exist."
+	exit 1
+fi
+
 # Temporary directories
 tmp_dir="$GIT_DIR"/rebase-apply
 tmp_msg="$tmp_dir/msg"
@@ -135,5 +147,5 @@ do
 		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
 	fi
-done 3<"$QUILT_PATCHES/series"
+done 3<"$QUILT_SERIES"
 rm -rf $tmp_dir || exit 5
-- 
2.1.4
