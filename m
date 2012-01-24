From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Tue, 24 Jan 2012 23:32:26 +0100
Message-ID: <1327444346-6243-6-git-send-email-fransklaver@gmail.com>
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
	id 1Rpovh-0005Xu-TV
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab2AXWdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:33:15 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59459 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab2AXWdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:33:09 -0500
Received: by eekc14 with SMTP id c14so2354923eek.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 14:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Zhj9GnsEOKbGDJAoz+VvcDWF2Da88ZNCbESN7CDr2lU=;
        b=FJhks23DmnA/cV/eYhoHeGIJfkRcqHUFfMXeoDVgXvtz32D98FbMd7tLhymo40zSm/
         NoggjG78/Enbi/vCmkk+EmYuD+6B5mO94r0ts0NZClDq5qZstekxh063WqfceGWS82gj
         AN1CakIqptvsb4JnzQQWLmXJWk/9LI6uwTuqc=
Received: by 10.14.35.84 with SMTP id t60mr5033467eea.126.1327444388584;
        Tue, 24 Jan 2012 14:33:08 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id c37sm18739220eec.10.2012.01.24.14.33.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 14:33:08 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1
In-Reply-To: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189079>

If the interpreter wasn't found, execvp returns ENOENT. The existing
error checking did not differentiate between file not found and
interpreter not found. While the former may be an incentive to start
inspecting aliases, the latter is an error because the desired script is
actually found.

This patch explicitly makes the interpreter failure a fatal error.

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---
As far as I'm concerned, this is a bug fix. However, since it really is
a change in git's behavior, we can still consider postponing this patch.

 run-command.c          |    7 +------
 t/t0061-run-command.sh |    4 ++--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index ab14910..9179daf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -201,12 +201,7 @@ static void inspect_file(struct strbuf *fn, int err, const char *argv0)
 		}
 		free(i);
 		strbuf_release(fn);
-		if (err == ENOENT) {
-			error("%s", es);
-			exit(127);
-		} else {
-			die("%s", es);
-		}
+		die("%s", es);
 	}
 
 	strbuf_release(fn);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index a4585b0..f08163f 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -76,12 +76,12 @@ test_expect_success POSIXPERM 'run_command reports EACCES, interpreter fails' '
 	grep "bad interpreter" err
 '
 
-test_expect_failure POSIXPERM 'run_command reports ENOENT, interpreter' '
+test_expect_success POSIXPERM 'run_command reports ENOENT, interpreter' '
 	cat non-existing-interpreter >hello.sh &&
 	chmod +x hello.sh &&
 	test_must_fail test-run-command start-command-ENOENT ./hello.sh 2>err &&
 
-	grep "error: cannot exec.*hello.sh" err &&
+	grep "fatal: cannot exec.*hello.sh" err &&
 	grep "bad interpreter" err
 '
 
-- 
1.7.8.1
