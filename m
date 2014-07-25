From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 4/6] add a test for semantic errors in config files
Date: Fri, 25 Jul 2014 05:58:13 -0700
Message-ID: <1406293095-15920-5-git-send-email-tanayabh@gmail.com>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 14:59:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAf62-0003Ip-GS
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 14:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760421AbaGYM7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 08:59:34 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44518 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbaGYM7d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 08:59:33 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so6049583pab.16
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KQPviVDI+vwbw1AhwoR4t/vcgYHEPcOh45DxcThN6Lw=;
        b=BKnm1sD1UmRer/37/hycLodwjwrvsYg2wuXAeFtSfxSRQF70IupKkbVl9Cox2oYHxk
         1spW0O3VCofW0PjBijHP0No/2TU90Vk4x+8gGbCCfI0+j5NP6ZWMSZ8BYNSXu4uv/0ZN
         iZ5+jcfbommUfc7Q3Dk1hoQ0GBWKPI9M0hN/Z8kgI+C+awqMDHV8qu9ZXmCKaMer7y6M
         ed0XG+bOuPRd8i/C1EVLWh9yEhQCl1X1hgv6yuLJUgV2+eIZt4+Zbl3NF93W7ZacsJY1
         Fugja2nxkV7BdkK8HKhzWtyhNy4jk7WtU7cXyiO9oScCjOccza1wDNSzTpYfdoaIkJwE
         Yahw==
X-Received: by 10.68.240.34 with SMTP id vx2mr18532253pbc.1.1406293173374;
        Fri, 25 Jul 2014 05:59:33 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.45])
        by mx.google.com with ESMTPSA id tg9sm8798900pbc.29.2014.07.25.05.59.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 05:59:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254215>

Semantic errors (for example, for alias.* variables NULL values are
not allowed) in configuration files cause a die printing the line
number and file name of the offending value.

Add a test documenting that such errors cause a die printing the
accurate line number and file name.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1308-config-set.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7fdf840..35c6ee2 100755
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
+	grep "fatal: bad config file line 2 in .git/config" result
+'
+
 test_done
-- 
1.9.0.GIT
