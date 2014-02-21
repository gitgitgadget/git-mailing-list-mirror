From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] demonstrate git-commit --dry-run exit code behaviour
Date: Sat, 22 Feb 2014 03:16:54 +0800
Message-ID: <1393010214-32306-1-git-send-email-rctay89@gmail.com>
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 21 20:17:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGvb2-0000Gg-Mf
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 20:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbaBUTRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 14:17:12 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:49222 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbaBUTRL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 14:17:11 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so3851881pab.4
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 11:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=q5/zVCjzfyRRV+vOhWUAM2ZJbJhscb499JHXFhSTvVc=;
        b=o01hsIfpe8vMVFuFtAq4HitCjlp1wGHyzeKnzio4H88Erjo0jzEXgcH4MVhNiSZKUm
         89fsXTeNi6ad8hFjSy5DdSr6e0aKNmhERPSj7fN46l7xovTtNqm2sdYOlZql8s94NrvD
         R/VsOtlLEcY1prvsaCXK4UZWqjst6kxcADPkZb1Y2S6+cM3E66IJGmq02HVJYOf2PrFv
         4/N8fv06H/Ztvdl8lYIT2Gq+Si8ecJxTUnejDFby/1yp9lX8BG55c2KLHcHJqvDLqyuL
         c3BvnbT7H9tFF7C2thz5k/qhY0gmhRZyWH5TQBvm3DG5Ibb6cP7J0J+CgyV9sH2inG4Z
         Fs8g==
X-Received: by 10.66.248.227 with SMTP id yp3mr10821703pac.116.1393010231437;
        Fri, 21 Feb 2014 11:17:11 -0800 (PST)
Received: from chiliad.localdomain (cm245.gamma242.maxonline.com.sg. [202.156.242.245])
        by mx.google.com with ESMTPSA id kc9sm23878626pbc.25.2014.02.21.11.17.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 11:17:10 -0800 (PST)
X-Mailer: git-send-email 1.9.0.291.g027825b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242491>

In particular, show that --short and --porcelain, while implying
--dry-run, do not return the same exit code as --dry-run. This is due to
the wt_status.commitable flag being set only when a long status is
requested.

No fix is provided here; with [1], it should be trivial to fix though -
just a matter of calling wt_status_mark_commitable().

[1] http://article.gmane.org/gmane.comp.version-control.git/242489

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t7501-commit.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 94eec83..d58b097 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -61,11 +61,47 @@ test_expect_success 'nothing to commit' '
 	test_must_fail git commit -m initial
 '
 
+test_expect_success '--dry-run fails with nothing to commit' '
+	test_must_fail git commit -m initial --dry-run
+'
+
+test_expect_success '--short fails with nothing to commit' '
+	test_must_fail git commit -m initial --short
+'
+
+test_expect_success '--porcelain fails with nothing to commit' '
+	test_must_fail git commit -m initial --porcelain
+'
+
+test_expect_success '--long fails with nothing to commit' '
+	test_must_fail git commit -m initial --long
+'
+
 test_expect_success 'setup: non-initial commit' '
 	echo bongo bongo bongo >file &&
 	git commit -m next -a
 '
 
+test_expect_success '--dry-run with stuff to commit returns ok' '
+	echo bongo bongo bongo >>file &&
+	git commit -m next -a --dry-run
+'
+
+test_expect_failure '--short with stuff to commit returns ok' '
+	echo bongo bongo bongo >>file &&
+	git commit -m next -a --short
+'
+
+test_expect_failure '--porcelain with stuff to commit returns ok' '
+	echo bongo bongo bongo >>file &&
+	git commit -m next -a --porcelain
+'
+
+test_expect_success '--long with stuff to commit returns ok' '
+	echo bongo bongo bongo >>file &&
+	git commit -m next -a --long
+'
+
 test_expect_success 'commit message from non-existing file' '
 	echo more bongo: bongo bongo bongo bongo >file &&
 	test_must_fail git commit -F gah -a
-- 
1.9.0.291.g027825b
