From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 6/6] pull: only allow ff merges by default
Date: Tue, 29 Apr 2014 06:17:06 -0500
Message-ID: <1398770226-9686-7-git-send-email-felipe.contreras@gmail.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 13:28:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf6Ct-0004pG-9P
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933915AbaD2L2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:28:09 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:57624 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933788AbaD2L2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:28:06 -0400
Received: by mail-yk0-f173.google.com with SMTP id 131so42048ykp.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 04:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vocg1AxsLZvbMIP44oViAtgL/m1OgpKqtwd8svFM9eQ=;
        b=PvrE2tylP8QtAaMH+639iVdYlKPuHPmCvFGPlJFsAvW3WiwSAT3kyakzH9cTAUr6Tr
         6Wugc9o8xNJNVpJLesedCQsrySfW8m4vnrTl/Tqr7ofrcXeoP8lB+rrPmPbmAz+6Zzpq
         de6A9xTkxlYY04wfqPNlTKGos5IJ+tl62dDrjDkQRQ/YJXJ/oG5igWXa3J474mTNcMx7
         +48YPyiBPXY2hIMCdHBvqjIfKVS4IzOt64Sc/Te1Rx67e+127wQSMqqXBtJJvC8Y8+tR
         3rDoJxh9/b4zsjsfkwE+PORBaUBx32Zw28bmC8y2hFh+4ZHwnYEnrUFrFtOAapSgKOWa
         Vmlw==
X-Received: by 10.236.26.193 with SMTP id c41mr1471596yha.151.1398770885905;
        Tue, 29 Apr 2014 04:28:05 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id p68sm36141606yho.10.2014.04.29.04.28.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 04:28:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247573>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   | 18 ++++++++++++++++++
 git-pull.sh                  |  2 +-
 t/t4013-diff-various.sh      |  2 +-
 t/t5500-fetch-pack.sh        |  2 +-
 t/t5524-pull-msg.sh          |  2 +-
 t/t5700-clone-reference.sh   |  4 ++--
 t/t6022-merge-rename.sh      | 20 ++++++++++----------
 t/t6026-merge-attr.sh        |  2 +-
 t/t6029-merge-subtree.sh     |  6 +++---
 t/t6037-merge-ours-theirs.sh | 10 +++++-----
 10 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 767bca3..ca8e951 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -23,6 +23,7 @@ More precisely, 'git pull' runs 'git fetch' with the given
 parameters and calls 'git merge' to merge the retrieved branch
 heads into the current branch.
 With `--rebase`, it runs 'git rebase' instead of 'git merge'.
+With `--merge`, it forces the merge, even if it's non-fast forward.
 
 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
@@ -41,11 +42,28 @@ Assume the following history exists and the current branch is
 ------------
 	  A---B---C master on origin
 	 /
+    D---E master
+------------
+
+Then `git pull` will merge in a fast-foward way up to the new master.
+
+------------
+    D---E---A---B---C master, origin/master
+------------
+
+However, a non-fast-foward case looks very different.
+
+------------
+	  A---B---C origin/master
+	 /
     D---E---F---G master
 	^
 	origin/master in your repository
 ------------
 
+By default `git pull` will fail on these situations, however, most likely
+you would want to force a merge, which you can do with `git pull --merge`.
+
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
 until its current commit (`C`) on top of `master` and record the
diff --git a/git-pull.sh b/git-pull.sh
index 946cbbe..8cf8f68 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -83,7 +83,7 @@ then
 		warn "$(gettext "Please use pull.mode and branch.<name>.pullmode instead.")"
 	fi
 fi
-test -z "$mode" && mode=merge
+test -z "$mode" && mode=merge-ff-only
 dry_run=
 while :
 do
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e77c09c..1840767 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -64,7 +64,7 @@ test_expect_success setup '
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
 	git checkout master &&
