From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 13/31] rebase: factor out reference parsing
Date: Sun,  6 Feb 2011 13:43:42 -0500
Message-ID: <1297017841-20678-14-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9e8-0005ZO-84
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670Ab1BFSqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:11 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48348 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab1BFSqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:09 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so1045841qyj.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=5caoOqRCTcskikFcrsXbElzeNw6WTGueZxXvnIluAEQ=;
        b=caUHFrbzvVLclSX923U4t4sfNhA1vKJ+6Ch2CuffjpP2wWH2z1qF+Ufbrt/c/sO3jk
         kGTck5W+8bzypH3XEUUsatBeYXZfcyLGrlJn5N8y8w3Dtsy2NT7bx/NCyImstZZSs1M4
         v0vrc6toz8LFuqSI9K29VPkSpUBoDIsuEShGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qUMru8H5J/KUo/MYNsqWuYax/oxn5nqN/YDtxOvrkYrMe4bo3B7awa0HOqQcg97e/b
         pnGkFHSZad/jnyPI9RRSbN3VYnkBJRiR9lXEQq7CLUr7uClUycS8xoVcttS5gDRpWAIh
         Sr5dEvYG0MGO6bpVyseHSQboBKOmCQ+NfCtws=
Received: by 10.229.85.82 with SMTP id n18mr3464181qcl.292.1297017969139;
        Sun, 06 Feb 2011 10:46:09 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:08 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166172>

Remove the parsing and validation of references (onto, upstream, branch)
from git-rebase--interactive.sh and rely on the information exported from
git-rebase.sh.

By using the parsing of the --onto parameter in git-rebase.sh, this
improves the error message when the parameter is invalid.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Should the check for set GIT_COMMITTER_IDENT be done for
non-interactive rebase as well or does it only make sense for
interactive rebase?


 git-rebase--interactive.sh |   48 +++----------------------------------------
 git-rebase.sh              |    9 ++++---
 2 files changed, 9 insertions(+), 48 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0f04f36..fbe12a6 100755
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
@@ -769,47 +750,26 @@ skip)
 	;;
 esac
 
-if test -n "$onto"
-then
-	onto=$(parse_onto "$onto") || die "Does not point to a valid commit: $1"
-fi
-
-test -z "$rebase_root" -a $# -ge 1 -a $# -le 2 ||
-test ! -z "$rebase_root" -a $# -le 1 || usage
-
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-if test -z "$rebase_root"
-then
-	upstream_arg="$1"
-	upstream=$(git rev-parse --verify "$1") || die "Invalid base"
-	test -z "$onto" && onto=$upstream
-	shift
-else
-	upstream=
-	upstream_arg=--root
-	test -z "$onto" &&
-		die "You must specify --onto when using --root"
-fi
 require_clean_work_tree "rebase" "Please commit or stash them."
 
 run_pre_rebase_hook "$upstream_arg" "$@"
 
 comment_for_reflog start
 
-if test ! -z "$1"
+if test ! -z "$switch_to"
 then
-	output git checkout "$1" -- ||
-		die "Could not checkout $1"
+	output git checkout "$switch_to" -- ||
+		die "Could not checkout $switch_to"
 fi
 
 head=$(git rev-parse --verify HEAD) || die "No HEAD?"
 mkdir "$dotest" || die "Could not create temporary $dotest"
 
 : > "$dotest"/interactive || die "Could not mark as interactive"
-git symbolic-ref HEAD > "$dotest"/head-name 2> /dev/null ||
-	echo "detached HEAD" > "$dotest"/head-name
+echo "$head_name" > "$dotest"/head-name
 
 echo $head > "$dotest"/head
 case "$rebase_root" in
diff --git a/git-rebase.sh b/git-rebase.sh
index 4a83d10..0f5f5fb 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -431,8 +431,6 @@ else
 	state_dir="$apply_dir"
 fi
 
-test "$type" = interactive && run_interactive_rebase "$@"
-
 if test -z "$rebase_root"
 then
 	# The upstream head must be given.  Make sure it is valid.
@@ -443,7 +441,7 @@ then
 	unset root_flag
 	upstream_arg="$upstream_name"
 else
-	test -z "$onto" && die "--root must be used with --onto"
+	test -z "$onto" && die "You must specify --onto when using --root"
 	unset upstream_name
 	unset upstream
 	root_flag="--root"
@@ -470,7 +468,8 @@ case "$onto_name" in
 	fi
 	;;
 *)
-	onto=$(git rev-parse --verify "${onto_name}^0") || exit
+	onto=$(git rev-parse --verify "${onto_name}^0") ||
+	die "Does not point to a valid commit: $1"
 	;;
 esac
 
@@ -512,6 +511,8 @@ case "$#" in
 esac
 orig_head=$branch
 
+test "$type" = interactive && run_interactive_rebase "$@"
+
 require_clean_work_tree "rebase" "Please commit or stash them."
 
 # Now we are rebasing commits $upstream..$branch (or with --root,
-- 
1.7.4.rc2.33.g8a14f
