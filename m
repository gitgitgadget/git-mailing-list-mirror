From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3] Porcelain scripts: Rewrite cryptic "needs update" error message
Date: Tue, 19 Oct 2010 20:09:28 +0530
Message-ID: <1287499168-26569-1-git-send-email-artagnon@gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 19 16:40:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8DMj-00063r-Il
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 16:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab0JSOkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 10:40:25 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38558 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab0JSOkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 10:40:24 -0400
Received: by gwb19 with SMTP id 19so52302gwb.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6/YSAqVdjwISuEpwJt+LA5fJMxyZHLtaGBqPlFInMBA=;
        b=W73hYZvgQYu7ulMBnYvi5qudJNqmb2RvNQpW+GweN4idD/VyznrzgWzgAU7R/6l+Vv
         JfRtFLjCS2PA1aAh3SLUMiDU/cEibDMifmBFf6cXSGms2cDv2SebJmxUx1Za9GndmNrc
         OE0r/BGL+zpTWVWbLQrNXuwMTeMgJQi13w++o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VlpDD7IX97sdlBQvvFbYvsGU6JZG16DHCKCESNrzJ5nNiLNRv19C2zD9/dTQ3Bg04V
         8af3rSEONFXK0Vxs89UecTCfka/Rr3JX16y+QOw+q9AfQHHhwH/JIzgnOywwyWbeHXsd
         RPG1JLAuaNGxoEa75B4Ll6tYL2UNBk3vdroBY=
Received: by 10.42.219.135 with SMTP id hu7mr489031icb.85.1287499222936;
        Tue, 19 Oct 2010 07:40:22 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id x51sm9145832yhc.19.2010.10.19.07.40.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 07:40:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a.dirty
In-Reply-To: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159332>

Although Git interally has the facility to differentiate between
porcelain and plubmbing commands and appropriately print errors,
several shell scripts invoke plubming commands triggering cryptic
plumbing errors to be displayed on a porcelain interface. This patch
replaces the "needs update" message in git-pull and git-rebase, when
`git update-index` is run, with a more friendly message.

Reported-by: Joshua Jensen <jjensen@workspacewhiz.com>
Reported-by: Thore Husfeldt <thore.husfeldt@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Ref: <1285877017-8060-1-git-send-email-artagnon@gmail.com> for v2.
 Ref: <1285514516-5112-1-git-send-email-artagnon@gmail.com> for v1.

 Thanks to Matthieu for reviewing v1 and Junio for reviewing v2: I've
 tried to attack the problem more conservatively in this patch. It
 doesn't list paths, and doesn't print "generic" advice.

 git-pull.sh                |    5 +----
 git-rebase--interactive.sh |   14 +++-----------
 git-rebase.sh              |   14 +-------------
 git-sh-setup.sh            |   29 +++++++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 8eb74d4..20a3bbe 100755
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
+		require_clean_work_tree "pull with rebase" "Please commit or stash them."
 	fi
 	oldremoteref= &&
 	. git-parse-remote &&
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a27952d..4d8a2a0 100755
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
+		require_clean_work_tree "rebase" "Please commit or stash them."
 
 		if test ! -z "$1"
 		then
diff --git a/git-rebase.sh b/git-rebase.sh
index e5df23b..988b3d8 100755
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
+require_clean_work_tree "rebase" "Please commit or stash them."
 
 if test -z "$rebase_root"
 then
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ae031a1..aa16b83 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -145,6 +145,35 @@ require_work_tree () {
 	die "fatal: $0 cannot be used without a working tree."
 }
 
+require_clean_work_tree () {
+	git rev-parse --verify HEAD >/dev/null || exit 1
+	git update-index -q --ignore-submodules --refresh
+	err=0
+
+	if ! git diff-files --quiet --ignore-submodules
+	then
+		echo >&2 "Cannot $1: You have unstaged changes."
+		err=1
+	fi
+
+	if ! git diff-index --cached --quiet --ignore-submodules HEAD --
+	then
+		if [ $err = 0 ]
+		then
+		    echo >&2 "Cannot $1: Your index contains uncommitted changes."
+		else
+		    echo >&2 "Additionally, your index contains uncommitted changes."
+		fi
+		err=1
+	fi
+
+	if [ $err = 1 ]
+	then
+		test -n "$2" && echo >&2 "$2"
+		exit 1
+	fi
+}
+
 get_author_ident_from_commit () {
 	pick_author_script='
 	/^author /{
-- 
1.7.2.2.409.gdbb11.dirty
