From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Mon, 12 Aug 2013 01:21:58 -0500
Message-ID: <1376288518-4875-1-git-send-email-stephen@exigencecorp.com>
Cc: Johannes.Schindelin@gmx.de, avarab@gmail.com,
	sunshine@sunshineco.com,
	Stephen Haberman <stephen@exigencecorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 12 08:22:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8lW9-0008CT-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 08:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840Ab3HLGWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 02:22:10 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:64254 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab3HLGWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 02:22:08 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so7104696pad.16
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 23:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Nz/E+cFoWbWe5ETQVVyy9CW5rwnNN3da0eSXQ6nTPEA=;
        b=U7XZ0BWXyi9Gpci5jtuXmqTJYgr4SZCiBY0KVWevBUOs5o3drYrnWOzouVRK7hLtVZ
         9HbdMAKJDCoEkO6OYc8jOJ+1JSjTYwpwgW43dE2jOY7oVMg4Ef+MaWP80IUZb23O4AgP
         DTyGR7Gvx8ogBQPYLKhuyL3SGnUEfmGLO6Fl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nz/E+cFoWbWe5ETQVVyy9CW5rwnNN3da0eSXQ6nTPEA=;
        b=JyBTfAb+wGJsLECAznCViVGOkp57lRKHQdasg5v2TF+kVpRzvbrdVylMRBrPDMpxvc
         9rrGQs1uiEF6aCJMYEXDgTdzTRNm0U+YZ0AaOnRf2oFh7CxcpAiKXyS9FVYdAx5eGyw/
         y39HDoYzAI7ALvIPZ+5iZ91exA4ja4ok/l/tvwnlhFo6PPbnLXnvdbPhlfhwS1LCN/oy
         AHejgOpOLfDB9cFSRFllphayi37Czq+RwxuMIZdKTi82EkHuQUVt+USgoi8FQC3EXyqC
         5uaJCVG+rR4O+YLq3B/oJGoKbyTNmOn4q/UcMOZeZXLDNOgFmKjcEn49rONlxFGDNKQg
         zt4A==
X-Gm-Message-State: ALoCoQmkThaDSpka6SeLVfHc91cOTCM/dYIcrtXUSxDxpTK5+xgBwcqkE9QVzD7QYcG8heFEvXa8
X-Received: by 10.68.164.225 with SMTP id yt1mr22295379pbb.195.1376288527485;
        Sun, 11 Aug 2013 23:22:07 -0700 (PDT)
Received: from localhost.localdomain (wsip-184-187-11-226.om.om.cox.net. [184.187.11.226])
        by mx.google.com with ESMTPSA id ut7sm3954827pbc.31.2013.08.11.23.22.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 23:22:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232156>

If a user is working on master, and has merged in their feature branch, but now
has to "git pull" because master moved, with pull.rebase their feature branch
will be flattened into master.

This is because "git pull" currently does not know about rebase's preserve
merges flag, which would avoid this behavior, as it would instead replay just
the merge commit of the feature branch onto the new master, and not replay each
individual commit in the feature branch.

Add a --rebase=preserve option, which will pass along --preserve-merges to
rebase.

Also add 'preserve' to the allowed values for the pull.rebase config setting.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
Hi,

This is v4 of my pull.rebase=preserve patch, previously discussed here:

http://thread.gmane.org/gmane.comp.version-control.git/232140

This version addresses feedback from Andreas about using case statements
instead of yoda conditions, and feedback from both Andreas and Junio
about avoiding ambiguity with "--rebase preserve". Now it must be
"--rebase=preseve".

I assume I'm doing the right thing by just posting another version of
this patch to the git list; let me know if I'm missing something.

Thanks!

 Documentation/config.txt   |  8 +++++
 Documentation/git-pull.txt | 18 +++++++----
 git-pull.sh                | 27 +++++++++++++---
 t/t5520-pull.sh            | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..4c22be2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -766,6 +766,10 @@ branch.<name>.rebase::
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
 +
+	When preserve, also pass `--preserve-merges` along to 'git rebase'
+	so that locally committed merge commits will not be flattened
+	by running 'git pull'.
++
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
@@ -1826,6 +1830,10 @@ pull.rebase::
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
 +
+	When preserve, also pass `--preserve-merges` along to 'git rebase'
+	so that locally committed merge commits will not be flattened
+	by running 'git pull'.
++
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 6ef8d59..beea10b 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -102,12 +102,18 @@ include::merge-options.txt[]
 :git-pull: 1
 
 -r::
