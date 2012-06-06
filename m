From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v9 2/4] submodule: document failure to handle relative superproject origin URLs
Date: Wed,  6 Jun 2012 21:57:28 +1000
Message-ID: <1338983850-9872-3-git-send-email-jon.seymour@gmail.com>
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
	id 1ScEsD-0000Jj-FG
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 13:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab2FFL5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 07:57:51 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65099 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab2FFL5u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 07:57:50 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so8693843dad.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=m1d75WILEsS90oo9sSTn++Ob46u/e39+QVBPZOt3zqw=;
        b=lUtSf85BGhc2ahkgQ6a/QhYpD0SIK3sYlwWIccVblEA4r1Uk3hRETzM1wRomBxEFCs
         CZkNOKswxR1mjkCBDDyMxlylc4REIofzFXWx3LAMWhuqiuT0+ZSQLliUqojU0h9ezT90
         HKcMToUpCB1AD2cvdufy3uCMwelFWaLtw8DK4hGDT6vVcB0XK88vnZ8AXyZCVYYHpryb
         bIWrkHinSiekCtnYaiT2Fn6CtbkELxibkk20nKtzxAxmDFlSM6mY64mdEfIb1OwK7s9C
         uRM8OUl5zfgxqapfR9znlXXDodnh67OOSMq0bBU7ENHj37DuyhWJrqmwc4a67ArEZert
         XGmQ==
Received: by 10.68.222.133 with SMTP id qm5mr46912232pbc.113.1338983870059;
        Wed, 06 Jun 2012 04:57:50 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([175.103.19.195])
        by mx.google.com with ESMTPS id pg3sm197182pbc.2.2012.06.06.04.57.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 04:57:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.650.g9c513dd.dirty
In-Reply-To: <1338983850-9872-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199316>

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
1.7.10.2.650.g9c513dd.dirty
