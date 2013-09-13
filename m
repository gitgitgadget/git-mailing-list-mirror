From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] version-gen: cleanup
Date: Thu, 12 Sep 2013 20:17:25 -0500
Message-ID: <1379035046-6688-2-git-send-email-felipe.contreras@gmail.com>
References: <1379035046-6688-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 13 03:22:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKI64-0007LY-Qe
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 03:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216Ab3IMBWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 21:22:43 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:40991 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733Ab3IMBWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 21:22:40 -0400
Received: by mail-oa0-f42.google.com with SMTP id n12so609169oag.15
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 18:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EGqRXJ6Yl2YaexftDawoRg+iZCa+DV/dle2c0PsqFCI=;
        b=b3P1xq41UsWbzrLbhzatmz4H8QMs8+VjcfmZBHymwQ7oHL7hc4vlGX7ep82avy00I1
         Cg14yKBO4r+MJ6zpb/JiuMSVdrpUC95NDNKN6e3Sk/onGwNsoCXe91lXXQPm9TytJSOG
         Mq81sNYpF85BXs/BUcL0F1Dc3ecO5sa4UckaoQSwq+8kFv8lba+2imGSnw3tkXIxuQZ7
         zKTNhp9BU495hnxBAGWEVC+FsKRaT4K3UK22AANMdFcobMnjgjCfOBI7uxBysHkRaKNs
         fb1Md5Pzqajy7pWztYedlYLPdyAhdpHWRJUQvl8Az0wt3ycp3l+3IKw3wRVNELOBuueU
         J8mQ==
X-Received: by 10.182.121.137 with SMTP id lk9mr9717178obb.32.1379035360001;
        Thu, 12 Sep 2013 18:22:40 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm9890095obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 18:22:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1379035046-6688-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234718>

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
1.8.4-338-gefd7fa6
