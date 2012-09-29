From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/2] Teach "git submodule add" the --name option
Date: Sun, 30 Sep 2012 01:05:58 +0200
Message-ID: <50677ED6.1030001@web.de>
References: <BC634E06939C44239106E7A8DD229130@gmail.com> <50636C00.6080906@web.de> <50677E76.1050204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Johnson <me@jondavidjohn.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 01:06:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TI66u-0003my-7G
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 01:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab2I2XGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 19:06:01 -0400
Received: from mout.web.de ([212.227.17.11]:60760 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2I2XGA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 19:06:00 -0400
Received: from [192.168.178.41] ([91.3.175.36]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MIvJx-1TK0z92Ma9-002JLy; Sun, 30 Sep 2012 01:05:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <50677E76.1050204@web.de>
X-Provags-ID: V02:K0:zx/Uj0GqbHPEa0Xe8DTTemo1mBQtgsmGjFRGGO5DURI
 09sMaGvfQYYc+8xzVJIMBpt1LLSrYlks6JWj/+P0vkYUV+SRqv
 ZSLOQrjkOKGF63enEXQMpUCXLfT36Bc1zWdL2ZrVLt8sMxXKWc
 vK5kMiVCBiph5DMqicn1853/jp1rqT+kkDVNU+ZSlLEXX2yrVH
 mLD46USlDAqUeZaHCRYmw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206659>

"git submodule add" initializes the name of a submodule to its path. This
was ok as long as the .git directory lived inside the submodule's work
tree, but since 1.7.8 it is stored in the .git/modules/<name> directory of
the superproject, making the submodule name survive the removal of the
submodule's work tree. This leads to problems when the user tries to add a
different submodule at the same path - and thus the same name - later, as
that will happily try to restore the submodule from the old repository
instead of the one the user specified and will lead to a checkout of the
wrong repository.

Add the new "--name" option to let the user provide a name for the
submodule. This enables the user to solve this conflict without having to
remove .git/modules/<name> by hand (which is no viable solution as it
makes it impossible to checkout a commit that records the old submodule
and populate it, as that will still check out the new submodule for the
same reason).

To achieve that the submodule's name is added to the parameter list of
the module_clone() helper function. This makes it possible to remove the
call of module_name() there because both callers of module_clone() already
know the name and can provide it as argument number two.

Reported-by: Jonathan Johnson <me@jondavidjohn.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-submodule.txt |  7 ++++++-
 Documentation/gitmodules.txt    |  4 +++-
 git-submodule.sh                | 32 ++++++++++++++++++++---------
 t/t7400-submodule-basic.sh      | 45 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2de7bf0..22efca0 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b branch] [-f|--force]
+'git submodule' [--quiet] add [-b branch] [-f|--force] [--name <name>]
 	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
@@ -266,6 +266,11 @@ OPTIONS
 	Initialize all submodules for which "git submodule init" has not been
 	called so far before updating.

+--name::
+	This option is only valid for the add command. It sets the submodule's
+	name to the given string instead of defaulting to its path. The name
+	must be valid as a directory name and may not end with a '/'.
+
 --reference <repository>::
 	This option is only valid for add and update commands.  These
 	commands sometimes need to clone a remote repository. In this case,
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 4effd78..ab3e91c 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -18,7 +18,9 @@ working tree, is a text file with a syntax matching the requirements
 of linkgit:git-config[1].

 The file contains one subsection per submodule, and the subsection value
-is the name of the submodule. Each submodule section also contains the
+is the name of the submodule. The name is set to the path where the
+submodule has been added unless it was customized with the '--name'
+option of 'git submodule add'. Each submodule section also contains the
 following required keys:

 submodule.<name>.path::
diff --git a/git-submodule.sh b/git-submodule.sh
index 3e2045e..22febb1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli

 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] add [-b branch] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
@@ -29,6 +29,7 @@ files=
 nofetch=
 update=
 prefix=
+custom_name=

 # The function takes at most 2 arguments. The first argument is the
 # URL that navigates to the submodule origin repo. When relative, this URL
