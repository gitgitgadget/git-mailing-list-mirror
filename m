From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 2/4] submodule: support superproject origin URLs of the form ./foo/bar or ../foo/bar
Date: Mon, 21 May 2012 23:31:40 +1000
Message-ID: <1337607102-14737-2-git-send-email-jon.seymour@gmail.com>
References: <1337607102-14737-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 15:32:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWSid-0005qO-K9
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 15:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab2EUNcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 09:32:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41980 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab2EUNcF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 09:32:05 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6944386pbb.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JF33vNKXs0L//aAWTdKXefVPiLVGYyYo0jGDSAdr5OE=;
        b=n/GRfA/k5a3gSdGwMYPZrYngfpMarZbDw23Ucy6lOoUX1YDnAbvzTm8ydRLxYxGs+L
         YnPbEK+CoOh60JFOKueFhLfF6riMhOpekDsuA8QRmxqw7NRr59+Gyd/ZZRdjvleHsHhb
         0+Yh0sgjMkdIc/onl9NKXoQHnJ65mg0diGbdTwKqIwiK2W11t33swWXfdHfoioplvevD
         2sdCXf6oiesTtAkP07MD+Dy9StWiKqeeFqZCc4TG+Bq7fBKR7aqfQJccz/9xyAiB3W+f
         ae+ZP2Zdgd5MnAy7JVcJbU2jdC0EF86dPT+SDjtMOmw5LFnJBmpcMGES5j/Q3/FUFbzY
         X3Og==
Received: by 10.68.134.132 with SMTP id pk4mr15854004pbb.10.1337607125187;
        Mon, 21 May 2012 06:32:05 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([110.173.237.195])
        by mx.google.com with ESMTPS id wi8sm23153721pbc.11.2012.05.21.06.32.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 May 2012 06:32:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.594.g5c52315
In-Reply-To: <1337607102-14737-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198103>

When the origin URL of the superproject is itself relative, an operation
such as git submodule add, init or sync produces a relative
URL for the submodule that doesn't point at the correct location.

The issue arises in these cases because the origin URL of
the superproject needs to be prepended with a prefix that navigates
from the submodule to the superproject so that when the submodule
URL is concatenated the resulting URL is relative to the working tree
of the submodule.

This change ensures that this is done for add, sync and init.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh           | 35 ++++++++++++++++++++---------------
 t/t7400-submodule-basic.sh |  4 ++--
 t/t7403-submodule-sync.sh  |  2 +-
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 64a70d6..230c219 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -45,6 +45,10 @@ resolve_relative_url ()
 		../*)
 			url="${url#../}"
 			case "$remoteurl" in
+			.*/*)
+				up_path="$(echo "$2" | sed "s/[^/]*/../g")"
+				remoteurl="${up_path%/}/${remoteurl%/*}"
+				;;
 			*/*)
 				remoteurl="${remoteurl%/*}"
 				;;
@@ -235,11 +239,24 @@ cmd_add()
 		usage
 	fi
 
+	# normalize path:
+	# multiple //; leading ./; /./; /../; trailing /
+	sm_path=$(printf '%s/\n' "$sm_path" |
+		sed -e '
+			s|//*|/|g
+			s|^\(\./\)*||
+			s|/\./|/|g
+			:start
+			s|\([^/]*\)/\.\./||
+			tstart
+			s|/*$||
+		')
+
 	# assure repo is absolute or relative to parent
 	case "$repo" in
 	./*|../*)
 		# dereference source url relative to parent's url
-		realrepo=$(resolve_relative_url "$repo") || exit
+		realrepo=$(resolve_relative_url "$repo" "$sm_path") || exit
 		;;
 	*:*|/*)
 		# absolute url
@@ -250,18 +267,6 @@ cmd_add()
 	;;
 	esac
 
-	# normalize path:
-	# multiple //; leading ./; /./; /../; trailing /
-	sm_path=$(printf '%s/\n' "$sm_path" |
-		sed -e '
-			s|//*|/|g
-			s|^\(\./\)*||
-			s|/\./|/|g
-			:start
-			s|\([^/]*\)/\.\./||
-			tstart
-			s|/*$||
-		')
 	git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
 	die "$(eval_gettext "'\$sm_path' already exists in the index")"
 
@@ -407,7 +412,7 @@ cmd_init()
 			# Possibly a url relative to parent
 			case "$url" in
 			./*|../*)
-				url=$(resolve_relative_url "$url") || exit
+				url=$(resolve_relative_url "$url" "$sm_path") || exit
 				;;
 			esac
 			git config submodule."$name".url "$url" ||
@@ -964,7 +969,7 @@ cmd_sync()
 		# Possibly a url relative to parent
 		case "$url" in
 		./*|../*)
-			url=$(resolve_relative_url "$url") || exit
+			url=$(resolve_relative_url "$url" "$sm_path") || exit
 			;;
 		esac
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 02e6428..b838f43 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -507,7 +507,7 @@ test_expect_success 'relative path works with user@host:path' '
 	)
 '
 
-test_expect_failure 'relative path works with ../relative/repo' '
+test_expect_success 'relative path works with ../relative/repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -517,7 +517,7 @@ test_expect_failure 'relative path works with ../relative/repo' '
 	)
 '
 
-test_expect_failure 'test that submodule add creates the correct url when super origin url is ../relative/repo' '
+test_expect_sucess 'test that submodule add creates the correct url when super origin url is ../relative/repo' '
 	mkdir reladd &&
 	(
 		cd reladd &&
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 788bc24..35700ef 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -86,7 +86,7 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
 	)
 '
 
-test_expect_failure '"git submodule sync" should handle a super with a relative origin URL' '
+test_expect_success '"git submodule sync" should handle a super with a relative origin URL' '
 	git clone super relative-clone &&
 	(cd relative-clone &&
 	 git submodule update --init &&
-- 
1.7.10.2.594.g5c52315
