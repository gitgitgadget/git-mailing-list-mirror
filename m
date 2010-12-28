From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 15/31] rebase: factor out call to pre-rebase hook
Date: Tue, 28 Dec 2010 10:30:32 +0100
Message-ID: <1293528648-21873-16-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:33:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYk-0005Wr-DL
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab0L1Pcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:53 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48315 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab0L1Pct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:49 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so10443701qyk.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MXvs30qhZQEpdppxfJw2ICQumBN7rjp9lh/OxIJP5j4=;
        b=kRXM0GDoEOMuRzuhmz0OmYxyp+PM//DPeIsOtix/0TVk3xNKCGVqTXqRtvq4hB5sP6
         r8LA0Gz67hcxvyhY7ppRtCesaNXf8x0PiY4sE5r6FAeKUzYuYHSUPlo6cL4/sas924fJ
         GK02odrUUei+dH/ZaCIomfoXWkEfM2jkoq/PM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JvMPEZ56ZaeSnGjfXUaJIHqByviXXQWu3cG1ps9YtLj+JcMpQ+J16YazGUoAaKVHU2
         XYtRtHYs8PuLqY2pCt9BdbGV/5PA2S2HbXtCsTkE5z1RbFLwa+wPqZ9A3gLKafk92Hlo
         oWWjR6LFv7GW9z62IKPl+C26t4ejK+LTl2mno=
Received: by 10.229.79.135 with SMTP id p7mr12133564qck.154.1293550369548;
        Tue, 28 Dec 2010 07:32:49 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:48 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164249>

Remove the call to the pre-rebase hook from
git-rebase--interactive.sh and rely on the call in
git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |   14 --------------
 git-rebase.sh              |   15 ++++++++-------
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index edde1e5..0beeb8b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -109,18 +109,6 @@ commit_message () {
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
@@ -753,8 +741,6 @@ esac
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-run_pre_rebase_hook "$upstream_arg" "$@"
-
 comment_for_reflog start
 
 if test ! -z "$switch_to"
diff --git a/git-rebase.sh b/git-rebase.sh
index e1e5263..229e8d2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -185,9 +185,8 @@ run_interactive_rebase () {
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
@@ -515,15 +514,15 @@ orig_head=$branch
 
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
@@ -541,6 +540,8 @@ fi
 # If a hook exists, give it a chance to interrupt
 run_pre_rebase_hook "$upstream_arg" "$@"
 
+test "$type" = interactive && run_interactive_rebase
+
 # Detach HEAD and reset the tree
 say "First, rewinding head to replay your work on top of it..."
 git checkout -q "$onto^0" || die "could not detach HEAD"
-- 
1.7.3.2.864.gbbb96
