From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and reapplying unnecessary patches
Date: Wed, 11 Aug 2010 23:56:09 -0600
Message-ID: <1281592569-740-3-git-send-email-newren@gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, santi@agolina.net, Johannes.Schindelin@gmx.de,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 07:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjQeJ-00079X-FA
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 07:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab0HLFsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 01:48:14 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59497 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab0HLFsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 01:48:12 -0400
Received: by mail-qw0-f46.google.com with SMTP id 6so1046824qwh.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 22:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/NVRJOPMDh9T4tiMZJxAj0orlRqj0RhYrSdeXYtGMsg=;
        b=B74HeX/GD9C4IM3OhS8c2oEuNdnR3jQ/yJNWgThXVPYJkYPnqHujqpvECLYEKXDC5Q
         LwGnOutATQZzovTlISTowVNC3QguYNIV79xiLkSL4QeVw6x06fNnQkl7HtpUjN9BZ4bV
         EXIDmD/BSr8KRxRi94aicXMPQ8aQAUj+FkPJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GiYFnIB8do5V6enkrP4mYcFkufTe3wk5Ui/ncfGmm0p5r2QQsx3jMhoESenOG8JdZQ
         2xLQ7eURp3g2rwcL7Ni5xJvryoWYArR1cAxgSq7oCTNVT5YscLuig1xp9iEivVbou8G1
         dzgw6HpWLVxsEZrf8quEdTQ328HrJOySW/32U=
Received: by 10.224.20.2 with SMTP id d2mr11498855qab.101.1281592091580;
        Wed, 11 Aug 2010 22:48:11 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t24sm1436480qcs.47.2010.08.11.22.48.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 22:48:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.43.gbae63
In-Reply-To: <1281592569-740-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153342>

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
index 85a6b23..0b489f5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -186,7 +186,7 @@ test_expect_success 'setup for detecting upstreamed changes' '
 	)
 '
 
-test_expect_failure 'git pull --rebase detects upstreamed changes' '
+test_expect_success 'git pull --rebase detects upstreamed changes' '
 	(cd dst &&
 	 git pull --rebase &&
 	 test -z "$(git ls-files -u)"
@@ -215,7 +215,7 @@ test_expect_success 'setup for avoiding reapplying old patches' '
 	)
 '
 
-test_expect_failure 'git pull --rebase does not reapply old patches' '
+test_expect_success 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
 	 test_must_fail git pull --rebase &&
 	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
-- 
1.7.2.1.43.gbae63
