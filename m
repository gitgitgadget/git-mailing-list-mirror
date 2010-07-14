From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH/RFC 1/4] Allow creation of arbitrary git-shell commands
Date: Tue, 13 Jul 2010 23:01:12 -0400
Message-ID: <1279076475-27730-2-git-send-email-gdb@mit.edu>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Greg Brockman <gdb@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 05:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYsJ3-0001Rj-Dx
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 05:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061Ab0GNDGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 23:06:40 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:49665 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751137Ab0GNDGk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 23:06:40 -0400
X-AuditID: 12074423-b7be0ae000000a83-d3-4c3d288b60d8
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id 7A.67.02691.B882D3C4; Tue, 13 Jul 2010 23:01:31 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6E31Vie017004;
	Tue, 13 Jul 2010 23:01:31 -0400
Received: from localhost (EASTCAMPUS-NINE-NINETY-FOUR.MIT.EDU [18.238.6.227])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6E31Uot005097;
	Tue, 13 Jul 2010 23:01:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279076475-27730-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAARUsJJY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150959>

This provides a mechanism for the server to expose custom
functionality to clients.  My particular use case is that I would like
a way of discovering all repositories available for cloning.  A
client that clones via
  git clone user@example.com
can invoke a command by
  ssh user@example.com $command

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 shell.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/shell.c b/shell.c
index e4864e0..3fee0ed 100644
--- a/shell.c
+++ b/shell.c
@@ -3,6 +3,8 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 
+#define COMMAND_DIR "git-shell-commands"
+
 static int do_generic_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];
@@ -33,6 +35,12 @@ static int do_cvs_cmd(const char *me, char *arg)
 	return execv_git_cmd(cvsserver_argv);
 }
 
+static int is_valid_cmd_name(const char *cmd)
+{
+	/* Test command contains no . or / characters */
+	return cmd[strcspn(cmd, "./")] == '\0';
+}
+
 
 static struct commands {
 	const char *name;
@@ -99,5 +107,13 @@ int main(int argc, char **argv)
 		}
 		exit(cmd->exec(cmd->name, arg));
 	}
+
+	/* Shell should be spawned with cwd in the git user's home directory */
+	if (chdir(COMMAND_DIR))
+		die("unrecognized command '%s'", prog);
+
+	if (is_valid_cmd_name(prog))
+		execl(prog, prog, (char *) NULL);
+
 	die("unrecognized command '%s'", prog);
 }
-- 
1.7.0.4
