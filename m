From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 1/2] submodule: add tests for add,sync,init in presence of relative super origin URL
Date: Sun, 20 May 2012 09:00:27 +1000
Message-ID: <1337468428-26155-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 01:00:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVsdh-0004GU-VT
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 01:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab2ESXAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 19:00:40 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38532 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab2ESXAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 19:00:39 -0400
Received: by dady13 with SMTP id y13so5264864dad.19
        for <git@vger.kernel.org>; Sat, 19 May 2012 16:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JnrVukjN/YGF2Qkbsf9TJKLLa4vzCMbWeiNMJRFYjxg=;
        b=GExFsFnchES01NShg4eKBw8h7wvqPU4QvrddAhZtMXh8KqOWGp4xjRG7L2AWDV36gv
         bsqhwguoCjqCP8bEgNQOQ93KBreWGQ3DDTj27KHnCZfCgoib7yKvgMEET2rRM9f3HSGg
         fPhQOwZO6KKEn1+BNMEYBcgkeP4PpO046mWx4piz6oJ/uajHrEdyoegXaRZbdXVNlNIV
         5LJgzWtO+Gf9IqpbOI7/E4HMCbysUnP8HbNuezLUvoH8b8zM9faBMvKZhrZXr8rrsEUt
         DjabSRfSuQK28JwBlTsVNCjzqMvLIBjkpVlHGZtQ2XLJTrXW6y6h3rT/jgHBf6kRLEHO
         yfLA==
Received: by 10.68.136.167 with SMTP id qb7mr52864113pbb.82.1337468438938;
        Sat, 19 May 2012 16:00:38 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id po10sm5720934pbb.21.2012.05.19.16.00.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 May 2012 16:00:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.650.g22d2504
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198042>

These tests are expected to fail, pending subsequent patch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7400-submodule-basic.sh | 27 +++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh  | 10 ++++++++++
 2 files changed, 37 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 81827e6..1c40951 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -507,6 +507,33 @@ test_expect_success 'relative path works with user@host:path' '
 	)
 '
 
+test_expect_failure 'relative path works with ../relative/repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url ../relative/repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ../../relative/subrepo
+	)
+'
+
+test_expect_failure 'test that submodule add creates the correct url when super origin url is relative' '
+	mkdir reladd &&
+	(
+		cd reladd &&
+		git init &&
+		git remote add origin ../relative/repo
+		mkdir sub &&
+		(
+			cd sub &&
+			git init &&
+			test_commit foo
+		) &&
+		git submodule add ../subrepo ./sub &&
+		test "$(git config submodule.sub.url)" = ../../relative/subrepo
+	)
+'
+
 test_expect_success 'moving the superproject does not break submodules' '
 	(
 		cd addtest &&
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 3620215..788bc24 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -86,4 +86,14 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
 	)
 '
 
+test_expect_failure '"git submodule sync" should handle a super with a relative origin URL' '
+	git clone super relative-clone &&
+	(cd relative-clone &&
+	 git submodule update --init &&
+	 git remote set-url origin ../relative/super.git &&
+	 git submodule sync &&
+	 test "$(git config submodule.submodule.url)" == ../../relative/moved-submodule
+	)
+'
+
 test_done
-- 
1.7.10.2.650.g22d2504
