From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 2/4] submodule: document failure to handle relative superproject origin URLs
Date: Sun,  3 Jun 2012 19:46:48 +1000
Message-ID: <1338716810-9881-3-git-send-email-jon.seymour@gmail.com>
References: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 11:47:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb7P8-000631-15
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 11:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab2FCJrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 05:47:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54207 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab2FCJrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 05:47:13 -0400
Received: by pbbrp8 with SMTP id rp8so4767123pbb.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0TS04fD445u8VYADXzWBVPX+1ObwF2lyc3c0UWawxgA=;
        b=UzuLu8U4zou/vHmVOXmcfSj1ahkccDtLRIqDmENi3h7ll9LEla4QT2WrmJoQ5CFL3W
         TEeaUxXlJa1GUCwT+MCr3xp99t30jjzz3MRfMnbJSiLRUz9HkIxuSioscgCwfjSedCtT
         XZp6uftrgjjhJ45dgBsWGIZpYPeUo5SN+4iJ1Qm/WQplgINKs0i5qMeSiayFndAS/Aec
         WAHVnszMNZSgUzemG95YlCEH4kmF+PdP4FHRYolgmEtwMKDNCYucvmnsAaUfGWbNIoYF
         qvP2GLTCJPPUMjbm3vsb1CEaM86mL3st1HmXvqeWskXC3I1UZt2L3IEo7sWJywWg8FYh
         3bYA==
Received: by 10.68.132.166 with SMTP id ov6mr28551377pbb.24.1338716832736;
        Sun, 03 Jun 2012 02:47:12 -0700 (PDT)
Received: from ubuntu.au.ibm.com (202-159-159-155.dyn.iinet.net.au. [202.159.159.155])
        by mx.google.com with ESMTPS id pb10sm8385550pbc.68.2012.06.03.02.47.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jun 2012 02:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.651.g2c84487
In-Reply-To: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199076>

This test case documents several cases where handling of relative
superproject origin URLs doesn't produce an expected result.

submodule.{sub}.url in the superproject is incorrect in these cases:
  foo
  ./foo
  ./foo/bar

The remote.origin.url of the submodule is incorrect in the above cases
and also when the superproject origin URL is like:
  foo/bar
  ../foo
  ../foo/bar

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7400-submodule-basic.sh | 34 ++++++++++++++++++
 t/t7403-submodule-sync.sh  | 90 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 9428c7a..09e2b9b 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -564,6 +564,18 @@ test_expect_success '../subrepo works with scp-style URL - user@host:path/to/rep
 	)
 '
 
+test_expect_failure '../subrepo works with relative local path - foo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url foo &&
+		# actual: fails with an error
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = subrepo
+	)
+'
+
 test_expect_success '../subrepo works with relative local path - foo/bar' '
 	(
 		cd reltest &&
@@ -575,6 +587,28 @@ test_expect_success '../subrepo works with relative local path - foo/bar' '
 	)
 '
 
+test_expect_failure '../subrepo works with relative local path - ./foo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ./foo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = subrepo
+	)
+'
+
+test_expect_failure '../subrepo works with relative local path - ./foo/bar' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ./foo/bar &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = foo/subrepo
+	)
+'
+
 test_expect_success '../subrepo works with relative local path - ../foo' '
 	(
 		cd reltest &&
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 3620215..56b933d 100755
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
@@ -86,4 +88,90 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
 	)
 '
 
+test_expect_failure '"git submodule sync" handles origin URL of the form foo' '
+	(cd relative-clone &&
+	 git remote set-url origin foo &&
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual fails with: "cannot strip off url foo
+	 test "$(git config remote.origin.url)" = "../submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form foo/bar' '
+	(cd relative-clone &&
+	 git remote set-url origin foo/bar &&
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual foo/submodule
+	 test "$(git config remote.origin.url)" = "../foo/submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form ./foo' '
+	(cd relative-clone &&
+	 git remote set-url origin ./foo &&
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual ./submodule
+	 test "$(git config remote.origin.url)" = "../submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form ./foo/bar' '
+	(cd relative-clone &&
+	 git remote set-url origin ./foo/bar &&
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual ./foo/submodule
+	 test "$(git config remote.origin.url)" = "../foo/submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form ../foo' '
+	(cd relative-clone &&
+	 git remote set-url origin ../foo &&
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual ../submodule
+	 test "$(git config remote.origin.url)" = "../../submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form ../foo/bar' '
+	(cd relative-clone &&
+	 git remote set-url origin ../foo/bar &&
+	 git submodule sync &&
+	(cd submodule &&
+	 #actual ../foo/submodule
+	 test "$(git config remote.origin.url)" = "../../foo/submodule"
+	)
+	)
+'
+
+test_expect_failure '"git submodule sync" handles origin URL of the form ../foo/bar with deeply nested submodule' '
+	(cd relative-clone &&
+	 git remote set-url origin ../foo/bar &&
+	 mkdir -p a/b/c &&
+	 ( cd a/b/c &&
+	   git init &&
+	   :> .gitignore &&
+	   git add .gitignore &&
+	   test_tick &&
+	   git commit -m "initial commit" ) &&
+	 git submodule add ../bar/a/b/c ./a/b/c &&
+	 git submodule sync &&
+	(cd a/b/c &&
+	 #actual ../foo/bar/a/b/c
+	 test "$(git config remote.origin.url)" = "../../../../foo/bar/a/b/c"
+	)
+	)
+'
+
+
 test_done
-- 
1.7.10.2.652.gdffd412
