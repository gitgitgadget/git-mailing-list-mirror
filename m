From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 2/2] submodule: fix handling of relative superproject origin URLs
Date: Thu, 24 May 2012 13:37:37 +1000
Message-ID: <1337830657-16400-3-git-send-email-jon.seymour@gmail.com>
References: <1337830657-16400-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 05:38:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXOsL-00081O-W4
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 05:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab2EXDiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 23:38:06 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:64392 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab2EXDiF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 23:38:05 -0400
Received: by gglu4 with SMTP id u4so7301727ggl.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 20:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=puIZyS7A6cvX7wVWXM/dtFwJ/SFFBehpb64TZQ4UAcQ=;
        b=uI2qtMHvFCVfmBM6qsVsN3RBi8xVEOxFlp3ed8lh1t4zZtfOyJpp+SOoef55mESzhq
         ntLyM2nZrf1gRFKnjp4dH2LXczwUR2wEo4bslFmm5C0LhKIbOzx7TmLt2ePGA9jrEw26
         pRSCPHHBRduobPJoobz0W2PRcGO38fhuu2Z5jxRKBJGh8h08JGoyafzjRuq01AQfzUyu
         6PjgFyGQ8x2mHrwk3YYqAdbynNJS1Fhnuvh9g544tnS3KMbgXi1IIsDXzdnwqU8j56Rk
         5yJ+T2iKsYltPKEVeXI9GGunDzCObBvKKcvwlO3jSwgILz3EXyLmolss+VhR4AkH/AIu
         LUNA==
Received: by 10.43.69.12 with SMTP id ya12mr12314218icb.50.1337830683921;
        Wed, 23 May 2012 20:38:03 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([1.142.1.227])
        by mx.google.com with ESMTPS id if4sm14062525igc.10.2012.05.23.20.38.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 20:38:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.649.g5ca7d80
In-Reply-To: <1337830657-16400-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198345>

When the origin URL of the superproject is itself relative, an operation
such as git submodule add, init or sync may result in either the
submodule.{name}.url configuration property of the superproject
referring to the incorrect location or remote.origin.url configuration
property of the submodule referring to the incorrect location or both
these conditions. In some cases, git submodule fails to update
the configuration and fails with an error condition.

The issue arises in these cases because the origin URL of
the superproject needs to be prepended with a prefix that navigates
from the submodule to the superproject so that when the submodule
URL is concatenated the resulting URL is relative to the working tree
of the submodule.

This change fixes handling for relative superproject origin URLs
for 6 cases:
  foo
  foo/bar
  ./foo
  ./foo/bar
  ../foo
  ../foo/bar

In each case, the configuration properties in the superproject's
configuration and the submodule's configuration refer to the
correct, relative, location of the submodule's origin repo. In all cases,
the configured paths are relative to the working trees of the
repositories containing the configuration.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh           | 57 +++++++++++++++++++++++++++++++++++++++++-----
 t/t7400-submodule-basic.sh |  6 ++---
 t/t7403-submodule-sync.sh  | 18 +++++----------
 3 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 64a70d6..738eba3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,13 +30,35 @@ nofetch=
 update=
 prefix=
 
