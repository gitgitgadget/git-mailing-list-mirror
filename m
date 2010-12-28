From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 13/31] rebase: factor out reference parsing
Date: Tue, 28 Dec 2010 10:30:30 +0100
Message-ID: <1293528648-21873-14-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYv-0005Wr-5Y
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab0L1Pdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:49 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43383 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab0L1Pcq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:46 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so11285887qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FvidmNy8o9uoAq2Xw8Tu9H3/Ly6gnVM238ymlq8GhYw=;
        b=aeacPd9FmtSMDa/EiYMRKfu3LNaurByHrTCazE1hap1KT0HqMsd+I9A0gq85ceBYNc
         J1Zfg5O6tBNHQpvFn0Roh1Ib3NmvF/fRHLG+dgN2FBHRtHEUdolQrTaO2oZxd5DjRBFF
         lPqvxYN0K0zEtgAR80THGsrkQZYusQq+4h5gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b5ldLtKZj9wpsXBivCFl7Eq64CH+rZwD6dtOGqRDyrD0IykmbTXNlC2rGoqAFcczNw
         pDUnMW2Da/gySjfN+NJ0Zb1T04Qh51gQM4XmJfRDKaZrnfkxaORuxgmA/5euCY7kA81P
         5pO/we8AP/HR2suYkQr2zL3kTwKjfGNgw+cKk=
Received: by 10.224.19.142 with SMTP id a14mr12986647qab.194.1293550365924;
        Tue, 28 Dec 2010 07:32:45 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:45 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164262>

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
 git-rebase.sh              |   12 ++++++----
 2 files changed, 11 insertions(+), 49 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5a8f582..c055fc4 100755
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
diff --git a/git-rebase.sh b/git-rebase.sh
index 26e4218..d8c7c8d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -185,7 +185,8 @@ run_interactive_rebase () {
 		export GIT_EDITOR
 	fi
 	export onto autosquash strategy strategy_opts verbose rebase_root \
-	force_rebase action preserve_merges OK_TO_SKIP_PRE_REBASE
+	force_rebase action preserve_merges OK_TO_SKIP_PRE_REBASE upstream \
+	upstream_arg switch_to head_name
 	exec git-rebase--interactive "$@"
 }
 
@@ -433,8 +434,6 @@ else
 	state_dir="$apply_dir"
 fi
 
-test "$type" = interactive && run_interactive_rebase "$@"
-
 if test -z "$rebase_root"
 then
 	# The upstream head must be given.  Make sure it is valid.
@@ -445,7 +444,7 @@ then
 	unset root_flag
 	upstream_arg="$upstream_name"
 else
-	test -z "$onto" && die "--root must be used with --onto"
+	test -z "$onto" && die "You must specify --onto when using --root"
 	unset upstream_name
 	unset upstream
 	root_flag="--root"
@@ -472,7 +471,8 @@ case "$onto_name" in
 	fi
 	;;
 *)
-	onto=$(git rev-parse --verify "${onto_name}^0") || exit
+	onto=$(git rev-parse --verify "${onto_name}^0") ||
+	die "Does not point to a valid commit: $1"
 	;;
 esac
 
@@ -513,6 +513,8 @@ case "$#" in
 esac
 orig_head=$branch
 
+test "$type" = interactive && run_interactive_rebase "$@"
+
 require_clean_work_tree "rebase" "Please commit or stash them."
 
 # Now we are rebasing commits $upstream..$branch (or with --root,
-- 
1.7.3.2.864.gbbb96
