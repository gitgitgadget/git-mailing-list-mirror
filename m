From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 2/2] run-command: Add interpreter permissions check
Date: Tue,  6 Dec 2011 22:38:23 +0100
Message-ID: <1323207503-26581-3-git-send-email-fransklaver@gmail.com>
References: <op.v5e8mgbc0aolir@keputer>
 <1323207503-26581-1-git-send-email-fransklaver@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Frans Klaver <fransklaver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 22:39:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2jQ-0004RC-1Y
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778Ab1LFVjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:39:11 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54231 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab1LFVjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:39:09 -0500
Received: by mail-ee0-f46.google.com with SMTP id q14so3376202eea.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 13:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SO/A+ssRRQXblIJ+g77vzQVFaOBgKkKYRl/o3go4q+I=;
        b=PDm5mTw/jR2HMNmWymEhmgzWJccWErBQu+gU6VXPhho10QK+wuIN17vIluaY9lL4ua
         HpM6OIo7Mc/fBTYCg1XsBtq65DYD+Pjp0oIMGB6RhQvJGJrH/hwCPsQK4K0KrKk7LR2f
         K37V+8t7Y73bMQYvX8XXv+aY8w2yLrtjdih4k=
Received: by 10.14.9.210 with SMTP id 58mr2997400eet.123.1323207548254;
        Tue, 06 Dec 2011 13:39:08 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id 65sm51275159eeg.8.2011.12.06.13.39.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 13:39:07 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323207503-26581-1-git-send-email-fransklaver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186390>

If a script is started and the interpreter of that script given in the
shebang cannot be started due to permissions, we can get a rather
obscure situation. All permission checks pass for the script itself,
but we still get EACCES from execvp.

Try to find out if the above is the case and warn the user about it.

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---
 run-command.c          |   66 +++++++++++++++++++++++++++++++++++++++++++----
 t/t0061-run-command.sh |   22 ++++++++++++++++
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5e38c5a..b8cf8d4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -194,6 +194,63 @@ static int have_read_execute_permissions(const char *path)
 	return 0;
 }
 
+static void check_interpreter(const char *cmd)
+{
+	FILE *f;
+	struct strbuf sb = STRBUF_INIT;
+	/* bash reads an 80 character line when determining the interpreter.
+	 * BSD apparently only allows 32 characters, as it is the size of
+	 * your average binary executable header.
+	 */
+	char firstline[80];
+	char *interpreter = NULL;
+	size_t s, i;
+
+	f = fopen(cmd, "r");
+	if (!f) {
+		error("cannot open file '%s': %s\n", cmd, strerror(errno));
+		return;
+	}
+
+	s = fread(firstline, 1, sizeof(firstline), f);
+	if (s < 2) {
+		trace_printf("cannot determine file type");
+		fclose(f);
+		return;
+	}
+
+	if (firstline[0] != '#' || firstline[1] != '!') {
+		trace_printf("file '%s' is not a script or"
+				" is a script without '#!'", cmd);
+		fclose(f);
+		return;
+	}
+
+	/* see if the given path has the executable bit set */
+	for (i = 2; i < s; i++) {
+		if (!interpreter && firstline[i] != ' ' && firstline[i] != '\t')
+			interpreter = firstline + i;
+
+		if (interpreter && (firstline[i] == ' ' ||
+				firstline[i] == '\n')) {
+			strbuf_add(&sb, interpreter,
+					(firstline + i) - interpreter);
+			break;
+		}
+	}
+	if (!sb.len) {
+		error("could not determine interpreter");
+		strbuf_release(&sb);
+		return;
+	}
+
+	if (!have_read_execute_permissions(sb.buf))
+		error("bad interpreter: no read/execute permissions on '%s'\n",
+				sb.buf);
+
+	strbuf_release(&sb);
+}
+
 static void diagnose_execvp_eacces(const char *cmd, const char **argv)
 {
 	/* man 2 execve states that EACCES is returned for:
@@ -209,8 +266,8 @@ static void diagnose_execvp_eacces(const char *cmd, const char **argv)
 	char *next;
 
 	if (strchr(cmd, '/')) {
-		if (!have_read_execute_permissions(cmd))
-			error("no read/execute permissions on '%s'\n", cmd);
+		if (have_read_execute_permissions(cmd))
+			check_interpreter(cmd);
 		return;
 	}
 
@@ -233,10 +290,7 @@ static void diagnose_execvp_eacces(const char *cmd, const char **argv)
 				error("no read/execute permissions on '%s'\n",
 						sb.buf);
 			else
-				warn("file '%s' exists and permissions "
-				"seem OK.\nIf this is a script, see if you "
-				"have sufficient privileges to run the "
-				"interpreter", sb.buf);
+				check_interpreter(sb.buf);
 		}
 
 		strbuf_release(&sb);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index b39bd16..39bfaef 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -13,6 +13,18 @@ cat >hello-script <<-EOF
 EOF
 >empty
 
+cat >someinterpreter <<-EOF
+	#!$SHELL_PATH
+	cat hello-script
+EOF
+>empty
+
+cat >incorrect-interpreter-script <<-EOF
+	#!someinterpreter
+	cat hello-script
+EOF
+>empty
+
 test_expect_success 'start_command reports ENOENT' '
 	test-run-command start-command-ENOENT ./does-not-exist
 '
@@ -48,4 +60,14 @@ test_expect_success POSIXPERM 'run_command reports EACCES, search path permision
 	grep "no read/execute permissions on" err
 '
 
+test_expect_success POSIXPERM 'run_command reports EACCES, interpreter fails' '
+	cat incorrect-interpreter-script >hello.sh &&
+	chmod +x hello.sh &&
+	chmod -x someinterpreter &&
+	test_must_fail test-run-command run-command ./hello.sh 2>err &&
+
+	grep "fatal: cannot exec.*hello.sh" err &&
+	grep "bad interpreter" err
+'
+
 test_done
-- 
1.7.8
