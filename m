From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 08/56] t6036: Add differently resolved modify/delete conflict in criss-cross test
Date: Thu, 11 Aug 2011 23:19:41 -0600
Message-ID: <1313126429-17368-9-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkB3-0004ab-Nf
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab1HLFUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:20:50 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab1HLFUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:48 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=V9gRLwm5AFaJV96TV+fmOz3feOIqyWuJ9yKfRC5aFJQ=;
        b=A/jzTCzEd4si+ZmYTfj7B+ZBR5j8ztphwsTzaaSv1fhEBC0p9HOZihY5Euj2plA/AH
         eVkGo+Y2iTxhfYRSuZK05f6EWrATynm+0QiaaVzZKrjNKQunhAlsgoZk9rwfLjh1iO6z
         xo+M+p+H7RY4Hu/epImMtthmsNsPNBX20C3RM=
Received: by 10.231.3.129 with SMTP id 1mr1110796ibn.42.1313126447921;
        Thu, 11 Aug 2011 22:20:47 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.46
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179169>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Changes since v1: Made wording change suggested by Junio.

 t/t6036-recursive-corner-cases.sh |   83 +++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 319b6fa..90b50bb 100755
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
+# Merging commits D & E should result in modify/delete conflict.
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
1.7.6.100.gac5c1
