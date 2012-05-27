From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 4/9] submodule: document failure to handle improperly normalized remote origin URLs
Date: Mon, 28 May 2012 01:34:06 +1000
Message-ID: <1338132851-23497-5-git-send-email-jon.seymour@gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 17:36:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYfVr-0006Ww-0j
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 17:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab2E0PfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 11:35:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab2E0Peh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 11:34:37 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3166603dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LXb4Ae/uKqL39BH4eL16MPeF2lWCorI2EkyEhY3LAlM=;
        b=V8T5pdhIg69js4akbaotq3vYbOz3iNFVkax3GZWBcOMQ2J/KM9/3jnXLM1iKcq9igb
         uOJEC2i35mMcnRYxa4fJRY28aEgXvxzcgXVfLlbUHxnBY1xGVdpHgsqEH56y8rncK9rc
         /ninyHiANO2ez8+TtD8Jp6tGvBKkNLqAEho+Oy+px29nEyhw9wIipBe2iQMXRNxcgyqi
         LaTqVywnles6vN43e+UlXqpMxnG+ZgnrshIB147hnzw8eqj0SUH5cFJQ3t4OEL2HqzCn
         YCO0W1BoMjs/Hk/l8nSlKmCR6Kc85qutW7VuNYvWtxRgnptNwKPURfAeNL5yBomlqroE
         e/5A==
Received: by 10.68.238.71 with SMTP id vi7mr18172322pbc.159.1338132877156;
        Sun, 27 May 2012 08:34:37 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id rk4sm16128261pbc.48.2012.05.27.08.34.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 08:34:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.g24a6219
In-Reply-To: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198610>

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
1.7.10.2.656.g24a6219
