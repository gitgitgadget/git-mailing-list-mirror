From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC 7/7] contrib/subtree: Handle '--prefix' argument with a slash appended
Date: Sun, 13 Jan 2013 09:52:38 +0800
Message-ID: <1358041958-1998-8-git-send-email-techlivezheng@gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 13 02:59:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuCrW-0001Bu-AD
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 02:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab3AMB71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 20:59:27 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:40538 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498Ab3AMB7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 20:59:24 -0500
Received: by mail-da0-f48.google.com with SMTP id k18so1318951dae.7
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 17:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=othotI9WM3sJ47ctv0ZHR/2o64sGkqeE9bmpD1uI/6Q=;
        b=jHzBOLB55jjT8n34TXVqBAeUruG+CXdzN10Klf4ruJ4rIYeGHothykhOhFuGA450BU
         23CJ1wiGmef+0NshpvX7NnIzmsPtBmHtoxNxbHoWbE49tMxZ3udmvdgZQ7MrkQwMm2x3
         r2a0KKoAgEO9LRgWEAHpcLo6VQBQMoDbWH3Ka+BmY/tTBFfVnV3sGpEO1/5rvQrfE3Kb
         hx5Yb03Wr0Bntw/hCe9f+1cL0L+OH4HCkKXl3ULJwklg4F278iaIUqSRLAfzzECFDagZ
         0KinqHIXb/D2UBuGwPb0fsNALVDxyVaDuEKzrRJcBHH9u1TBadatzQ35GezJfU9UISA+
         4DGA==
X-Received: by 10.66.85.70 with SMTP id f6mr211000006paz.76.1358042364114;
        Sat, 12 Jan 2013 17:59:24 -0800 (PST)
Received: from home.techlive.me ([122.244.155.16])
        by mx.google.com with ESMTPS id d8sm5908882pax.23.2013.01.12.17.59.21
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Jan 2013 17:59:23 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213327>

'git subtree merge' will fail if the argument of '--prefix' has a slash
appended.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
---
 contrib/subtree/git-subtree.sh     |  2 +-
 contrib/subtree/t/t7900-subtree.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 018ee32..574ff04 100755
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
index 1492303..8e09606 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -238,6 +238,25 @@ test_expect_success 'merge new subproj history into subdir/ with --squash and --
     )
 '
 
+test_expect_success 'merge new subproj history into subdir/ with a slash appended to the argument of --prefix' '
+    test_create_repo "$test_count" &&
+    test_create_repo "$test_count/subproj" &&
+    test_create_commit "$test_count" main1 &&
+    test_create_commit "$test_count/subproj" sub1 &&
+    (
+        cd "$test_count" &&
+        git fetch ./subproj master &&
+        git subtree add --prefix=subdir/ FETCH_HEAD
+    ) &&
+    test_create_commit "$test_count/subproj" sub2 &&
+    (
+        cd "$test_count" &&
+        git fetch ./subproj master &&
+        git subtree merge --prefix=subdir/ FETCH_HEAD &&
+        test_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+    )
+'
+
 #
 # Tests for 'git subtree split'
 #
-- 
1.8.1
