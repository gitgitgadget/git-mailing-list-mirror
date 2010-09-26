From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] Porcelain scripts: Rewrite cryptic "needs update" error message
Date: Sun, 26 Sep 2010 20:51:56 +0530
Message-ID: <1285514516-5112-3-git-send-email-artagnon@gmail.com>
References: <4C9E07B1.50600@workspacewhiz.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 26 17:23:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozt4s-0001ms-4E
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 17:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922Ab0IZPXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 11:23:31 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:57728 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab0IZPXa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 11:23:30 -0400
Received: by pxi10 with SMTP id 10so1174988pxi.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=R8nYsalJAsbAre6C/yN/vTRkfu1Nqg5dPg2ST5buFkA=;
        b=HC8faukmGcrS/YRlgvc8gh2wwlkPAjegxL4euPkNri6GQvIUMXJhmTiXzuHMtvj4Lx
         w3Re7WdJC5CnulkB2poHwOnX8BERhy9VvSvO3l5BAdnAFZT30ZvRfxL5ykMJdqO7lSaA
         z8jTPPRz6RoIYpTSz2wOWiYQvVMHUPuqg1Gco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S24od3eottEk5Rs77C0INmYW86JNFT2xMGQKFUhscIb1zWvTccYXmp1MysmjyADuEo
         7Gq9qW53BvqXHe5gw9tYgy/WJi//2TrkbP1zlUOtUT9LvXYSQbnUSxd3obDdUz7M0xtG
         8pjW+d+mBUaXoZVdRf+NBxeUxHLlffacchQpw=
Received: by 10.114.148.15 with SMTP id v15mr6893749wad.127.1285514610419;
        Sun, 26 Sep 2010 08:23:30 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d39sm8436936wam.16.2010.09.26.08.23.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 08:23:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a.dirty
In-Reply-To: <4C9E07B1.50600@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157232>

Although Git interally has the facility to differentiate between
porcelain and plubmbing commands and appropriately print errors,
several shell scripts invoke plubming commands triggering cryptic
plumbing errors to be displayed on a porcelain interface. This patch
replaces the "needs update" message in git-pull and git-rebase, when
`git update-index` is run, with a more friendly message.

Reported-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-pull.sh                |    5 +----
 git-rebase--interactive.sh |   16 ++++------------
 git-rebase.sh              |   14 +-------------
 3 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 8eb74d4..5da0f76 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -201,10 +201,7 @@ test true = "$rebase" && {
 			die "updating an unborn branch with changes added to the index"
 		fi
 	else
-		git update-index --ignore-submodules --refresh &&
-		git diff-files --ignore-submodules --quiet &&
-		git diff-index --ignore-submodules --cached --quiet HEAD -- ||
-		die "refusing to pull with rebase: your working tree is not up-to-date"
+		require_clean_work_tree "pull with rebase"
 	fi
 	oldremoteref= &&
 	. git-parse-remote &&
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a27952d..8722baf 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -153,14 +153,6 @@ run_pre_rebase_hook () {
 	fi
 }
 
-require_clean_work_tree () {
-	# test if working tree is dirty
-	git rev-parse --verify HEAD > /dev/null &&
-	git update-index --ignore-submodules --refresh &&
-	git diff-files --quiet --ignore-submodules &&
-	git diff-index --cached --quiet HEAD --ignore-submodules -- ||
-	die "Working tree is dirty"
-}
 
 ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"
 
@@ -557,7 +549,7 @@ do_next () {
 			exit "$status"
 		fi
 		# Run in subshell because require_clean_work_tree can die.
-		if ! (require_clean_work_tree)
+		if ! (require_clean_work_tree "rebase")
 		then
 			warn "Commit or stash your changes, and then run"
 			warn
@@ -740,7 +732,7 @@ do
 			die "Cannot read HEAD"
 		git update-index --ignore-submodules --refresh &&
 			git diff-files --quiet --ignore-submodules ||
-			die "Working tree is dirty"
+			die "Working tree is dirty. Please commit or stash your changes to proceed."
 
 		# do we have anything to commit?
 		if git diff-index --cached --quiet --ignore-submodules HEAD --
@@ -768,7 +760,7 @@ first and then run 'git rebase --continue' again."
 
 		record_in_rewritten "$(cat "$DOTEST"/stopped-sha)"
 
-		require_clean_work_tree
+		require_clean_work_tree "rebase"
 		do_rest
 		;;
 	--abort)
@@ -866,7 +858,7 @@ first and then run 'git rebase --continue' again."
 
 		comment_for_reflog start
 
-		require_clean_work_tree
+		require_clean_work_tree "rebase"
 
 		if test ! -z "$1"
 		then
diff --git a/git-rebase.sh b/git-rebase.sh
index 3335cee..c3ca8d5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -416,19 +416,7 @@ else
 	fi
 fi
 
-# The tree must be really really clean.
-if ! git update-index --ignore-submodules --refresh > /dev/null; then
-	echo >&2 "cannot rebase: you have unstaged changes"
-	git diff-files --name-status -r --ignore-submodules -- >&2
-	exit 1
-fi
-diff=$(git diff-index --cached --name-status -r --ignore-submodules HEAD --)
-case "$diff" in
-?*)	echo >&2 "cannot rebase: your index contains uncommitted changes"
-	echo >&2 "$diff"
-	exit 1
-	;;
-esac
+require_clean_work_tree "rebase"
 
 if test -z "$rebase_root"
 then
-- 
1.7.2.2.409.gdbb11.dirty
