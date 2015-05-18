From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 1/2] pull: handle git-fetch's options as well
Date: Mon, 18 May 2015 21:30:45 +0800
Message-ID: <1431955855-16228-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:31:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuL8j-0008Kj-AU
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbbERNbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:31:22 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34428 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbbERNbS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:31:18 -0400
Received: by pdbnk13 with SMTP id nk13so54464952pdb.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eKTWdHqUVM7TNrHSVAXiMzKIqoAB2OZP/1x3xSGp6Y4=;
        b=qrL3hhLbFNGFwm77rnXdzfvJikCnFdrV0TftYVuqJgGwwFRHmsOr7C1qQFTVoj3uBg
         HxIccALOE5oBRuyX8h4YniikLb5yoCbnw8GJCiRyX3UiRsBiRBygq2P8wC7fKb4KJaoy
         D1OfAukk1ZgBaytHeS1RvxCjL8zdT5YepTfDa1Eape1RLaI2VZKWcz8KJh1zD7sx1lAM
         bRYd+0qAvke08eYPLJWwU4/+BUf62qFxG6ZMIRxOHuo4thCAHxCAzGEv9ZBp15kAAOkF
         IBDMTWjYUclaqVJdXXlna9ZP5g+ffJVQ6LCE+Q/uLwSL9g1lsCGBr57Chzq2BWjftHqU
         T6DQ==
X-Received: by 10.70.131.132 with SMTP id om4mr44080458pdb.30.1431955877197;
        Mon, 18 May 2015 06:31:17 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id jz10sm10118688pbc.48.2015.05.18.06.31.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:31:16 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269235>

t5520: failing test for pull --all with no configured upstream
t5521: test pull --all --dry-run does not make any changes

error_on_no_merge_candidates() does not consider the case where "$#"
includes command-line flags that are passed to git-fetch.

As such, when the current branch has no configured upstream, and there
are no merge candidates because of that, git-pull --all erroneously reports
that we are pulling from "--all", as it believes that the first argument
is the remote name.

Add a failing test that shows this case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-pull.sh             | 34 ++++++++++++++++++++++++++++++++--
 t/t5520-pull.sh         | 20 ++++++++++++++++++++
 t/t5521-pull-options.sh | 14 ++++++++++++++
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 9ed01fd..28d49ab 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -163,11 +163,39 @@ do
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=--dry-run
 		;;
+	--all|--no-all)
+		all=$1 ;;
+	-a|--append|--no-append)
+		append=$1 ;;
+	--upload-pack=*|--no-upload-pack)
+		upload_pack="$1" ;;
+	-f|--force|--no-force)
+		force="$force $1" ;;
+	-t|--tags|--no-tags)
+		tags=$1 ;;
+	-p|--prune|--no-prune)
+		prune=$1 ;;
+	-k|--keep|--no-keep)
+		keep=$1 ;;
+	--depth=*|--no-depth)
+		depth="$1" ;;
+	--unshallow|--no-unshallow)
+		unshallow=$1 ;;
+	--update-shallow|--no-update-shallow)
+		update_shallow=$1 ;;
+	--refmap=*|--no-refmap)
+		refmap="$1" ;;
 	-h|--help-all)
 		usage
 		;;
+	--)
+		shift
+		break
+		;;
+	-*)
+		usage
+		;;
 	*)
-		# Pass thru anything that may be meant for fetch.
 		break
 		;;
 	esac
@@ -254,7 +282,9 @@ test true = "$rebase" && {
 	oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch 2>/dev/null)
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
+git fetch $verbosity $progress $dry_run $recurse_submodules $all $append \
+$upload_pack $force $tags $prune $keep $depth $unshallow $update_shallow \
+$refmap --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0
 
 curr_head=$(git rev-parse -q --verify HEAD)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 62dbfb5..ea73f2f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -160,6 +160,18 @@ test_expect_success 'fail if no configuration for current branch' '
 	test "$(cat file)" = file
 '
 
+test_expect_success 'pull --all: fail if no configuration for current branch' '
+	git remote add test_remote . &&
+	test_when_finished "git remote remove test_remote" &&
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test_config branch.test.remote test_remote &&
+	test "$(cat file)" = file &&
+	test_must_fail git pull --all 2>err &&
+	test_i18ngrep "There is no tracking information" err &&
+	test "$(cat file)" = file
+'
+
 test_expect_success 'fail if upstream branch does not exist' '
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
@@ -366,6 +378,14 @@ test_expect_success '--rebase with rebased upstream' '
 
 '
 
+test_expect_success '--rebase -f with rebased upstream' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git reset --hard to-rebase-orig &&
+	git pull --rebase -f me copy &&
+	test "conflicting modification" = "$(cat file)" &&
+	test file = "$(cat file2)"
+'
+
 test_expect_success '--rebase with rebased default upstream' '
 
 	git update-ref refs/remotes/me/copy copy-orig &&
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 56e7377..9d5e41f 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -130,4 +130,18 @@ test_expect_success 'git pull --dry-run' '
 	)
 '
 
+test_expect_failure 'git pull --all --dry-run' '
+	test_when_finished "rm -rf clonedmulti" &&
+	git init clonedry &&
+	(
+		cd clonedry &&
+		git remote add origin ../parent &&
+		git pull --all --dry-run &&
+		test_path_is_missing .git/FETCH_HEAD &&
+		test_path_is_missing .git/refs/remotes/origin/master &&
+		test_path_is_missing .git/index &&
+		test_path_is_missing file
+	)
+'
+
 test_done
-- 
2.1.4
