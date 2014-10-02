From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Thu,  2 Oct 2014 06:24:52 -0700
Message-ID: <1412256292-4286-6-git-send-email-tanayabh@gmail.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 15:26:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZgOe-0006UM-KV
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 15:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbaJBN0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 09:26:09 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:52388 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbaJBN0H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 09:26:07 -0400
Received: by mail-pa0-f51.google.com with SMTP id lj1so2479481pab.10
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fPJIk2R1E+inqTzrSxvO+x90Br9J5yDI3aOr1WZvkbU=;
        b=mPScgi+6sJempQ/pKqlhwX2yUUKP6h1IO1v8Mi28e9zZqQE5q0AajYMN/NshDWbL+Z
         IcX+4G9hK2+JFGmm76JX5UnqnDr4+BZNyNwXZfACJH0kgU+5fjKOe03leyz/HJ6D45nN
         UMyekLMPatfyk/J5tBfRL4CmIWqDZFgeQ4l7ucJvU8LbhBPmieB6swh4e0otrlCg2mvB
         a8dL4gQiYNA6Vvpp5I/YFJ78xcs8nqrweLpux16haAx3qw+m6ddU/cKf7az/adLDi+5G
         5Ln3bE82WKvgz0YPgAenadtHuuTFt1UlQ9tDDQU3jAGu7VFnht/np/syk8FtE5zQjRKK
         739Q==
X-Received: by 10.68.203.5 with SMTP id km5mr85746485pbc.91.1412256367112;
        Thu, 02 Oct 2014 06:26:07 -0700 (PDT)
Received: from localhost.localdomain ([182.67.148.232])
        by mx.google.com with ESMTPSA id qp9sm3612065pbc.31.2014.10.02.06.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Oct 2014 06:26:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257805>

Helped-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1300-repo-config.sh | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index ce5ea01..f75c001 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1179,4 +1179,58 @@ test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
 '
 
+test_expect_success 'unset.variable unsets all previous matching keys' '
+	cat >.git/config <<-\EOF &&
+	[alias]
+		checkconfig = -c foo.check=baz config foo.check
+		checkconfig = -c foo.check=bar config foo.check
+	[unset]
+		variable = alias.checkconfig
+	EOF
+
+	test_expect_code 1 git checkconfig
+'
+
+test_expect_success 'unset.variable does not touch all matching keys after it' '
+	cat >.git/config <<-\EOF &&
+	[alias]
+		checkconfig = -c foo.check=foo config foo.check
+	[unset]
+		variable = alias.checkconfig
+	[alias]
+		checkconfig = -c foo.check=baz config foo.check
+		checkconfig = -c foo.check=bar config foo.check
+	EOF
+
+	cat >expect <<-\EOF &&
+	bar
+	EOF
+
+	test_expect_code 0 git checkconfig >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'document how unset.variable will behave in shell scripts' '
+	rm -f .git/config &&
+	cat >expect <<-\EOF &&
+	EOF
+	git config foo.bar boz1 &&
+	git config --add foo.bar boz2 &&
+	git config unset.variable foo.bar &&
+	git config --add foo.bar boz3 &&
+	test_must_fail git config --get-all foo.bar >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unset.variable declared after in shell scripts' '
+	rm -f .git/config &&
+	cat >expect <<-\EOF &&
+	EOF
+	git config foo.bar boz1 &&
+	git config --add foo.bar boz2 &&
+	git config unset.variable foo.bar &&
+	test_must_fail git config --get-all foo.bar >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.9.0.GIT
