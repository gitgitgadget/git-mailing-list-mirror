From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 7/9] submodule: fix sync handling of relative superproject origin URLs
Date: Mon, 28 May 2012 01:34:09 +1000
Message-ID: <1338132851-23497-8-git-send-email-jon.seymour@gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 17:36:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYfVs-0006Ww-Gs
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 17:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab2E0PfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 11:35:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59885 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab2E0Pes (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 11:34:48 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3669135pbb.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=03lgfEla2UhyLMf1bFkOJ6vXocJ2dJihCKkWcrHOmu4=;
        b=vTyNIAZ4Xuci+t2P6H67O3VKkWQEhWvyz0LcO6uQZ+OM06FoJlSreW3ShQQWst4NF+
         GR9aL2HuoHXxcWD0CKkCg3d8jpZWyACQe74fwvN6oxzXHZrqTUIGTzFwFktkPEJDrD+s
         kqvg2PEkw4OgaMm3ALoYhVToW4sxdhZcxepkL4inXp+aXKm9EKeCZEgR8cTn66dXSs85
         1jt74DHJBXTaQQYreBWGK+NR4C9huehQAQj5MU18L4dPvsAStCWhov3F0IHHxIDF3iFi
         jjdggWw5iSPXvMswZt+UD8gnODVnzQqRNKefhUADAbBXSLayYg5eJslmwnImgmm0z73H
         RG1g==
Received: by 10.68.231.195 with SMTP id ti3mr18062037pbc.96.1338132888464;
        Sun, 27 May 2012 08:34:48 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id rk4sm16128261pbc.48.2012.05.27.08.34.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 08:34:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.g24a6219
In-Reply-To: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198611>

When the origin URL of the superproject is itself relative, git submodule sync
configures the remote.origin.url configuration property of the submodule
with a path that is relative to the work tree of the superproject
rather than the work tree of the submodule.

To fix this an 'up_path' that navigates from the work tree of the submodule
to the work tree of the superproject needs to be prepended to the URL
otherwise calculated.

This change fixes handling for relative superproject origin URLs like
the following:
      foo
      foo/bar
      ./foo
      ./foo/bar
      ../foo
      ../foo/bar

This change also renames the url variable used by git sync to module_url
and introduces to new variables super_config_url and sub_origin_url to refer
to the different URLs derived from the module_url.

The function blurb is expanded to give a more thorough description of what
resolve_relative_url()'s function is intended to be.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh          | 48 ++++++++++++++++++++++++++++++++++++++++-------
 t/t7403-submodule-sync.sh | 23 ++++++++---------------
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2550681..9ca2ffe 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,14 +30,32 @@ nofetch=
 update=
 prefix=
 
-# Resolve relative url by appending to parent's url
+# The function takes at most 2 arguments. The first argument is the
+# relative URL that navigates from the superproject origin repo to the
+# submodule origin repo. The second up_path argument, if specified, is
+# the relative path that navigates from the submodule working tree to
+# the superproject working tree.
+#
+# The output of the function is the origin URL of the submodule.
+#
+# The output will either be an absolute URL or filesystem path (if the
+# superproject origin URL is an absolute URL or filesystem path,
+# respectively) or a relative file system path (if the superproject
+# origin URL is a relative file system path).
+#
+# When the output is a relative file system path, the path is either
+# relative to the submodule working tree, if up_path is specified, or to
+# the superproject working tree otherwise.
 resolve_relative_url ()
 {
 	remote=$(get_default_remote)
 	remoteurl=$(git config "remote.$remote.url") ||
 		remoteurl=$(pwd) # the repository is its own authoritative upstream
 	url="$1"
+	up_path="$2"
+
 	remoteurl="${remoteurl%/}"
+	is_relative=
 
 	case "$remoteurl" in
 		*//*/*)
@@ -54,6 +72,7 @@ resolve_relative_url ()
 		;;
 		*)
 			variant="${remoteurl}"
+			is_relative=t
 		;;
 	esac
 	invariant="${remoteurl%$variant}"
@@ -83,11 +102,13 @@ resolve_relative_url ()
 			break;;
 		esac
 	done
+
 	# ensure a trailing path separator
 	variant="${variant}/"
 	# strip the sentinel, if present
 	variant="${variant#./}"
-	echo "$invariant$variant${url%/}"
+
+	echo "$invariant${is_relative:+$up_path}$variant${url%/}"
 }
 
 #
