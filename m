From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v9 4/4] submodule: fix handling of superproject origin URLs like foo, ./foo and ./foo/bar
Date: Wed,  6 Jun 2012 21:57:30 +1000
Message-ID: <1338983850-9872-5-git-send-email-jon.seymour@gmail.com>
References: <1338983850-9872-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 13:58:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScEsV-0000tm-E6
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 13:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab2FFL6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 07:58:00 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65099 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab2FFL57 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 07:57:59 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so8693843dad.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DSjpk3SC2FQL7pOTsWyUuwyBM7jkmYlphz1ubuPacAc=;
        b=gZPHBr0Tk32+KoHO2YvBJxCvxqgNvXd5daiqe+bzgtaHCj4DDE7URmyQowBsFlUbhc
         Hm+4XigO4I8fIOtI+wksjd2hnZSRTNU+nVl1H/ZDcJBIM2LNPsMR6QBmcGsByNdccBHn
         e+SqpOZqAhLE92i1g1qyEqHGVR8K79ELvFhy2Ehs1XTxuwOSgm/eWhrVjr3QiTnjnwSF
         j16og8hLJn0fRqE0WxdEKUrbiFmCMykxKicIbv8O4YcBkQVK3Kf00t+3fbWrSHXhlFSe
         F7qZDQIdQ8LmYmC0nxSUwoHsgXLPy1mCReqY9Qd48kqF7xX9p8mT1SIqdmpNiIlmi23f
         QVgA==
Received: by 10.68.217.166 with SMTP id oz6mr12561739pbc.136.1338983879757;
        Wed, 06 Jun 2012 04:57:59 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([175.103.19.195])
        by mx.google.com with ESMTPS id pg3sm197182pbc.2.2012.06.06.04.57.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 04:57:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.650.g9c513dd.dirty
In-Reply-To: <1338983850-9872-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199318>

Currently git submodule init and git submodule sync fail with an error
if the superproject origin URL is of the form foo but succeed if the
superproject origin URL is of the form ./foo or ./foo/bar or foo/bar.

This change makes handling of the foo case behave like the handling
of the ./foo case and also ensures that superfluous leading and
embedded ./'s are removed from the resulting derived URLs.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh           | 14 ++++++++++++--
 t/t7400-submodule-basic.sh |  6 +++---
 t/t7403-submodule-sync.sh  |  6 +++---
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 227ba59..cff1348 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -60,8 +60,12 @@ resolve_relative_url ()
 	*:*|/*)
 		is_relative=
 		;;
+	./*|../*)
+		is_relative=t
+		;;
 	*)
 		is_relative=t
+		remoteurl="./$remoteurl"
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
1.7.10.2.650.g9c513dd.dirty
