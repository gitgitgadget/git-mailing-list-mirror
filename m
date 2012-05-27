From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 2/9] submodule: document failure to detect invalid submodule URLs
Date: Mon, 28 May 2012 01:34:04 +1000
Message-ID: <1338132851-23497-3-git-send-email-jon.seymour@gmail.com>
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
	id 1SYfVo-0006Ww-NL
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 17:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab2E0PfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 11:35:01 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59885 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab2E0Pea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 11:34:30 -0400
Received: by pbbrp8 with SMTP id rp8so3669135pbb.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oWccdF51AcQiyjxCbhSgzZIbeos+Mps9T8EMc3Cl06o=;
        b=RNLATb9eAezVdNJlplGuX40sOxquxX7/4gKiPwi0CzhzhbkU7l3tp6ojmSYA3EiIRW
         YPoCtgySXn5h1tziYV5jjVCCMjpWLPN7Wz3f0IePMglqGYJyWKBNKvITeoRMXSbU32MP
         SeP2YBIjmJM/iVgxDHlhaMkNF0jmeZOiB2MGdqMZcmxnFj8mZnS6fBZRO2zQhUOLV4JC
         91TgZgAGYkX+EvrF3hvNnCtgAaibrDt3jbzxbTUZTcI8FHu2otExAbnFBlCj//0huoJ0
         KoWN4otND2FPOd677YUnATZk8Bawzospgwb2fG+M7ZYYGWHaZqTyUDfJO84R9S7tFVNM
         oMCQ==
Received: by 10.68.238.134 with SMTP id vk6mr17840031pbc.128.1338132869875;
        Sun, 27 May 2012 08:34:29 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id rk4sm16128261pbc.48.2012.05.27.08.34.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 08:34:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.g24a6219
In-Reply-To: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198609>

These tests document failures to detect submodule URLs that backtrack
past the 'invariant' part of a superproject's origin URL.

For example: if the origin URL is ssh://hostname/repo, then currently
if a submodule URL is specified as ../../subrepo, then git will
construct a submodule url of the form ssh://subrepo/ without complaint.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7400-submodule-basic.sh | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 9428c7a..a758c63 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -543,10 +543,80 @@ test_expect_success '../subrepo works with helper URL- helper:://hostname/repo'
 	)
 '
 
+test_expect_failure '../../subrepo fails with URL - ssh://hostname/repo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/repo &&
+		git config -f .gitmodules submodule.sub.url ../../subrepo &&
+		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
+		test_must_fail git submodule init 2>actual &&
+		#actual no failure, url configured as ssh://subrepo
+		test_cmp expected actual
+	)
+"
+
+test_expect_failure '../../subrepo fails with absolute local path - /repo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url /repo &&
+		git config -f .gitmodules submodule.sub.url ../../subrepo &&
+		echo cannot strip one component off url \'/\' > expected &&
+		test_must_fail git submodule init 2>actual &&
+		test_cmp expected actual
+	)
+"
+
+test_expect_failure '../../../subrepo fails with URL - ssh://hostname/repo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/repo &&
+		git config -f .gitmodules submodule.sub.url ../../../subrepo &&
+		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
+		test_must_fail git submodule init 2>actual &&
+		#actual no failure, url configured as ssh:/subrepo
+		test_cmp expected actual
+	)
+"
+
+test_expect_failure '../../../../subrepo fails with with URL - ssh://hostname/repo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/repo &&
+		git config -f .gitmodules submodule.sub.url ../../../../subrepo &&
+		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
+		test_must_fail git submodule init 2>actual &&
+		#actual no failure, url configured as ssh:/subrepo
+		test_cmp expected actual
+	)
+"
+
+test_expect_failure '../../../../../subrepo fails with URL - ssh://hostname/repo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/repo &&
+		git config -f .gitmodules submodule.sub.url ../../../../../subrepo &&
+		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
+		test_must_fail git submodule init 2>actual &&
+		#actual cannot strip one component off url 'ssh'
+		test_cmp expected actual
+	)
+"
+
 test_expect_success '../subrepo works with scp-style URL - user@host:repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
 		git config remote.origin.url user@host:repo &&
 		git submodule init &&
 		test "$(git config submodule.sub.url)" = user@host:subrepo
-- 
1.7.10.2.656.g24a6219
