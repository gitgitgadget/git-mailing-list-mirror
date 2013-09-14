From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/3] version-gen: cleanup
Date: Sat, 14 Sep 2013 01:28:46 -0500
Message-ID: <1379140128-12397-2-git-send-email-felipe.contreras@gmail.com>
References: <1379140128-12397-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 08:34:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjQn-0008Ee-8E
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab3INGeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:34:05 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:39661 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab3INGeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:34:04 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so1980690oah.20
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 23:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z5hXx1uJw7571Z0CF16F+4kb0M6dW1byheT0uAqgOho=;
        b=IHPHOJhIE7thDdkNS4w4v7gltNr78GH0MEdyUJRyoU08AaIuU1dc2yNwv5gJhsBu00
         /JMr8xormbhyVq9wfO4BGaXuCnl3hfGojawmSOU8Iop4sOt1is78a3jPR40SYG5m1YXM
         1uBk55n62wqW03WMTJ9AAvWHNsKrwDC3gpy7+4wIKpAUTxjvNyfPu+Ry2nvDCThrhip3
         36SlulqZq1JUjwnzo3YdhmJAHFzwE4ZG0AY04Ax1j/O6xVc6AlAjejRs4Ds12jWq7tKp
         lp21kzU9UWURFg4eNJ9oAWGGBpgCxIGCa1LYF58BHBS1L3JPJe7J6w3pQyLXUTRGQS9F
         kKRQ==
X-Received: by 10.60.51.196 with SMTP id m4mr15716834oeo.1.1379140443525;
        Fri, 13 Sep 2013 23:34:03 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm20260501obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 23:34:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379140128-12397-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234792>

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