-	git pull -s ours . side &&
+	git pull --merge -s ours . side &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:05:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:05:00 +0000" &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 5b2b1c2..f735cfe 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -259,7 +259,7 @@ test_expect_success 'clone shallow object count' '
 test_expect_success 'pull in shallow repo with missing merge base' '
 	(
 		cd shallow &&
-		test_must_fail git pull --depth 4 .. A
+		test_must_fail git pull --merge --depth 4 .. A
 	)
 '
 
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index 8cccecc..ec9f413 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 test_expect_success pull '
 (
 	cd cloned &&
-	git pull --log &&
+	git pull --merge --log &&
 	git log -2 &&
 	git cat-file commit HEAD >result &&
 	grep Dollar result
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 6537911..306badf 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -94,7 +94,7 @@ cd "$base_dir"
 
 test_expect_success 'pulling changes from origin' \
 'cd C &&
-git pull origin'
+git pull --merge origin'
 
 cd "$base_dir"
 
@@ -109,7 +109,7 @@ cd "$base_dir"
 
 test_expect_success 'pulling changes from origin' \
 'cd D &&
-git pull origin'
+git pull --merge origin'
 
 cd "$base_dir"
 
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index a89dfbe..f63300f 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -100,7 +100,7 @@ git checkout master'
 test_expect_success 'pull renaming branch into unrenaming one' \
 '
 	git show-branch &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --merge . white &&
 	git ls-files -s &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
@@ -118,7 +118,7 @@ test_expect_success 'pull renaming branch into another renaming one' \
 	rm -f B &&
 	git reset --hard &&
 	git checkout red &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --merge . white &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
 	git ls-files -s N >n.stages &&
@@ -134,7 +134,7 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . master &&
+	test_expect_code 1 git pull --merge . master &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
 	git ls-files -s N >n.stages &&
@@ -150,7 +150,7 @@ test_expect_success 'pull conflicting renames' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . blue &&
+	test_expect_code 1 git pull --merge . blue &&
 	git ls-files -u A >a.stages &&
 	test_line_count = 1 a.stages &&
 	git ls-files -u B >b.stages &&
@@ -170,7 +170,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git reset --hard &&
 	git show-branch &&
 	echo >A this file should not matter &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --merge . white &&
 	test_path_is_file A
 '
 
@@ -180,7 +180,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git show-branch &&
 	rm -f A &&
 	echo >A this file should not matter &&
-	test_expect_code 1 git pull . red &&
+	test_expect_code 1 git pull --merge . red &&
 	test_path_is_file A
 '
 
@@ -190,7 +190,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git checkout -f master &&
 	git tag -f anchor &&
 	git show-branch &&
-	git pull . yellow &&
+	git pull --merge . yellow &&
 	test_path_is_missing M &&
 	git reset --hard anchor
 '
@@ -203,7 +203,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	git show-branch &&
 	echo >>M one line addition &&
 	cat M >M.saved &&
-	test_expect_code 128 git pull . yellow &&
+	test_expect_code 128 git pull --merge . yellow &&
 	test_cmp M M.saved &&
 	rm -f M.saved
 '
@@ -217,7 +217,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	echo >>M one line addition &&
 	cat M >M.saved &&
 	git update-index M &&
-	test_expect_code 128 git pull . yellow &&
+	test_expect_code 128 git pull --merge . yellow &&
 	test_cmp M M.saved &&
 	rm -f M.saved
 '
@@ -229,7 +229,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git tag -f anchor &&
 	git show-branch &&
 	echo >M this file should not matter &&
-	git pull . master &&
+	git pull --merge . master &&
 	test_path_is_file M &&
 	! {
 		git ls-files -s |
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 5e43997..5428f19 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -172,7 +172,7 @@ test_expect_success 'up-to-date merge without common ancestor' '
 	test_tick &&
 	(
 		cd repo1 &&
-		git pull ../repo2 master
+		git pull --merge ../repo2 master
 	)
 '
 
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 73fc240..0e626d1 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -69,7 +69,7 @@ test_expect_success 'merge update' '
 	git checkout -b master2 &&
 	git commit -m "update git-gui" &&
 	cd ../git &&
-	git pull -s subtree gui master2 &&
+	git pull --merge -s subtree gui master2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh"
@@ -98,7 +98,7 @@ test_expect_success 'initial ambiguous subtree' '
 test_expect_success 'merge using explicit' '
 	cd ../git &&
 	git reset --hard master2 &&
-	git pull -Xsubtree=git-gui gui master2 &&
+	git pull --merge -Xsubtree=git-gui gui master2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh"
@@ -111,7 +111,7 @@ test_expect_success 'merge using explicit' '
 test_expect_success 'merge2 using explicit' '
 	cd ../git &&
 	git reset --hard master2 &&
-	git pull -Xsubtree=git-gui2 gui master2 &&
+	git pull --merge -Xsubtree=git-gui2 gui master2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	git-gui/git-gui.sh"
diff --git a/t/t6037-merge-ours-theirs.sh b/t/t6037-merge-ours-theirs.sh
index 3889eca..8e67d2a 100755
--- a/t/t6037-merge-ours-theirs.sh
+++ b/t/t6037-merge-ours-theirs.sh
@@ -66,11 +66,11 @@ test_expect_success 'binary file with -Xours/-Xtheirs' '
 '
 
 test_expect_success 'pull passes -X to underlying merge' '
-	git reset --hard master && git pull -s recursive -Xours . side &&
-	git reset --hard master && git pull -s recursive -X ours . side &&
-	git reset --hard master && git pull -s recursive -Xtheirs . side &&
-	git reset --hard master && git pull -s recursive -X theirs . side &&
-	git reset --hard master && test_must_fail git pull -s recursive -X bork . side
+	git reset --hard master && git pull -m -s recursive -Xours . side &&
+	git reset --hard master && git pull -m -s recursive -X ours . side &&
+	git reset --hard master && git pull -m -s recursive -Xtheirs . side &&
+	git reset --hard master && git pull -m -s recursive -X theirs . side &&
+	git reset --hard master && test_must_fail git pull -m -s recursive -X bork . side
 '
 
 test_done
-- 
1.9.2+fc1.3.gade8541
