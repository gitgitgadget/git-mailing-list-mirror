From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v5 3/4] submodule: Explicit local branch creation in module_clone
Date: Sun, 26 Jan 2014 12:45:15 -0800
Message-ID: <42bef14770ea71bc96e9a18828e4921d27ee581b.1390768736.git.wking@tremily.us>
References: <20140117023746.GJ7078@odin.tremily.us>
 <cover.1390768736.git.wking@tremily.us>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 26 21:46:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7Wb8-0002cz-Ku
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 21:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbaAZUqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 15:46:21 -0500
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:45645
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753329AbaAZUqK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 15:46:10 -0500
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id JkDq1n0080mv7h056km9bE; Sun, 26 Jan 2014 20:46:09 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id Jkm71n00W152l3L3Xkm8bp; Sun, 26 Jan 2014 20:46:09 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id 5CD8AF1C33B;
	Sun, 26 Jan 2014 12:46:07 -0800 (PST)
Received: (nullmailer pid 2843 invoked by uid 1000);
	Sun, 26 Jan 2014 20:45:23 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <cover.1390768736.git.wking@tremily.us>
In-Reply-To: <cover.1390768736.git.wking@tremily.us>
References: <cover.1390768736.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1390769169;
	bh=FNjjDoH8osRyqVqmHN89eOgo8t2PX+XpJcCAhXCkS+g=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=aFgh+6GrPr+b794SzauW4/XdxLfmkdLWS0uL1IX96GN+WZzC4bHitRd9m2H4twURV
	 tJL8XR7lLBwjCA4tr/f2KtYVvvcyLvJsKf/Kizk5a2eGxVDMNFDyc8NGNcybOuaD7y
	 +lK2x/LR9pxSiDU4+++eNdB6wHg5Em6OVhzzk4pVAVh8FFlDfPiCRMhAbUjuUAEMnZ
	 lOOGcMmpeMzFYpB9Jv6INs0DpcNMi1MleOGyk23uznd/fBVBA578kLbh/bMOGflL7D
	 h+WlRnQrD+Uk+ePWlzRMC69AEA3NJcX5Wo5QsCmM6GArBwx5MqJizvPLu9wCU6pCJU
	 O5EBc71Dr0w/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241116>

The previous code only checked out branches in cmd_add.  This commit
moves the branch-checkout logic into module_clone, where it can be
shared by cmd_add and cmd_update.  I also update the initial checkout
command to use 'reset' to preserve branches setup during module_clone.

With this change, folks cloning submodules for the first time via:

  $ git submodule update ...

will get a local branch instead of a detached HEAD, unless they are
using the default checkout-mode updates.  This is a change from the
previous situation where cmd_update always used checkout-mode logic
(regardless of the requested update mode) for updates that triggered
an initial clone, which always resulted in a detached HEAD.

This commit does not change the logic for updates after the initial
clone, which will continue to create detached HEADs for checkout-mode
updates, and integrate remote work with the local HEAD (detached or
not) in other modes.

The motivation for the change is that developers doing local work
inside the submodule are likely to select a non-checkout-mode for
updates so their local work is integrated with upstream work.
Developers who are not doing local submodule work stick with
checkout-mode updates so any apparently local work is blown away
during updates.  For example, if upstream rolls back the remote branch
or gitlinked commit to an earlier version, the checkout-mode developer
wants their old submodule checkout to be rolled back as well, instead
of getting a no-op merge/rebase with the rolled-back reference.

By using the update mode to distinguish submodule developers from
black-box submodule consumers, we can setup local branches for the
developers who will want local branches, and stick with detached HEADs
for the developers that don't care.

Testing
=======

In t7406, just-cloned checkouts now update to the gitlinked hash with
'reset', to preserve the local branch for situations where we're not
on a detached HEAD.

I also added explicit tests to t7406 for HEAD attachement after
cloning updates, showing that it depends on their update mode:

* Checkout-mode updates get detached HEADs
* Everyone else gets a local branch, matching the configured
  submodule.<name>.branch and defaulting to master.

The 'initial-setup' tag makes it easy to reset the superproject to a
known state, as several earlier tests commit to submodules and commit
the changed gitlinks to the superproject, but don't push the new
submodule commits to the upstream subprojects.  This makes it
impossible to checkout the current super master, because it references
submodule commits that don't exist in the upstream subprojects.  For a
specific example, see the tests that currently generate the
'two_new_submodule_commits' commits.

