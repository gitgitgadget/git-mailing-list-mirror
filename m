From: Cole Minnaar <cole.minnaar@gmail.com>
Subject: [PATCH/RFC v2 1/2] submodule: add ability to shallowly clone any branch in a repo as a submodule
Date: Mon, 15 Sep 2014 12:42:00 +0200
Message-ID: <1410777721-602-1-git-send-email-cole.minnaar@gmail.com>
Cc: Cole Minnaar <cole.minnaar@gmail.com>, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 12:42:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTTjc-0005sT-Qt
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 12:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbaIOKmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 06:42:11 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:56723 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbaIOKmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 06:42:09 -0400
Received: by mail-wi0-f169.google.com with SMTP id cc10so2222901wib.4
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Hb07HWOCrImunPnx3uD6nXd4VfY4oGlse3L9YOfNTl4=;
        b=ZiUaYSqw1SguMjMNVIT8xYEEZ6ldnyMUaSpIdltQYQdZEAM01V5f65N32yDitte63S
         5/QS+AaEn0Q5ouLmCnyvNW4kBbM/FmsXPY/cmrpu0jA1XTqUo5owDdnKghKzPGsba8eL
         M/uSfaVYb5UWrzfOMEY8qq9LFB5JVEuhL16EGkPdHNs7QCuEg2fQBFq/ShIhNUf1E0fv
         2LH5oIUbrWaE03aXZjyLkRI6YFFgF3/MWTRqirNYvrA6YHvMBEP+Akix46u3336VJXNg
         FC4zbOyvbBoScvOX6on8JuS+mNXm4aTakAHomNEyRAnlLlfDp1Yl5T24Qr0vHL1vHdg1
         Dcnw==
X-Received: by 10.180.183.133 with SMTP id em5mr22185157wic.72.1410777723581;
        Mon, 15 Sep 2014 03:42:03 -0700 (PDT)
Received: from localhost.localdomain (196-210-108-164.dynamic.isadsl.co.za. [196.210.108.164])
        by mx.google.com with ESMTPSA id cj7sm14300982wjc.37.2014.09.15.03.42.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Sep 2014 03:42:03 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.240.g8a0e823
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257047>

Currently when specifying the `--depth` option to the 'submodule add'
command, it can only create a shallow submodule clone of the currently
active branch from the cloned repository. If a branch is specified using
the `--branch` option, and the `--depth` option is also specified, the
'submodule add' command will result in an error as the branch will not
be present in the cloned repository. If a repository is shallowly cloned
as a submodule, there is no way to specify that the shallowly cloned
submodule should setup remote-tracking branches.

Added the ability to shallowly clone any branch as a submodule, not just
the current active branch in the cloned repository.
Added support to the 'submodule add' and 'submodule update' commands to
handle `--no-single-branch` option, which is in turn passed to the clone
command in order to setup remote-tracking branches in the shallowly
cloned submodule.

Signed-off-by: Cole Minnaar <cole.minnaar@gmail.com>
---
 Documentation/git-submodule.txt |  8 ++++++--
 git-submodule.sh                | 24 ++++++++++++++++++++----
 t/t7400-submodule-basic.sh      | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..5b913ab 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -10,13 +10,14 @@ SYNOPSIS
 --------
 [verse]
 'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
-	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
+	      [--reference <repository>] [--depth <depth>] [--no-single-branch]
+	      [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
-	      [--depth <depth>] [--recursive] [--] [<path>...]
+	      [--depth <depth>] [--recursive] [--no-single-branch] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -354,6 +355,9 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
+--no-single-branch::
+	This option is valid for add and update commands. Fetch histories near the tips
+	of all branches and create remote-tracking branches in the submodule.
 
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
diff --git a/git-submodule.sh b/git-submodule.sh
index 9245abf..9c0c858 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,11 +5,11 @@
 # Copyright (c) 2007 Lars Hjemli
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--depth <depth>] [--no-single-branch] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--depth <depth>] [--no-single-branch] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -259,6 +259,13 @@ module_clone()
 	url=$3
 	reference="$4"
 	depth="$5"
+	clone_branch=
+	if test -n "$6"
+	then
+		clone_branch="--branch=$6"
+	fi
+
+	no_single_branch="$7"
 	quiet=
 	if test -n "$GIT_QUIET"
 	then
@@ -282,6 +289,7 @@ module_clone()
 		(
 			clear_local_git_env
 			git clone $quiet ${depth:+"$depth"} -n ${reference:+"$reference"} \
+				${clone_branch:+"$clone_branch"} ${no_single_branch:+"$no_single_branch"} \
 				--separate-git-dir "$gitdir" "$url" "$sm_path"
 		) ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
@@ -328,6 +336,7 @@ cmd_add()
 {
 	# parse $args after "submodule ... add".
 	reference_path=
+	no_single_branch=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -363,6 +372,9 @@ cmd_add()
 		--depth=*)
 			depth=$1
 			;;
+		--no-single-branch)
+			no_single_branch="--no-single-branch"
+			;;
 		--)
 			shift
 			break
@@ -472,7 +484,7 @@ Use -f if you really want to add it." >&2
 				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
 			fi
 		fi
-		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
+		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" "$branch" "$no_single_branch" || exit
 		(
 			clear_local_git_env
 			cd "$sm_path" &&
@@ -724,6 +736,7 @@ cmd_deinit()
 cmd_update()
 {
 	# parse $args after "submodule ... update".
+	no_single_branch=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -770,6 +783,9 @@ cmd_update()
 		--depth=*)
 			depth=$1
 			;;
+		--no-single-branch)
+			no_single_branch="--no-single-branch"
+			;;
 		--)
 			shift
 			break
@@ -834,7 +850,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
+			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$branch" "$no_single_branch" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 7c88245..f716c1e 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -136,7 +136,6 @@ test_expect_success 'submodule add --branch' '
 	echo "refs/heads/initial" >expect-head &&
 	cat <<-\EOF >expect-heads &&
 	refs/heads/initial
-	refs/heads/master
 	EOF
 	>empty &&
 
@@ -982,5 +981,37 @@ test_expect_success 'submodule add clone shallow submodule' '
 	)
 '
 
+test_expect_success 'submodule add --branch --depth' '
+	(
+		cd addtest2 &&
+		git submodule add -b initial --depth 1 -- file://"$submodurl" submod-branch-depth &&
+		test "initial" = "$(git config -f .gitmodules submodule.submod-branch-depth.branch)" &&
+		(
+			cd submod-branch-depth &&
+			test 1 = $(git log --oneline | wc -l)
+		)
+	)
+'
+
+cat >remote <<\EOF
+  origin/HEAD -> origin/second
+  origin/initial
+  origin/master
+  origin/second
+EOF
+
+test_expect_success 'submodule add --branch --depth --no-single-branch' '
+	(
+		cd addtest2 &&
+		git submodule add -b initial --depth 1 --no-single-branch -- file://"$submodurl" submod-branch-depth-all &&
+		test "initial" = "$(git config -f .gitmodules submodule.submod-branch-depth-all.branch)" &&
+		(
+			cd submod-branch-depth-all &&
+			test 1 = $(git log --oneline | wc -l) &&
+			git branch -r >../../remote-out
+		)
+	) &&
+	test_cmp remote remote-out
+'
 
 test_done
-- 
2.1.0.240.g8a0e823
