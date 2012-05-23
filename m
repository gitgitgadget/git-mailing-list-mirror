From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 2/2] submodule: fix handling of relative superproject origin URLs
Date: Thu, 24 May 2012 02:45:54 +1000
Message-ID: <1337791554-31294-3-git-send-email-jon.seymour@gmail.com>
References: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 18:46:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXEi0-00075y-6a
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 18:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759678Ab2EWQqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 12:46:33 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57730 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab2EWQqa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 12:46:30 -0400
Received: by dady13 with SMTP id y13so9981647dad.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TT1M77DQBUl+TkShS6FTgDZFhSImu3PSPaOtXckgoEU=;
        b=HqjFq6UKHfMR6L5rSxLhYSIoR5mqm061RDyk0D2/+JjVssoVI3LR6nuAhpjALT6X71
         P95WPXdbJoUT5DcpsPBVWnL6u8buaBhpWyS5xNQVxZW4aMbtmM/xuozBmVapDsXyJV9c
         jX8S8uSsurJZN4PWLQkyRgT6ebXgNy7KrHsR877TXwFLvj09CKdUgquEPqGGeu+wuwrK
         cH3SOVnTS7Ur4yrwSuORfxk9ZzYGECVWXjbsPZQfPVyxYhMdJV2q96lxEtZNMAcDpt37
         QkyToExpYs9clezZXJBSzbrIcLIQbPaGSztoTW5C97wE9Rxpitupjt6sWeEIYdwymsou
         OF9w==
Received: by 10.68.234.73 with SMTP id uc9mr11549280pbc.65.1337791590013;
        Wed, 23 May 2012 09:46:30 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([101.114.128.220])
        by mx.google.com with ESMTPS id ss8sm2352494pbc.43.2012.05.23.09.46.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 09:46:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.594.g24e850d
In-Reply-To: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198309>

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
 git-submodule.sh           | 17 +++++++++++++++--
 t/t7400-submodule-basic.sh | 12 +++++-------
 t/t7403-submodule-sync.sh  | 21 +++++++++++----------
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 64a70d6..3e943de 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -37,6 +37,8 @@ resolve_relative_url ()
 	remoteurl=$(git config "remote.$remote.url") ||
 		remoteurl=$(pwd) # the repository is its own authoritative upstream
 	url="$1"
+	prefix="$2"
+	remoteurl=$(echo "$remoteurl" | sed "s|^[^/:\\.][^:]*\$|./&|")
 	remoteurl=${remoteurl%/}
 	sep=/
 	while test -n "$url"
@@ -45,6 +47,11 @@ resolve_relative_url ()
 		../*)
 			url="${url#../}"
 			case "$remoteurl" in
+			.*/*)
+				remoteurl="${remoteurl%/*}"
+				remoteurl="${remoteurl#./}"
+				remoteurl="${prefix}${remoteurl}"
+				;;
 			*/*)
 				remoteurl="${remoteurl%/*}"
 				;;
@@ -64,7 +71,7 @@ resolve_relative_url ()
 			break;;
 		esac
 	done
-	echo "$remoteurl$sep${url%/}"
+	echo "${remoteurl%/.}$sep${url%/}"
 }
 
 #
@@ -964,8 +971,14 @@ cmd_sync()
 		# Possibly a url relative to parent
 		case "$url" in
 		./*|../*)
+			up_path="$(echo "$sm_path" | sed "s/[^/]*/../g")" &&
+			up_path=${up_path%/}/ &&
+			remoteurl=$(resolve_relative_url "$url" "$up_path") &&
 			url=$(resolve_relative_url "$url") || exit
 			;;
+		*)
+			remoteurl="$url"
+			;;
 		esac
 
 		if git config "submodule.$name.url" >/dev/null 2>/dev/null
@@ -979,7 +992,7 @@ cmd_sync()
 				clear_local_git_env
 				cd "$sm_path"
 				remote=$(get_default_remote)
-				git config remote."$remote".url "$url"
+				git config remote."$remote".url "$remoteurl"
 			)
 			fi
 		fi
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 97e7a73..f2f907f 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -507,17 +507,15 @@ test_expect_success 'relative path works with user@host:path' '
 	)
 '
 
-test_expect_success 'relative path works with foo' "
+test_expect_success 'relative path works with foo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
 		git config remote.origin.url foo &&
-		echo \"cannot strip one component off url 'foo'\" >expect &&
-		test_must_fail git submodule init 2>actual &&
-		cat actual &&
-		test_cmp expect actual
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ./subrepo
 	)
-"
+'
 
 test_expect_success 'relative path works with foo/bar' '
 	(
@@ -545,7 +543,7 @@ test_expect_success 'relative path works with ./foo/bar' '
 		cp pristine-.git-config .git/config &&
 		git config remote.origin.url ./foo/bar &&
 		git submodule init &&
-		test "$(git config submodule.sub.url)" = ./foo/subrepo
+		test "$(git config submodule.sub.url)" = foo/subrepo
 	)
 '
 
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 3784c9b..583fe21 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -88,21 +88,22 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
 	)
 '
 
-test_expect_success '"git submodule sync" handles origin URL of the form foo' "
+test_expect_success '"git submodule sync" handles origin URL of the form foo' '
 	(cd relative-clone &&
 	 git remote set-url origin foo
-	 echo \"cannot strip one component off url 'foo'\" > expect &&
-	 test_must_fail git submodule sync 2> actual &&
-	 test_cmp expect actual
+	 git submodule sync &&
+	(cd submodule &&
+	 test "$(git config remote.origin.url)" == "../submodule"
 	)
-"
+	)
+'
 
 test_expect_success '"git submodule sync" handles origin URL of the form foo/bar' '
 	(cd relative-clone &&
 	 git remote set-url origin foo/bar
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "foo/submodule"
+	 test "$(git config remote.origin.url)" == "../foo/submodule"
 	)
 	)
 '
@@ -112,7 +113,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ./foo'
 	 git remote set-url origin ./foo
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "./submodule"
+	 test "$(git config remote.origin.url)" == "../submodule"
 	)
 	)
 '
@@ -122,7 +123,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ./foo/b
 	 git remote set-url origin ./foo/bar
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "./foo/submodule"
+	 test "$(git config remote.origin.url)" == "../foo/submodule"
 	)
 	)
 '
@@ -132,7 +133,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ../foo'
 	 git remote set-url origin ../foo
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "../submodule"
+	 test "$(git config remote.origin.url)" == "../../submodule"
 	)
 	)
 '
@@ -142,7 +143,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ../foo/
 	 git remote set-url origin ../foo/bar
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "../foo/submodule"
+	 test "$(git config remote.origin.url)" == "../../foo/submodule"
 	)
 	)
 '
-- 
1.7.10.2.594.g24e850d
