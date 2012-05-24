From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 1/2] submodule: document failures handling relative superproject origin URLs
Date: Thu, 24 May 2012 13:37:36 +1000
Message-ID: <1337830657-16400-2-git-send-email-jon.seymour@gmail.com>
References: <1337830657-16400-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 05:38:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXOsL-00081O-DE
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 05:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab2EXDiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 23:38:02 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42381 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab2EXDiA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 23:38:00 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so7355332yhm.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 20:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aLpYUg8m56ifXUQAyMRF7IYjk89tDq89E9e07wZ/pao=;
        b=nbiGxeRFBBAUx1b4GQpLjREtVl7wbK2enGkkYJMzAM7w/HJJTpF9+HF/JByhVnMwo+
         0r+dbre5YkI/E5uF81+S4jjkbdr6W7+b1gUQXbd2tsIIV8J6cZXCUIBr7z/zirGdf+Fa
         fCqYGpbe0G61WWfHOdeWa2qstCYbBu1udNOvtmGJaer2oj525KVbHTJXm3dBPjp3Pt3P
         XOnZfV6YoND4GEI/StDrUJfBVm/STa79xvHTuKVLqiy+ZGgSlJ80t0hQkqaagqtnFp+x
         /0rEvJXwgoL2FaohimDHSz6bd1JD5VPh1ODrONWGyHHpn7RVnknP2+tqN0gz6KZ5M1zG
         LBKw==
Received: by 10.50.236.74 with SMTP id us10mr3465656igc.29.1337830679694;
        Wed, 23 May 2012 20:37:59 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([1.142.1.227])
        by mx.google.com with ESMTPS id if4sm14062525igc.10.2012.05.23.20.37.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 20:37:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.649.g5ca7d80
In-Reply-To: <1337830657-16400-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198346>

These tests document how submodule sync and init handle various
kinds of relative super project origin URLs.  The submodule URL
path is ../subrepo.

6 cases are documented:
  foo
  foo/bar
  ./foo
  ./foo/bar
  ../foo
  ../foo/bar

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7400-submodule-basic.sh | 62 +++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh  | 76 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 81827e6..08b8d2f 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -507,6 +507,68 @@ test_expect_success 'relative path works with user@host:path' '
 	)
 '
 
+test_expect_failure 'relative path works with foo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url foo &&
+		# actual: fails with an error
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ./subrepo
+	)
+'
+
+test_expect_success 'relative path works with foo/bar' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url foo/bar &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = foo/subrepo
+	)
+'
+
+test_expect_success 'relative path works with ./foo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url ./foo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ./subrepo
+	)
+'
+
+test_expect_failure 'relative path works with ./foo/bar' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url ./foo/bar &&
+		git submodule init &&
+		#actual: ./foo/subrepo
+		test "$(git config submodule.sub.url)" = foo/subrepo
+	)
+'
+
+test_expect_success 'relative path works with ../foo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url ../foo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ../subrepo
+	)
+'
+
+test_expect_success 'relative path works with ../foo/bar' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url ../foo/bar &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ../foo/subrepo
+	)
+'
+
 test_expect_success 'moving the superproject does not break submodules' '
 	(
 		cd addtest &&
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 3620215..9fa4e58 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -26,7 +26,9 @@ test_expect_success setup '
 	(cd super-clone && git submodule update --init) &&
 	git clone super empty-clone &&
 	(cd empty-clone && git submodule init) &&
-	git clone super top-only-clone
+	git clone super top-only-clone &&
+	git clone super relative-clone &&
+	(cd relative-clone && git submodule update --init)
 '
 
 test_expect_success 'change submodule' '
@@ -86,4 +88,76 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
 	)
 '
 
+test_expect_failure '"git submodule sync" handles origin URL of the form foo' '
+	(cd relative-clone &&
+	 git remote set-url origin foo
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual fails with: "cannot strip off url foo
+	 git config remote.origin.url &&
+	 test "$(git config remote.origin.url)" == "../submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form foo/bar' '
+	(cd relative-clone &&
+	 git remote set-url origin foo/bar
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual foo/submodule
+	 git config remote.origin.url &&
+	 test "$(git config remote.origin.url)" == "../foo/submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form ./foo' '
+	(cd relative-clone &&
+	 git remote set-url origin ./foo
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual ./submodule
+	 git config remote.origin.url &&
+	 test "$(git config remote.origin.url)" == "../submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form ./foo/bar' '
+	(cd relative-clone &&
+	 git remote set-url origin ./foo/bar
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual ./foo/submodule
+	 git config remote.origin.url &&
+	 test "$(git config remote.origin.url)" == "../foo/submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form ../foo' '
+	(cd relative-clone &&
+	 git remote set-url origin ../foo
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual ../submodule
+	 git config remote.origin.url &&
+	 test "$(git config remote.origin.url)" == "../../submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form ../foo/bar' '
+	(cd relative-clone &&
+	 git remote set-url origin ../foo/bar
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual ../foo/submodule
+	 git config remote.origin.url &&
+	 test "$(git config remote.origin.url)" == "../../foo/submodule"
+	)
+	)
+'
+
 test_done
-- 
1.7.10.2.649.g5ca7d80
