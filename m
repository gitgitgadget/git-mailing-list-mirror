From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/5] pull: refactor $rebase variable into $mode
Date: Sun,  8 Sep 2013 20:23:13 -0500
Message-ID: <1378689796-19305-3-git-send-email-felipe.contreras@gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	sandals@crustytoothpaste.net,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 03:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqHS-0001HK-3j
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 03:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab3IIB2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 21:28:35 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:35901 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab3IIB2b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 21:28:31 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so6004998oah.11
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 18:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6erhhco83jeosE7PitEH/xo0LDtIn/Zt9vh3Y5TeF3Y=;
        b=bk2UFH6BU22w0wjyYjccZf8qFy1/EpXnrI0RMiJbPr043qK00WIEJC2XXtbDIFOXMK
         KbisSEMZ00vpOcE7lW3dPimmOOPG9LrAILhTPsdpfjLS+y3HhFU/bUu1FHjq5UmjE299
         MVL3ZD/OZH1yHgbW34cY3hs+RAkVGbOVtzlLX8iITvleXwr2SNo+3xmJh/z4Rjlkme74
         8wkSDt55yrY12QJOiilNEiEabsViYDfbWfL8h25vJKK/q3fdL9CeGb8x9/kAcnJykL10
         Va51R+A/JaafkbCYUfJkDByTYnN29ng3iCy34dQiyyqY7Ult5J8l+wNfogqw/nfs64Jq
         j98w==
X-Received: by 10.182.215.202 with SMTP id ok10mr9790725obc.62.1378690110854;
        Sun, 08 Sep 2013 18:28:30 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ts4sm10452413obb.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 18:28:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234297>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-pull.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index de57c1d..f53d193 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -48,8 +48,7 @@ if test -z "$mode"
 then
 	mode=$(git config pull.mode)
 fi
-test "$mode" == 'rebase' && rebase="true"
-if test -z "$rebase"
+if test -z "$mode"
 then
 	rebase=$(git config --bool branch.$curr_branch_short.rebase)
 	if test -z "$rebase"
@@ -58,6 +57,7 @@ then
 	fi
 	if test "$rebase" = 'true'
 	then
+		mode="rebase"
 		echo "The configurations pull.rebase and branch.<name>.rebase are deprecated."
 		echo "Please use pull.mode and branch.<name>.pullmode instead."
 	fi
@@ -125,10 +125,10 @@ do
 		merge_args="$merge_args$xx "
 		;;
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
-		rebase=true
+		mode=rebase
 		;;
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
-		rebase=false
+		mode=
 		;;
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
@@ -171,7 +171,7 @@ error_on_no_merge_candidates () {
 		esac
 	done
 
-	if test true = "$rebase"
+	if test "$mode" = rebase
 	then
 		op_type=rebase
 		op_prep=against
@@ -185,7 +185,7 @@ error_on_no_merge_candidates () {
 	remote=$(git config "branch.$curr_branch.remote")
 
 	if [ $# -gt 1 ]; then
-		if [ "$rebase" = true ]; then
+		if [ "$mode" = rebase ]; then
 			printf "There is no candidate for rebasing against "
 		else
 			printf "There are no candidates for merging "
@@ -208,7 +208,7 @@ error_on_no_merge_candidates () {
 	exit 1
 }
 
-test true = "$rebase" && {
+test "$mode" = rebase && {
 	if ! git rev-parse -q --verify HEAD >/dev/null
 	then
 		# On an unborn branch
@@ -273,7 +273,7 @@ case "$merge_head" in
 	then
 		die "$(gettext "Cannot merge multiple branches into empty head")"
 	fi
-	if test true = "$rebase"
+	if test "$mode" = rebase
 	then
 		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
@@ -294,7 +294,7 @@ then
 	exit
 fi
 
-if test true = "$rebase"
+if test "$mode" = rebase
 then
 	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
 	if test "$oldremoteref" = "$o"
@@ -304,8 +304,8 @@ then
 fi
 
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
-case "$rebase" in
-true)
+case "$mode" in
+rebase)
 	eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
-- 
1.8.4-338-gefd7fa6
