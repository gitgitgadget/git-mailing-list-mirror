From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 3/6] submodule: Explicit local branch creation in module_clone
Date: Wed, 15 Jan 2014 20:10:24 -0800
Message-ID: <96f9749de94f7e89f4d113f8cde69f2a960bcb88.1389837412.git.wking@tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 05:12:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3eJb-0002iU-5C
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 05:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbaAPELq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 23:11:46 -0500
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:37522
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751435AbaAPELa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 23:11:30 -0500
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id EUBH1n00A0cZkys55UBW0D; Thu, 16 Jan 2014 04:11:30 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id EUBU1n00Q152l3L3WUBVpX; Thu, 16 Jan 2014 04:11:30 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id 388E2EFE48B;
	Wed, 15 Jan 2014 20:11:28 -0800 (PST)
Received: (nullmailer pid 18562 invoked by uid 1000);
	Thu, 16 Jan 2014 04:11:03 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <20140114224246.GA13271@book.hvoigt.net>
In-Reply-To: <cover.1389837412.git.wking@tremily.us>
References: <cover.1389837412.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389845490;
	bh=yV2rYU2H3gSHRgVistNpX8fUSZT1SiREyfhrfpolc14=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=qS/txFEGr3g48GCwHJ0lCVGGrH1l5GKHelPkS7nv2nhfXHi+W332lqO9dzHGhzNut
	 a8qmz/1F0IGp0Ta6CoLrorIpED9L2Dcw6eHSOudzUAlk5BmRfqSQjcQF9LJO8OOl0+
	 1V6EOMZLrdi68f4TNjP8uCtBzEm67yW65ahVxds4fCWBMuhxA44/VlD/e1JDyt5wuU
	 i+Jplob8It37sybzfyAY+VKvIbNdZRPzMJ6lPDniT3yUafz8/NHUI0rA9rRwkjwUtS
	 roL3bOkKbAFaZKtzU0gXT6OB6nwFrkiWEvwuEFIKdyqcVh9aZzcTCRxUKFGQHU4Yyv
	 ZFntsb5z+4asQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240504>

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

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 git-submodule.sh | 53 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 68dcbe1..4a09951 100755
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
@@ -475,16 +489,14 @@ Use -f if you really want to add it." >&2
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
+		fi
+		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" "$start_point" "$local_branch" || exit
 	fi
 	git config submodule."$sm_name".url "$realrepo"
 
@@ -803,7 +815,9 @@ cmd_update()
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
@@ -817,11 +831,15 @@ cmd_update()
 
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
+		esac
 
 		if test -z "$url"
 		then
@@ -835,7 +853,8 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
+			start_point="origin/${branch}"
+			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$start_point" "$local_branch" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
@@ -881,7 +900,7 @@ Maybe you want to use 'update --init'?")"
 			case ";$cloned_modules;" in
 			*";$name;"*)
 				# then there is no local change to integrate
-				update_module=checkout ;;
+				update_module='!git reset --hard -q'
 			esac
 
 			must_die_on_failure=
-- 
1.8.5.2.8.g0f6c0d1