@@ -986,19 +1007,32 @@ cmd_sync()
 	while read mode sha1 stage sm_path
 	do
 		name=$(module_name "$sm_path")
-		url=$(git config -f .gitmodules --get submodule."$name".url)
+		# path from superproject origin repo to submodule origin repo
+		module_url=$(git config -f .gitmodules --get submodule."$name".url)
 
 		# Possibly a url relative to parent
-		case "$url" in
+		case "$module_url" in
 		./*|../*)
-			url=$(resolve_relative_url "$url") || exit
+			# rewrite foo/bar as ../.. to find path from
+			# submodule work tree to superproject work tree
+			up_path="$(echo "$sm_path" | sed "s/[^/]*/../g")" &&
+			# guarantee a trailing /
+			up_path=${up_path%/}/ &&
+			# path from submodule work tree to submodule origin repo
+			sub_origin_url=$(resolve_relative_url "$module_url" "$up_path") &&
+			# path from superproject work tree to submodule origin repo
+			super_config_url=$(resolve_relative_url "$module_url") || exit
+			;;
+		*)
+			sub_origin_url="$module_url"
+			super_config_url="$module_url"
 			;;
 		esac
 
 		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
 			say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
-			git config submodule."$name".url "$url"
+			git config submodule."$name".url "$super_config_url"
 
 			if test -e "$sm_path"/.git
 			then
@@ -1006,7 +1040,7 @@ cmd_sync()
 				clear_local_git_env
 				cd "$sm_path"
 				remote=$(get_default_remote)
-				git config remote."$remote".url "$url"
+				git config remote."$remote".url "$sub_origin_url"
 			)
 			fi
 		fi
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 56b933d..b7466ba 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -88,73 +88,67 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form foo' '
+test_expect_success '"git submodule sync" handles origin URL of the form foo' '
 	(cd relative-clone &&
 	 git remote set-url origin foo &&
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual fails with: "cannot strip off url foo
 	 test "$(git config remote.origin.url)" = "../submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form foo/bar' '
+test_expect_success '"git submodule sync" handles origin URL of the form foo/bar' '
 	(cd relative-clone &&
 	 git remote set-url origin foo/bar &&
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual foo/submodule
 	 test "$(git config remote.origin.url)" = "../foo/submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ./foo' '
+test_expect_success '"git submodule sync" handles origin URL of the form ./foo' '
 	(cd relative-clone &&
 	 git remote set-url origin ./foo &&
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual ./submodule
 	 test "$(git config remote.origin.url)" = "../submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ./foo/bar' '
+test_expect_success '"git submodule sync" handles origin URL of the form ./foo/bar' '
 	(cd relative-clone &&
 	 git remote set-url origin ./foo/bar &&
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual ./foo/submodule
 	 test "$(git config remote.origin.url)" = "../foo/submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ../foo' '
+test_expect_success '"git submodule sync" handles origin URL of the form ../foo' '
 	(cd relative-clone &&
 	 git remote set-url origin ../foo &&
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual ../submodule
 	 test "$(git config remote.origin.url)" = "../../submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ../foo/bar' '
+test_expect_success '"git submodule sync" handles origin URL of the form ../foo/bar' '
 	(cd relative-clone &&
 	 git remote set-url origin ../foo/bar &&
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual ../foo/submodule
 	 test "$(git config remote.origin.url)" = "../../foo/submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ../foo/bar with deeply nested submodule' '
+test_expect_success '"git submodule sync" handles origin URL of the form ../foo/bar with deeply nested submodule' '
 	(cd relative-clone &&
 	 git remote set-url origin ../foo/bar &&
 	 mkdir -p a/b/c &&
@@ -167,11 +161,10 @@ test_expect_failure '"git submodule sync" handles origin URL of the form ../foo/
 	 git submodule add ../bar/a/b/c ./a/b/c &&
 	 git submodule sync &&
 	(cd a/b/c &&
-	 #actual ../foo/bar/a/b/c
 	 test "$(git config remote.origin.url)" = "../../../../foo/bar/a/b/c"
 	)
 	)
 '
 
-
 test_done
+<
-- 
1.7.10.2.656.g24a6219
