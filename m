From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Tue, 23 Apr 2013 19:32:04 +0530
Message-ID: <1366725724-1016-8-git-send-email-artagnon@gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:01:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUdmL-0001SN-9P
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912Ab3DWOAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:00:53 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36282 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab3DWOAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:00:52 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so515374pad.30
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2Izc0hQxRtRDEpEjh2q/INZ2QHGSDHWVN8FGENJrjqA=;
        b=Ai3PVK36wiCwAq689pbCqPnKLQ+OePnXOLXDrQPZsvTLr/CvL5DPkvN8DJ6xAS/Qt2
         /BYi+mt1Tuzwu/Nwx/GCOdOPLHr8lnBdCMzc84gw0PwHu3YWqhpT+44uMCEDmu58Ccie
         s6EqkFpYNIHxQU5DEtWIQaiaSaP/NbD5cB4+fTp+yDMaonDW/7ARc/jVW/6+O6F+dhL9
         Nslh1lCbaj/V4j6nSjRUwyTpLfD9gPUueb4574OUt+aVvl1e8159lbnemSBpAqOpAnGl
         ct33qgvZfNc/EuiabcAfqRUHkyK21d+zdYK3zqSw5gjbNMtEeoOKhNd8YYfzbzqkN5/2
         WdAQ==
X-Received: by 10.68.254.225 with SMTP id al1mr42061769pbd.69.1366725651718;
        Tue, 23 Apr 2013 07:00:51 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id vk7sm29634120pbc.41.2013.04.23.07.00.49
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 07:00:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.578.ga933817
In-Reply-To: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222164>

This new feature allows a rebase to be executed on a dirty worktree.
It works by creating a temporary stash and storing it in
$state_dir/autostash before the operation, and applying it after a
successful operation.  It will be removed along with the $state_dir if
the operation is aborted.

The feature creates a special stash that does not affect the normal
stash's reflogs, and will therefore be invisible to the end user.
This special stash is essentially a dangling merge commit which has
reasonable lifetime specified by gc.pruneexpire (default 2 weeks).

Most significantly, this feature means that a caller like pull (with
pull.rebase set to true) can easily be patched to remove the
require_clean_work_tree restriction.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt     |  8 ++++++++
 Documentation/git-rebase.txt | 10 ++++++++++
 git-rebase.sh                | 38 +++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c67038b..03ad701 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1867,6 +1867,14 @@ rebase.stat::
 rebase.autosquash::
 	If set to true enable '--autosquash' option by default.
 
+rebase.autostash::
+	When set to true, automatically create a temporary stash
+	before the operation begins, and apply it after the operation
+	ends.  This means that you can run rebase on a dirty worktree.
+	However, use with care: the final stash application after a
+	successful rebase might result in non-trivial conflicts.
+	Defaults to false.
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index aca8405..c84854a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -208,6 +208,9 @@ rebase.stat::
 rebase.autosquash::
 	If set to true enable '--autosquash' option by default.
 
+rebase.autostash::
+	If set to true enable '--autostash' option by default.
+
 OPTIONS
 -------
 --onto <newbase>::
@@ -394,6 +397,13 @@ If the '--autosquash' option is enabled by default using the
 configuration variable `rebase.autosquash`, this option can be
 used to override and disable this setting.
 
+--[no-]autostash::
+	Automatically create a temporary stash before the operation
+	begins, and apply it after the operation ends.  This means
+	that you can run rebase on a dirty worktree.  However, use
+	with care: the final stash application after a successful
+	rebase might result in non-trivial conflicts.
+
 --no-ff::
 	With --interactive, cherry-pick all rebased commits instead of
 	fast-forwarding over the unchanged ones.  This ensures that the
diff --git a/git-rebase.sh b/git-rebase.sh
index 8412d81..c8fddfe 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -13,6 +13,7 @@ git-rebase --continue | --abort | --skip | --edit-todo
  Available options are
 v,verbose!         display a diffstat of what changed upstream
 q,quiet!           be quiet. implies --no-stat
+autostash!         automatically stash/stash pop before and after
 onto=!             rebase onto given branch instead of upstream
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
@@ -64,6 +65,7 @@ apply_dir="$GIT_DIR"/rebase-apply
 verbose=
 diffstat=
 test "$(git config --bool rebase.stat)" = true && diffstat=t
+autostash="$(git config --bool rebase.autostash || echo false)"
 git_am_opt=
 rebase_root=
 force_rebase=
@@ -143,6 +145,24 @@ move_to_original_branch () {
 	esac
 }
 
+apply_autostash () {
+	if test -f "$state_dir/autostash"
+	then
+		stash_sha1=$(cat "$state_dir/autostash")
+		git stash apply $stash_sha1 2>&1 >/dev/null ||
+		die "
+$(eval_gettext 'Applying autostash resulted in conflicts.
+Either fix the conflicts now, or run
+	git reset --hard
+and apply the stash on your desired branch:
+	git stash apply $stash_sha1
+at any time.')" &&
+		echo "Applied autostash"
+	fi
+	git gc --auto &&
+	rm -rf "$state_dir"
+}
+
 run_specific_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
@@ -153,8 +173,7 @@ run_specific_rebase () {
 	ret=$?
 	if test $ret = 0
 	then
-		git gc --auto &&
-		rm -rf "$state_dir"
+		apply_autostash
 	fi
 	exit $ret
 }
@@ -248,6 +267,9 @@ do
 	--stat)
 		diffstat=t
 		;;
+	--autostash)
+		autostash=true
+		;;
 	-v)
 		verbose=t
 		diffstat=t
@@ -348,7 +370,7 @@ abort)
 		;;
 	esac
 	output git reset --hard $orig_head
-	rm -r "$state_dir"
+	apply_autostash
 	exit
 	;;
 edit-todo)
@@ -487,6 +509,16 @@ case "$#" in
 	;;
 esac
 
+if test "$autostash" = true && ! require_clean_work_tree --quiet
+then
+	stash_sha1=$(git stash create) || die "$(gettext "Cannot autostash")" &&
+	mkdir -p "$state_dir" &&
+	echo $stash_sha1 >"$state_dir/autostash" &&
+	stash_abbrev=$(git rev-parse --short $stash_sha1) &&
+	echo "$(gettext "Created autostash: $stash_abbrev")" &&
+	git reset --hard
+fi
+
 require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
 
 # Now we are rebasing commits $upstream..$orig_head (or with --root,
-- 
1.8.2.1.578.ga933817
