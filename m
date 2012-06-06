From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v9 3/4] submodule: fix sync handling of some relative superproject origin URLs
Date: Wed,  6 Jun 2012 21:57:29 +1000
Message-ID: <1338983850-9872-4-git-send-email-jon.seymour@gmail.com>
References: <1338983850-9872-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 13:58:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScEsD-0000Jj-Va
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 13:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab2FFL54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 07:57:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58482 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992Ab2FFL5z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 07:57:55 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8843656pbb.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jbBjwPzHzuOUFuKTRd6fKYaVrcERJLl6iE/lbFUQQiI=;
        b=dcBPpwCf0jIzAr/mifpaA/LM5T5lnVP7D8Lhtw8xMDmnDFakLR9WGnylxyK+vg3gEp
         G+iXAqeh5AjfFdNDVQlKUAWYGW3kKlUBNbhXrCVUccVSuyEovVEygcKIYrfDqP3PM02o
         3z7scBXujbr7imf4ZffCUGsltTT4ue4RqUJFIcW1vanMYd9Uiy2YsgEPpbJkfdzBsVrL
         2L39XxE8vSN6t3Xc5HlolWwZeoTINmdZoayjowWCQ1TYh3GrdVhQ0O7LpvbyB03fNGCP
         GXqpgDUGsmHSkUCf07rREoR0jopW3ulAXCgaP/NhIXMa9jbUyHss3fms3hH3oNvR9All
         sDfQ==
Received: by 10.68.234.35 with SMTP id ub3mr58154776pbc.8.1338983874805;
        Wed, 06 Jun 2012 04:57:54 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([175.103.19.195])
        by mx.google.com with ESMTPS id pg3sm197182pbc.2.2012.06.06.04.57.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 04:57:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.650.g9c513dd.dirty
In-Reply-To: <1338983850-9872-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199315>

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
description of the function's objective.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh          | 48 ++++++++++++++++++++++++++++++++++++++++++-----
 t/t7403-submodule-sync.sh |  8 ++++----
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 64a70d6..227ba59 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,7 +30,22 @@ nofetch=
 update=
 prefix=
 
-# Resolve relative url by appending to parent's url
+# The function takes at most 2 arguments. The first argument is the
+# URL that navigates to the submodule origin repo. When relative, this URL
+# is relative to the superproject origin URL repo. The second up_path 
+# argument, if specified, is the relative path that navigates 
+# from the submodule working tree to the superproject working tree.
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
+	*:*|/*)
+		is_relative=
+		;;
+	*)
+		is_relative=t
+		;;
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
@@ -964,14 +990,26 @@ cmd_sync()
 		# Possibly a url relative to parent
 		case "$url" in
 		./*|../*)
-			url=$(resolve_relative_url "$url") || exit
+			# rewrite foo/bar as ../.. to find path from
+			# submodule work tree to superproject work tree
+			up_path="$(echo "$sm_path" | sed "s/[^/][^/]*/../g")" &&
+			# guarantee a trailing /
+			up_path=${up_path%/}/ &&
+			# path from submodule work tree to submodule origin repo
+			sub_origin_url=$(resolve_relative_url "$url" "$up_path") &&
+			# path from superproject work tree to submodule origin repo
+			super_config_url=$(resolve_relative_url "$url") || exit
+			;;
+		*)
+			sub_origin_url="$url"
+			super_config_url="$url"
 			;;
 		esac
 
 		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
 			say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
-			git config submodule."$name".url "$url"
+			git config submodule."$name".url "$super_config_url"
 
 			if test -e "$sm_path"/.git
 			then
@@ -979,7 +1017,7 @@ cmd_sync()
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
1.7.10.2.650.g9c513dd.dirty
