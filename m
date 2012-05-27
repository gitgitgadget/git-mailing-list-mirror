From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 8/9] submodule: fix handling of denormalized superproject origin URLs
Date: Mon, 28 May 2012 01:34:10 +1000
Message-ID: <1338132851-23497-9-git-send-email-jon.seymour@gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 17:36:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYfVt-0006Ww-0F
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 17:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab2E0PfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 11:35:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab2E0Pew (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 11:34:52 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3166603dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=O0Iu6Ulzg0Oml53FBiv+gS7zJn9B/y/rqNU7vHSBsKs=;
        b=qTHEF2O1ivMNJjthA5XwtcONN41Vy9bRE8Ac5brjcda2hcp89uPlxPWOWM4/ubiaZI
         Ermo5zNTt6SDc/23PxsLO4OlhB3Wp5e4RVIUUoB58bhvUYdeQi/kJ3e7FRXbGnFIg2ce
         xjS1+uXgzEH7bDMA4n1shz+DJWXcGNXn3Law/GjVBVa1Vd/TJ/9p7TeJ2GyiRfGSiauF
         tNkEKIVvKCFQkn3Q2N12nTLBupjhf0JJ0tr0q2ksp5NGXLxuhez+K7aXUKzoduCDUkzk
         u9AJC+K0ocW5ebMiuHa0/MHrUZXxoCT5RADaWWkxaP33PrBrsl07YQMrqbuPFLNqEZJs
         oXtw==
Received: by 10.68.197.99 with SMTP id it3mr878832pbc.148.1338132892115;
        Sun, 27 May 2012 08:34:52 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id rk4sm16128261pbc.48.2012.05.27.08.34.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 08:34:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.g24a6219
In-Reply-To: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198612>

Currently git calculates the submodule origin URL incorrectly in
the case that the superproject origin URL is denormalized.

So, we normalize the path part of the superproject URL before iterating
over the leading ../ parts of the submodule URL.

A remaining problem related to the handling of consecutive repeated ./'s
in the superproject origin URL is deferred to a subsequent commit.

This change also fixes a subtle error in the setup of some tests which was
masked by the denormalization issue that is now fixed.

Previous behaviour was relying on submodule add to clone trash/submodule
into super/submodule, however from the perspective of super's origin (i.e. trash),
the origin submodule is actually located at ./submodule not ../submodule.

However, because the origin URL of super was denormalized (it had a trailing /.)
the incorrect handling of denormalized super URLs actually produced
the correct result - a case of two errors cancelling out each other's
effects.

Now that normalization is fixed, the erroneous use of git submodule add
by the test setups needs to be fixed. The cleanest way to do this is to
clone super not from ., but from ./omega. The subsequent invocation of

   git submodule add ../submodule submodule

now does the expected thing because ../submodule is the correct
path from omega to the submodule origin repo.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh             |  1 +
 t/t7400-submodule-basic.sh   | 10 +++++-----
 t/t7403-submodule-sync.sh    | 14 +++++++++-----
 t/t7406-submodule-update.sh  | 16 ++++++++++------
 t/t7407-submodule-foreach.sh | 14 +++++++++-----
 t/t7506-status-submodule.sh  | 10 +++++++++-
 6 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9ca2ffe..1f0983c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -76,6 +76,7 @@ resolve_relative_url ()
 		;;
 	esac
 	invariant="${remoteurl%$variant}"
+	variant="$(normalize_path "$variant")"
 
 	while test -n "$url"
 	do
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a94c5e9..b01f479 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -521,7 +521,7 @@ test_expect_failure 'relative path works with URL - ssh://hostname/path/detour/.
 	)
 '
 
-test_expect_failure 'relative path works with URL - ssh://hostname/path/repo/.' '
+test_expect_success 'relative path works with URL - ssh://hostname/path/repo/.' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -663,7 +663,7 @@ test_expect_success '../subrepo works with scp-style URL - user@host:path/to/rep
 	)
 '
 
-test_expect_failure 'relative path works with user@host:path/to/repo/.' '
+test_expect_success 'relative path works with user@host:path/to/repo/.' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -674,7 +674,7 @@ test_expect_failure 'relative path works with user@host:path/to/repo/.' '
 	)
 '
 
-test_expect_failure 'relative path works with user@host:path/to/./repo' '
+test_expect_success 'relative path works with user@host:path/to/./repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -696,7 +696,7 @@ test_expect_failure 'relative path works with user@host:path/to/././repo' '
 	)
 '
 
-test_expect_failure 'relative path works with user@host:path/to/detour/../repo' '
+test_expect_success 'relative path works with user@host:path/to/detour/../repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -773,7 +773,7 @@ test_expect_success '../subrepo works with relative local path - ../foo/bar' '
 	)
 '
 
-test_expect_failure 'relative path works with ../foo/./bar' '
+test_expect_success 'relative path works with ../foo/./bar' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index b7466ba..d76e49f 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -11,11 +11,15 @@ These tests exercise the "git submodule sync" subcommand.
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo file > file &&
-	git add file &&
-	test_tick &&
-	git commit -m upstream &&
-	git clone . super &&
+	mkdir omega &&
+	(cd omega &&
+	 git init &&
+	 echo file > file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m upstream
+	) &&
+	git clone omega super &&
 	git clone super submodule &&
 	(cd super &&
 	 git submodule add ../submodule submodule &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index dcb195b..8b6c330 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -22,11 +22,15 @@ compare_head()
 
 
 test_expect_success 'setup a submodule tree' '
-	echo file > file &&
-	git add file &&
-	test_tick &&
-	git commit -m upstream &&
-	git clone . super &&
+	mkdir omega &&
+	(cd omega &&
+	 git init &&
+	 echo file > file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m upstream
+	) &&
+	git clone omega super &&
 	git clone super submodule &&
 	git clone super rebasing &&
 	git clone super merging &&
@@ -58,7 +62,7 @@ test_expect_success 'setup a submodule tree' '
 	 git submodule add ../merging merging &&
 	 test_tick &&
 	 git commit -m "rebasing"
-	)
+	) &&
 	(cd super &&
 	 git submodule add ../none none &&
 	 test_tick &&
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 9b69fe2..40f957c 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -13,11 +13,15 @@ that are currently checked out.
 
 
 test_expect_success 'setup a submodule tree' '
-	echo file > file &&
-	git add file &&
-	test_tick &&
-	git commit -m upstream &&
-	git clone . super &&
+	mkdir omega &&
+	(cd omega &&
+	 git init &&
+	 echo file > file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m upstream
+	) &&
+	git clone omega super &&
 	git clone super submodule &&
 	(
 		cd super &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d31b34d..764c1d0 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -197,7 +197,15 @@ A  sub1
 EOF
 
 test_expect_success 'status with merge conflict in .gitmodules' '
-	git clone . super &&
+	mkdir omega &&
+	(cd omega &&
+	 git init &&
+	 echo file > file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m upstream
+	) &&
+	git clone omega super &&
 	test_create_repo_with_commit sub1 &&
 	test_tick &&
 	test_create_repo_with_commit sub2 &&
-- 
1.7.10.2.656.g24a6219
