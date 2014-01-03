From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] submodule: Respect reqested branch on all clones
Date: Fri,  3 Jan 2014 10:06:11 -0800
Message-ID: <dad947caba9e1c49d691ffccc868cfdce7d04e82.1388772192.git.wking@tremily.us>
References: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 19:06:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz98e-0006hm-6L
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 19:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbaACSGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 13:06:24 -0500
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:43754
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039AbaACSGX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jan 2014 13:06:23 -0500
Received: from omta14.westchester.pa.mail.comcast.net ([76.96.62.60])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id 9VTi1n0061HzFnQ5BW6Nmr; Fri, 03 Jan 2014 18:06:22 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta14.westchester.pa.mail.comcast.net with comcast
	id 9W6L1n00f152l3L3aW6MxG; Fri, 03 Jan 2014 18:06:22 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 5F1ECE66D5A; Fri,  3 Jan 2014 10:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388772380; bh=QnAYzQYcsm171GeH43a0eQngGTrPF4LkuLiqYhhjQlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=flxkstOu7tP5ZR5mPUIVd9550IO+flg2VK5BvFc92cefzds6VjVloTxSSFKUfdVwT
	 Td/G0RphdAxobzQBdRtCN4qzAagrmCxKBfzYbIevI5vWojKG0KPQDJBBC4gkHKRh3/
	 w1pdhua4Cdv8CicVGZoWHUJo0yy6dc/39tMiaWqM=
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388772382;
	bh=/PsnOC8T711A0zy14E1hE5b9SqZkC0XQ+/GfbPAEd6E=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=dFrQt/145Fj+pVm9ZIOejQhyenLcg5SUtyKOCx4B7K2MHIIzv7OqdvxzjRAz5EP4D
	 iH9nI+AjDzSZfHaftij0EVFZ6fnnjV8UtLtvu2JBUxVW6Z2V57tqJHJG7GW4PkyYVn
	 cRn48eVMC8ItdBB7/+lfZOmaD6OVz2Dvs0NInNKFOqOsiTyb3Ki6EbEQvL6oT372TE
	 87x8/yxXA6HUa5nG/6kGFEcqKKKUTNvzCJPLgm6FTeQB9y1buibMMcIv5TDxRhDpBF
	 qmgASnJs0yRKiJjLBNRrEZpB4r/r3qnAy6gtkS+RDupS5aSOr3DxAO3fG89QneysFw
	 En8e9s587P8cw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239921>

From: "W. Trevor King" <wking@tremily.us>

The previous code only checked out the requested branch in cmd_add.
This commit moves the branch-checkout logic into module_clone, where
it can be shared by cmd_add and cmd_update.  I also update the initial
checkout command to use 'rebase' to preserve branches setup during
module_clone.

Signed-off-by: W. Trevor King <wking@tremily.us>
---

On Fri, Jan 03, 2014 at 09:49:01AM +0100, Francesco Pretto wrote:
> - there's a developer "update" user. He will clone the submodule
> repository with an *attached* HEAD. Subsequent "merge" or "rebase"
> update operations will keep the HEAD attached.

'merge' and 'rebase' updates don't change the HEAD attachment.
Branches stay branches and detached HEADs stay detached.  If you've
moved away from the 'checkout' update mechanism, the only thing you
still need is a way to get an initial checkout on a branch.  This
should do it (I can add tests if folks like the general approach).

 git-submodule.sh | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..e2e5a6c 100755
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
@@ -306,7 +307,14 @@ module_clone()
 	echo "gitdir: $rel/$a" >"$sm_path/.git"
 
 	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
-	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
+	(
+		clear_local_git_env
+		cd "$sm_path" &&
+		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
+		if test -n "$branch"; then
+			git checkout -f -q -B "$branch" "origin/$branch" && echo "checked out $branch"
+		fi
+	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
 }
 
 isnumber()
@@ -469,16 +477,7 @@ Use -f if you really want to add it." >&2
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
 
@@ -815,7 +814,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
+			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$branch" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
@@ -861,7 +860,12 @@ Maybe you want to use 'update --init'?")"
 			case ";$cloned_modules;" in
 			*";$name;"*)
 				# then there is no local change to integrate
-				update_module= ;;
+				if test -n "$branch"; then
+					update_module="!git reset --hard -q"
+				else
+					update_module=
+				fi
+				;;
 			esac
 
 			must_die_on_failure=
-- 
1.8.5.2.gaa5d535.dirty
