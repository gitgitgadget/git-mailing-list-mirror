From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 4/6] add a test for semantic errors in config files
Date: Tue, 29 Jul 2014 04:28:20 -0700
Message-ID: <1406633302-23144-5-git-send-email-tanayabh@gmail.com>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 13:30:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC5bg-0003IL-PT
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 13:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbaG2LaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 07:30:05 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:39318 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbaG2LaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 07:30:04 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so11525173pdj.36
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MZmElS2o/0r2M0qauUd1G8rRWUgRAFwU38toAcuJwEI=;
        b=vR1xChGoXUbAEoHfw8eNMEfhP0s7FSXtwCu7o3dJuuozlg3hMxJD+2r+bG/JNLQsGs
         E8RGV9nV1ED3slUnqkUdgRMeCEswNFSOdYQNXzhPqt3MmNlLMmXCbo33lS2X3tN0wZk9
         saCoPE26STc3BuJWEJvN5RSoXvekHkc/xHc4K8q7ksdXjpjGm8gCKu5iMP7wfLRhj4Th
         x/iFfotMkhuz+VCEjs2+LK6xiy/uZpukqwNUQXZ3TiP/VH3Ajpkr86Oz1Q2Cw+vX/REB
         ryC5Ak+tx+G3lkujq0U9Ah1Gg3dTAaQq7sneMawADIMGNF6GyOWrLalpVcoOGrp7LOYN
         fdFg==
X-Received: by 10.68.116.235 with SMTP id jz11mr1282979pbb.149.1406633403730;
        Tue, 29 Jul 2014 04:30:03 -0700 (PDT)
Received: from localhost.localdomain ([223.184.138.24])
        by mx.google.com with ESMTPSA id z2sm28554774pdj.16.2014.07.29.04.29.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 04:30:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254416>

Semantic errors (for example, for alias.* variables NULL values are
not allowed) in configuration files cause a die printing the line
number and file name of the offending variable.

Add a test documenting that such errors cause a die printing the
the configuration variable, accurate line number and the file name.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1308-config-set.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7fdf840..e2f9d0b 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -197,4 +197,15 @@ test_expect_success 'proper error on error in custom config files' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check line errors for malformed values' '
+	mv .git/config .git/config.old &&
+	test_when_finished "mv .git/config.old .git/config" &&
+	cat >.git/config <<-\EOF &&
+	[alias]
+		br
+	EOF
+	test_expect_code 128 git br 2>result &&
+	grep "fatal: bad config variable '\''alias.br'\'' at file line 2 in .git/config" result
+'
+
 test_done
-- 
1.9.0.GIT
