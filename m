From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 3/9] submodule: document failure to handle relative superproject origin URLs
Date: Sun, 27 May 2012 23:43:24 +1000
Message-ID: <1338126210-11517-4-git-send-email-jon.seymour@gmail.com>
References: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 15:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYdlI-00060W-9z
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 15:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab2E0Nny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 09:43:54 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38301 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab2E0Nnw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 09:43:52 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3101250dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=L3S49376mTZsK23tSlq4Uy5FS/Fgva2U4F///OT+ldI=;
        b=vTiJcbG9HY+BjrKc1Ce9W6oYTVEkzdXmmGtmwJY40PJPNSBoUlYnhZH5zta6YIwr82
         lAHGOpfErZVM4lW/HM+mFfSQPeNwBjcZAC2j6QncPykCXcBJ5oDfE2aeBSedCD0TXQQy
         W822XUxAUNPIKEmilCTpxV6enfNaRGiI6hJnXbdfWcAV6f16il8xeV9i4z1RYooxKmiJ
         PP5y9RzPLZhAV8R6qnnF8PiKrK1NfY2gEfbE3zjGcEX72/AUrOmdyndyhc+GmO+JVl0G
         klyDLBPA/dmd9vFBMnO3tho9su7sXKQK/TI4xE/Yb7L5wdWppO7hIuq6xXzg+3lk5EBN
         pEgg==
Received: by 10.68.190.39 with SMTP id gn7mr17480841pbc.5.1338126232632;
        Sun, 27 May 2012 06:43:52 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id ru4sm15870005pbc.66.2012.05.27.06.43.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 06:43:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.gb5a46db
In-Reply-To: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198595>

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
 t/t7400-submodule-basic.sh | 36 +++++++++++++++++++
 t/t7403-submodule-sync.sh  | 90 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a758c63..80ec0f7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -634,6 +634,18 @@ test_expect_success '../subrepo works with scp-style URL - user@host:path/to/rep
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
@@ -645,6 +657,30 @@ test_expect_success '../subrepo works with relative local path - foo/bar' '
 	)
 '
 
+test_expect_failure '../subrepo works with relative local path - ./foo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ./foo &&
+		git submodule init &&
+		#actual ./subrepo
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
+		#actual: ./foo/subrepo
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
1.7.10.2.656.gb5a46db
