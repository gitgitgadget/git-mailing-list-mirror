From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH 1/2] test for '!' handling in rev-parse's named commits
Date: Wed,  3 Jun 2015 21:54:13 +0100
Message-ID: <1433364854-30088-2-git-send-email-wmpalmer@gmail.com>
References: <1433364854-30088-1-git-send-email-wmpalmer@gmail.com>
Cc: Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 22:54:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0FgQ-0003kX-OD
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 22:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302AbbFCUyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 16:54:37 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35659 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbbFCUyg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 16:54:36 -0400
Received: by wiga1 with SMTP id a1so27556727wig.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PVBNRrV1EC8XjLzvhWZZipeTixHgMsXaf2hzK1kXc3g=;
        b=CmbqSYm8CAlV0znppuGzNO6rgy9GhnuQ3dPEraR2gUV8KiMvH48v1RuZh42ESsRBnY
         5/9y+7GcG5cJCG5L8/tLwEPLP8xkQlKK5xLbQGozVcLOHInjXlDB/xlXv91FQ0Cdun0R
         G7Y5Ld7t2Uix8ifpDQvP5fv/NknWdU1nkA2EyY4q2HR9iuCT1ZKIjPEEdSKWmeRmbiqc
         ZDAKWrmbxQUIQy6BmAZwbwAEi1guDgJ2GmjyrooyUVzw2C4Ryh/Ad44L2v23JFqkgp/J
         AQ9P21I8Lx+dyNpBO/eMoO0BMgJItsLBN+7yNQ5Z2agphtbtN7g0PWqVf/Tmoq2BRh/W
         O1Hg==
X-Received: by 10.180.36.103 with SMTP id p7mr1041492wij.88.1433364875509;
        Wed, 03 Jun 2015 13:54:35 -0700 (PDT)
Received: from localhost.localdomain (cpc12-folk2-2-0-cust138.1-2.cable.virginm.net. [81.109.109.139])
        by mx.google.com with ESMTPSA id h7sm1888220wig.13.2015.06.03.13.54.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jun 2015 13:54:34 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.rc1
In-Reply-To: <1433364854-30088-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270736>

In anticipation of modifying this behaviour, add a test verifying the
handling of exclamation marks when looking up a commit "by name".

Specifically, as documented: '^{/!Message}' should fail, as this syntax
is currently reserved; while '^{!!Message}' should search for a commit
whose message contains the string "!Message".

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 t/t1511-rev-parse-caret.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index 15973f2..0c46e5c 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -18,7 +18,14 @@ test_expect_success 'setup' '
 	git checkout master &&
 	echo modified >>a-blob &&
 	git add -u &&
-	git commit -m Modified
+	git commit -m Modified &&
+	echo changed! >>a-blob &&
+	git add -u &&
+	git commit -m !Exp &&
+	git branch expref &&
+	echo changed >>a-blob &&
+	git add -u &&
+	git commit -m Changed
 '
 
 test_expect_success 'ref^{non-existent}' '
@@ -77,4 +84,14 @@ test_expect_success 'ref^{/Initial}' '
 	test_cmp expected actual
 '
 
+test_expect_success 'ref^{/!Exp}' '
+	test_must_fail git rev-parse master^{/!Exp}
+'
+
+test_expect_success 'ref^{/!!Exp}' '
+	git rev-parse expref >expected &&
+	git rev-parse master^{/!!Exp} >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.3.0.rc1
