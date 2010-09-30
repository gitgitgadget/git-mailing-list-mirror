From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/2] Porcelain scripts: Rewrite cryptic "needs update" error message
Date: Fri,  1 Oct 2010 01:33:37 +0530
Message-ID: <1285877017-8060-3-git-send-email-artagnon@gmail.com>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 30 22:05:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1PNX-000618-QX
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 22:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab0I3UFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 16:05:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54644 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448Ab0I3UFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 16:05:09 -0400
Received: by pwj5 with SMTP id 5so389258pwj.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 13:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WFvgtKbL9MuBgRjAq0sfwuhvdvLT7LAXfRZsFKQFbzU=;
        b=n0b/gg7srfDV+6H/MdFu6AmoHSc6oLOsIYvNCj52OSpYfdflnm2gbtAsKUeVdosXk0
         m3WfdBEoVcDBINV243NOdvoQgBPO8VMQBLNH3fyl7eHBJWbJorU9NPYWFV2NmUfChigs
         whVbLK5fVOm0gXSYGejRj1X+m1zyUFMFLEno4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H9W9EhOG4YXL1Ra7PMkPIgIkKDxlen+02OTmInCCdPKPCrriyQk3iCVNa+VvaaQozM
         Zc5acf28Mcsgzn2icDV8iugddUSm0+gB5hj8o7GVT+Br72iAIrDD24LrrcSpKqmXA0Eq
         EvqszMaXG5v8MxyaNTfpF0UGrgRKNTItuHvMs=
Received: by 10.114.78.1 with SMTP id a1mr4959522wab.216.1285877108860;
        Thu, 30 Sep 2010 13:05:08 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id c24sm362759wam.19.2010.09.30.13.05.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 13:05:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a.dirty
In-Reply-To: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157709>

Although Git interally has the facility to differentiate between
porcelain and plubmbing commands and appropriately print errors,
several shell scripts invoke plubming commands triggering cryptic
plumbing errors to be displayed on a porcelain interface. This patch
replaces the "needs update" message in git-pull and git-rebase, when
`git update-index` is run, with a more friendly message.

Reported-by: Joshua Jensen <jjensen@workspacewhiz.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-pull.sh                |    5 +----
 git-rebase--interactive.sh |   21 +++++----------------
 git-rebase.sh              |   14 +-------------
 3 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 8eb74d4..a15b545 100755
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
index a27952d..9546975 100755
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
 
@@ -557,12 +549,9 @@ do_next () {
 			exit "$status"
 		fi
 		# Run in subshell because require_clean_work_tree can die.
-		if ! (require_clean_work_tree)
+		if ! (require_clean_work_tree "rebase")
 		then
-			warn "Commit or stash your changes, and then run"
-			warn
-			warn "	git rebase --continue"
-			warn
+			warn "Then run git rebase --continue."
 			exit 1
 		fi
 		;;
@@ -740,7 +729,7 @@ do
 			die "Cannot read HEAD"
 		git update-index --ignore-submodules --refresh &&
 			git diff-files --quiet --ignore-submodules ||
-			die "Working tree is dirty"
+			die "Working tree is dirty. Please commit or stash your changes to proceed."
 
 		# do we have anything to commit?
 		if git diff-index --cached --quiet --ignore-submodules HEAD --
@@ -768,7 +757,7 @@ first and then run 'git rebase --continue' again."
 
 		record_in_rewritten "$(cat "$DOTEST"/stopped-sha)"
 
-		require_clean_work_tree
+		require_clean_work_tree "rebase"
 		do_rest
 		;;
 	--abort)
@@ -866,7 +855,7 @@ first and then run 'git rebase --continue' again."
 
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
