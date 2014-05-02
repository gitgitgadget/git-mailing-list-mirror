From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 3/7] pull: refactor $rebase variable into $mode
Date: Thu,  1 May 2014 19:00:04 -0500
Message-ID: <1398988808-29678-4-git-send-email-felipe.contreras@gmail.com>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 02:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg14a-00015g-IC
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbaEBALG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:11:06 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:63500 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbaEBALF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 20:11:05 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so1797326oag.26
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D2Xrd3xq0qV0laLObzOUOuTiSlfZiP4oYCYRta5agDo=;
        b=R9WLLSkTFWHIvBl1L7HfpZp/EIX6Cw9n3gmDbou7cJpv2/Z4UPJQ/3X6aI1KPjjjmw
         zmL4llCzwgMWb2gJxX7YiNF2w+D0f7AHXiTdf8DL/jOUcwgEz1o3XpqltYxgCFQ12e0v
         LUiwQ2foIxZOnj1FNrLfXJnTyYR41hW3qMUGzDpdQSg4Vj4nHCnUePuEcikO0JdSKAJg
         lavnY5M4RBRPNOX4RZPPAdvrJK727EnHXim3k8TGqzW1z/SnRB3gYfWu407t4w66moXB
         frHVYwpY5TGBVOvz12x4NAtCI8dudN79Z+yxEtUXMHY0TDa4bwRMGqQXUPoQIQdrn9bh
         DuEw==
X-Received: by 10.60.174.164 with SMTP id bt4mr10760122oec.54.1398989465009;
        Thu, 01 May 2014 17:11:05 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c7sm122946083oek.12.2014.05.01.17.11.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 17:11:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.19.g85b6256
In-Reply-To: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247908>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-pull.sh | 64 +++++++++++++++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 3dbf9cf..50c612f 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -53,16 +53,11 @@ then
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
@@ -71,7 +66,7 @@ rebase-preserve)
 	;;
 esac
 # backwards compatibility
-if test -z "$rebase"
+if test -z "$mode"
 then
 	rebase=$(bool_or_string_config branch.$curr_branch_short.rebase)
 	if test -z "$rebase"
@@ -145,10 +140,10 @@ do
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
@@ -179,19 +174,26 @@ do
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
@@ -205,7 +207,7 @@ error_on_no_merge_candidates () {
 		esac
 	done
 
-	if test true = "$rebase"
+	if test "$mode" = rebase
 	then
 		op_type=rebase
 		op_prep=against
@@ -218,7 +220,7 @@ error_on_no_merge_candidates () {
 	remote=$(git config "branch.$curr_branch_short.remote")
 
 	if [ $# -gt 1 ]; then
-		if [ "$rebase" = true ]; then
+		if [ "$mode" = rebase ]; then
 			printf "There is no candidate for rebasing against "
 		else
 			printf "There are no candidates for merging "
@@ -241,7 +243,7 @@ error_on_no_merge_candidates () {
 	exit 1
 }
 
-test true = "$rebase" && {
+test "$mode" = rebase && {
 	if ! git rev-parse -q --verify HEAD >/dev/null
 	then
 		# On an unborn branch
@@ -298,7 +300,7 @@ case "$merge_head" in
 	then
 		die "$(gettext "Cannot merge multiple branches into empty head")"
 	fi
-	if test true = "$rebase"
+	if test "$mode" = rebase
 	then
 		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
@@ -319,7 +321,7 @@ then
 	exit
 fi
 
-if test true = "$rebase"
+if test "$mode" = rebase
 then
 	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
 	if test "$oldremoteref" = "$o"
@@ -329,8 +331,8 @@ then
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
1.9.2+fc1.19.g85b6256