@@ -179,8 +180,9 @@ module_name()
 module_clone()
 {
 	sm_path=$1
-	url=$2
-	reference="$3"
+	name=$2
+	url=$3
+	reference="$4"
 	quiet=
 	if test -n "$GIT_QUIET"
 	then
@@ -189,8 +191,6 @@ module_clone()

 	gitdir=
 	gitdir_base=
-	name=$(module_name "$sm_path" 2>/dev/null)
-	test -n "$name" || name="$sm_path"
 	base_name=$(dirname "$name")

 	gitdir=$(git rev-parse --git-dir)
@@ -272,6 +272,11 @@ cmd_add()
 			reference="$1"
 			shift
 			;;
+		--name)
+			case "$2" in '') usage ;; esac
+			custom_name=$2
+			shift
+			;;
 		--)
 			shift
 			break
@@ -336,6 +341,13 @@ Use -f if you really want to add it." >&2
 		exit 1
 	fi

+	if test -n "$custom_name"
+	then
+		sm_name="$custom_name"
+	else
+		sm_name="$sm_path"
+	fi
+
 	# perhaps the path exists and is already a git repo, else clone it
 	if test -e "$sm_path"
 	then
@@ -348,7 +360,7 @@ Use -f if you really want to add it." >&2

 	else

-		module_clone "$sm_path" "$realrepo" "$reference" || exit
+		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" || exit
 		(
 			clear_local_git_env
 			cd "$sm_path" &&
@@ -359,13 +371,13 @@ Use -f if you really want to add it." >&2
 			esac
 		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
 	fi
-	git config submodule."$sm_path".url "$realrepo"
+	git config submodule."$sm_name".url "$realrepo"

 	git add $force "$sm_path" ||
 	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"

-	git config -f .gitmodules submodule."$sm_path".path "$sm_path" &&
-	git config -f .gitmodules submodule."$sm_path".url "$repo" &&
+	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
+	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 }
@@ -594,7 +606,7 @@ Maybe you want to use 'update --init'?")"

 		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$url" "$reference"|| exit
+			module_clone "$sm_path" "$name" "$url" "$reference" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 56a81cd..78bf739 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -681,4 +681,49 @@ test_expect_success 'moving the superproject does not break submodules' '
 	)
 '

+test_expect_success 'submodule add --name allows to replace a submodule with another at the same path' '
+	(
+		cd addtest2 &&
+		(
+			cd repo &&
+			echo "$submodurl/repo" >expect &&
+			git config remote.origin.url >actual &&
+			test_cmp expect actual &&
+			echo "gitdir: ../.git/modules/repo" >expect &&
+			test_cmp expect .git
+		) &&
+		rm -rf repo &&
+		git rm repo &&
+		git submodule add -q --name repo_new "$submodurl/bare.git" repo >actual &&
+		test ! -s actual &&
+		echo "gitdir: ../.git/modules/submod" >expect &&
+		test_cmp expect submod/.git &&
+		(
+			cd repo &&
+			echo "$submodurl/bare.git" >expect &&
+			git config remote.origin.url >actual &&
+			test_cmp expect actual &&
+			echo "gitdir: ../.git/modules/repo_new" >expect &&
+			test_cmp expect .git
+		) &&
+		echo "repo" >expect &&
+		git config -f .gitmodules submodule.repo.path >actual &&
+		test_cmp expect actual &&
+		git config -f .gitmodules submodule.repo_new.path >actual &&
+		test_cmp expect actual&&
+		echo "$submodurl/repo" >expect &&
+		git config -f .gitmodules submodule.repo.url >actual &&
+		test_cmp expect actual &&
+		echo "$submodurl/bare.git" >expect &&
+		git config -f .gitmodules submodule.repo_new.url >actual &&
+		test_cmp expect actual &&
+		echo "$submodurl/repo" >expect &&
+		git config submodule.repo.url >actual &&
+		test_cmp expect actual &&
+		echo "$submodurl/bare.git" >expect &&
+		git config submodule.repo_new.url >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
1.7.12.1.430.g4fd6dc4
