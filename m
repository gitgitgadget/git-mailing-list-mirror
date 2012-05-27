From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 4/9] submodule: document failure to handle improperly normalized remote origin URLs
Date: Sun, 27 May 2012 23:43:25 +1000
Message-ID: <1338126210-11517-5-git-send-email-jon.seymour@gmail.com>
References: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 15:44:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYdlI-00060W-UW
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 15:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533Ab2E0Nn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 09:43:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38301 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab2E0Nn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 09:43:56 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3101250dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=J5erZQlFGVZtyA7uZRsUWJEte+MdA7sPyMbyEyJFZLA=;
        b=JS02/1WxBrOLBHzSJcMgOy7QkC86vMUyJjmZp/nZFh7w8+8Ok5FbTZLoxUL+6sB4bL
         3IPhGPChu6f4DizX5cPgQD734U0J4qSUD4XLCFfuuwC3TYzt8SHXWXU6rY2ZnteVtW07
         2g/4eayba81aZqhl9K8xcO/1wP0/t57yA7/S0Cmf3ag4ySPaHrxp0BpxLjQtSMTLR1KW
         Jl71w6G/EAs6fG1Jriu4FqUSg5BAnRkhHW1bTwu9V4B4J09lT/I34MJCcVc2oMauAtxP
         loEfnsNx+31kxskPAt2mrj0g8NEN++W8MvKDcBJGUWCnDB4WUCyVVaLG6TAeVz+f3kkd
         QRjg==
Received: by 10.68.233.193 with SMTP id ty1mr17379033pbc.47.1338126236184;
        Sun, 27 May 2012 06:43:56 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id ru4sm15870005pbc.66.2012.05.27.06.43.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 06:43:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.gb5a46db
In-Reply-To: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198597>

These tests document failures to properly handle improperly normalized
remote origin URLs.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7400-submodule-basic.sh | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 80ec0f7..2674088 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -499,6 +499,39 @@ test_expect_success '../subrepo works with URL - ssh://hostname/repo' '
 	)
 '
 
+test_expect_failure 'relative path works with URL - ssh://hostname/path/././repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/path/././repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ssh://hostname/path/subrepo
+	)
+'
+
+test_expect_failure 'relative path works with URL - ssh://hostname/path/detour/././../repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/path/detour/././../repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ssh://hostname/path/subrepo
+	)
+'
+
+test_expect_failure 'relative path works with URL - ssh://hostname/path/repo/.' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/path/repo/. &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ssh://hostname/path/subrepo
+	)
+'
+
 test_expect_success '../subrepo works with port-qualified URL - ssh://hostname:22/repo' '
 	(
 		cd reltest &&
@@ -634,6 +667,50 @@ test_expect_success '../subrepo works with scp-style URL - user@host:path/to/rep
 	)
 '
 
+test_expect_failure 'relative path works with user@host:path/to/repo/.' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url user@host:path/to/repo/. &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = user@host:path/to/subrepo
+	)
+'
+
+test_expect_failure 'relative path works with user@host:path/to/./repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url user@host:path/to/./repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = user@host:path/to/subrepo
+	)
+'
+
+test_expect_failure 'relative path works with user@host:path/to/././repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url user@host:path/to/././repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = user@host:path/to/subrepo
+	)
+'
+
+test_expect_failure 'relative path works with user@host:path/to/detour/../repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url user@host:path/to/detour/../repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = user@host:path/to/subrepo
+	)
+'
+
 test_expect_failure '../subrepo works with relative local path - foo' '
 	(
 		cd reltest &&
@@ -703,6 +780,17 @@ test_expect_success '../subrepo works with relative local path - ../foo/bar' '
 	)
 '
 
+test_expect_failure 'relative path works with ../foo/./bar' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ../foo/./bar &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ../foo/subrepo
+	)
+'
+
 test_expect_success '../bar/a/b/c works with relative local path - ../foo/bar.git' '
 	(
 		cd reltest &&
-- 
1.7.10.2.656.gb5a46db
