From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 26/27] rebase -i: refuse to commit when resuming with updated head
Date: Mon, 18 Aug 2014 23:23:09 +0200
Message-ID: <e4a115adb51335f197ba5b35437dce8dfa3e363d.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPt-0000iP-IX
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbaHRVYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:34 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:43035 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbaHRVY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:29 -0400
Received: by mail-la0-f45.google.com with SMTP id ty20so5130029lab.4
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZlH4V4RWO9P9d4JAcJPPPEYGaurI8gaJeOGQcaC/rDw=;
        b=Lk24VUApoMKfdI8EuU7ceTsNkKcxErnqM9IaVG1UVp3qQ/hRmNMkZF+OVHOyQcqRN+
         Ao5iBQk3FRbNOfKclmRYWfxnTeE3WOYkVxDRHYg+fTC0YRWE5VpN5Obd5UUJ7iRAjAsx
         QYvkr9DfcieNfXCuxrWVlB9LL+ALz6TCVvfgGvHUZZS+2GA7sMfYPndQcNvQ4T+O3kH8
         TuXVrEZ19LKD3ZE+Q19QMSujm5uWpWBJzup10xgKc4z48ZdOWwhKDEkdyysO8i3y/+Cm
         +rPNxPvd7omoc5ectF2FicCb0OzOEYqxQJZ6PMFVmCv2l8wWRN75Ql/BrY9zKhb1lgXu
         Cm+A==
X-Received: by 10.112.158.199 with SMTP id ww7mr30566858lbb.71.1408397067914;
        Mon, 18 Aug 2014 14:24:27 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:26 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255426>

If git-rebase--interactive fails to apply the changes introduced by a
commit due to conflicts, it interrupts the rebase process and gives
the user a shell to resolve the conflicts manually. The process is
resumed when the user executes `git rebase --continue`. If the index
has changes, the script assumes that those are to be committed under
the authorship and with the log message of the commit it tried to
replay last. However, that assumption is most likely incorrect if the
user has already committed the resolved changes herself. To prevent
committing unrelated changes under the wrong authorship and with the
wrong log message, at least check that HEAD is still at the same
commit by tracking the hash of the last replayed commit. A similar
check already happens before `git rebase --continue` amends the
previous commit after an `edit` or a conflicted `squash` command.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    | 35 +++++++++++++++++++++--------------
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8fbfe6d..51ee80c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -62,13 +62,18 @@ msgnum="$state_dir"/msgnum
 # being rebased.
 author_script="$state_dir"/author-script
 
-# When an "edit" rebase command is being processed, the SHA1 of the
-# commit to be edited is recorded in this file.  The same happens when
-# rewriting a root commit fails, for instance "reword".  When "git
-# rebase --continue" is executed, if there are any staged changes then
-# they will be amended to the HEAD commit, but only provided the HEAD
-# commit is still the commit to be edited.  When any other rebase
-# command is processed, this file is deleted.
+# This file keeps track of the SHA1 of the last replayed commit, the
+# new parent of the next commit being replayed. It is used to make
+# sure that "git rebase --continue" only commits resolved conflicts
+# or "edit" changes automatically.
+last_head="$state_dir"/last_head
+
+# When an "edit" or a "squash" rebase command is being processed, the
+# file 'amend' is created. When "git rebase --continue" is executed,
+# if there are any staged changes then they will be amended to the
+# HEAD commit, but only provided the HEAD commit is still the commit
+# to be edited or the squash commit. When any other rebase command is
+# processed, these files are deleted.
 amend="$state_dir"/amend
 
 # For the post-rewrite hook, we make a list of rewritten commits and
@@ -179,7 +184,8 @@ die_with_patch () {
 exit_with_patch () {
 	echo "$1" > "$state_dir"/stopped-sha
 	make_patch $1
-	git rev-parse --verify HEAD > "$amend"
+	>"$amend"
+	git rev-parse --verify HEAD >"$last_head"
 	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
 	warn "You can amend the commit now, with"
 	warn
@@ -535,7 +541,7 @@ do_pick () {
 			fi
 			rewrite=y
 			rewrite_amend=y
-			git rev-parse --verify HEAD >"$amend"
+			>"$amend"
 			;;
 		-F|--file)
 			if test $# -eq 0
@@ -572,7 +578,7 @@ do_pick () {
 	then
 		rewrite=y
 		rewrite_amend=y
-		git rev-parse --verify HEAD >"$amend"
+		>"$amend"
 
 		# Set the correct commit message and author info on the
 		# sentinel root before cherry-picking the original changes
@@ -734,6 +740,7 @@ do_replay () {
 
 do_next () {
 	rm -f "$msg" "$author_script" "$amend" || exit
+	git rev-parse --verify HEAD >"$last_head" || exit
 	read -r command args <"$todo"
 
 	case "$command" in
@@ -1031,13 +1038,13 @@ In both case, once you're done, continue with:
   git rebase --continue
 "
 		fi
-		if test -f "$amend"
-		then
-			current_head=$(git rev-parse --verify HEAD)
-			test "$current_head" = $(cat "$amend") ||
+		current_head=$(git rev-parse --verify HEAD)
+		test "$current_head" = $(cat "$last_head") ||
 			die "\
 You have uncommitted changes in your working tree. Please, commit them
 first and then run 'git rebase --continue' again."
+		if test -f "$amend"
+		then
 			git commit --amend --no-verify -F "$msg" -e \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die "Could not commit staged changes."
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c037a07..5955bd8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -444,6 +444,18 @@ test_expect_success '--continue tries to commit' '
 	git show HEAD | grep chouette
 '
 
+test_expect_success '--continue does not commit after head is moved' '
+	git reset --hard to-be-rebased@{1} &&
+	test_must_fail git rebase -i --onto new-branch1 HEAD^ &&
+	echo resolved >file1 &&
+	git add file1 &&
+	git commit &&
+	echo dirty >file1 &&
+	test_must_fail git rebase --continue &&
+	git checkout file1 &&
+	git rebase --continue
+'
+
 test_expect_success 'verbose flag is heeded, even after --continue' '
 	git reset --hard master@{1} &&
 	test_tick &&
-- 
2.0.1
