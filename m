From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 15/20] rebase: factor out call to pre-rebase hook
Date: Thu, 25 Nov 2010 20:57:58 +0100
Message-ID: <1290715083-16919-16-git-send-email-martin.von.zweigbergk@gmail.com>
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
	id 1PLna7-0001kp-Oe
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab0KZB60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:26 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63197 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0KZB6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:24 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347966vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=T1MgzsokvX+pYhJRMHzJS3n6kCV8a3nVR/d9QaYOZQ8=;
        b=uopKl2Af6un9egs/Pa1H9WMjHn18vUgmPeqlKl+slwW2FTSmDhDeWmSWa4HxWH0eVV
         iup+R8CS75AshFXMbCmp4I5l94hqWjhYFvkEFlMOpp0cJs68s2/99B1O+dmVvdIVv8xg
         L90ojpmmB9H2Mw/g8phkzHxLnoYQqWKGQE66c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iAXgrM9+/wDQnAlmIClVjfGPyMu5/Vp4ViEVX+1zkVkCN6pHwXm+T4eQOVltFb6YL9
         lPGRSGqtFvXX9il3fN/h81vLL47YSvMtzRnwL/PY35sG//ijgBf2XVccDy/q4ZYlQ5qy
         nSPwdu1kznk1MO+mdbiQip1HyX/49KXFsqaE0=
Received: by 10.220.97.17 with SMTP id j17mr395853vcn.26.1290736703760;
        Thu, 25 Nov 2010 17:58:23 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:23 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162165>

Remove the call to the pre-rebase hook from
git-rebase--interactive.sh and rely on the call in
git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |   14 --------------
 git-rebase.sh              |   15 ++++++++-------
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 36bf259..d60977d 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -110,18 +110,6 @@ commit_message () {
 	git cat-file commit "$1" | sed "1,/^$/d"
 }
 
-run_pre_rebase_hook () {
-	if test -z "$OK_TO_SKIP_PRE_REBASE" &&
-	   test -x "$GIT_DIR/hooks/pre-rebase"
-	then
-		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
-			echo >&2 "The pre-rebase hook refused to rebase."
-			exit 1
-		}
-	fi
-}
-
-
 ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"
 
 comment_for_reflog () {
@@ -755,8 +743,6 @@ test -n "$strategy" && strategy="-s $strategy"
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-run_pre_rebase_hook "$upstream_arg" "$@"
-
 comment_for_reflog start
 
 if test ! -z "$switch_to"
diff --git a/git-rebase.sh b/git-rebase.sh
index 9d398eb..11cea3c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -180,9 +180,8 @@ run_interactive_rebase () {
 		export GIT_EDITOR
 	fi
 	export onto autosquash strategy strategy_opts verbose rebase_root \
-	force_rebase action preserve_merges OK_TO_SKIP_PRE_REBASE upstream \
-	upstream_arg switch_to head_name
-	exec git-rebase--interactive "$@"
+	force_rebase action preserve_merges upstream switch_to head_name
+	exec git-rebase--interactive
 }
 
 run_pre_rebase_hook () {
@@ -497,15 +496,15 @@ orig_head=$branch
 
 require_clean_work_tree "rebase" "Please commit or stash them."
 
-test -n "$interactive_rebase" && run_interactive_rebase "$@"
-
 # Now we are rebasing commits $upstream..$branch (or with --root,
 # everything leading up to $branch) on top of $onto
 
 # Check if we are already based on $onto with linear history,
-# but this should be done only when upstream and onto are the same.
+# but this should be done only when upstream and onto are the same
+# and if this is not an interactive rebase.
 mb=$(git merge-base "$onto" "$branch")
-if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
+if test -z "$interactive_rebase" && test "$upstream" = "$onto" &&
+	test "$mb" = "$onto" &&
 	# linear history?
 	! (git rev-list --parents "$onto".."$branch" | sane_grep " .* ") > /dev/null
 then
@@ -523,6 +522,8 @@ fi
 # If a hook exists, give it a chance to interrupt
 run_pre_rebase_hook "$upstream_arg" "$@"
 
+test -n "$interactive_rebase" && run_interactive_rebase
+
 # Detach HEAD and reset the tree
 say "First, rewinding head to replay your work on top of it..."
 git checkout -q "$onto^0" || die "could not detach HEAD"
-- 
1.7.3.2.864.gbbb96
