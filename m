From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 4/4] submodule: fix handling of superproject origin URLs like foo, ./foo and ./foo/bar
Date: Sun,  3 Jun 2012 19:46:50 +1000
Message-ID: <1338716810-9881-5-git-send-email-jon.seymour@gmail.com>
References: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 11:47:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb7PH-0006Ms-2v
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 11:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab2FCJrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 05:47:21 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60718 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab2FCJrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 05:47:20 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4601633dad.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Y7O8gX5f7/Tnj1tla98HJdFtqQ0CmeSnHQiH5QYZ6rE=;
        b=IL9q5Dt+WKKFvlqkFJcPZDbDApCDW2avvM66K+f4y3oCkMhXpJY73Im9M4hXZfBsY4
         X6L04xT+yvSu3fJ6xctzjaIPvfrco/9UeoWIjTOhz1YQM9zYgjpw51LdcR6P6tOBdtB0
         BqWRnhwo1B5N1IXyfhIyPs1p2utnzJvr1p2fGPDWTIzddejDFa/Qm3CCF8gmzxNTjbjr
         h8ic6Dn8aJLGr7R5eR8YEC0q26NavYbs4M/OmvOinXrePG69CR3r6PmBfRpOMGOhl/BY
         /J/eKb/otEeU8fRNAbE20iG/UhEqmqhpPaJ7Rya0N7MS9KjKsbKiXFDOMA/Npx3FXoVo
         kfIg==
Received: by 10.68.191.8 with SMTP id gu8mr28667153pbc.0.1338716840249;
        Sun, 03 Jun 2012 02:47:20 -0700 (PDT)
Received: from ubuntu.au.ibm.com (202-159-159-155.dyn.iinet.net.au. [202.159.159.155])
        by mx.google.com with ESMTPS id pb10sm8385550pbc.68.2012.06.03.02.47.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jun 2012 02:47:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.651.g2c84487
In-Reply-To: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199078>

Currently git submodule init and git submodule sync fail with an error
if the superproject origin URL is of the form foo but succeeds if the
superproject origin URL is of the form ./foo or ./foo/bar or foo/bar.

This change makes handling of the foo case behave like the handling
of the ./foo case and also ensures that superfluous leading ./'s are
removed from the resulting derived URLs.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh           | 14 ++++++++++++--
 t/t7400-submodule-basic.sh |  6 +++---
 t/t7403-submodule-sync.sh  |  6 +++---
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 314df20..5142379 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -60,8 +60,12 @@ resolve_relative_url ()
 		*:*|/*)
 			is_relative=
 			;;
+		./*|../*)
+			is_relative=t
+			;;
 		*)
 			is_relative=t
+			remoteurl="./$remoteurl"
 			;;
 	esac
 
@@ -79,7 +83,12 @@ resolve_relative_url ()
 				sep=:
 				;;
 			*)
-				die "$(eval_gettext "cannot strip one component off url '\$remoteurl'")"
+				if test -z "$is_relative" || test "." = "$remoteurl"
+				then
+					die "$(eval_gettext "cannot strip one component off url '\$remoteurl'")"
+				else
+					remoteurl=.
+				fi
 				;;
 			esac
 			;;
@@ -90,7 +99,8 @@ resolve_relative_url ()
 			break;;
 		esac
 	done
-	echo "${is_relative:+${up_path}}$remoteurl$sep${url%/}"
+	remoteurl="$remoteurl$sep${url%/}"
+	echo "${is_relative:+${up_path}}${remoteurl#./}"
 }
 
 #
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 09e2b9b..a899e6d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -564,7 +564,7 @@ test_expect_success '../subrepo works with scp-style URL - user@host:path/to/rep
 	)
 '
 
-test_expect_failure '../subrepo works with relative local path - foo' '
+test_expect_success '../subrepo works with relative local path - foo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -587,7 +587,7 @@ test_expect_success '../subrepo works with relative local path - foo/bar' '
 	)
 '
 
-test_expect_failure '../subrepo works with relative local path - ./foo' '
+test_expect_success '../subrepo works with relative local path - ./foo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -598,7 +598,7 @@ test_expect_failure '../subrepo works with relative local path - ./foo' '
 	)
 '
 
-test_expect_failure '../subrepo works with relative local path - ./foo/bar' '
+test_expect_success '../subrepo works with relative local path - ./foo/bar' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 98bc74a..524d5c1 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -88,7 +88,7 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form foo' '
+test_expect_success '"git submodule sync" handles origin URL of the form foo' '
 	(cd relative-clone &&
 	 git remote set-url origin foo &&
 	 git submodule sync &&
@@ -110,7 +110,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form foo/bar
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ./foo' '
+test_expect_success '"git submodule sync" handles origin URL of the form ./foo' '
 	(cd relative-clone &&
 	 git remote set-url origin ./foo &&
 	 git submodule sync &&
@@ -121,7 +121,7 @@ test_expect_failure '"git submodule sync" handles origin URL of the form ./foo'
 	)
 '
 
-test_expect_failure '"git submodule sync" handles origin URL of the form ./foo/bar' '
+test_expect_success '"git submodule sync" handles origin URL of the form ./foo/bar' '
 	(cd relative-clone &&
 	 git remote set-url origin ./foo/bar &&
 	 git submodule sync &&
-- 
1.7.10.2.652.gdffd412
