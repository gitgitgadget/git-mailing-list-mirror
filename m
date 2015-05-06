From: Stephen Robin <stephen.robin@gmail.com>
Subject: [PATCH 6/6] parse-remote: dismantle git-parse-remote.sh
Date: Wed,  6 May 2015 01:00:53 +0100
Message-ID: <1430870453-5408-7-git-send-email-stephen.robin@gmail.com>
References: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
 <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Cc: git@vger.kernel.org
To: pyokagan@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 02:01:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypmm3-0004e4-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 02:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbbEFABI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 20:01:08 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35483 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbbEFAAz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 20:00:55 -0400
Received: by wgyo15 with SMTP id o15so200479272wgy.2
        for <git@vger.kernel.org>; Tue, 05 May 2015 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mwXWqFgnP7zh5Qub0OeS95raNKS8JHmFQvnLlwpf8mg=;
        b=OwCZGDIQdFQ+PiGHM/fI32FT7f3UhqPAPBvbqG0YnbUY9QYSf7sg5rsDvC4KE/E6ea
         rUzSi3omHP5lcoI/A0WrNCMnHbOMl9CVilI92N5oMkHwMuEqKLb0++bLzMUbPacfUbWI
         bQxMVAhGZIusXJ+QHTVgPUlj7dc7gfQVPhlkCeZhk10M8tVJcgYfeP5/dPvM9QqmqIxE
         9IrXY2ETHYVupFiaJqORbzPa8oKph3662iVrTGfWlDD+fYd6woNuTfkEsiJ5XqtG+oe0
         rgxoWbKl6YRC8ASPd5ApMZ+eX0WfeGLt0kz2FpdRsNczaGvhHqV5aWeF5GQSOlstf89F
         OQAw==
X-Received: by 10.180.82.133 with SMTP id i5mr2738452wiy.23.1430870454245;
        Tue, 05 May 2015 17:00:54 -0700 (PDT)
Received: from localhost ([141.0.152.225])
        by mx.google.com with ESMTPSA id cs4sm19539wjb.31.2015.05.05.17.00.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 17:00:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.7.gf20f26f
In-Reply-To: <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268438>

THIS PATCH SERIES IS NOT CODE-COMPLETE OR FULLY TESTED.
See code comments beginning TODO for work remaining.

Following the conversion of git-pull.sh to a builtin, git-parse-remote.sh
is only used from two places:
function error_on_missing_default_upstream is used within git-rebase.sh
only.
function get_default_remote is used within git-submodule.sh only.

Move these two functions into the scripts within which they're used, and
delete git-parse-remote.sh itself.

Signed-off-by: Stephen Robin <stephen.robin@gmail.com>
---
 .gitignore                           |  1 -
 Documentation/git-parse-remote.txt   | 23 ----------
 Makefile                             |  1 -
 command-list.txt                     |  1 -
 contrib/examples/git-parse-remote.sh | 89 ++++++++++++++++++++++++++++++++++++
 git-parse-remote.sh                  | 89 ------------------------------------
 git-rebase.sh                        | 36 ++++++++++++++-
 git-submodule.sh                     |  8 +++-
 8 files changed, 131 insertions(+), 117 deletions(-)
 delete mode 100644 Documentation/git-parse-remote.txt
 create mode 100644 contrib/examples/git-parse-remote.sh
 delete mode 100644 git-parse-remote.sh

diff --git a/.gitignore b/.gitignore
index 6287647..dd25b33 100644
--- a/.gitignore
+++ b/.gitignore
@@ -104,7 +104,6 @@
 /git-pack-redundant
 /git-pack-objects
 /git-pack-refs
-/git-parse-remote
 /git-patch-id
 /git-prune
 /git-prune-packed
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
deleted file mode 100644
index a45ea1e..0000000
--- a/Documentation/git-parse-remote.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-git-parse-remote(1)
-===================
-
-NAME
-----
-git-parse-remote - Routines to help parsing remote repository access parameters
-
-
-SYNOPSIS
---------
-[verse]
-'. "$(git --exec-path)/git-parse-remote"'
-
-DESCRIPTION
------------
-This script is included in various scripts to supply
-routines to parse files under $GIT_DIR/remotes/ and
-$GIT_DIR/branches/ and configuration variables that are related
-to fetching, pulling and pushing.
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 8d8fb3a..d41224c 100644
--- a/Makefile
+++ b/Makefile
@@ -481,7 +481,6 @@ SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
-SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
 SCRIPT_LIB += git-rebase--interactive
 SCRIPT_LIB += git-rebase--merge
