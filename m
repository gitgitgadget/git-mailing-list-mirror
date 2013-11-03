From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH 4/8] am: add the --gpg-sign option
Date: Sun,  3 Nov 2013 16:54:20 +0100
Message-ID: <1383494064-5653-5-git-send-email-boklm@mars-attacks.org>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 16:55:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd013-0007zG-3h
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 16:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab3KCPy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 10:54:56 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:35791 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab3KCPyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 10:54:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id B9C134E75
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 16:55:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id T4AxCbmOV7Dp; Sun,  3 Nov 2013 16:55:05 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 28E6B3ECC;
	Sun,  3 Nov 2013 16:55:04 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id C195A43934; Sun,  3 Nov 2013 16:54:47 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237266>

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 Documentation/git-am.txt | 6 +++++-
 git-am.sh                | 9 ++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 54d8461d61b2..17924d0f3ff3 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
-	 [--[no-]scissors]
+	 [--[no-]scissors] [-S[<keyid>]]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
 
@@ -119,6 +119,10 @@ default.   You can use `--no-utf8` to override this.
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+	GPG-sign commits.
+
 --continue::
 -r::
 --resolved::
diff --git a/git-am.sh b/git-am.sh
index 020abf6940bd..dccbae2af0de 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -38,6 +38,7 @@ abort           restore the original branch and abort the patching operation.
 committer-date-is-author-date    lie about committer date
 ignore-date     use current timestamp for author date
 rerere-autoupdate update the index with reused conflict resolution if possible
+S,gpg-sign?     GPG-sign commits
 rebasing*       (internal use for git-rebase)"
 
 . git-sh-setup
@@ -375,6 +376,7 @@ git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
 allow_rerere_autoupdate=
+gpg_sign_opt=
 
 if test "$(git config --bool --get am.keepcr)" = true
 then
@@ -436,6 +438,10 @@ it will be removed. Please do not use it anymore."
 		keepcr=t ;;
 	--no-keep-cr)
 		keepcr=f ;;
+	--gpg-sign)
+		gpg_sign_opt=-S ;;
+	--gpg-sign=*)
+		gpg_sign_opt="-S${1#--gpg-sign=}" ;;
 	--)
 		shift; break ;;
 	*)
@@ -900,7 +906,8 @@ did you forget to use 'git add'?"
 			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
 			export GIT_COMMITTER_DATE
 		fi &&
-		git commit-tree $tree ${parent:+-p} $parent <"$dotest/final-commit"
+		git commit-tree ${gpg_sign_opt:+"$gpg_sign_opt"} $tree ${parent:+-p} $parent \
+			<"$dotest/final-commit"
 	) &&
 	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
-- 
1.8.4.2
