From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] submodule: fix handling of supermodules with relative origin URLs
Date: Sat, 19 May 2012 14:40:03 +1000
Message-ID: <1337402403-7546-2-git-send-email-jon.seymour@gmail.com>
References: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 06:40:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVbSz-0006Mv-BW
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 06:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab2ESEkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 00:40:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37691 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab2ESEkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 00:40:21 -0400
Received: by yenm10 with SMTP id m10so3447117yen.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 21:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FAXngyG7OxEwuDqNlyabEhPXIP6h+8N0YoPu9XxG3sE=;
        b=SG+eLl9Tt96crsHXd1A+NTljuIlxjC013lbdWMeH0Y4E5QCjeCwpy7EtRkRjFIdmV1
         yYkuvPljkgooXxbNYQKgPtM9U2X0gh/AufRVOB+N7ofraSooJGeGBo721F39aAD1ywx7
         hx6QNEfbRSKbgGlecVUXFPH0lt2wFzyUVPGu1BHQSJuyDFVCCweW50qmMYwnNknEGtF8
         PiAFFGgA5o7LPD2J0POoKiciUX1oa8A+FZgjRPZb8AQm/4xxvs6NF0xjrvwqM90J4kkI
         GdN+F7nLCS2LIIHHfDs3G6f5BK9NYyjLSSmnx3gYI6qK6hjEHU/ly38h34ux3HMH0Jov
         9aGQ==
Received: by 10.42.81.17 with SMTP id x17mr8841403ick.5.1337402420623;
        Fri, 18 May 2012 21:40:20 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id ai6sm3262838igc.0.2012.05.18.21.40.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 21:40:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.649.gec87875
In-Reply-To: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198011>

Prior to this change, an operation such as git submodule add, init or
sync produced the wrong result when the origin URL of the supermodule
was itself a relative URL.

The issue arises in these cases, because the origin URL of
the supermodule needs to be prepended with a prefix that navigates
from the submodule to the supermodule so that when the submodule
URL is concatenated, the resulting url is relative to the working tree
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
index 1c40951..e10abc4 100755
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
 
-test_expect_failure 'test that submodule add creates the correct url when super origin url is relative' '
+test_expect_success 'test that submodule add creates the correct url when super origin url is relative' '
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
1.7.10.2.649.gec87875
