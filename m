From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 08/48] t6036: Add differently resolved modify/delete conflict in criss-cross test
Date: Wed,  8 Jun 2011 01:30:38 -0600
Message-ID: <1307518278-23814-9-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDF-0005pC-MJ
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694Ab1FHH3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:10 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:37577 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab1FHH3I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:08 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so191910pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=CcIkK/+TQZbsgeS7S6Ux/RxmsiJZmGEPG3o5xgBAJXc=;
        b=GFxrItI8iMBr00EHVQ0H/gMwnLfocddpa+nmug2izIWl4pR2/T5eVtSFV9UcG9Cfje
         Lsd5YM5WpYULL/nmYlRGkTHaBhb8cl6BL2c2DQpA7eqNFDnlWtALUlgr0vmX+o2JWd9s
         Hy5r/YzDnyWvgJK2y6VZxIotCMCySH8uUdzm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xliZDd9HIzf1zyJGjIwwVU/TQVa7K56PTC6PbfEgH6VTXPFNac8J8p0NK1pga+v2mI
         WS3ygTSUKVCtm1sNwEuXw5G8xM/+yB/t6Y2YGqY54gRWYp/Pg9BtRLNJvq0y7Ohu1hoj
         7a8yvpFru79vJzZyg9aK4S4zwsU00ht3GMS3U=
Received: by 10.68.21.231 with SMTP id y7mr591751pbe.493.1307518148672;
        Wed, 08 Jun 2011 00:29:08 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.06
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175304>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh |   83 +++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 319b6fa..52d2ecf 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -231,4 +231,87 @@ test_expect_success 'git detects differently handled merges conflict' '
 	test $(git rev-parse :1:new_a) = $(git hash-object merged)
 '
 
+#
+# criss-cross + modify/delete:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: file with contents 'A\n'
+#   Commit B: file with contents 'B\n'
+#   Commit C: file not present
+#   Commit D: file with contents 'B\n'
+#   Commit E: file not present
+#
+# Now, when we merge commits D & E, does git detect the conflict?
+
+test_expect_success 'setup criss-cross + modify/delete resolved differently' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	echo A >file &&
+	git add file &&
+	test_tick &&
+	git commit -m A &&
+
+	git branch B &&
+	git checkout -b C &&
+	git rm file &&
+	test_tick &&
+	git commit -m C &&
+
+	git checkout B &&
+	echo B >file &&
+	git add file &&
+	test_tick &&
+	git commit -m B &&
+
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	echo B >file &&
+	git add file &&
+	test_tick &&
+	git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	git rm file &&
+	test_tick &&
+	git commit -m E &&
+	git tag E
+'
+
+test_expect_failure 'git detects conflict merging criss-cross+modify/delete' '
+	git checkout D^0 &&
+
+	test_must_fail git merge -s recursive E^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+
+	test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
+	test $(git rev-parse :2:file) = $(git rev-parse B:file)
+'
+
+test_expect_failure 'git detects conflict merging criss-cross+modify/delete, reverse direction' '
+	git reset --hard &&
+	git checkout E^0 &&
+
+	test_must_fail git merge -s recursive D^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+
+	test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
+	test $(git rev-parse :3:file) = $(git rev-parse B:file)
+'
+
 test_done
-- 
1.7.6.rc0.62.g2d69f
