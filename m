From: "W. Trevor King" <wking@tremily.us>
Subject: [RFC v3 3/4] submodule: Teach 'add' about a configurable local-branch
Date: Wed,  8 Jan 2014 22:17:54 -0800
Message-ID: <75e8c98df73273c2c8174e726e3fc961fbebd6a7.1389247320.git.wking@tremily.us>
References: <20140108040627.GD29954@odin.tremily.us>
 <cover.1389247320.git.wking@tremily.us>
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 09 07:18:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W18x7-0005a6-6l
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 07:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbaAIGSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 01:18:21 -0500
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:36160
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750702AbaAIGST (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 01:18:19 -0500
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id BiJJ1n0020xGWP851iJJRp; Thu, 09 Jan 2014 06:18:18 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta12.westchester.pa.mail.comcast.net with comcast
	id BiJH1n002152l3L3YiJH9h; Thu, 09 Jan 2014 06:18:18 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 5E21CEB6890; Wed,  8 Jan 2014 22:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389248295; bh=Pg/aEzIrvy4g4tBCJrwjoqBkO8T5ruqvTq0CBfxXFpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References;
	b=o10xyvGyOiFOD0UcSfpEg693u8yFB/iv4KJKUn8ucF3BBhOdr8g4aZ4UXbXSa7EmP
	 8dl4YBsG6xLLBp1Z7husN5atCM9ZC3nvozffY3dUQSoBneNjMapSffTkspn0nycoWK
	 eefbS6ThfVardX0CFoQ6RMlxiCe7R68CJxmaRu10=
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1389247320.git.wking@tremily.us>
In-Reply-To: <cover.1389247320.git.wking@tremily.us>
References: <cover.1389247320.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389248298;
	bh=lRKMAFf5QiAfFQkJ+puO5Gth3yRPi5jveNTPlwZPwf0=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=dZqk/fOfEkAtv/fC35Y/AJ2n++6wZAeF1CxAYNUVYYwVW5JYUOZ+bBcSyeY81/pQN
	 U7cXs5CuCZUO5UJZDTLRTGJvV7K+K3+uQIZSwOa/xLlnbTLdQIMwIC8mXf86VkUTyF
	 k8PFW18EuyNxf5dhxVvucSPKQHnsWpFx+fWks9Pf7LjBMCDe1dvN1y8iNyH6vMy+12
	 VzjqsINwtXCyP4LWOMLH+sVAbj/HcMBisXKTeeY5bNfdqTYTvS6CqWs05BNypFuU9+
	 nA7DKBeuGsegVfBl8m8TDfsZ/Jcw/kvXeQVryFzOCDW8lb238GTyoLrzMFKeC+GAbU
	 3iTXeV3gPef4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240247>

From: "W. Trevor King" <wking@tremily.us>

This patch teaches 'git submodule add' to look for a preferred
local-branch, and to checkout that branch after the initial clone.
The local branch will always point at the commit checked out by the
internal 'git clone' operation.  For example:

  $ git submodule add git://example.com/subproject.git submod

will checkout the branch pointed to by the cloned repository's HEAD,
and call the local branch 'master'.

  $ git submodule add -b my-feature git://example.com/subproject.git submod

will checkout the branch pointed to by the cloned repository's
my-feature, and *still* call the local branch 'master'.

'git submodule add' does not always make an initial clone (e.g. if a
git repository already exists at the target path).  In cases where
'git submodule add' does not clone a repository, we just leave the
local branch alone.

This commit also shifts the post-clone branch checkout logic from
cmd_add to module_clone, so it can be shared with cmd_update.  The
previous code only checked out the requested branch in cmd_add but not
in cmd_update; this left the user on a detached HEAD after an update
initially cloned, and subsequent updates kept the HEAD detached,
unless the user moved to the desired branch himself.  Now, unless the
user explicitly asks to work on a detached HEAD, subsequent updates
all happen on the specified branch, which matches the end-user
expectation much better.
---
 git-submodule.sh | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c5ea7bd..7cee0bf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -339,7 +339,19 @@ module_clone()
 	echo "gitdir: $rel/$a" >"$sm_path/.git"
 
 	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
-	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
+	superproject_branch=$(get_current_branch)
+	default_local_branch=$(get_submodule_config "$sm_name" local-branch)
+	(
+		clear_local_git_env
+		cd "$sm_path" &&
+		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
+		local_branch=$(get_local_branch "${superproject_branch}" "${default_local_branch}") &&
+		# ash fails to wordsplit ${branch:+-b "$branch"...}
+		case "$branch" in
+		'') git checkout -f -q -B "$local_branch" ;;
+		?*) git checkout -f -q -B "$local_branch" "origin/$branch" ;;
+		esac
+	) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
 }
 
 isnumber()
@@ -503,15 +515,6 @@ Use -f if you really want to add it." >&2
 			fi
 		fi
 		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
-		(
-			clear_local_git_env
-			cd "$sm_path" &&
-			# ash fails to wordsplit ${branch:+-b "$branch"...}
-			case "$branch" in
-			'') git checkout -f -q ;;
-			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
-			esac
-		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
 	fi
 	git config submodule."$sm_name".url "$realrepo"
 
-- 
1.8.5.2.237.g01c62c6
