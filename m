From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v2 1/2] test for '!' handling in rev-parse's named commits
Date: Sat,  6 Jun 2015 01:24:54 +0100
Message-ID: <1433550295-15098-2-git-send-email-wmpalmer@gmail.com>
References: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
Cc: Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 02:25:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z11vw-0000wb-Jt
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 02:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbbFFAZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 20:25:53 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37966 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbbFFAZr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 20:25:47 -0400
Received: by wibdq8 with SMTP id dq8so33598638wib.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZraICm+BWgIXrJKjmrq1ceX1bxuWR0lvF7rmkwpEl5Y=;
        b=vggKGafOF8YVlyCymDR+fzfHmxHk2PHP5RKvmFsMo+NVR8XLoaOCypjb5EfqCmRXt4
         pG0YWAOelzMntceJW3ytmvHvnN2szBYUzPnYqNXmXpa5LzbNlgnOGq5Icg1PsvcJypcm
         Qg6wi2KN8IPGzxi2jMgXrk3oIE93xYjSNzYVHmuAgpg0Gg6xlGc/JdWcSzrnuvO8Ufb3
         6w76C7s+Dac8QPH3Icmh370BAtmL3W0eZscrbBXUMNjSix4tBA/Gn99iqLT2uo9AdnpP
         nTwur0AUlYXwqmXR34k805LuTjBgrQVU22xIC+qRQYBTfydyrp7taXszHTjq980GQRGn
         xv+Q==
X-Received: by 10.194.62.228 with SMTP id b4mr10697186wjs.2.1433550346027;
        Fri, 05 Jun 2015 17:25:46 -0700 (PDT)
Received: from localhost.localdomain (cpc12-folk2-2-0-cust138.1-2.cable.virginm.net. [81.109.109.139])
        by mx.google.com with ESMTPSA id 12sm12755607wjw.17.2015.06.05.17.25.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Jun 2015 17:25:45 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.rc1
In-Reply-To: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270898>

In anticipation of extending this behaviour, add tests verifying the
handling of exclamation marks when looking up a commit "by name".

Specifically, as documented: '<rev>^{/!Message}' should fail, as the '!'
prefix is reserved; while '<rev>^{!!Message}' should search for a commit
whose message contains the string "!Message".

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 t/t1511-rev-parse-caret.sh | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index 15973f2..e0fe102 100755
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
@@ -77,4 +84,18 @@ test_expect_success 'ref^{/Initial}' '
 	test_cmp expected actual
 '
 
+test_expect_success 'ref^{/!Exp}' '
+	test_must_fail git rev-parse master^{/!Exp}
+'
+
+test_expect_success 'ref^{/!}' '
+	test_must_fail git rev-parse master^{/!}
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
