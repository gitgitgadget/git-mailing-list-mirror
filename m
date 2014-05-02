From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 7/7] pull: only allow ff merges by default
Date: Thu,  1 May 2014 19:00:08 -0500
Message-ID: <1398988808-29678-8-git-send-email-felipe.contreras@gmail.com>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 02:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg14c-00015g-Kh
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbaEBAL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:11:26 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:46576 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbaEBALZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 20:11:25 -0400
Received: by mail-oa0-f42.google.com with SMTP id i7so4370154oag.15
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nrFQD3Ic41wwdgqAECbQvCrnbels5RpsnsFq8bbJbwQ=;
        b=SOw162Ij0v5ZhflrslYDAF4cD6RIFEHc50VZ9L5m0f0+EIUPG62zSXGMtuHWF9hzKM
         FnQ9pYrDkUBeNHbB6MEXhJVzaJyPoZWH0yS2pJEs4sF+Hn7ea/waRIcc8GgRgBib5HZ8
         TJZmbj7WV5aVM/V7yR8DTect5yO7Pp4uLdhplskxI8bhKAVP+mXutgttLshRTBwHDGB+
         eLmhiUKbkfX34yvtnRX9mrqLyDFIkRbHJU1dGbzKz1SWD8eDBRUj1v4lChwiNsUbMW4X
         IcVVnJf7xUOwGKparTIAw7bxUT4TRvRh8AGyEKeGZMHGuKFmfqDnEoxioUF417ydRtfZ
         6krg==
X-Received: by 10.60.115.68 with SMTP id jm4mr4882997oeb.57.1398989485393;
        Thu, 01 May 2014 17:11:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm122939897oeb.11.2014.05.01.17.11.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 17:11:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.19.g85b6256
In-Reply-To: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247904>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   |  2 +-
 git-pull.sh                  | 15 +++------------
 t/t4013-diff-various.sh      |  2 +-
 t/t5500-fetch-pack.sh        |  2 +-
 t/t5520-pull.sh              |  5 +----
 t/t5524-pull-msg.sh          |  2 +-
 t/t5700-clone-reference.sh   |  4 ++--
 t/t6022-merge-rename.sh      | 20 ++++++++++----------
 t/t6026-merge-attr.sh        |  2 +-
 t/t6029-merge-subtree.sh     |  6 +++---
 t/t6037-merge-ours-theirs.sh | 10 +++++-----
 11 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index fe3d15d..968315c 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -61,7 +61,7 @@ However, a non-fast-foward case looks very different.
 	origin/master in your repository
 ------------
 
-By default `git pull` will warn about these situations, however, most likely
+By default `git pull` will fail on these situations, however, most likely
 you would want to force a merge, which you can do with `git pull --merge`.
 
 Then "`git pull`" will fetch and replay the changes from the remote
diff --git a/git-pull.sh b/git-pull.sh
index c4a0b08..bccaf27 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -78,7 +78,7 @@ then
 		rebase=$(bool_or_string_config pull.rebase)
 	fi
 fi
-test -z "$mode" && mode=default
+test -z "$mode" && mode=ff-only
 dry_run=
 while :
 do
@@ -317,22 +317,13 @@ case "$merge_head" in
 *)
 	# check if a non-fast-foward merge would be needed
 	merge_head=${merge_head% }
-	if test -z "$no_ff$ff_only${squash#--no-squash}" &&
+	if test "$mode" = 'ff-only' && test -z "$no_ff$ff_only${squash#--no-squash}" &&
 		test -n "$orig_head" &&
 		! git merge-base --is-ancestor "$orig_head" "$merge_head" &&
 		! git merge-base --is-ancestor "$merge_head" "$orig_head"
 	then
-		case "$mode" in
-		ff-only)
-			die "$(gettext "The pull was not fast-forward, please either merge or rebase.
+		die "$(gettext "The pull was not fast-forward, please either merge or rebase.
 If unsure, run 'git pull --merge'.")"
-			;;
-		default)
-			warn "$(gettext "the pull was not fast-forward, in the future you would have to choose
-a merge or a rebase, falling back to old style for now (git pull --merge).
-Read 'git pull --help' for more information.")" >&2
-			;;
-		esac
 	fi
 	;;
 esac
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
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c96834e..dc7749b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -409,10 +409,7 @@ test_expect_success 'git pull non-fast-forward (default)' '
 	git commit -m new &&
 	git checkout -b test -t other &&
 	git reset --hard master &&
-	git pull 2> error &&
-	cat error &&
-	grep -q "the pull was not fast-forward" error &&
-	grep -q "in the future you would have to choose" error
+	test_must_fail git pull
 '
 
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
1.9.2+fc1.19.g85b6256
