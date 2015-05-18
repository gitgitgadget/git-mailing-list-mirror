From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 1/2] pull: handle git-fetch's options as well
Date: Mon, 18 May 2015 21:54:55 +0800
Message-ID: <1431957296-31534-2-git-send-email-pyokagan@gmail.com>
References: <1431957296-31534-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:55:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLVn-0002kN-AQ
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbbERNzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:55:12 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34010 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbbERNzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:55:10 -0400
Received: by pabru16 with SMTP id ru16so153493284pab.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pGc6uNzBRPDbmT00qW9rkQjCi/0I+eUf1eH+SMi+QP0=;
        b=BfbXI2aSAM2DwouSj5bzuVO1uIIQnk5RZiLmLzbDwsJa+Nxsi1wnmcT8QRAT7Y7VtQ
         PBAS6i92Ae+aBgqUQjfWiJOlK2aQ6Ebjv3m8WR8lVN77133IbumON6WHt9XtJSo6zk3t
         cKdrmCdLEw6CJbhN2Ztq7Srwo7b+HIIV4KpOga9Pd+MOExQZDJIpxMu3bmSgEgP5+p6p
         c8Y0X/yxYcMHVRivZoQax2eIsKg/X6Kn4UJMR9wU5MD0U2D428SU9Ssxoc+ICvqg+Thg
         7cedAGhIJzqRpUTyuNYh8oIlMVVUtj9rtj7Q8MPjriBNjlJzjWZGThJrogtUEA3waoB1
         S7Zg==
X-Received: by 10.68.125.130 with SMTP id mq2mr43661183pbb.121.1431957309643;
        Mon, 18 May 2015 06:55:09 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id v2sm10185365pdn.90.2015.05.18.06.55.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:55:08 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431957296-31534-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269251>

While parsing the command-line arguments, git-pull stops parsing at the
first unrecognized option, assuming that any subsequent options are for
git-fetch, and can thus be kept in the shell's positional parameters
list, so that it can be passed to git-fetch via the expansion of "$@".

However, certain functions in git-pull assume that the positional
parameters do not contain any options:

* error_on_no_merge_candidates() uses the number of positional
  parameters to determine which error message to print out, and will
  thus print the wrong message if git-fetch's options are passed in as
  well.

* the call to get_remote_merge_branch() assumes that the positional
  parameters only contains the optional repo and refspecs, and will
  thus silently fail if git-fetch's options are passed in as well.

* --dry-run is a valid git-fetch option, but if provided after any
  git-fetch options, it is not recognized by git-pull and thus git-pull
  will continue to run the merge or rebase.

Fix these bugs by teaching git-pull to parse git-fetch's options as
well. Add tests to prevent regressions.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-pull.sh             | 34 ++++++++++++++++++++++++++++++++--
 t/t5520-pull.sh         | 20 ++++++++++++++++++++
 t/t5521-pull-options.sh | 14 ++++++++++++++
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 5ff4545..633c385 100755
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
+		upload_pack=$1 ;;
+	-f|--force|--no-force)
+		force="$force $1" ;;
+	-t|--tags|--no-tags)
+		tags=$1 ;;
+	-p|--prune|--no-prune)
+		prune=$1 ;;
+	-k|--keep|--no-keep)
+		keep=$1 ;;
+	--depth=*|--no-depth)
+		depth=$1 ;;
+	--unshallow|--no-unshallow)
+		unshallow=$1 ;;
+	--update-shallow|--no-update-shallow)
+		update_shallow=$1 ;;
+	--refmap=*|--no-refmap)
+		refmap=$1 ;;
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
index 56e7377..d61af3d 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -130,4 +130,18 @@ test_expect_success 'git pull --dry-run' '
 	)
 '
 
+test_expect_success 'git pull --all --dry-run' '
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
