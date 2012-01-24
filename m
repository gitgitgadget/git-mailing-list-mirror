From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 4/5] run-command: Warn if PATH entry cannot be searched
Date: Tue, 24 Jan 2012 23:32:25 +0100
Message-ID: <1327444346-6243-5-git-send-email-fransklaver@gmail.com>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Frans Klaver <fransklaver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 23:33:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpovh-0005Xu-9l
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab2AXWdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:33:10 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51026 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab2AXWdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:33:08 -0500
Received: by eekc14 with SMTP id c14so2354920eek.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 14:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=edz1qKo6LLmolUgiCm0Je6QRXNdsxg5xBy5D1WRxvi0=;
        b=TI+scdI5nUNnTLH0V7mZUEuOp576yHnVDulbKktorRwqZpZjtLCh4cQHT12Sj5r51c
         qL7K2IFuRyOa8OSWqDX5958KhlMO4LXIZ91yYq6BxiYNCr4mHwbqrQ3a2IQLPqzuyqQl
         Ip8+0zwyM1CP6m05dZjjU8rMr28Y0xPr8vuEE=
Received: by 10.14.94.134 with SMTP id n6mr5073428eef.63.1327444387362;
        Tue, 24 Jan 2012 14:33:07 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id c37sm18739220eec.10.2012.01.24.14.33.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 14:33:06 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1
In-Reply-To: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189078>

execvp will return EACCES when PATH entries are encountered that cannot
be searched and the requested command isn't found. Since this error only
arises in that particular case, warning the user is more appropriate
than producing an error.

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---
 run-command.c          |    1 +
 t/t0061-run-command.sh |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index 17a65fe..ab14910 100644
--- a/run-command.c
+++ b/run-command.c
@@ -243,6 +243,7 @@ static void inspect_failure(const char *argv0, int silent_exec_failure)
 				path = next + 1;
 
 			if (!is_searchable(sb.buf)) {
+				warning("cannot search '%s'", sb.buf);
 				strbuf_release(&sb);
 				continue;
 			}
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 14b4ea6..a4585b0 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -62,7 +62,8 @@ test_expect_success POSIXPERM 'run_command reports EACCES, search path perms' '
 	test_must_fail test-run-command run-command hello.sh 2>err &&
 	chmod 755 inaccessible &&
 
-	grep "fatal: cannot exec.*hello.sh" err
+	grep "fatal: cannot exec.*hello.sh" err &&
+	grep "cannot search" err
 '
 
 test_expect_success POSIXPERM 'run_command reports EACCES, interpreter fails' '
-- 
1.7.8.1
