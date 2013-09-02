From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/6] pull: refactor $rebase variable into $mode
Date: Mon,  2 Sep 2013 17:17:56 -0500
Message-ID: <1378160278-14872-5-git-send-email-felipe.contreras@gmail.com>
References: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 00:23:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGcWi-0001AS-D9
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 00:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759130Ab3IBWXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 18:23:04 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:50495 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759121Ab3IBWXA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 18:23:00 -0400
Received: by mail-oa0-f44.google.com with SMTP id l17so5766592oag.17
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6erhhco83jeosE7PitEH/xo0LDtIn/Zt9vh3Y5TeF3Y=;
        b=HDcz+pHSLNKTp6vAxGK7n6u3VKMFqipxKPuR6KjQnDjdsoxDZWXstNXWwdxm1dm/B3
         dNcxCjx3aVm7NmsLfk235VqbA5wDD0BjrzoEOtgPfbYjChz7BJp3nffpvygEreTwr9yI
         a9u+0Gt25Qb+ojDsyavh86wyhxbJyAN57fBxPfmdKraVCxfuWWIqKAEuEsa3568OELBY
         9fB7TvfERvoAHadKhUftVoYmVLKT4K+3jFmKrq0fEIl/+8yyTi25sQyIgDC6prjo8Pe1
         Y9pAIVYfHYHyFvIJJKxdZv/Dtedj3HpYCwsnvULHDzS3/gKXxf1dWUwVZlt/n2VQ6HQ+
         zSng==
X-Received: by 10.182.237.44 with SMTP id uz12mr18680120obc.11.1378160580085;
        Mon, 02 Sep 2013 15:23:00 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm15909987oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 15:22:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233671>

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
