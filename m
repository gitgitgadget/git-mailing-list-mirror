From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 3/4] submodules: refactor computation of relative gitdir
 path
Date: Sun, 04 Mar 2012 22:15:36 +0100
Message-ID: <4F53DB78.1010109@web.de>
References: <4F53DA95.2020402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 22:15:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4ImO-0001yV-El
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 22:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab2CDVPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 16:15:40 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:53773 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755267Ab2CDVPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 16:15:39 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id 6832773222CC
	for <git@vger.kernel.org>; Sun,  4 Mar 2012 22:15:38 +0100 (CET)
Received: from [192.168.178.48] ([91.3.220.167]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M1FqS-1SNszg2pOy-00u2fm; Sun, 04 Mar 2012 22:15:36
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F53DA95.2020402@web.de>
X-Provags-ID: V02:K0:7NPStsEK5n2Thyw9obCoZKq2MC1vGOlbe5QPCWOXJam
 J03UmZnqN1xuT9EYARQFE+MyXBN6OFXhW93dGE6O5CnZw/c+ta
 /O/7iFVkrBXZrw7kau11yvBuHahrtCBAqvhIwW90FugV5omRkQ
 EIf9v79pYCCEYabpQXmzgvHraM8fnyemuOhsPSc2XiTx5ogeMo
 z+HblV89v/44x/1+zL46g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192176>

In module_clone() the rel_gitdir variable was computed differently when
"git rev-parse --git-dir" returned a relative path than when it returned
an absolute path. This is not optimal, as different code paths are used
depending on the return value of that command.

Fix that by reusing the differing path components computed for setting the
core.worktree config setting, which leaves a single code path for setting
both instead of having three and makes the code much shorter.

This also fixes the bug that in the computation of how many directories
have to be traversed up to hit the root directory of the submodule the
name of the submodule was used where the path should have been used. This
lead to problems after renaming submodules into another directory level.

Even though the "(cd $somewhere && pwd)" approach breaks the flexibility
of symlinks, that is no issue here as we have to have one relative path
pointing from the work tree to the gitdir and another pointing back, which
will never work anyway when a symlink along one of those paths is changed
because the directory it points to was moved.

Also add a test moving a submodule into a deeper directory to catch any
future breakage here and to document what has to be done when a submodule
needs to be moved until git mv learns to do that. Simply moving it to the
new location doesn't work, as the core.worktree and possibly the gitfile
setting too will be wrong. So it has to be removed from filesystem and
index, then the new location has to be added into the index and the
.gitmodules file has to be updated. After that a git submodule update will
check out the submodule at the new location.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-submodule.sh            |   30 ++++++------------------------
 t/t7406-submodule-update.sh |   17 +++++++++++++++++
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c405caa..a9e9822 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -132,30 +132,11 @@ module_clone()
 	gitdir_base=
 	name=$(module_name "$path" 2>/dev/null)
 	test -n "$name" || name="$path"
-	base_path=$(dirname "$path")
+	base_name=$(dirname "$name")

 	gitdir=$(git rev-parse --git-dir)
-	gitdir_base="$gitdir/modules/$base_path"
-	gitdir="$gitdir/modules/$path"
-
-	case $gitdir in
-	/*)
-		a="$(cd_to_toplevel && pwd)/"
-		b=$gitdir
-		while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
-		do
-			a=${a#*/} b=${b#*/};
-		done
-
-		rel="$a$name"
-		rel=`echo $rel | sed -e 's|[^/]*|..|g'`
-		rel_gitdir="$rel/$b"
-		;;
-	*)
-		rel=`echo $name | sed -e 's|[^/]*|..|g'`
-		rel_gitdir="$rel/$gitdir"
-		;;
-	esac
+	gitdir_base="$gitdir/modules/$base_name"
+	gitdir="$gitdir/modules/$name"

 	if test -d "$gitdir"
 	then
@@ -168,8 +149,6 @@ module_clone()
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
 	fi

-	echo "gitdir: $rel_gitdir" >"$path/.git"
-
 	a=$(cd "$gitdir" && pwd)/
 	b=$(cd "$path" && pwd)/
 	# Remove all common leading directories after a sanity check
@@ -185,6 +164,9 @@ module_clone()
 	a=${a%/}
 	b=${b%/}

+	rel=$(echo $b | sed -e 's|[^/]*|..|g')
+	echo "gitdir: $rel/$a" >"$path/.git"
+
 	rel=$(echo $a | sed -e 's|[^/]*|..|g')
 	(clear_local_git_env; cd "$path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
 }
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 5b97222..dcb195b 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -619,4 +619,21 @@ test_expect_success 'submodule add properly re-creates deeper level submodules'
 	)
 '

+test_expect_success 'submodule update properly revives a moved submodule' '
+	(cd super &&
+	 git commit -am "pre move" &&
+	 git status >expect&&
+	 H=$(cd submodule2; git rev-parse HEAD) &&
+	 git rm --cached submodule2 &&
+	 rm -rf submodule2 &&
+	 mkdir -p "moved/sub module" &&
+	 git update-index --add --cacheinfo 160000 $H "moved/sub module" &&
+	 git config -f .gitmodules submodule.submodule2.path "moved/sub module"
+	 git commit -am "post move" &&
+	 git submodule update &&
+	 git status >actual &&
+	 test_cmp expect actual
+	)
+'
+
 test_done
-- 
1.7.9.2.362.g684a8
