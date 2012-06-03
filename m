From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 3/4] submodule: fix sync handling of some relative superproject origin URLs
Date: Sun,  3 Jun 2012 19:46:49 +1000
Message-ID: <1338716810-9881-4-git-send-email-jon.seymour@gmail.com>
References: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 11:47:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb7P8-000631-GD
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 11:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab2FCJrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 05:47:18 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60718 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab2FCJrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 05:47:16 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4601633dad.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QlHWBfvAS3i+nO4zVZoEuKDH1BIb54jSsOdcxi1caNk=;
        b=U6eaUyhYy54DkQFtKouR2hFBkPMtWnxFEmCaMTIwZAfzc5V/xAeIxFVJSCWHo8FbS5
         jGbe6YFcETjAF0bpZpWwWafCbO9RzQoZ7ollbVLbr1MI8Cu+s2PXTzowsAOjbega8nLr
         oKXkPNozuLElSqXtvwcSjKo6tX+nZOmDD9Z4zu7Qkhejq4UhfgvR0TxzgkUk8+eXSB3m
         okKxenZkQal6QGSfEnxof5dDgxhokSDq8YqcicbnLGV30gfhXK/OP+OvcxIx7EDzB7aT
         Xm/uE+yXUE2FbriWCSBos0coXhmMco06YmABFb63neeDR8ItW62DCaGHxCsj8FN8j8oN
         3g0Q==
Received: by 10.68.237.166 with SMTP id vd6mr27493259pbc.139.1338716836529;
        Sun, 03 Jun 2012 02:47:16 -0700 (PDT)
Received: from ubuntu.au.ibm.com (202-159-159-155.dyn.iinet.net.au. [202.159.159.155])
        by mx.google.com with ESMTPS id pb10sm8385550pbc.68.2012.06.03.02.47.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jun 2012 02:47:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.651.g2c84487
In-Reply-To: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199077>

When the origin URL of the superproject is itself relative, git submodule sync
configures the remote.origin.url configuration property of the submodule
with a path that is relative to the work tree of the superproject
rather than the work tree of the submodule.

To fix this an 'up_path' that navigates from the work tree of the submodule
to the work tree of the superproject needs to be prepended to the URL
otherwise calculated.

Correct handling of superproject origin URLs like foo, ./foo and ./foo/bar is
left to a subsequent patch since an additional change is required to handle
these cases.

The documentation of resolve_relative_url() is expanded to give a more thorough
description of the function's objective is intended to be.

This change also renames the url variable used by cmd_sync() to module_url
and introduces two new variables super_config_url and sub_origin_url to help
explain the purpose of the different urls derived from the module_url.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh          | 53 ++++++++++++++++++++++++++++++++++++++++-------
 t/t7403-submodule-sync.sh |  8 +++----
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 64a70d6..314df20 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,7 +30,22 @@ nofetch=
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
@@ -39,6 +54,17 @@ resolve_relative_url ()
 	url="$1"
 	remoteurl=${remoteurl%/}
 	sep=/
+	up_path="$2"
+
+	case "$remoteurl" in
+		*:*|/*)
+			is_relative=
+			;;
+		*)
+			is_relative=t
+			;;
+	esac
+
 	while test -n "$url"
 	do
 		case "$url" in
@@ -64,7 +90,7 @@ resolve_relative_url ()
 			break;;
 		esac
 	done
-	echo "$remoteurl$sep${url%/}"
+	echo "${is_relative:+${up_path}}$remoteurl$sep${url%/}"
 }
 
 #
@@ -959,19 +985,32 @@ cmd_sync()
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
@@ -979,7 +1018,7 @@ cmd_sync()
 				clear_local_git_env
 				cd "$sm_path"
 				remote=$(get_default_remote)
-				git config remote."$remote".url "$url"
+				git config remote."$remote".url "$sub_origin_url"
 			)
 			fi
 		fi
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 56b933d..98bc74a 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -99,7 +99,7 @@ test_expect_failure '"git submodule sync" handles origin URL of the form foo' '
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form foo/bar' '
+test_expect_success '"git submodule sync" handles origin URL of the form foo/bar' '
 	(cd relative-clone &&
 	 git remote set-url origin foo/bar &&
 	 git submodule sync &&
@@ -132,7 +132,7 @@ test_expect_failure '"git submodule sync" handles origin URL of the form ./foo/b
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ../foo' '
+test_expect_success '"git submodule sync" handles origin URL of the form ../foo' '
 	(cd relative-clone &&
 	 git remote set-url origin ../foo &&
 	 git submodule sync &&
@@ -143,7 +143,7 @@ test_expect_failure '"git submodule sync" handles origin URL of the form ../foo'
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ../foo/bar' '
+test_expect_success '"git submodule sync" handles origin URL of the form ../foo/bar' '
 	(cd relative-clone &&
 	 git remote set-url origin ../foo/bar &&
 	 git submodule sync &&
@@ -154,7 +154,7 @@ test_expect_failure '"git submodule sync" handles origin URL of the form ../foo/
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ../foo/bar with deeply nested submodule' '
+test_expect_success '"git submodule sync" handles origin URL of the form ../foo/bar with deeply nested submodule' '
 	(cd relative-clone &&
 	 git remote set-url origin ../foo/bar &&
 	 mkdir -p a/b/c &&
-- 
1.7.10.2.652.gdffd412
