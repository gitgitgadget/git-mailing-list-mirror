From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] pull: reject non-ff pulls by default
Date: Sat, 31 Aug 2013 17:38:10 -0500
Message-ID: <1377988690-23460-4-git-send-email-felipe.contreras@gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 00:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFtsw-0007Ce-CY
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 00:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab3HaWnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 18:43:05 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:42825 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520Ab3HaWnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 18:43:00 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so3783829oag.26
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pMm44rvy7aagcmy3m2mKlBFJNGFOYVGXQDq7QNvOicU=;
        b=HIJdiDFh058bSMA4PWwU27O/YSHZksLoj+dab8QlTOW1OzB3gv+/OpWEmDhlVwZaO0
         Nq2ddAIRztFDlveDgxS3VyYuvhoE10mjTikDFxD5xMviuc7ykB6bD04uw0IYgVRjxKJb
         DLZQMgwCApyWJh2axEhk8/H7otEXS4kBhlGFCj6ay452/rhLu2ip9b3C2EczUKDuQKrT
         4At12olErPYRYGqluGunEnUPHDNtC4Jy7piJfvn36Ji2u3cdpfVqt7IkOJc5EmLJ8rsr
         A3zaCCB5iCXp/c4mLm1D4pqGfkPzzNF5hDPKgtFk2Ux/bDx0D+zxkx1KEZTC6RLw271E
         25cQ==
X-Received: by 10.182.101.165 with SMTP id fh5mr11949740obb.58.1377988979537;
        Sat, 31 Aug 2013 15:42:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm5381253obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 31 Aug 2013 15:42:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
In-Reply-To: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233557>

For the full discussion:

http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225305

The user still can specify 'git pull --merge' to restore the old
behavior, or 'git config pull.rebase false'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt    |  1 +
 builtin/merge.c               |  9 ++++++++-
 git-pull.sh                   |  9 ++++++++-
 t/t5500-fetch-pack.sh         |  2 +-
 t/t5520-pull.sh               | 33 +++++++++++++++++++++++++++++++++
 t/t5524-pull-msg.sh           |  2 +-
 t/t5700-clone-reference.sh    |  4 ++--
 t/t6022-merge-rename.sh       | 20 ++++++++++----------
 t/t6026-merge-attr.sh         |  2 +-
 t/t6029-merge-subtree.sh      |  4 ++--
 t/t6037-merge-ours-theirs.sh  | 10 +++++-----
 t/t7603-merge-reduce-heads.sh |  2 +-
 12 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 6ef8d59..1833779 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -119,6 +119,7 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
+--merge::
 --no-rebase::
 	Override earlier --rebase.
 
diff --git a/builtin/merge.c b/builtin/merge.c
index da9fc08..97b4205 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1437,8 +1437,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (fast_forward == FF_ONLY)
+	if (fast_forward == FF_ONLY) {
+		const char *msg = getenv("GIT_MERGE_FF_ONLY_HELP");
+		if (msg) {
+			fprintf(stderr, "%s\n", msg);
+			ret = 1;
+			goto done;
+		}
 		die(_("Not possible to fast-forward, aborting."));
+	}
 
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
diff --git a/git-pull.sh b/git-pull.sh
index f0df41c..c6b576b 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -113,7 +113,8 @@ do
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
 		rebase=true
 		;;
-	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
+	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase|\
+	-m|--m|--me|--mer|--merg|--merge)
 		rebase=false
 		;;
 	--recurse-submodules)
@@ -289,6 +290,12 @@ then
 	fi
 fi
 
+if test -z "$rebase$no_ff$ff_only${squash#--no-squash}"
+then
+	ff_only=--ff-only
+	export GIT_MERGE_FF_ONLY_HELP="The pull was not fast-forward, please either merge or rebase."
+fi
+
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index fd2598e..f1a068f 100755
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
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ed4d9c8..c0c50a2 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -284,4 +284,37 @@ test_expect_success 'git pull --rebase against local branch' '
 	test file = "$(cat file2)"
 '
 
+test_expect_success 'git pull fast-forward' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	git checkout -b other master &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull
+'
+
+test_expect_success 'git pull non-fast-forward' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git pull
+'
+
+test_expect_success 'git pull non-fast-forward (merge)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull --merge
+'
+
 test_done
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
index c680f78..6c7fdc1 100755
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
index 73fc240..0eeec04 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
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
index 3889eca..927e67c 100755
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
+	git reset --hard master && git pull --merge -s recursive -Xours . side &&
+	git reset --hard master && git pull --merge -s recursive -X ours . side &&
+	git reset --hard master && git pull --merge -s recursive -Xtheirs . side &&
+	git reset --hard master && git pull --merge -s recursive -X theirs . side &&
+	git reset --hard master && test_must_fail git pull --merge -s recursive -X bork . side
 '
 
 test_done
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 9894895..566b1c1 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -68,7 +68,7 @@ test_expect_success 'merge c1 with c2, c3, c4, c5' '
 
 test_expect_success 'pull c2, c3, c4, c5 into c1' '
 	git reset --hard c1 &&
-	git pull . c2 c3 c4 c5 &&
+	git pull --merge . c2 c3 c4 c5 &&
 	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
 	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
-- 
1.8.4-337-g7358a66-dirty
