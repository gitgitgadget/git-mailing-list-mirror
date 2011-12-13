From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 2/2] run-command: Add interpreter permissions check
Date: Tue, 13 Dec 2011 16:08:37 +0100
Message-ID: <1323788917-4141-3-git-send-email-fransklaver@gmail.com>
References: <op.v5e8mgbc0aolir@keputer>
 <1323788917-4141-1-git-send-email-fransklaver@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Frans Klaver <fransklaver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 16:11:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaU0Y-0006oC-8c
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 16:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590Ab1LMPLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 10:11:00 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48884 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab1LMPK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 10:10:59 -0500
Received: by eekc4 with SMTP id c4so2164749eek.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 07:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8OWPHEQzhJs6bCR5+TSm4BFfd//3IJf4He7NFdDPcls=;
        b=ORYDGxJCMINKzE1jB/sr269MVM+9R77hgWKqUvRdiJ4/yFRTQNys/UM2/qSzICmh4R
         lVq2XyJVtaZQROjpDpiPxH/ME0xfYVuUB3QB+SDqRqRcxxSSquHtH1ijUPJrl9tMvHzj
         R1xXgZ0axw2idkcMX3/VidjbyJtKWWLMLrVpo=
Received: by 10.14.100.197 with SMTP id z45mr325908eef.54.1323788968457;
        Tue, 13 Dec 2011 07:09:28 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id x12sm90027005eef.9.2011.12.13.07.09.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 07:09:27 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323788917-4141-1-git-send-email-fransklaver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187028>

If a script is started and the interpreter of that script given in the
shebang cannot be started due to permissions, we can get a rather
obscure situation. All permission checks pass for the script itself,
but we still get EACCES from execvp.

Try to find out if the above is the case and warn the user about it.

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---
 run-command.c          |   59 ++++++++++++++++++++++++++++++++++++++++++++---
 t/t0061-run-command.sh |   22 ++++++++++++++++++
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3f136f4..9ddd409 100644
--- a/run-command.c
+++ b/run-command.c
@@ -149,6 +149,55 @@ static int have_read_execute_permissions(const char *path)
 	return 0;
 }
 
+static void check_interpreter(const char *cmd)
+{
+	FILE *f;
+	struct strbuf sb = STRBUF_INIT;
+	/*
+	 * bash reads an 80 character line when determining the interpreter.
+	 * BSD apparently only allows 32 characters, as it is the size of
+	 * your average binary executable header.
+	 */
+	char firstline[80];
+	size_t s, start, end;
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
+	start = strspn(&firstline[2], " \t") + 2;
+	end = strcspn(&firstline[start], " \t\r\n") + start;
+	if (start >= end) {
+		error("could not determine interpreter\n");
+		return;
+	}
+
+	strbuf_add(&sb, &firstline[start], end - start);
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
 	/*
@@ -167,6 +216,8 @@ static void diagnose_execvp_eacces(const char *cmd, const char **argv)
 	if (strchr(cmd, '/')) {
 		if (!have_read_execute_permissions(cmd))
 			error("no read/execute permissions on '%s'\n", cmd);
+		else
+			check_interpreter(cmd);
 		return;
 	}
 
@@ -197,11 +248,11 @@ static void diagnose_execvp_eacces(const char *cmd, const char **argv)
 			if (!have_read_execute_permissions(sb.buf))
 				error("no read/execute permissions on '%s'\n",
 						sb.buf);
+			else if (access(sb.buf, R_OK) == 0)
+				check_interpreter(sb.buf);
 			else
-				warning("file '%s' exists and permissions "
-				"seem OK.\nIf this is a script, see if you "
-				"have sufficient privileges to run the "
-				"interpreter", sb.buf);
+				trace_printf("cannot determine interpreter "
+						"on '%s'\n", sb.buf);
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
