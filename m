From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 2/2] pull --rebase: Avoid spurious conflicts and reapplying unnecessary patches
Date: Sun,  8 Aug 2010 14:55:17 -0600
Message-ID: <1281300917-5610-3-git-send-email-newren@gmail.com>
References: <1281300917-5610-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, santi@agolina.net, Johannes.Schindelin@gmx.de,
	avarab@gmail.com, Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 08 22:47:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiCmi-00067j-EA
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 22:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab0HHUrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 16:47:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59942 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab0HHUrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 16:47:40 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so3455744pxi.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gCN8ioQ6lWvy2aFtzDVsya1wRlh4/ZVOsAXUHuddR1o=;
        b=tT9i272gDYZDJr/CSXUTULvm1d0qQC7Y7tvBNNivEXfnx2VgdNrsFTfDrj4yialyF5
         UqMmkAQan3ICd7r529goij/mNEOoUAfa0jsslTCpR74hWc77VxL2RVqd2AFzvrUKayTi
         RarJN3xIV/rQJ/RqtNtzOv5YybrBa5CW0rTEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mFJVNINMccXUALU965iJ3op79DA8LVHx05ONVqGUZlBXA4nqAs3wHYzLERD7+2uYQu
         D+VsDInSAPNbebXiZHBMjDHIf9nPc/Dj66k2QuelWcfcamS8V2/SVUoJ6N7YlskxcE/H
         Z3Q0RpggqDHcOqfjLhQeaIUM3kUjAl93CoXKQ=
Received: by 10.142.194.15 with SMTP id r15mr12818793wff.31.1281300460221;
        Sun, 08 Aug 2010 13:47:40 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id q27sm5555628wfc.18.2010.08.08.13.47.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 13:47:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.28.ga5061
In-Reply-To: <1281300917-5610-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152929>

Prior to c85c79279df2c8a583d95449d1029baba41f8660, pull --rebase would run
  git rebase $merge_head
which resulted in a call to
  git format-patch ... --ignore-if-in-upstream $merge_head..$cur_branch

This resulted in patches from $merge_head..$cur_branch being applied, as
long as they did not already exist in $cur_branch..$merge_head.
Unfortunately, when upstream is rebased, $merge_head..$cur_branch also
refers to "old" commits that have already been rebased upstream, meaning
that many patches that were already fixed upstream would be reapplied.
This could result in many spurious conflicts, as well as reintroduce
patches that were intentionally dropped upstream.

So the algorithm was changed in c85c79279df2c8a583d95449d1029baba41f8660
and d44e71261f91d3cc81293e0976bb40daa8abb583.  Defining $old_remote_ref to
be the most recent entry in the reflog for @{upstream} that is an ancestor
of $cur_branch, pull --rebase was changed to run
  git rebase --onto $merge_head $old_remote_ref
which results in a call to
  git format-patch ... --ignore-if-in-upstream $old_remote_ref..$cur_branch

The whole point of this change was to reduce the number of commits being
reapplied, by avoiding commits that upstream already has or had.

In the rebased upstream case, this change achieved that purpose.  It is
worth noting, though, that since $old_remote_ref is always an ancestor of
$cur_branch (by its definition), format-patch will not know what upstream
is and thus will not be able to determine if any patches are already
upstream; they will all be reapplied.

In the non-rebased upstream case, this new form is usually the same as the
original code but in some cases $old_remote_ref can be an ancestor of
   $(git merge-base $merge_head $cur_branch)
meaning that instead of avoiding reapplying commits that upstream already
has, it actually includes more such commits.  Combined with the fact that
format-patch can no longer detect commits that are already upstream (since
it is no longer told what upstream is), results in lots of confusion for
users (e.g. "git is giving me lots of conflicts in stuff I didn't even
change since my last push.")

Fix the non-rebased upstream case by ignoring $old_remote_ref whenever it
is contained in $(git merge-base $merge_head $cur_branch).  This should
have no affect on the rebased upstream case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Note that 24 lines of the patch are simply due to moving 12 lines; I
considered leaving those 12 lines where they were, but it'd split the
code that handles the setting of oldremoteref, which I thought should
be together.  I couldn't place the new code earlier, because it
depends on the definition of $merge_head.  I'd be happy to reshuffle
differently if anyone has any strong preferences.

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
index 9099e55..0e5d097 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -187,7 +187,7 @@ test_expect_success 'setup for detecting upstreamed changes' '
 	)
 '
 
-test_expect_failure 'git pull --rebase detects upstreamed changes' '
+test_expect_success 'git pull --rebase detects upstreamed changes' '
 	(cd dst &&
 	 git pull --rebase &&
 	 test -z "$(git ls-files -u)"
@@ -216,7 +216,7 @@ test_expect_success 'setup for avoiding reapplying old patches' '
 	)
 '
 
-test_expect_failure 'git pull --rebase does not reapply old patches' '
+test_expect_success 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
 	 git pull --rebase;
 	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
-- 
1.7.2.1
