From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 13/20] rebase: factor out reference parsing
Date: Thu, 25 Nov 2010 20:57:56 +0100
Message-ID: <1290715083-16919-14-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:58:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLna7-0001kp-87
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197Ab0KZB6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:24 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58794 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab0KZB6U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:20 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so348008vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RoE7BC/kB0pxNfZuOOxdtES4W5if/ncHohsHxdCcaLk=;
        b=nVTu2t8ewG0ibXjvIuU+uNMU61W2HbCzwuTMRfMd5eM6v/0T+m4WF/4mW1F0mGieq5
         D/mXGEGRJ96vMSDl+Ouqx2LMew1Ipr6Z4I5TYDyoXGNTYxSgK7Nl4mg3w5l/Mxx/Pv0g
         3xvMrgBgPM6CNSeNhTWIpDbvTfUHuhY7FYGSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fBTMilNqysul25rBAB4U3XEoCiFCN8BrJLbiIKCX9Y+j1qWlDxaTb6ljI5BmV//kEK
         C2Itygv43IoB9v1195Tptq5fBU/uZ1+C1yof7ZWbPpI5uOSf8VeiG+VLeenU3t/i0b/Y
         NKW0R1BUeoYGENX2yAGpnbqgdAHGEEuHjJ6tA=
Received: by 10.220.176.74 with SMTP id bd10mr394121vcb.22.1290736700261;
        Thu, 25 Nov 2010 17:58:20 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:19 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162164>

Remove the parsing and validation of references (onto, upstream, branch)
from git-rebase--interactive.sh and rely on the information exported from
git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |   59 +++++++------------------------------------
 git-rebase.sh              |   12 +++++---
 2 files changed, 17 insertions(+), 54 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f07472a..fe56d98 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -682,25 +682,6 @@ rearrange_squash () {
 	rm -f "$1.sq" "$1.rearranged"
 }
 
-LF='
-'
-parse_onto () {
-	case "$1" in
-	*...*)
-		if	left=${1%...*} right=${1#*...} &&
-			onto=$(git merge-base --all ${left:-HEAD} ${right:-HEAD})
-		then
-			case "$onto" in
-			?*"$LF"?* | '')
-				exit 1 ;;
-			esac
-			echo "$onto"
-			exit 0
-		fi
-	esac
-	git rev-parse --verify "$1^0"
-}
-
 case "$action" in
 continue)
 	get_saved_options
@@ -769,48 +750,28 @@ skip)
 	;;
 esac
 
-if test -n "$onto"
-then
-	onto=$(parse_onto "$onto") || die "Does not point to a valid commit: $1"
-fi
 test -n "$strategy" && strategy="-s $strategy"
 
-test -z "$rebase_root" -a $# -ge 1 -a $# -le 2 ||
-test ! -z "$rebase_root" -a $# -le 1 || usage
-
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-if test -z "$rebase_root"
-then
-	UPSTREAM_ARG="$1"
-	UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
-	test -z "$onto" && onto=$UPSTREAM
-	shift
-else
-	UPSTREAM=
-	UPSTREAM_ARG=--root
-	test -z "$onto" &&
-		die "You must specify --onto when using --root"
-fi
 require_clean_work_tree "rebase" "Please commit or stash them."
 
-run_pre_rebase_hook "$UPSTREAM_ARG" "$@"
+run_pre_rebase_hook "$upstream_arg" "$@"
 
 comment_for_reflog start
 
-if test ! -z "$1"
+if test ! -z "$switch_to"
 then
-	output git checkout "$1" ||
-		die "Could not checkout $1"
+	output git checkout "$switch_to" ||
+		die "Could not checkout $switch_to"
 fi
 
 HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
 mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
 
 : > "$DOTEST"/interactive || die "Could not mark as interactive"
-git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
-	echo "detached HEAD" > "$DOTEST"/head-name
+echo "$head_name" > "$DOTEST"/head-name
 
 echo $HEAD > "$DOTEST"/head
 case "$rebase_root" in
@@ -827,7 +788,7 @@ then
 	if test -z "$rebase_root"
 	then
 		mkdir "$REWRITTEN" &&
-		for c in $(git merge-base --all $HEAD $UPSTREAM)
+		for c in $(git merge-base --all $HEAD $upstream)
 		do
 			echo $onto > "$REWRITTEN"/$c ||
 				die "Could not init rewritten commits"
@@ -841,7 +802,7 @@ then
 	# parents to rewrite and skipping dropped commits would
 	# prematurely end our probe
 	MERGES_OPTION=
-	first_after_upstream="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
+	first_after_upstream="$(git rev-list --reverse --first-parent $upstream..$HEAD | head -n 1)"
 else
 	MERGES_OPTION="--no-merges --cherry-pick"
 fi
@@ -849,10 +810,10 @@ fi
 SHORTHEAD=$(git rev-parse --short $HEAD)
 SHORTONTO=$(git rev-parse --short $onto)
 if test -z "$rebase_root"
-	# this is now equivalent to ! -z "$UPSTREAM"
+	# this is now equivalent to ! -z "$upstream"
 then
-	SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
-	REVISIONS=$UPSTREAM...$HEAD
+	SHORTUPSTREAM=$(git rev-parse --short $upstream)
+	REVISIONS=$upstream...$HEAD
 	SHORTREVISIONS=$SHORTUPSTREAM..$SHORTHEAD
 else
 	REVISIONS=$onto...$HEAD
diff --git a/git-rebase.sh b/git-rebase.sh
index 5b0b73a..17b5042 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -180,7 +180,8 @@ run_interactive_rebase () {
 		export GIT_EDITOR
 	fi
 	export onto autosquash strategy strategy_opts verbose rebase_root \
-	force_rebase action preserve_merges OK_TO_SKIP_PRE_REBASE
+	force_rebase action preserve_merges OK_TO_SKIP_PRE_REBASE upstream \
+	upstream_arg switch_to head_name
 	exec git-rebase--interactive "$@"
 }
 
@@ -415,8 +416,6 @@ abort)
 	;;
 esac
 
-test -n "$interactive_rebase" && run_interactive_rebase "$@"
-
 if test -z "$rebase_root"
 then
 	# The upstream head must be given.  Make sure it is valid.
@@ -427,7 +426,7 @@ then
 	unset root_flag
 	upstream_arg="$upstream_name"
 else
-	test -z "$onto" && die "--root must be used with --onto"
+	test -z "$onto" && die "You must specify --onto when using --root"
 	unset upstream_name
 	unset upstream
 	root_flag="--root"
@@ -454,7 +453,8 @@ case "$onto_name" in
 	fi
 	;;
 *)
-	onto=$(git rev-parse --verify "${onto_name}^0") || exit
+	onto=$(git rev-parse --verify "${onto_name}^0") ||
+	die "Does not point to a valid commit: $1"
 	;;
 esac
 
@@ -495,6 +495,8 @@ case "$#" in
 esac
 orig_head=$branch
 
+test -n "$interactive_rebase" && run_interactive_rebase "$@"
+
 require_clean_work_tree "rebase" "Please commit or stash them."
 
 # Now we are rebasing commits $upstream..$branch (or with --root,
-- 
1.7.3.2.864.gbbb96
