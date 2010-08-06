From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] pull --rebase: Avoid spurious conflicts and reapplying unnecessary patches
Date: Fri,  6 Aug 2010 08:05:03 -0600
Message-ID: <1281103503-27515-3-git-send-email-newren@gmail.com>
References: <1281103503-27515-1-git-send-email-newren@gmail.com>
Cc: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 16:03:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhNWR-00022O-PK
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 16:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211Ab0HFODd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 10:03:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42294 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab0HFODb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 10:03:31 -0400
Received: by eya25 with SMTP id 25so2768976eya.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OtOi9ISo5pF0s5Un4Sr4qGX5N5uP0YnAwWksm7OV/co=;
        b=wtMvBC9tXU5XaHqWw/s9sYU/MVjlTH4dmoKS3NrmAdM0a7Kaxhogn4i3+ZGwUa/kPu
         lHk9YjcMPyYEIBgEpw3fQeZ3s//6iE+XGkZJNw35gTnfH6WbLGcjeBPFAohBRHlOOuXd
         PA7bl+Y37MZ1d3/JR7nMJYDi9VAtvv/pGcVqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SfKP7SUFGYnFdX5yRfS61jiPXWSh7yeQpI8w2jJqCizuOgDEIAf2LtM2aulOYDTquv
         siwzrVvPN7FbTuIfowBPXo8jb+paOdhBXDftUcIewGv/FPY3WYoabBwDm1qa3n9JGebO
         Jmihya1ItQp/lCr2unqrBitsDIMDEqhcA/a1E=
Received: by 10.216.35.65 with SMTP id t43mr945812wea.34.1281103409420;
        Fri, 06 Aug 2010 07:03:29 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o84sm867954wej.13.2010.08.06.07.03.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 07:03:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1281103503-27515-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152783>

Prior to c85c79279df2c8a583d95449d1029baba41f8660, pull --rebase would run
  git rebase $merge_head
which resulted in a call to
  git format-patch ... --ignore-if-in-upstream $merge_head..$cur_branch

This had two nice qualities when upstream isn't rebased: (1) "only" the
patches in $merge_head..$cur_branch would be applied, and (2) patches
could be dropped/ignored if they had already been applied.  But this did
not work well when upstream is rebased, since in that case
$merge_head..$cur_branch refers to too many commits that would need to be
reapplied, and could result in intentionally dropped commits being
reintroduced.

So the algorithm was changed.  Defining $old_remote_ref to be the most
recent entry in the reflog for @upstream that is an ancestor of
$cur_branch, pull --rebase was changed (over time) to run
  git rebase --onto $merge_head $old_remote_ref
which results in a call to
  git format-patch ... --ignore-if-in-upstream $old_remote_ref..$cur_branch

In the rebased upstream case, this can result in far fewer commits being
included in the rebase, though the fact that $old_remote_ref is an ancestor
of $cur_branch means that format-patch will not know what upstream is and
will not be able to determine if any patches are already upstream.

In the non-rebased upstream case, this new form is usually the same as the
original code.  However, as noted above, the --ignore-if-in-upstream flag
becomes meaningless and all patches will be forced to be reapplied.  Also,
$old_remote_ref can be an ancestor of
   $(git merge-base $merge_head $cur_branch)
meaning that pull --rebase may try to reapply more patches which are
clearly already upstream, without the means to detect that they've already
been applied.  This can be extremely confusing for new users ("git is
giving me lots of conflicts in stuff I didn't even change since my last
push.")

Fix the non-rebased upstream case by ignoring $old_remote_ref whenever it
is contained by $(git merge-base $merge_head $cur_branch).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-pull.sh     |   34 ++++++++++++++++++++++------------
 t/t5520-pull.sh |    4 ++--
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index a09a44e..54da07b 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -206,18 +206,6 @@ test true = "$rebase" && {
 		git diff-index --ignore-submodules --cached --quiet HEAD -- ||
 		die "refusing to pull with rebase: your working tree is not up-to-date"
 	fi
-	oldremoteref= &&
-	. git-parse-remote &&
-	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
-	oldremoteref="$(git rev-parse -q --verify "$remoteref")" &&
-	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
-	do
-		if test "$reflog" = "$(git merge-base $reflog $curr_branch)"
-		then
-			oldremoteref="$reflog"
-			break
-		fi
-	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run --update-head-ok "$@" || exit 1
@@ -273,6 +261,28 @@ then
 	exit
 fi
 
+if test true = "$rebase"
+then
+	oldremoteref= &&
+	. git-parse-remote &&
+	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
+	oldremoteref="$(git rev-parse -q --verify "$remoteref")" &&
+	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
+	do
+		if test "$reflog" = "$(git merge-base $reflog $curr_branch)"
+		then
+			oldremoteref="$reflog"
+			break
+		fi
+	done
+
+	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
+	if test "$oldremoteref" = "$o"
+	then
+		unset oldremoteref
+	fi
+fi
+
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 8f76829..4bf2253 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -182,7 +182,7 @@ test_expect_success 'setup for detecting upstreamed changes' '
 	)
 '
 
-test_expect_failure 'git pull --rebase detects upstreamed changes' '
+test_expect_success 'git pull --rebase detects upstreamed changes' '
 	(cd dst &&
 	 git pull --rebase &&
 	 test -z "$(git ls-files -u)"
@@ -212,7 +212,7 @@ test_expect_success 'setup for avoiding reapplying old patches' '
 	)
 '
 
-test_expect_failure 'git pull --rebase does not reapply old patches' '
+test_expect_success 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
 	 (git pull --rebase || true) &&
 	 test 3 != $(find .git/rebase-apply -name "000*" | wc -l)
-- 
1.7.1.1
