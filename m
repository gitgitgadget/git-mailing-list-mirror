From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 3/6] pull: refactor $rebase variable into $mode
Date: Tue, 29 Apr 2014 06:17:03 -0500
Message-ID: <1398770226-9686-4-git-send-email-felipe.contreras@gmail.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 13:28:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf6Cr-0004pG-KE
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933908AbaD2L14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:27:56 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:32911 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933877AbaD2L1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:27:53 -0400
Received: by mail-yh0-f49.google.com with SMTP id t59so44639yho.8
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z3htA4pQpU6MJzI0LHJbNW/Q51icJ8oNKQMOCN4TZD8=;
        b=pR/EUPM9OdnTRyE8iTkajQ0TCBghi5bERlN9T8Sp7PzhdoJcL8nwAefBEH28fn7HDa
         xz4cur/gVxwkv5cT30txS3tbiVQTbiLiYkHhOKc025FOjKodjMuBaW/maQdYbkI19CjS
         dk5oevOe9WU2USd48/TAu8ReYaVsBjKZtHykOKiBTiV7Zb+v2nuXqYPdUFvfJUIhdrXD
         rM+q7bn++Ub57jpPZSuseAyJk1fdWzU86SJjUU1IxMYHU5GL7Qltik3nu1vyonD15HI4
         JcC1/k9dIgEka2wZj5YeQQd1hC3f/2YBGWhUU7ajXoW2o+xSiomyB6HPykvv4B0uod5g
         nt0g==
X-Received: by 10.236.137.8 with SMTP id x8mr44927368yhi.4.1398770873059;
        Tue, 29 Apr 2014 04:27:53 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f62sm36144217yhq.6.2014.04.29.04.27.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 04:27:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247570>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-pull.sh | 65 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index d4e25f1..3dfd856 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -57,16 +57,11 @@ then
 	mode=$(git config pull.mode)
 fi
 case "$mode" in
-merge)
-	rebase="false"
-	;;
-rebase)
-	rebase="true"
+merge|rebase|'')
 	;;
 rebase-preserve)
-	rebase="preserve"
-	;;
-'')
+	mode="rebase"
+	rebase_args="--preserve-merges"
 	;;
 *)
 	echo "Invalid value for 'mode'"
@@ -74,7 +69,8 @@ rebase-preserve)
 	exit 1
 	;;
 esac
-if test -z "$rebase"
+
+if test -z "$mode"
 then
 	rebase=$(bool_or_string_config branch.$curr_branch_short.rebase)
 	if test -z "$rebase"
@@ -153,10 +149,10 @@ do
 		rebase="${1#*=}"
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
@@ -187,19 +183,26 @@ do
 	shift
 done
 
-case "$rebase" in
-preserve)
-	rebase=true
-	rebase_args=--preserve-merges
-	;;
-true|false|'')
-	;;
-*)
-	echo "Invalid value for --rebase, should be true, false, or preserve"
-	usage
-	exit 1
-	;;
-esac
+if test -n "$rebase"
+then
+	case "$rebase" in
+	true)
+		mode="rebase"
+		;;
+	false)
+		mode="merge"
+		;;
+	preserve)
+		mode="rebase"
+		rebase_args=--preserve-merges
+		;;
+	*)
+		echo "Invalid value for --rebase, should be true, false, or preserve"
+		usage
+		exit 1
+		;;
+	esac
+fi
 
 error_on_no_merge_candidates () {
 	exec >&2
@@ -213,7 +216,7 @@ error_on_no_merge_candidates () {
 		esac
 	done
 
-	if test true = "$rebase"
+	if test "$mode" = rebase
 	then
 		op_type=rebase
 		op_prep=against
@@ -226,7 +229,7 @@ error_on_no_merge_candidates () {
 	remote=$(git config "branch.$curr_branch_short.remote")
 
 	if [ $# -gt 1 ]; then
-		if [ "$rebase" = true ]; then
+		if [ "$mode" = rebase ]; then
 			printf "There is no candidate for rebasing against "
 		else
 			printf "There are no candidates for merging "
@@ -249,7 +252,7 @@ error_on_no_merge_candidates () {
 	exit 1
 }
 
-test true = "$rebase" && {
+test "$mode" = rebase && {
 	if ! git rev-parse -q --verify HEAD >/dev/null
 	then
 		# On an unborn branch
@@ -306,7 +309,7 @@ case "$merge_head" in
 	then
 		die "$(gettext "Cannot merge multiple branches into empty head")"
 	fi
-	if test true = "$rebase"
+	if test "$mode" = rebase
 	then
 		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
@@ -327,7 +330,7 @@ then
 	exit
 fi
 
-if test true = "$rebase"
+if test "$mode" = rebase
 then
 	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
 	if test "$oldremoteref" = "$o"
@@ -337,8 +340,8 @@ then
 fi
 
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
-case "$rebase" in
-true)
+case "$mode" in
+rebase)
 	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
-- 
1.9.2+fc1.3.gade8541
