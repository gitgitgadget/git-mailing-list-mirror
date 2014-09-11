From: Cole Minnaar <cole.minnaar@gmail.com>
Subject: [PATCH/RFC] submodule: add ability to shallowly clone any branch in a submodule
Date: Thu, 11 Sep 2014 19:11:13 +0200
Message-ID: <1410455473-2367-1-git-send-email-cole.minnaar@gmail.com>
Cc: Cole Minnaar <cole.minnaar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 19:11:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS7u9-0005eG-NI
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 19:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbaIKRL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 13:11:28 -0400
Received: from mail-wi0-f195.google.com ([209.85.212.195]:52525 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbaIKRLW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 13:11:22 -0400
Received: by mail-wi0-f195.google.com with SMTP id bs8so452351wib.6
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LWrkT7Rh4rko9PaNRPTS0Es12Dlrtoa8Frgbk/7aglA=;
        b=P/HmVJb/aBsJucI8ry0pff3U9Y/WeZbIhpIT2cU69yrhr5TEkKgtS3C9fH0j6k1vxe
         QudZbxN7lZ2CXaXQydP5YEQtq0SKQHlPYoiRJBuuBZalm4R2f4zwFqOPf3Ze+crhZSzR
         Q6Jubozr2tDHQKKMyCXRNAdKro9XDEAmcDX6yMu/0cvycizb/tzStZYfI6LK6StRhDEx
         rayWqbvK88BVXKdVchc3yKg18iQBdHMbN8HYQfwnbCt+bD46IE/p/7wddEeSg6DG77V7
         1uE6lDKSxbe40NWdX1+KTOOwOgXZzqjJr9HDiCyqcC0HHXo461t25rROR71wTggD8ftF
         cw2g==
X-Received: by 10.180.76.209 with SMTP id m17mr4094754wiw.78.1410455480863;
        Thu, 11 Sep 2014 10:11:20 -0700 (PDT)
Received: from localhost.localdomain (196-210-108-164.dynamic.isadsl.co.za. [196.210.108.164])
        by mx.google.com with ESMTPSA id v20sm2156158wib.4.2014.09.11.10.11.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Sep 2014 10:11:20 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.127.g0c72b98.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256855>

Currently when specifying the `--depth` option to the 'submodule add'
command, it can only create a shallow submodule clone of the currently active
branch from the cloned repository. If a branch is specified using the
`--branch` command, the 'submodule add' will result in an error as the
branch will not exist in the cloned repository. Subsequently, if a
repository is cloned which contains submodules, and both the `--depth` and
`--recursive` options are specified, the top level repository will be
cloned using the specified depth, but each submodule will be cloned in
its entirety.

Added the ability to shallowly clone any branch as a submodule, not just
the current active branch from the cloned repository. Also includes the
ability to shallowly clone a repository and all its submodules.
Added support to the 'submodule add' and 'submodule update' command to handle
`--no-single-branch`, which is then passed to the clone command in order
to setup remote-tracking branches in the shallowly cloned submodules.

Signed-off-by: Cole Minnaar <cole.minnaar@gmail.com>
---
 Documentation/git-clone.txt     |  6 +++++-
 Documentation/git-submodule.txt |  8 ++++++--
 builtin/clone.c                 | 15 +++++++++------
 git-submodule.sh                | 24 ++++++++++++++++++++----
 t/t7400-submodule-basic.sh      | 33 ++++++++++++++++++++++++++++++++-
 5 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 0363d00..5eef11c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -178,7 +178,9 @@ objects from the source repository into a pack in the cloned repository.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions.
+	specified number of revisions. If `--recursive` was also specified,
+	the depth value will be passed to all submodules within when
+	cloning.
 
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
@@ -192,6 +194,8 @@ objects from the source repository into a pack in the cloned repository.
 	initial cloning.  If the HEAD at the remote did not point at any
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
+	If `--recursive` was also specified, this option will also be passed
+	to all submodules when cloning.
 
 --recursive::
 --recurse-submodules::
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..176f150 100644
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
+	      [--recursive] [--depth <depth>] [--no-single-branch] [--] [<path>...]
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
diff --git a/builtin/clone.c b/builtin/clone.c
index dd4092b..b27917c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -48,6 +48,7 @@ static int option_verbosity;
 static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
+static struct argv_array argv_submodule_cmd = ARGV_ARRAY_INIT;
 
 static int opt_parse_reference(const struct option *opt, const char *arg, int unset)
 {
@@ -100,10 +101,6 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
-static const char *argv_submodule[] = {
-	"submodule", "update", "--init", "--recursive", NULL
-};
-
 static char *get_repo_path(const char *repo, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -663,8 +660,14 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
-		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+	if (!err && option_recursive) {
+		argv_array_pushl(&argv_submodule_cmd, "submodule", "update", "--init", "--recursive", NULL);
+		if (option_depth)
+			argv_array_pushf(&argv_submodule_cmd, "--depth=%d", atoi(option_depth));
+		if (!option_single_branch)
+			argv_array_pushl(&argv_submodule_cmd, "--no-single-branch", NULL);
+		err = run_command_v_opt(argv_submodule_cmd.argv, RUN_GIT_CMD);
+	}
 
 	return err;
 }
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
index 7c88245..81c05ae 100755
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
+			test 1 = $(git log --oneline | wc -l)
+			git branch -r >../../remote-out
+		)
+	) &&
+	test_cmp remote remote-out
+'
 
 test_done
-- 
2.1.0.127.g0c72b98.dirty
