From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 2/5] t0061: Add tests
Date: Tue, 24 Jan 2012 23:32:23 +0100
Message-ID: <1327444346-6243-3-git-send-email-fransklaver@gmail.com>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Frans Klaver <fransklaver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 23:33:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpovi-0005Xu-FF
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab2AXWdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:33:23 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54821 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab2AXWdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:33:05 -0500
Received: by mail-ey0-f174.google.com with SMTP id c13so1306969eaa.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 14:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kgvGVVJfKjzXOcJQzuZWWHf2Vcm8MeafJiheFLuvsVs=;
        b=jXe95djCN+zWWw8fdT7EgDRrubtW7jDqbRqsYwIGs8SxMB4PGpx6DJoIFsj8izBOm6
         6NPrinRFWris+PLat/oqU+Rt3F/f4rC+cGKhurCUNroXDGhVa9QBfWhkBoYwJtLRsNG9
         reynJiVtOypuSxEiqHFPfa7Uep/QjlIOc4ydY=
Received: by 10.213.25.146 with SMTP id z18mr2693748ebb.65.1327444384737;
        Tue, 24 Jan 2012 14:33:04 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id c37sm18739220eec.10.2012.01.24.14.33.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 14:33:03 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1
In-Reply-To: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189080>

Capture failure behavior when running into
- EACCES caused by search path permissions
- ENOENT caused by interpreter not found

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---
 t/t0061-run-command.sh |   50 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 95e89bc..31eb3c3 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -13,6 +13,24 @@ cat hello-script
 EOF
 >empty
 
+cat >someinterpreter <<-EOF
+#!$SHELL_PATH
+cat hello-script
+EOF
+>empty
+
+cat >incorrect-interpreter-script <<-EOF
+#!someinterpreter
+cat hello-script
+EOF
+>empty
+
+cat >non-existing-interpreter <<-EOF
+#!nonexisting_interpreter
+cat hello-script
+EOF
+>empty
+
 test_expect_success 'start_command reports ENOENT' '
 	test-run-command start-command-ENOENT ./does-not-exist
 '
@@ -26,7 +44,7 @@ test_expect_success 'run_command can run a command' '
 	test_cmp empty err
 '
 
-test_expect_success POSIXPERM 'run_command reports EACCES' '
+test_expect_success POSIXPERM 'run_command reports EACCES, file permissions' '
 	cat hello-script >hello.sh &&
 	chmod -x hello.sh &&
 	test_must_fail test-run-command run-command ./hello.sh 2>err &&
@@ -34,4 +52,34 @@ test_expect_success POSIXPERM 'run_command reports EACCES' '
 	grep "fatal: cannot exec.*hello.sh" err
 '
 
+test_expect_success POSIXPERM 'run_command reports EACCES, search path perms' '
+	mkdir -p inaccessible &&
+	PATH=$(pwd)/inaccessible:$PATH &&
+	export PATH &&
+
+	cat hello-script >inaccessible/hello.sh &&
+	chmod 400 inaccessible &&
+	test_must_fail test-run-command run-command hello.sh 2>err &&
+	chmod 755 inaccessible &&
+
+	grep "fatal: cannot exec.*hello.sh" err
+'
+
+test_expect_success POSIXPERM 'run_command reports EACCES, interpreter fails' '
+	cat incorrect-interpreter-script >hello.sh &&
+	chmod +x hello.sh &&
+	chmod -x someinterpreter &&
+	test_must_fail test-run-command run-command ./hello.sh 2>err &&
+
+	grep "fatal: cannot exec.*hello.sh" err
+'
+
+test_expect_failure POSIXPERM 'run_command reports ENOENT, interpreter' '
+	cat non-existing-interpreter >hello.sh &&
+	chmod +x hello.sh &&
+	test_must_fail test-run-command start-command-ENOENT ./hello.sh 2>err &&
+
+	grep "error: cannot exec.*hello.sh" err
+'
+
 test_done
-- 
1.7.8.1
