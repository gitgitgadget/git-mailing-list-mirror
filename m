From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] submodule: add tests for add,sync,init in presence of relative super origin URL
Date: Sat, 19 May 2012 14:40:02 +1000
Message-ID: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 06:40:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVbSq-000699-HD
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 06:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827Ab2ESEkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 00:40:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39163 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab2ESEkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 00:40:16 -0400
Received: by obbtb18 with SMTP id tb18so4867463obb.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 21:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=VV5bgOYTm/X2ac3DVIV5PLg5ahG6iIlUmJmeUUzcbEc=;
        b=ZjyLya6QLE9rzVqmHdiCO7+5R+vCyeUI3gIt4hHJdNwjItXekIFSX4hr3KKM0QnFrZ
         uMX99Lf0tetyHViE/TqBf25wzxCFlfSCgQOwxuo9Nqi6AGrbYH82D1NPfyQSuL1QgVv2
         2axLmseH2QWjED0w8Bz+Nv7SwuAskdn/AnedS0NV6XdXaxAEP8vJUSBCYNvUDMofewQL
         UxeVrLmArTZdEmd6KMidxwoab606QkQdFhG9k3rHRmkGxKjPNGrAlaQCEaxRJgCDXrY9
         PAWdQTzus8gXjfi6KoDrQ4ym0tI0/UtDE/P+TCxQE8gEiLM3jsilP47yplDI3pLewLHy
         4D4Q==
Received: by 10.50.42.130 with SMTP id o2mr2451299igl.37.1337402415646;
        Fri, 18 May 2012 21:40:15 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id ai6sm3262838igc.0.2012.05.18.21.40.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 21:40:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.649.gec87875
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198010>

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
1.7.10.2.649.gec87875