-# Resolve relative url by appending to parent's url
+# Resolve relative url by appending the submodule url
+# to the superproject's origin URL
+#
+# If the origin URL is itself a relative URL prepend
+# an additional prefix, if present, that represents
+# the relative path from the submodule's working tree
+# to the superprojects' working tree.
+#
+# This behaviour is required to ensure that the origin URL
+# of a submodule, when relative, is relative to the
+# submodule's work tree and not to the superproject's work tree.
+#
 resolve_relative_url ()
 {
 	remote=$(get_default_remote)
 	remoteurl=$(git config "remote.$remote.url") ||
 		remoteurl=$(pwd) # the repository is its own authoritative upstream
 	url="$1"
+	up_path="$2"
+
+	#
+	# ensure all relative paths begin with ./ to enable
+	# selection relative branch of subsequent case "$remoteurl"
+	# statement.
+	#
+	# rewrites foo/bar to ./foo/bar but leaves /foo, :foo ./foo
+	# and ../foo untouched.
+	#
+	remoteurl=$(echo "$remoteurl" | sed "s|^[^/:\\.][^:]*\$|./&|")
 	remoteurl=${remoteurl%/}
 	sep=/
 	while test -n "$url"
@@ -45,6 +67,16 @@ resolve_relative_url ()
 		../*)
 			url="${url#../}"
 			case "$remoteurl" in
+			.*/*)
+				# remove last part
+				remoteurl="${remoteurl%/*}"
+				# remove redundant leading ./
+				remoteurl="${remoteurl#./}"
+				# prefix path from submodule work tree to superproject work tree
+				remoteurl="${up_path}${remoteurl}"
+				# remove trailing /.
+				remoteurl="${remoteurl%/.}"
+				;;
 			*/*)
 				remoteurl="${remoteurl%/*}"
 				;;
@@ -959,19 +991,32 @@ cmd_sync()
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
@@ -979,7 +1024,7 @@ cmd_sync()
 				clear_local_git_env
 				cd "$sm_path"
 				remote=$(get_default_remote)
-				git config remote."$remote".url "$url"
+				git config remote."$remote".url "$sub_origin_url"
 			)
 			fi
 		fi
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 08b8d2f..f2f907f 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -507,12 +507,11 @@ test_expect_success 'relative path works with user@host:path' '
 	)
 '
 
-test_expect_failure 'relative path works with foo' '
+test_expect_success 'relative path works with foo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
 		git config remote.origin.url foo &&
-		# actual: fails with an error
 		git submodule init &&
 		test "$(git config submodule.sub.url)" = ./subrepo
 	)
@@ -538,13 +537,12 @@ test_expect_success 'relative path works with ./foo' '
 	)
 '
 
-test_expect_failure 'relative path works with ./foo/bar' '
+test_expect_success 'relative path works with ./foo/bar' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
 		git config remote.origin.url ./foo/bar &&
 		git submodule init &&
-		#actual: ./foo/subrepo
 		test "$(git config submodule.sub.url)" = foo/subrepo
 	)
 '
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 9fa4e58..9526f8d 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -88,72 +88,66 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form foo' '
+test_expect_success '"git submodule sync" handles origin URL of the form foo' '
 	(cd relative-clone &&
 	 git remote set-url origin foo
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual fails with: "cannot strip off url foo
 	 git config remote.origin.url &&
 	 test "$(git config remote.origin.url)" == "../submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form foo/bar' '
+test_expect_success '"git submodule sync" handles origin URL of the form foo/bar' '
 	(cd relative-clone &&
 	 git remote set-url origin foo/bar
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual foo/submodule
 	 git config remote.origin.url &&
 	 test "$(git config remote.origin.url)" == "../foo/submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ./foo' '
+test_expect_success '"git submodule sync" handles origin URL of the form ./foo' '
 	(cd relative-clone &&
 	 git remote set-url origin ./foo
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual ./submodule
 	 git config remote.origin.url &&
 	 test "$(git config remote.origin.url)" == "../submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ./foo/bar' '
+test_expect_success '"git submodule sync" handles origin URL of the form ./foo/bar' '
 	(cd relative-clone &&
 	 git remote set-url origin ./foo/bar
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual ./foo/submodule
 	 git config remote.origin.url &&
 	 test "$(git config remote.origin.url)" == "../foo/submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ../foo' '
+test_expect_success '"git submodule sync" handles origin URL of the form ../foo' '
 	(cd relative-clone &&
 	 git remote set-url origin ../foo
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual ../submodule
 	 git config remote.origin.url &&
 	 test "$(git config remote.origin.url)" == "../../submodule"
 	)
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ../foo/bar' '
+test_expect_success '"git submodule sync" handles origin URL of the form ../foo/bar' '
 	(cd relative-clone &&
 	 git remote set-url origin ../foo/bar
 	 git submodule sync &&
 	(cd submodule &&
-	 #actual ../foo/submodule
 	 git config remote.origin.url &&
 	 test "$(git config remote.origin.url)" == "../../foo/submodule"
 	)
-- 
1.7.10.2.649.g5ca7d80
