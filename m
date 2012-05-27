From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 8/9] submodule: fix handling of denormalized superproject origin URLs
Date: Sun, 27 May 2012 23:43:29 +1000
Message-ID: <1338126210-11517-9-git-send-email-jon.seymour@gmail.com>
References: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 15:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYdla-0006LW-Vp
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 15:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab2E0NoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 09:44:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38301 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab2E0NoK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 09:44:10 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3101250dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dO8UjvK1dFaBTq4jQOdoJ2fMF2DYcaykWZHUe44gYLY=;
        b=XJlwkCB1wlkz0RqzS9nmB3HUKkyzz9JIUOrX0qdXnom3uZOzd6SyCoTDjOnRmMxUne
         HbKZ04zJqWUYiKxWy8rpTBnSAhJVX8z+DItYUku8Xnnw7he5+S8gLJWDzBVBSCVCDO4/
         s3EoxtQCbD6LISh9cWu5D+pTJY1IVJN34/Bo0IrKVPcBsgrvLsr0fHWsj1rvd/hXDrx5
         UYTefxkNDhUIpKVD2kT+gzBbtHajzi8jM9jDpcoNphsiSDvZs5e8rDbjivAZrQSpOZWJ
         qYq0HyPZKXDxBldxmha0j0YE1yc3wST39XblZfwpacw4SP5utJil8HDbIeL74RjOd7Oe
         2HOg==
Received: by 10.68.230.105 with SMTP id sx9mr16955645pbc.114.1338126250470;
        Sun, 27 May 2012 06:44:10 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id ru4sm15870005pbc.66.2012.05.27.06.44.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 06:44:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.gb5a46db
In-Reply-To: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198599>

Currently git calculates the submodule origin URL incorrectly in
the case that the superproject origin URL is denormalized.

So, we normalize the path part of the superproject URL before iterating
over the leading ../ parts of the submodule URL.

A remaining problem related to the handling of consecutive repeated ./'s
in the superproject origin URL is deferred to a subsequent commit.

This change also fixes a subtle error in the setup of t7403 which was
masked by the denormalization issue. Previous behaviour was
relying on submodule add to clone trash/submodule into super/submodule,
however from the perspective of super's origin (i.e. trash), the origin
submodule is actually located at ./submodule not ../submodule. However,
because the origin URL of super was denormalized (it had a trailing /.)
the incorrect handling of denormalized super URLs actually produced
the correct result - a case of two errors cancelling out each other's
effects.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh           |  1 +
 t/t7400-submodule-basic.sh | 10 +++++-----
 t/t7403-submodule-sync.sh  |  1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

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
index b7466ba..0152969 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -18,6 +18,7 @@ test_expect_success setup '
 	git clone . super &&
 	git clone super submodule &&
 	(cd super &&
+	 git clone ../submodule submodule &&
 	 git submodule add ../submodule submodule &&
 	 test_tick &&
 	 git commit -m "submodule"
-- 
1.7.10.2.656.gb5a46db
