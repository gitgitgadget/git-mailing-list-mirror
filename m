From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 1/2] pull: handle git-fetch's options as well
Date: Tue,  2 Jun 2015 22:22:52 +0800
Message-ID: <1433254973-13797-2-git-send-email-pyokagan@gmail.com>
References: <1433254973-13797-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 16:23:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzn62-0000WS-FQ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759135AbbFBOXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 10:23:08 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36778 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759181AbbFBOXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 10:23:04 -0400
Received: by pdjm12 with SMTP id m12so51079295pdj.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y7rotgTo77AUpJw+PdWjR0BtHvLCGd5PZSiwLfcbX6k=;
        b=gKe+5UpLcda/D8ZBpyJY4ZGr7rV+Bca6gSlm56DaOh+ypId8ucOU6gGHBzKPDr6trr
         M+9xyXveN6UbuJavJqMVtZo7rTA8fYotQS2AJaPI6NS/U+sWsrImL5NbOJUAQHvdoZHy
         +hXE44lrLLy4BkIYIxcxlO3UvGqLUiqMl2+H0XdpITNcGtx0PD+yKbq3Yf88ERyRX+Xa
         J3AlYAmdE5ZdiWKJc2329pbzYJLVXZqnudzz5eMxpmvjgVeEZfmwB1IHmwpwPOMV/Myd
         krxoDH04G4GHi5hMnBH2jHzf3Mww/1aXfRaS8DTGDXg0N4UMS+muWxyaHUOjLHVBD9h1
         gWlg==
X-Received: by 10.66.150.196 with SMTP id uk4mr50977059pab.54.1433254983387;
        Tue, 02 Jun 2015 07:23:03 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id fd3sm5329786pac.39.2015.06.02.07.23.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 07:23:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433254973-13797-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270543>

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

This removes the limitation where git-fetch's options have to come after
git-merge's and git-rebase's options on the command line. Update the
documentation to reflect this.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    Improve git-pull's option parsing
    
    Previous versions:
    
    [v1] http://thread.gmane.org/gmane.comp.version-control.git/269249
    
    This patch series is based on pt/pull-tests.
    
    While parsing the command-line arguments, git-pull stops parsing at the
    first unrecognized option, assuming that any subsequent options are for
    git-fetch, and can thus be kept in the shell's positional parameters
    list, so that it can be passed to git-fetch via the expansion of "$ <at>
    ".
    
    However, certain functions in git-pull assume that the positional
    parameters do not contain any options. Fix this by making git-pull
    handle git-fetch's options as well at the option parsing stage.
    
    With this change in place, we can move on to migrate git-pull to use
    git-rev-parse --parseopt such that its option parsing is consistent with
    the other git commands.
    
    I believe this is the last required behavior change for my rewrite of
    git-pull.sh to C.
    
    v2
    
    * Initialize variables to prevent them from being set in the command
      line.
    
    * Update the documentation as well.

 Documentation/git-pull.txt |  3 ---
 git-pull.sh                | 37 ++++++++++++++++++++++++++++++++++---
 t/t5520-pull.sh            | 20 ++++++++++++++++++++
 t/t5521-pull-options.sh    | 14 ++++++++++++++
 4 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 712ab4b..93c72a2 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -74,9 +74,6 @@ pulling or stash them away with linkgit:git-stash[1].
 OPTIONS
 -------
 
-Options meant for 'git pull' itself and the underlying 'git merge'
-must be given before the options meant for 'git fetch'.
-
 -q::
 --quiet::
 	This is passed to both underlying git-fetch to squelch reporting of
diff --git a/git-pull.sh b/git-pull.sh
index 0917d0d..623ba7a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -44,7 +44,8 @@ bool_or_string_config () {
 
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
 log_arg= verbosity= progress= recurse_submodules= verify_signatures=
-merge_args= edit= rebase_args=
+merge_args= edit= rebase_args= all= append= upload_pack= force= tags= prune=
+keep= depth= unshallow= update_shallow= refmap=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
 rebase=$(bool_or_string_config branch.$curr_branch_short.rebase)
@@ -166,11 +167,39 @@ do
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
@@ -248,7 +277,9 @@ test true = "$rebase" && {
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
index af31f04..f4a7193 100755
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
@@ -365,6 +377,14 @@ test_expect_success '--rebase with rebased upstream' '
 
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
index 56e7377..18372ca 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -130,4 +130,18 @@ test_expect_success 'git pull --dry-run' '
 	)
 '
 
+test_expect_success 'git pull --all --dry-run' '
+	test_when_finished "rm -rf cloneddry" &&
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
