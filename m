From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 15/31] rebase: factor out call to pre-rebase hook
Date: Sun,  6 Feb 2011 13:43:44 -0500
Message-ID: <1297017841-20678-16-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9e9-0005ZO-NZ
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab1BFSqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:16 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab1BFSqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:13 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=C4oNhZ5Cc9+U8CSWOmaJcf5CAnykV+IFJzEAhlK2rfM=;
        b=dtEtu8uCK2LkYrGzgdE7IFqtXMKjkd85IGDGlWtDfxTJoWGId6qUSP9b7XNkovI4ZA
         YoG9R17Ei7ac2XuS5oo4HfGoT3S+N3fNqaJxJJ/Tml/t+iKij3um9ku5T3arWCu8Rg7u
         YZMVRo+KsIoR5F8lG501y26drrbEZJCFLnqaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kQN8+GrRxhewYPb1Et4P7gijEN3UNNASq2NHpmUBC5v/m5ujQyIkhQU1u0AWI2C4ro
         IvA65eozkR/dJTvhZGoFsw7S4fDcOXv0YnkSjNAyTSr/twykwcSl1IHj9bAy49KWgjlu
         MlCG+ljZ0SFYPX5MoXrXVdBxwc0Ehxn+wRig4=
Received: by 10.224.60.73 with SMTP id o9mr4251837qah.58.1297017973036;
        Sun, 06 Feb 2011 10:46:13 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:12 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166174>

Remove the call to the pre-rebase hook from
git-rebase--interactive.sh and rely on the call in
git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |   14 --------------
 git-rebase.sh              |   12 +++++++-----
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1ba98a2..f94f057 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -109,18 +109,6 @@ commit_message () {
 	git cat-file commit "$1" | sed "1,/^$/d"
 }
 
-run_pre_rebase_hook () {
-	if test -z "$ok_to_skip_pre_rebase" &&
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
 orig_reflog_action="$GIT_REFLOG_ACTION"
 
 comment_for_reflog () {
@@ -753,8 +741,6 @@ esac
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-run_pre_rebase_hook "$upstream_arg" "$@"
-
 comment_for_reflog start
 
 if test ! -z "$switch_to"
diff --git a/git-rebase.sh b/git-rebase.sh
index 265f01d..87d7fde 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -184,7 +184,7 @@ run_interactive_rebase () {
 		GIT_EDITOR=:
 		export GIT_EDITOR
 	fi
-	. git-rebase--interactive "$@"
+	. git-rebase--interactive
 }
 
 run_pre_rebase_hook () {
@@ -513,15 +513,15 @@ orig_head=$branch
 
 require_clean_work_tree "rebase" "Please commit or stash them."
 
-test "$type" = interactive && run_interactive_rebase "$@"
-
 # Now we are rebasing commits $upstream..$branch (or with --root,
 # everything leading up to $branch) on top of $onto
 
 # Check if we are already based on $onto with linear history,
-# but this should be done only when upstream and onto are the same.
+# but this should be done only when upstream and onto are the same
+# and if this is not an interactive rebase.
 mb=$(git merge-base "$onto" "$branch")
-if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
+if test "$type" != interactive && test "$upstream" = "$onto" &&
+	test "$mb" = "$onto" &&
 	# linear history?
 	! (git rev-list --parents "$onto".."$branch" | sane_grep " .* ") > /dev/null
 then
@@ -539,6 +539,8 @@ fi
 # If a hook exists, give it a chance to interrupt
 run_pre_rebase_hook "$upstream_arg" "$@"
 
+test "$type" = interactive && run_interactive_rebase
+
 # Detach HEAD and reset the tree
 say "First, rewinding head to replay your work on top of it..."
 git checkout -q "$onto^0" || die "could not detach HEAD"
-- 
1.7.4.rc2.33.g8a14f