---rebase::
-	Rebase the current branch on top of the upstream branch after
-	fetching.  If there is a remote-tracking branch corresponding to
-	the upstream branch and the upstream branch was rebased since last
-	fetched, the rebase uses that information to avoid rebasing
-	non-local changes.
+--rebase[=false|true|preserve]::
+	When true, rebase the current branch on top of the upstream
+	branch after fetching. If there is a remote-tracking branch
+	corresponding to the upstream branch and the upstream branch
+	was rebased since last fetched, the rebase uses that information
+	to avoid rebasing non-local changes.
++
+When preserve, also rebase the current branch on top of the upstream
+branch, but pass `--preserve-merges` along to `git rebase` so that
+locally created merge commits will not be flattened.
++
+When false, merge the current branch into the upstream branch.
 +
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
diff --git a/git-pull.sh b/git-pull.sh
index f0df41c..6ae6640 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,7 +4,7 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
-USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
+USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-r=[true|false|preserve]] [-s strategy]... [<fetch-options>] <repo> <head>...'
 LONG_USAGE='Fetch one or more remote refs and integrate it/them with the current HEAD.'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
@@ -40,13 +40,13 @@ test -f "$GIT_DIR/MERGE_HEAD" && die_merge
 
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
 log_arg= verbosity= progress= recurse_submodules= verify_signatures=
-merge_args= edit=
+merge_args= edit= rebase_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
-rebase=$(git config --bool branch.$curr_branch_short.rebase)
+rebase=$(git config branch.$curr_branch_short.rebase)
 if test -z "$rebase"
 then
-	rebase=$(git config --bool pull.rebase)
+	rebase=$(git config pull.rebase)
 fi
 dry_run=
 while :
@@ -110,6 +110,9 @@ do
 		esac
 		merge_args="$merge_args$xx "
 		;;
+	-r=*|--r=*|--re=*|--reb=*|--reba=*|--rebas=*|--rebase=*)
+		rebase="${1#*=}"
+		;;
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
 		rebase=true
 		;;
@@ -145,6 +148,20 @@ do
 	shift
 done
 
+case "$rebase" in
+preserve)
+	rebase=true
+	rebase_args=--preserve-merges
+	;;
+true|false|'')
+	;;
+*)
+	echo "Invalid value for --rebase, should be true, false, or preserve"
+	usage
+	exit 1
+	;;
+esac
+
 error_on_no_merge_candidates () {
 	exec >&2
 	for opt
@@ -292,7 +309,7 @@ fi
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
-	eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
+	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ed4d9c8..8be0482 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -148,6 +148,87 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test new = $(git show HEAD:file2)
 '
 
+# add a feature branch, keep-merge, that is merged into master, so the
+# test can try preserving the merge commit (or not) with various
+# --rebase flags/pull.rebase settings.
+test_expect_success 'preserve merge setup' '
+	git reset --hard before-rebase &&
+	git checkout -b keep-merge second^ &&
+	test_commit file3 &&
+	git checkout to-rebase &&
+	git merge keep-merge &&
+	git tag before-preserve-rebase
+'
+
+test_expect_success 'pull.rebase=false create a new merge commit' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.rebase false &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^1) = $(git rev-parse before-preserve-rebase) &&
+	test $(git rev-parse HEAD^2) = $(git rev-parse copy) &&
+	test file3 = $(git show HEAD:file3.t)
+'
+
+test_expect_success 'pull.rebase=true flattens keep-merge' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.rebase true &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
+	test file3 = $(git show HEAD:file3.t)
+'
+
+test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.rebase preserve &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
+	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
+'
+
+test_expect_success 'pull.rebase=invalid fails' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.rebase invalid &&
+	! git pull . copy
+'
+
+test_expect_success '--rebase=false create a new merge commit' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.rebase true &&
+	git pull --rebase=false . copy &&
+	test $(git rev-parse HEAD^1) = $(git rev-parse before-preserve-rebase) &&
+	test $(git rev-parse HEAD^2) = $(git rev-parse copy) &&
+	test file3 = $(git show HEAD:file3.t)
+'
+
+test_expect_success '--rebase=true rebases and flattens keep-merge' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.rebase preserve &&
+	git pull --rebase=true . copy &&
+	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
+	test file3 = $(git show HEAD:file3.t)
+'
+
+test_expect_success '--rebase=preserve rebases and merges keep-merge' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.rebase true &&
+	git pull --rebase=preserve . copy &&
+	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
+	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
+'
+
+test_expect_success '--rebase=invalid fails' '
+	git reset --hard before-preserve-rebase &&
+	! git pull --rebase=invalid . copy
+'
+
+test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.rebase preserve &&
+	git pull --rebase . copy &&
+	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
+	test file3 = $(git show HEAD:file3.t)
+'
+
 test_expect_success '--rebase with rebased upstream' '
 
 	git remote add -f me . &&
-- 
1.8.1.2
