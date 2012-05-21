From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 1/4] submodule: verify support for superproject origin URLs of the form ./foo/bar or ../foo/bar
Date: Mon, 21 May 2012 23:31:39 +1000
Message-ID: <1337607102-14737-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 15:32:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWSiV-0005dO-Ht
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 15:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab2EUNcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 09:32:01 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41980 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab2EUNcA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 09:32:00 -0400
Received: by pbbrp8 with SMTP id rp8so6944386pbb.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=4ampwjP0G3ZckFUR0NPZBgh82eYBnMfdY9RQDDq40G0=;
        b=LDgZ9kYdZI27TpnJMbMYsOV+qqzPP+31pD3MrZp+FgbUi/HQTili4GU3OLQDls4uRE
         jFibgy4iAo+6MtWyrCUKIbVzraheIU2EgEq28TEWCNZazGguBjqVtHAEmVyAj4x841UQ
         9+6qooa2gIV2hzamX037OrSIV2oOA5UpBnhCIre9anD42Y0o0SOKcFpAkdRpxlL84xJ0
         LANT5sb3/rrpy+hfRRGoVv0Kur9k3EM1qLyx4FjHsiOXuMpGDif6Pucy2ISlbYSx6fIK
         7mzFiYzTM2QQolNTaMvog69M7uTPHmHi06MegwjpBsW0NOqyYmOx3Pu35ZwKX+gYZgrl
         yexQ==
Received: by 10.68.130.9 with SMTP id oa9mr68270842pbb.95.1337607120128;
        Mon, 21 May 2012 06:32:00 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([110.173.237.195])
        by mx.google.com with ESMTPS id wi8sm23153721pbc.11.2012.05.21.06.31.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 May 2012 06:31:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.594.g5c52315
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198101>

These tests are expected to fail, pending a subsequent corrective patch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7400-submodule-basic.sh | 26 ++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh  | 10 ++++++++++
 2 files changed, 36 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 81827e6..02e6428 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -507,6 +507,32 @@ test_expect_success 'relative path works with user@host:path' '
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
+test_expect_failure 'test that submodule add creates the correct url when super origin url is ../relative/repo' '
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
1.7.10.2.594.g5c52315
