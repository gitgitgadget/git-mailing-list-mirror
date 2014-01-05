From: "W. Trevor King" <wking@tremily.us>
Subject: [RFC v2] submodule: Respect requested branch on all clones
Date: Sun,  5 Jan 2014 08:17:00 -0800
Message-ID: <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 05 17:17:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzqOL-0005Fs-39
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 17:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbaAEQRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 11:17:20 -0500
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:44799
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112AbaAEQRH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jan 2014 11:17:07 -0500
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id AGCr1n0060cZkys57GH6KD; Sun, 05 Jan 2014 16:17:06 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id AGH51n004152l3L3WGH5r8; Sun, 05 Jan 2014 16:17:06 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 06BB7E88FB2; Sun,  5 Jan 2014 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388938624; bh=eUQ+I34lubHHcd9uceJR39W3r2Q7ICLLqytw6wAhjoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nEiswoITmtVtSPnbA4lYqXYVncz4XmNb5RA6Uy7FdwUix9ummkp3cJ3qLU6hH3QN/
	 3QuKsZK+kEKOuGMvkTr0AtbT2sINMXxuQYfyb40AvJJJh5fiQWcMRdiADG/Kylx5cW
	 cv7ncXJUGQWykrv1ISYqUfxmsb/zgqOmhwKfXI7M=
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388938626;
	bh=YnES7zh9mJX1AkBYYKkBDGRWdyRr9LkgDXufGXLh2TU=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=b+ci7z1jIBGpYGv4k4lLdVk8A6s8ibRHhhZ3eM7TZJLZmMi30m25LGhvnHS+HLjxu
	 AnYc2ozyvjPzySAf3JAz7gUNRHBC8Sz5smzfHBYQ5PtmYYBv7pdgLu+z44alSeDy/T
	 b0L+hMXYu4X6wOj7f9pYxTsbVWte0vvrzvaqqTAuymCx8+AYEivi12jaM3aQqXiNkm
	 KmDxQVO0Z1xQ24iQ5OgJvKVo1Jrl0c2QAVwVT/bvwZTeTvgN2qB1w/QC/dn+tYhcx8
	 ZuRTGChCH8TWI627uR0gaEatbs5DsmC+w/OrretLHLsTYWUXKgftpxFqbPNx5VLb64
	 djwWXoEGhZdQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239967>

From: "W. Trevor King" <wking@tremily.us>

The previous code only checked out the requested branch in cmd_add.
This commit moves the branch-checkout logic into module_clone, where
it can be shared by cmd_add and cmd_update.  I also update the initial
checkout command to use 'rebase' to preserve branches setup during
module_clone.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
Changes since v1:
* Fix a 'reqested' -> 'requested' typo in the subject/summary.
* Restore a post-clone 'git checkout -f -q' for the empty-branch case
  in module_clone().
* Distinguish between $branch (which defaults to 'master') and a new
  $config_branch (which defaults to empty) in cmd_update

After these fixes, all the existing submodule tests pass.  If we want
to merge this, we'd still want new tests that demonstrate the new
functionality.

On Sun, Jan 05, 2014 at 04:53:12AM +0100, Francesco Pretto wrote:
> If I understand it correctly, looking at your intervention in
> module_clone and cmd_update, when "submodule.<module>.branch" is set
> during "update" the resulting first clone will always be a branch
> checkout (cause $branch is filled with "branch" property).

That's correct.

> I believe this will break a lot of tests,

Thanks for prompting me to run the tests.  This v2 now passes all of
the current submodule tests, and the functionality actually matches my
earlier descriptions of it ;).

> as the the documentation says that in this configuration the HEAD
> should be detached.

The current Documentation/git-submodule.txt has:

  update::
    Update the registered submodules, i.e. clone missing submodules
    and checkout the commit specified in the index of the containing
    repository.  This will make the submodules HEAD be detached unless
    `--rebase` or `--merge` is specified or the key
    `submodule.$name.update` is set to `rebase`, `merge` or `none`.

It's not clear if this refers to the initial-clone update, future
post-clone updates, or both.  Ideally, the behavior should be the
same, but in the initial-clone case we don't have an existing
checked-out branch to work with.

> Also it could break some users that rely on the current behavior.

The current code always has a detached HEAD after an initial-clone
update, regardless of submodule.<name>.update, which doesn't match
those docs either.  Adding a check to only checkout
submodule.<name>.branch if submodule.<name>.update was 'rebase',
'merge', or 'none' would be easy, but I don't think that makes much
sense.  I can't see any reason for folks who specify
submodule.<name>.branch to prefer a detached HEAD over a local branch
matching the remote branch's name.  If they prefer checkout updates,
the first such update will return them to a detached HEAD.  If they
prefer merge/rebase updates, future updates will keep them on the same
branch.  All my commit does is setup that initial branch for folks who
get the submodule via 'update', in the same way it's currently setup
for folks who get the submodule via 'add'.

Cheers,
Trevor

 git-submodule.sh | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..167d4fa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -253,6 +253,7 @@ module_clone()
 	url=$3
 	reference="$4"
 	depth="$5"
+	branch="$6"
 	quiet=
 	if test -n "$GIT_QUIET"
 	then
@@ -306,7 +307,15 @@ module_clone()
 	echo "gitdir: $rel/$a" >"$sm_path/.git"
 
 	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
-	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
+	(
+		clear_local_git_env
+		cd "$sm_path" &&
+		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
+		case "$branch" in
+		'') git checkout -f -q ;;
+		?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
+		esac
+	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
 }
 
 isnumber()
@@ -469,16 +478,7 @@ Use -f if you really want to add it." >&2
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
+		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" "$branch" || exit
 	fi
 	git config submodule."$sm_name".url "$realrepo"
 
@@ -787,7 +787,8 @@ cmd_update()
 		fi
 		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
-		branch=$(get_submodule_config "$name" branch master)
+		config_branch=$(get_submodule_config "$name" branch)
+		branch="${config_branch:-master}"
 		if ! test -z "$update"
 		then
 			update_module=$update
@@ -815,7 +816,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
+			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$config_branch" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
@@ -861,7 +862,12 @@ Maybe you want to use 'update --init'?")"
 			case ";$cloned_modules;" in
 			*";$name;"*)
 				# then there is no local change to integrate
-				update_module= ;;
+				if test -n "$config_branch"; then
+					update_module="!git reset --hard -q"
+				else
+					update_module=
+				fi
+				;;
 			esac
 
 			must_die_on_failure=
-- 
1.8.4.100.gd81c160.dirty