Documentation
=============

I updated the docs to describe the 'submodule update' modes in detail.
The old documentation did not distinguish between cloning and
non-cloning updates and lacked clarity on which operations would lead
to detached HEADs, and which would not.  The new documentation
addresses these issues while updating the docs to reflect the changes
introduced by this commit's explicit local branch creation in
module_clone.

I also add '--checkout' to the usage summary and group the update-mode
options into a single set.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 36 ++++++++++++++++++-------
 Documentation/gitmodules.txt    |  4 +++
 git-submodule.sh                | 58 +++++++++++++++++++++++++++++------------
 t/t7406-submodule-update.sh     | 39 ++++++++++++++++++++++++++-
 4 files changed, 110 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bfef8a0..2e1c7a2 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,8 +15,8 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [-f|--force] [--rebase] [--reference <repository>] [--depth <depth>]
-	      [--merge] [--recursive] [--] [<path>...]
+	      [-f|--force] [--rebase|--merge|--checkout] [--reference <repository>]
+	      [--depth <depth>] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -155,13 +155,31 @@ it contains local modifications.
 
 update::
 	Update the registered submodules, i.e. clone missing submodules and
-	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached unless `--rebase` or
-	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`. `none` can be overridden by specifying
-	`--checkout`. Setting the key `submodule.$name.update` to `!command`
-	will cause `command` to be run. `command` can be any arbitrary shell
-	command that takes a single argument, namely the sha1 to update to.
+	checkout the commit specified in the index of the containing
+	repository.  The update mode defaults to `checkout`, but can be
+	configured with the `submodule.<name>.update` setting or the
+	`--rebase`, `--merge`, or `--checkout` options.
++
+For updates that clone missing submodules, checkout-mode updates will
+create submodules with detached HEADs; all other modes will create
+submodules with a local branch named after `submodule.<path>.branch`.
++
+For updates that do not clone missing submodules, the submodule's HEAD
+is only touched when the remote reference does not match the
+submodule's HEAD (for none-mode updates, the submodule is never
+touched).  The remote reference is usually the gitlinked commit from
+the superproject's tree, but with `--remote` it is the upstream
+subproject's `submodule.<name>.branch`.  This remote reference is
+integrated with the submodule's HEAD using the specified update mode.
+For checkout-mode updates, that will result in a detached HEAD.  For
+rebase- and merge-mode updates, the commit referenced by the
+submodule's HEAD may change, but the symbolic reference will remain
+unchanged (i.e. checked-out branches will still be checked-out
+branches, and detached HEADs will still be detached HEADs).  If none
+of the builtin modes fit your needs, set `submodule.<name>.update` to
+`!command` to configure a custom integration command.  `command` can
+be any arbitrary shell command that takes a single argument, namely
+the sha1 to update to.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index f7be93f..385f35d 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -53,6 +53,10 @@ submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
 	If the option is not specified, it defaults to 'master'.  See the
 	`--remote` documentation in linkgit:git-submodule[1] for details.
++
+This branch name is also used for the local branch created by
+non-checkout cloning updates.  See the `update` documentation in
+linkgit:git-submodule[1] for details.
 
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
diff --git a/git-submodule.sh b/git-submodule.sh
index 68dcbe1..626a746 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -246,6 +246,9 @@ module_name()
 # $3 = URL to clone
 # $4 = reference repository to reuse (empty for independent)
 # $5 = depth argument for shallow clones (empty for deep)
+# $6 = (remote-tracking) starting point for the local branch (empty for HEAD)
+# $7 = local branch to create (empty for a detached HEAD, unless $6 is
+#      also empty, in which case the local branch is left unchanged)
 #
 # Prior to calling, cmd_update checks that a possibly existing
 # path is not a git repository.
@@ -259,6 +262,8 @@ module_clone()
 	url=$3
 	reference="$4"
 	depth="$5"
+	start_point="$6"
+	local_branch="$7"
 	quiet=
 	if test -n "$GIT_QUIET"
 	then
@@ -312,7 +317,16 @@ module_clone()
 	echo "gitdir: $rel/$a" >"$sm_path/.git"
 
 	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
-	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
+	(
+		clear_local_git_env
+		cd "$sm_path" &&
+		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
+		# ash fails to wordsplit ${local_branch:+-B "$local_branch"...}
+		case "$local_branch" in
+		'') git checkout -f -q ${start_point:+"$start_point"} ;;
+		?*) git checkout -f -q -B "$local_branch" ${start_point:+"$start_point"} ;;
+		esac
+	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
 }
 
 isnumber()
@@ -475,16 +489,15 @@ Use -f if you really want to add it." >&2
 				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
 			fi
 		fi
-		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
-		(
-			clear_local_git_env
-			cd "$sm_path" &&
-			# ash fails to wordsplit ${branch:+-b "$branch"...}
-			case "$branch" in
-			'') git checkout -f -q ;;
-			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
-			esac
-		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
+		if test -n "$branch"
+		then
+			start_point="origin/$branch"
+			local_branch="$branch"
+		else
+			start_point=""
+			local_branch=""
+		fi
+		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" "$start_point" "$local_branch" || exit
 	fi
 	git config submodule."$sm_name".url "$realrepo"
 
@@ -803,7 +816,9 @@ cmd_update()
 		fi
 		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
-		branch=$(get_submodule_config "$name" branch master)
+		config_branch=$(get_submodule_config "$name" branch)
+		branch="${config_branch:-master}"
+		local_branch="$branch"
 		if ! test -z "$update"
 		then
 			update_module=$update
@@ -817,11 +832,19 @@ cmd_update()
 
 		displaypath=$(relative_path "$prefix$sm_path")
 
-		if test "$update_module" = "none"
-		then
+		case "$update_module" in
+		none)
 			echo "Skipping submodule '$displaypath'"
 			continue
-		fi
+			;;
+		checkout)
+			local_branch=""
+			;;
+		rebase | merge | !*)
+			;;
+		*)
+			die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
+		esac
 
 		if test -z "$url"
 		then
@@ -835,7 +858,8 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
+			start_point="origin/${branch}"
+			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$start_point" "$local_branch" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
@@ -881,7 +905,7 @@ Maybe you want to use 'update --init'?")"
 			case ";$cloned_modules;" in
 			*";$name;"*)
 				# then there is no local change to integrate
-				update_module=checkout ;;
+				update_module='!git reset --hard -q'
 			esac
 
 			must_die_on_failure=
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 0825a92..f056c01 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -63,6 +63,9 @@ test_expect_success 'setup a submodule tree' '
 	 git submodule add ../none none &&
 	 test_tick &&
 	 git commit -m "none"
+	) &&
+	(cd super &&
+	 git tag initial-setup
 	)
 '
 
@@ -703,7 +706,7 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	git clone super_update_r super_update_r2 &&
 	(cd super_update_r2 &&
 	 git submodule update --init --recursive >actual &&
-	 test_i18ngrep "Submodule path .submodule/subsubmodule.: checked out" actual &&
+	 test_i18ngrep "Submodule path .submodule/subsubmodule.: .git reset --hard -q" actual &&
 	 (cd submodule/subsubmodule &&
 	  git log > ../../expected
 	 ) &&
@@ -764,4 +767,38 @@ test_expect_success 'submodule update clone shallow submodule' '
 	 )
 	)
 '
+
+test_expect_success 'submodule update --checkout clones detached HEAD' '
+	git clone super super4 &&
+	echo "detached HEAD" >expected &&
+	(cd super4 &&
+	 git reset --hard initial-setup &&
+	 git submodule init submodule &&
+	 git submodule update >> /tmp/log 2>&1 &&
+	 (cd submodule &&
+	  git symbolic-ref HEAD > ../../actual ||
+	  echo "detached HEAD" > ../../actual
+	 )
+	) &&
+	test_cmp actual expected &&
+	rm -rf super4
+'
+
+test_expect_success 'submodule update --merge clones attached HEAD' '
+	git clone super super4 &&
+	echo "refs/heads/master" >expected &&
+	(cd super4 &&
+	 git reset --hard initial-setup &&
+	 git submodule init submodule &&
+	 git config submodule.submodule.update merge &&
+	 git submodule update --merge &&
+	 (cd submodule &&
+	  git symbolic-ref HEAD > ../../actual ||
+	  echo "detached HEAD" > ../../actual
+	 )
+	) &&
+	test_cmp actual expected &&
+	rm -rf super4
+'
+
 test_done
-- 
1.8.5.2.8.g0f6c0d1