diff --git a/command-list.txt b/command-list.txt
index f1eae08..273f69e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -86,7 +86,6 @@ git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
-git-parse-remote                        synchelpers
 git-patch-id                            purehelpers
 git-prune                               ancillarymanipulators
 git-prune-packed                        plumbingmanipulators
diff --git a/contrib/examples/git-parse-remote.sh b/contrib/examples/git-parse-remote.sh
new file mode 100644
index 0000000..55fe8d5
--- /dev/null
+++ b/contrib/examples/git-parse-remote.sh
@@ -0,0 +1,89 @@
+# This is a shell library to calculate the remote repository and
+# upstream branch that should be pulled by "git pull" from the current
+# branch.
+
+# git-ls-remote could be called from outside a git managed repository;
+# this would fail in that case and would issue an error message.
+GIT_DIR=$(git rev-parse -q --git-dir) || :;
+
+get_default_remote () {
+	curr_branch=$(git symbolic-ref -q HEAD)
+	curr_branch="${curr_branch#refs/heads/}"
+	origin=$(git config --get "branch.$curr_branch.remote")
+	echo ${origin:-origin}
+}
+
+get_remote_merge_branch () {
+	case "$#" in
+	0|1)
+	    origin="$1"
+	    default=$(get_default_remote)
+	    test -z "$origin" && origin=$default
+	    curr_branch=$(git symbolic-ref -q HEAD) &&
+	    [ "$origin" = "$default" ] &&
+	    echo $(git for-each-ref --format='%(upstream)' $curr_branch)
+	    ;;
+	*)
+	    repo=$1
+	    shift
+	    ref=$1
+	    # FIXME: It should return the tracking branch
+	    #        Currently only works with the default mapping
+	    case "$ref" in
+	    +*)
+		ref=$(expr "z$ref" : 'z+\(.*\)')
+		;;
+	    esac
+	    expr "z$ref" : 'z.*:' >/dev/null || ref="${ref}:"
+	    remote=$(expr "z$ref" : 'z\([^:]*\):')
+	    case "$remote" in
+	    '' | HEAD ) remote=HEAD ;;
+	    heads/*) remote=${remote#heads/} ;;
+	    refs/heads/*) remote=${remote#refs/heads/} ;;
+	    refs/* | tags/* | remotes/* ) remote=
+	    esac
+	    [ -n "$remote" ] && case "$repo" in
+		.)
+		    echo "refs/heads/$remote"
+		    ;;
+		*)
+		    echo "refs/remotes/$repo/$remote"
+		    ;;
+	    esac
+	esac
+}
+
+error_on_missing_default_upstream () {
+	cmd="$1"
+	op_type="$2"
+	op_prep="$3"
+	example="$4"
+	branch_name=$(git symbolic-ref -q HEAD)
+	# If there's only one remote, use that in the suggestion
+	remote="<remote>"
+	if test $(git remote | wc -l) = 1
+	then
+		remote=$(git remote)
+	fi
+
+	if test -z "$branch_name"
+	then
+		echo "You are not currently on a branch. Please specify which
+branch you want to $op_type $op_prep. See git-${cmd}(1) for details.
+
+    $example
+"
+	else
+		echo "There is no tracking information for the current branch.
+Please specify which branch you want to $op_type $op_prep.
+See git-${cmd}(1) for details
+
+    $example
+
+If you wish to set tracking information for this branch you can do so with:
+
+    git branch --set-upstream-to=$remote/<branch> ${branch_name#refs/heads/}
+"
+	fi
+	exit 1
+}
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
deleted file mode 100644
index 55fe8d5..0000000
--- a/git-parse-remote.sh
+++ /dev/null
@@ -1,89 +0,0 @@
-# This is a shell library to calculate the remote repository and
-# upstream branch that should be pulled by "git pull" from the current
-# branch.
-
-# git-ls-remote could be called from outside a git managed repository;
-# this would fail in that case and would issue an error message.
-GIT_DIR=$(git rev-parse -q --git-dir) || :;
-
-get_default_remote () {
-	curr_branch=$(git symbolic-ref -q HEAD)
-	curr_branch="${curr_branch#refs/heads/}"
-	origin=$(git config --get "branch.$curr_branch.remote")
-	echo ${origin:-origin}
-}
-
-get_remote_merge_branch () {
-	case "$#" in
-	0|1)
-	    origin="$1"
-	    default=$(get_default_remote)
-	    test -z "$origin" && origin=$default
-	    curr_branch=$(git symbolic-ref -q HEAD) &&
-	    [ "$origin" = "$default" ] &&
-	    echo $(git for-each-ref --format='%(upstream)' $curr_branch)
-	    ;;
-	*)
-	    repo=$1
-	    shift
-	    ref=$1
-	    # FIXME: It should return the tracking branch
-	    #        Currently only works with the default mapping
-	    case "$ref" in
-	    +*)
-		ref=$(expr "z$ref" : 'z+\(.*\)')
-		;;
-	    esac
-	    expr "z$ref" : 'z.*:' >/dev/null || ref="${ref}:"
-	    remote=$(expr "z$ref" : 'z\([^:]*\):')
-	    case "$remote" in
-	    '' | HEAD ) remote=HEAD ;;
-	    heads/*) remote=${remote#heads/} ;;
-	    refs/heads/*) remote=${remote#refs/heads/} ;;
-	    refs/* | tags/* | remotes/* ) remote=
-	    esac
-	    [ -n "$remote" ] && case "$repo" in
-		.)
-		    echo "refs/heads/$remote"
-		    ;;
-		*)
-		    echo "refs/remotes/$repo/$remote"
-		    ;;
-	    esac
-	esac
-}
-
-error_on_missing_default_upstream () {
-	cmd="$1"
-	op_type="$2"
-	op_prep="$3"
-	example="$4"
-	branch_name=$(git symbolic-ref -q HEAD)
-	# If there's only one remote, use that in the suggestion
-	remote="<remote>"
-	if test $(git remote | wc -l) = 1
-	then
-		remote=$(git remote)
-	fi
-
-	if test -z "$branch_name"
-	then
-		echo "You are not currently on a branch. Please specify which
-branch you want to $op_type $op_prep. See git-${cmd}(1) for details.
-
-    $example
-"
-	else
-		echo "There is no tracking information for the current branch.
-Please specify which branch you want to $op_type $op_prep.
-See git-${cmd}(1) for details
-
-    $example
-
-If you wish to set tracking information for this branch you can do so with:
-
-    git branch --set-upstream-to=$remote/<branch> ${branch_name#refs/heads/}
-"
-	fi
-	exit 1
-}
diff --git a/git-rebase.sh b/git-rebase.sh
index 55da9db..7b157ec 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -209,6 +209,41 @@ run_pre_rebase_hook () {
 	fi
 }
 
+error_on_missing_default_upstream () {
+	cmd="$1"
+	op_type="$2"
+	op_prep="$3"
+	example="$4"
+	branch_name=$(git symbolic-ref -q HEAD)
+	# If there's only one remote, use that in the suggestion
+	remote="<remote>"
+	if test $(git remote | wc -l) = 1
+	then
+		remote=$(git remote)
+	fi
+
+	if test -z "$branch_name"
+	then
+		echo "You are not currently on a branch. Please specify which
+branch you want to $op_type $op_prep. See git-${cmd}(1) for details.
+
+    $example
+"
+	else
+		echo "There is no tracking information for the current branch.
+Please specify which branch you want to $op_type $op_prep.
+See git-${cmd}(1) for details
+
+    $example
+
+If you wish to set tracking information for this branch you can do so with:
+
+    git branch --set-upstream-to=$remote/<branch> ${branch_name#refs/heads/}
+"
+	fi
+	exit 1
+}
+
 test -f "$apply_dir"/applying &&
 	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
 
@@ -446,7 +481,6 @@ then
 		if ! upstream_name=$(git rev-parse --symbolic-full-name \
 			--verify -q @{upstream} 2>/dev/null)
 		then
-			. git-parse-remote
 			error_on_missing_default_upstream "rebase" "rebase" \
 				"against" "git rebase <branch>"
 		fi
diff --git a/git-submodule.sh b/git-submodule.sh
index 36797c3..08c31eb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -17,7 +17,6 @@ OPTIONS_SPEC=
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 . git-sh-i18n
-. git-parse-remote
 require_work_tree
 wt_prefix=$(git rev-parse --show-prefix)
 cd_to_toplevel
@@ -37,6 +36,13 @@ prefix=
 custom_name=
 depth=
 
+get_default_remote () {
+	curr_branch=$(git symbolic-ref -q HEAD)
+	curr_branch="${curr_branch#refs/heads/}"
+	origin=$(git config --get "branch.$curr_branch.remote")
+	echo ${origin:-origin}
+}
+
 # The function takes at most 2 arguments. The first argument is the
 # URL that navigates to the submodule origin repo. When relative, this URL
 # is relative to the superproject origin URL repo. The second up_path
-- 
2.4.0.7.gf20f26f
