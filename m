From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 1/2] version-gen: cleanup
Date: Sat, 12 Oct 2013 02:07:07 -0500
Message-ID: <1381561628-20665-2-git-send-email-felipe.contreras@gmail.com>
References: <1381561628-20665-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtO1-0005PR-2G
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab3JLHNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:14 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:57142 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab3JLHNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:12 -0400
Received: by mail-ob0-f180.google.com with SMTP id wn1so3435967obc.39
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z5hXx1uJw7571Z0CF16F+4kb0M6dW1byheT0uAqgOho=;
        b=vJ657EMcF4ncr64nCMvJGgNJNMgK+8bcCCREwgWibfUSe+k6ngRvvLs0Yg3op3BoPY
         xOJHqZvC7he/oexc9neSE1gcFdZVY7vRQFe0iVyxAhZxEq8uQb9biGOqIgZmHkSFumZ3
         6rh0avuq/cAPmBxEat3fQsVHQbf+EU8y9E+/5DSFOKdLOhZgSsPPfBugZLkrrWt6ySTs
         JzaRxB23xGMYzL+yTTsGNEqAYXC6tSCf7i+RNS+Ncq4NGkTrd0w3i+0m04ihjj0d0xTm
         BVvsUNP7ywRDj0YkvE352lnPBxlwhZryU3QuUjy061pn+VTqNIVkBSRjiWStK3EkTZj2
         1NSQ==
X-Received: by 10.182.214.98 with SMTP id nz2mr13741557obc.37.1381561992070;
        Sat, 12 Oct 2013 00:13:12 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm28636445obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561628-20665-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236008>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 06026ea..e96538d 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -6,22 +6,29 @@ DEF_VER=v1.8.4
 LF='
 '
 
-# First see if there is a version file (included in release tarballs),
-# then try git-describe, then default.
-if test -f version
-then
-	VN=$(cat version) || VN="$DEF_VER"
-elif test -d ${GIT_DIR:-.git} -o -f .git &&
-	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
+describe () {
+	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) || return 1
 	case "$VN" in
-	*$LF*) (exit 1) ;;
+	*$LF*)
+		return 1
+		;;
 	v[0-9]*)
 		git update-index -q --refresh
 		test -z "$(git diff-index --name-only HEAD --)" ||
-		VN="$VN-dirty" ;;
+		VN="$VN-dirty"
+		return 0
+		;;
 	esac
+}
+
+# First see if there is a version file (included in release tarballs),
+# then try 'git describe', then default.
+if test -f version
+then
+	VN=$(cat version) || VN="$DEF_VER"
+elif test -d ${GIT_DIR:-.git} -o -f .git && describe
 then
-	VN=$(echo "$VN" | sed -e 's/-/./g');
+	VN=$(echo "$VN" | sed -e 's/-/./g')
 else
 	VN="$DEF_VER"
 fi
@@ -34,9 +41,6 @@ then
 else
 	VC=unset
 fi
-test "$VN" = "$VC" || {
-	echo >&2 "GIT_VERSION = $VN"
-	echo "GIT_VERSION = $VN" >$GVF
-}
-
-
+test "$VN" = "$VC" && exit
+echo >&2 "GIT_VERSION = $VN"
+echo "GIT_VERSION = $VN" >$GVF
-- 
1.8.4-fc
