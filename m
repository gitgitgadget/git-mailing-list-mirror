From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC v2 8/8] contrib/subtree: Handle '--prefix' argument with a slash appended
Date: Mon, 14 Jan 2013 11:52:21 +0800
Message-ID: <1358135541-10349-9-git-send-email-techlivezheng@gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
 <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 04:59:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TubCo-0006Wq-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 04:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab3AND7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 22:59:04 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:57241 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869Ab3AND7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 22:59:02 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so1613030dad.8
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 19:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9D1VSe7v8kMD009i8ZwtyjePbIizKje8rYCV9SrCzZw=;
        b=nGks0Yi9pPUMGgpK/3Y0WgCRd1/slZjjJjepBp5I8DWhTvEKpQRfaO0YvUu9EpYiuY
         vYoQcXL0A5a8nkiEowfGnVv79VxwFBhORiaJJeJ+TgrksElPgdCgxbUpuFiK2DoUU3iH
         BKUYlm/YvUm0LOPlA4yE32PwvA32012O8KDYPBXiM3arWODiUlDd0GjX9oN8PYUOof45
         DGqUuHktmTjiJECvOQbwhcAdN7xbYWNyLUB8Hyu35HyiMth/Hm4q8+nLmF8KOzP63fUf
         QrPMYnC9Ts9PhmdzJgVFTE04iLJCkr+zlUcxVoeNqOmTodeXOZd942fYllhv+JzTSWm8
         PYwQ==
X-Received: by 10.68.239.194 with SMTP id vu2mr23399856pbc.34.1358135941958;
        Sun, 13 Jan 2013 19:59:01 -0800 (PST)
Received: from home.techlive.me ([122.244.159.146])
        by mx.google.com with ESMTPS id kl3sm7400598pbc.15.2013.01.13.19.58.57
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 19:59:01 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213426>

'git subtree merge' will fail if the argument of '--prefix' has a slash
appended.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
---
 contrib/subtree/git-subtree.sh     |  2 +-
 contrib/subtree/t/t7900-subtree.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index d529a76..40100e5 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -83,7 +83,7 @@ while [ $# -gt 0 ]; do
 		--annotate) annotate="$1"; shift ;;
 		--no-annotate) annotate= ;;
 		-b) branch="$1"; shift ;;
-		-P) prefix="$1"; shift ;;
+		-P) prefix="${1%/}"; shift ;;
 		-m) message="$1"; shift ;;
 		--no-prefix) prefix= ;;
 		--onto) onto="$1"; shift ;;
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 232ed89..297dac4 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -238,6 +238,25 @@ test_expect_success 'merge new subproj history into subdir/ with --squash and --
 	)
 '
 
+test_expect_success 'merge new subproj history into subdir/ with a slash appended to the argument of --prefix' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir/ FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir/ FETCH_HEAD &&
+		test_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
+'
+
 #
 # Tests for 'git subtree split'
 #
-- 
1.8.1
