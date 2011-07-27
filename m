From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v2 1/3] test whether push checks for unpushed remotes in submodules
Date: Wed, 27 Jul 2011 20:10:48 +0200
Message-ID: <1311790250-32454-2-git-send-email-iveqy@iveqy.com>
References: <1311790250-32454-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, iveqy@iveqy.com, jens.lehmann@web.de,
	hvoigt@hvoigt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 20:10:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm8ZL-0000Fh-M8
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 20:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab1G0SKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 14:10:46 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:56289 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab1G0SKo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 14:10:44 -0400
Received: by eye22 with SMTP id 22so2218744eye.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0hOVzRQHknCJAHbUBdVw6hU3NDVobzpfWcvYXD4y0a0=;
        b=R9X2/hBnyaLcYm5Xl7tDJpnXuUxywK2CzzmU+79ruoQNj290vlU7f8pI34NA3uT0F8
         trZq2zxL8mkZ6TD45TeTcy3f3VNMvAwSFivBh7LPzxoMYfpY6BPg9OCD59LhVTQazCjg
         tR5khGcmpYrODDOCO7c9dCaBaHnZqqaxCzxTg=
Received: by 10.204.133.16 with SMTP id d16mr40617bkt.61.1311790242899;
        Wed, 27 Jul 2011 11:10:42 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id s2sm35374bkd.55.2011.07.27.11.10.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 11:10:41 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qm8ZH-0008S2-DB; Wed, 27 Jul 2011 20:10:51 +0200
X-Mailer: git-send-email 1.7.6.236.g7ad21
In-Reply-To: <1311790250-32454-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177989>

From: Heiko Voigt <hvoigt@hvoigt.net>

These tests are used to extend push to check whether all recorded
submodule commits have also been pushed.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t5531-deep-submodule-push.sh |   46 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index faa2e96..0b55466 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -28,8 +28,52 @@ test_expect_success setup '
 test_expect_success push '
 	(
 		cd work &&
-		git push ../pub.git master
+		git push -f ../pub.git master
 	)
 '
 
+test_expect_failure 'push fails if submodule has no remote' '
+	(
+		cd work/gar/bage &&
+		>junk2 &&
+		git add junk2 &&
+		git commit -m "Second junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Second commit for gar/bage" &&
+		test_must_fail git push ../pub.git master
+	)
+'
+
+test_expect_failure 'push fails if submodule commit not on remote' '
+	(
+		cd work/gar &&
+		git clone --bare bage ../../submodule.git &&
+		cd bage &&
+		git remote add origin ../../../submodule.git &&
+		git fetch &&
+		>junk3 &&
+		git add junk3 &&
+		git commit -m "Third junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Third commit for gar/bage" &&
+		test_must_fail git push ../pub.git master
+	)
+'
+
+test_expect_failure 'push succeeds after commit was pushed to remote' '
+	(
+		cd work/gar/bage &&
+		git push origin master
+	) &&
+	(
+		cd work &&
+		git push ../pub.git master
+	)
+'
 test_done
-- 
1.7.6.236.g7ad21
